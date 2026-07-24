-- ═════════════════════════════════════════════════════════
-- Klary — Module Formation & Certification interne
-- Migration à appliquer sur le projet Supabase existant
--   project_id : ezhgsurhnyszhjixybak
-- ═════════════════════════════════════════════════════════
-- Ce module s'AJOUTE aux tables existantes du site principal.
-- Il utilise auth.users et profiles déjà en place.
-- ═════════════════════════════════════════════════════════

-- ─────────────────────────────────────────────────────────
-- Modules de formation (Maladie, LPP, Prévoyance, Hypothèque)
-- ─────────────────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS training_modules (
  key TEXT PRIMARY KEY,                       -- ex : 'maladie'
  title TEXT NOT NULL,
  description TEXT,
  duration_min INT NOT NULL DEFAULT 45,
  passing_score INT NOT NULL DEFAULT 80,
  active BOOLEAN DEFAULT TRUE,
  version INT DEFAULT 1,                      -- pour tracer les révisions de contenu
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

COMMENT ON TABLE training_modules IS 'Modules de certification interne Klary';

-- ─────────────────────────────────────────────────────────
-- Questions par module
-- ─────────────────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS training_questions (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  module_key TEXT NOT NULL REFERENCES training_modules(key) ON DELETE CASCADE,
  external_id TEXT,                           -- ex : 'M001'
  category TEXT NOT NULL,
  question_type TEXT NOT NULL DEFAULT 'single'
    CHECK (question_type IN ('single', 'multiple', 'vrai_faux')),
  question TEXT NOT NULL,
  options JSONB NOT NULL,                     -- tableau de strings
  correct INT NOT NULL,                       -- index bonne réponse (0-based)
  explanation TEXT,
  weight INT DEFAULT 1,                       -- pondération pour scoring futur
  active BOOLEAN DEFAULT TRUE,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE INDEX idx_training_questions_module ON training_questions(module_key);
CREATE INDEX idx_training_questions_active ON training_questions(active);

-- ─────────────────────────────────────────────────────────
-- Tentatives d'évaluation
-- ─────────────────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS training_attempts (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  module_key TEXT NOT NULL REFERENCES training_modules(key),
  started_at TIMESTAMPTZ DEFAULT NOW(),
  finished_at TIMESTAMPTZ,
  score_pct INT,
  passed BOOLEAN,
  cheat_count INT DEFAULT 0,
  aborted BOOLEAN DEFAULT FALSE,
  abort_reason TEXT,                          -- 'cheat', 'timeout', 'user_quit', etc.
  raw_answers JSONB,                          -- {"question_id": chosen_index, ...}
  time_used_sec INT,
  user_agent TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE INDEX idx_training_attempts_user ON training_attempts(user_id);
CREATE INDEX idx_training_attempts_module ON training_attempts(module_key);
CREATE INDEX idx_training_attempts_started ON training_attempts(started_at DESC);

-- ─────────────────────────────────────────────────────────
-- Certifications délivrées
-- ─────────────────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS training_certifications (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  cert_number TEXT NOT NULL UNIQUE,           -- ex : 'KLA-260724-A3F2'
  user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  module_key TEXT NOT NULL REFERENCES training_modules(key),
  attempt_id UUID REFERENCES training_attempts(id),
  issued_at TIMESTAMPTZ DEFAULT NOW(),
  valid_until DATE NOT NULL,                  -- issued_at + 6 mois par défaut
  score_pct INT NOT NULL,
  pdf_storage_path TEXT,                      -- chemin dans bucket 'training-certificates'
  email_sent_at TIMESTAMPTZ,
  revoked BOOLEAN DEFAULT FALSE,
  revoked_at TIMESTAMPTZ,
  revoked_reason TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE INDEX idx_training_certif_user ON training_certifications(user_id);
CREATE INDEX idx_training_certif_valid ON training_certifications(valid_until);
CREATE INDEX idx_training_certif_number ON training_certifications(cert_number);

-- ─────────────────────────────────────────────────────────
-- Triggers updated_at
-- ─────────────────────────────────────────────────────────
CREATE OR REPLACE FUNCTION training_set_updated_at()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trg_training_modules_updated_at ON training_modules;
CREATE TRIGGER trg_training_modules_updated_at BEFORE UPDATE ON training_modules
  FOR EACH ROW EXECUTE FUNCTION training_set_updated_at();

DROP TRIGGER IF EXISTS trg_training_questions_updated_at ON training_questions;
CREATE TRIGGER trg_training_questions_updated_at BEFORE UPDATE ON training_questions
  FOR EACH ROW EXECUTE FUNCTION training_set_updated_at();

-- ─────────────────────────────────────────────────────────
-- ROW-LEVEL SECURITY (RLS)
-- ─────────────────────────────────────────────────────────
ALTER TABLE training_modules ENABLE ROW LEVEL SECURITY;
ALTER TABLE training_questions ENABLE ROW LEVEL SECURITY;
ALTER TABLE training_attempts ENABLE ROW LEVEL SECURITY;
ALTER TABLE training_certifications ENABLE ROW LEVEL SECURITY;

-- Modules actifs lisibles par tout utilisateur authentifié
CREATE POLICY authenticated_read_training_modules ON training_modules
  FOR SELECT USING (auth.role() = 'authenticated' AND active = TRUE);

-- Questions actives lisibles par tout utilisateur authentifié
-- (Mais la 'correct' ne doit jamais être exposée côté client — voir API/Edge Function)
CREATE POLICY authenticated_read_training_questions ON training_questions
  FOR SELECT USING (auth.role() = 'authenticated' AND active = TRUE);

-- Un utilisateur voit uniquement SES tentatives
CREATE POLICY user_read_own_attempts ON training_attempts
  FOR SELECT USING (auth.uid() = user_id);

CREATE POLICY user_insert_own_attempts ON training_attempts
  FOR INSERT WITH CHECK (auth.uid() = user_id);

CREATE POLICY user_update_own_attempts ON training_attempts
  FOR UPDATE USING (auth.uid() = user_id);

-- Un utilisateur voit uniquement SES certifications
CREATE POLICY user_read_own_certifications ON training_certifications
  FOR SELECT USING (auth.uid() = user_id);

-- Admins (via profiles.role si présent, sinon user_roles) — accès complet
-- ⚠ À adapter selon le modèle admin existant du site principal
CREATE POLICY admin_all_training_modules ON training_modules
  FOR ALL USING (
    EXISTS (SELECT 1 FROM user_roles WHERE user_id = auth.uid() AND role IN ('admin', 'manager'))
  );

CREATE POLICY admin_all_training_questions ON training_questions
  FOR ALL USING (
    EXISTS (SELECT 1 FROM user_roles WHERE user_id = auth.uid() AND role IN ('admin', 'manager'))
  );

CREATE POLICY admin_all_training_attempts ON training_attempts
  FOR SELECT USING (
    EXISTS (SELECT 1 FROM user_roles WHERE user_id = auth.uid() AND role IN ('admin', 'manager'))
  );

CREATE POLICY admin_all_training_certifications ON training_certifications
  FOR ALL USING (
    EXISTS (SELECT 1 FROM user_roles WHERE user_id = auth.uid() AND role IN ('admin', 'manager'))
  );

-- ─────────────────────────────────────────────────────────
-- STORAGE BUCKET (à créer manuellement via Supabase Dashboard)
-- ─────────────────────────────────────────────────────────
-- Bucket 'training-certificates' → PRIVÉ · signed URLs uniquement

-- ─────────────────────────────────────────────────────────
-- DONNÉES INITIALES — 4 modules
-- ─────────────────────────────────────────────────────────
INSERT INTO training_modules (key, title, description, duration_min, passing_score) VALUES
  ('maladie',    'Assurance Maladie (LAMal + LCA)', 'Certification agent Klary sur les assurances maladie de base et complémentaires', 45, 80),
  ('lpp',        'LPP Libre Passage',                'Certification agent Klary sur les fonds de libre passage', 30, 80),
  ('prevoyance', 'Prévoyance vie & 3e pilier',       'Certification agent Klary sur 3a, 3b et assurance-vie', 45, 80),
  ('hypotheque', 'Hypothèque',                       'Certification agent Klary sur les financements immobiliers', 30, 80)
ON CONFLICT (key) DO NOTHING;

-- ═════════════════════════════════════════════════════════
-- FIN MIGRATION training_module
-- ═════════════════════════════════════════════════════════
