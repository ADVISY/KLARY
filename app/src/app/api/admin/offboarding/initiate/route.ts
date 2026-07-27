import { NextRequest, NextResponse } from "next/server";
import { createClient } from "@supabase/supabase-js";
import { z } from "zod";
import { createSupabaseServerClient } from "@/lib/supabase/server";
import {
  sendEmail,
  ADMIN_EMAIL,
  OFFICE_EMAILS,
  LAWYER_EMAILS,
} from "@/lib/resend/client";
import { templates } from "@/lib/resend/templates";

const schema = z.object({
  user_id: z.string().uuid(),
  reason: z.enum([
    "demission",
    "mutuel_accord",
    "rupture_essai",
    "fin_cdd",
    "retraite",
    "licenciement",
    "faute_grave",
    "abandon_poste",
  ]),
  last_working_day: z.string().regex(/^\d{4}-\d{2}-\d{2}$/, "Date invalide"),
  admin_notes: z.string().max(2000).optional().or(z.literal("")),
});

export async function POST(request: NextRequest) {
  try {
    const supabase = createSupabaseServerClient();
    const {
      data: { user },
    } = await supabase.auth.getUser();
    if (!user) {
      return NextResponse.json({ error: "Non authentifié" }, { status: 401 });
    }

    // Admin only (pas manager)
    const { data: viewerRole } = await supabase
      .from("user_roles")
      .select("role, first_name, last_name")
      .eq("user_id", user.id)
      .eq("active", true)
      .maybeSingle();
    if (viewerRole?.role !== "admin") {
      return NextResponse.json(
        { error: "Accès refusé (admin uniquement)" },
        { status: 403 }
      );
    }

    const body = await request.json();
    const parsed = schema.safeParse(body);
    if (!parsed.success) {
      return NextResponse.json(
        { error: "Données invalides", details: parsed.error.flatten() },
        { status: 400 }
      );
    }

    // SAFEGUARD : un admin ne peut pas s'offboarder lui-même
    // (sinon il révoque son propre accès à admin.klary.ch et se coupe la branche)
    if (parsed.data.user_id === user.id) {
      return NextResponse.json(
        {
          error:
            "Impossible d'initier un offboarding sur ton propre compte admin. Demande à un autre admin/manager de le faire, ou teste sur un compte agent de test.",
        },
        { status: 400 }
      );
    }

    // Bloquer si l'agent a déjà un offboarding en cours (non finalisé)
    const { data: existing } = await supabase
      .from("offboarding_processes")
      .select("id")
      .eq("user_id", parsed.data.user_id)
      .is("completed_at", null)
      .maybeSingle();
    if (existing) {
      return NextResponse.json(
        {
          error:
            "Un offboarding est déjà en cours pour cet agent. Voir /admin/offboarding/" +
            existing.id,
        },
        { status: 409 }
      );
    }

    // Récupérer profil agent (snapshot identité)
    const { data: agentRole } = await supabase
      .from("user_roles")
      .select("first_name, last_name")
      .eq("user_id", parsed.data.user_id)
      .maybeSingle();

    // Client service_role pur pour lecture email agent + inserts DB
    const service = createClient(
      process.env.NEXT_PUBLIC_SUPABASE_URL!,
      process.env.SUPABASE_SERVICE_ROLE_KEY!,
      { auth: { persistSession: false, autoRefreshToken: false } }
    );
    const { data: authUser } = await service.auth.admin.getUserById(
      parsed.data.user_id
    );
    const agentEmail = authUser?.user?.email;
    if (!agentEmail) {
      return NextResponse.json(
        { error: "Email de l'agent introuvable" },
        { status: 400 }
      );
    }

    // ─── INSERT offboarding_processes ───
    const { data: inserted, error: insErr } = await service
      .from("offboarding_processes")
      .insert({
        user_id: parsed.data.user_id,
        first_name: agentRole?.first_name || null,
        last_name: agentRole?.last_name || null,
        agent_email: agentEmail,
        reason: parsed.data.reason,
        last_working_day: parsed.data.last_working_day,
        initiated_by: user.id,
        admin_notes: parsed.data.admin_notes || null,
      })
      .select()
      .single();

    if (insErr || !inserted) {
      console.error("[offboarding/initiate] insert err:", insErr);
      return NextResponse.json(
        { error: "Erreur DB", details: insErr?.message },
        { status: 500 }
      );
    }

    // ─── SÉCURITÉ IMMÉDIATE : user_roles.active = false ───
    const { error: deactivateErr } = await service
      .from("user_roles")
      .update({ active: false })
      .eq("user_id", parsed.data.user_id);
    if (deactivateErr) {
      console.error(
        "[offboarding/initiate] deactivate user_roles err:",
        deactivateErr
      );
      // On continue quand même, mais on log fort
    }

    const appUrl =
      process.env.NEXT_PUBLIC_APP_URL || "https://app.klary.ch";
    const dashboardUrl = `${appUrl}/admin/offboarding/${inserted.id}`;
    const agentName = [agentRole?.first_name, agentRole?.last_name]
      .filter(Boolean)
      .join(" ");
    const lastDayFormatted = new Date(
      parsed.data.last_working_day
    ).toLocaleDateString("fr-CH", {
      day: "numeric",
      month: "long",
      year: "numeric",
    });
    const initiatorName = [
      viewerRole?.first_name,
      viewerRole?.last_name,
    ]
      .filter(Boolean)
      .join(" ") || user.email || "";

    // ─── ENVOI DES 3 EMAILS EN PARALLÈLE (await pour garantir en serverless) ───
    const supervisionTo = Array.from(
      new Set([ADMIN_EMAIL, ...LAWYER_EMAILS])
    );

    const emailResults = await Promise.allSettled([
      // Office : révocation accès URGENTE
      sendEmail({
        to: OFFICE_EMAILS,
        subject: `🚨 URGENT — Révoquer accès de ${agentName}`,
        userId: parsed.data.user_id,
        eventType: "offboarding_office_urgent",
        html: templates.offboardingOfficeUrgent({
          firstName: agentRole?.first_name || "",
          lastName: agentRole?.last_name || "",
          reason: parsed.data.reason,
          lastWorkingDay: lastDayFormatted,
          dashboardUrl,
        }),
      }),
      // Agent : notification (sans PJ convention — remise en main propre)
      sendEmail({
        to: agentEmail,
        subject: "Fin de collaboration Klary — procédure de sortie",
        userId: parsed.data.user_id,
        eventType: "offboarding_agent_notice",
        html: templates.offboardingAgentNotice({
          firstName: agentRole?.first_name || "",
          lastName: agentRole?.last_name || "",
          reason: parsed.data.reason,
          lastWorkingDay: lastDayFormatted,
        }),
      }),
      // Supervision admin + avocat
      sendEmail({
        to: supervisionTo,
        subject: `[Offboarding] ${agentName} — ${parsed.data.reason}`,
        userId: parsed.data.user_id,
        eventType: "offboarding_admin_supervision",
        html: templates.offboardingAdminSupervision({
          firstName: agentRole?.first_name || "",
          lastName: agentRole?.last_name || "",
          reason: parsed.data.reason,
          lastWorkingDay: lastDayFormatted,
          initiatedByName: initiatorName,
          adminNotes: parsed.data.admin_notes || undefined,
          dashboardUrl,
        }),
      }),
    ]);

    // Log les échecs (mais on retourne succès — offboarding est enregistré,
    // les emails peuvent être re-tentés manuellement)
    const labels = ["office_urgent", "agent_notice", "admin_supervision"];
    emailResults.forEach((r, i) => {
      if (r.status === "rejected") {
        console.error(`[offboarding/initiate] email ${labels[i]} FAILED:`, r.reason);
      }
    });

    return NextResponse.json({
      success: true,
      id: inserted.id,
      redirectUrl: `/admin/offboarding/${inserted.id}`,
      emails: emailResults.map((r, i) => ({
        target: labels[i],
        status: r.status,
      })),
    });
  } catch (err: any) {
    console.error("[offboarding/initiate] fatal:", err);
    return NextResponse.json(
      { error: "Erreur serveur", details: err?.message },
      { status: 500 }
    );
  }
}
