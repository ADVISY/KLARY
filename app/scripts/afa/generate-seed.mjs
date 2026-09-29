#!/usr/bin/env node
/**
 * Génère la migration SQL de seed des questions AFA à partir des fichiers
 * JSON de src/content/afa/. Le JSON reste la source de vérité éditable ;
 * on régénère le SQL après chaque modification.
 *
 *   node scripts/afa/generate-seed.mjs > supabase/migrations/<ts>_afa_seed_questions.sql
 */
import { readFileSync, readdirSync } from "node:fs";
import { join, dirname } from "node:path";
import { fileURLToPath } from "node:url";

const root = join(dirname(fileURLToPath(import.meta.url)), "..", "..");
const contentDir = join(root, "src", "content", "afa");

/** Échappe une chaîne pour un littéral SQL. */
const q = (s) => (s == null ? "NULL" : `'${String(s).replace(/'/g, "''")}'`);
/** Échappe un objet pour un littéral JSONB. */
const j = (o) => `'${JSON.stringify(o).replace(/'/g, "''")}'::jsonb`;

const files = readdirSync(contentDir).filter((f) => f.endsWith(".json"));
const out = [];

out.push("-- ═════════════════════════════════════════════════════════");
out.push("-- Klary — Seed des questions AFA");
out.push("-- FICHIER GÉNÉRÉ — ne pas éditer à la main.");
out.push("-- Source : src/content/afa/*.json");
out.push("-- Régénérer : node scripts/afa/generate-seed.mjs");
out.push("-- ═════════════════════════════════════════════════════════");
out.push("");

let count = 0;
for (const file of files) {
  const data = JSON.parse(readFileSync(join(contentDir, file), "utf8"));
  const { source, filiere_key, questions = [] } = data;

  out.push(`-- ───────── ${file} — ${data.reference ?? ""} ─────────`);

  for (const qn of questions) {
    count++;
    // Insertion de la question, thème résolu par sous-requête
    out.push(`INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT ${q(qn.external_id)}, ${q(filiere_key)}, t.id, ${q(qn.type)},
       ${q(qn.context)}, ${q(qn.question)}, ${j(qn.options)}, ${qn.points},
       ${q(qn.explanation)}, ${q(source)}, TRUE
FROM afa_themes t
WHERE t.filiere_key = ${q(filiere_key)} AND t.key = ${q(qn.theme)}
ON CONFLICT (external_id) DO NOTHING;`);

    // Liaisons notions
    for (const notion of qn.notions ?? []) {
      out.push(`INSERT INTO afa_question_notions (question_id, notion_id)
SELECT qu.id, n.id FROM afa_questions qu, afa_notions n
WHERE qu.external_id = ${q(qn.external_id)} AND n.key = ${q(notion)}
ON CONFLICT DO NOTHING;`);
    }
    out.push("");
  }

  // Les questions en attente sont insérées inactives, pour garder la trace
  for (const qn of data.questions_en_attente_de_validation ?? []) {
    count++;
    out.push(`-- EN ATTENTE DE VALIDATION : ${qn.raison_mise_en_attente ?? ""}`);
    out.push(`INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT ${q(qn.external_id)}, ${q(filiere_key)}, t.id, ${q(qn.type)},
       ${q(qn.context)}, ${q(qn.question)}, ${j(qn.options)}, ${qn.points},
       ${q(qn.raison_mise_en_attente)}, ${q(source)}, FALSE
FROM afa_themes t
WHERE t.filiere_key = ${q(filiere_key)} AND t.key = ${q(qn.theme)}
ON CONFLICT (external_id) DO NOTHING;`);
    out.push("");
  }
}

out.push(`-- ${count} question(s) traitée(s).`);
process.stdout.write(out.join("\n") + "\n");
