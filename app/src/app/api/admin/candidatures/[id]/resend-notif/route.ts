import { NextRequest, NextResponse } from "next/server";
import { createSupabaseServerClient } from "@/lib/supabase/server";
import { sendEmail, ADMIN_EMAIL } from "@/lib/resend/client";
import { templates } from "@/lib/resend/templates";

/**
 * POST /api/admin/candidatures/[id]/resend-notif
 *
 * Renvoie manuellement la notification admin (nouvelle candidature)
 * et la confirmation candidat pour une candidature.
 * Utile quand l'envoi automatique a échoué (ex: clé Resend expirée).
 *
 * Body optionnel : { target?: "admin" | "candidate" | "both" } (défaut: "both")
 */
export async function POST(
  request: NextRequest,
  { params }: { params: { id: string } }
) {
  try {
    const supabase = createSupabaseServerClient();

    // ─── Authentification + role admin/manager ───
    const {
      data: { user },
    } = await supabase.auth.getUser();
    if (!user) {
      return NextResponse.json({ error: "Non authentifié" }, { status: 401 });
    }

    const { data: role } = await supabase
      .from("user_roles")
      .select("role")
      .eq("user_id", user.id)
      .eq("active", true)
      .maybeSingle();

    if (role?.role !== "admin" && role?.role !== "manager") {
      return NextResponse.json(
        { error: "Accès réservé aux admins/managers" },
        { status: 403 }
      );
    }

    // ─── Récupération de la candidature ───
    const { data: candidate, error: candErr } = await supabase
      .from("candidates")
      .select(
        "id, first_name, last_name, email, phone, position_applied, status"
      )
      .eq("id", params.id)
      .maybeSingle();

    if (candErr || !candidate) {
      return NextResponse.json(
        { error: "Candidature introuvable" },
        { status: 404 }
      );
    }

    // ─── Parse target (défaut: both) ───
    let target: "admin" | "candidate" | "both" = "both";
    try {
      const body = await request.json();
      if (
        body?.target === "admin" ||
        body?.target === "candidate" ||
        body?.target === "both"
      ) {
        target = body.target;
      }
    } catch {
      // Body vide ou invalide → default "both"
    }

    const appUrl = process.env.NEXT_PUBLIC_APP_URL || "https://app.klary.ch";
    const dashboardUrl = `${appUrl}/admin/candidatures/${candidate.id}`;

    const results: {
      admin?: { ok: boolean; error?: string; id?: string };
      candidate?: { ok: boolean; error?: string; id?: string };
    } = {};

    // ─── Notification admin ───
    if (target === "admin" || target === "both") {
      const res = await sendEmail({
        to: ADMIN_EMAIL,
        subject: `[Candidature — RENVOI] ${candidate.position_applied} — ${candidate.first_name} ${candidate.last_name}`,
        replyTo: candidate.email,
        candidateId: candidate.id,
        eventType: "candidature_admin_notif",
        html: templates.candidatureAdminNotif({
          firstName: candidate.first_name,
          lastName: candidate.last_name,
          email: candidate.email,
          phone: candidate.phone || undefined,
          positionApplied: candidate.position_applied,
          dashboardUrl,
        }),
      });
      results.admin = res as any;
    }

    // ─── Confirmation candidat ───
    if (target === "candidate" || target === "both") {
      const res = await sendEmail({
        to: candidate.email,
        subject: "Votre candidature a bien été reçue — Klary",
        candidateId: candidate.id,
        eventType: "candidature_confirmation",
        html: templates.candidatureConfirmation({
          firstName: candidate.first_name,
          positionApplied: candidate.position_applied,
        }),
      });
      results.candidate = res as any;
    }

    return NextResponse.json({ success: true, results });
  } catch (error: any) {
    console.error("resend-notif POST error:", error);
    return NextResponse.json(
      { error: error?.message || "Erreur serveur" },
      { status: 500 }
    );
  }
}
