// Test direct : crée un event Google Calendar via l'API pour valider la config
import { readFileSync, existsSync } from "node:fs";
import { createClient } from "@supabase/supabase-js";

const envPath = new URL("../.env.local", import.meta.url);
if (existsSync(envPath)) {
  for (const line of readFileSync(envPath, "utf8").split("\n")) {
    const m = line.match(/^\s*([A-Z_][A-Z0-9_]*)\s*=\s*(.*)\s*$/);
    if (m && !process.env[m[1]]) process.env[m[1]] = m[2].replace(/^['"]|['"]$/g, "");
  }
}

const supabase = createClient(
  process.env.NEXT_PUBLIC_SUPABASE_URL,
  process.env.SUPABASE_SERVICE_ROLE_KEY,
  { auth: { persistSession: false } }
);

// 1. Récupérer les tokens
const { data: tokens } = await supabase
  .from("google_oauth_tokens")
  .select("*")
  .eq("provider", "google")
  .maybeSingle();

if (!tokens) {
  console.error("❌ Aucun token Google en DB");
  process.exit(1);
}

console.log(`Tokens : authorized_email=${tokens.authorized_email}`);
console.log(`Scope : ${tokens.scope}`);
console.log(`Expires : ${tokens.expires_at}`);

// 2. Refresh access token si expiré
const now = Date.now();
const exp = new Date(tokens.expires_at).getTime();
let accessToken = tokens.access_token;

if (now >= exp - 60_000) {
  console.log("\n⏳ Access token expiré, refresh…");
  const res = await fetch("https://oauth2.googleapis.com/token", {
    method: "POST",
    headers: { "Content-Type": "application/x-www-form-urlencoded" },
    body: new URLSearchParams({
      client_id: process.env.GOOGLE_CLIENT_ID,
      client_secret: process.env.GOOGLE_CLIENT_SECRET,
      refresh_token: tokens.refresh_token,
      grant_type: "refresh_token",
    }),
  });
  const data = await res.json();
  if (!res.ok || !data.access_token) {
    console.error("❌ Refresh échec :", data);
    process.exit(1);
  }
  accessToken = data.access_token;
  console.log(`✅ Nouveau access_token (expires in ${data.expires_in}s)`);
} else {
  console.log("✅ Access token toujours valide");
}

// 3. Créer un event test dans 1 heure, durée 30 min
const start = new Date(Date.now() + 3600 * 1000);
const end = new Date(start.getTime() + 30 * 60 * 1000);

const body = {
  summary: "🧪 Test Klary Calendar API",
  description: "Event créé par test-google-event.mjs — tu peux le supprimer.",
  location: "Test — Route de Crassier 7, 1262 Eysins",
  start: { dateTime: start.toISOString(), timeZone: "Europe/Zurich" },
  end: { dateTime: end.toISOString(), timeZone: "Europe/Zurich" },
  reminders: {
    useDefault: false,
    overrides: [{ method: "popup", minutes: 10 }],
  },
};

console.log("\n📅 Création event test…");
console.log("   Start :", start.toISOString(), "(zone Europe/Zurich)");

const url =
  "https://www.googleapis.com/calendar/v3/calendars/primary/events?sendUpdates=none";
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
  console.error(`\n❌ ÉCHEC ${res.status} :`, JSON.stringify(data, null, 2));
  process.exit(1);
}

console.log(`\n✅ Event créé avec succès !`);
console.log(`   ID     : ${data.id}`);
console.log(`   Link   : ${data.htmlLink}`);
console.log(`   Status : ${data.status}`);
console.log(`   Timezone confirmée : ${data.start.timeZone} / ${data.end.timeZone}`);
console.log(`\nOuvre le htmlLink ci-dessus dans ton navigateur.`);
console.log(`Si tu vois "Test Klary Calendar API" dans TON Google Calendar → intégration parfaite.`);
console.log(`Sinon → problème de compte Google (mauvais compte connecté chez toi).`);
