-- ═════════════════════════════════════════════════════════
-- Formulaires d'onboarding candidat → employé Klary
--   • Généré quand la candidature passe en statut 'hired'
--   • Lien signé /onboarding/{token} envoyé au candidat par email
--   • Candidat remplit : identité, adresse, banque, fiscalité, prévoyance
--   • Docs uploadés : ID, AVS, RIB, permis séjour, certif sortie LPP
--   • Soumission → email récap au comptable + notification admin
-- ═════════════════════════════════════════════════════════

CREATE TABLE IF NOT EXISTS onboarding_forms (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  candidate_id UUID NOT NULL REFERENCES candidates(id) ON DELETE CASCADE,
  form_token TEXT NOT NULL UNIQUE,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  created_by UUID REFERENCES auth.users(id),
  submitted_at TIMESTAMPTZ,
  form_data JSONB,                 -- identité + adresse + banque + fiscalité + prévoyance
  uploaded_docs JSONB DEFAULT '[]', -- [{key,filename,storage_path,size_bytes}]
  comptable_notified_at TIMESTAMPTZ
);

CREATE INDEX IF NOT EXISTS idx_onboarding_forms_candidate ON onboarding_forms(candidate_id);
CREATE INDEX IF NOT EXISTS idx_onboarding_forms_token ON onboarding_forms(form_token);

ALTER TABLE onboarding_forms ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS admin_all_onboarding_forms ON onboarding_forms;
CREATE POLICY admin_all_onboarding_forms ON onboarding_forms
  FOR ALL USING (public.is_admin_or_manager());

-- Accès public via token = géré par service_role côté API,
-- pas de policy publique nécessaire.
