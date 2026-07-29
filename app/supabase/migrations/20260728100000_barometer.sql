-- ═════════════════════════════════════════════════════════
-- Baromètre équipe mensuel — 7 questions anonymes
-- ═════════════════════════════════════════════════════════

-- Table 1 : invitations (nominatives — pour tracker qui a répondu, envoyer rappel)
--            AUCUN lien avec le contenu des réponses.
CREATE TABLE IF NOT EXISTS barometer_invites (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  period_month TEXT NOT NULL, -- ex: "2026-08"
  token UUID NOT NULL UNIQUE DEFAULT gen_random_uuid(),
  invited_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  reminder_sent_at TIMESTAMPTZ,
  responded_at TIMESTAMPTZ,
  expires_at TIMESTAMPTZ NOT NULL DEFAULT (NOW() + INTERVAL '10 days'),
  UNIQUE (user_id, period_month)
);

CREATE INDEX IF NOT EXISTS idx_barometer_invites_token
  ON barometer_invites(token) WHERE responded_at IS NULL;
CREATE INDEX IF NOT EXISTS idx_barometer_invites_pending
  ON barometer_invites(period_month, responded_at, reminder_sent_at)
  WHERE responded_at IS NULL;

-- Table 2 : réponses ANONYMES (aucun user_id — impossible de lier à un agent)
CREATE TABLE IF NOT EXISTS barometer_responses (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  period_month TEXT NOT NULL, -- ex: "2026-08"
  q1_enps INT NOT NULL CHECK (q1_enps BETWEEN 1 AND 10),
  q2_charge TEXT NOT NULL CHECK (q2_charge IN ('tres_faible','faible','equilibree','lourde','tres_lourde')),
  q3_ambiance INT NOT NULL CHECK (q3_ambiance BETWEEN 1 AND 10),
  q4_manager INT NOT NULL CHECK (q4_manager BETWEEN 1 AND 10),
  q6_motivation INT NOT NULL CHECK (q6_motivation BETWEEN 1 AND 10),
  q5_improve TEXT,
  q7_continue TEXT,
  submitted_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_barometer_responses_period
  ON barometer_responses(period_month);

ALTER TABLE barometer_invites ENABLE ROW LEVEL SECURITY;
ALTER TABLE barometer_responses ENABLE ROW LEVEL SECURITY;

-- Admin/manager lecture seule (via service_role de toute façon)
DROP POLICY IF EXISTS admin_read_invites ON barometer_invites;
CREATE POLICY admin_read_invites ON barometer_invites
  FOR SELECT USING (public.is_admin_or_manager());

DROP POLICY IF EXISTS admin_read_responses ON barometer_responses;
CREATE POLICY admin_read_responses ON barometer_responses
  FOR SELECT USING (public.is_admin_or_manager());

NOTIFY pgrst, 'reload schema';
