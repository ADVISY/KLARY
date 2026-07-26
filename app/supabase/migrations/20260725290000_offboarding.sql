-- ═════════════════════════════════════════════════════════
-- Processus d'offboarding agent Klary
-- ═════════════════════════════════════════════════════════

CREATE TABLE IF NOT EXISTS offboarding_processes (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,

  -- Snapshot identité (au cas où le profil serait supprimé)
  first_name TEXT,
  last_name TEXT,
  agent_email TEXT NOT NULL,

  -- Motif + dates
  reason TEXT NOT NULL CHECK (reason IN (
    'demission',
    'mutuel_accord',
    'rupture_essai',
    'fin_cdd',
    'retraite',
    'licenciement',
    'faute_grave',
    'abandon_poste'
  )),
  last_working_day DATE,
  notice_period_end DATE,

  -- Meta
  initiated_by UUID REFERENCES auth.users(id),
  admin_notes TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW(),

  -- Convention de sortie signée (upload par admin)
  convention_signed_storage_path TEXT,
  convention_signed_uploaded_at TIMESTAMPTZ,

  -- ─── CHECKLIST ADMIN (items cochables) ───
  access_revoked_at TIMESTAMPTZ,
  access_revoked_notes TEXT,

  equipment_returned_at TIMESTAMPTZ,
  equipment_returned_notes TEXT,

  portfolio_transferred_to UUID REFERENCES auth.users(id),
  portfolio_transferred_at TIMESTAMPTZ,
  portfolio_transferred_notes TEXT,

  final_commissions_calculated_at TIMESTAMPTZ,
  final_commissions_amount NUMERIC(10, 2),
  final_commissions_notes TEXT,

  work_certificate_issued_at TIMESTAMPTZ,
  work_certificate_notes TEXT,

  attestation_ac_issued_at TIMESTAMPTZ,
  attestation_ac_notes TEXT,

  salary_final_sent_at TIMESTAMPTZ,
  salary_final_notes TEXT,

  lawid_sent_at TIMESTAMPTZ,
  lawid_notes TEXT,

  finma_registry_updated_at TIMESTAMPTZ,
  finma_registry_notes TEXT,

  -- Finalisation
  completed_at TIMESTAMPTZ,
  completed_by UUID REFERENCES auth.users(id)
);

CREATE INDEX IF NOT EXISTS idx_offboarding_user ON offboarding_processes(user_id);
CREATE INDEX IF NOT EXISTS idx_offboarding_created ON offboarding_processes(created_at DESC);
CREATE INDEX IF NOT EXISTS idx_offboarding_completed ON offboarding_processes(completed_at);

CREATE TRIGGER trg_offboarding_updated_at BEFORE UPDATE ON offboarding_processes
  FOR EACH ROW EXECUTE FUNCTION set_updated_at();

ALTER TABLE offboarding_processes ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS admin_all_offboarding ON offboarding_processes;
CREATE POLICY admin_all_offboarding ON offboarding_processes
  FOR ALL USING (public.is_admin_or_manager());

-- Bucket Storage privé "offboarding-docs" à créer manuellement dans
-- le dashboard Supabase (Storage → New bucket → private).
