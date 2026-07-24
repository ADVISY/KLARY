-- ═════════════════════════════════════════════════════════
-- Klary — Migration initiale
-- Projet Supabase : ezhgsurhnyszhjixybak
-- ═════════════════════════════════════════════════════════

-- ───────── FONCTIONS UTILITAIRES ─────────
CREATE OR REPLACE FUNCTION set_updated_at()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- ───────── USER ROLES (admin/agent/manager) ─────────
CREATE TABLE IF NOT EXISTS user_roles (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  role TEXT NOT NULL CHECK (role IN ('agent', 'manager', 'admin')),
  first_name TEXT,
  last_name TEXT,
  active BOOLEAN DEFAULT TRUE,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW(),
  UNIQUE (user_id, role)
);

CREATE INDEX idx_user_roles_user_id ON user_roles(user_id);

CREATE TRIGGER trg_user_roles_updated_at BEFORE UPDATE ON user_roles
  FOR EACH ROW EXECUTE FUNCTION set_updated_at();

-- ───────── CONTACT MESSAGES (formulaire site public) ─────────
CREATE TABLE IF NOT EXISTS contact_messages (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  first_name TEXT NOT NULL,
  last_name TEXT NOT NULL,
  email TEXT NOT NULL,
  phone TEXT,
  subject TEXT NOT NULL CHECK (subject IN (
    'demande_information',
    'demande_devis',
    'assurance_maladie',
    'prevoyance',
    'lpp_libre_passage',
    'hypotheque',
    'autre'
  )),
  message TEXT NOT NULL,
  status TEXT NOT NULL DEFAULT 'new'
    CHECK (status IN ('new', 'in_progress', 'answered', 'converted_lead', 'closed', 'spam')),
  assigned_to UUID REFERENCES auth.users(id),
  user_agent TEXT,
  ip_hash TEXT,
  consent_given_at TIMESTAMPTZ NOT NULL,
  scheduled_delete_at TIMESTAMPTZ NOT NULL,
  internal_notes TEXT,
  responded_at TIMESTAMPTZ,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE INDEX idx_contact_status ON contact_messages(status);
CREATE INDEX idx_contact_created ON contact_messages(created_at DESC);

CREATE TRIGGER trg_contact_updated_at BEFORE UPDATE ON contact_messages
  FOR EACH ROW EXECUTE FUNCTION set_updated_at();

-- ───────── CANDIDATURES (formulaire recrutement) ─────────
CREATE TABLE IF NOT EXISTS candidates (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  first_name TEXT NOT NULL,
  last_name TEXT NOT NULL,
  email TEXT NOT NULL,
  phone TEXT,
  position_applied TEXT,
  cover_letter TEXT,
  cv_storage_path TEXT,
  status TEXT NOT NULL DEFAULT 'new'
    CHECK (status IN ('new', 'reviewed', 'interview_1', 'interview_2', 'test_ok', 'offered', 'hired', 'rejected', 'archived')),
  source TEXT,
  consent_given_at TIMESTAMPTZ NOT NULL,
  scheduled_delete_at TIMESTAMPTZ NOT NULL,
  internal_notes TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE INDEX idx_candidates_status ON candidates(status);
CREATE INDEX idx_candidates_email ON candidates(email);

CREATE TRIGGER trg_candidates_updated_at BEFORE UPDATE ON candidates
  FOR EACH ROW EXECUTE FUNCTION set_updated_at();

-- ───────── MODULES DE FORMATION ─────────
CREATE TABLE IF NOT EXISTS training_modules (
  key TEXT PRIMARY KEY,
  title TEXT NOT NULL,
  description TEXT,
  duration_min INT NOT NULL DEFAULT 45,
  passing_score INT NOT NULL DEFAULT 80,
  active BOOLEAN DEFAULT TRUE,
  version INT DEFAULT 1,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE TRIGGER trg_training_modules_updated_at BEFORE UPDATE ON training_modules
  FOR EACH ROW EXECUTE FUNCTION set_updated_at();

-- ───────── QUESTIONS ─────────
CREATE TABLE IF NOT EXISTS training_questions (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  module_key TEXT NOT NULL REFERENCES training_modules(key) ON DELETE CASCADE,
  external_id TEXT,
  category TEXT NOT NULL,
  question_type TEXT NOT NULL DEFAULT 'single'
    CHECK (question_type IN ('single', 'multiple', 'vrai_faux')),
  question TEXT NOT NULL,
  options JSONB NOT NULL,
  correct INT NOT NULL,
  explanation TEXT,
  weight INT DEFAULT 1,
  active BOOLEAN DEFAULT TRUE,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE INDEX idx_training_questions_module ON training_questions(module_key);

CREATE TRIGGER trg_training_questions_updated_at BEFORE UPDATE ON training_questions
  FOR EACH ROW EXECUTE FUNCTION set_updated_at();

-- ───────── TENTATIVES ─────────
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
  abort_reason TEXT,
  raw_answers JSONB,
  time_used_sec INT,
  user_agent TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE INDEX idx_training_attempts_user ON training_attempts(user_id);

-- ───────── CERTIFICATIONS ─────────
CREATE TABLE IF NOT EXISTS training_certifications (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  cert_number TEXT NOT NULL UNIQUE,
  user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  module_key TEXT NOT NULL REFERENCES training_modules(key),
  attempt_id UUID REFERENCES training_attempts(id),
  issued_at TIMESTAMPTZ DEFAULT NOW(),
  valid_until DATE NOT NULL,
  score_pct INT NOT NULL,
  pdf_storage_path TEXT,
  email_sent_at TIMESTAMPTZ,
  revoked BOOLEAN DEFAULT FALSE,
  revoked_at TIMESTAMPTZ,
  revoked_reason TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE INDEX idx_training_certif_user ON training_certifications(user_id);

-- ───────── ROW LEVEL SECURITY ─────────
ALTER TABLE user_roles ENABLE ROW LEVEL SECURITY;
ALTER TABLE contact_messages ENABLE ROW LEVEL SECURITY;
ALTER TABLE candidates ENABLE ROW LEVEL SECURITY;
ALTER TABLE training_modules ENABLE ROW LEVEL SECURITY;
ALTER TABLE training_questions ENABLE ROW LEVEL SECURITY;
ALTER TABLE training_attempts ENABLE ROW LEVEL SECURITY;
ALTER TABLE training_certifications ENABLE ROW LEVEL SECURITY;

-- Publique : insertion contact et candidature (protégé par validation côté API)
CREATE POLICY public_insert_contact ON contact_messages
  FOR INSERT WITH CHECK (TRUE);

CREATE POLICY public_insert_candidate ON candidates
  FOR INSERT WITH CHECK (TRUE);

-- Utilisateur authentifié : lit ses propres tentatives/certifs
CREATE POLICY user_read_own_attempts ON training_attempts
  FOR SELECT USING (auth.uid() = user_id);
CREATE POLICY user_insert_own_attempts ON training_attempts
  FOR INSERT WITH CHECK (auth.uid() = user_id);
CREATE POLICY user_update_own_attempts ON training_attempts
  FOR UPDATE USING (auth.uid() = user_id);
CREATE POLICY user_read_own_certifications ON training_certifications
  FOR SELECT USING (auth.uid() = user_id);

-- Utilisateur authentifié : lit modules et questions actifs
CREATE POLICY authenticated_read_modules ON training_modules
  FOR SELECT USING (auth.role() = 'authenticated' AND active = TRUE);
CREATE POLICY authenticated_read_questions ON training_questions
  FOR SELECT USING (auth.role() = 'authenticated' AND active = TRUE);

-- Admin/Manager : accès complet
CREATE POLICY admin_all_user_roles ON user_roles
  FOR ALL USING (
    EXISTS (SELECT 1 FROM user_roles r WHERE r.user_id = auth.uid() AND r.role IN ('admin', 'manager') AND r.active)
  );
CREATE POLICY admin_all_contact ON contact_messages
  FOR ALL USING (
    EXISTS (SELECT 1 FROM user_roles r WHERE r.user_id = auth.uid() AND r.role IN ('admin', 'manager') AND r.active)
  );
CREATE POLICY admin_all_candidates ON candidates
  FOR ALL USING (
    EXISTS (SELECT 1 FROM user_roles r WHERE r.user_id = auth.uid() AND r.role IN ('admin', 'manager') AND r.active)
  );
CREATE POLICY admin_all_modules ON training_modules
  FOR ALL USING (
    EXISTS (SELECT 1 FROM user_roles r WHERE r.user_id = auth.uid() AND r.role IN ('admin', 'manager') AND r.active)
  );
CREATE POLICY admin_all_questions ON training_questions
  FOR ALL USING (
    EXISTS (SELECT 1 FROM user_roles r WHERE r.user_id = auth.uid() AND r.role IN ('admin', 'manager') AND r.active)
  );
CREATE POLICY admin_all_attempts ON training_attempts
  FOR SELECT USING (
    EXISTS (SELECT 1 FROM user_roles r WHERE r.user_id = auth.uid() AND r.role IN ('admin', 'manager') AND r.active)
  );
CREATE POLICY admin_all_certifications ON training_certifications
  FOR ALL USING (
    EXISTS (SELECT 1 FROM user_roles r WHERE r.user_id = auth.uid() AND r.role IN ('admin', 'manager') AND r.active)
  );

-- Utilisateur lit son propre rôle
CREATE POLICY user_read_own_role ON user_roles
  FOR SELECT USING (auth.uid() = user_id);

-- ───────── DONNÉES INITIALES ─────────
INSERT INTO training_modules (key, title, description, duration_min, passing_score) VALUES
  ('maladie',    'Assurance Maladie (LAMal + LCA)', 'Certification agent Klary sur les assurances maladie de base et complémentaires', 45, 80),
  ('lpp',        'LPP Libre Passage',                'Certification agent Klary sur les fonds de libre passage', 30, 80),
  ('prevoyance', 'Prévoyance vie & 3e pilier',       'Certification agent Klary sur 3a, 3b et assurance-vie', 45, 80),
  ('hypotheque', 'Hypothèque',                       'Certification agent Klary sur les financements immobiliers', 30, 80)
ON CONFLICT (key) DO NOTHING;
