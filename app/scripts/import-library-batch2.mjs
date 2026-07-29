// Import batch #2 — Templates résiliation + PV compagnies + fiches produits Fortuna + Feyn
// Réutilise la même logique que import-library-pdfs.mjs (idempotent via check title/path)
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

const KLARY_ROOT = "/Users/habibagharbi/Projects/Klary Sàrl";
const SVAG = "/Users/habibagharbi/Desktop/SVAG INFO/DOC PARTENAIRE";

const DOCS = [
  // Templates internes Klary — utile pour conseillers ET téléphonistes
  {
    path: `${KLARY_ROOT}/brand-assets/processus-internes/templates/Resiliation_LAMal_LCA_Template.pdf`,
    title: "Klary — Template lettre de résiliation LAMal / LCA",
    description:
      "Modèle Klary officiel pour rédiger une lettre de résiliation à envoyer à la compagnie d'assurance (LAMal ou LCA). À personnaliser avec les infos client.",
    category: "procedure_klary",
    tags: ["klary", "resiliation", "lamal", "lca", "template"],
    target_roles: ["conseiller", "telephoniste"],
  },

  // Procès-verbal Helsana (RDV LCA)
  {
    path: `${SVAG}/Helsana/Procès-verbal de proposition.pdf`,
    title: "Helsana — Procès-verbal de proposition",
    description:
      "PV de conseil Helsana à remplir en rendez-vous client avant proposition d'assurance complémentaire. Obligatoire (art. 45 LSA).",
    category: "pv_conseil",
    tags: ["helsana", "pv", "proposition", "art_45"],
    target_roles: ["conseiller"],
  },

  // Fortuna — offres LCA
  {
    path: `${SVAG}/Fortuna/Privée/Offre Top Fortuna.pdf`,
    title: "Fortuna — Offre Top (privée)",
    description:
      "Fiche produit Fortuna gamme Top — assurance complémentaire haut de gamme.",
    category: "fiche_produit",
    tags: ["fortuna", "top", "lca", "privee"],
    target_roles: ["conseiller"],
  },
  {
    path: `${SVAG}/Fortuna/Privée/Offre_basic_2024_fr.pdf`,
    title: "Fortuna — Offre Basic 2024",
    description:
      "Fiche produit Fortuna gamme Basic 2024 — assurance complémentaire entrée de gamme.",
    category: "fiche_produit",
    tags: ["fortuna", "basic", "lca", "2024"],
    target_roles: ["conseiller"],
  },

  // Feyn — hypothèque
  {
    path: `${SVAG}/Feyn/Checklist feyn FR.pdf`,
    title: "Feyn — Checklist dossier hypothèque",
    description:
      "Checklist des documents à collecter auprès du client pour monter un dossier de financement hypothécaire Feyn.",
    category: "procedure_klary",
    tags: ["feyn", "hypotheque", "checklist"],
    target_roles: ["conseiller"],
  },
  {
    path: `${SVAG}/Feyn/Demande de financement feyn.pdf`,
    title: "Feyn — Formulaire demande de financement",
    description:
      "Formulaire officiel Feyn à remplir avec le client pour lancer une demande de financement hypothécaire.",
    category: "procedure_klary",
    tags: ["feyn", "hypotheque", "financement", "formulaire"],
    target_roles: ["conseiller"],
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
    console.log(`⏭  ${label} fichier introuvable — skip`);
    return { status: "skipped", reason: "not_found" };
  }

  const filename = basename(doc.path);
  const buf = readFileSync(doc.path);
  const ext = filename.split(".").pop() || "pdf";
  const storagePath = `${doc.category}/${slugify(doc.title)}.${ext}`;

  const { data: existing } = await supabase
    .from("library_documents")
    .select("id, title")
    .or(`storage_path.eq.${storagePath},title.eq.${doc.title}`)
    .maybeSingle();

  if (existing) {
    console.log(`⏭  ${label} déjà présent (id=${existing.id}) — skip`);
    return { status: "skipped", reason: "duplicate" };
  }

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
    console.error(`❌ ${label} insert DB:`, insErr.message);
    return { status: "error", reason: insErr.message };
  }

  const kb = (buf.length / 1024).toFixed(0);
  const targets = doc.target_roles.join(",");
  console.log(`✅ ${label} → ${doc.title} (${kb} Ko) [target: ${targets}]`);
  return { status: "ok" };
}

console.log("═══════════════════════════════════════════════════");
console.log("Import batch #2 — Résiliation + PV + Fortuna + Feyn");
console.log("═══════════════════════════════════════════════════\n");

const uploadedBy = await getAnyAdminId();
if (!uploadedBy) {
  console.error("❌ Aucun admin actif dans user_roles");
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
