-- ═════════════════════════════════════════════════════════
-- Enrichissement questions : feedback pédagogique renforcé
--   • why_wrong[]   → raison précise pour chaque option fausse
--   • consequence   → impact réel si l'agent commet l'erreur en clientèle
-- + cooldown retry sur modules (défaut 24h après échec)
-- ═════════════════════════════════════════════════════════

ALTER TABLE training_questions
  ADD COLUMN IF NOT EXISTS why_wrong JSONB,        -- array indexé sur options (null pour la bonne)
  ADD COLUMN IF NOT EXISTS consequence TEXT;       -- impact business/légal de l'erreur

ALTER TABLE training_modules
  ADD COLUMN IF NOT EXISTS retry_cooldown_hours INT DEFAULT 24 NOT NULL;

-- Extension du type question pour supporter case_study et numerical (même stockage,
-- juste métadonnée pour l'UI). On drop puis recreate le CHECK.
ALTER TABLE training_questions DROP CONSTRAINT IF EXISTS training_questions_question_type_check;
ALTER TABLE training_questions
  ADD CONSTRAINT training_questions_question_type_check
  CHECK (question_type IN ('single', 'multiple', 'vrai_faux', 'numerical', 'case_study'));
