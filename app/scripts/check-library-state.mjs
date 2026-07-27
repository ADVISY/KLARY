// Vérifie DB + Storage bucket "library"
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

console.log("═══ DB storage_paths ═══");
const { data: docs } = await supabase
  .from("library_documents")
  .select("id, title, storage_path")
  .order("created_at", { ascending: false });

for (const d of docs) {
  console.log(`  ${d.storage_path}   ← ${d.title}`);
}

console.log("\n═══ Storage bucket 'library' contents ═══");
async function listBucket(prefix = "") {
  const { data, error } = await supabase.storage.from("library").list(prefix, {
    limit: 100,
    sortBy: { column: "name", order: "asc" },
  });
  if (error) {
    console.log(`  ERR pour "${prefix}":`, error.message);
    return;
  }
  for (const f of data || []) {
    if (f.id === null) {
      // folder
      console.log(`  📁 ${prefix}${f.name}/`);
      await listBucket(`${prefix}${f.name}/`);
    } else {
      const kb = f.metadata?.size ? (f.metadata.size / 1024).toFixed(0) : "?";
      console.log(`  📄 ${prefix}${f.name}  (${kb} Ko)`);
    }
  }
}
await listBucket();

console.log("\n═══ Test génération signed URL (1er doc) ═══");
if (docs?.[0]) {
  const { data: sig, error: sigErr } = await supabase.storage
    .from("library")
    .createSignedUrl(docs[0].storage_path, 60);
  if (sigErr) console.log("  ❌", sigErr.message);
  else if (sig?.signedUrl) console.log("  ✅ OK:", sig.signedUrl.slice(0, 100) + "...");
  else console.log("  ⚠ sig.signedUrl vide");
}
