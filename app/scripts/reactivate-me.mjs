// Fix urgent : réactive ton rôle admin coupé par un test d'offboarding sur toi-même
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

// 1. Trouve l'admin (probablement toi, Habib)
const { data: adminRow } = await supabase
  .from("user_roles")
  .select("user_id, first_name, last_name, role, active")
  .eq("role", "admin")
  .limit(1)
  .maybeSingle();

if (!adminRow) {
  console.error("❌ Aucun admin trouvé dans user_roles");
  process.exit(1);
}

console.log("Admin trouvé :", adminRow);

if (adminRow.active) {
  console.log("✅ Déjà actif — rien à faire.");
  process.exit(0);
}

// 2. Réactive
const { error: reactivateErr } = await supabase
  .from("user_roles")
  .update({ active: true })
  .eq("user_id", adminRow.user_id);

if (reactivateErr) {
  console.error("❌ Erreur réactivation :", reactivateErr);
  process.exit(1);
}

// 3. Marque l'offboarding en cours comme terminé (nettoyage du test)
const { data: pending, error: findErr } = await supabase
  .from("offboarding_processes")
  .select("id, reason, created_at, completed_at")
  .eq("user_id", adminRow.user_id)
  .is("completed_at", null);

if (findErr) {
  console.error("⚠ Impossible de chercher offboardings :", findErr.message);
} else if (pending && pending.length > 0) {
  console.log(`\n🗑  ${pending.length} offboarding(s) test en cours :`);
  for (const p of pending) {
    console.log(`   - ${p.id.slice(0, 8)} · ${p.reason} · créé ${p.created_at}`);
  }
  const { error: closeErr } = await supabase
    .from("offboarding_processes")
    .update({
      completed_at: new Date().toISOString(),
      completed_notes: "Fermé automatiquement (test admin sur soi-même)",
    })
    .in(
      "id",
      pending.map((p) => p.id)
    );
  if (closeErr) {
    console.log(`⚠ Impossible de fermer, essai sans champ notes :`, closeErr.message);
    await supabase
      .from("offboarding_processes")
      .update({ completed_at: new Date().toISOString() })
      .in("id", pending.map((p) => p.id));
  }
  console.log("   → fermé(s).");
}

console.log("\n✅ Rôle admin réactivé. Recharge app.klary.ch pour retrouver ton accès.");
