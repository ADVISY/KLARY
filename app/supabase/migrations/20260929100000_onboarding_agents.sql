-- Permettre de lancer un onboarding pour un COLLABORATEUR déjà en poste,
-- et pas seulement pour un candidat issu du recrutement.
--
-- Jusqu'ici onboarding_forms.candidate_id était obligatoire : un agent déjà
-- embauché ne pouvait donc pas remplir son dossier RH depuis l'application.
-- On ajoute user_id, on rend candidate_id facultatif, et on impose qu'au
-- moins l'un des deux soit renseigné.

ALTER TABLE onboarding_forms
  ADD COLUMN IF NOT EXISTS user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE;

ALTER TABLE onboarding_forms
  ALTER COLUMN candidate_id DROP NOT NULL;

ALTER TABLE onboarding_forms
  DROP CONSTRAINT IF EXISTS onboarding_forms_target_check;
ALTER TABLE onboarding_forms
  ADD CONSTRAINT onboarding_forms_target_check
  CHECK (candidate_id IS NOT NULL OR user_id IS NOT NULL);

CREATE INDEX IF NOT EXISTS idx_onboarding_forms_user ON onboarding_forms(user_id);

-- Un seul onboarding actif par collaborateur.
CREATE UNIQUE INDEX IF NOT EXISTS uniq_onboarding_forms_user
  ON onboarding_forms(user_id) WHERE user_id IS NOT NULL;

COMMENT ON COLUMN onboarding_forms.user_id IS
  'Collaborateur concerné, quand l''onboarding est lancé depuis la fiche agent plutôt que depuis une candidature.';

-- ───────── RLS : le collaborateur accède à son propre dossier ─────────

DROP POLICY IF EXISTS own_onboarding_select ON onboarding_forms;
CREATE POLICY own_onboarding_select ON onboarding_forms
  FOR SELECT
  USING (user_id = auth.uid());

DROP POLICY IF EXISTS own_onboarding_update ON onboarding_forms;
CREATE POLICY own_onboarding_update ON onboarding_forms
  FOR UPDATE
  USING (user_id = auth.uid() AND submitted_at IS NULL)
  WITH CHECK (user_id = auth.uid());
