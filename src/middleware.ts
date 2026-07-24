import { NextRequest, NextResponse } from "next/server";

/**
 * Routing par hostname :
 *   - klary.ch          → routes /(pages marketing à la racine)
 *   - app.klary.ch      → routes /app/*  (réécrites de manière transparente)
 *   - localhost         → tout accessible ; /app/* force le mode app
 */
export function middleware(request: NextRequest) {
  const hostname = request.headers.get("host") || "";
  const pathname = request.nextUrl.pathname;

  // Bypass assets et API
  if (
    pathname.startsWith("/_next") ||
    pathname.startsWith("/api") ||
    pathname === "/favicon.ico" ||
    pathname.includes(".")
  ) {
    return NextResponse.next();
  }

  const isAppHostname =
    hostname.startsWith("app.") || hostname.startsWith("app-");

  if (isAppHostname && !pathname.startsWith("/app")) {
    // On app.klary.ch mais URL sans préfixe /app → on réécrit vers /app/*
    const url = request.nextUrl.clone();
    url.pathname = `/app${pathname === "/" ? "" : pathname}`;
    return NextResponse.rewrite(url);
  }

  if (!isAppHostname && pathname.startsWith("/app")) {
    // On klary.ch (ou local) et l'URL est /app/* → rediriger vers app.klary.ch
    // Sauf en dev local (localhost) où on autorise
    if (
      !hostname.includes("localhost") &&
      !hostname.includes("127.0.0.1") &&
      !hostname.includes("vercel.app")
    ) {
      const url = new URL(request.url);
      url.hostname = "app.klary.ch";
      url.pathname = pathname.replace(/^\/app/, "") || "/";
      return NextResponse.redirect(url);
    }
  }

  return NextResponse.next();
}

export const config = {
  matcher: [
    "/((?!_next/static|_next/image|favicon.ico).*)",
  ],
};
