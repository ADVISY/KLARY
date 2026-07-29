// Import batch #3 — SVAG (Helsana/Fortuna/Feyn) + Optimis scripts + Art 45 LSA Klary
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
const SVAG = "/Users/habibagharbi/Downloads/SVAG INFO/DOC PARTENAIRE";
const OPTIMIS = "/Users/habibagharbi/Projects/Optimis/Scripts d'appel";

const DOCS = [
  // ─── Fiche légale Art. 45 LSA (obligatoire selon LSFin/LSA) ───
  {
    path: `${KLARY_ROOT}/brand-assets/documents-legaux/klary-art45-lsa.pdf`,
    title: "Klary — Fiche d'information Art. 45 LSA",
    description:
      "Fiche d'information client obligatoire selon l'art. 45 LSA (Loi sur la Surveillance des Assurances) et LSFin. À remettre à tout client avant conclusion d'un contrat d'assurance. Identité Klary, autorité de surveillance, rémunération intermédiaire, obligations diligence.",
    category: "reference_finma",
    tags: ["klary", "art_45", "lsa", "lsfin", "obligatoire"],
    target_roles: ["conseiller", "telephoniste"],
  },

  // ─── PV Helsana ───
  {
    path: `${SVAG}/Helsana/Procès-verbal de proposition.pdf`,
    title: "Helsana — Procès-verbal de proposition",
    description:
      "PV de conseil Helsana à remplir en rendez-vous client avant proposition d'assurance complémentaire. Obligatoire (art. 45 LSA).",
    category: "pv_conseil",
    tags: ["helsana", "pv", "proposition", "art_45"],
    target_roles: ["conseiller"],
  },

  // ─── Fortuna offres LCA ───
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

  // ─── Feyn hypothèque ───
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

  // ─── Scripts d'appel Optimis ───
  {
    path: `${OPTIMIS}/01-Trame-Optimis-Demande-Subside.pdf`,
    title: "Optimis — Trame appel demande de subside",
    description:
      "Script d'appel officiel pour qualifier une demande de subside cantonal d'assurance maladie. À utiliser par les téléphonistes.",
    category: "script_appel",
    tags: ["optimis", "subside", "appel", "qualification"],
    target_roles: ["conseiller", "telephoniste"],
  },
  {
    path: `${OPTIMIS}/02-Trame-Optimis-Comparatif-Assurance-Maladie.pdf`,
    title: "Optimis — Trame appel comparatif assurance maladie",
    description:
      "Script d'appel officiel pour comparatif assurance maladie (LAMal + LCA). Structure appel + argumentaire + qualification besoin.",
    category: "script_appel",
    tags: ["optimis", "maladie", "comparatif", "appel"],
    target_roles: ["conseiller", "telephoniste"],
  },
  {
    path: `${OPTIMIS}/03-Manuel-Optimis-Traitement-Leads-RDV.pdf`,
    title: "Optimis — Manuel traitement des leads et RDV",
    description:
      "Mode d'emploi officiel Optimis pour le traitement complet du cycle : lead entrant → qualification → prise de RDV → transmission au conseiller.",
    category: "procedure_klary",
    tags: ["optimis", "leads", "rdv", "process", "manuel"],
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
    console.error(`❌ ${label} upload:`, upErr.message);
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
    console.error(`❌ ${label} DB:`, insErr.message);
    return { status: "error", reason: insErr.message };
  }

  const kb = (buf.length / 1024).toFixed(0);
  console.log(
    `✅ ${label} → ${doc.title} (${kb} Ko) [${doc.category} · target: ${doc.target_roles.join(",")}]`
  );
  return { status: "ok" };
}

console.log("═══════════════════════════════════════════════════");
console.log("Import batch #3 — SVAG + Optimis + Art 45 LSA");
console.log("═══════════════════════════════════════════════════\n");

const uploadedBy = await getAnyAdminId();
if (!uploadedBy) {
  console.error("❌ Aucun admin actif");
  process.exit(1);
}

const counters = { ok: 0, skipped: 0, error: 0 };
for (const doc of DOCS) {
  const res = await importOne(doc, uploadedBy);
  counters[res.status] = (counters[res.status] || 0) + 1;
}

console.log(
  `\nTerminé — ${counters.ok} importés · ${counters.skipped} skip · ${counters.error} erreurs`
);
process.exit(counters.error > 0 ? 1 : 0);
