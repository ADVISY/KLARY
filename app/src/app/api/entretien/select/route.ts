import { NextRequest, NextResponse } from "next/server";
import { createServerClient } from "@supabase/ssr";
import { cookies } from "next/headers";
import { z } from "zod";
import { sendEmail, ADMIN_EMAIL } from "@/lib/resend/client";
import { templates } from "@/lib/resend/templates";
import { formatSlot } from "@/lib/interview/generate-slots";

const schema = z.object({
  token: z.string().uuid(),
  slot_index: z.union([z.literal(0), z.literal(1), z.literal(2)]),
});

/**
 * POST /api/entretien/select
 * Body: { token, slot_index }
 *
 * Public — protégé par token secret (UUID). Aucune auth requise.
 * Utilise le service_role pour bypasser RLS (le candidat n'est pas connecté).
 */
export async function POST(request: NextRequest) {
  try {
    const body = await request.json();
    const parsed = schema.safeParse({
      token: body.token,
      slot_index: Number(body.slot_index),
    });
    if (!parsed.success) {
      return NextResponse.json(
        { error: "Requête invalide" },
        { status: 400 }
      );
    }

    // Client service_role (bypass RLS)
    const cookieStore = cookies();
    const supabase = createServerClient(
      process.env.NEXT_PUBLIC_SUPABASE_URL!,
      process.env.SUPABASE_SERVICE_ROLE_KEY!,
      {
        cookies: {
          getAll: () => cookieStore.getAll(),
          setAll: () => {},
        },
      }
    );

    // Récupérer la ligne interview_slots par token
    const { data: interview, error: fetchErr } = await supabase
      .from("interview_slots")
      .select(
        "id, candidate_id, proposed_slots, selected_slot_index, selected_at"
      )
      .eq("selection_token", parsed.data.token)
      .maybeSingle();

    if (fetchErr || !interview) {
      return NextResponse.json(
        { error: "Lien invalide ou expiré." },
        { status: 404 }
      );
    }

    // Empêcher re-sélection après confirmation
    if (interview.selected_at) {
      return NextResponse.json(
        {
          error: "Créneau déjà confirmé.",
          alreadySelected: true,
          selectedSlot: (interview.proposed_slots as any[])[
            interview.selected_slot_index as number
          ],
        },
        { status: 409 }
      );
    }

    const slots = interview.proposed_slots as any[];
    const chosenSlot = slots[parsed.data.slot_index];
    if (!chosenSlot?.start) {
      return NextResponse.json(
        { error: "Créneau invalide" },
        { status: 400 }
      );
    }

    // Enregistrer sélection
    const { error: updateErr } = await supabase
      .from("interview_slots")
      .update({
        selected_slot_index: parsed.data.slot_index,
        selected_at: new Date().toISOString(),
      })
      .eq("id", interview.id);

    if (updateErr) {
      console.error("interview_slots update:", updateErr);
      return NextResponse.json(
        { error: "Erreur d'enregistrement" },
        { status: 500 }
      );
    }

    // Charger candidat pour email
    const { data: candidate } = await supabase
      .from("candidates")
      .select("first_name, last_name, email, position_applied")
      .eq("id", interview.candidate_id)
      .maybeSingle();

    if (candidate) {
      const slotLabel = formatSlot(chosenSlot.start);
      const appUrl =
        process.env.NEXT_PUBLIC_APP_URL || "https://app.klary.ch";
      const dashboardUrl = `${appUrl}/admin/candidatures/${interview.candidate_id}`;

      // Confirmation candidat
      sendEmail({
        to: candidate.email,
        subject: "Votre entretien Klary est confirmé",
        html: templates.interviewConfirmation({
          firstName: candidate.first_name,
          slotLabel,
        }),
      }).catch((err) =>
        console.error("Failed interview confirmation:", err)
      );

      // Notif admin
      sendEmail({
        to: ADMIN_EMAIL,
        subject: `[Entretien] Créneau confirmé — ${candidate.first_name} ${candidate.last_name}`,
        html: templates.interviewNotifAdmin({
          firstName: candidate.first_name,
          lastName: candidate.last_name,
          email: candidate.email,
          positionApplied: candidate.position_applied || undefined,
          slotLabel,
          dashboardUrl,
        }),
      }).catch((err) => console.error("Failed interview notif admin:", err));
    }

    return NextResponse.json({
      success: true,
      selectedSlot: chosenSlot,
    });
  } catch (error) {
    console.error("entretien/select POST:", error);
    return NextResponse.json(
      { error: "Erreur serveur" },
      { status: 500 }
    );
  }
}
