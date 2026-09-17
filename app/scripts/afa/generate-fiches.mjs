#!/usr/bin/env node
/**
 * Génère une migration SQL de seed pour les fiches AFA (cas d'oral) à partir
 * des fichiers JSON de src/content/afa/fiches/. Le JSON reste la source
 * éditable, on régénère le SQL après chaque modification.
 *
 *   node scripts/afa/generate-fiches.mjs > supabase/migrations/<ts>_afa_seed_fiches_cas.sql
 *
 * Chaque fichier JSON doit avoir la structure :
 *   {
 *     "fiches": [
 *       {
 *         "filiere_key": "vie",
 *         "theme_key": "garantie_revenus",
 *         "key": "cas_deces_couple_2enfants",
 *         "title": "...",
 *         "summary": "...",
 *         "content_md": "...",
 *         "sort_order": 10
 *       }
 *     ]
 *   }
 */
import { readFileSync, readdirSync, existsSync } from "node:fs";
import { join, dirname } from "node:path";
import { fileURLToPath } from "node:url";

const root = join(dirname(fileURLToPath(import.meta.url)), "..", "..");
const contentDir = join(root, "src", "content", "afa", "fiches");

if (!existsSync(contentDir)) {
  console.error(`Répertoire introuvable : ${contentDir}`);
  process.exit(1);
}

const q = (s) => (s == null ? "NULL" : `'${String(s).replace(/'/g, "''")}'`);

const files = readdirSync(contentDir).filter((f) => f.endsWith(".json"));
const out = [];

out.push("-- ═════════════════════════════════════════════════════════");
out.push("-- Klary — Seed fiches AFA (cas d'oral prévoyance)");
out.push("-- FICHIER GÉNÉRÉ — ne pas éditer à la main.");
out.push("-- Source : src/content/afa/fiches/*.json");
out.push("-- Régénérer : node scripts/afa/generate-fiches.mjs");
out.push("-- ═════════════════════════════════════════════════════════");
out.push("");

let count = 0;
for (const file of files) {
  const data = JSON.parse(readFileSync(join(contentDir, file), "utf8"));
  const { fiches = [] } = data;

  out.push(`-- ───────── ${file} — ${fiches.length} fiche(s) ─────────`);

  for (const f of fiches) {
    count++;
    out.push(`INSERT INTO afa_fiches
  (filiere_key, theme_id, key, title, summary, content_md, sort_order, active)
SELECT ${q(f.filiere_key)}, t.id, ${q(f.key)}, ${q(f.title)},
       ${q(f.summary)}, ${q(f.content_md)}, ${f.sort_order ?? 0}, TRUE
FROM afa_themes t
WHERE t.filiere_key = ${q(f.filiere_key)} AND t.key = ${q(f.theme_key)}
ON CONFLICT (key) DO UPDATE SET
  title = EXCLUDED.title,
  summary = EXCLUDED.summary,
  content_md = EXCLUDED.content_md,
  sort_order = EXCLUDED.sort_order,
  updated_at = NOW();`);
    out.push("");
  }
}

out.push(`-- ${count} fiche(s) traitée(s).`);
process.stdout.write(out.join("\n") + "\n");
