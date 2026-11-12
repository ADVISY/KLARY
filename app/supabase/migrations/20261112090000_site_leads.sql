-- ═════════════════════════════════════════════════════════
-- Demandes issues des pages d'offre publiques de klary.ch
-- (comparatif assurance maladie, demande de subside).
--
--   • Écriture : ouverte au public NON authentifié, c'est un formulaire de site.
--     Insertion seule, jamais de lecture ni de modification.
--   • Lecture : direction et responsables uniquement. Ce sont des données
--     personnelles de prospects, personne d'autre n'y accède.
--   • Le consentement du prospect au statut d'intermédiaire LIÉ est stocké
--     avec la demande : c'est la preuve que l'information art. 45 LSA a bien
--     été donnée avant la prise de contact.
-- ═════════════════════════════════════════════════════════

CREATE TABLE IF NOT EXISTS site_leads (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

  -- Origine
  source TEXT NOT NULL CHECK (source IN ('maladie', 'subside')),
  campaign TEXT NOT NULL CHECK (length(campaign) BETWEEN 1 AND 60),
  page_url TEXT CHECK (page_url IS NULL OR length(page_url) <= 500),

  -- Identité du prospect
  first_name TEXT NOT NULL CHECK (length(btrim(first_name)) BETWEEN 1 AND 80),
  last_name  TEXT NOT NULL CHECK (length(btrim(last_name))  BETWEEN 1 AND 80),
  email      TEXT NOT NULL CHECK (email ~* '^[^@[:space:]]+@[^@[:space:]]+\.[a-z]{2,}$' AND length(email) <= 180),
  phone      TEXT NOT NULL CHECK (length(btrim(phone)) BETWEEN 8 AND 25),

  -- Situation
  canton      TEXT CHECK (canton IS NULL OR length(canton) = 2),
  postal_code TEXT CHECK (postal_code IS NULL OR postal_code ~ '^[0-9]{4}$'),
  birth_date  DATE CHECK (birth_date IS NULL OR birth_date > current_date - INTERVAL '110 years'),

  -- Information préalable sur le statut d'intermédiaire lié
  consent_tied BOOLEAN NOT NULL DEFAULT false,

  -- Réponses complètes du tunnel
  answers JSONB NOT NULL DEFAULT '{}'::jsonb,

  -- Suivi commercial
  status TEXT NOT NULL DEFAULT 'nouveau'
    CHECK (status IN ('nouveau', 'contacte', 'rdv', 'signe', 'perdu', 'injoignable')),
  assigned_to UUID REFERENCES auth.users(id) ON DELETE SET NULL,
  notes TEXT,

  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE INDEX IF NOT EXISTS idx_site_leads_created ON site_leads(created_at DESC);
CREATE INDEX IF NOT EXISTS idx_site_leads_source  ON site_leads(source, created_at DESC);
CREATE INDEX IF NOT EXISTS idx_site_leads_status  ON site_leads(status, created_at DESC);

DROP TRIGGER IF EXISTS trg_site_leads_updated_at ON site_leads;
CREATE TRIGGER trg_site_leads_updated_at BEFORE UPDATE ON site_leads
  FOR EACH ROW EXECUTE FUNCTION set_updated_at();

ALTER TABLE site_leads ENABLE ROW LEVEL SECURITY;

-- Le formulaire public dépose sa demande, et rien de plus.
-- Les colonnes de suivi ne sont pas écrites par le site : on les force
-- à leur valeur par défaut pour qu'un visiteur ne puisse pas s'auto-assigner
-- un lead ni le marquer comme signé.
DROP POLICY IF EXISTS site_leads_insert_public ON site_leads;
CREATE POLICY site_leads_insert_public ON site_leads
  FOR INSERT TO anon, authenticated
  WITH CHECK (
    status = 'nouveau'
    AND assigned_to IS NULL
    AND notes IS NULL
  );

-- Lecture réservée à la direction et aux responsables.
DROP POLICY IF EXISTS site_leads_read_staff ON site_leads;
CREATE POLICY site_leads_read_staff ON site_leads
  FOR SELECT TO authenticated
  USING (public.is_admin_or_manager());

-- Qualification du lead par la direction et les responsables.
DROP POLICY IF EXISTS site_leads_update_staff ON site_leads;
CREATE POLICY site_leads_update_staff ON site_leads
  FOR UPDATE TO authenticated
  USING (public.is_admin_or_manager())
  WITH CHECK (public.is_admin_or_manager());

COMMENT ON TABLE site_leads IS
  'Demandes des pages d''offre publiques (maladie, subside). Insertion publique, lecture direction et responsables uniquement.';
COMMENT ON COLUMN site_leads.consent_tied IS
  'Le prospect a vu et accepté la mention d''intermédiaire lié au Groupe Mutuel avant l''envoi (information art. 45 LSA).';
