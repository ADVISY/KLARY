// Import batch #6 — Livret d'accueil agent Klary (édition 2026)
import { readFileSync, existsSync } from "node:fs";
import { basename } from "node:path";
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

const DOCS = [
  {
    path: "/Users/habibagharbi/Projects/Klary Sàrl/brand-assets/onboarding-agent/Livret_Accueil_Agent_Klary.pdf",
    title: "Klary — Livret d'accueil agent (Édition 2026)",
    description:
      "Document remis à chaque nouveau collaborateur Klary lors de sa signature de contrat. Couvre : positionnement Klary, statut & rémunération, cadre réglementaire (LSA/LSFin/nLPD), Méthode Klary en 5 étapes, fiches produits express, outils à disposition, résiliations, checklist intégration J1/S1/M1 et Q&A fréquentes.",
    category: "procedure_klary",
    tags: ["klary", "livret_accueil", "onboarding", "agent", "2026"],
    target_roles: ["conseiller", "telephoniste"],
  },
];

function slugify(str) {
  return str
    .toLowerCase()
    .normalize("NFD")
    .replace(/[̀-ͯ]/g, "")
    .replace(/[^a-z0-9]+/g, "_")
    .replace(/^_+|_+$/g, "")
    .slice(0, 60);
}

async function getAnyAdminId() {
  const { data } = await supabase
    .from("user_roles")
    .select("user_id")
    .eq("role", "admin")
    .eq("active", true)
    .limit(1)
    .maybeSingle();
  return data?.user_id || null;
}

async function importOne(doc, uploadedBy) {
  const label = `[${basename(doc.path)}]`;
  if (!existsSync(doc.path)) {
    console.log(`⏭  ${label} introuvable`);
    return { status: "skipped" };
  }
  const filename = basename(doc.path);
  const buf = readFileSync(doc.path);
  const ext = filename.split(".").pop() || "pdf";
  const storagePath = `${doc.category}/${slugify(doc.title)}.${ext}`;

  // Idempotence : cherche par titre ET par storage_path
  const { data: existing } = await supabase
    .from("library_documents")
    .select("id, title")
    .or(`storage_path.eq.${storagePath},title.eq.${doc.title}`)
    .maybeSingle();

  if (existing) {
    // Écraser l'ancien (nouvelle version du livret)
    console.log(`♻  ${label} déjà présent (id=${existing.id}) — mise à jour du contenu`);

    // Upload avec upsert=true pour remplacer le PDF
    const { error: upErr } = await supabase.storage
      .from("library")
      .upload(storagePath, buf, {
        contentType: "application/pdf",
        upsert: true,
      });
    if (upErr) {
      console.error(`❌ upload:`, upErr.message);
      return { status: "error" };
    }

    // Update la row DB avec les nouveaux metadata (target_roles etc.)
    const { error: updErr } = await supabase
      .from("library_documents")
      .update({
        description: doc.description,
        tags: doc.tags,
        target_roles: doc.target_roles,
        size_bytes: buf.length,
        content_type: "application/pdf",
        updated_at: new Date().toISOString(),
      })
      .eq("id", existing.id);
    if (updErr) {
      console.error(`❌ update DB:`, updErr.message);
      return { status: "error" };
    }

    console.log(`✅ ${label} → mis à jour (${(buf.length / 1024).toFixed(0)} Ko)`);
    return { status: "updated" };
  }

  // Nouveau doc — insert
  const { error: upErr } = await supabase.storage
    .from("library")
    .upload(storagePath, buf, { contentType: "application/pdf", upsert: true });
  if (upErr) {
    console.error(`❌ ${label} upload:`, upErr.message);
    return { status: "error" };
  }
  const { error: insErr } = await supabase.from("library_documents").insert({
    title: doc.title,
    description: doc.description,
    category: doc.category,
    tags: doc.tags,
    target_roles: doc.target_roles,
    storage_path: storagePath,
    filename,
    size_bytes: buf.length,
    content_type: "application/pdf",
    uploaded_by: uploadedBy,
    is_active: true,
  });
  if (insErr) {
    await supabase.storage.from("library").remove([storagePath]);
    console.error(`❌ ${label} DB:`, insErr.message);
    return { status: "error" };
  }
  console.log(
    `✅ ${label} → ${doc.title} (${(buf.length / 1024).toFixed(0)} Ko) [${doc.category}]`
  );
  return { status: "ok" };
}

const uploadedBy = await getAnyAdminId();
console.log("═══ Import batch #6 — Livret d'accueil agent ═══\n");
const c = { ok: 0, skipped: 0, error: 0, updated: 0 };
for (const d of DOCS) {
  const r = await importOne(d, uploadedBy);
  c[r.status] = (c[r.status] || 0) + 1;
}
console.log(`\n${c.ok} nouveaux · ${c.updated} mis à jour · ${c.skipped} skip · ${c.error} erreurs`);
process.exit(c.error > 0 ? 1 : 0);
