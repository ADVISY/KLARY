import { NextRequest, NextResponse } from "next/server";
import { createSupabaseServerClient } from "@/lib/supabase/server";

/**
 * GET /api/outils/hypotheque/load?id=<uuid>
 * Recharge une simulation existante (RLS gère les permissions).
 */
export async function GET(request: NextRequest) {
  const supabase = createSupabaseServerClient();
  const {
    data: { user },
  } = await supabase.auth.getUser();
  if (!user) {
    return NextResponse.json({ error: "Non authentifié" }, { status: 401 });
  }

  const id = request.nextUrl.searchParams.get("id");
  if (!id) {
    return NextResponse.json({ error: "Paramètre id requis" }, { status: 400 });
  }

  const { data, error } = await supabase
    .from("outil_simulations")
    .select("id, dossier, synthese, notes, outcome, relance_at, created_at, updated_at")
    .eq("id", id)
    .maybeSingle();

  if (error) return NextResponse.json({ error: error.message }, { status: 500 });
  if (!data) return NextResponse.json({ error: "Simulation introuvable" }, { status: 404 });

  return NextResponse.json(data);
}
