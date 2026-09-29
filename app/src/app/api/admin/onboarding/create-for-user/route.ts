import { NextRequest, NextResponse } from "next/server";
import { randomUUID } from "crypto";
import {
  createSupabaseServerClient,
  createSupabaseServiceClient,
} from "@/lib/supabase/server";

/**
 * POST /api/admin/onboarding/create-for-user
 * Body : { userId: string }
 *
 * Ouvre un dossier RH (onboarding) pour un collaborateur déjà en poste.
 * Jusqu'ici un dossier ne pouvait être créé que depuis une candidature.
 * Réservé aux rôles admin et manager.
 */
export async function POST(request: NextRequest) {
  const auth = createSupabaseServerClient();
  const {
    data: { user },
  } = await auth.auth.getUser();
  if (!user) {
    return NextResponse.json({ error: "Non authentifié" }, { status: 401 });
  }

  const { data: roles } = await auth
    .from("user_roles")
    .select("role")
    .eq("user_id", user.id)
    .eq("active", true);
  const isPrivileged = (roles ?? []).some(
    (r: any) => r.role === "admin" || r.role === "manager"
  );
  if (!isPrivileged) {
    return NextResponse.json({ error: "Accès refusé" }, { status: 403 });
  }

  let body: any;
  try {
    body = await request.json();
  } catch {
    return NextResponse.json({ error: "Body JSON invalide" }, { status: 400 });
  }

  const userId = body?.userId;
  if (!userId || typeof userId !== "string") {
    return NextResponse.json({ error: "userId requis" }, { status: 400 });
  }

  const supabase = createSupabaseServiceClient();

  // Le collaborateur doit exister et être actif.
  const { data: target } = await supabase
    .from("user_roles")
    .select("user_id, first_name, last_name")
    .eq("user_id", userId)
    .eq("active", true)
    .maybeSingle();
  if (!target) {
    return NextResponse.json(
      { error: "Collaborateur introuvable ou inactif" },
      { status: 404 }
    );
  }

  // Un seul dossier par collaborateur : on renvoie l'existant plutôt que d'échouer.
  const { data: existing } = await supabase
    .from("onboarding_forms")
    .select("id, form_token, submitted_at")
    .eq("user_id", userId)
    .maybeSingle();

  if (existing) {
    return NextResponse.json({
      id: existing.id,
      token: existing.form_token,
      alreadyExists: true,
      submitted: !!existing.submitted_at,
    });
  }

  const formToken = randomUUID();
  const { data, error } = await supabase
    .from("onboarding_forms")
    .insert({
      user_id: userId,
      candidate_id: null,
      form_token: formToken,
      created_by: user.id,
    })
    .select("id, form_token")
    .single();

  if (error) {
    return NextResponse.json({ error: error.message }, { status: 500 });
  }

  return NextResponse.json({
    id: data.id,
    token: data.form_token,
    created: true,
  });
}
