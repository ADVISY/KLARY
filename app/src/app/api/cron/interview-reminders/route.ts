import { NextRequest, NextResponse } from "next/server";
import { createClient } from "@supabase/supabase-js";
import { sendEmail, ADMIN_EMAIL } from "@/lib/resend/client";
import { templates } from "@/lib/resend/templates";
import { formatSlot } from "@/lib/interview/generate-slots";

/**
 * GET /api/cron/interview-reminders
 *
 * Déclenché par Vercel Cron (vercel.json → schedule "0 7 * * *" — 07:00 UTC = 09:00 Suisse).
 *
 * Trouve tous les entretiens confirmés dont le créneau démarre entre 20h et 30h
 * dans le futur, et qui n'ont pas encore reçu de rappel J-1.
 * Envoie :
 *   - email individuel à chaque candidat concerné
 *   - email récap à admin@klary.ch avec la liste
 *
 * Sécurité : vérifie header Authorization: Bearer $CRON_SECRET
 * (Vercel Cron l'envoie automatiquement quand CRON_SECRET est défini).
 */
export async function GET(req: NextRequest) {
  // Auth via CRON_SECRET (protection accès public)
  const authHeader = req.headers.get("authorization");
  const cronSecret = process.env.CRON_SECRET;
  if (cronSecret && authHeader !== `Bearer ${cronSecret}`) {
    return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
  }

  const supabase = createClient(
    process.env.NEXT_PUBLIC_SUPABASE_URL!,
    process.env.SUPABASE_SERVICE_ROLE_KEY!,
    { auth: { persistSession: false, autoRefreshToken: false } }
  );

  const now = new Date();
  const windowStart = new Date(now.getTime() + 20 * 3600 * 1000); // +20h
  const windowEnd = new Date(now.getTime() + 30 * 3600 * 1000); // +30h

  // Charger les entretiens confirmés sans rappel envoyé
  const { data: interviews, error } = await supabase
    .from("interview_slots")
    .select("id, candidate_id, proposed_slots, selected_slot_index")
    .not("selected_at", "is", null)
    .is("reminder_sent_at", null);

  if (error) {
    console.error("[cron/interview-reminders] DB error:", error);
    return NextResponse.json(
      { error: "DB error", details: error.message },
      { status: 500 }
    );
  }

  // Filtrer côté JS ceux dont le slot start est dans [windowStart, windowEnd]
  const pending: {
    id: string;
    candidateId: string;
    slotStart: string;
  }[] = [];
  for (const iv of interviews || []) {
    if (iv.selected_slot_index == null) continue;
    const slot = (iv.proposed_slots as any[])[iv.selected_slot_index as number];
    if (!slot?.start) continue;
    const slotDate = new Date(slot.start);
    if (slotDate >= windowStart && slotDate <= windowEnd) {
      pending.push({
        id: iv.id,
        candidateId: iv.candidate_id,
        slotStart: slot.start,
      });
    }
  }

  if (pending.length === 0) {
    return NextResponse.json({
      success: true,
      window: { start: windowStart, end: windowEnd },
      pending: 0,
      message: "Aucun rappel à envoyer",
    });
  }

  // Charger les candidats
  const candIds = pending.map((p) => p.candidateId);
  const { data: candidates } = await supabase
    .from("candidates")
    .select("id, first_name, last_name, email, position_applied")
    .in("id", candIds);
  const candMap = new Map((candidates || []).map((c: any) => [c.id, c]));

  const appUrl = process.env.NEXT_PUBLIC_APP_URL || "https://app.klary.ch";

  // Envoyer email à chaque candidat + accumuler pour récap admin
  const adminSummary: {
    firstName: string;
    lastName: string;
    email: string;
    slotLabel: string;
    dashboardUrl: string;
  }[] = [];

  const results: any[] = [];

  for (const p of pending) {
    const c = candMap.get(p.candidateId);
    if (!c) {
      results.push({ id: p.id, status: "skipped", reason: "candidate_not_found" });
      continue;
    }

    const slotLabel = formatSlot(p.slotStart);
    const dashboardUrl = `${appUrl}/admin/candidatures/${p.candidateId}`;

    try {
      await sendEmail({
        to: c.email,
        subject: "Rappel : votre entretien Klary demain",
        candidateId: p.candidateId,
        eventType: "entretien_rappel_candidat",
        html: templates.interviewReminderCandidate({
          firstName: c.first_name,
          slotLabel,
        }),
      });

      adminSummary.push({
        firstName: c.first_name,
        lastName: c.last_name,
        email: c.email,
        slotLabel,
        dashboardUrl,
      });

      // Marquer comme envoyé
      await supabase
        .from("interview_slots")
        .update({ reminder_sent_at: new Date().toISOString() })
        .eq("id", p.id);

      results.push({ id: p.id, status: "sent", to: c.email });
    } catch (err: any) {
      console.error(`[cron/interview-reminders] Email failed for ${c.email}:`, err);
      results.push({ id: p.id, status: "error", details: err?.message });
    }
  }

  // Récap admin (une seule fois s'il y a au moins 1 envoi réussi)
  if (adminSummary.length > 0) {
    try {
      await sendEmail({
        to: ADMIN_EMAIL,
        subject: `📅 Rappel : ${adminSummary.length} entretien${adminSummary.length > 1 ? "s" : ""} demain`,
        eventType: "entretien_rappel_admin",
        html: templates.interviewReminderAdmin({ interviews: adminSummary }),
      });
    } catch (err: any) {
      console.error("[cron/interview-reminders] Admin summary email failed:", err);
    }
  }

  return NextResponse.json({
    success: true,
    window: { start: windowStart, end: windowEnd },
    pending: pending.length,
    sent: adminSummary.length,
    results,
  });
}
