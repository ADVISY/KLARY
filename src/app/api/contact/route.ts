import { NextRequest, NextResponse } from "next/server";
import { createSupabaseServerClient } from "@/lib/supabase/server";
import { z } from "zod";

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

export async function POST(request: NextRequest) {
  try {
    const body = await request.json();
    const parsed = contactSchema.safeParse(body);

    if (!parsed.success) {
      return NextResponse.json(
        { error: "Données invalides", details: parsed.error.flatten() },
        { status: 400 }
      );
    }

    const data = parsed.data;

    const supabase = createSupabaseServerClient();

    // Date de suppression auto : +24 mois
    const scheduledDeleteAt = new Date();
    scheduledDeleteAt.setMonth(scheduledDeleteAt.getMonth() + 24);

    const { error } = await supabase.from("contact_messages").insert({
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
    });

    if (error) {
      console.error("Supabase insert error:", error);
      return NextResponse.json(
        { error: "Erreur d'enregistrement, veuillez réessayer." },
        { status: 500 }
      );
    }

    // TODO : notifier Sacha via Resend Edge Function ou email direct
    // TODO : rate-limit par IP hash

    return NextResponse.json({ success: true }, { status: 200 });
  } catch (error) {
    console.error("Contact POST error:", error);
    return NextResponse.json(
      { error: "Erreur serveur" },
      { status: 500 }
    );
  }
}
