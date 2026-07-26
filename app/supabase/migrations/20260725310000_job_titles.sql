-- ═════════════════════════════════════════════════════════
-- Postes (job_title) sur user_roles + filtrage docs bibliothèque
-- ═════════════════════════════════════════════════════════

-- Poste occupé par chaque user (2 valeurs Klary : conseiller ou telephoniste)
ALTER TABLE user_roles
  ADD COLUMN IF NOT EXISTS job_title TEXT
  CHECK (job_title IN ('conseiller', 'telephoniste') OR job_title IS NULL);

-- Postes cibles pour un document de bibliothèque
-- Vide '{}' = visible par TOUS les postes
-- Sinon = visible uniquement pour les postes listés
ALTER TABLE library_documents
  ADD COLUMN IF NOT EXISTS target_roles TEXT[] DEFAULT '{}';

CREATE INDEX IF NOT EXISTS idx_library_docs_target_roles
  ON library_documents USING gin(target_roles);
