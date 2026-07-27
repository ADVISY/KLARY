import { NextRequest, NextResponse } from "next/server";
import { cookies } from "next/headers";
import { createSupabaseServerClient } from "@/lib/supabase/server";
import {
  exchangeCodeForTokens,
  extractEmailFromIdToken,
  storeGoogleTokens,
} from "@/lib/google/calendar";

/**
 * GET /api/google/callback
 * Callback OAuth Google — reçoit `code` + `state`.
 * - Vérifie state anti-CSRF
 * - Vérifie que l'utilisateur est admin/manager (session Supabase)
 * - Échange code → tokens
 * - Stocke tokens dans google_oauth_tokens
 * - Redirige vers page settings avec status
 */
export async function GET(req: NextRequest) {
  const appUrl = process.env.NEXT_PUBLIC_APP_URL || "http://localhost:3000";
  const settingsUrl = `${appUrl}/admin/integrations`;

  const url = req.nextUrl;
  const code = url.searchParams.get("code");
  const state = url.searchParams.get("state");
  const errorParam = url.searchParams.get("error");

  if (errorParam) {
    return NextResponse.redirect(
      `${settingsUrl}?google_error=${encodeURIComponent(errorParam)}`
    );
  }
  if (!code || !state) {
    return NextResponse.redirect(`${settingsUrl}?google_error=missing_params`);
  }

  // Vérifier state anti-CSRF
  const cookieStore = cookies();
  const savedState = cookieStore.get("g_oauth_state")?.value;
  if (!savedState || savedState !== state) {
    return NextResponse.redirect(`${settingsUrl}?google_error=state_mismatch`);
  }
  cookieStore.delete("g_oauth_state");

  // Vérifier session utilisateur
  const supabase = createSupabaseServerClient();
  const {
    data: { user },
  } = await supabase.auth.getUser();
  if (!user) {
    return NextResponse.redirect(`${settingsUrl}?google_error=not_authenticated`);
  }
  const { data: role } = await supabase
    .from("user_roles")
    .select("role")
    .eq("user_id", user.id)
    .eq("active", true)
    .maybeSingle();
  if (role?.role !== "admin" && role?.role !== "manager") {
    return NextResponse.redirect(`${settingsUrl}?google_error=forbidden`);
  }

  // Échange code → tokens
  try {
    const tokens = await exchangeCodeForTokens(code);
    if (!tokens.refresh_token) {
      // Peut arriver si l'utilisateur a déjà autorisé et que prompt=consent n'a pas été respecté
      return NextResponse.redirect(
        `${settingsUrl}?google_error=no_refresh_token`
      );
    }

    const email = tokens.id_token
      ? extractEmailFromIdToken(tokens.id_token)
      : null;

    await storeGoogleTokens({
      accessToken: tokens.access_token,
      refreshToken: tokens.refresh_token,
      expiresIn: tokens.expires_in,
      scope: tokens.scope,
      authorizedEmail: email || "unknown",
      connectedBy: user.id,
    });

    return NextResponse.redirect(`${settingsUrl}?google_connected=1`);
  } catch (err: any) {
    console.error("[google/callback] exchange error:", err);
    return NextResponse.redirect(
      `${settingsUrl}?google_error=${encodeURIComponent(err?.message || "unknown")}`
    );
  }
}
