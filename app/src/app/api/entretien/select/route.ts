import { NextRequest, NextResponse } from "next/server";
import { createClient } from "@supabase/supabase-js";
import { z } from "zod";
import { sendEmail, ADMIN_EMAIL } from "@/lib/resend/client";
import { templates } from "@/lib/resend/templates";
import { formatSlot } from "@/lib/interview/generate-slots";
import { generateInterviewIcs } from "@/lib/interview/ics";
import {
  createCalendarEvent,
  getStoredGoogleTokens,
} from "@/lib/google/calendar";

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

    // Client service_role pur (bypass RLS — le candidat n'est pas connecté)
    const supabase = createClient(
      process.env.NEXT_PUBLIC_SUPABASE_URL!,
      process.env.SUPABASE_SERVICE_ROLE_KEY!,
      { auth: { persistSession: false, autoRefreshToken: false } }
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

      // Générer le fichier .ics — invitation calendrier avec adresse bureau
      const icsContent = generateInterviewIcs({
        uid: interview.id,
        startISO: chosenSlot.start,
        durationMin: chosenSlot.duration_min || 30,
        candidateName: `${candidate.first_name} ${candidate.last_name}`,
        candidateEmail: candidate.email,
        organizerEmail: ADMIN_EMAIL,
        organizerName: "Klary Sàrl",
      });
      const icsAttachment = {
        filename: "entretien-klary.ics",
        content: Buffer.from(icsContent, "utf-8"),
      };

      // Confirmation candidat (avec .ics)
      sendEmail({
        to: candidate.email,
        subject: "Votre entretien Klary est confirmé",
        candidateId: interview.candidate_id,
        eventType: "entretien_confirmation_candidat",
        html: templates.interviewConfirmation({
          firstName: candidate.first_name,
          slotLabel,
        }),
        attachments: [icsAttachment],
      }).catch((err) =>
        console.error("Failed interview confirmation:", err)
      );

      // Notif admin (avec .ics)
      sendEmail({
        to: ADMIN_EMAIL,
        subject: `[Entretien] Créneau confirmé — ${candidate.first_name} ${candidate.last_name}`,
        candidateId: interview.candidate_id,
        eventType: "entretien_notif_admin",
        html: templates.interviewNotifAdmin({
          firstName: candidate.first_name,
          lastName: candidate.last_name,
          email: candidate.email,
          positionApplied: candidate.position_applied || undefined,
          slotLabel,
          dashboardUrl,
        }),
        attachments: [icsAttachment],
      }).catch((err) => console.error("Failed interview notif admin:", err));

      // Créer l'event Google Calendar si connecté (AWAIT — en serverless
      // les promesses non-awaited sont perdues quand la fonction se termine)
      const googleConnected = await getStoredGoogleTokens();
      if (googleConnected) {
        try {
          const event = await createCalendarEvent({
            summary: `Entretien Klary — ${candidate.first_name} ${candidate.last_name}`,
            description: [
              `Candidature : ${candidate.position_applied || "—"}`,
              `Email candidat : ${candidate.email}`,
              ``,
              `Fiche candidat : ${dashboardUrl}`,
            ].join("\n"),
            location:
              "Klary Sàrl — Bâtiment Regus, Route de Crassier 7, 1262 Eysins",
            startISO: chosenSlot.start,
            durationMin: chosenSlot.duration_min || 30,
            attendees: [
              {
                email: candidate.email,
                displayName: `${candidate.first_name} ${candidate.last_name}`,
              },
            ],
            sendUpdates: "all",
          });

          await supabase
            .from("interview_slots")
            .update({ google_event_id: event.id })
            .eq("id", interview.id);
          console.log(`[google] Event created: ${event.htmlLink}`);
        } catch (err: any) {
          // Non-bloquant : log et continue, la sélection candidat reste OK
          console.error("[google] Failed to create calendar event:", err?.message || err);
        }
      }
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
