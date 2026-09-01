import { createBrowserClient } from "@supabase/ssr";

/**
 * Client Supabase côté navigateur (composants React client uniquement).
 * Utilise NEXT_PUBLIC_SUPABASE_URL et NEXT_PUBLIC_SUPABASE_ANON_KEY.
 *
 * cookieOptions explicites pour que le code_verifier PKCE survive :
 * - sameSite: lax (indispensable pour magic link cliqué depuis un email)
 * - secure: true en prod (cookie HTTPS-only)
 * - maxAge: 1 an
 * - path: / (toutes les pages)
 */
export function createSupabaseBrowserClient() {
  return createBrowserClient(
    process.env.NEXT_PUBLIC_SUPABASE_URL!,
    process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY!,
    {
      cookieOptions: {
        maxAge: 60 * 60 * 24 * 365, // 1 an
        path: "/",
        sameSite: "lax",
        secure: process.env.NODE_ENV === "production",
      },
    }
  );
}
