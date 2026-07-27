/**
 * Google Calendar helper — OAuth 2.0 refresh + Calendar API v3
 *
 * Pas de dep externe (googleapis) — appels REST directs pour bundle léger.
 *
 * Requis dans .env :
 *   GOOGLE_CLIENT_ID
 *   GOOGLE_CLIENT_SECRET
 *   GOOGLE_REDIRECT_URI     (ex: https://app.klary.ch/api/google/callback)
 *
 * Table `google_oauth_tokens` : stocke le refresh_token unique + access_token cache.
 */

import { createClient } from "@supabase/supabase-js";

const GOOGLE_TOKEN_URL = "https://oauth2.googleapis.com/token";
const GOOGLE_AUTH_URL = "https://accounts.google.com/o/oauth2/v2/auth";
const CALENDAR_API_BASE = "https://www.googleapis.com/calendar/v3";

// Scopes minimum : lire l'email autorisé + gérer les events du calendrier primaire
export const GOOGLE_SCOPES = [
  "openid",
  "email",
  "https://www.googleapis.com/auth/calendar.events",
].join(" ");

function service() {
  return createClient(
    process.env.NEXT_PUBLIC_SUPABASE_URL!,
    process.env.SUPABASE_SERVICE_ROLE_KEY!,
    { auth: { persistSession: false, autoRefreshToken: false } }
  );
}

// ─── OAuth authorization URL (redirection utilisateur) ───

export function buildGoogleAuthUrl(state: string): string {
  const params = new URLSearchParams({
    client_id: process.env.GOOGLE_CLIENT_ID!,
    redirect_uri: process.env.GOOGLE_REDIRECT_URI!,
    response_type: "code",
    scope: GOOGLE_SCOPES,
    access_type: "offline", // pour obtenir un refresh_token
    prompt: "consent", // force ré-affichage du consent (garantit un refresh_token)
    include_granted_scopes: "true",
    state,
  });
  return `${GOOGLE_AUTH_URL}?${params.toString()}`;
}

// ─── Échange du code contre les tokens (callback) ───

export async function exchangeCodeForTokens(code: string): Promise<{
  access_token: string;
  refresh_token: string;
  expires_in: number;
  scope: string;
  id_token?: string;
}> {
  const res = await fetch(GOOGLE_TOKEN_URL, {
    method: "POST",
    headers: { "Content-Type": "application/x-www-form-urlencoded" },
    body: new URLSearchParams({
      code,
      client_id: process.env.GOOGLE_CLIENT_ID!,
      client_secret: process.env.GOOGLE_CLIENT_SECRET!,
      redirect_uri: process.env.GOOGLE_REDIRECT_URI!,
      grant_type: "authorization_code",
    }),
  });
  const data = await res.json();
  if (!res.ok) {
    throw new Error(
      `Google token exchange failed: ${res.status} ${JSON.stringify(data)}`
    );
  }
  return data;
}

// ─── Extraction email depuis id_token (JWT non vérifié — juste parsing) ───

export function extractEmailFromIdToken(idToken: string): string | null {
  try {
    const parts = idToken.split(".");
    if (parts.length !== 3) return null;
    const payload = JSON.parse(
      Buffer.from(parts[1], "base64url").toString("utf8")
    );
    return typeof payload.email === "string" ? payload.email : null;
  } catch {
    return null;
  }
}

// ─── Stockage / lecture des tokens ───

export async function storeGoogleTokens({
  accessToken,
  refreshToken,
  expiresIn,
  scope,
  authorizedEmail,
  connectedBy,
}: {
  accessToken: string;
  refreshToken: string;
  expiresIn: number;
  scope: string;
  authorizedEmail: string;
  connectedBy: string | null;
}) {
  const supabase = service();
  const expiresAt = new Date(Date.now() + expiresIn * 1000).toISOString();

  const { error } = await supabase.from("google_oauth_tokens").upsert(
    {
      provider: "google",
      scope,
      access_token: accessToken,
      refresh_token: refreshToken,
      expires_at: expiresAt,
      authorized_email: authorizedEmail,
      connected_by: connectedBy,
      connected_at: new Date().toISOString(),
      updated_at: new Date().toISOString(),
    },
    { onConflict: "provider" }
  );
  if (error) throw new Error("Storage error: " + error.message);
}

export async function getStoredGoogleTokens() {
  const supabase = service();
  const { data } = await supabase
    .from("google_oauth_tokens")
    .select("*")
    .eq("provider", "google")
    .maybeSingle();
  return data;
}

export async function deleteGoogleTokens() {
  const supabase = service();
  await supabase.from("google_oauth_tokens").delete().eq("provider", "google");
}

// ─── Access token frais (refresh si expiré) ───

async function refreshAccessToken(refreshToken: string): Promise<{
  access_token: string;
  expires_in: number;
}> {
  const res = await fetch(GOOGLE_TOKEN_URL, {
    method: "POST",
    headers: { "Content-Type": "application/x-www-form-urlencoded" },
    body: new URLSearchParams({
      client_id: process.env.GOOGLE_CLIENT_ID!,
      client_secret: process.env.GOOGLE_CLIENT_SECRET!,
      refresh_token: refreshToken,
      grant_type: "refresh_token",
    }),
  });
  const data = await res.json();
  if (!res.ok || !data.access_token) {
    throw new Error(`Refresh failed: ${res.status} ${JSON.stringify(data)}`);
  }
  return data;
}

export async function getFreshAccessToken(): Promise<string> {
  const stored = await getStoredGoogleTokens();
  if (!stored) throw new Error("Google Calendar non connecté");

  const expiresAt = new Date(stored.expires_at).getTime();
  const now = Date.now();

  // 60s de buffer avant expiration
  if (now < expiresAt - 60_000) {
    return stored.access_token;
  }

  const refreshed = await refreshAccessToken(stored.refresh_token);
  const newExpiresAt = new Date(now + refreshed.expires_in * 1000).toISOString();

  const supabase = service();
  await supabase
    .from("google_oauth_tokens")
    .update({
      access_token: refreshed.access_token,
      expires_at: newExpiresAt,
      updated_at: new Date().toISOString(),
    })
    .eq("provider", "google");

  return refreshed.access_token;
}

// ─── Calendar API : CRUD événements ───

export type CalendarEventDetails = {
  summary: string;
  description?: string;
  location?: string;
  startISO: string;
  durationMin: number;
  attendees?: { email: string; displayName?: string }[];
  /** "all" (par défaut) envoie invitation email aux attendees */
  sendUpdates?: "all" | "externalOnly" | "none";
};

export async function createCalendarEvent(
  details: CalendarEventDetails
): Promise<{ id: string; htmlLink: string }> {
  const accessToken = await getFreshAccessToken();
  const start = new Date(details.startISO);
  const end = new Date(start.getTime() + details.durationMin * 60_000);

  const body = {
    summary: details.summary,
    description: details.description,
    location: details.location,
    start: { dateTime: start.toISOString(), timeZone: "Europe/Zurich" },
    end: { dateTime: end.toISOString(), timeZone: "Europe/Zurich" },
    attendees: details.attendees,
    reminders: {
      useDefault: false,
      overrides: [
        { method: "email", minutes: 60 * 24 }, // 1 jour avant
        { method: "popup", minutes: 30 },
      ],
    },
  };

  const url = `${CALENDAR_API_BASE}/calendars/primary/events?sendUpdates=${
    details.sendUpdates || "all"
  }`;

  const res = await fetch(url, {
    method: "POST",
    headers: {
      Authorization: `Bearer ${accessToken}`,
      "Content-Type": "application/json",
    },
    body: JSON.stringify(body),
  });
  const data = await res.json();
  if (!res.ok) {
    throw new Error(
      `Create event failed: ${res.status} ${JSON.stringify(data)}`
    );
  }
  return { id: data.id, htmlLink: data.htmlLink };
}

export async function deleteCalendarEvent(eventId: string): Promise<void> {
  const accessToken = await getFreshAccessToken();
  const url = `${CALENDAR_API_BASE}/calendars/primary/events/${eventId}?sendUpdates=all`;
  const res = await fetch(url, {
    method: "DELETE",
    headers: { Authorization: `Bearer ${accessToken}` },
  });
  if (!res.ok && res.status !== 404 && res.status !== 410) {
    const text = await res.text();
    throw new Error(`Delete event failed: ${res.status} ${text}`);
  }
}
