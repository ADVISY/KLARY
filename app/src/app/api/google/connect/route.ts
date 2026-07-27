import { NextResponse } from "next/server";
import { cookies } from "next/headers";
import { randomBytes } from "node:crypto";
import { createSupabaseServerClient } from "@/lib/supabase/server";
import { buildGoogleAuthUrl } from "@/lib/google/calendar";

/**
 * GET /api/google/connect
 * Admin only. Redirige vers l'écran de consentement Google OAuth.
 * Utilise un state random stocké en cookie pour anti-CSRF.
 */
export async function GET() {
  const supabase = createSupabaseServerClient();
  const {
    data: { user },
  } = await supabase.auth.getUser();
  if (!user) {
    return NextResponse.redirect(
      new URL("/login", process.env.NEXT_PUBLIC_APP_URL || "http://localhost:3000")
    );
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

  // Anti-CSRF : state random signé en cookie httpOnly
  const state = randomBytes(24).toString("hex");
  cookies().set("g_oauth_state", state, {
    httpOnly: true,
    secure: process.env.NODE_ENV === "production",
    sameSite: "lax",
    path: "/",
    maxAge: 600, // 10 min
  });

  const authUrl = buildGoogleAuthUrl(state);
  return NextResponse.redirect(authUrl);
}
