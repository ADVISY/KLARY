import { NextResponse } from "next/server";
import { createSupabaseServerClient } from "@/lib/supabase/server";
import { deleteGoogleTokens } from "@/lib/google/calendar";

/**
 * POST /api/google/disconnect
 * Admin only. Supprime les tokens Google Calendar stockés.
 * Les events existants dans le calendrier ne sont pas touchés.
 */
export async function POST() {
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
  if (role?.role !== "admin" && role?.role !== "manager") {
    return NextResponse.json({ error: "Accès refusé" }, { status: 403 });
  }

  try {
    await deleteGoogleTokens();
    return NextResponse.json({ success: true });
  } catch (err: any) {
    console.error("[google/disconnect]", err);
    return NextResponse.json(
      { error: "Erreur suppression", details: err?.message },
      { status: 500 }
    );
  }
}
