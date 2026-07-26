-- ═════════════════════════════════════════════════════════
-- Historique des emails envoyés par le système
-- Chaque email transactionnel Resend est journalisé pour :
--   • traçabilité admin (voir historique complet par candidat)
--   • debug si un email n'est pas reçu
--   • preuve d'envoi en cas de litige
-- ═════════════════════════════════════════════════════════

CREATE TABLE IF NOT EXISTS email_events (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  candidate_id UUID REFERENCES candidates(id) ON DELETE CASCADE,
  user_id UUID REFERENCES auth.users(id) ON DELETE SET NULL,
  event_type TEXT NOT NULL,           -- 'candidature_confirmation', 'refus', 'invitation_entretien', ...
  recipient TEXT NOT NULL,             -- to (comma-separated si plusieurs)
  cc TEXT,                             -- cc (comma-separated)
  subject TEXT NOT NULL,
  resend_id TEXT,                      -- id Resend pour tracer côté fournisseur
  status TEXT DEFAULT 'sent',          -- 'sent' | 'failed' | 'skipped'
  error TEXT,                          -- message d'erreur si status = 'failed'
  sent_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_email_events_candidate ON email_events(candidate_id);
CREATE INDEX IF NOT EXISTS idx_email_events_user ON email_events(user_id);
CREATE INDEX IF NOT EXISTS idx_email_events_sent_at ON email_events(sent_at DESC);
CREATE INDEX IF NOT EXISTS idx_email_events_event_type ON email_events(event_type);

ALTER TABLE email_events ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS admin_all_email_events ON email_events;
CREATE POLICY admin_all_email_events ON email_events
  FOR ALL USING (public.is_admin_or_manager());

-- Un utilisateur peut voir ses propres events (utile si on veut afficher
-- côté agent son propre historique dans le futur)
DROP POLICY IF EXISTS user_read_own_email_events ON email_events;
CREATE POLICY user_read_own_email_events ON email_events
  FOR SELECT USING (auth.uid() = user_id);
