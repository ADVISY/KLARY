-- ═════════════════════════════════════════════════════════
-- Coffre-fort documents RH internes Klary
-- Séparé de la production (LYTA / clients) — uniquement les docs
-- de la relation Klary ↔ employés/agents.
-- ═════════════════════════════════════════════════════════

CREATE TABLE IF NOT EXISTS internal_documents (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  document_type TEXT NOT NULL,
  title TEXT NOT NULL,
  description TEXT,
  storage_path TEXT NOT NULL,
  filename TEXT NOT NULL,
  size_bytes BIGINT,
  content_type TEXT,
  status TEXT DEFAULT 'signed' CHECK (status IN ('draft', 'to_sign', 'signed', 'archived')),
  signed_at TIMESTAMPTZ,
  signature_method TEXT CHECK (signature_method IN (
    'manuscrite_scan',
    'ses_app',
    'qes_skribble',
    'unsigned'
  )),
  signature_metadata JSONB,
  is_active BOOLEAN DEFAULT TRUE,
  created_by UUID REFERENCES auth.users(id),
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_internal_docs_user ON internal_documents(user_id);
CREATE INDEX IF NOT EXISTS idx_internal_docs_type ON internal_documents(document_type);
CREATE INDEX IF NOT EXISTS idx_internal_docs_created ON internal_documents(created_at DESC);

CREATE TRIGGER trg_internal_docs_updated_at BEFORE UPDATE ON internal_documents
  FOR EACH ROW EXECUTE FUNCTION set_updated_at();

ALTER TABLE internal_documents ENABLE ROW LEVEL SECURITY;

-- Admin/manager : full CRUD
DROP POLICY IF EXISTS admin_all_internal_docs ON internal_documents;
CREATE POLICY admin_all_internal_docs ON internal_documents
  FOR ALL USING (public.is_admin_or_manager());

-- Agent : voit ses propres docs actifs uniquement
DROP POLICY IF EXISTS user_read_own_internal_docs ON internal_documents;
CREATE POLICY user_read_own_internal_docs ON internal_documents
  FOR SELECT USING (
    auth.uid() = user_id AND is_active = TRUE
  );

-- Bucket Supabase Storage "internal-documents" à créer manuellement
-- (privé, service_role only).
