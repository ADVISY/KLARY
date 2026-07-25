-- ═════════════════════════════════════════════════════════
-- Table candidate_events : historique des actions sur une candidature
--   • changement de statut
--   • ajout de notes
--   • envoi d'email
--   • création de créneau d'entretien
-- ═════════════════════════════════════════════════════════

CREATE TABLE IF NOT EXISTS candidate_events (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  candidate_id UUID NOT NULL REFERENCES candidates(id) ON DELETE CASCADE,
  event_type TEXT NOT NULL,               -- 'status_or_notes_updated', 'email_sent', 'interview_scheduled', ...
  actor_agent_id UUID REFERENCES auth.users(id),
  details JSONB,                          -- payload libre selon event_type
  created_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_candidate_events_candidate ON candidate_events(candidate_id);
CREATE INDEX IF NOT EXISTS idx_candidate_events_created ON candidate_events(created_at DESC);

ALTER TABLE candidate_events ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS admin_all_candidate_events ON candidate_events;
CREATE POLICY admin_all_candidate_events ON candidate_events
  FOR ALL USING (public.is_admin_or_manager());
