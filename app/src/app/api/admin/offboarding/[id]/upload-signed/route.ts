import { NextRequest, NextResponse } from "next/server";
import { createServerClient } from "@supabase/ssr";
import { cookies } from "next/headers";
import { createSupabaseServerClient } from "@/lib/supabase/server";
import {
  sendEmail,
  COMPTABLE_EMAILS,
} from "@/lib/resend/client";
import { templates } from "@/lib/resend/templates";

const MAX_SIZE = 10 * 1024 * 1024; // 10 Mo
const ACCEPT = [
  "application/pdf",
  "image/jpeg",
  "image/jpg",
  "image/png",
];

/**
 * POST /api/admin/offboarding/[id]/upload-signed
 * Multipart form-data admin only : file (PDF ou JPG/PNG du scan signé)
 * → sauvegarde le fichier dans bucket "offboarding-docs"
 * → met à jour convention_signed_uploaded_at + storage_path
 * → déclenche l'email checklist finance
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

    const { data: role } = await supabase
      .from("user_roles")
      .select("role")
      .eq("user_id", user.id)
      .eq("active", true)
      .maybeSingle();
    if (role?.role !== "admin") {
      return NextResponse.json(
        { error: "Accès refusé (admin uniquement)" },
        { status: 403 }
      );
    }

    const fd = await request.formData();
    const file = fd.get("file") as File | null;
    if (!file || file.size === 0) {
      return NextResponse.json({ error: "Fichier manquant" }, { status: 400 });
    }
    if (file.size > MAX_SIZE) {
      return NextResponse.json(
        { error: "Fichier trop lourd (max 10 Mo)" },
        { status: 400 }
      );
    }
    if (!ACCEPT.includes(file.type)) {
      return NextResponse.json(
        { error: "Type de fichier non accepté (PDF/JPG/PNG)" },
        { status: 400 }
      );
    }

    const cookieStore = cookies();
    const service = createServerClient(
      process.env.NEXT_PUBLIC_SUPABASE_URL!,
      process.env.SUPABASE_SERVICE_ROLE_KEY!,
      {
        cookies: {
          getAll: () => cookieStore.getAll(),
          setAll: () => {},
        },
      }
    );

    // Récupérer le dossier
    const { data: offb } = await service
      .from("offboarding_processes")
      .select("*")
      .eq("id", params.id)
      .maybeSingle();
    if (!offb) {
      return NextResponse.json(
        { error: "Dossier offboarding introuvable" },
        { status: 404 }
      );
    }

    // Upload storage
    const ext = file.name.split(".").pop() || "pdf";
    const path = `${new Date().getFullYear()}/${offb.id}_convention_signee.${ext}`;
    const buf = await file.arrayBuffer();
    const { error: upErr } = await service.storage
      .from("offboarding-docs")
      .upload(path, buf, {
        contentType: file.type,
        upsert: true, // permet re-upload si scan à corriger
      });
    if (upErr) {
      console.error("[offboarding/upload-signed] storage err:", upErr);
      return NextResponse.json(
        {
          error: "Erreur upload storage",
          details: upErr.message,
        },
        { status: 500 }
      );
    }

    // Update DB
    const { error: updateErr } = await service
      .from("offboarding_processes")
      .update({
        convention_signed_storage_path: path,
        convention_signed_uploaded_at: new Date().toISOString(),
      })
      .eq("id", params.id);
    if (updateErr) {
      console.error("[offboarding/upload-signed] update err:", updateErr);
      return NextResponse.json(
        { error: "Erreur DB", details: updateErr.message },
        { status: 500 }
      );
    }

    // ─── EMAIL finance@ pour préparation documents administratifs ───
    const appUrl =
      process.env.NEXT_PUBLIC_APP_URL || "https://app.klary.ch";
    const dashboardUrl = `${appUrl}/admin/offboarding/${offb.id}`;
    const lastDayFormatted = offb.last_working_day
      ? new Date(offb.last_working_day).toLocaleDateString("fr-CH", {
          day: "numeric",
          month: "long",
          year: "numeric",
        })
      : "";

    sendEmail({
      to: COMPTABLE_EMAILS,
      subject: `[Offboarding] Convention signée — ${offb.first_name} ${offb.last_name}`,
      userId: offb.user_id,
      eventType: "offboarding_finance_checklist",
      html: templates.offboardingFinanceChecklist({
        firstName: offb.first_name || "",
        lastName: offb.last_name || "",
        reason: offb.reason,
        lastWorkingDay: lastDayFormatted,
        dashboardUrl,
      }),
    }).catch((err) =>
      console.error("[offboarding/upload-signed] finance email err:", err)
    );

    return NextResponse.json({ success: true });
  } catch (err: any) {
    console.error("[offboarding/upload-signed] fatal:", err);
    return NextResponse.json(
      { error: "Erreur serveur", details: err?.message },
      { status: 500 }
    );
  }
}
