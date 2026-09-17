-- ═════════════════════════════════════════════════════════
-- Klary — Module RÉVISION AFA (VBV)
--
-- Distinct du module `training_*` qui reste la CERTIFICATION
-- commerciale Klary (one-shot, anti-triche, cooldown, certificat).
-- Ici : entraînement répété, scoring partiel VBV, suivi des notions.
--
-- Filières officielles VBV (profil de qualification art. 190 OS) :
--   toutes_branches · non_vie · vie · maladie_complementaire
-- ═════════════════════════════════════════════════════════

-- ───────── FILIÈRES ─────────
CREATE TABLE IF NOT EXISTS afa_filieres (
  key         TEXT PRIMARY KEY,
  title       TEXT NOT NULL,
  description TEXT,
  -- Barème officiel VBV : 60 % des points (art. 3.73 / 8.11)
  passing_pct INT  NOT NULL DEFAULT 60,
  -- Durée de l'épreuve en minutes (art. 5.242 d)
  duration_min INT NOT NULL DEFAULT 30,
  sort_order  INT  NOT NULL DEFAULT 0,
  active      BOOLEAN NOT NULL DEFAULT TRUE,
  created_at  TIMESTAMPTZ DEFAULT NOW(),
  updated_at  TIMESTAMPTZ DEFAULT NOW()
);

DROP TRIGGER IF EXISTS trg_afa_filieres_updated_at ON afa_filieres;
CREATE TRIGGER trg_afa_filieres_updated_at BEFORE UPDATE ON afa_filieres
  FOR EACH ROW EXECUTE FUNCTION set_updated_at();

-- ───────── THÈMES (par filière) ─────────
CREATE TABLE IF NOT EXISTS afa_themes (
  id          UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  filiere_key TEXT NOT NULL REFERENCES afa_filieres(key) ON DELETE CASCADE,
  key         TEXT NOT NULL,
  title       TEXT NOT NULL,
  description TEXT,
  sort_order  INT NOT NULL DEFAULT 0,
  active      BOOLEAN NOT NULL DEFAULT TRUE,
  created_at  TIMESTAMPTZ DEFAULT NOW(),
  updated_at  TIMESTAMPTZ DEFAULT NOW(),
  UNIQUE (filiere_key, key)
);

CREATE INDEX idx_afa_themes_filiere ON afa_themes(filiere_key);

DROP TRIGGER IF EXISTS trg_afa_themes_updated_at ON afa_themes;
CREATE TRIGGER trg_afa_themes_updated_at BEFORE UPDATE ON afa_themes
  FOR EACH ROW EXECUTE FUNCTION set_updated_at();

-- ───────── NOTIONS (granularité fine du suivi de faiblesse) ─────────
-- Une question porte sur 1..n notions. C'est la notion, pas le thème,
-- qui pilote la remédiation ("chômeurs AC art. 22a LACI", "plafond quote-part"...).
CREATE TABLE IF NOT EXISTS afa_notions (
  id         UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  theme_id   UUID NOT NULL REFERENCES afa_themes(id) ON DELETE CASCADE,
  key        TEXT NOT NULL UNIQUE,
  label      TEXT NOT NULL,
  legal_ref  TEXT,               -- ex. 'art. 22a LACI', 'art. 24-25 LAA'
  -- Piège historique identifié sur les tentatives passées
  is_trap    BOOLEAN NOT NULL DEFAULT FALSE,
  trap_note  TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE INDEX idx_afa_notions_theme ON afa_notions(theme_id);
CREATE INDEX idx_afa_notions_trap  ON afa_notions(is_trap) WHERE is_trap;

-- ───────── QUESTIONS ─────────
-- `options` : [{ "text": "...", "correct": true, "why_wrong": "..." }]
-- Multi-réponses natif (correction du blocage `correct INT` de training_questions).
CREATE TABLE IF NOT EXISTS afa_questions (
  id            UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  filiere_key   TEXT NOT NULL REFERENCES afa_filieres(key) ON DELETE CASCADE,
  theme_id      UUID REFERENCES afa_themes(id) ON DELETE SET NULL,
  external_id   TEXT UNIQUE,
  question_type TEXT NOT NULL DEFAULT 'single'
    CHECK (question_type IN ('single', 'multiple', 'vrai_faux', 'matching', 'numerical')),
  -- Mise en situation / dialogue client (format étude de cas dirigée VBV)
  context       TEXT,
  question      TEXT NOT NULL,
  options       JSONB NOT NULL,
  -- Barème VBV : 1, 2 ou 3 points selon complexité
  points        INT NOT NULL DEFAULT 1 CHECK (points > 0),
  explanation   TEXT,
  -- Provenance, pour tracer la fiabilité du contenu
  source        TEXT NOT NULL DEFAULT 'interne'
    CHECK (source IN ('preserie_vbv', 'cahier_anisa', 'formation_externe', 'klary_interne', 'interne')),
  difficulty    INT CHECK (difficulty BETWEEN 1 AND 3),
  active        BOOLEAN NOT NULL DEFAULT TRUE,
  created_at    TIMESTAMPTZ DEFAULT NOW(),
  updated_at    TIMESTAMPTZ DEFAULT NOW()
);

CREATE INDEX idx_afa_questions_filiere ON afa_questions(filiere_key);
CREATE INDEX idx_afa_questions_theme   ON afa_questions(theme_id);

DROP TRIGGER IF EXISTS trg_afa_questions_updated_at ON afa_questions;
CREATE TRIGGER trg_afa_questions_updated_at BEFORE UPDATE ON afa_questions
  FOR EACH ROW EXECUTE FUNCTION set_updated_at();

-- Liaison question ↔ notions (n..n)
CREATE TABLE IF NOT EXISTS afa_question_notions (
  question_id UUID NOT NULL REFERENCES afa_questions(id) ON DELETE CASCADE,
  notion_id   UUID NOT NULL REFERENCES afa_notions(id)   ON DELETE CASCADE,
  PRIMARY KEY (question_id, notion_id)
);

-- ───────── SESSIONS DE RÉVISION ─────────
-- mode 'simulation' : 30 min chrono, tirage type examen, auto-submit
-- mode 'drill'      : quiz ciblé par thème/notion, sans chrono
-- mode 'pieges'     : uniquement les notions marquées is_trap
CREATE TABLE IF NOT EXISTS afa_sessions (
  id            UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id       UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  filiere_key   TEXT NOT NULL REFERENCES afa_filieres(key),
  mode          TEXT NOT NULL CHECK (mode IN ('simulation', 'drill', 'pieges')),
  theme_id      UUID REFERENCES afa_themes(id) ON DELETE SET NULL,
  question_ids  JSONB NOT NULL,          -- ordre de passage figé au démarrage
  duration_sec  INT,                     -- NULL = pas de chrono (drill)
  started_at    TIMESTAMPTZ DEFAULT NOW(),
  finished_at   TIMESTAMPTZ,
  time_used_sec INT,
  auto_submitted BOOLEAN NOT NULL DEFAULT FALSE,  -- chrono écoulé

  -- Double scoring (cf. commentaire ci-dessous)
  points_max        INT,
  points_partial    INT,   -- crédit partiel, proche du barème VBV
  points_strict     INT,   -- tout-ou-rien par question
  score_pct_partial INT,
  score_pct_strict  INT,
  passed            BOOLEAN,  -- basé sur score_pct_partial >= passing_pct

  created_at    TIMESTAMPTZ DEFAULT NOW()
);

CREATE INDEX idx_afa_sessions_user ON afa_sessions(user_id, started_at DESC);

-- ───────── RÉPONSES DÉTAILLÉES ─────────
-- Une ligne par question présentée : c'est la base du suivi de progression.
CREATE TABLE IF NOT EXISTS afa_answers (
  id              UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  session_id      UUID NOT NULL REFERENCES afa_sessions(id) ON DELETE CASCADE,
  question_id     UUID NOT NULL REFERENCES afa_questions(id) ON DELETE CASCADE,
  selected        JSONB NOT NULL DEFAULT '[]'::jsonb,  -- indices d'options cochées
  points_max      INT NOT NULL,
  points_partial  INT NOT NULL DEFAULT 0,
  points_strict   INT NOT NULL DEFAULT 0,
  is_perfect      BOOLEAN NOT NULL DEFAULT FALSE,
  -- Diagnostic du type d'erreur — c'est CE champ qui alimente la remédiation.
  -- 'omission'   : a coché juste mais incomplet  ← pattern dominant d'Anisa
  -- 'commission' : a coché une option fausse
  -- 'mixte'      : les deux
  error_type      TEXT CHECK (error_type IN ('omission', 'commission', 'mixte')),
  time_spent_sec  INT,
  created_at      TIMESTAMPTZ DEFAULT NOW(),
  UNIQUE (session_id, question_id)
);

CREATE INDEX idx_afa_answers_session  ON afa_answers(session_id);
CREATE INDEX idx_afa_answers_question ON afa_answers(question_id);

-- ───────── FICHES MÉMOIRE ─────────
CREATE TABLE IF NOT EXISTS afa_fiches (
  id          UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  filiere_key TEXT NOT NULL REFERENCES afa_filieres(key) ON DELETE CASCADE,
  theme_id    UUID REFERENCES afa_themes(id) ON DELETE SET NULL,
  key         TEXT NOT NULL UNIQUE,
  title       TEXT NOT NULL,
  summary     TEXT,
  content_md  TEXT NOT NULL,
  sort_order  INT NOT NULL DEFAULT 0,
  active      BOOLEAN NOT NULL DEFAULT TRUE,
  created_at  TIMESTAMPTZ DEFAULT NOW(),
  updated_at  TIMESTAMPTZ DEFAULT NOW()
);

CREATE INDEX idx_afa_fiches_filiere ON afa_fiches(filiere_key);

DROP TRIGGER IF EXISTS trg_afa_fiches_updated_at ON afa_fiches;
CREATE TRIGGER trg_afa_fiches_updated_at BEFORE UPDATE ON afa_fiches
  FOR EACH ROW EXECUTE FUNCTION set_updated_at();
