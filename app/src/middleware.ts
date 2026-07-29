import { NextRequest, NextResponse } from "next/server";
import { updateSession } from "@/lib/supabase/middleware";

/**
 * Middleware combiné :
 *   1. Rewrite hostname → path (klary.ch → /, app.klary.ch → /app)
 *   2. Rafraîchit la session Supabase à chaque requête
 *   3. Protège les routes privées (redirection vers /login si pas connecté)
 */

// Routes accessibles sans authentification dans /app
const PUBLIC_APP_ROUTES = [
  "/app/login",
  "/app/auth/check-email",
  "/app/auth/error",
  "/app/entretien", // page publique candidat pour choisir son créneau (auth par token)
  "/app/onboarding", // page publique candidat pour remplir son dossier onboarding
];

export async function middleware(request: NextRequest) {
  const hostname = request.headers.get("host") || "";
  const pathname = request.nextUrl.pathname;

  // Bypass static assets & Next internals (mais laisse passer /api)
  if (
    pathname.startsWith("/_next") ||
    pathname === "/favicon.ico" ||
    (pathname.includes(".") && !pathname.startsWith("/api"))
  ) {
    return NextResponse.next();
  }

  const isAppHostname =
    hostname.startsWith("app.") || hostname.startsWith("app-");

  // 1. Rewrite : app.klary.ch/xxx → /app/xxx
  //    Exceptions : /api/*, /verifier/*, /barometre/* (pages publiques servies
  //    identiquement sur les 2 domaines, sans layout dashboard)
  if (
    isAppHostname &&
    !pathname.startsWith("/app") &&
    !pathname.startsWith("/api") &&
    !pathname.startsWith("/verifier") &&
    !pathname.startsWith("/barometre")
  ) {
    const url = request.nextUrl.clone();
    url.pathname = `/app${pathname === "/" ? "" : pathname}`;
    return NextResponse.rewrite(url);
  }

  // 2. Redirect klary.ch/app/* → app.klary.ch/* (sauf dev)
  if (
    !isAppHostname &&
    pathname.startsWith("/app") &&
    !hostname.includes("localhost") &&
    !hostname.includes("127.0.0.1") &&
    !hostname.includes("vercel.app")
  ) {
    const url = new URL(request.url);
    url.hostname = "app.klary.ch";
    url.pathname = pathname.replace(/^\/app/, "") || "/";
    return NextResponse.redirect(url);
  }

  // 3. Session Supabase + protection routes /app/*
  const isAppRoute = pathname.startsWith("/app");

  if (isAppRoute) {
    const { response, user } = await updateSession(request);

    const isPublicRoute = PUBLIC_APP_ROUTES.some((p) => pathname.startsWith(p));
    const isApiAuth = pathname.startsWith("/api/auth");

    // Non authentifié sur route protégée → redirection login
    if (!user && !isPublicRoute && !isApiAuth) {
      const url = request.nextUrl.clone();
      url.pathname = isAppHostname ? "/login" : "/app/login";
      return NextResponse.redirect(url);
    }

    // Authentifié sur /login → redirection vers /formation
    if (user && (pathname === "/app/login" || pathname === "/app/login/")) {
      const url = request.nextUrl.clone();
      url.pathname = isAppHostname ? "/formation" : "/app/formation";
      return NextResponse.redirect(url);
    }

    return response;
  }

  return NextResponse.next();
}

export const config = {
  matcher: ["/((?!_next/static|_next/image|favicon.ico).*)"],
};
