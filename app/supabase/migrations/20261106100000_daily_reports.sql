-- ═════════════════════════════════════════════════════════
-- Rapport du soir : un rapport par personne et par jour.
--   • Chacun écrit le sien et peut le corriger jusqu'à minuit (heure suisse).
--   • Après minuit, la journée est figée : plus de création ni de modification.
--   • Lecture : la direction (admin) voit tout, le responsable (manager) voit
--     les conseillers et le back-office en plus du sien.
-- ═════════════════════════════════════════════════════════

CREATE TABLE IF NOT EXISTS daily_reports (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  report_date DATE NOT NULL,
  role TEXT NOT NULL CHECK (role IN ('admin', 'manager', 'agent', 'backoffice')),
  metrics JSONB NOT NULL DEFAULT '{}'::jsonb,
  summary TEXT NOT NULL,
  problem TEXT,
  solution TEXT,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  UNIQUE (user_id, report_date)
);

CREATE INDEX IF NOT EXISTS idx_daily_reports_date ON daily_reports(report_date);

DROP TRIGGER IF EXISTS trg_daily_reports_updated_at ON daily_reports;
CREATE TRIGGER trg_daily_reports_updated_at BEFORE UPDATE ON daily_reports
  FOR EACH ROW EXECUTE FUNCTION set_updated_at();

ALTER TABLE daily_reports ENABLE ROW LEVEL SECURITY;

-- Chacun lit ses propres rapports, sans limite de date
DROP POLICY IF EXISTS daily_reports_read_own ON daily_reports;
CREATE POLICY daily_reports_read_own ON daily_reports
  FOR SELECT USING (user_id = auth.uid());

-- On n'écrit que pour soi, que pour la journée en cours à Zurich,
-- et qu'avec un rôle que l'on détient réellement
DROP POLICY IF EXISTS daily_reports_insert_own ON daily_reports;
CREATE POLICY daily_reports_insert_own ON daily_reports
  FOR INSERT WITH CHECK (
    user_id = auth.uid()
    AND report_date = (now() AT TIME ZONE 'Europe/Zurich')::date
    AND EXISTS (
      SELECT 1 FROM user_roles
      WHERE user_roles.user_id = auth.uid()
        AND user_roles.role = daily_reports.role
        AND user_roles.active = true
    )
  );

-- La correction reste ouverte jusqu'à minuit, heure suisse
DROP POLICY IF EXISTS daily_reports_update_own ON daily_reports;
CREATE POLICY daily_reports_update_own ON daily_reports
  FOR UPDATE
  USING (
    user_id = auth.uid()
    AND report_date = (now() AT TIME ZONE 'Europe/Zurich')::date
  )
  WITH CHECK (
    user_id = auth.uid()
    AND report_date = (now() AT TIME ZONE 'Europe/Zurich')::date
    AND EXISTS (
      SELECT 1 FROM user_roles
      WHERE user_roles.user_id = auth.uid()
        AND user_roles.role = daily_reports.role
        AND user_roles.active = true
    )
  );

-- La direction voit tous les rapports
DROP POLICY IF EXISTS daily_reports_read_admin ON daily_reports;
CREATE POLICY daily_reports_read_admin ON daily_reports
  FOR SELECT USING (
    EXISTS (
      SELECT 1 FROM user_roles
      WHERE user_roles.user_id = auth.uid()
        AND user_roles.role = 'admin'
        AND user_roles.active = true
    )
  );

-- Le responsable suit son équipe : conseillers et back-office
DROP POLICY IF EXISTS daily_reports_read_manager ON daily_reports;
CREATE POLICY daily_reports_read_manager ON daily_reports
  FOR SELECT USING (
    daily_reports.role IN ('agent', 'backoffice')
    AND public.is_admin_or_manager()
  );

COMMENT ON TABLE daily_reports IS
  'Rapport de fin de journée, un par personne et par jour. Modifiable jusqu''à minuit (Europe/Zurich), figé ensuite par les policies RLS.';
