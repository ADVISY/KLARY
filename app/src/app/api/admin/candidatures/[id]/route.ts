import { NextRequest, NextResponse } from "next/server";
import { createSupabaseServerClient } from "@/lib/supabase/server";
import { z } from "zod";
import { sendEmail, ADMIN_EMAIL } from "@/lib/resend/client";
import { templates } from "@/lib/resend/templates";
import {
  generateInterviewSlots,
  formatSlot,
} from "@/lib/interview/generate-slots";
import { randomUUID } from "crypto";

const updateSchema = z.object({
  status: z.enum([
    "new",
    "reviewed",
    "interview_1",
    "interview_2",
    "test_ok",
    "offered",
    "hired",
    "active",
    "rejected",
    "archived",
  ]),
  internal_notes: z.string().max(10000).optional().or(z.literal("")),
});

/**
 * POST /api/admin/candidatures/[id]
 *
 * Met à jour statut/notes + dispatche l'email approprié à chaque transition :
 *   rejected     → email refus
 *   interview_1  → génère 3 créneaux + email invitation
 *   hired        → email bienvenue + processus complet
 *   active       → email activation accès complets
 */
export async function POST(
  request: NextRequest,
  { params }: { params: { id: string } }
) {
  try {
    const supabase = createSupabaseServerClient();
    const {
      data: { user },
    } = await supabase.auth.getUser();
    if (!user) {
      return NextResponse.json({ error: "Non authentifié" }, { status: 401 });
    }

    // Vérif role admin/manager
    const { data: role } = await supabase
      .from("user_roles")
      .select("role")
      .eq("user_id", user.id)
      .eq("active", true)
      .maybeSingle();
    if (role?.role !== "admin" && role?.role !== "manager") {
      return NextResponse.json({ error: "Accès refusé" }, { status: 403 });
    }

    // Récupérer la candidature AVANT update (pour connaître l'ancien statut)
    const { data: candidateBefore, error: fetchErr } = await supabase
      .from("candidates")
      .select("*")
      .eq("id", params.id)
      .single();

    if (fetchErr || !candidateBefore) {
      return NextResponse.json(
        { error: "Candidature introuvable" },
        { status: 404 }
      );
    }

    let payload: Record<string, any>;
    const contentType = request.headers.get("content-type") || "";
    if (contentType.includes("application/json")) {
      payload = await request.json();
    } else {
      const fd = await request.formData();
      payload = Object.fromEntries(fd.entries());
    }

    const parsed = updateSchema.safeParse({
      status: payload.status,
      internal_notes: payload.internal_notes || "",
    });
    if (!parsed.success) {
      return NextResponse.json(
        { error: "Données invalides", details: parsed.error.flatten() },
        { status: 400 }
      );
    }

    const previousStatus = candidateBefore.status;
    const newStatus = parsed.data.status;
    const statusChanged = previousStatus !== newStatus;

    const { error } = await supabase
      .from("candidates")
      .update({
        status: newStatus,
        internal_notes: parsed.data.internal_notes || null,
      })
      .eq("id", params.id);

    if (error) {
      console.error("Update error:", error);
      return NextResponse.json(
        { error: "Erreur d'enregistrement" },
        { status: 500 }
      );
    }

    // Log dans candidate_events — wrappé pour ne PAS bloquer le flow
    // si la table n'existe pas encore ou si RLS bloque.
    try {
      const { error: eventErr } = await supabase
        .from("candidate_events")
        .insert({
          candidate_id: params.id,
          event_type: "status_or_notes_updated",
          actor_agent_id: user.id,
          details: { from: previousStatus, to: newStatus },
        });
      if (eventErr) {
        console.error("candidate_events insert (non-bloquant):", eventErr);
      }
    } catch (e) {
      console.error("candidate_events insert threw (non-bloquant):", e);
    }

    // ─── Dispatch email selon transition ───
    if (statusChanged) {
      const appUrl =
        process.env.NEXT_PUBLIC_APP_URL || "https://app.klary.ch";
      const dashboardUrl = `${appUrl}/admin/candidatures/${params.id}`;

      try {
        if (newStatus === "rejected") {
          await sendEmail({
            to: candidateBefore.email,
            subject: "Votre candidature — Klary",
            html: templates.candidatureRejection({
              firstName: candidateBefore.first_name,
              positionApplied: candidateBefore.position_applied || undefined,
            }),
          });
        } else if (newStatus === "interview_1") {
          // Générer 3 créneaux et envoyer invitation
          const slots = generateInterviewSlots();
          const token = randomUUID();
          const selectionUrl = `${appUrl}/entretien/${token}`;

          const { error: insertErr } = await supabase
            .from("interview_slots")
            .insert({
              candidate_id: params.id,
              proposed_slots: slots,
              selection_token: token,
              created_by: user.id,
            });

          if (insertErr) {
            // Table manquante ou RLS bloque. On log DÉTAILLÉ et on tente
            // quand même l'email pour que l'admin sache que le candidat a
            // reçu quelque chose, avec un flag pour le debug.
            console.error(
              "[interview_1] INSERT interview_slots ÉCHEC — table interview_slots peut-être absente ou RLS bloquée.",
              {
                code: insertErr.code,
                message: insertErr.message,
                details: insertErr.details,
                hint: insertErr.hint,
              }
            );
            console.error(
              "[interview_1] Fix: passer la migration 20260725170000_interview_slots.sql dans Supabase."
            );
            // On envoie quand même l'email avec les créneaux — sans lien
            // fonctionnel de sélection (le lien renverra 404 tant que la
            // table n'existe pas, mais le candidat voit les 3 dates).
            const sendResult = await sendEmail({
              to: candidateBefore.email,
              subject: "Votre entretien Klary — choisissez votre créneau",
              html: templates.interviewInvitation({
                firstName: candidateBefore.first_name,
                positionApplied:
                  candidateBefore.position_applied || undefined,
                slotLabels: slots.map((s) => formatSlot(s.start)),
                selectionUrl,
              }),
            });
            console.log(
              "[interview_1] Email invitation envoyé (malgré échec DB):",
              sendResult
            );
          } else {
            const sendResult = await sendEmail({
              to: candidateBefore.email,
              subject: "Votre entretien Klary — choisissez votre créneau",
              html: templates.interviewInvitation({
                firstName: candidateBefore.first_name,
                positionApplied:
                  candidateBefore.position_applied || undefined,
                slotLabels: slots.map((s) => formatSlot(s.start)),
                selectionUrl,
              }),
            });
            console.log("[interview_1] Email invitation envoyé:", sendResult);
          }
        } else if (newStatus === "hired") {
          // Créer un token d'onboarding + insertion en base
          const onboardingToken = randomUUID();
          const { error: onbErr } = await supabase
            .from("onboarding_forms")
            .insert({
              candidate_id: params.id,
              form_token: onboardingToken,
              created_by: user.id,
            });

          const onboardingUrl = onbErr
            ? undefined
            : `${appUrl}/onboarding/${onboardingToken}`;

          if (onbErr) {
            console.error(
              "[hired] onboarding_forms insert échec (envoi email quand même sans lien onboarding):",
              onbErr
            );
          }

          await sendEmail({
            to: candidateBefore.email,
            subject: "Bienvenue chez Klary — votre parcours démarre",
            html: templates.candidatureHired({
              firstName: candidateBefore.first_name,
              positionApplied: candidateBefore.position_applied || undefined,
              portalUrl: `${appUrl}/formation`,
              onboardingUrl,
            }),
          });
        } else if (newStatus === "active") {
          await sendEmail({
            to: candidateBefore.email,
            subject: "Vous êtes activé·e — bienvenue en production",
            html: templates.candidatureActivated({
              firstName: candidateBefore.first_name,
              portalUrl: `${appUrl}/formation`,
              managerName: "Sacha Bacconnier",
              klaryEmail: `${candidateBefore.first_name.toLowerCase()}.${candidateBefore.last_name.toLowerCase()}@klary.ch`,
            }),
          });
        }
      } catch (mailErr) {
        // On ne bloque pas le flow admin si l'email échoue — on log seulement
        console.error("Email transition candidature échoué:", mailErr);
      }
    }

    // Rediriger vers la page détail
    return NextResponse.redirect(
      new URL(`/admin/candidatures/${params.id}`, request.url),
      { status: 303 }
    );
  } catch (error) {
    console.error("admin/candidatures POST:", error);
    return NextResponse.json({ error: "Erreur serveur" }, { status: 500 });
  }
}
