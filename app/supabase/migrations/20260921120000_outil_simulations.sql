-- ═════════════════════════════════════════════════════════
-- Klary — Historique des simulations « Premier Plan Logement »
--
-- Chaque conseiller peut sauvegarder un dossier client complet (chiffres
-- + identité + verdict) pour le retrouver plus tard, le rejouer ou le
-- ré-imprimer. Utile pour : suivi post-RDV, préparation d'un rappel J+7,
-- comparaison de scénarios.
-- ═════════════════════════════════════════════════════════

CREATE TABLE IF NOT EXISTS outil_simulations (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  outil TEXT NOT NULL CHECK (outil IN ('hypotheque_ppl', 'prevoyance_lacune', 'impot_retrait')),

  -- Identité client (dénormalisé pour listing rapide)
  client_prenom TEXT,
  client_nom TEXT,
  client_display TEXT GENERATED ALWAYS AS (
    TRIM(COALESCE(client_prenom, '') || ' ' || COALESCE(client_nom, ''))
  ) STORED,

  -- Snapshot complet du dossier + synthèse en JSON pour rejouer / afficher
  dossier JSONB NOT NULL,
  synthese JSONB,

  -- Suivi commercial
  notes TEXT,
  outcome TEXT CHECK (outcome IN ('en_reflexion', 'signee', 'refusee', 'a_relancer', NULL)),
  relance_at TIMESTAMPTZ,

  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_outil_simulations_user ON outil_simulations(user_id, created_at DESC);
CREATE INDEX IF NOT EXISTS idx_outil_simulations_outil ON outil_simulations(outil);
CREATE INDEX IF NOT EXISTS idx_outil_simulations_relance ON outil_simulations(relance_at) WHERE relance_at IS NOT NULL;

DROP TRIGGER IF EXISTS trg_outil_simulations_updated_at ON outil_simulations;
CREATE TRIGGER trg_outil_simulations_updated_at BEFORE UPDATE ON outil_simulations
  FOR EACH ROW EXECUTE FUNCTION set_updated_at();

-- ─── RLS : chaque conseiller voit uniquement SES simulations ───
ALTER TABLE outil_simulations ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS outil_simulations_own ON outil_simulations;
CREATE POLICY outil_simulations_own ON outil_simulations
  FOR ALL
  USING (auth.uid() = user_id)
  WITH CHECK (auth.uid() = user_id);

-- Admin / manager peuvent tout voir pour supervision
DROP POLICY IF EXISTS outil_simulations_admin_read ON outil_simulations;
CREATE POLICY outil_simulations_admin_read ON outil_simulations
  FOR SELECT
  USING (public.is_admin_or_manager());

COMMENT ON TABLE outil_simulations IS
  'Historique des simulations générées par les conseillers via les outils Klary. RLS : chacun voit ses propres simulations, admin/manager voient tout.';
