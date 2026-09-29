-- Ciblage des modules de formation par rôle.
-- Même convention que library_documents.target_roles :
--   NULL ou tableau vide  → module visible par tout le monde
--   ARRAY['backoffice']   → module réservé à ce rôle (admin et manager voient tout)

ALTER TABLE training_modules
  ADD COLUMN IF NOT EXISTS target_roles TEXT[];

COMMENT ON COLUMN training_modules.target_roles IS
  'Rôles autorisés à voir ce module. NULL ou [] = visible par tous. admin et manager voient tout dans tous les cas.';

-- Les modules existants restent visibles par tous.
UPDATE training_modules SET target_roles = NULL WHERE target_roles IS NULL;
