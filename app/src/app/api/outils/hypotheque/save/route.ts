import { NextRequest, NextResponse } from "next/server";
import { createSupabaseServerClient } from "@/lib/supabase/server";

/**
 * POST /api/outils/hypotheque/save
 * Body : { dossier, synthese, notes?, outcome?, relance_at? }
 * Sauvegarde une simulation dans l'historique du conseiller.
 * Si `id` est fourni → update, sinon → create.
 */
export async function POST(request: NextRequest) {
  const supabase = createSupabaseServerClient();
  const {
    data: { user },
  } = await supabase.auth.getUser();
  if (!user) {
    return NextResponse.json({ error: "Non authentifié" }, { status: 401 });
  }

  let body: any;
  try {
    body = await request.json();
  } catch {
    return NextResponse.json({ error: "Body JSON invalide" }, { status: 400 });
  }

  const dossier = body.dossier;
  if (!dossier || typeof dossier !== "object") {
    return NextResponse.json({ error: "Champ `dossier` requis" }, { status: 400 });
  }

  const payload = {
    user_id: user.id,
    outil: "hypotheque_ppl" as const,
    client_prenom: dossier.clientPrenom ?? null,
    client_nom: dossier.clientNom ?? null,
    dossier,
    synthese: body.synthese ?? null,
    notes: body.notes ?? null,
    outcome: body.outcome ?? null,
    relance_at: body.relance_at ?? null,
  };

  if (body.id) {
    // Update — RLS vérifie que user_id matche
    const { data, error } = await supabase
      .from("outil_simulations")
      .update(payload)
      .eq("id", body.id)
      .eq("user_id", user.id)
      .select("id")
      .single();
    if (error) return NextResponse.json({ error: error.message }, { status: 500 });
    return NextResponse.json({ id: data.id, updated: true });
  }

  const { data, error } = await supabase
    .from("outil_simulations")
    .insert(payload)
    .select("id")
    .single();
  if (error) return NextResponse.json({ error: error.message }, { status: 500 });
  return NextResponse.json({ id: data.id, created: true });
}
