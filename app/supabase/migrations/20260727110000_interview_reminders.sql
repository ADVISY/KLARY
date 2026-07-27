-- ═════════════════════════════════════════════════════════
-- Rappels entretiens J-1 — colonne pour tracker envoi rappel
-- ═════════════════════════════════════════════════════════

ALTER TABLE interview_slots
  ADD COLUMN IF NOT EXISTS reminder_sent_at TIMESTAMPTZ;

-- Index pour requête cron rapide (entretiens confirmés sans rappel envoyé)
CREATE INDEX IF NOT EXISTS idx_interview_slots_pending_reminder
  ON interview_slots(selected_at, reminder_sent_at)
  WHERE selected_at IS NOT NULL AND reminder_sent_at IS NULL;

NOTIFY pgrst, 'reload schema';
