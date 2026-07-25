import { NextRequest, NextResponse } from "next/server";
import { createSupabaseServerClient } from "@/lib/supabase/server";

/**
 * Callback OAuth Supabase — reçoit le code du magic link,
 * échange contre une session, puis redirige vers /formation.
 *
 * Sécurité : vérifie que l'email est bien @klary.ch. Sinon efface la session.
 */
export async function GET(request: NextRequest) {
  const { searchParams, origin } = new URL(request.url);
  const code = searchParams.get("code");
  const nextPath = searchParams.get("next") || "/formation";

  if (!code) {
    return NextResponse.redirect(
      `${origin}/auth/error?message=${encodeURIComponent("Lien invalide ou expiré.")}`
    );
  }

  const supabase = createSupabaseServerClient();

  const { data, error } = await supabase.auth.exchangeCodeForSession(code);

  if (error || !data.session) {
    return NextResponse.redirect(
      `${origin}/auth/error?message=${encodeURIComponent(
        error?.message || "Session invalide."
      )}`
    );
  }

  const userEmail = data.session.user.email?.toLowerCase();

  // Double-vérification : seuls les emails @klary.ch autorisés
  if (!userEmail || !userEmail.endsWith("@klary.ch")) {
    await supabase.auth.signOut();
    return NextResponse.redirect(
      `${origin}/auth/error?message=${encodeURIComponent(
        "Seuls les emails @klary.ch sont autorisés."
      )}`
    );
  }

  // Vérifier que l'utilisateur a un rôle assigné dans user_roles
  const { data: roleData } = await supabase
    .from("user_roles")
    .select("role, active")
    .eq("user_id", data.session.user.id)
    .eq("active", true)
    .maybeSingle();

  if (!roleData) {
    // Auto-création du rôle "agent" par défaut si utilisateur nouveau + email @klary.ch
    await supabase.from("user_roles").insert({
      user_id: data.session.user.id,
      role: "agent",
      first_name: userEmail.split("@")[0].split(".")[0],
      last_name: userEmail.split("@")[0].split(".")[1] || "",
      active: true,
    });
  }

  return NextResponse.redirect(`${origin}${nextPath}`);
}
