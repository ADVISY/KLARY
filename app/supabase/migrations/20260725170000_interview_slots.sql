-- ═════════════════════════════════════════════════════════
-- Système de prise de RDV entretien candidat
--   • Admin marque candidature = interview_1
--   • 3 créneaux générés automatiquement (J+1 à J+3 ouvrables)
--   • Email envoyé au candidat avec lien signé /entretien/{token}
--   • Candidat choisit → confirm email candidat + notif admin
-- ═════════════════════════════════════════════════════════

CREATE TABLE IF NOT EXISTS interview_slots (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  candidate_id UUID NOT NULL REFERENCES candidates(id) ON DELETE CASCADE,
  proposed_slots JSONB NOT NULL,             -- [{"start":"2026-07-26T10:00:00Z","duration_min":30}, ...]
  selection_token TEXT NOT NULL UNIQUE,      -- URL /entretien/{token}
  selected_slot_index INT,                   -- 0, 1 ou 2
  selected_at TIMESTAMPTZ,
  interview_notes TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  created_by UUID REFERENCES auth.users(id)
);

CREATE INDEX IF NOT EXISTS idx_interview_slots_candidate ON interview_slots(candidate_id);
CREATE INDEX IF NOT EXISTS idx_interview_slots_token ON interview_slots(selection_token);

ALTER TABLE interview_slots ENABLE ROW LEVEL SECURITY;

-- Admin/manager : accès complet
DROP POLICY IF EXISTS admin_all_interview_slots ON interview_slots;
CREATE POLICY admin_all_interview_slots ON interview_slots
  FOR ALL USING (public.is_admin_or_manager());

-- Public read via service_role uniquement (la route publique /api/entretien/select
-- passe par le service_role côté serveur, aucun accès direct client)
-- Pas de policy publique — protection par service_role + token secret.

-- Extension : ajouter statut 'active' à candidates (agent activé après FINMA + compagnies)
ALTER TABLE candidates DROP CONSTRAINT IF EXISTS candidates_status_check;
ALTER TABLE candidates
  ADD CONSTRAINT candidates_status_check
  CHECK (status IN (
    'new', 'reviewed', 'interview_1', 'interview_2',
    'test_ok', 'offered', 'hired', 'active',
    'rejected', 'archived'
  ));
