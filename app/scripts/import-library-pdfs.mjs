// ═════════════════════════════════════════════════════════
// Import en masse — Fiches produits compagnies + tableaux LCA Klary
// Vers bucket Storage "library" + table library_documents
//
// Prérequis :
//   - .env.local avec NEXT_PUBLIC_SUPABASE_URL + SUPABASE_SERVICE_ROLE_KEY
//   - Migration 20260725310000_job_titles.sql appliquée (colonne target_roles)
//   - Bucket "library" créé (privé) sur Supabase Storage
//
// Usage :
//   cd klary-app/app
//   node scripts/import-library-pdfs.mjs
//
// Idempotent : vérifie storage_path avant insert (ré-exécutable sans doublons).
// ═════════════════════════════════════════════════════════

import { readFileSync, existsSync } from "node:fs";
import { basename } from "node:path";
import { createClient } from "@supabase/supabase-js";

// ─── Chargement .env.local (sans dep dotenv) ───
const envPath = new URL("../.env.local", import.meta.url);
if (existsSync(envPath)) {
  const raw = readFileSync(envPath, "utf8");
  for (const line of raw.split("\n")) {
    const m = line.match(/^\s*([A-Z_][A-Z0-9_]*)\s*=\s*(.*)\s*$/);
    if (m && !process.env[m[1]]) {
      process.env[m[1]] = m[2].replace(/^['"]|['"]$/g, "");
    }
  }
}

const SUPABASE_URL = process.env.NEXT_PUBLIC_SUPABASE_URL;
const SERVICE_ROLE = process.env.SUPABASE_SERVICE_ROLE_KEY;

if (!SUPABASE_URL || !SERVICE_ROLE) {
  console.error(
    "❌ Manque NEXT_PUBLIC_SUPABASE_URL ou SUPABASE_SERVICE_ROLE_KEY dans .env.local"
  );
  process.exit(1);
}

const supabase = createClient(SUPABASE_URL, SERVICE_ROLE, {
  auth: { persistSession: false },
});

// ─── Inventaire à importer ───
const KLARY_ROOT = "/Users/habibagharbi/Projects/Klary Sàrl";
const DOWNLOADS = "/Users/habibagharbi/Downloads";

const DOCS = [
  // Compagnies
  {
    path: `${DOWNLOADS}/021_f_Leistungsuebersicht_online_rfvnzk.pdf`,
    title: "SWICA — Récapitulatif des prestations 2026",
    description:
      "Vue d'ensemble complète des produits SWICA : assurance de base (Favorit), complémentaires (Completa Top/Forte, Praevita, Supplementa, Optima, Denta), hospitalisation (Hospita Privée/Demi-privée/Commune) et accidents (Infortuna).",
    category: "fiche_produit",
    tags: ["swica", "lca", "2026", "recapitulatif"],
  },
  {
    path: `${DOWNLOADS}/24- Fiche_Comparative_A4_FR-BR.pdf`,
    title: "Groupe Mutuel — Assurances complémentaires 2026",
    description:
      "Fiche comparative Groupe Mutuel : soins complémentaires (SC/SO/SD), hospitalisation (HC/HB), formules combinées (Global classic/flex/smart).",
    category: "fiche_produit",
    tags: ["groupe_mutuel", "lca", "2026", "comparatif"],
  },
  {
    path: `${DOWNLOADS}/501_f_produktblatt_leistungsuebersicht_myflex.pdf`,
    title: "CSS — Aperçu des prestations myFlex 2026",
    description:
      "Produktblatt CSS myFlex : offre modulaire avec choix flexible des couvertures complémentaires.",
    category: "fiche_produit",
    tags: ["css", "myflex", "lca", "2026"],
  },
  {
    path: `${DOWNLOADS}/502_f_produktblatt_leistungsuebersicht_classic.pdf`,
    title: "CSS — Aperçu des prestations Classic 2026",
    description:
      "Produktblatt CSS Classic : gamme classique de complémentaires CSS.",
    category: "fiche_produit",
    tags: ["css", "classic", "lca", "2026"],
  },
  {
    path: `${DOWNLOADS}/Assura_vuePrestations_v20_F_BR.pdf`,
    title: "Assura — Vue d'ensemble des produits",
    description:
      "Catalogue Assura : Basis, Complementa Extra, médecines alternatives (Natura/Medna), Denta Plus, Mondia, Previsia, hospitalisation (Priveco/Optima/Ultra Varia), Hospita.",
    category: "fiche_produit",
    tags: ["assura", "lca", "catalogue"],
  },
  {
    path: `${DOWNLOADS}/assurances-complementaires-hospitalisation-2.pdf`,
    title: "Helsana — Assurances d'hospitalisation 2025-26",
    description:
      "Focus hospitalisation Helsana : Hospital Eco, Hospital Flex, Demi-Privée, Privée. Prestations, franchises, rabais.",
    category: "fiche_produit",
    tags: ["helsana", "lca", "hospitalisation", "2025", "2026"],
  },
  {
    path: `${DOWNLOADS}/cahier-produits.pdf`,
    title: "Helsana — Brochure produit 2025-26",
    description:
      "Brochure produit complète Helsana : assurance de base (Basis, BeneFit PLUS Médecin de famille/Telmed/Flexmed, PREMED-24), complémentaires ambulatoires (Top, Sana, Completa, Completa Plus, Primeo), Dentaplus, World, hospitalisations, Advocare, Cura/Vivante, Hospital Extra, Salaria, Prevea.",
    category: "fiche_produit",
    tags: ["helsana", "lca", "brochure_complete", "2025", "2026"],
  },
  // Tableaux comparatifs Klary
  {
    path: `${KLARY_ROOT}/brand-assets/charte-graphique/Tableau_Comparatif_LCA_Accessible.pdf`,
    title: "Klary — Comparatif LCA Accessible",
    description:
      "Tableau comparatif Klary des solutions LCA accessibles (entrée de gamme) toutes compagnies.",
    category: "argumentaire",
    tags: ["klary", "lca", "comparatif", "accessible"],
  },
  {
    path: `${KLARY_ROOT}/brand-assets/charte-graphique/Tableau_Comparatif_LCA_Haut_de_Gamme.pdf`,
    title: "Klary — Comparatif LCA Haut de Gamme",
    description:
      "Tableau comparatif Klary des solutions LCA haut de gamme (privée / demi-privée avec confort) toutes compagnies.",
    category: "argumentaire",
    tags: ["klary", "lca", "comparatif", "haut_de_gamme"],
  },
];

// Toutes cible conseiller (les téléphonistes ne vendent pas de LCA)
const TARGET_ROLES = ["conseiller"];

// ─── Slug utilitaire ───
function slugify(str) {
  return str
    .toLowerCase()
    .normalize("NFD")
    .replace(/[̀-ͯ]/g, "")
    .replace(/[^a-z0-9]+/g, "_")
    .replace(/^_+|_+$/g, "")
    .slice(0, 60);
}

// ─── Récupère un admin existant (pour uploaded_by) ───
async function getAnyAdminId() {
  const { data, error } = await supabase
    .from("user_roles")
    .select("user_id")
    .eq("role", "admin")
    .eq("active", true)
    .limit(1)
    .maybeSingle();
  if (error) throw error;
  return data?.user_id || null;
}

// ─── Vérifie que la colonne target_roles existe ───
async function checkTargetRolesColumn() {
  const { error } = await supabase
    .from("library_documents")
    .select("target_roles")
    .limit(1);
  if (error && error.message?.includes("target_roles")) {
    console.error(
      "❌ Colonne target_roles absente. Applique la migration 20260725310000_job_titles.sql d'abord."
    );
    process.exit(1);
  }
}

// ─── Import d'un doc ───
async function importOne(doc, uploadedBy) {
  const label = `[${basename(doc.path)}]`;

  if (!existsSync(doc.path)) {
    console.log(`⏭  ${label} fichier introuvable — skip`);
    return { status: "skipped", reason: "not_found" };
  }

  const filename = basename(doc.path);
  const buf = readFileSync(doc.path);
  const ext = filename.split(".").pop() || "pdf";
  const storagePath = `${doc.category}/${slugify(doc.title)}.${ext}`;

  // Vérifie doublon par storage_path OU par title (idempotence)
  const { data: existing } = await supabase
    .from("library_documents")
    .select("id, title")
    .or(`storage_path.eq.${storagePath},title.eq.${doc.title}`)
    .maybeSingle();

  if (existing) {
    console.log(`⏭  ${label} déjà présent (id=${existing.id}) — skip`);
    return { status: "skipped", reason: "duplicate" };
  }

  // Upload storage (upsert=true pour cas où row DB manque mais fichier existe)
  const { error: upErr } = await supabase.storage
    .from("library")
    .upload(storagePath, buf, {
      contentType: "application/pdf",
      upsert: true,
    });

  if (upErr) {
    console.error(`❌ ${label} upload storage:`, upErr.message);
    return { status: "error", reason: upErr.message };
  }

  // Insert DB
  const { error: insErr } = await supabase.from("library_documents").insert({
    title: doc.title,
    description: doc.description,
    category: doc.category,
    tags: doc.tags,
    target_roles: TARGET_ROLES,
    storage_path: storagePath,
    filename,
    size_bytes: buf.length,
    content_type: "application/pdf",
    uploaded_by: uploadedBy,
    is_active: true,
  });

  if (insErr) {
    // Rollback storage
    await supabase.storage.from("library").remove([storagePath]);
    console.error(`❌ ${label} insert DB:`, insErr.message);
    return { status: "error", reason: insErr.message };
  }

  const kb = (buf.length / 1024).toFixed(0);
  console.log(`✅ ${label} → ${doc.title} (${kb} Ko)`);
  return { status: "ok" };
}

// ─── Main ───
async function main() {
  console.log("═══════════════════════════════════════════════════");
  console.log("Import bibliothèque Klary — fiches produits + comparatifs");
  console.log("═══════════════════════════════════════════════════\n");

  await checkTargetRolesColumn();

  const uploadedBy = await getAnyAdminId();
  if (!uploadedBy) {
    console.error("❌ Aucun admin trouvé dans user_roles — impossible de définir uploaded_by");
    process.exit(1);
  }
  console.log(`👤 uploaded_by = ${uploadedBy}\n`);

  const counters = { ok: 0, skipped: 0, error: 0 };

  for (const doc of DOCS) {
    const res = await importOne(doc, uploadedBy);
    counters[res.status] = (counters[res.status] || 0) + 1;
  }

  console.log("\n═══════════════════════════════════════════════════");
  console.log(
    `Terminé — ${counters.ok} importés · ${counters.skipped} skip · ${counters.error} erreurs`
  );
  console.log("═══════════════════════════════════════════════════");
  process.exit(counters.error > 0 ? 1 : 0);
}

main().catch((err) => {
  console.error("💥 Fatal:", err);
  process.exit(1);
});
