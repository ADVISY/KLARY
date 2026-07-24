import { NextRequest, NextResponse } from "next/server";
import { createServerClient } from "@supabase/ssr";
import { cookies } from "next/headers";
import { z } from "zod";

const candidateSchema = z.object({
  first_name: z.string().min(1).max(100),
  last_name: z.string().min(1).max(100),
  email: z.string().email().max(200),
  phone: z.string().max(50).optional(),
  position_applied: z.string().min(1).max(100),
  cover_letter: z.string().max(10000).optional(),
});

const MAX_CV_SIZE = 5 * 1024 * 1024; // 5 MB

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
    });

    if (!parsed.success) {
      return NextResponse.json(
        { error: "Données invalides", details: parsed.error.flatten() },
        { status: 400 }
      );
    }

    const consent = formData.get("consent");
    if (!consent) {
      return NextResponse.json(
        { error: "Consentement RGPD/nLPD requis" },
        { status: 400 }
      );
    }

    const cv = formData.get("cv") as File | null;
    if (!cv || cv.size === 0) {
      return NextResponse.json({ error: "CV manquant" }, { status: 400 });
    }
    if (cv.size > MAX_CV_SIZE) {
      return NextResponse.json(
        { error: "CV trop lourd (max 5 Mo)" },
        { status: 400 }
      );
    }
    if (cv.type !== "application/pdf") {
      return NextResponse.json(
        { error: "Seuls les fichiers PDF sont acceptés" },
        { status: 400 }
      );
    }

    // Client service_role (bypass RLS pour storage et insertion)
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

    // Upload du CV
    const timestamp = Date.now();
    const safeName = `${data.last_name}_${data.first_name}_${timestamp}.pdf`
      .replace(/[^a-zA-Z0-9._-]/g, "_");
    const storagePath = `${new Date().getFullYear()}/${safeName}`;

    const cvBuffer = await cv.arrayBuffer();
    const { error: uploadError } = await supabase.storage
      .from("cvs")
      .upload(storagePath, cvBuffer, {
        contentType: "application/pdf",
        upsert: false,
      });

    if (uploadError) {
      console.error("CV upload error:", uploadError);
      return NextResponse.json(
        { error: "Erreur lors de l'upload du CV" },
        { status: 500 }
      );
    }

    // Date suppression auto : +12 mois
    const scheduledDeleteAt = new Date();
    scheduledDeleteAt.setMonth(scheduledDeleteAt.getMonth() + 12);

    const { error: insertError } = await supabase.from("candidates").insert({
      first_name: data.first_name,
      last_name: data.last_name,
      email: data.email,
      phone: data.phone || null,
      position_applied: data.position_applied,
      cover_letter: data.cover_letter || null,
      cv_storage_path: storagePath,
      status: "new",
      source: "site_klary",
      consent_given_at: new Date().toISOString(),
      scheduled_delete_at: scheduledDeleteAt.toISOString(),
    });

    if (insertError) {
      console.error("Candidate insert error:", insertError);
      // Cleanup CV upload en cas d'échec DB
      await supabase.storage.from("cvs").remove([storagePath]);
      return NextResponse.json(
        { error: "Erreur d'enregistrement, veuillez réessayer." },
        { status: 500 }
      );
    }

    // TODO : notifier Sacha par email (Resend)

    return NextResponse.json({ success: true }, { status: 200 });
  } catch (error) {
    console.error("Candidature POST error:", error);
    return NextResponse.json(
      { error: "Erreur serveur" },
      { status: 500 }
    );
  }
}
