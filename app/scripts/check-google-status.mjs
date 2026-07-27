// Diagnostic Google Calendar integration
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

console.log("═══ Google OAuth tokens ═══");
const { data: tokens } = await supabase
  .from("google_oauth_tokens")
  .select("provider, authorized_email, scope, connected_at, expires_at, updated_at")
  .eq("provider", "google")
  .maybeSingle();
if (!tokens) {
  console.log("  ❌ Aucun token — non connecté");
} else {
  console.log(`  ✅ authorized_email : ${tokens.authorized_email}`);
  console.log(`     scope           : ${tokens.scope}`);
  console.log(`     connected_at    : ${tokens.connected_at}`);
  console.log(`     access expires  : ${tokens.expires_at}`);
}

console.log("\n═══ 5 derniers entretiens ═══");
const { data: interviews } = await supabase
  .from("interview_slots")
  .select("id, candidate_id, selected_slot_index, selected_at, google_event_id, created_at, proposed_slots")
  .order("created_at", { ascending: false })
  .limit(5);

for (const iv of interviews || []) {
  console.log(`\n  Interview ${iv.id.slice(0, 8)}`);
  console.log(`    créé      : ${iv.created_at}`);
  console.log(`    confirmé  : ${iv.selected_at || "❌ pas encore"}`);
  console.log(`    slot #    : ${iv.selected_slot_index ?? "—"}`);
  if (iv.selected_slot_index != null && iv.proposed_slots) {
    const slot = iv.proposed_slots[iv.selected_slot_index];
    console.log(`    date slot : ${slot?.start || "?"}`);
  }
  console.log(`    google id : ${iv.google_event_id || "❌ AUCUN — event Google non créé"}`);

  // Candidat associé
  const { data: c } = await supabase
    .from("candidates")
    .select("first_name, last_name, email")
    .eq("id", iv.candidate_id)
    .maybeSingle();
  if (c) console.log(`    candidat  : ${c.first_name} ${c.last_name} <${c.email}>`);
}
