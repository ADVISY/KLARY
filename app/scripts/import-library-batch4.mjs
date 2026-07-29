// Import batch #4 — Formulaires admin compagnies (Groupe Mutuel + Helsana + PAX)
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

const SVAG = "/Users/habibagharbi/Downloads/SVAG INFO/DOC PARTENAIRE";

const DOCS = [
  {
    path: `${SVAG}/Groupe Mutuel/GM_Login formulaire.pdf`,
    title: "Groupe Mutuel — Formulaire de login (espace client)",
    description:
      "Formulaire d'inscription à l'espace client en ligne Groupe Mutuel (MyMutuel). À faire remplir au client pour activation de son accès.",
    category: "procedure_klary",
    tags: ["groupe_mutuel", "login", "espace_client", "formulaire"],
    target_roles: ["conseiller"],
  },
  {
    path: `${SVAG}/Helsana/Procuration Helsana.pdf`,
    title: "Helsana — Procuration client",
    description:
      "Formulaire de procuration Helsana à faire signer par le client pour permettre au conseiller Klary d'agir en son nom auprès de la compagnie (résiliation, changement modèle, questions dossier).",
    category: "procedure_klary",
    tags: ["helsana", "procuration", "mandat"],
    target_roles: ["conseiller"],
  },
  {
    path: `${SVAG}/PAX/LSV.pdf`,
    title: "PAX — Autorisation LSV (prélèvement bancaire)",
    description:
      "Formulaire LSV (Lastschriftverfahren) PAX à faire remplir et signer par le client pour autoriser PAX à prélever automatiquement les primes de prévoyance sur son compte bancaire.",
    category: "procedure_klary",
    tags: ["pax", "lsv", "prelevement", "prevoyance"],
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
    console.log(`⏭  ${label} introuvable`);
    return { status: "skipped" };
  }
  const filename = basename(doc.path);
  const buf = readFileSync(doc.path);
  const ext = filename.split(".").pop() || "pdf";
  const storagePath = `${doc.category}/${slugify(doc.title)}.${ext}`;
  const { data: existing } = await supabase
    .from("library_documents")
    .select("id")
    .or(`storage_path.eq.${storagePath},title.eq.${doc.title}`)
    .maybeSingle();
  if (existing) {
    console.log(`⏭  ${label} déjà présent`);
    return { status: "skipped" };
  }
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
  console.log(`✅ ${label} → ${doc.title} (${(buf.length / 1024).toFixed(0)} Ko)`);
  return { status: "ok" };
}

const uploadedBy = await getAnyAdminId();
if (!uploadedBy) process.exit(1);

console.log("═══ Import batch #4 — GM + Helsana + PAX ═══\n");
const c = { ok: 0, skipped: 0, error: 0 };
for (const d of DOCS) {
  const r = await importOne(d, uploadedBy);
  c[r.status] = (c[r.status] || 0) + 1;
}
console.log(`\n${c.ok} importés · ${c.skipped} skip · ${c.error} erreurs`);
process.exit(c.error > 0 ? 1 : 0);
