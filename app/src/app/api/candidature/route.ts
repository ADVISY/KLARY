import { NextRequest, NextResponse } from "next/server";
import { createServerClient } from "@supabase/ssr";
import { cookies } from "next/headers";
import { z } from "zod";
import { sendEmail, ADMIN_EMAIL } from "@/lib/resend/client";
import { templates } from "@/lib/resend/templates";

const candidateSchema = z.object({
  first_name: z.string().min(1).max(100),
  last_name: z.string().min(1).max(100),
  email: z.string().email().max(200),
  phone: z.string().max(50).optional(),
  position_applied: z.string().min(1).max(200),
  cover_letter: z.string().max(10000).optional(),
  why_klary: z.string().max(10000).optional(),
});

const MAX_FILE_SIZE = 5 * 1024 * 1024; // 5 MB par fichier
const ADDITIONAL_KEYS = ["diplomes", "casier", "poursuites"] as const;
const ACCEPTED_TYPES = [
  "application/pdf",
  "image/jpeg",
  "image/jpg",
  "image/png",
  "application/msword",
  "application/vnd.openxmlformats-officedocument.wordprocessingml.document",
];

// CORS : autoriser klary.ch (site Vite)
const CORS_HEADERS = {
  "Access-Control-Allow-Origin":
    process.env.CORS_ALLOW_ORIGIN || "https://klary.ch",
  "Access-Control-Allow-Methods": "POST, OPTIONS",
  "Access-Control-Allow-Headers": "Content-Type",
  "Access-Control-Max-Age": "86400",
};

export async function OPTIONS() {
  return new NextResponse(null, { status: 204, headers: CORS_HEADERS });
}

export async function POST(request: NextRequest) {
  try {
    const formData = await request.formData();

    const parsed = candidateSchema.safeParse({
      first_name: formData.get("first_name"),
      last_name: formData.get("last_name"),
      email: formData.get("email"),
      phone: formData.get("phone") || undefined,
      position_applied: formData.get("position_applied"),
      cover_letter: formData.get("cover_letter") || undefined,
      why_klary: formData.get("why_klary") || undefined,
    });

    if (!parsed.success) {
      return NextResponse.json(
        { error: "Données invalides", details: parsed.error.flatten() },
        { status: 400, headers: CORS_HEADERS }
      );
    }

    const consent = formData.get("consent");
    if (!consent) {
      return NextResponse.json(
        { error: "Consentement RGPD/nLPD requis" },
        { status: 400, headers: CORS_HEADERS }
      );
    }

    // ─── Validation CV ───
    const cv = formData.get("cv") as File | null;
    if (!cv || cv.size === 0) {
      return NextResponse.json(
        { error: "CV manquant" },
        { status: 400, headers: CORS_HEADERS }
      );
    }
    if (cv.size > MAX_FILE_SIZE) {
      return NextResponse.json(
        { error: "CV trop lourd (max 5 Mo)" },
        { status: 400, headers: CORS_HEADERS }
      );
    }
    if (!ACCEPTED_TYPES.includes(cv.type)) {
      return NextResponse.json(
        { error: "Type de fichier CV non accepté (PDF/DOC/DOCX/JPG/PNG)" },
        { status: 400, headers: CORS_HEADERS }
      );
    }

    // ─── Documents additionnels (optionnels) ───
    const additionalFiles: {
      key: string;
      file: File;
    }[] = [];
    for (const key of ADDITIONAL_KEYS) {
      const f = formData.get(`document_${key}`) as File | null;
      if (f && f.size > 0) {
        if (f.size > MAX_FILE_SIZE) {
          return NextResponse.json(
            {
              error: `Fichier '${key}' trop lourd (max 5 Mo)`,
            },
            { status: 400, headers: CORS_HEADERS }
          );
        }
        if (!ACCEPTED_TYPES.includes(f.type)) {
          return NextResponse.json(
            { error: `Type de fichier '${key}' non accepté` },
            { status: 400, headers: CORS_HEADERS }
          );
        }
        additionalFiles.push({ key, file: f });
      }
    }

    // ─── Client Supabase (service_role) ───
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

    const data = parsed.data;
    const now = Date.now();
    const year = new Date().getFullYear();
    const uploadedPaths: string[] = []; // pour cleanup en cas d'erreur

    // ─── Upload CV ───
    const cvExt = cv.name.split(".").pop() || "pdf";
    const safeCvName = `${data.last_name}_${data.first_name}_${now}_cv.${cvExt}`
      .replace(/[^a-zA-Z0-9._-]/g, "_")
      .toLowerCase();
    const cvPath = `${year}/${safeCvName}`;
    const cvBuffer = await cv.arrayBuffer();

    const { error: cvUploadErr } = await supabase.storage
      .from("cvs")
      .upload(cvPath, cvBuffer, {
        contentType: cv.type,
        upsert: false,
      });

    if (cvUploadErr) {
      console.error("CV upload error:", cvUploadErr);
      return NextResponse.json(
        { error: "Erreur lors de l'upload du CV" },
        { status: 500, headers: CORS_HEADERS }
      );
    }
    uploadedPaths.push(cvPath);

    // ─── Upload documents additionnels ───
    const additionalDocs: any[] = [];
    for (const doc of additionalFiles) {
      const ext = doc.file.name.split(".").pop() || "pdf";
      const safeName = `${data.last_name}_${data.first_name}_${now}_${doc.key}.${ext}`
        .replace(/[^a-zA-Z0-9._-]/g, "_")
        .toLowerCase();
      const path = `${year}/${safeName}`;
      const buf = await doc.file.arrayBuffer();

      const { error: err } = await supabase.storage
        .from("cvs")
        .upload(path, buf, { contentType: doc.file.type, upsert: false });

      if (err) {
        // Cleanup tous les uploads précédents
        await supabase.storage.from("cvs").remove(uploadedPaths);
        console.error(`Upload ${doc.key} error:`, err);
        return NextResponse.json(
          { error: `Erreur lors de l'upload du document '${doc.key}'` },
          { status: 500, headers: CORS_HEADERS }
        );
      }

      uploadedPaths.push(path);
      additionalDocs.push({
        key: doc.key,
        filename: doc.file.name,
        storage_path: path,
        size_bytes: doc.file.size,
      });
    }

    // ─── Insert en base ───
    const scheduledDeleteAt = new Date();
    scheduledDeleteAt.setMonth(scheduledDeleteAt.getMonth() + 12);

    const { error: insertError, data: inserted } = await supabase
      .from("candidates")
      .insert({
        first_name: data.first_name,
        last_name: data.last_name,
        email: data.email,
        phone: data.phone || null,
        position_applied: data.position_applied,
        cover_letter: data.cover_letter || null,
        why_klary: data.why_klary || null,
        cv_storage_path: cvPath,
        additional_documents: additionalDocs,
        status: "new",
        source: "site_klary",
        consent_given_at: new Date().toISOString(),
        scheduled_delete_at: scheduledDeleteAt.toISOString(),
      })
      .select()
      .single();

    if (insertError) {
      console.error("Candidate insert error:", insertError);
      // Cleanup TOUS les uploads en cas d'échec DB
      await supabase.storage.from("cvs").remove(uploadedPaths);
      return NextResponse.json(
        {
          error: "Erreur d'enregistrement, veuillez réessayer.",
          details: insertError.message,
        },
        { status: 500, headers: CORS_HEADERS }
      );
    }

    // ─── Notifications email ───
    const appUrl = process.env.NEXT_PUBLIC_APP_URL || "https://app.klary.ch";
    const dashboardUrl = `${appUrl}/admin/candidatures/${inserted?.id}`;

    sendEmail({
      to: ADMIN_EMAIL,
      subject: `[Candidature] ${data.position_applied} — ${data.first_name} ${data.last_name}`,
      replyTo: data.email,
      candidateId: inserted?.id,
      eventType: "candidature_admin_notif",
      html: templates.candidatureAdminNotif({
        firstName: data.first_name,
        lastName: data.last_name,
        email: data.email,
        phone: data.phone || undefined,
        positionApplied: data.position_applied,
        dashboardUrl,
      }),
    }).catch((err) => console.error("Failed admin notif:", err));

    sendEmail({
      to: data.email,
      subject: "Votre candidature a bien été reçue — Klary",
      candidateId: inserted?.id,
      eventType: "candidature_confirmation",
      html: templates.candidatureConfirmation({
        firstName: data.first_name,
        positionApplied: data.position_applied,
      }),
    }).catch((err) => console.error("Failed candidate confirmation:", err));

    return NextResponse.json(
      { success: true, id: inserted?.id },
      { status: 200, headers: CORS_HEADERS }
    );
  } catch (error) {
    console.error("Candidature POST error:", error);
    return NextResponse.json(
      { error: "Erreur serveur" },
      { status: 500, headers: CORS_HEADERS }
    );
  }
}
