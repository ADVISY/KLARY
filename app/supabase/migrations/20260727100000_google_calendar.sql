-- ═════════════════════════════════════════════════════════
-- Google Calendar OAuth — stockage token unique + tracking events entretiens
-- ═════════════════════════════════════════════════════════

-- Table pour stocker le refresh token Google Calendar (un seul, connecté par admin)
CREATE TABLE IF NOT EXISTS google_oauth_tokens (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  provider TEXT NOT NULL DEFAULT 'google' UNIQUE,
  scope TEXT NOT NULL,
  access_token TEXT NOT NULL,
  refresh_token TEXT NOT NULL,
  expires_at TIMESTAMPTZ NOT NULL,
  authorized_email TEXT NOT NULL,
  connected_by UUID REFERENCES auth.users(id) ON DELETE SET NULL,
  connected_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

ALTER TABLE google_oauth_tokens ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS admin_all_google_oauth ON google_oauth_tokens;
CREATE POLICY admin_all_google_oauth ON google_oauth_tokens
  FOR ALL USING (public.is_admin_or_manager());

-- Track l'event Google Calendar créé pour chaque entretien
-- (pour pouvoir le mettre à jour / supprimer en cas de reprogrammation)
ALTER TABLE interview_slots
  ADD COLUMN IF NOT EXISTS google_event_id TEXT;

CREATE INDEX IF NOT EXISTS idx_interview_slots_google_event
  ON interview_slots(google_event_id)
  WHERE google_event_id IS NOT NULL;

NOTIFY pgrst, 'reload schema';
