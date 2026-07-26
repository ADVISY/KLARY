-- ═════════════════════════════════════════════════════════
-- Bibliothèque de documents / argumentaires Klary
--   • Fiches produits par compagnie
--   • Scripts d'appel / trames commerciales
--   • PV de conseil templates
--   • Références réglementaires FINMA / VBI
--   • Argumentaires par situation
--   • Docs internes divers
-- Uploads par admin/manager. Lecture par tous les agents authentifiés.
-- ═════════════════════════════════════════════════════════

CREATE TABLE IF NOT EXISTS library_documents (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  title TEXT NOT NULL,
  description TEXT,
  category TEXT NOT NULL,
  tags TEXT[] DEFAULT '{}',
  storage_path TEXT NOT NULL,
  filename TEXT NOT NULL,
  size_bytes BIGINT,
  content_type TEXT,
  uploaded_by UUID REFERENCES auth.users(id),
  is_active BOOLEAN DEFAULT TRUE,
  download_count INT DEFAULT 0,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_library_docs_category ON library_documents(category);
CREATE INDEX IF NOT EXISTS idx_library_docs_tags ON library_documents USING gin(tags);
CREATE INDEX IF NOT EXISTS idx_library_docs_active ON library_documents(is_active) WHERE is_active = TRUE;

ALTER TABLE library_documents ENABLE ROW LEVEL SECURITY;

-- Lecture : tout agent authentifié voit les docs actifs
DROP POLICY IF EXISTS authenticated_read_library ON library_documents;
CREATE POLICY authenticated_read_library ON library_documents
  FOR SELECT USING (auth.role() = 'authenticated' AND is_active = TRUE);

-- Admin/manager : accès complet (CRUD)
DROP POLICY IF EXISTS admin_all_library ON library_documents;
CREATE POLICY admin_all_library ON library_documents
  FOR ALL USING (public.is_admin_or_manager());

-- Bucket Storage privé "library" à créer MANUELLEMENT via dashboard :
--   Storage → New bucket → nom "library" → PRIVATE
-- Signed URLs générées côté serveur avec service_role (pas de policy publique)
