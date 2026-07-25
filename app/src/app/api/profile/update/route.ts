import { NextRequest, NextResponse } from "next/server";
import { createSupabaseServerClient } from "@/lib/supabase/server";
import { z } from "zod";

const profileSchema = z.object({
  first_name: z.string().min(1).max(100),
  last_name: z.string().min(1).max(100),
  date_of_birth: z.string().regex(/^\d{4}-\d{2}-\d{2}$/, "Date invalide"),
  phone: z.string().max(50).optional().or(z.literal("")),
  postal_street: z.string().min(1).max(200),
  postal_zip: z.string().min(4).max(10),
  postal_city: z.string().min(1).max(100),
  postal_country: z.string().min(1).max(100).default("Suisse"),
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

    const body = await request.json();
    const parsed = profileSchema.safeParse(body);
    if (!parsed.success) {
      return NextResponse.json(
        { error: "Données invalides", details: parsed.error.flatten() },
        { status: 400 }
      );
    }

    const d = parsed.data;
    const { error } = await supabase
      .from("user_roles")
      .update({
        first_name: d.first_name,
        last_name: d.last_name,
        date_of_birth: d.date_of_birth,
        phone: d.phone || null,
        postal_street: d.postal_street,
        postal_zip: d.postal_zip,
        postal_city: d.postal_city,
        postal_country: d.postal_country,
      })
      .eq("user_id", user.id)
      .eq("active", true);

    if (error) {
      console.error("Profile update error:", error);
      return NextResponse.json(
        { error: "Erreur d'enregistrement" },
        { status: 500 }
      );
    }

    return NextResponse.json({ success: true });
  } catch (error) {
    console.error("profile/update error:", error);
    return NextResponse.json({ error: "Erreur serveur" }, { status: 500 });
  }
}
