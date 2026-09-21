-- ═════════════════════════════════════════════════════════
-- Klary — Découpage du thème « retraite » (filière VIE) en 2 sous-modules
--
-- Suite au feedback conseillers : 74 questions dans un seul thème = trop
-- large pour une révision ciblée. On sépare en :
--   - retraite_obligatoire  : règles AVS + LPP légales, cotisations, bonifications
--   - retraite_individuelle : arbitrages rente/capital, 3a/3b, fiscalité, cas particuliers
--
-- L'ancien thème « retraite » est désactivé (préserve historique sessions).
-- ═════════════════════════════════════════════════════════

-- 1. Créer les 2 sous-thèmes
INSERT INTO afa_themes (filiere_key, key, title, description, sort_order) VALUES
  ('vie', 'retraite_obligatoire',
   'Retraite — Prévoyance obligatoire (1er + 2ème pilier)',
   'AVS et LPP : cotisations, splitting, bonifications, seuil et déduction de coordination, taux de conversion, retrait anticipé EPL, prestations complémentaires.',
   21),
  ('vie', 'retraite_individuelle',
   'Retraite — Prévoyance individuelle & décisions',
   '3a et 3b, arbitrage rente vs capital, fiscalité art. 22/38 LIFD, rentes viagères, rachats stratégiques, cas particuliers (divorce, étrangers, EPL).',
   22)
ON CONFLICT (filiere_key, key) DO NOTHING;

-- 2. Reclasser les questions OBLIGATOIRE (49)
UPDATE afa_questions
SET theme_id = (SELECT id FROM afa_themes WHERE filiere_key = 'vie' AND key = 'retraite_obligatoire')
WHERE external_id IN (
  -- lpp_externe.json (24)
  'EXT-LPP-001', 'EXT-LPP-002', 'EXT-LPP-003', 'EXT-LPP-004', 'EXT-LPP-005',
  'EXT-LPP-008', 'EXT-LPP-009', 'EXT-LPP-010', 'EXT-LPP-011', 'EXT-LPP-012',
  'EXT-LPP-013', 'EXT-LPP-015', 'EXT-LPP-019', 'EXT-LPP-020', 'EXT-LPP-023',
  'EXT-LPP-025', 'EXT-LPP-030', 'EXT-LPP-031', 'EXT-LPP-032', 'EXT-LPP-034',
  'EXT-LPP-035', 'EXT-LPP-051', 'EXT-LPP-052', 'EXT-LPP-053',
  -- vie_externe.json (3)
  'EXT-VIE-001', 'EXT-VIE-002', 'EXT-VIE-003',
  -- vie_klary_bank_v2.json (17)
  'KLARY-VIE-RT-001', 'KLARY-VIE-RT-002', 'KLARY-VIE-RT-003', 'KLARY-VIE-RT-004',
  'KLARY-VIE-RT-005', 'KLARY-VIE-RT-006', 'KLARY-VIE-RT-007', 'KLARY-VIE-RT-008',
  'KLARY-VIE-RT-009', 'KLARY-VIE-RT-011', 'KLARY-VIE-RT-013', 'KLARY-VIE-RT-014',
  'KLARY-VIE-RT-016', 'KLARY-VIE-RT-017', 'KLARY-VIE-RT-018', 'KLARY-VIE-RT-019',
  'KLARY-VIE-RT-020',
  -- vie_klary_prevoyance_privee.json (5)
  'KLARY-VIE-PP-069', 'KLARY-VIE-PP-070', 'KLARY-VIE-PP-073', 'KLARY-VIE-PP-074',
  'KLARY-VIE-PP-075'
);

-- 3. Reclasser les questions INDIVIDUELLE (25)
UPDATE afa_questions
SET theme_id = (SELECT id FROM afa_themes WHERE filiere_key = 'vie' AND key = 'retraite_individuelle')
WHERE external_id IN (
  -- lpp_externe.json (7)
  'EXT-LPP-024', 'EXT-LPP-047', 'EXT-LPP-048', 'EXT-LPP-049', 'EXT-LPP-050',
  'EXT-LPP-054', 'EXT-LPP-057',
  -- vie_klary_bank_v2.json (3)
  'KLARY-VIE-RT-010', 'KLARY-VIE-RT-012', 'KLARY-VIE-RT-015',
  -- vie_klary_prevoyance_privee.json (15)
  'KLARY-VIE-PP-056', 'KLARY-VIE-PP-057', 'KLARY-VIE-PP-058', 'KLARY-VIE-PP-059',
  'KLARY-VIE-PP-060', 'KLARY-VIE-PP-061', 'KLARY-VIE-PP-062', 'KLARY-VIE-PP-063',
  'KLARY-VIE-PP-064', 'KLARY-VIE-PP-065', 'KLARY-VIE-PP-066', 'KLARY-VIE-PP-067',
  'KLARY-VIE-PP-068', 'KLARY-VIE-PP-071', 'KLARY-VIE-PP-072'
);

-- 4. Désactiver l'ancien thème « retraite » (préserve historique via theme_id NULL sur nouvelles seed)
UPDATE afa_themes
SET active = FALSE
WHERE filiere_key = 'vie' AND key = 'retraite';

COMMENT ON TABLE afa_themes IS
  'Thèmes AFA. Le thème vie/retraite est désactivé au profit de retraite_obligatoire et retraite_individuelle.';
