import { NextRequest, NextResponse } from "next/server";
import { createClient } from "@supabase/supabase-js";
import { sendEmail } from "@/lib/resend/client";
import { templates } from "@/lib/resend/templates";

/**
 * GET /api/cron/barometer-invites
 *
 * Vercel cron : chaque 1er du mois à 08:00 UTC (10:00 CH été / 09:00 hiver)
 * Envoie une invitation baromètre à chaque agent actif.
 * Idempotent : ne crée pas d'invite s'il en existe déjà une pour ce mois.
 *
 * Sécurité : header Authorization: Bearer $CRON_SECRET
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
  const periodMonth = `${now.getUTCFullYear()}-${String(now.getUTCMonth() + 1).padStart(2, "0")}`;
  const monthLabel = now.toLocaleDateString("fr-CH", {
    month: "long",
    year: "numeric",
    timeZone: "Europe/Zurich",
  });

  // Charger tous les agents actifs (admin + manager + agent)
  const { data: users } = await supabase
    .from("user_roles")
    .select("user_id, first_name, last_name")
    .eq("active", true)
    .in("role", ["admin", "manager", "agent"]);

  if (!users || users.length === 0) {
    return NextResponse.json({ success: true, invited: 0, message: "Aucun user actif" });
  }

  const appUrl = process.env.NEXT_PUBLIC_APP_URL || "https://app.klary.ch";
  const results: any[] = [];

  for (const u of users) {
    // Vérif idempotence — invite déjà envoyée ce mois ?
    const { data: existing } = await supabase
      .from("barometer_invites")
      .select("id")
      .eq("user_id", u.user_id)
      .eq("period_month", periodMonth)
      .maybeSingle();
    if (existing) {
      results.push({ user_id: u.user_id, status: "already_invited" });
      continue;
    }

    // Charger email agent via admin API
    const { data: authRes } = await supabase.auth.admin.getUserById(u.user_id);
    const email = authRes?.user?.email;
    if (!email) {
      results.push({ user_id: u.user_id, status: "no_email" });
      continue;
    }

    // Créer l'invite (token auto-généré par la DB)
    const { data: invite, error: insErr } = await supabase
      .from("barometer_invites")
      .insert({ user_id: u.user_id, period_month: periodMonth })
      .select("token")
      .single();

    if (insErr || !invite) {
      results.push({ user_id: u.user_id, status: "insert_error", err: insErr?.message });
      continue;
    }

    const surveyUrl = `${appUrl}/barometre/${invite.token}`;

    try {
      await sendEmail({
        to: email,
        subject: `Baromètre équipe Klary — ${monthLabel}`,
        userId: u.user_id,
        eventType: "barometer_invite",
        html: templates.barometerInvite({
          firstName: u.first_name || "toi",
          monthLabel,
          surveyUrl,
        }),
      });
      results.push({ user_id: u.user_id, status: "sent", to: email });
    } catch (err: any) {
      console.error(`[barometer/invites] Email failed for ${email}:`, err);
      results.push({ user_id: u.user_id, status: "email_error", err: err?.message });
    }
  }

  const sent = results.filter((r) => r.status === "sent").length;
  return NextResponse.json({
    success: true,
    period_month: periodMonth,
    total_users: users.length,
    sent,
    results,
  });
}
