-- ═════════════════════════════════════════════════════════
-- Extension table candidates : champs additionnels + documents supplémentaires
-- ═════════════════════════════════════════════════════════

ALTER TABLE candidates
  ADD COLUMN IF NOT EXISTS why_klary TEXT,
  ADD COLUMN IF NOT EXISTS additional_documents JSONB DEFAULT '[]'::jsonb;

-- additional_documents structure :
-- [
--   { "key": "diplomes",   "filename": "...", "storage_path": "2026/xxx.pdf", "size_bytes": 123456 },
--   { "key": "casier",     "filename": "...", "storage_path": "2026/xxx.pdf", "size_bytes": 123456 },
--   { "key": "poursuites", "filename": "...", "storage_path": "2026/xxx.pdf", "size_bytes": 123456 }
-- ]
