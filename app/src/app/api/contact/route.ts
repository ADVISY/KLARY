import { NextRequest, NextResponse } from "next/server";
import { createSupabaseServerClient } from "@/lib/supabase/server";
import { z } from "zod";
import { sendEmail, ADMIN_EMAIL } from "@/lib/resend/client";
import { templates } from "@/lib/resend/templates";

const contactSchema = z.object({
  first_name: z.string().min(1).max(100),
  last_name: z.string().min(1).max(100),
  email: z.string().email().max(200),
  phone: z.string().max(50).optional().or(z.literal("")),
  subject: z.enum([
    "demande_information",
    "demande_devis",
    "assurance_maladie",
    "prevoyance",
    "lpp_libre_passage",
    "hypotheque",
    "autre",
  ]),
  message: z.string().min(10).max(5000),
  consent: z.union([z.literal("on"), z.literal("true"), z.boolean()]),
});

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

const SUBJECT_LABELS: Record<string, string> = {
  demande_information: "Demande d'information",
  demande_devis: "Demande de devis / comparatif",
  assurance_maladie: "Assurance maladie (LAMal / LCA)",
  prevoyance: "Prévoyance / 3e pilier",
  lpp_libre_passage: "LPP libre passage",
  hypotheque: "Hypothèque",
  autre: "Autre",
};

export async function POST(request: NextRequest) {
  try {
    const body = await request.json();
    const parsed = contactSchema.safeParse(body);

    if (!parsed.success) {
      return NextResponse.json(
        { error: "Données invalides", details: parsed.error.flatten() },
        { status: 400, headers: CORS_HEADERS }
      );
    }

    const data = parsed.data;
    const supabase = createSupabaseServerClient();

    const scheduledDeleteAt = new Date();
    scheduledDeleteAt.setMonth(scheduledDeleteAt.getMonth() + 24);

    const { error, data: inserted } = await supabase
      .from("contact_messages")
      .insert({
        first_name: data.first_name,
        last_name: data.last_name,
        email: data.email,
        phone: data.phone || null,
        subject: data.subject,
        message: data.message,
        status: "new",
        consent_given_at: new Date().toISOString(),
        scheduled_delete_at: scheduledDeleteAt.toISOString(),
        user_agent: request.headers.get("user-agent") || null,
      })
      .select()
      .single();

    if (error) {
      console.error("Supabase insert error:", error);
      return NextResponse.json(
        { error: "Erreur d'enregistrement, veuillez réessayer." },
        { status: 500, headers: CORS_HEADERS }
      );
    }

    // ─── Notifications email (Resend) ───
    const subjectLabel = SUBJECT_LABELS[data.subject] || data.subject;
    const appUrl = process.env.NEXT_PUBLIC_APP_URL || "https://app.klary.ch";
    const dashboardUrl = `${appUrl}/admin/contacts`;

    // Notification admin
    sendEmail({
      to: ADMIN_EMAIL,
      subject: `[Contact] ${subjectLabel} — ${data.first_name} ${data.last_name}`,
      replyTo: data.email,
      html: templates.contactAdminNotif({
        firstName: data.first_name,
        lastName: data.last_name,
        email: data.email,
        phone: data.phone || undefined,
        subject: subjectLabel,
        message: data.message,
        dashboardUrl,
      }),
    }).catch((err) => console.error("Failed admin notif:", err));

    // Accusé de réception au visiteur
    sendEmail({
      to: data.email,
      subject: "Votre message a bien été reçu — Klary",
      html: templates.contactConfirmation({ firstName: data.first_name }),
    }).catch((err) => console.error("Failed contact confirmation:", err));

    return NextResponse.json({ success: true }, { status: 200, headers: CORS_HEADERS });
  } catch (error) {
    console.error("Contact POST error:", error);
    return NextResponse.json({ error: "Erreur serveur" }, { status: 500 });
  }
}
