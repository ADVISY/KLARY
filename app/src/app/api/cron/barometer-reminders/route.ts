import { NextRequest, NextResponse } from "next/server";
import { createClient } from "@supabase/supabase-js";
import { sendEmail } from "@/lib/resend/client";
import { templates } from "@/lib/resend/templates";

/**
 * GET /api/cron/barometer-reminders
 *
 * Vercel cron : chaque jour 08:00 UTC
 * Envoie 1 rappel unique aux invités qui n'ont pas répondu 3 jours après leur invitation.
 * Un seul rappel par invite (jamais de harcèlement).
 */
export async function GET(req: NextRequest) {
  const auth = req.headers.get("authorization");
  if (process.env.CRON_SECRET && auth !== `Bearer ${process.env.CRON_SECRET}`) {
    return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
  }

  const supabase = createClient(
    process.env.NEXT_PUBLIC_SUPABASE_URL!,
    process.env.SUPABASE_SERVICE_ROLE_KEY!,
    { auth: { persistSession: false, autoRefreshToken: false } }
  );

  const now = new Date();
  const threeDaysAgo = new Date(now.getTime() - 3 * 24 * 3600 * 1000);

  // Invites : non répondues + pas de rappel envoyé + créées il y a >3 jours + non expirées
  const { data: pending, error } = await supabase
    .from("barometer_invites")
    .select("id, user_id, token, period_month, invited_at")
    .is("responded_at", null)
    .is("reminder_sent_at", null)
    .lt("invited_at", threeDaysAgo.toISOString())
    .gt("expires_at", now.toISOString());

  if (error) {
    return NextResponse.json({ error: error.message }, { status: 500 });
  }
  if (!pending || pending.length === 0) {
    return NextResponse.json({ success: true, sent: 0, message: "Aucun rappel à envoyer" });
  }

  const appUrl = process.env.NEXT_PUBLIC_APP_URL || "https://app.klary.ch";
  const results: any[] = [];

  for (const inv of pending) {
    const { data: profile } = await supabase
      .from("user_roles")
      .select("first_name")
      .eq("user_id", inv.user_id)
      .maybeSingle();

    const { data: authRes } = await supabase.auth.admin.getUserById(inv.user_id);
    const email = authRes?.user?.email;
    if (!email) {
      results.push({ id: inv.id, status: "no_email" });
      continue;
    }

    // monthLabel depuis period_month
    const [year, month] = inv.period_month.split("-");
    const monthLabel = new Date(Number(year), Number(month) - 1, 1).toLocaleDateString(
      "fr-CH",
      { month: "long", year: "numeric" }
    );

    try {
      await sendEmail({
        to: email,
        subject: `Rappel — Baromètre équipe ${monthLabel}`,
        userId: inv.user_id,
        eventType: "barometer_reminder",
        html: templates.barometerReminder({
          firstName: profile?.first_name || "toi",
          monthLabel,
          surveyUrl: `${appUrl}/barometre/${inv.token}`,
        }),
      });

      await supabase
        .from("barometer_invites")
        .update({ reminder_sent_at: new Date().toISOString() })
        .eq("id", inv.id);

      results.push({ id: inv.id, status: "sent" });
    } catch (err: any) {
      results.push({ id: inv.id, status: "error", err: err?.message });
    }
  }

  const sent = results.filter((r) => r.status === "sent").length;
  return NextResponse.json({ success: true, sent, results });
}
