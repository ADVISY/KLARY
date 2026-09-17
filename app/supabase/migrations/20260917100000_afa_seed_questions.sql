-- ═════════════════════════════════════════════════════════
-- Klary — Seed des questions AFA
-- FICHIER GÉNÉRÉ — ne pas éditer à la main.
-- Source : src/content/afa/*.json
-- Régénérer : node scripts/afa/generate-seed.mjs
-- ═════════════════════════════════════════════════════════

-- ───────── laa_externe.json — Banque de questions LAA reconstituée à partir d'un support de formation externe. Fond : LAA, OLAA, LPGA. ─────────
INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'EXT-LAA-001', 'maladie_complementaire', t.id, 'single',
       NULL, 'A partir de quel revenu est-on obligatoirement assuré à la LAA ?', '[{"text":"22''050","correct":false},{"text":"3''675","correct":false},{"text":"Pas de minimum","correct":true}]'::jsonb, 1,
       'Base légale : Art. 92 LAA / Art. 22, al. 1 et 2 LAA / Art. 115 OLAA.', 'formation_externe', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'laa'
ON CONFLICT (external_id) DO NOTHING;
INSERT INTO afa_question_notions (question_id, notion_id)
SELECT qu.id, n.id FROM afa_questions qu, afa_notions n
WHERE qu.external_id = 'EXT-LAA-001' AND n.key = 'laa_assujettissement'
ON CONFLICT DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'EXT-LAA-002', 'maladie_complementaire', t.id, 'single',
       NULL, 'Quel est le salaire assuré maximum en LAA obligatoire ?', '[{"text":"148''200","correct":true},{"text":"62''475","correct":false},{"text":"88''200","correct":false},{"text":"126''000","correct":false}]'::jsonb, 1,
       'Base légale : Art. 22, al. 1 OLAA.', 'formation_externe', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'laa'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'EXT-LAA-003', 'maladie_complementaire', t.id, 'single',
       NULL, 'A partir de quand est-on assuré en assurance accident non-professionnel ?', '[{"text":"A partir de la 1ère heure de travail","correct":false},{"text":"A partir de 8 heures de travail par semaine auprès de différents employeurs","correct":false},{"text":"A partir de 8 heures de travail par semaine auprès du même employeur","correct":true},{"text":"A partir de 42 heures de travail par semaine","correct":false}]'::jsonb, 1,
       'Base légale : Art. 13, al. 1 OLAA.', 'formation_externe', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'laa'
ON CONFLICT (external_id) DO NOTHING;
INSERT INTO afa_question_notions (question_id, notion_id)
SELECT qu.id, n.id FROM afa_questions qu, afa_notions n
WHERE qu.external_id = 'EXT-LAA-003' AND n.key = 'laa_8h'
ON CONFLICT DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'EXT-LAA-004', 'maladie_complementaire', t.id, 'single',
       NULL, 'A partir de quand est-on assuré en accident professionnel ?', '[{"text":"A partir de 8 heures de travail auprès du même employeur","correct":false},{"text":"Dès la signature du contrat de travail","correct":false},{"text":"Dès le début des rapports de travail","correct":true}]'::jsonb, 1,
       'Base légale : Art. 3, al. 1 LAA.', 'formation_externe', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'laa'
ON CONFLICT (external_id) DO NOTHING;
INSERT INTO afa_question_notions (question_id, notion_id)
SELECT qu.id, n.id FROM afa_questions qu, afa_notions n
WHERE qu.external_id = 'EXT-LAA-004' AND n.key = 'laa_8h'
ON CONFLICT DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'EXT-LAA-005', 'maladie_complementaire', t.id, 'single',
       NULL, 'Quel est le montant de la rente de veuve LAA ?', '[{"text":"80 % de la rente d''invalidité","correct":false},{"text":"40 % de la rente d''invalidité","correct":false},{"text":"40 % du gain assuré","correct":true},{"text":"80 % du gain assuré","correct":false}]'::jsonb, 1,
       'Base légale : Art. 31, al. 1 LAA.', 'formation_externe', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'laa'
ON CONFLICT (external_id) DO NOTHING;
INSERT INTO afa_question_notions (question_id, notion_id)
SELECT qu.id, n.id FROM afa_questions qu, afa_notions n
WHERE qu.external_id = 'EXT-LAA-005' AND n.key = 'laa_survivants'
ON CONFLICT DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'EXT-LAA-006', 'maladie_complementaire', t.id, 'single',
       NULL, 'Quel est le montant de la rente d''orphelin LAA ?', '[{"text":"15 % de la rente d''invalidité","correct":false},{"text":"20 % de la rente d''invalidité","correct":false},{"text":"20 % du gain assuré","correct":false},{"text":"15 % du gain assuré","correct":true}]'::jsonb, 1,
       'Base légale : Art. 31, al. 1 LAA.', 'formation_externe', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'laa'
ON CONFLICT (external_id) DO NOTHING;
INSERT INTO afa_question_notions (question_id, notion_id)
SELECT qu.id, n.id FROM afa_questions qu, afa_notions n
WHERE qu.external_id = 'EXT-LAA-006' AND n.key = 'laa_survivants'
ON CONFLICT DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'EXT-LAA-007', 'maladie_complementaire', t.id, 'single',
       NULL, 'Quel est le montant de la rente d''orphelin double ?', '[{"text":"30 % du gain assuré","correct":false},{"text":"25 % du gain assuré","correct":true},{"text":"30 % de la rente d''invalidité","correct":false},{"text":"25 % de la rente d''invalidité","correct":false}]'::jsonb, 1,
       'Base légale : Art. 31, al. 1 LAA.', 'formation_externe', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'laa'
ON CONFLICT (external_id) DO NOTHING;
INSERT INTO afa_question_notions (question_id, notion_id)
SELECT qu.id, n.id FROM afa_questions qu, afa_notions n
WHERE qu.external_id = 'EXT-LAA-007' AND n.key = 'laa_survivants'
ON CONFLICT DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'EXT-LAA-008', 'maladie_complementaire', t.id, 'single',
       NULL, 'Quel est la limite maximum assurée en LAA pour les rentes de survivants ?', '[{"text":"70 % de la rente d''invalidité","correct":false},{"text":"70 % du gain assuré","correct":true},{"text":"80 % de la rente d''invalidité","correct":false},{"text":"80 % du gain assuré","correct":false}]'::jsonb, 1,
       'Base légale : Art. 31, al. 1 LAA.', 'formation_externe', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'laa'
ON CONFLICT (external_id) DO NOTHING;
INSERT INTO afa_question_notions (question_id, notion_id)
SELECT qu.id, n.id FROM afa_questions qu, afa_notions n
WHERE qu.external_id = 'EXT-LAA-008' AND n.key = 'laa_survivants'
ON CONFLICT DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'EXT-LAA-009', 'maladie_complementaire', t.id, 'single',
       NULL, 'Monsieur Lacouleur est peintre en bâtiment auprès de l''entreprise « Peinture Sàrl ». Son salaire est de CHF 70''000.- par année. En cas d''invalidité, sa rente serait de CHF 56''000.- par an. Marié à Emilie, il a un garçon de 8 ans qui se nomme Pierre. En cas de décès, à combien se monte la rente d''Emilie ?', '[{"text":"CHF 42''000.- par an","correct":false},{"text":"CHF 33''600.- par an","correct":false},{"text":"CHF 28''000.- par an","correct":true},{"text":"CHF 22''400.- par an","correct":false}]'::jsonb, 1,
       'Base légale : Art. 31, al. 1 LAA / CHF 70''000.- * 40 %.', 'formation_externe', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'laa'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'EXT-LAA-010', 'maladie_complementaire', t.id, 'single',
       NULL, 'Monsieur Lacouleur est peintre en bâtiment auprès de l''entreprise « Peinture Sàrl ». Son salaire est de CHF 70''000.- par année. En cas d''invalidité, sa rente serait de CHF 56''000.- par an. Marié à Emilie, il a un garçon de 8 ans qui se nomme Pierre. En cas de décès, à combien se monte la rente de Pierre ?', '[{"text":"CHF 14''000.- par an","correct":false},{"text":"CHF 11''200.- par an","correct":false},{"text":"CHF 10''500.- par an","correct":true},{"text":"CHF 8''400.- par an","correct":false}]'::jsonb, 1,
       'Base légale : Art. 31, al. 1 LAA / CHF 70''000.- * 15 %.', 'formation_externe', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'laa'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'EXT-LAA-011', 'maladie_complementaire', t.id, 'single',
       NULL, 'Monsieur Lacouleur et son épouse viennent d''avoir un second enfant. En c as de décès de Mr. Lacouleur, quel serait le total des rentes auxquelles les survivants auraient droit ?', '[{"text":"CHF 49''000.- par an","correct":true},{"text":"CHF 45''500.- par an","correct":false},{"text":"CHF 39''200.- par an","correct":false},{"text":"CHF 36''400.- par an","correct":false}]'::jsonb, 1,
       'Base légale : Art. 31, al. 1 LAA / CHF 70''000.- * 70 %.', 'formation_externe', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'laa'
ON CONFLICT (external_id) DO NOTHING;
INSERT INTO afa_question_notions (question_id, notion_id)
SELECT qu.id, n.id FROM afa_questions qu, afa_notions n
WHERE qu.external_id = 'EXT-LAA-011' AND n.key = 'laa_survivants'
ON CONFLICT DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'EXT-LAA-012', 'maladie_complementaire', t.id, 'single',
       NULL, 'Par qui l''assuré au chômage est-il couvert en LAA ?', '[{"text":"La caisse supplétive","correct":false},{"text":"L''assureur maladie","correct":false},{"text":"L''assureur de l''ancien employeur","correct":false},{"text":"Une compagnie d''assurance privée choisie par la caisse de chômage","correct":false},{"text":"La SUVA","correct":true}]'::jsonb, 1,
       NULL, 'formation_externe', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'laa'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'EXT-LAA-013', 'maladie_complementaire', t.id, 'single',
       NULL, 'Par qui les militaires sont-ils couverts en LAA ?', '[{"text":"La caisse supplétive","correct":false},{"text":"L''assureur maladie","correct":false},{"text":"L''assureur de l''ancien employeur","correct":false},{"text":"Une compagnie d''assurance privée choisie par la caisse de chômage","correct":false},{"text":"La SUVA","correct":true}]'::jsonb, 1,
       'Base légale : Art. 67, al. 1 LAA / Art. 81, al. 2 LAM.', 'formation_externe', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'laa'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'EXT-LAA-014', 'maladie_complementaire', t.id, 'multiple',
       NULL, 'Qui assume la charge des différentes cotisations LAA ?', '[{"text":"L''employé assume l''entier des cotisations","correct":false},{"text":"L''employeur assume l''entier des cotisations","correct":false},{"text":"L''employé assume les cotisations de l''accident professionnel","correct":false},{"text":"L''employeur assume les cotisations de l''accident professionnel","correct":true},{"text":"L''employé assume les cotisations de l''accident non-professionnel","correct":true},{"text":"L''employeur assume les cotisations de l''accident non-professionnel","correct":false},{"text":"L''employé assume les cotisations des maladies professionnelles","correct":false},{"text":"L''employeur assume les cotisations des maladies professionnelles","correct":true}]'::jsonb, 3,
       'Base légale : Art. 91, al. 1 et 2 LAA.', 'formation_externe', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'laa'
ON CONFLICT (external_id) DO NOTHING;
INSERT INTO afa_question_notions (question_id, notion_id)
SELECT qu.id, n.id FROM afa_questions qu, afa_notions n
WHERE qu.external_id = 'EXT-LAA-014' AND n.key = 'laa_8h'
ON CONFLICT DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'EXT-LAA-015', 'maladie_complementaire', t.id, 'vrai_faux',
       NULL, 'Existe-t''il des rentes pour enfant d''invalide en LAA ?', '[{"text":"Vrai","correct":false},{"text":"Faux","correct":true}]'::jsonb, 1,
       'Base légale : Art. 15 à 35 LAA / Ne figure pas parmi les prestations en espèces de la LAA.', 'formation_externe', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'laa'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'EXT-LAA-016', 'maladie_complementaire', t.id, 'multiple',
       NULL, 'Jusqu''à quel âge une rente pour orphelin peut-elle être versée ?', '[{"text":"Jusqu''à 18 ans, s''il poursuit des études","correct":false},{"text":"Jusqu''à 18 ans, même s''il n''est plus aux études","correct":true},{"text":"Jusqu''à 25 ans, s''il poursuit des études","correct":true},{"text":"Jusqu''à 25 ans, même s''il ne poursuit pas d''études","correct":false}]'::jsonb, 2,
       'Base légale : Art. 30, al. 3 LAA.', 'formation_externe', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'laa'
ON CONFLICT (external_id) DO NOTHING;
INSERT INTO afa_question_notions (question_id, notion_id)
SELECT qu.id, n.id FROM afa_questions qu, afa_notions n
WHERE qu.external_id = 'EXT-LAA-016' AND n.key = 'laa_survivants'
ON CONFLICT DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'EXT-LAA-017', 'maladie_complementaire', t.id, 'multiple',
       NULL, 'Parmi les cas ci-dessous, lesquels donnent droit à une rente de veuve ?', '[{"text":"Femme de 40 ans, mariée depuis 15 ans, sans enfant","correct":false},{"text":"Femme de 48 ans, mariée depuis 3 ans, sans enfant","correct":true},{"text":"Femme de 35 ans, mariée depuis 4 ans, un enfant de 2 ans","correct":true},{"text":"Femme de 44 ans, mariée depuis 22 ans, un enfant de 20 qui est salarié","correct":true},{"text":"Femme de 48 ans, en couple depuis 12 ans, un enfant de 10 ans","correct":false},{"text":"Femme de 48 ans, en couple depuis 6 ans, sans enfant","correct":false},{"text":"Femme de 34 ans, mariée depuis 8 ans, sans enfant, invalide à 60 %","correct":false},{"text":"Femme de 34 ans, mariée depuis 8 ans, sans enfant, invalide à 70 %","correct":true}]'::jsonb, 4,
       'Base légale : Art. 29, al. 3 LAA.', 'formation_externe', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'laa'
ON CONFLICT (external_id) DO NOTHING;
INSERT INTO afa_question_notions (question_id, notion_id)
SELECT qu.id, n.id FROM afa_questions qu, afa_notions n
WHERE qu.external_id = 'EXT-LAA-017' AND n.key = 'laa_survivants'
ON CONFLICT DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'EXT-LAA-018', 'maladie_complementaire', t.id, 'multiple',
       NULL, 'Parmi les cas ci-dessous, lesquels donnent droit à une rente de veuf ?', '[{"text":"Homme de 24 ans, marié depuis 2 ans, un enfant de 6 mois","correct":true},{"text":"Homme de 48 ans, marié depuis 3 ans, sans enfant","correct":false},{"text":"Homme de 35 ans, marié depuis 4 ans, un enfant de 2 ans","correct":true},{"text":"Homme de 44 ans, marié depuis 22 ans, un enfant de 20 ans qui est salarié","correct":false},{"text":"Homme de 44 ans, marié depuis 22 ans, un enfant de 20 ans aux études","correct":true},{"text":"Homme de 48 ans, en couple depuis 12 ans, un enfant de 10 ans","correct":false},{"text":"Homme de 34 ans, marié depuis 8 ans, sans enfant, invalide à 60 %","correct":false},{"text":"Homme de 34 ans, marié depuis 8 ans, sans enfant, invalide à 70 %","correct":true}]'::jsonb, 4,
       'Base légale : Art. 29, al. 3 LAA.', 'formation_externe', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'laa'
ON CONFLICT (external_id) DO NOTHING;
INSERT INTO afa_question_notions (question_id, notion_id)
SELECT qu.id, n.id FROM afa_questions qu, afa_notions n
WHERE qu.external_id = 'EXT-LAA-018' AND n.key = 'laa_survivants'
ON CONFLICT DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'EXT-LAA-020', 'maladie_complementaire', t.id, 'single',
       NULL, 'Quelles sont les conditions à remplir pour l''octroi d''une rente de veuve/veuf divorcé/e ?', '[{"text":"5 ans de mariage avec le défunt et bénéficier d''une pension alimentaire lors du décès du conjoint divorcé","correct":false},{"text":"10 ans de mariage avec le défunt et bénéficier d''une pension alimentaire lors du décès du conjoint divorcé","correct":false},{"text":"Bénéficier d''une pension alimentaire lors du décès du conjoint divorcé","correct":true}]'::jsonb, 1,
       'Base légale : Art. 29, al. 4 LAA.', 'formation_externe', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'laa'
ON CONFLICT (external_id) DO NOTHING;
INSERT INTO afa_question_notions (question_id, notion_id)
SELECT qu.id, n.id FROM afa_questions qu, afa_notions n
WHERE qu.external_id = 'EXT-LAA-020' AND n.key = 'laa_survivants'
ON CONFLICT DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'EXT-LAA-021', 'maladie_complementaire', t.id, 'multiple',
       NULL, 'Quand est-ce qu''une rente de veuve s''éteint ?', '[{"text":"Lorsque le dernier des enfants atteint l''âge de 18/25 ans","correct":false},{"text":"Lorsque la veuve atteint l''âge de la retraite","correct":false},{"text":"Lors du décès de la veuve","correct":true},{"text":"Lorsque la veuve vie à nouveau en couple depuis plus de 5 ans","correct":false},{"text":"Lorsque la veuve se remarie","correct":true}]'::jsonb, 2,
       'Base légale : Art. 29, al. 6 LAA.', 'formation_externe', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'laa'
ON CONFLICT (external_id) DO NOTHING;
INSERT INTO afa_question_notions (question_id, notion_id)
SELECT qu.id, n.id FROM afa_questions qu, afa_notions n
WHERE qu.external_id = 'EXT-LAA-021' AND n.key = 'laa_survivants'
ON CONFLICT DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'EXT-LAA-022', 'maladie_complementaire', t.id, 'multiple',
       NULL, 'Parmi les personnes suivantes, lesquelles ne sont pas obligatoirement soumises à la LAA ?', '[{"text":"Apprentis, stagiaires et volontaires","correct":false},{"text":"Personnes bénéficiant des indemnités journalières de l''assurance chômage","correct":false},{"text":"Femme travaillant sans salaire dans le restaurant du mari","correct":true},{"text":"Travailleur indépendant au sein d''une raison individuelle","correct":true}]'::jsonb, 2,
       'Base légale : Art. 2 OLAA.', 'formation_externe', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'laa'
ON CONFLICT (external_id) DO NOTHING;
INSERT INTO afa_question_notions (question_id, notion_id)
SELECT qu.id, n.id FROM afa_questions qu, afa_notions n
WHERE qu.external_id = 'EXT-LAA-022' AND n.key = 'laa_assujettissement'
ON CONFLICT DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'EXT-LAA-023', 'maladie_complementaire', t.id, 'multiple',
       NULL, 'Quel est le système de financement de la LAA ?', '[{"text":"Système de répartition des dépenses pour les rentes d''invalidité et de survivants","correct":false},{"text":"Système de répartition des dépenses pour les indemnité journalières et les frais de traitement","correct":true},{"text":"Système de de répartition des capitaux de couverture pour les rentes d''invalidité et de survivants","correct":true},{"text":"Système de de répartition des capitaux de couverture pour les indemnités journalières et les frais de traitement","correct":false},{"text":"les excédents d''intérêts servent à financer les allocations de renchérissement","correct":true}]'::jsonb, 3,
       'Base légale : Art. 90 LAA.', 'formation_externe', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'laa'
ON CONFLICT (external_id) DO NOTHING;
INSERT INTO afa_question_notions (question_id, notion_id)
SELECT qu.id, n.id FROM afa_questions qu, afa_notions n
WHERE qu.external_id = 'EXT-LAA-023' AND n.key = 'laa_survivants'
ON CONFLICT DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'EXT-LAA-024', 'maladie_complementaire', t.id, 'multiple',
       NULL, 'Comment une femme de ménage travaillant 4 heures par semaine auprès d''une école primaire à Lausanne (VD) et 5 heures par semaines auprès d''une autre école primaire à Renens (VD) est- elle assurée en assurance accident par ses employeurs ?', '[{"text":"Elle est assurée en cas d''accidents professionnels et non-professionnels","correct":false},{"text":"Elle est assurée uniquement en cas d''accidents professionnels","correct":true},{"text":"Elle est assurée uniquement en cas d''accidents non-professionnels","correct":false},{"text":"Elle doit s''assurer en accidents non-professionnels auprès de son employeur","correct":false},{"text":"Elle doit s''assurer en accidents non-professionnels auprès de l''assureur maladie","correct":true}]'::jsonb, 2,
       'Base légale : Art. 13, al. 1 OLAA / Art. 1a, al. 2, let. b LAMal / Art. 8 LAMal.', 'formation_externe', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'laa'
ON CONFLICT (external_id) DO NOTHING;
INSERT INTO afa_question_notions (question_id, notion_id)
SELECT qu.id, n.id FROM afa_questions qu, afa_notions n
WHERE qu.external_id = 'EXT-LAA-024' AND n.key = 'laa_8h'
ON CONFLICT DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'EXT-LAA-025', 'maladie_complementaire', t.id, 'multiple',
       NULL, 'Parmi les prestations en espèces suivantes, lesquelles sont prévues par la LAA ?', '[{"text":"Rente de vieillesse","correct":false},{"text":"Indemnité pour atteinte à l''intégrité","correct":true},{"text":"Rente d''invalidité complémentaire pour conjoint","correct":false},{"text":"Rente pour enfant d''invalide","correct":false},{"text":"Indemnités journalières","correct":true},{"text":"Allocation pour impotent","correct":true}]'::jsonb, 3,
       'Base légale : Art. 15 à 35 LAA.', 'formation_externe', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'laa'
ON CONFLICT (external_id) DO NOTHING;
INSERT INTO afa_question_notions (question_id, notion_id)
SELECT qu.id, n.id FROM afa_questions qu, afa_notions n
WHERE qu.external_id = 'EXT-LAA-025' AND n.key = 'laa_iai'
ON CONFLICT DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'EXT-LAA-026', 'maladie_complementaire', t.id, 'single',
       NULL, 'Lorsque l''employeur n''affilie pas ses employés à une assurance accident comme il est tenu de le faire selon la loi, qui s''occupe de procéder à l''affiliation d''office auprès d''un assureur ?', '[{"text":"La caisse de compensation","correct":false},{"text":"La caisse supplétive","correct":true},{"text":"La SUVA","correct":false}]'::jsonb, 1,
       'Base légale : Art. 73, al. 2 LAA / Art. 95 OLAA.', 'formation_externe', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'laa'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'EXT-LAA-027', 'maladie_complementaire', t.id, 'multiple',
       NULL, 'Parmi les affirmations suivantes, laquelle ou lesquelles sont correctes ?', '[{"text":"La totalité des cotisations LAA sont déduites du salaire de l''employé","correct":false},{"text":"Les cotisations de l''accident professionnel sont déduites du salaire de l''employé","correct":false},{"text":"Les cotisations de l''accident non-professionnel peuvent être déduites du salaire de l''employé","correct":true},{"text":"Les rentes sont imposées à un taux unique et distinct séparé des autres revenus","correct":false},{"text":"Les rentes sont imposées à 100 % avec les autres revenus","correct":true},{"text":"Les indemnités pour atteinte à l''intégrité sont imposés à un taux unique et distinct séparé des autres revenus","correct":false},{"text":"Les indemnités pour atteinte à l''intégrité sont exonérées des impôts","correct":true},{"text":"Les allocations pour impotent sont exonérées des impôts","correct":true}]'::jsonb, 4,
       'Base légale : Art. 22, 33 et 38 LIFD.', 'formation_externe', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'laa'
ON CONFLICT (external_id) DO NOTHING;
INSERT INTO afa_question_notions (question_id, notion_id)
SELECT qu.id, n.id FROM afa_questions qu, afa_notions n
WHERE qu.external_id = 'EXT-LAA-027' AND n.key = 'laa_iai'
ON CONFLICT DO NOTHING;
INSERT INTO afa_question_notions (question_id, notion_id)
SELECT qu.id, n.id FROM afa_questions qu, afa_notions n
WHERE qu.external_id = 'EXT-LAA-027' AND n.key = 'laa_8h'
ON CONFLICT DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'EXT-LAA-028', 'maladie_complementaire', t.id, 'multiple',
       NULL, 'Un employeur peut décider d''accorder des prestations plus favorables à ses employés. Parmi les possibilités suivantes,', '[{"text":"Inclusion d''un capital décès et/ou d''un capital invalidité","correct":true},{"text":"Frais de séjours hospitaliers en division semi-privée ou privée","correct":true},{"text":"Inclusion des entreprises téméraires en accidents non-professionnels","correct":true},{"text":"Inclusion d''une rente de vieillesse","correct":false},{"text":"Inclusion d''une rente pour enfant d''invalide","correct":false},{"text":"Salaire assuré au-delà du maximum obligatoire","correct":true}]'::jsonb, 4,
       NULL, 'formation_externe', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'laa'
ON CONFLICT (external_id) DO NOTHING;
INSERT INTO afa_question_notions (question_id, notion_id)
SELECT qu.id, n.id FROM afa_questions qu, afa_notions n
WHERE qu.external_id = 'EXT-LAA-028' AND n.key = 'laa_8h'
ON CONFLICT DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'EXT-LAA-029', 'maladie_complementaire', t.id, 'single',
       NULL, 'Parmi les affirmations suivantes, laquelle ou lesquelles sont correctes ?', '[{"text":"Ensemble, le 1er et 2ème pilier doivent permettre aux assurés de maintenir leur niveau de vie antérieur et ne peuvent pas dépasser 100 % du revenu précédent","correct":false},{"text":"Ensemble, le 1er et 2ème pilier doivent permettre aux assurés de maintenir leur niveau de vie antérieur et ne peuvent pas dépasser 90 % du revenu précédent","correct":true},{"text":"Ensemble, le 1er et 2ème pilier doivent permettre aux assurés de maintenir leur niveau de vie antérieur et ne peuvent pas dépasser 80 % du revenu précédent","correct":false}]'::jsonb, 1,
       'Base légale : Art. 20, al. 2 LAA.', 'formation_externe', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'laa'
ON CONFLICT (external_id) DO NOTHING;
INSERT INTO afa_question_notions (question_id, notion_id)
SELECT qu.id, n.id FROM afa_questions qu, afa_notions n
WHERE qu.external_id = 'EXT-LAA-029' AND n.key = 'laa_rente_compl'
ON CONFLICT DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'EXT-LAA-030', 'maladie_complementaire', t.id, 'single',
       NULL, 'Parmi les affirmations suivantes, laquelle ou lesquelles sont correctes ?', '[{"text":"La SUVA est une institution de droit privé et autonome sans but lucratif","correct":false},{"text":"La SUVA est une institution de droit privé et autonome avec but lucratif","correct":false},{"text":"La SUVA est une institution de droit public et autonome avec but lucratif","correct":false},{"text":"La SUVA est une institution de droit public et autonome sans but lucratif","correct":true}]'::jsonb, 1,
       'Base légale : Art. 61 LAA.', 'formation_externe', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'laa'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'EXT-LAA-032', 'maladie_complementaire', t.id, 'vrai_faux',
       NULL, 'La nationalité est un critère de tarification dans l''assurance accident.', '[{"text":"Vrai","correct":false},{"text":"Faux","correct":true}]'::jsonb, 1,
       'Base légale : Art. 92 LAA.', 'formation_externe', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'laa'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'EXT-LAA-033', 'maladie_complementaire', t.id, 'vrai_faux',
       NULL, 'Un employé est assuré à la LAA uniquement à partir de 18 ans.', '[{"text":"Vrai","correct":false},{"text":"Faux","correct":true}]'::jsonb, 1,
       'Base légale : Art. 1a LAA.', 'formation_externe', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'laa'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'EXT-LAA-034', 'maladie_complementaire', t.id, 'multiple',
       NULL, 'Parmi les affirmations suivantes, lesquelles sont correctes ?', '[{"text":"Un indépendant souhaitant s''assurer facultativement à la LAA peut librement choisir le montant du salaire assuré","correct":false},{"text":"Un indépendant souhaitant s''assurer facultativement à la LAA ne peut librement","correct":true},{"text":"Pour un membre de la famille (sans salaire) de l''indépendant souhaitant s''assurer facultativement à la LAA, le montant du salaire assuré peut être librement choisi","correct":false},{"text":"Pour un membre de la famille (sans salaire) de l''indépendant souhaitant s''assurer facultativement à la LAA, le montant du salaire assuré ne peut être librement choisi. Un montant minimum doit être respecté","correct":true}]'::jsonb, 2,
       'Base légale : Art. 138 OLAA.', 'formation_externe', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'laa'
ON CONFLICT (external_id) DO NOTHING;
INSERT INTO afa_question_notions (question_id, notion_id)
SELECT qu.id, n.id FROM afa_questions qu, afa_notions n
WHERE qu.external_id = 'EXT-LAA-034' AND n.key = 'laa_assujettissement'
ON CONFLICT DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'EXT-LAA-035', 'maladie_complementaire', t.id, 'vrai_faux',
       NULL, 'Le chemin en direction du travail est toujours considéré comme un accident non-professionnel.', '[{"text":"Vrai","correct":false},{"text":"Faux","correct":true}]'::jsonb, 1,
       'Base légale : Art. 13, al. 2 OLAA.', 'formation_externe', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'laa'
ON CONFLICT (external_id) DO NOTHING;
INSERT INTO afa_question_notions (question_id, notion_id)
SELECT qu.id, n.id FROM afa_questions qu, afa_notions n
WHERE qu.external_id = 'EXT-LAA-035' AND n.key = 'laa_8h'
ON CONFLICT DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'EXT-LAA-036', 'maladie_complementaire', t.id, 'multiple',
       NULL, 'A la fin des rapports de travail auprès d''une entreprise, une assurance par convention peut être conclue. Parmi les affirmations suivantes, lesquelles sont correctes ?', '[{"text":"L''assurance accident de l''ancien employeur s''interrompt 31 jours après le droit au ½ salaire","correct":true},{"text":"L''assurance accident de l''ancien employeur s''interrompt 1 mois après le droit au ½ salaire","correct":false},{"text":"Une assurance par convention peut être conclue pour 6 mois au maximum, pour les accidents professionnels et non professionnels","correct":false},{"text":"Une assurance par convention peut être conclue pour 6 mois au maximum, pour les accidents non-professionnels","correct":true},{"text":"Seuls les employés travaillant plus de 8 heures par semaines auprès du même employeur peuvent conclure une assurance par convention","correct":true}]'::jsonb, 1,
       'Base légale : Art. 3, al. 2 et 3 LAA / Art. 8 OLAA.', 'formation_externe', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'laa'
ON CONFLICT (external_id) DO NOTHING;
INSERT INTO afa_question_notions (question_id, notion_id)
SELECT qu.id, n.id FROM afa_questions qu, afa_notions n
WHERE qu.external_id = 'EXT-LAA-036' AND n.key = 'laa_8h'
ON CONFLICT DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'EXT-LAA-037', 'maladie_complementaire', t.id, 'single',
       NULL, 'Sur la base des indications suivantes, quel est le montant de l''indemnité journalière ? Salaire mensuel de CHF 4''800. - / 13ème salaire CHF 4''800.- / Bonus pour objectifs CHF 2''000. - / Remboursement de frais de téléphone CHF 180.- par mois', '[{"text":"CHF 182.35","correct":false},{"text":"CHF 176.45","correct":false},{"text":"CHF 145.90","correct":false},{"text":"CHF 141.15","correct":true}]'::jsonb, 1,
       NULL, 'formation_externe', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'laa'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'EXT-LAA-038', 'maladie_complementaire', t.id, 'single',
       NULL, 'Sur la base des indications suivantes, quel est le montant annuel max. de la rente d''invalidité ? Salaire mensuel de CHF 10''500.- / 13ème salaire CHF 10''500.- / Bonus pour objectifs CHF 20''000.- / Remboursement de frais de téléphone CHF 180.- par mois  148''00.- ➔ 148''200 * 80 % = CHF 118''560.-', '[{"text":"CHF 126''928","correct":false},{"text":"CHF 125''200","correct":false},{"text":"CHF 118''560","correct":true}]'::jsonb, 1,
       NULL, 'formation_externe', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'laa'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'EXT-LAA-039', 'maladie_complementaire', t.id, 'multiple',
       NULL, 'Quelles sont les différences entre la couverture accident dans l''assurance accident de l''employeur et celle de l''assurance accident inclue dans la LAMal ?', '[{"text":"Pas de franchise pour l''accident dans la LAMal","correct":false},{"text":"Pas de franchise pour l''accident dans l''assurance accident de l''employeur","correct":true},{"text":"Libre choix du médecin pour l''accident dans la LAMal","correct":false},{"text":"Libre choix du médecin pour l''accident dans l''assurance accident de l''employeur","correct":true}]'::jsonb, 1,
       'Base légale : Art. 28 LAMal.', 'formation_externe', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'laa'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'EXT-LAA-040', 'maladie_complementaire', t.id, 'multiple',
       NULL, 'Quel est le rôle de la caisse supplétive ?', '[{"text":"Assume les frais liés aux prestations réglementaires des assureurs insolvables","correct":false},{"text":"Assume les frais liés aux prestations légales des assureurs insolvables","correct":true},{"text":"Alloue les prestations réglementaires aux travailleurs accidentés non assurés par leur employeur","correct":false},{"text":"Alloue les prestations légales aux travailleurs accidentés non assurés par leur employeur","correct":true},{"text":"Attribue à un assureur les employeurs qui, malgré sommation, n''ont pas assuré leur employés","correct":true}]'::jsonb, 3,
       'Base légale : Art. 72 et 73 LAA / Art. 94 à 96 OLAA.', 'formation_externe', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'laa'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'EXT-LAA-041', 'maladie_complementaire', t.id, 'multiple',
       NULL, 'Parmi les affirmations suivantes, lesquelles sont correctes ?', '[{"text":"Le gain minimum assuré est de CHF 325.- par jour","correct":false},{"text":"Le gain maximum assuré est de CHF 406.- par jour","correct":true},{"text":"Le montant du gain assuré pour les stagiaires et apprentis de + de 20 ans peut être librement déterminé par l''employeur","correct":false},{"text":"Le gain minimum assuré pour les stagiaires et apprentis de - de 20 ans est de CHF 14''820.- par année","correct":true},{"text":"Le gain minimum assuré pour les stagiaires et apprentis de + de 20 ans est de CHF 29''640.- par année","correct":true}]'::jsonb, 3,
       'Base légale : Art. 22 OLAA / Art. 23, al. 6 OLAA.', 'formation_externe', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'laa'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'EXT-LAA-042', 'maladie_complementaire', t.id, 'multiple',
       NULL, 'Qu''est-ce qui fait partie du salaire soumis aux cotisations ?', '[{"text":"Salaire en espèce et salaire en nature","correct":true},{"text":"Salaire en espèce uniquement","correct":false},{"text":"Pourboire, si au minimum 20 % du salaire","correct":false},{"text":"Pourboire, si au minimum 10 % du salaire","correct":true},{"text":"Commissions","correct":true},{"text":"Indemnité de vacances et pour jours fériés","correct":true},{"text":"Frais de déplacements et de représentations","correct":false}]'::jsonb, 4,
       'Base légale : Art. 92 LAA / Art, 22, al. 1 et 2 LAA / Art. 115 OLAA.', 'formation_externe', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'laa'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'EXT-LAA-043', 'maladie_complementaire', t.id, 'single',
       NULL, 'Quelle est la définition d''un accident ?', '[{"text":"Est réputée accident toute atteinte dommageable, soudaine et volontaire, portée au corps humain par une cause extérieure extraordinaire qui compromet la santé physique, mentale ou psychique ou qui entraine la mort","correct":false},{"text":"Est réputée accident toute atteinte dommageable, soudaine et involontaire, portée au corps humain par une cause intérieure extraordinaire qui compromet la santé physique, mentale ou psychique ou qui entraine la mort","correct":false},{"text":"Est réputée accident toute atteinte dommageable, soudaine et involontaire, portée au corps humain par une cause extérieure extraordinaire qui compromet la santé physique, mentale ou psychique ou qui entraine la mort","correct":true}]'::jsonb, 1,
       'Base légale : Art. 4 LPGA.', 'formation_externe', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'laa'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'EXT-LAA-044', 'maladie_complementaire', t.id, 'multiple',
       NULL, 'Lesquels de ces événements sont réputés accidents professionnels.', '[{"text":"Accident se produisant durant la pause de midi","correct":true},{"text":"Accident se produisant sur le trajet pour aller au travail pour une personne dont la durée de travail est de + de 8 heures par semaine","correct":false},{"text":"Accident se produisant sur le trajet pour aller au travail pour une personne dont la durée de travail est de - de 8 heures par semaine","correct":true},{"text":"Accident se produisant, durant le week-end, lors d''une sortie organisée et financée par l''entreprise","correct":true},{"text":"Accident se produisant à l''hôtel lors d''un voyage d''affaire en Angleterre","correct":true}]'::jsonb, 4,
       'Base légale : Art. 12 OLAA.', 'formation_externe', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'laa'
ON CONFLICT (external_id) DO NOTHING;
INSERT INTO afa_question_notions (question_id, notion_id)
SELECT qu.id, n.id FROM afa_questions qu, afa_notions n
WHERE qu.external_id = 'EXT-LAA-044' AND n.key = 'laa_8h'
ON CONFLICT DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'EXT-LAA-045', 'maladie_complementaire', t.id, 'multiple',
       NULL, 'Quelle est la définition d''une maladie professionnelle ?', '[{"text":"Maladies dues exclusivement ou de manière prépondérante, dans l''exercice de l''activité professionnelle, à des substances nocives ou à certains travaux","correct":true},{"text":"Maladies dues principalement, dans l''exercice de l''activité professionnelle, à des substances nocives ou à certains travaux","correct":false},{"text":"Les autres maladies dont il est prouvé qu''elles ont été causées de manière prépondérante par l''exercice de l''activité professionnelle","correct":false},{"text":"Les autres maladies dont il est prouvé qu''elles ont été causées exclusivement ou de manière nettement prépondérante par l''exercice de l''activité professionnelle","correct":true}]'::jsonb, 2,
       'Base légale : Art. 9 LAA, Annexe 1 OLAA.', 'formation_externe', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'laa'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'EXT-LAA-046', 'maladie_complementaire', t.id, 'single',
       NULL, 'La LAA couvre également les traitements médicaux à l''étranger. Quel est le montant maximum pris en charge selon la base légale ?', '[{"text":"Au maximum la moitié du montant qui aurait résulté d''un traitement en suisse","correct":false},{"text":"Au maximum le montant qui aurait résulté d''un traitement en suisse","correct":false},{"text":"Au maximum le double du montant qui aurait résulté d''un traitement en suisse","correct":true},{"text":"Au maximum le triple montant qui aurait résulté d''un traitement en suisse","correct":false}]'::jsonb, 1,
       'Base légale : Art. 17 OLAA.', 'formation_externe', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'laa'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'EXT-LAA-047', 'maladie_complementaire', t.id, 'vrai_faux',
       NULL, 'Lors d''un traitement médical pris en charge par la LAA, le patient peut librement choisir le médecin auprès de qui il se fait soigner.', '[{"text":"Vrai","correct":true},{"text":"Faux","correct":false}]'::jsonb, 1,
       'Base légale : Art. 10, al. 2 LAA / Art. 16 OLAA.', 'formation_externe', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'laa'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'EXT-LAA-048', 'maladie_complementaire', t.id, 'multiple',
       NULL, 'Quels sont les dommages matériels couverts à la suite d''un accident ?', '[{"text":"Lunettes","correct":true},{"text":"Pantalon déchiré","correct":false},{"text":"Veste abimée","correct":false},{"text":"Appareils acoustiques","correct":true},{"text":"Prothèses dentaires","correct":true}]'::jsonb, 3,
       'Base légale : Art. 12 LAA.', 'formation_externe', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'laa'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'EXT-LAA-049', 'maladie_complementaire', t.id, 'single',
       NULL, 'Laquelle de ces affirmations est correcte ?', '[{"text":"La LAA fourni des moyens auxiliaires uniquement en prêt","correct":false},{"text":"La LAA fourni des moyens auxiliaires uniquement en propriété","correct":false},{"text":"La LAA fourni des moyens auxiliaires aussi bien en prêt qu''en propriété","correct":true}]'::jsonb, 1,
       'Base légale : Art. 11, al. 2 LAA / Art. 4 OMAA.', 'formation_externe', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'laa'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'EXT-LAA-050', 'maladie_complementaire', t.id, 'multiple',
       NULL, 'Parmi les affirmations suivantes, laquelle ou lesquelles sont correctes ?', '[{"text":"Les frais de voyage, transport et sauvetage en Suisse sont couverts jusqu''à un 1/5 du montant du gain annuel maximum assuré dans la LAA","correct":false},{"text":"Les frais de voyage, transport et sauvetage à l''étranger sont couverts jusqu''à concurrence du total des frais nécessaires","correct":false},{"text":"À la suite d''un décès, les frais de transport du corps à l''étranger sont couverts jusqu''à 1/5 du montant du gain annuel maximum assuré en LAA","correct":true},{"text":"Les frais funéraires (d''ensevelissement) sont couverts jusqu''à 7x le montant du gain journalier maximum assuré en LAA","correct":true}]'::jsonb, 2,
       'Base légale : Art. 13 et 14 LAA / Art. 20 et 21 OLAA.', 'formation_externe', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'laa'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'EXT-LAA-051', 'maladie_complementaire', t.id, 'single',
       NULL, 'A partir de quel degré d''invalidité la LAA verse-t''elle une rente ?', '[{"text":"A partir de 10 % de degré d''invalidité","correct":true},{"text":"A partir de 25 % de degré d''invalidité","correct":false},{"text":"A partir de 40 % de degré d''invalidité","correct":false},{"text":"A partir de 49 % de degré d''invalidité","correct":false}]'::jsonb, 1,
       'Base légale : Art. 18 LAA.', 'formation_externe', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'laa'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'EXT-LAA-052', 'maladie_complementaire', t.id, 'multiple',
       NULL, 'Jusqu''à quand les indemnités journalières de l''assurance accident sont-elles versées ?', '[{"text":"Durant 1 an au maximum","correct":false},{"text":"Durant 2 ans au maximum","correct":false},{"text":"Jusqu''à la reprise de la capacité de travail","correct":true},{"text":"Jusqu''à la décision de rente AI","correct":true},{"text":"Jusqu''au décès de l''assuré","correct":true}]'::jsonb, 3,
       'Base légale : Art. 16, al. 2 LAA.', 'formation_externe', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'laa'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'EXT-LAA-053', 'maladie_complementaire', t.id, 'vrai_faux',
       NULL, 'En cas d''invalidité complète, la LAA verse toujours une rente d''invalidité d''un montant de 80 % du gain assuré. Celle-ci n''est jamais réduite.', '[{"text":"Vrai","correct":false},{"text":"Faux","correct":true}]'::jsonb, 1,
       'Base légale : Art. 20, al. 2 LAA / Art. 31 et 32 OLAA.', 'formation_externe', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'laa'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'EXT-LAA-054', 'maladie_complementaire', t.id, 'vrai_faux',
       NULL, 'La rente LAA est une rente complémentaire. Additionnée au 1 er pilier, elle est réduite en conséquence pour ne pas dépasser le 90 % du gain présumé perdu de l''assuré.', '[{"text":"Vrai","correct":true},{"text":"Faux","correct":false}]'::jsonb, 1,
       'Base légale : Art. 20, al. 2 LAA / Art. 31 et 32 OLAA.', 'formation_externe', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'laa'
ON CONFLICT (external_id) DO NOTHING;
INSERT INTO afa_question_notions (question_id, notion_id)
SELECT qu.id, n.id FROM afa_questions qu, afa_notions n
WHERE qu.external_id = 'EXT-LAA-054' AND n.key = 'laa_rente_compl'
ON CONFLICT DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'EXT-LAA-055', 'maladie_complementaire', t.id, 'vrai_faux',
       NULL, 'La LPP peut également verser une rente en cas d''invalidité accident.', '[{"text":"Vrai","correct":true},{"text":"Faux","correct":false}]'::jsonb, 1,
       'Base légale : Art. 1, al. 1 LPP.', 'formation_externe', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'laa'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'EXT-LAA-056', 'maladie_complementaire', t.id, 'single',
       NULL, 'Quelle affirmation est correcte ?', '[{"text":"L''indemnité pour atteinte à l''intégrité est versée en % du salaire assuré de la personne au moment de l''atteinte à l''intégrité","correct":false},{"text":"L''indemnité pour atteinte à l''intégrité est versée en % du salaire maximum LAA assuré au moment de l''atteinte à l''intégrité","correct":true},{"text":"Etant donné que l''atteinte à l''intégrité est attestée, celle-ci peut être versée avant la décision de rente d''invalidité","correct":false}]'::jsonb, 1,
       'Base légale : Art. 36, al. 2 OLAA / Annexe 3 OLAA.', 'formation_externe', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'laa'
ON CONFLICT (external_id) DO NOTHING;
INSERT INTO afa_question_notions (question_id, notion_id)
SELECT qu.id, n.id FROM afa_questions qu, afa_notions n
WHERE qu.external_id = 'EXT-LAA-056' AND n.key = 'laa_iai'
ON CONFLICT DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'EXT-LAA-057', 'maladie_complementaire', t.id, 'vrai_faux',
       NULL, 'Le droit à l''allocation d''impotent peut démarrer avant celui de la rente d''invalidité.', '[{"text":"Vrai","correct":false},{"text":"Faux","correct":true}]'::jsonb, 1,
       'Base légale : Art. 37 et 62 OLAA.', 'formation_externe', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'laa'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'EXT-LAA-058', 'maladie_complementaire', t.id, 'vrai_faux',
       NULL, 'Une réduction ou un refus de prestation s peut être décidé aussi bien à la suite d''un accident professionnel que non-professionnel.', '[{"text":"Vrai","correct":false},{"text":"Faux","correct":true}]'::jsonb, 1,
       'Base légale : Art. 37, al. 2 LAA et 39 LAA.', 'formation_externe', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'laa'
ON CONFLICT (external_id) DO NOTHING;
INSERT INTO afa_question_notions (question_id, notion_id)
SELECT qu.id, n.id FROM afa_questions qu, afa_notions n
WHERE qu.external_id = 'EXT-LAA-058' AND n.key = 'laa_8h'
ON CONFLICT DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'EXT-LAA-059', 'maladie_complementaire', t.id, 'vrai_faux',
       NULL, 'Une réduction ou un refus de prestations peut être décidé aussi bien pour les prestations en espèces que pour les prestations de soins.', '[{"text":"Vrai","correct":false},{"text":"Faux","correct":true}]'::jsonb, 1,
       'Base légale : Art. 36 LAA / Art. 21 LPGA.', 'formation_externe', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'laa'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'EXT-LAA-060', 'maladie_complementaire', t.id, 'vrai_faux',
       NULL, 'Lors d''un crime ou délit non intentionnel, les prestations de la LAA ne peuvent en aucun cas être réduites ou refusées.', '[{"text":"Vrai","correct":false},{"text":"Faux","correct":true}]'::jsonb, 1,
       'Base légale : Art. 37, al. 3 LAA.', 'formation_externe', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'laa'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'EXT-LAA-061', 'maladie_complementaire', t.id, 'vrai_faux',
       NULL, 'Si l''assuré a provoqué l''accident par une négligence légère, les indemnités journalières versées pendant les deux premières années suivant l''accident sont réduites par la LAA.  Points maximum possible : 110 points Points minimum à atteindre : 66 points (60 %) Pour chaque réponse fausse, un point négatif est calculé. Malgré les points négatifs, il ne peut y avoir moins de 0 point par question.', '[{"text":"Vrai","correct":false},{"text":"Faux","correct":true}]'::jsonb, 1,
       'Base légale : Art. 37, al. 2 LAA.', 'formation_externe', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'laa'
ON CONFLICT (external_id) DO NOTHING;

-- ───────── lamal_externe.json — Questions à choix multiples issues de questionnaires de formation externes, réponses cochées dans le corrigé d'origine. ─────────
INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'EXT-LM-001', 'maladie_complementaire', t.id, 'multiple',
       NULL, 'Cochez les prestations pouvant être assurées dans l''assurance-maladie.', '[{"text":"Frais de guérison (p. ex. médecin, médicaments)","correct":true},{"text":"Prestations en espèces sous forme de rentes (par ex. perte de revenu en cas d''incapacité de gain","correct":false},{"text":"Frais de soins (p. ex. thérapie, soins à domicile)","correct":true}]'::jsonb, 2,
       NULL, 'formation_externe', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'lamal_prestations'
ON CONFLICT (external_id) DO NOTHING;

-- ───────── lpp_externe.json — Banque de questions LPP reconstituée à partir d'un support de formation externe. Fond : LPP, OPP2, OPP3. ─────────
INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'EXT-LPP-001', 'vie', t.id, 'single',
       NULL, 'A partir de quel revenu annuel est-on obligatoirement assuré à la LPP ?', '[{"text":"22''050.- net auprès du même employeur","correct":false},{"text":"22''050.- brut auprès de différents employeurs","correct":false},{"text":"22''050.- net auprès de différents employeurs","correct":false},{"text":"22''050.- brut auprès du même employeur","correct":true}]'::jsonb, 1,
       'Base légale : Art. 7, al. 1 LPP.', 'formation_externe', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'retraite'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'EXT-LPP-002', 'vie', t.id, 'single',
       NULL, 'Quel est le montant de la déduction de coordination ?', '[{"text":"22''050","correct":false},{"text":"25''725","correct":true},{"text":"29''400","correct":false}]'::jsonb, 1,
       'Base légale : Art. 8, al 1 LPP.', 'formation_externe', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'retraite'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'EXT-LPP-003', 'vie', t.id, 'single',
       NULL, 'Quel est le montant de la limite supérieure du salaire en LPP obligatoire ?', '[{"text":"148''200","correct":false},{"text":"62''475","correct":false},{"text":"88''200","correct":true},{"text":"882''000","correct":false}]'::jsonb, 1,
       'Base légale : Art. 8, al. 1 LPP.', 'formation_externe', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'retraite'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'EXT-LPP-004', 'vie', t.id, 'single',
       NULL, 'Quel est le montant du salaire coordonné maximum en LPP obligatoire ?', '[{"text":"148''200","correct":false},{"text":"62''475","correct":true},{"text":"88''200","correct":false},{"text":"44''100","correct":false}]'::jsonb, 1,
       'Base légale : Art. 8, al. 1 LPP.', 'formation_externe', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'retraite'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'EXT-LPP-005', 'vie', t.id, 'single',
       NULL, 'Quel est le montant du salaire coordonné minimum soumis à cotisation ?', '[{"text":"3''675","correct":true},{"text":"22''050","correct":false},{"text":"25''725","correct":false},{"text":"29''400","correct":false}]'::jsonb, 1,
       'Base légale : Art. 8, al 2 LPP.', 'formation_externe', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'retraite'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'EXT-LPP-006', 'vie', t.id, 'single',
       NULL, 'Quel est le montant maximum déductible pour un 3A d''une personne non-soumise à LPP ?', '[{"text":"20 % du revenu, mais au maximum 7''056","correct":false},{"text":"20 % du revenu, mais au maximum 35''280","correct":true},{"text":"20 % du revenu, sans limite maximum au niveau du montant","correct":false},{"text":"35''280.- par an quel que soit le revenu annuel","correct":false}]'::jsonb, 1,
       'Base légale : Art. 7, al. 1 let. b OPP 3.', 'formation_externe', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'epargne'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'EXT-LPP-007', 'vie', t.id, 'single',
       NULL, 'Quel est le montant maximum déductible pour un 3A d''une personne soumise à LPP ?', '[{"text":"20 % du revenu, mais au maximum 7''056","correct":false},{"text":"20 % du revenu, mais au maximum 35''280","correct":false},{"text":"35''280.- par an quel que soit le revenu annuel","correct":false},{"text":"7''056.- sans limite de pourcentage par rapport au revenu","correct":true}]'::jsonb, 1,
       'Base légale : Art. 7, al. 1 let. a OPP 3.', 'formation_externe', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'epargne'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'EXT-LPP-008', 'vie', t.id, 'single',
       NULL, 'Combien d''années de cotisations un homme doit-il totaliser pour atteindre l''avoir complet de vieillesse ?', '[{"text":"44","correct":false},{"text":"42","correct":false},{"text":"40","correct":true},{"text":"43","correct":false}]'::jsonb, 1,
       NULL, 'formation_externe', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'retraite'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'EXT-LPP-009', 'vie', t.id, 'single',
       NULL, 'Quel est le pourcentage des bonifications de vieillesse ?', '[{"text":"7 / 10 / 12 / 18","correct":false},{"text":"7 / 8 / 15 / 18","correct":false},{"text":"7 / 10 / 15 / 18","correct":true},{"text":"7 / 10 / 15 / 17","correct":false}]'::jsonb, 1,
       'Base légale : Art. 16 LPP.', 'formation_externe', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'retraite'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'EXT-LPP-010', 'vie', t.id, 'single',
       NULL, 'Selon la LPP, quel est le pourcentage des bonifications d''une femme de 62 ans ?', '[{"text":"7","correct":false},{"text":"10","correct":false},{"text":"12","correct":false},{"text":"15","correct":false},{"text":"18","correct":true}]'::jsonb, 1,
       'Base légale : Art. 16 LPP.', 'formation_externe', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'retraite'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'EXT-LPP-011', 'vie', t.id, 'single',
       NULL, 'Selon la LPP, quel est le pourcentage des bonifications d''une femme de 33 ans ?', '[{"text":"7","correct":true},{"text":"10","correct":false},{"text":"12","correct":false},{"text":"15","correct":false},{"text":"18","correct":false}]'::jsonb, 1,
       'Base légale : Art. 16 LPP.', 'formation_externe', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'retraite'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'EXT-LPP-012', 'vie', t.id, 'single',
       NULL, 'Selon la LPP, quel est le pourcentage des bonifications d''une femme de 44 ans ?', '[{"text":"7","correct":false},{"text":"10","correct":true},{"text":"12","correct":false},{"text":"15","correct":false},{"text":"18","correct":false}]'::jsonb, 1,
       'Base légale : Art. 16 LPP.', 'formation_externe', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'retraite'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'EXT-LPP-013', 'vie', t.id, 'single',
       NULL, 'Selon la LPP, quel est le pourcentage des bonifications d''une femme de 47 ans ?', '[{"text":"7","correct":false},{"text":"10","correct":false},{"text":"12","correct":false},{"text":"15","correct":true},{"text":"18","correct":false}]'::jsonb, 1,
       'Base légale : Art. 16 LPP.', 'formation_externe', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'retraite'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'EXT-LPP-014', 'vie', t.id, 'single',
       NULL, 'A partir de quand est-on assuré de manière obligatoire pour les risques décès et invalidité ?', '[{"text":"Dès le 1er janvier de l''année du 17ème anniversaire","correct":false},{"text":"Dès le 1er janvier suivant l''année du 17ème anniversaire","correct":true},{"text":"Dès le 1er janvier de l''année du 24ème anniversaire","correct":false},{"text":"Dès le 1er janvier suivant l''année du 24ème anniversaire","correct":false}]'::jsonb, 1,
       'Base légale : Art. 7, al. 1 LPP.', 'formation_externe', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'garantie_revenus'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'EXT-LPP-015', 'vie', t.id, 'single',
       NULL, 'A partir de quand cotise-t-on de manière obligatoire pour la part épargne ?', '[{"text":"Dès le 1er janvier de l''année du 17ème anniversaire","correct":false},{"text":"Dès le 1er janvier suivant l''année du 17ème anniversaire","correct":false},{"text":"Dès le 1er janvier de l''année du 24ème anniversaire","correct":false},{"text":"Dès le 1er janvier suivant l''année du 24ème anniversaire","correct":true}]'::jsonb, 1,
       'Base légale : Art. 7, al. 1 LPP.', 'formation_externe', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'retraite'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'EXT-LPP-016', 'vie', t.id, 'single',
       NULL, 'Quel est le montant de la rente de veuve LPP ?', '[{"text":"80 % de la rente vieillesse/invalidité de la personne décédée","correct":false},{"text":"60 % du gain assuré de la personne décédée","correct":false},{"text":"60 % de la rente vieillesse/invalidité de la personne décédée","correct":true},{"text":"80 % du gain assuré de la personne décédée","correct":false}]'::jsonb, 1,
       'Base légale : Art. 21, al. 1 et 2 LPP.', 'formation_externe', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'garantie_revenus'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'EXT-LPP-017', 'vie', t.id, 'single',
       NULL, 'Quel est le montant de la rente d''orphelin LPP ?', '[{"text":"40 % de la rente vieillesse/invalidité de la personne décédée","correct":false},{"text":"20 % de la rente vieillesse/invalidité de la personne décédée","correct":true},{"text":"40 % du gain assuré de la personne décédée","correct":false},{"text":"20 % du gain assuré de la personne décédée","correct":false}]'::jsonb, 1,
       'Base légale : Art. 21, al. 1 et 2 LPP.', 'formation_externe', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'garantie_revenus'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'EXT-LPP-018', 'vie', t.id, 'multiple',
       NULL, 'Quel est le montant maximum de l''avoir de libre passage pouvant être retiré pour l''acquisition du propre logement ?', '[{"text":"L''entier de l''avoir de libre passage en tout temps","correct":false},{"text":"L''entier de l''avoir de libre passage jusqu''à l''âge de 50 ans","correct":true},{"text":"La moitié de l''avoir de libre passage en tout temps","correct":false},{"text":"La moitié de l''avoir de libre passage après l''âge de 50 ans","correct":true}]'::jsonb, 2,
       'Base légale : Art. 30c, al. 2 LPP.', 'formation_externe', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'epargne'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'EXT-LPP-019', 'vie', t.id, 'multiple',
       NULL, 'Quand est-ce qu''un retrait anticipé peut-il être demandé ?', '[{"text":"En tout temps","correct":false},{"text":"Une fois tous les 3 ans","correct":false},{"text":"Une fois tous les 5 ans","correct":true},{"text":"Au plus tard 3 ans avant la naissance du droit aux prestations de vieillesse","correct":true},{"text":"Au plus tard 2 ans avant la naissance du droit aux prestations de vieillesse","correct":false}]'::jsonb, 2,
       'Base légale : Art. 30c LPP.', 'formation_externe', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'retraite'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'EXT-LPP-020', 'vie', t.id, 'multiple',
       NULL, 'Dans quels cas un retrait anticipé peut-il être demandé ?', '[{"text":"Départ définitif de la Suisse, quel que soit le pays","correct":false},{"text":"Départ définitif de la Suisse, hors UE/AELE","correct":true},{"text":"Départ définitif de la Suisse, uniquement en UE/AELE","correct":false},{"text":"Personne s''établissant à son propre compte en Sàrl","correct":false},{"text":"Personne s''établissant à son propre compte en raison individuelle","correct":true},{"text":"Personne s''établissant à son propre compte en raison individuelle et S''affiliant à la LPP","correct":false}]'::jsonb, 2,
       NULL, 'formation_externe', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'retraite'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'EXT-LPP-021', 'vie', t.id, 'multiple',
       NULL, 'Dans quels cas un retrait anticipé peut-il être demandé ?', '[{"text":"Achat d''une résidence principale à Annecy (France)","correct":true},{"text":"Achat d''une résidence secondaire en Valais","correct":false},{"text":"Achat d''une résidence principale à Zürich","correct":true},{"text":"Achat d''une résidence secondaire à Madrid (Espagne)","correct":false},{"text":"Achat d''une propriété commune avec son concubin","correct":false},{"text":"Achat d''une propriété commune avec son conjoint","correct":true}]'::jsonb, 3,
       NULL, 'formation_externe', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'garantie_revenus'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'EXT-LPP-022', 'vie', t.id, 'multiple',
       NULL, 'Pour quelles prestations les personnes au chômage sont-elles couvertes par la LPP ?', '[{"text":"Uniquement pour le risque invalidité par suite de maladie","correct":false},{"text":"Pour le risque décès par suite de maladie","correct":true},{"text":"Pour le risque invalidité par suite de maladie","correct":true},{"text":"Pour les risques décès et invalidité ainsi que pour l''épargne","correct":false}]'::jsonb, 2,
       'Base légale : Art. 2, al. 3 LPP.', 'formation_externe', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'garantie_revenus'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'EXT-LPP-023', 'vie', t.id, 'single',
       NULL, 'Qui paie les cotisations épargne de la LPP ?', '[{"text":"L''employé paie l''entier des cotisations","correct":false},{"text":"L''employeur paie l''entier des cotisations","correct":false},{"text":"L''employé, l''employeur et la Confédération","correct":false},{"text":"L''employé et l''employeur","correct":true}]'::jsonb, 1,
       'Base légale : Art. 66 LPP.', 'formation_externe', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'retraite'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'EXT-LPP-024', 'vie', t.id, 'multiple',
       NULL, 'Selon la loi, arrivé à la retraite, quel pourcentage de son avoir de prévoyance un assuré peut-il retirer en capital ?', '[{"text":"Au maximum 25 %","correct":true},{"text":"Au minimum 25 %","correct":false},{"text":"Il peut dans tous les cas retirer l''entier de son savoir","correct":false},{"text":"Il peut retirer l''entier de son avoir, si le règlement de prévoyance le prévoit","correct":true}]'::jsonb, 2,
       'Base légale : Art. 37 LPP.', 'formation_externe', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'retraite'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'EXT-LPP-025', 'vie', t.id, 'multiple',
       NULL, 'Jusqu''à quel âge une rente pour enfant d''invalide peut-elle être versée ?', '[{"text":"Jusqu''à 18 ans, s''il poursuit des études","correct":false},{"text":"Jusqu''à 18 ans, même s''il ne poursuit pas d''études","correct":true},{"text":"Jusqu''à 25 ans, s''il poursuit des études","correct":true},{"text":"Jusqu''à 25 ans, même s''il ne poursuit pas d''études","correct":false}]'::jsonb, 2,
       'Base légale : Art. 22, al. 3 LPP.', 'formation_externe', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'retraite'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'EXT-LPP-026', 'vie', t.id, 'multiple',
       NULL, 'Parmi les cas ci-dessous, lesquels donnent droit à une rente de veuve ?', '[{"text":"Femme de 45 ans, sans enfant et mariée depuis 3 ans","correct":false},{"text":"Femme de 35 ans, un enfant de 7 ans et mariée depuis 9 ans","correct":true},{"text":"Femme de 44 ans, mariée depuis 10 ans et sans enfant","correct":false},{"text":"Femme de 50 ans, vivant en concubinage depuis 7 ans et sans enfant","correct":false},{"text":"Femme de 28 ans, mariée depuis 3 ans et un enfant de 1 an","correct":true},{"text":"Femme de 57 ans, sans enfant et mariée depuis 12 ans","correct":true}]'::jsonb, 3,
       'Base légale : Art. 19, al. 1 LPP.', 'formation_externe', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'garantie_revenus'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'EXT-LPP-027', 'vie', t.id, 'single',
       NULL, 'Quelles sont les conditions à remplir pour l''octroi d''une rente de veuve divorcée ?', '[{"text":"Au moins 5 ans de mariage avec le défunt et avoir un enfant commun","correct":false},{"text":"Au moins 5 ans de mariage avec le défunt et bénéficier d''une pension alimentaire lors du décès","correct":false},{"text":"Au moins 10 ans de mariage avec le défunt et bénéficier d''une pension alimentaire lors du décès","correct":true},{"text":"Au moins 10 ans de mariage avec le défunt et avoir un enfant commun","correct":false}]'::jsonb, 1,
       'Base légale : Art. 20, al. 1 OPP 2.', 'formation_externe', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'garantie_revenus'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'EXT-LPP-028', 'vie', t.id, 'single',
       NULL, 'Quand est-ce qu''une rente de veuve s''éteint ?', '[{"text":"Lorsque le dernier des enfants atteint l''âge de 18 ans","correct":false},{"text":"Lorsque le dernier des enfants atteint l''âge de 25 ans","correct":false},{"text":"Lorsque la veuve atteint l''âge de la retraite","correct":false},{"text":"Lors du décès de la veuve","correct":true},{"text":"Lorsque la veuve vie à nouveau en concubinage","correct":false}]'::jsonb, 1,
       'Base légale : Art. 22, al. 2 LPP.', 'formation_externe', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'garantie_revenus'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'EXT-LPP-029', 'vie', t.id, 'single',
       NULL, 'Lorsqu''une veuve ne remplit pas les conditions pour l''octroi d''une rente de veuve, elle a droit une indemnité unique en capital. Quel est ce montant ?', '[{"text":"Un capital égal à 1 rente annuelle de veuve","correct":false},{"text":"Un capital égal à 3 rentes annuelles de veuve","correct":true},{"text":"Un capital égal à 5 rentes annuelles de veuve","correct":false}]'::jsonb, 1,
       'Base légale : Art. 19, al. 2 LPP.', 'formation_externe', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'garantie_revenus'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'EXT-LPP-030', 'vie', t.id, 'multiple',
       NULL, 'Parmi les réponses suivantes, lesquelles se rapportent au système de capitalisation ?', '[{"text":"Les recettes d''une année servent à couvrir les dépenses de la même année","correct":false},{"text":"Un avoir de vieillesse est constitué pour financer les prestations dues","correct":true},{"text":"Chaque assuré constitue sa propre épargne","correct":true},{"text":"La Confédération contribue à son financement","correct":false}]'::jsonb, 2,
       NULL, 'formation_externe', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'retraite'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'EXT-LPP-031', 'vie', t.id, 'multiple',
       NULL, 'Parmi les réponses suivantes, lesquelles se rapportent à la primauté des prestations ?', '[{"text":"Les prestations sont fixées en premier lieu et ensuite les cotisations","correct":true},{"text":"Les cotisations sont fixées en premier lieu et ensuite les prestations","correct":false},{"text":"En cas de retrait anticipé les couvertures de risques diminuent","correct":false},{"text":"En cas de retrait total ou partiel les couvertures de risques restent inchangées","correct":true}]'::jsonb, 2,
       NULL, 'formation_externe', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'retraite'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'EXT-LPP-032', 'vie', t.id, 'single',
       NULL, 'Quel est le montant minimum d''un retrait LPP ?', '[{"text":"Aucun","correct":false},{"text":"10''000","correct":false},{"text":"20''000","correct":true},{"text":"25''000","correct":false}]'::jsonb, 1,
       NULL, 'formation_externe', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'retraite'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'EXT-LPP-033', 'vie', t.id, 'multiple',
       NULL, 'Parmi les personnes suivantes, lesquelles ne sont pas soumises à la LPP ?', '[{"text":"Salariés engagés pour une durée limitée à 12 mois","correct":false},{"text":"Salariés engagés pour une durée de 3 mois","correct":true},{"text":"Personnes à l''AI dont le degré d''invalidité est au moins de 70 %","correct":true},{"text":"Salariés engagés pour une durée limitée de 4 mois","correct":false}]'::jsonb, 2,
       'Base légale : Art. 1j, al. 1 OPP 2.', 'formation_externe', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'garantie_revenus'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'EXT-LPP-034', 'vie', t.id, 'vrai_faux',
       NULL, 'Une fleuriste avec un salaire annuel brut de CHF 35''000.- et un contrat d''une durée de 3 mois doit obligatoirement être assurée à la LPP.', '[{"text":"Vrai","correct":false},{"text":"Faux","correct":true}]'::jsonb, 1,
       'Base légale : Art. 1j, al. 1, let b OPP 2.', 'formation_externe', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'retraite'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'EXT-LPP-035', 'vie', t.id, 'single',
       NULL, 'Selon l''OPP2, l''âge minimum pour une retraite anticipée en prévoyance professionnelle est de … (en dehors des professions avec des exigences spécifiques) ?', '[{"text":"50","correct":false},{"text":"55","correct":false},{"text":"58","correct":true},{"text":"59","correct":false},{"text":"60","correct":false}]'::jsonb, 1,
       NULL, 'formation_externe', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'retraite'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'EXT-LPP-036', 'vie', t.id, 'multiple',
       NULL, 'Parmi les prestations suivantes, lesquelles sont prévues par la LPP ?', '[{"text":"Rente de vieillesse","correct":true},{"text":"Rente de veuve/veuf","correct":true},{"text":"Rente d''orphelin","correct":true},{"text":"Rente d''invalidité pour enfant","correct":false},{"text":"Rente d''invalidité complémentaire pour conjoint","correct":false},{"text":"Rente pour enfant d''invalide","correct":true}]'::jsonb, 4,
       'Base légale : Art. 13 à 26a LPP.', 'formation_externe', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'garantie_revenus'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'EXT-LPP-037', 'vie', t.id, 'single',
       NULL, 'Monsieur Moulin souhaite effectuer un retrait anticipé de sa caisse de pension afin de financer sa résidence principale. Il est assuré en primauté des prestations. De combien se rédui rait la rente d''orphelin s''il retire 75''000.- ? de retrait anticipé', '[{"text":"0","correct":true},{"text":"1''020","correct":false},{"text":"5''100","correct":false},{"text":"1''360","correct":false},{"text":"6''800","correct":false}]'::jsonb, 1,
       NULL, 'formation_externe', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'garantie_revenus'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'EXT-LPP-038', 'vie', t.id, 'single',
       NULL, 'Monsieur Moulin souhaite effectuer un retrait anticipé de sa caisse de pension afin de financer sa résidence principale. Il est assuré en primauté des c otisations. De combien se rédui rait la rente de veuve s''il retire 75''000.- ?', '[{"text":"0","correct":false},{"text":"3''060","correct":true},{"text":"5''100","correct":false},{"text":"4''080","correct":false},{"text":"6''800","correct":false}]'::jsonb, 1,
       NULL, 'formation_externe', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'garantie_revenus'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'EXT-LPP-039', 'vie', t.id, 'single',
       NULL, 'Monsieur Moulin souhaite effectuer un retrait anticipé de sa caisse de pension afin de financer sa résidence principale. Il est assuré en primauté des cotisations. De combien se rédui rait sa rente d''invalidité s''il retire 75''000.- ?', '[{"text":"0","correct":false},{"text":"3''060","correct":false},{"text":"5''100","correct":true},{"text":"4''060","correct":false},{"text":"6''800","correct":false}]'::jsonb, 1,
       NULL, 'formation_externe', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'garantie_revenus'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'EXT-LPP-040', 'vie', t.id, 'multiple',
       NULL, 'Mr. Barman quitte son emploi afin de se lancer en tant qu''indépendant. Il décide de ne pas s''affilier à un 2ème pilier et son avoir doit être transféré à l''institution supplétive. Sans nouvelles de Mr. Barman, a près quel délai l ''institution de prévoyance de son anci en employeur doit-elle obligatoirement transférer l''avoir de libre passage ?', '[{"text":"Aucun délai n''est fixé","correct":false},{"text":"Après 6 mois au plus tôt","correct":true},{"text":"Après 6 mois au maximum","correct":false},{"text":"Après 1 an au plus tôt","correct":false},{"text":"Après 1 an au maximum","correct":false},{"text":"Après 2 ans au plus tôt","correct":false},{"text":"Après 2 ans au maximum","correct":true}]'::jsonb, 1,
       NULL, 'formation_externe', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'epargne'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'EXT-LPP-041', 'vie', t.id, 'single',
       NULL, 'Pour l''achat de sa maison, Mr. Barman effectue un retrait EPL. Ce retrait figurera sur le registre foncier. Comment appelle-t''on ce terme ?', '[{"text":"Une inscription","correct":false},{"text":"Une mention","correct":true},{"text":"Une annotation","correct":false}]'::jsonb, 1,
       'Base légale : Art. 30e, al. 2 LPP.', 'formation_externe', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'epargne'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'EXT-LPP-042', 'vie', t.id, 'single',
       NULL, 'Pour l''achat d''une maison, Mr. Barman souhaite effectuer un retrait EPL. Néanmoins, il pense divorcer de son épouse avec laquelle il a souvent des disputes. Il vous demande alors votre avis. Parmi les réponses suivantes, choisissez celle qui correspond à la loi.', '[{"text":"Comme il va probablement divorcer, Monsieur Barman peut effectuer un retrait EPL sans l''accord de son épouse","correct":false},{"text":"Monsieur Barman peut effectuer un retrait EPL uniquement avec l''accord oral de son épouse","correct":false},{"text":"Monsieur Barman peut effectuer un retrait EPL uniquement avec l''accord écrit de son épouse","correct":true}]'::jsonb, 1,
       'Base légale : Art. 30c, al. 5 LPP.', 'formation_externe', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'epargne'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'EXT-LPP-043', 'vie', t.id, 'single',
       NULL, 'Monsieur Chevalley souhaite effectuer un remboursement d''une partie de son retrait EPL. Quel est le montant minimum ?', '[{"text":"Aucun","correct":false},{"text":"10''000","correct":true},{"text":"20''000","correct":false}]'::jsonb, 1,
       NULL, 'formation_externe', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'epargne'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'EXT-LPP-044', 'vie', t.id, 'multiple',
       NULL, 'Jusqu''à quand un remboursement EPL peut-il être effectué ?', '[{"text":"Jusqu''à 2 ans avant la retraite","correct":false},{"text":"Jusqu''à 3 ans avant la retraite","correct":true},{"text":"Jusqu''à 5 ans avant la retraite","correct":false},{"text":"Jusqu''à la survenance d''un cas de prévoyance","correct":true}]'::jsonb, 2,
       'Base légale : Art. 30d, al. 3 LPP.', 'formation_externe', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'epargne'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'EXT-LPP-045', 'vie', t.id, 'single',
       NULL, 'Votre client souhaite effectuer différents rachats auprès de sa caisse de pension à hauteur de CHF 15''000.- par an durant 5 ans. Il y a 9 ans, votre client a fait un retrait EPL de CHF 100''000.-. Parmi les affirmations suivantes,', '[{"text":"Il peut sans autre effectuer les rachats prévus pendant 5 ans","correct":false},{"text":"Il peut sans autre effectuer les rachats prévu pendant 5 ans, à condition que son épouse ait donné son accord écrit","correct":false},{"text":"Il ne peut pas effectuer de rachat. Il doit d''abord rembourser le retrait EPL","correct":true},{"text":"Il peut effectuer des rachats selon la lacune calculée par la caisse de pension","correct":false}]'::jsonb, 1,
       'Base légale : Art. 79b, al. 3 LPP.', 'formation_externe', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'epargne'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'EXT-LPP-046', 'vie', t.id, 'single',
       NULL, 'Peut-on effectuer un rachat auprès de la caisse de pension grâce à un compte ou une police 3a afin d''augmenter les prestations de prévoyance ?  autorisé (Art. 3, al. 2, let. b OPP3). Néanmoins, les contributions déjà déduites du revenu imposable une 1ère fois ne peuvent pas l''être à nouveau.', '[{"text":"Oui. Le rachat sera également déductible du revenu imposable","correct":false},{"text":"Oui. Le rachat ne pourra toutefois pas être déduit du revenu imposable","correct":true},{"text":"Non, un tel rachat n''est pas possible","correct":false}]'::jsonb, 1,
       NULL, 'formation_externe', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'epargne'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'EXT-LPP-047', 'vie', t.id, 'vrai_faux',
       NULL, 'Un étranger arrivé en Suisse il y a deux ans peut effectuer un rachat pour la différence entre son avoir actuel de prévoyance et celui qu''il aurait eu s''il savait été affilié depuis ses 25 ans.', '[{"text":"Vrai","correct":false},{"text":"Faux","correct":true}]'::jsonb, 1,
       'Base légale : Art. 60b, al. 1 OPP 2.', 'formation_externe', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'retraite'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'EXT-LPP-048', 'vie', t.id, 'vrai_faux',
       NULL, 'Un rachat LPP augmente toujours les prestations de risques de l''assuré. risques sont assurées en % du salaire assuré. Un rachat n''aura donc aucun impact sur les couvertures de risques.', '[{"text":"Vrai","correct":false},{"text":"Faux","correct":true}]'::jsonb, 1,
       NULL, 'formation_externe', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'retraite'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'EXT-LPP-049', 'vie', t.id, 'vrai_faux',
       NULL, 'À la suite d''un divorce, un rachat ne peut être effectué que lorsque le montant retiré a été remboursé.', '[{"text":"Vrai","correct":false},{"text":"Faux","correct":true}]'::jsonb, 1,
       'Base légale : Art. 22d LFLP / Art. 79b, al. 4 LPP.', 'formation_externe', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'retraite'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'EXT-LPP-050', 'vie', t.id, 'vrai_faux',
       NULL, 'Durant les 10 premières années, une personne venant de l''étranger et jamais affiliée à une institution de prévoyance ne peut effectuer un rachat que pour 20 % de son salaire assuré.', '[{"text":"Vrai","correct":false},{"text":"Faux","correct":true}]'::jsonb, 1,
       'Base légale : Art. 60b, al. 1 OPP 2.', 'formation_externe', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'retraite'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'EXT-LPP-051', 'vie', t.id, 'vrai_faux',
       NULL, 'Lorsque l''employeur n''affilie pas ses employés à une institution de prévoyance comme il est tenu de le faire selon la loi, l''institution supplétive peut procéder à une affiliation d''office.', '[{"text":"Vrai","correct":true},{"text":"Faux","correct":false}]'::jsonb, 1,
       'Base légale : Art. 11, al. 6 LPP.', 'formation_externe', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'retraite'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'EXT-LPP-052', 'vie', t.id, 'single',
       NULL, 'Une entreprise s''est vu résilier son contrat par l''institution de prévoyance auprès de laquelle elle était assurée. Que peut-elle faire à présent ?', '[{"text":"Rien. Elle n''a plus aucune possibilité car aucune institution ne l''acceptera","correct":false},{"text":"S''adresser à une nouvelle institution de prévoyance qui sera obligée de l''accepter, puisque l''affiliation est obligatoire pour les employés","correct":false},{"text":"L''entreprise peut s''adresser à l''institution supplétive qui peut toutefois refuser l''affiliation de l''entreprise et ses employés","correct":false},{"text":"L''entreprise peut s''adresser à l''institution supplétive qui ne peut pas refuser l''affiliation de l''entreprise et ses employés","correct":true}]'::jsonb, 1,
       'Base légale : Art. 11, al. 3bis LPP.', 'formation_externe', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'retraite'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'EXT-LPP-053', 'vie', t.id, 'vrai_faux',
       NULL, 'Une caisse dite enveloppante réunie les prestations obligatoires et surobligatoire dans un seul contrat. C''est la solution privilégiée par les entreprises qui accordent, à une partie de son personnel, des prestations plus généreuses que le minimum légal.', '[{"text":"Vrai","correct":false},{"text":"Faux","correct":true}]'::jsonb, 1,
       NULL, 'formation_externe', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'retraite'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'EXT-LPP-054', 'vie', t.id, 'vrai_faux',
       NULL, 'L''épargne constituée par un employé dans la caisse de pension est soumise à l''impôt sur la fortune.', '[{"text":"Vrai","correct":false},{"text":"Faux","correct":true}]'::jsonb, 1,
       'Base légale : Art, 81, al. 2 LPP.', 'formation_externe', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'retraite'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'EXT-LPP-055', 'vie', t.id, 'multiple',
       NULL, 'Parmi les affirmations suivantes, laquelle ou lesquelles sont correctes ?', '[{"text":"La totalité des cotisations LPP sont déductibles du salaire","correct":false},{"text":"Les cotisations LPP de l''employé sont déductibles du salaire","correct":true},{"text":"Les rentes sont imposées à un taux unique et distinct séparé des autres revenus","correct":false},{"text":"Les capitaux sont imposés à un taux unique et distinct séparé des autres revenus","correct":true},{"text":"Un retrait EPL est imposé à un taux unique et distinct séparé des autres revenus","correct":true},{"text":"Le remboursement d''un retrait EPL donne droit à un remboursement d''impôt","correct":true}]'::jsonb, 4,
       'Base légale : Art, 81, al. 2 LPP / Art. 83a, al. 2 LPP / Art. 331, al. 3 CO.', 'formation_externe', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'epargne'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'EXT-LPP-056', 'vie', t.id, 'multiple',
       NULL, 'Une institution de prévoyance peut décider d''accorder des prestations plus favorables à ses affiliés. Parmi les affirmations suivantes,', '[{"text":"Inclusion d''un capital décès et/ou d''un capital invalidité","correct":true},{"text":"Déduction de coordination selon le taux d''activité","correct":true},{"text":"Suppression de la déduction coordination","correct":true},{"text":"Bonifications de vieillesse jusqu''à 50 % du salaire assuré","correct":false},{"text":"Salaire assuré jusqu''à 15 fois la limite supérieure du salaire LPP obligatoire","correct":false}]'::jsonb, 3,
       NULL, 'formation_externe', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'garantie_revenus'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'EXT-LPP-057', 'vie', t.id, 'multiple',
       NULL, 'Quelles sont les caractéristiques d''une mise en gage de l''avoir de prévoyance ?  pas réalisé, les prestations restent identiques et aucune imposition n''a lieu.', '[{"text":"Diminution des prestations de retraite","correct":false},{"text":"Pas de diminution des prestations de retraite","correct":true},{"text":"Imposition du montant lors de la mise en gage","correct":false},{"text":"Pas d''imposition du montant lors de la mise en gage","correct":true},{"text":"Pas de mention au registre foncier","correct":true}]'::jsonb, 3,
       NULL, 'formation_externe', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'retraite'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'EXT-LPP-058', 'vie', t.id, 'multiple',
       NULL, 'Quelles sont les formes de propriétés autorisées pour un retrait EPL ?', '[{"text":"Propriété commune avec son frère/sa sœur","correct":false},{"text":"Propriété commune avec son concubin/sa concubine","correct":false},{"text":"Propriété commune avec son conjoint/sa conjointe","correct":true},{"text":"Propriété commune avec son/sa partenaire enregistré/e","correct":true},{"text":"Copropriété avec un partenaire","correct":true}]'::jsonb, 3,
       NULL, 'formation_externe', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'epargne'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'EXT-LPP-059', 'vie', t.id, 'multiple',
       NULL, 'Quelles sont les utilisations autorisées pour un retrait EPL ?', '[{"text":"Amortissement de la dette hypothécaire","correct":true},{"text":"Paiement des intérêts de la dette hypothécaire","correct":false},{"text":"Construction d''une résidence secondaire","correct":false},{"text":"La construction de deux villas","correct":false},{"text":"L''achat d''un logement en propriété","correct":true}]'::jsonb, 2,
       NULL, 'formation_externe', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'epargne'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'EXT-LPP-060', 'vie', t.id, 'multiple',
       NULL, 'De quelle manière est imposé le montant du retrait EPL ?', '[{"text":"Les impôts peuvent être payés à l''aide du retrait EPL","correct":false},{"text":"Les impôts ne peuvent pas être payés à l''aide du retrait EPL","correct":true},{"text":"Le taux de l''impôt dépend de la forme de propriété","correct":false},{"text":"Le taux dépend du montant du retrait","correct":true},{"text":"Un impôt sur la fortune est payé lors du retrait","correct":false},{"text":"Les impôts doivent être payés avec des fonds propres","correct":true}]'::jsonb, 3,
       NULL, 'formation_externe', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'epargne'
ON CONFLICT (external_id) DO NOTHING;

-- ───────── nonvie_genere.json — Questions non-vie construites à partir de questionnaires de formation externes (RC entreprise, RC privée et immeubles, protection juridique, choses PME). ─────────
INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'GEN-NV-001', 'non_vie', t.id, 'multiple',
       'Assurance RC d''entreprise et RC professionnelle', 'Quels sont les fondements légaux (bases légales) de l''assurance RC d''entreprise ?', '[{"text":"LCA (traitement juridique des contrats d''assurance)","correct":true},{"text":"CGA (couverture d''assurance)","correct":true},{"text":"Lois fédérales (obligation d''assurance)","correct":true},{"text":"Assurance marchandises","correct":false,"why_wrong":"Proposition tirée d''un autre domaine d''assurance : elle ne fait pas partie de la réponse attendue."},{"text":"Assurance des installations techniques (IT)","correct":false,"why_wrong":"Proposition tirée d''un autre domaine d''assurance : elle ne fait pas partie de la réponse attendue."},{"text":"Supports de données et données enregistrées","correct":false,"why_wrong":"Proposition tirée d''un autre domaine d''assurance : elle ne fait pas partie de la réponse attendue."},{"text":"Droit de la responsabilité civile (responsabilité)","correct":true}]'::jsonb, 3,
       NULL, 'formation_externe', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'non_vie' AND t.key = 'pme'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'GEN-NV-002', 'non_vie', t.id, 'multiple',
       'Assurance RC d''entreprise et RC professionnelle', 'Quels cercles de personnes sont assurés par l''assurance responsabilité civile d''entreprise ?', '[{"text":"Techniques de mesure de film et de photographie","correct":false,"why_wrong":"Proposition tirée d''un autre domaine d''assurance : elle ne fait pas partie de la réponse attendue."},{"text":"Les employés","correct":true},{"text":"Le preneur d''assurance en tant que propriétaire de l''entreprise","correct":true},{"text":"Les membres de la famille de l''entrepreneur qui travaillent dans l''entreprise","correct":true},{"text":"La direction","correct":true},{"text":"Erreur de manipulation","correct":false,"why_wrong":"Proposition tirée d''un autre domaine d''assurance : elle ne fait pas partie de la réponse attendue."},{"text":"Machines de construction de route autopropulsées","correct":false,"why_wrong":"Proposition tirée d''un autre domaine d''assurance : elle ne fait pas partie de la réponse attendue."}]'::jsonb, 3,
       NULL, 'formation_externe', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'non_vie' AND t.key = 'pme'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'GEN-NV-003', 'non_vie', t.id, 'multiple',
       'Assurance RC d''entreprise et RC professionnelle', 'Quels types de dommages (risques assurés) sont inclus dans la RC d''entreprise ?', '[{"text":"Erreur de manipulation","correct":false,"why_wrong":"Proposition tirée d''un autre domaine d''assurance : elle ne fait pas partie de la réponse attendue."},{"text":"Somme d''assurance","correct":false,"why_wrong":"Proposition tirée d''un autre domaine d''assurance : elle ne fait pas partie de la réponse attendue."},{"text":"Dommages matériels","correct":true},{"text":"Dommages économiques consécutifs","correct":true},{"text":"Dommages corporels","correct":true},{"text":"Machines de construction","correct":false,"why_wrong":"Proposition tirée d''un autre domaine d''assurance : elle ne fait pas partie de la réponse attendue."}]'::jsonb, 3,
       NULL, 'formation_externe', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'non_vie' AND t.key = 'pme'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'GEN-NV-004', 'non_vie', t.id, 'multiple',
       'Assurance RC d''entreprise et RC professionnelle', 'Quels éléments déterminent la prime de l''assurance RC d''entreprise ?', '[{"text":"Somme de garantie","correct":true},{"text":"Défauts de conception et de matériel","correct":false,"why_wrong":"Proposition tirée d''un autre domaine d''assurance : elle ne fait pas partie de la réponse attendue."},{"text":"Police individuelle","correct":false,"why_wrong":"Proposition tirée d''un autre domaine d''assurance : elle ne fait pas partie de la réponse attendue."},{"text":"Type d''entreprise","correct":true},{"text":"Taille de l''entreprise","correct":true},{"text":"Malveillance","correct":false,"why_wrong":"Proposition tirée d''un autre domaine d''assurance : elle ne fait pas partie de la réponse attendue."},{"text":"Montant de la franchise","correct":true}]'::jsonb, 3,
       NULL, 'formation_externe', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'non_vie' AND t.key = 'pme'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'GEN-NV-005', 'non_vie', t.id, 'multiple',
       'Assurance RC privée, immeubles et maître de l''ouvrage', 'Quel est le cercle possible des personnes assurées ?', '[{"text":"Défauts de conception et de matériel","correct":false,"why_wrong":"Proposition tirée d''un autre domaine d''assurance : elle ne fait pas partie de la réponse attendue."},{"text":"Autres personnes (employés de maison, enfants mineurs, animaux domestiques)","correct":true},{"text":"Autres personnes selon CGA des compagnies","correct":true},{"text":"Frais fixes maintenus malgré l''arrêt des machines","correct":false,"why_wrong":"Proposition tirée d''un autre domaine d''assurance : elle ne fait pas partie de la réponse attendue."},{"text":"Le preneur d''assurance (P.A.)","correct":true},{"text":"La famille du P.A. vivant en ménage commun","correct":true},{"text":"Installations d''incinération","correct":false,"why_wrong":"Proposition tirée d''un autre domaine d''assurance : elle ne fait pas partie de la réponse attendue."}]'::jsonb, 3,
       NULL, 'formation_externe', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'non_vie' AND t.key = 'propriete_logement'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'GEN-NV-006', 'non_vie', t.id, 'multiple',
       'Assurance RC privée, immeubles et maître de l''ouvrage', 'Quelles sont les exclusions ?', '[{"text":"Les propres dommages","correct":true},{"text":"Frais fixes maintenus malgré l''arrêt des machines","correct":false,"why_wrong":"Proposition tirée d''un autre domaine d''assurance : elle ne fait pas partie de la réponse attendue."},{"text":"Les prétentions pour les dommages entre personnes faisant ménage commun","correct":true},{"text":"Les prétentions pour les dommages entre personnes compris dans une assurance familiale","correct":true},{"text":"Techniques de mesure de film et de photographie","correct":false,"why_wrong":"Proposition tirée d''un autre domaine d''assurance : elle ne fait pas partie de la réponse attendue."},{"text":"Défauts de conception et de matériel ou des vices de fabrication","correct":false,"why_wrong":"Proposition tirée d''un autre domaine d''assurance : elle ne fait pas partie de la réponse attendue."}]'::jsonb, 3,
       NULL, 'formation_externe', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'non_vie' AND t.key = 'propriete_logement'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'GEN-NV-007', 'non_vie', t.id, 'multiple',
       'Assurance RC privée, immeubles et maître de l''ouvrage', 'En quelle qualité un assuré peut-il être tenu responsable ?', '[{"text":"Propriétaire du bâtiment et des constructions érigées sur son terrain (Art. 58 CO)","correct":true},{"text":"Les membres de la famille de l''entrepreneur qui travaillent dans l''entreprise","correct":false,"why_wrong":"Proposition tirée d''un autre domaine d''assurance : elle ne fait pas partie de la réponse attendue."},{"text":"Dommages économiques consécutifs","correct":false,"why_wrong":"Proposition tirée d''un autre domaine d''assurance : elle ne fait pas partie de la réponse attendue."},{"text":"Frais de réparation de la conduite d''eau endommagée par le gel Non couvert","correct":false,"why_wrong":"Proposition tirée d''un autre domaine d''assurance : elle ne fait pas partie de la réponse attendue."},{"text":"Pour les dommages imprévus et soudains causés à l''environnement","correct":true},{"text":"Pour les activités en rapport avec la propriété (Art. 41 CO)","correct":true},{"text":"Propriétaire foncier (Art. 679 CCS)","correct":true}]'::jsonb, 3,
       NULL, 'formation_externe', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'non_vie' AND t.key = 'propriete_logement'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'GEN-NV-008', 'non_vie', t.id, 'multiple',
       'Assurance RC privée, immeubles et maître de l''ouvrage', 'Comment se calcule la prime ?', '[{"text":"Le degré de danger que la construction fait courir au voisinage","correct":true},{"text":"Type de marchandises transportées","correct":false,"why_wrong":"Proposition tirée d''un autre domaine d''assurance : elle ne fait pas partie de la réponse attendue."},{"text":"La somme garantie choisie","correct":true},{"text":"La franchise choisie","correct":true},{"text":"Le montant du coût de la construction","correct":true},{"text":"Biens des clients Valeur à neuf","correct":false,"why_wrong":"Proposition tirée d''un autre domaine d''assurance : elle ne fait pas partie de la réponse attendue."},{"text":"Type d''objet et de risques","correct":false,"why_wrong":"Proposition tirée d''un autre domaine d''assurance : elle ne fait pas partie de la réponse attendue."}]'::jsonb, 3,
       NULL, 'formation_externe', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'non_vie' AND t.key = 'propriete_logement'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'GEN-NV-009', 'non_vie', t.id, 'multiple',
       'Protection juridique, RC véhicules à moteur et assurances diverses', 'Quelles sont les PA dans l''assurance PJ privée (individuelle et famille), la circulation et celle d''entreprise ?', '[{"text":"Le ou les entrepreneurs","correct":true},{"text":"L''entreprise elle-même","correct":true},{"text":"Marchandises achetées Prix de revient","correct":false,"why_wrong":"Proposition tirée d''un autre domaine d''assurance : elle ne fait pas partie de la réponse attendue."},{"text":"La direction","correct":true},{"text":"Les collaborateurs","correct":true},{"text":"Les membres de la famille de l''entrepreneur qui travaillent dans l''entreprise","correct":true},{"text":"Pollution de l''air","correct":false,"why_wrong":"Proposition tirée d''un autre domaine d''assurance : elle ne fait pas partie de la réponse attendue."}]'::jsonb, 3,
       NULL, 'formation_externe', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'non_vie' AND t.key = 'litiges_nv'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'GEN-NV-010', 'non_vie', t.id, 'multiple',
       'Protection juridique, RC véhicules à moteur et assurances diverses', 'Qu''est-ce qu''un véhicule à moteur ?', '[{"text":"Tracteurs et autres véhicules agricoles","correct":true},{"text":"Motos et scooters","correct":true},{"text":"Utilisateur, gardien ou transporteur d''objets confiés par des tiers","correct":false,"why_wrong":"Proposition tirée d''un autre domaine d''assurance : elle ne fait pas partie de la réponse attendue."},{"text":"Machines de construction de route autopropulsées","correct":true},{"text":"Police individuelle","correct":false,"why_wrong":"Proposition tirée d''un autre domaine d''assurance : elle ne fait pas partie de la réponse attendue."},{"text":"Techniques de mesure de film et de photographie","correct":false,"why_wrong":"Proposition tirée d''un autre domaine d''assurance : elle ne fait pas partie de la réponse attendue."},{"text":"Voitures électriques et voitures solaires","correct":true}]'::jsonb, 3,
       NULL, 'formation_externe', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'non_vie' AND t.key = 'litiges_nv'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'GEN-NV-011', 'non_vie', t.id, 'multiple',
       'Protection juridique, RC véhicules à moteur et assurances diverses', 'Quels sont les éléments généralement couverts par l''assurance voyage ?', '[{"text":"Protection de voyage","correct":true},{"text":"Les employés","correct":false,"why_wrong":"Proposition tirée d''un autre domaine d''assurance : elle ne fait pas partie de la réponse attendue."},{"text":"Assistance en cas de panne","correct":true},{"text":"Assurance de machines","correct":false,"why_wrong":"Proposition tirée d''un autre domaine d''assurance : elle ne fait pas partie de la réponse attendue."},{"text":"Remplacement du voyage","correct":true},{"text":"Annulation de voyage","correct":true},{"text":"Chiropracticiens","correct":false,"why_wrong":"Proposition tirée d''un autre domaine d''assurance : elle ne fait pas partie de la réponse attendue."}]'::jsonb, 3,
       NULL, 'formation_externe', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'non_vie' AND t.key = 'litiges_nv'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'GEN-NV-012', 'non_vie', t.id, 'multiple',
       'Assurance de choses pour PME : commerce', 'Indiquez si les exemples de sinistres suivants sont couverts ou exclus par l''assurance de chose de', '[{"text":"Assurance des installations techniques (IT)","correct":false,"why_wrong":"Proposition tirée d''un autre domaine d''assurance : elle ne fait pas partie de la réponse attendue."},{"text":"Frais de réparation de la conduite d''eau endommagée par le gel Non couvert","correct":true},{"text":"Propriétaire de l''ouvrage (RC Bâtiment et autres ouvrages)","correct":false,"why_wrong":"Proposition tirée d''un autre domaine d''assurance : elle ne fait pas partie de la réponse attendue."},{"text":"Défauts de conception et de matériel","correct":false,"why_wrong":"Proposition tirée d''un autre domaine d''assurance : elle ne fait pas partie de la réponse attendue."},{"text":"Outils volés dans le camion de livraison ouvert Non couvert","correct":true}]'::jsonb, 2,
       NULL, 'formation_externe', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'non_vie' AND t.key = 'pme'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'GEN-NV-013', 'non_vie', t.id, 'multiple',
       'Assurance de choses pour PME : transport', 'Quels éléments sont importants pour le calcul de la prime ?', '[{"text":"Etendue de la couverture d''assurance","correct":true},{"text":"Moyens de transport","correct":true},{"text":"Durée du montage","correct":false,"why_wrong":"Proposition tirée d''un autre domaine d''assurance : elle ne fait pas partie de la réponse attendue."},{"text":"Type de marchandises transportées","correct":true},{"text":"Installations d''incinération","correct":false,"why_wrong":"Proposition tirée d''un autre domaine d''assurance : elle ne fait pas partie de la réponse attendue."},{"text":"Employeur de personnel domestique","correct":false,"why_wrong":"Proposition tirée d''un autre domaine d''assurance : elle ne fait pas partie de la réponse attendue."},{"text":"Somme d''assurance","correct":true}]'::jsonb, 3,
       NULL, 'formation_externe', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'non_vie' AND t.key = 'pme'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'GEN-NV-014', 'non_vie', t.id, 'multiple',
       'Assurance de choses pour PME : installations techniques', 'Indiquez trois branches de l''assurance technique', '[{"text":"Assurance casco de machines","correct":true},{"text":"Assurance de montage","correct":true},{"text":"Valeurs pécuniaires Premier risque","correct":false,"why_wrong":"Proposition tirée d''un autre domaine d''assurance : elle ne fait pas partie de la réponse attendue."},{"text":"Assurance des installations techniques (IT)","correct":true},{"text":"Assurance de machines","correct":true},{"text":"La franchise choisie","correct":false,"why_wrong":"Proposition tirée d''un autre domaine d''assurance : elle ne fait pas partie de la réponse attendue."},{"text":"Assurance d''équipement informatique","correct":true}]'::jsonb, 3,
       NULL, 'formation_externe', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'non_vie' AND t.key = 'pme'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'GEN-NV-015', 'non_vie', t.id, 'multiple',
       'Assurance de choses pour PME : installations techniques', 'Indiquez trois facteurs déterminants pour le calcul de la prime d''assurance de machines', '[{"text":"Montant de la franchise","correct":true},{"text":"Type de machine","correct":true},{"text":"Les propres dommages","correct":false,"why_wrong":"Proposition tirée d''un autre domaine d''assurance : elle ne fait pas partie de la réponse attendue."},{"text":"Assurance marchandises","correct":false,"why_wrong":"Proposition tirée d''un autre domaine d''assurance : elle ne fait pas partie de la réponse attendue."},{"text":"Annulation de voyage","correct":false,"why_wrong":"Proposition tirée d''un autre domaine d''assurance : elle ne fait pas partie de la réponse attendue."},{"text":"Somme d''assurance","correct":true}]'::jsonb, 3,
       NULL, 'formation_externe', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'non_vie' AND t.key = 'pme'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'GEN-NV-016', 'non_vie', t.id, 'multiple',
       'Assurance de choses pour PME : installations techniques', 'Nommez trois risques couverts par l''assurance de montage', '[{"text":"Erreurs de planification et de calcul","correct":true},{"text":"Evénements naturels","correct":true},{"text":"Négligence ou dommage intentionnel","correct":true},{"text":"Erreur de manipulation","correct":true},{"text":"Dépens (indemnité de procédure allouée à la partie adverse)","correct":false,"why_wrong":"Proposition tirée d''un autre domaine d''assurance : elle ne fait pas partie de la réponse attendue."},{"text":"Les propres dommages","correct":false,"why_wrong":"Proposition tirée d''un autre domaine d''assurance : elle ne fait pas partie de la réponse attendue."},{"text":"Défauts de conception et de matériel ou des vices de fabrication","correct":true}]'::jsonb, 3,
       NULL, 'formation_externe', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'non_vie' AND t.key = 'pme'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'GEN-NV-017', 'non_vie', t.id, 'multiple',
       'Assurance de choses pour PME : installations techniques', 'Indiquez trois facteurs déterminants pour le calcul de la prime d''assurance de montage', '[{"text":"Dommages matériels","correct":false,"why_wrong":"Proposition tirée d''un autre domaine d''assurance : elle ne fait pas partie de la réponse attendue."},{"text":"Somme d''assurance","correct":true},{"text":"Type d''objet et de risques","correct":true},{"text":"Durée du montage","correct":true},{"text":"Motos et scooters","correct":false,"why_wrong":"Proposition tirée d''un autre domaine d''assurance : elle ne fait pas partie de la réponse attendue."},{"text":"Police individuelle","correct":false,"why_wrong":"Proposition tirée d''un autre domaine d''assurance : elle ne fait pas partie de la réponse attendue."}]'::jsonb, 3,
       NULL, 'formation_externe', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'non_vie' AND t.key = 'pme'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'GEN-NV-018', 'non_vie', t.id, 'multiple',
       'Assurance de choses pour PME : installations techniques', 'Nommez trois risques couverts par l''assurance casco de machines', '[{"text":"Droit du travail","correct":false,"why_wrong":"Proposition tirée d''un autre domaine d''assurance : elle ne fait pas partie de la réponse attendue."},{"text":"Montant de la franchise","correct":false,"why_wrong":"Proposition tirée d''un autre domaine d''assurance : elle ne fait pas partie de la réponse attendue."},{"text":"Chute ou enlisement","correct":true},{"text":"Annulation de voyage","correct":false,"why_wrong":"Proposition tirée d''un autre domaine d''assurance : elle ne fait pas partie de la réponse attendue."},{"text":"Vent et tempête","correct":true},{"text":"Renversement","correct":true}]'::jsonb, 3,
       NULL, 'formation_externe', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'non_vie' AND t.key = 'pme'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'GEN-NV-019', 'non_vie', t.id, 'multiple',
       'Assurance de choses pour PME : installations techniques', 'Indiquez trois facteurs déterminants pour le calcul de la prime d''assurance casco de machines', '[{"text":"Droit des patients","correct":false,"why_wrong":"Proposition tirée d''un autre domaine d''assurance : elle ne fait pas partie de la réponse attendue."},{"text":"Droits réels","correct":false,"why_wrong":"Proposition tirée d''un autre domaine d''assurance : elle ne fait pas partie de la réponse attendue."},{"text":"Type d''objet et de risques","correct":true},{"text":"Somme d''assurance","correct":true},{"text":"Lois fédérales (obligation d''assurance)","correct":false,"why_wrong":"Proposition tirée d''un autre domaine d''assurance : elle ne fait pas partie de la réponse attendue."}]'::jsonb, 2,
       NULL, 'formation_externe', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'non_vie' AND t.key = 'pme'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'GEN-NV-020', 'non_vie', t.id, 'multiple',
       'Assurance de choses pour PME : installations techniques', 'Nommez trois risques couverts par l''assurance d''équipement informatique', '[{"text":"Action de l''humidité","correct":true},{"text":"Erreur de manipulation","correct":true},{"text":"Décharges électriques","correct":true},{"text":"Pollution de l''air","correct":true},{"text":"La franchise choisie","correct":false,"why_wrong":"Proposition tirée d''un autre domaine d''assurance : elle ne fait pas partie de la réponse attendue."},{"text":"Corps étrangers","correct":true},{"text":"Effets du personnel Premier risque","correct":false,"why_wrong":"Proposition tirée d''un autre domaine d''assurance : elle ne fait pas partie de la réponse attendue."}]'::jsonb, 3,
       NULL, 'formation_externe', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'non_vie' AND t.key = 'pme'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'GEN-NV-021', 'non_vie', t.id, 'multiple',
       'Assurance de choses pour PME : installations techniques', 'Quels sont les objets et secteurs qui peuvent être couverts par l''assurance d''équipement informatique ?', '[{"text":"Cycliste ou conducteur de mobylette","correct":false,"why_wrong":"Proposition tirée d''un autre domaine d''assurance : elle ne fait pas partie de la réponse attendue."},{"text":"Le montant du coût de la construction","correct":false,"why_wrong":"Proposition tirée d''un autre domaine d''assurance : elle ne fait pas partie de la réponse attendue."},{"text":"Installations électroniques de traitement des données et infrastructure","correct":true},{"text":"Supports de données et données enregistrées","correct":true},{"text":"Frais supplémentaires pour le maintien du traitement des données","correct":true},{"text":"Les prétentions pour les dommages entre personnes faisant ménage commun","correct":false,"why_wrong":"Proposition tirée d''un autre domaine d''assurance : elle ne fait pas partie de la réponse attendue."}]'::jsonb, 3,
       NULL, 'formation_externe', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'non_vie' AND t.key = 'pme'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'GEN-NV-022', 'non_vie', t.id, 'multiple',
       'Assurance de choses pour PME : installations techniques', 'Indiquez trois facteurs déterminants pour le calcul de la prime d''assurance d''équipement informatique', '[{"text":"Somme d''assurance","correct":true},{"text":"Valeurs pécuniaires Premier risque","correct":false,"why_wrong":"Proposition tirée d''un autre domaine d''assurance : elle ne fait pas partie de la réponse attendue."},{"text":"Dommages économiques consécutifs","correct":false,"why_wrong":"Proposition tirée d''un autre domaine d''assurance : elle ne fait pas partie de la réponse attendue."},{"text":"Type d''objet et de risques","correct":true},{"text":"L''entreprise elle-même","correct":false,"why_wrong":"Proposition tirée d''un autre domaine d''assurance : elle ne fait pas partie de la réponse attendue."}]'::jsonb, 2,
       NULL, 'formation_externe', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'non_vie' AND t.key = 'pme'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'GEN-NV-023', 'non_vie', t.id, 'multiple',
       'Assurance de choses pour PME : installations techniques', 'Nommez trois risques couverts par l''assurance des installations techniques', '[{"text":"Défauts de conception et de matériel","correct":true},{"text":"Les collaborateurs","correct":false,"why_wrong":"Proposition tirée d''un autre domaine d''assurance : elle ne fait pas partie de la réponse attendue."},{"text":"Malveillance","correct":true},{"text":"Droit des assurances","correct":false,"why_wrong":"Proposition tirée d''un autre domaine d''assurance : elle ne fait pas partie de la réponse attendue."},{"text":"Erreur de manipulation","correct":true},{"text":"Vent et tempête","correct":true},{"text":"Décharges électriques","correct":true}]'::jsonb, 3,
       NULL, 'formation_externe', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'non_vie' AND t.key = 'pme'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'GEN-NV-024', 'non_vie', t.id, 'multiple',
       'Assurance de choses pour PME : installations techniques', 'Quels objets peuvent être couverts par l''assurance des installations techniques ?', '[{"text":"Moyens de transport","correct":false,"why_wrong":"Proposition tirée d''un autre domaine d''assurance : elle ne fait pas partie de la réponse attendue."},{"text":"La somme garantie choisie","correct":false,"why_wrong":"Proposition tirée d''un autre domaine d''assurance : elle ne fait pas partie de la réponse attendue."},{"text":"Dispositif de signalisation","correct":true},{"text":"Techniques de mesure de film et de photographie","correct":true},{"text":"Enseignes lumineuses","correct":true},{"text":"Type de marchandises transportées","correct":false,"why_wrong":"Proposition tirée d''un autre domaine d''assurance : elle ne fait pas partie de la réponse attendue."}]'::jsonb, 3,
       NULL, 'formation_externe', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'non_vie' AND t.key = 'pme'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'GEN-NV-025', 'non_vie', t.id, 'multiple',
       'Assurance de choses pour PME : installations techniques', 'Indiquez trois facteurs déterminants pour le calcul de la prime d''assurance des installations techniques', '[{"text":"Réparation civile","correct":false,"why_wrong":"Proposition tirée d''un autre domaine d''assurance : elle ne fait pas partie de la réponse attendue."},{"text":"Le montant du coût de la construction","correct":false,"why_wrong":"Proposition tirée d''un autre domaine d''assurance : elle ne fait pas partie de la réponse attendue."},{"text":"Type d''objet et de risques","correct":true},{"text":"Chef de famille","correct":false,"why_wrong":"Proposition tirée d''un autre domaine d''assurance : elle ne fait pas partie de la réponse attendue."},{"text":"Somme d''assurance","correct":true}]'::jsonb, 2,
       NULL, 'formation_externe', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'non_vie' AND t.key = 'pme'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'GEN-NV-026', 'non_vie', t.id, 'multiple',
       'Assurance de choses pour PME : installations techniques', 'Quelles catégories de dommages peuvent être couvertes par l''assurance perte d''exploitation machines ?', '[{"text":"Gains perdus","correct":true},{"text":"Personne privée (particulier) pour son propre comportement","correct":false,"why_wrong":"Proposition tirée d''un autre domaine d''assurance : elle ne fait pas partie de la réponse attendue."},{"text":"Frais supplémentaires pour des travaux devant être attribués à l''extérieur","correct":true},{"text":"Marchandises achetées Prix de revient","correct":false,"why_wrong":"Proposition tirée d''un autre domaine d''assurance : elle ne fait pas partie de la réponse attendue."},{"text":"Frais fixes maintenus malgré l''arrêt des machines","correct":true},{"text":"Le preneur d''assurance en tant que propriétaire de l''entreprise","correct":false,"why_wrong":"Proposition tirée d''un autre domaine d''assurance : elle ne fait pas partie de la réponse attendue."}]'::jsonb, 3,
       NULL, 'formation_externe', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'non_vie' AND t.key = 'pme'
ON CONFLICT (external_id) DO NOTHING;

-- ───────── nonvie_klary_complement.json — Banque Klary — complément NON-VIE couvrant vehicule, voyages et conseil_nv. Ces 3 thèmes manquaient au seed initial issu du programme externe. ─────────
INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-NV-VH-001', 'non_vie', t.id, 'single',
       NULL, 'En Suisse, quelle assurance véhicule est obligatoire par la loi ?', '[{"text":"Casco complète","correct":false,"why_wrong":"Toujours facultative, même en leasing (exigence contractuelle, pas légale)."},{"text":"Responsabilité civile véhicule (RC)","correct":true},{"text":"Casco partielle","correct":false,"why_wrong":"Facultative."},{"text":"Occupants + RC","correct":false,"why_wrong":"Occupants toujours facultative."}]'::jsonb, 1,
       'Art. 63 LCR : RC véhicule OBLIGATOIRE. Sans attestation, aucun permis de circulation. Somme légale minimale : 5 millions CHF par sinistre depuis 2015 (art. 3 OAV).', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'non_vie' AND t.key = 'vehicule'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-NV-VH-002', 'non_vie', t.id, 'multiple',
       NULL, 'Parmi les événements suivants, lesquels sont couverts par la casco PARTIELLE ?', '[{"text":"Vol du véhicule","correct":true},{"text":"Grêle, chute de pierres, tempête","correct":true},{"text":"Bris de glace","correct":true},{"text":"Collision avec un animal sauvage","correct":true},{"text":"Collision avec un autre véhicule par faute du conducteur","correct":false,"why_wrong":"C''est la casco COMPLÈTE qui couvre les dommages de collision par faute propre."},{"text":"Incendie et forces de la nature","correct":true}]'::jsonb, 2,
       'Casco partielle = événements NON dus à la conduite : vol, feu, nature, animaux, bris de glace. Casco complète = casco partielle + dommages de collision par faute propre (le seul cas où la RC de l''autre ne paie pas).', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'non_vie' AND t.key = 'vehicule'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-NV-VH-003', 'non_vie', t.id, 'single',
       NULL, 'Un client provoque un accident et déclenche sa casco complète pour couvrir son véhicule. Quel impact sur son degré de bonus ?', '[{"text":"Aucun impact, la casco est indépendante de la RC","correct":false,"why_wrong":"Le bonus/malus casco existe aussi, à ne pas confondre."},{"text":"Recul du degré de bonus casco (malus)","correct":true},{"text":"Seul le bonus RC recule","correct":false,"why_wrong":"La RC recule uniquement quand elle-même est mise en cause, pas la casco propre."},{"text":"Perte de 5 ans de bonus","correct":false,"why_wrong":"Non standardisé : dépend du barème de chaque assureur."}]'::jsonb, 1,
       'Bonus/malus séparés RC et casco. Une casco propre déclenchée recule seulement le bonus casco. Un accident dont il est responsable recule ET la RC (car l''assureur RC de la victime paie) ET la casco (car il paie ses propres dégâts).', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'non_vie' AND t.key = 'vehicule'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-NV-VH-004', 'non_vie', t.id, 'single',
       NULL, 'Que couvre le Fonds national de garantie automobile suisse ?', '[{"text":"Les dommages causés aux véhicules stationnés par des inconnus","correct":false,"why_wrong":"Piège : ce serait dommages parking, propre à la casco."},{"text":"Les dommages causés par un véhicule non identifié, non assuré ou volé","correct":true},{"text":"Les frais de dépannage à l''étranger","correct":false},{"text":"Les frais de justice après procès pénal","correct":false}]'::jsonb, 1,
       'Art. 76 LCR : Fonds national de garantie intervient quand la RC ne peut pas payer (véhicule non identifié après délit de fuite, véhicule non assuré, véhicule volé sans couverture).', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'non_vie' AND t.key = 'vehicule'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-NV-VH-005', 'non_vie', t.id, 'single',
       NULL, 'Un client en leasing sur 4 ans. Quelle option casco lui recommandez-vous en priorité ?', '[{"text":"Casco partielle seulement (moins chère)","correct":false,"why_wrong":"Ne couvre pas la collision par faute propre : dette de leasing exposée."},{"text":"Casco complète pendant toute la durée du leasing","correct":true},{"text":"Aucune casco, juste la RC obligatoire","correct":false,"why_wrong":"Aucune banque de leasing ne l''accepte, et le risque de dette résiduelle est majeur."},{"text":"Casco complète seulement les 2 premières années","correct":false,"why_wrong":"Piège : oui certains assureurs proposent ça, mais le contrat de leasing exige normalement la casco complète pour TOUTE la durée."}]'::jsonb, 1,
       'Contrat de leasing = obligation contractuelle de casco complète pour toute la durée. Si sinistre total sans casco complète : le loueur/preneur reste redevable de la valeur résiduelle du véhicule.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'non_vie' AND t.key = 'vehicule'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-NV-VH-006', 'non_vie', t.id, 'single',
       NULL, 'Un jeune conducteur (18 ans, permis depuis 6 mois) demande une casco complète. Que se passe-t-il en général chez les assureurs suisses ?', '[{"text":"Prime standard, aucun impact","correct":false},{"text":"Surprime jeune conducteur ou franchise renforcée les premières années","correct":true},{"text":"Refus systématique","correct":false,"why_wrong":"Aucun assureur ne refuse par principe, mais les conditions sont durcies."},{"text":"Passage obligatoire par le Bureau national d''assurance","correct":false}]'::jsonb, 1,
       'Pratique du marché : jeunes conducteurs et permis récents = statistiquement à risque. Surprime + franchise supplémentaire jusqu''à ~25 ans ou 3 ans de permis sans sinistre. À signaler dès le premier entretien.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'non_vie' AND t.key = 'vehicule'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-NV-VG-001', 'non_vie', t.id, 'single',
       NULL, 'Quelle assurance couvre les frais médicaux d''un touriste suisse hospitalisé aux États-Unis après un accident ?', '[{"text":"La LAMal seule, au tarif suisse doublé","correct":false,"why_wrong":"Piège : LAMal couvre urgence à l''étranger au double du tarif suisse, largement insuffisant aux États-Unis."},{"text":"La LAA obligatoire, sans plafond","correct":false,"why_wrong":"LAA couvre l''accident mais pas au tarif US ; la couverture voyage LCA complète."},{"text":"L''assurance voyage LCA prend en charge le solde après LAMal/LAA","correct":true},{"text":"Aucune, les frais sont à la charge du touriste","correct":false}]'::jsonb, 1,
       'PIÈGE MAJEUR : la LAMal couvre l''urgence étranger au maximum au double du tarif suisse (art. 36 OAMal). Un séjour hospitalier aux États-Unis coûte 10 à 20 x. L''assurance voyage LCA complète est INDISPENSABLE hors Europe.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'non_vie' AND t.key = 'voyages'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-NV-VG-002', 'non_vie', t.id, 'multiple',
       NULL, 'Quels motifs d''annulation sont TYPIQUEMENT couverts par une assurance annulation voyage ?', '[{"text":"Maladie ou accident grave de l''assuré","correct":true},{"text":"Décès d''un proche","correct":true},{"text":"Convocation devant un tribunal","correct":true},{"text":"Dommage matériel important au domicile (incendie, cambriolage)","correct":true},{"text":"Changement d''avis du client (envie de rester chez soi)","correct":false,"why_wrong":"Aucun assureur ne couvre l''annulation par convenance personnelle."},{"text":"Grève de la compagnie aérienne annoncée à l''avance","correct":false,"why_wrong":"Grève annoncée = risque connu, généralement exclu."}]'::jsonb, 2,
       'L''annulation est couverte pour les motifs GRAVES et IMPRÉVISIBLES au moment de la réservation. Convenance personnelle et risques déjà connus = exclus.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'non_vie' AND t.key = 'voyages'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-NV-VG-003', 'non_vie', t.id, 'single',
       NULL, 'Quelle est la principale différence entre une assurance voyage annuelle et une assurance voyage unique ?', '[{"text":"L''assurance annuelle couvre tous les voyages de l''année ; l''unique un seul voyage","correct":true},{"text":"L''annuelle est toujours moins chère","correct":false,"why_wrong":"Faux : elle n''est rentable qu''à partir de 2-3 voyages/an environ."},{"text":"L''unique couvre des durées illimitées","correct":false},{"text":"L''annuelle est obligatoire pour partir plus d''1 mois","correct":false}]'::jsonb, 1,
       'Annuelle = couvre tous les voyages < ~45 jours pendant 12 mois. Unique = un voyage précis, dates connues. L''annuelle devient rentable à ~3 voyages/an pour un couple/famille. Argument commercial : pratique et sans démarche à chaque départ.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'non_vie' AND t.key = 'voyages'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-NV-VG-004', 'non_vie', t.id, 'single',
       NULL, 'Un skieur suisse se blesse en Autriche et doit être rapatrié en hélicoptère. Qui prend en charge le rapatriement ?', '[{"text":"La LAMal automatiquement","correct":false,"why_wrong":"PIÈGE ULTRA-CLASSIQUE : la LAMal NE COUVRE JAMAIS le rapatriement (art. 36 OAMal)."},{"text":"L''assurance voyage / assistance LCA","correct":true},{"text":"La LAA obligatoire","correct":false,"why_wrong":"LAA couvre les soins liés à l''accident, pas le rapatriement médical."},{"text":"Les autorités autrichiennes","correct":false}]'::jsonb, 1,
       'RAPATRIEMENT = JAMAIS LAMal. C''est un des motifs premiers de souscription d''une assurance voyage/assistance. Coût typique rapatriement hélicoptère Alpes : 3 000-15 000 CHF, vol médicalisé longue distance : 30 000-100 000 CHF.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'non_vie' AND t.key = 'voyages'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-NV-VG-005', 'non_vie', t.id, 'single',
       NULL, 'Un client perd ses bagages à l''aéroport de Bangkok. Que couvre son assurance voyage bagages ?', '[{"text":"La valeur à neuf des bagages sans limite","correct":false,"why_wrong":"Toujours plafond CGA."},{"text":"La valeur actuelle des bagages jusqu''à un plafond CGA, souvent 2 000-5 000 CHF","correct":true},{"text":"Uniquement les frais de nettoyage","correct":false},{"text":"Rien : les bagages restent à la charge de la compagnie aérienne","correct":false,"why_wrong":"La compagnie a une responsabilité limitée (Convention de Montréal ~1 400 CHF), mais l''assurance voyage complète."}]'::jsonb, 1,
       'Assurance bagages LCA : couvre vol, perte définitive et détérioration. Plafond typique 2 000-5 000 CHF, sous-limites pour objets de valeur (bijoux, appareils électroniques). Franchise 100-300 CHF. La responsabilité aérienne (Convention de Montréal) est déduite.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'non_vie' AND t.key = 'voyages'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-NV-VG-006', 'non_vie', t.id, 'single',
       NULL, 'Une famille de 4 personnes voyage 2 fois par an à l''étranger et fait des sorties ski hebdomadaires. Quelle offre voyage est la plus adaptée ?', '[{"text":"Une assurance voyage unique par voyage","correct":false,"why_wrong":"Peu pratique et rapidement plus cher."},{"text":"Une assurance annuelle voyage FAMILIALE avec option ski/sports","correct":true},{"text":"Rien : la LAMal suffit en Europe","correct":false,"why_wrong":"PIÈGE : couverture LAMal étranger = urgence uniquement + rapatriement exclu."},{"text":"L''assurance ménage uniquement","correct":false}]'::jsonb, 1,
       'Profil idéal pour une annuelle familiale : ~250-450 CHF/an couvrant les 4 membres pour tous les voyages < 45-60 jours + activités sportives incluses. Argument valeur ajoutée : pas à repenser à s''assurer avant chaque départ.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'non_vie' AND t.key = 'voyages'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-NV-CN-001', 'non_vie', t.id, 'single',
       NULL, 'Dans un entretien non-vie, quel est le PREMIER document à remettre au client (art. 45 LSA) ?', '[{"text":"Le devis chiffré","correct":false,"why_wrong":"Vient en phase solution."},{"text":"La fiche d''information au preneur d''assurance","correct":true},{"text":"Les CGA de tous les produits proposés","correct":false,"why_wrong":"Trop volumineux pour un premier entretien ; remises avec la proposition."},{"text":"Un questionnaire de santé","correct":false,"why_wrong":"Non-vie : rare qu''on demande un questionnaire de santé sauf couvertures spécifiques."}]'::jsonb, 1,
       'Art. 45 LSA : fiche d''information = obligation identique en vie ET en non-vie. Elle documente le statut du conseiller (lié/non lié), ses partenaires, sa formation, l''organe de médiation, la protection des données. Doit être signée.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'non_vie' AND t.key = 'conseil_nv'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-NV-CN-002', 'non_vie', t.id, 'single',
       NULL, 'Selon la structure classique d''un entretien de conseil non-vie, dans quel ordre priorisez-vous les couvertures ?', '[{"text":"Casco complète > RC > protection juridique","correct":false,"why_wrong":"Erreur de priorisation : RC vient toujours AVANT casco propre."},{"text":"RC (obligatoire ou fortement conseillée) > couvertures de biens > options confort","correct":true},{"text":"Protection juridique > casco > RC","correct":false},{"text":"Peu importe l''ordre, on présente tout ensemble","correct":false,"why_wrong":"Sans priorisation, le client se noie et ne comprend pas la structure de son besoin."}]'::jsonb, 1,
       'Règle du conseil : d''abord ce qui protège des ATTEINTES MAJEURES à autrui ou soi (RC véhicule, RC privée, RC PME) puis les couvertures de biens (ménage inventaire, casco), enfin les options confort (annulation, protection juridique, assistance). C''est l''ordre du risque décroissant.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'non_vie' AND t.key = 'conseil_nv'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-NV-CN-003', 'non_vie', t.id, 'single',
       'Nouveau droit LCA en vigueur depuis le 1er janvier 2022.', 'Quelle nouveauté clé du droit LCA 2022 concerne la résiliation par le client ?', '[{"text":"Le client ne peut plus jamais résilier avant l''échéance","correct":false,"why_wrong":"Faux, c''est même l''inverse."},{"text":"Droit ordinaire de résiliation annuel après 3 ans, même si le contrat est de plus longue durée","correct":true},{"text":"Résiliation possible uniquement en cas d''augmentation de prime","correct":false,"why_wrong":"Ce droit existait déjà."},{"text":"Résiliation possible à tout moment sans motif","correct":false,"why_wrong":"Piège : c''est valable seulement pour la maladie complémentaire dans certains cas, pas comme règle générale non-vie."}]'::jsonb, 2,
       'Art. 35a LCA (nouveau) : après 3 ans, le preneur peut résilier annuellement le contrat, même si celui-ci est conclu pour une durée plus longue. Fin des contrats de 5 ou 10 ans imposés. Argument commercial fort à connaître.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'non_vie' AND t.key = 'conseil_nv'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-NV-CN-004', 'non_vie', t.id, 'multiple',
       NULL, 'Que doit contenir OBLIGATOIREMENT le procès-verbal de conseil non-vie remis au client ?', '[{"text":"Les besoins identifiés du client","correct":true},{"text":"Les solutions recommandées","correct":true},{"text":"Les motifs de la recommandation (raison d''être du produit choisi)","correct":true},{"text":"La date de l''entretien et l''identité du conseiller","correct":true},{"text":"Le salaire annuel de tous les collaborateurs de la compagnie","correct":false,"why_wrong":"Absurde : information confidentielle sans lien avec le conseil."},{"text":"Les alternatives présentées et les raisons de leur écartement","correct":true}]'::jsonb, 2,
       'Le PV de conseil sert de preuve de la qualité du conseil (LSFin, LSA, jurisprudence). Traçabilité complète du besoin > analyse > proposition > choix. Point protecteur pour le conseiller en cas de plainte.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'non_vie' AND t.key = 'conseil_nv'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-NV-CN-005', 'non_vie', t.id, 'single',
       NULL, 'Un client vous dit : « J''ai déjà une assurance ménage chez X, je préfère la garder pour le moment ». Que faites-vous ?', '[{"text":"Insister jusqu''à ce qu''il change","correct":false,"why_wrong":"Pratique déloyale, contraire à la LCD art. 3."},{"text":"Respecter la décision, documenter dans le PV, proposer un rappel à l''échéance","correct":true},{"text":"Résilier son ancien contrat à sa place pour l''obliger à souscrire","correct":false,"why_wrong":"Absolument interdit et pénalement répréhensible."},{"text":"Terminer l''entretien immédiatement","correct":false}]'::jsonb, 1,
       'Respect du client + documentation = protection du conseiller. Le rappel à l''échéance permet un contact professionnel légitime à un moment où le client est réellement disposé à comparer.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'non_vie' AND t.key = 'conseil_nv'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-NV-CN-006', 'non_vie', t.id, 'single',
       NULL, 'Un client résilie son contrat non-vie après un sinistre payé par l''assureur. Sur quel article s''appuie l''assureur pour se réserver le droit de résilier aussi ?', '[{"text":"Art. 42 LCA : droit de résiliation après sinistre","correct":true},{"text":"Art. 12 LCR","correct":false,"why_wrong":"Loi circulation routière, hors sujet."},{"text":"Art. 3 nLPD","correct":false},{"text":"Art. 45 LSA","correct":false,"why_wrong":"Concerne l''information client, pas la résiliation."}]'::jsonb, 1,
       'Art. 42 LCA (nouveau droit) : chaque partie peut résilier le contrat après un sinistre, dans les 14 jours dès versement de l''indemnité. Cette réciprocité doit être annoncée au client dès le conseil.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'non_vie' AND t.key = 'conseil_nv'
ON CONFLICT (external_id) DO NOTHING;

-- ───────── nonvie_xmark.json — Questions à choix multiples issues de questionnaires de formation externes, réponses cochées dans le corrigé d'origine. ─────────
INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'EXT-BL-001', 'non_vie', t.id, 'single',
       NULL, 'Parmi les cas suivants, lequel n''entre pas dans la catégorie de la responsabilité civile causale simple ?', '[{"text":"Responsabilité selon l''équité","correct":false},{"text":"Responsabilité selon la LCR","correct":true},{"text":"Responsabilité du fait des produits","correct":false},{"text":"Responsabilité en tant que chef de famille","correct":false}]'::jsonb, 1,
       NULL, 'formation_externe', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'non_vie' AND t.key = 'litiges_nv'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'EXT-BL-002', 'non_vie', t.id, 'multiple',
       NULL, 'Dans quels cas suivants un particulier peut-il être confronté à la responsabilité causale aggravée ?', '[{"text":"Chasseur","correct":true},{"text":"Chef de famille","correct":false},{"text":"Détenteur d''un animal","correct":false},{"text":"Conducteur de cyclomoteur","correct":false},{"text":"Détenteur de véhicule","correct":true}]'::jsonb, 2,
       NULL, 'formation_externe', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'non_vie' AND t.key = 'litiges_nv'
ON CONFLICT (external_id) DO NOTHING;

-- ───────── preserie.json — VBV — Assurance-maladie complémentaire, Présérie : le corrigé. Version Santé, 6 février 2025. ─────────
INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'PRE-1.1', 'maladie_complementaire', t.id, 'multiple',
       'Voici comment j''ai prévu le déroulement de notre entretien.', 'Quelles annonces sont correctes pour ouvrir l''entretien ?', '[{"text":"Je vais commencer par me présenter et par présenter Eiger Assurance maladie et, comme vous ne faites pas encore partie de nos clients, Monsieur Babic, tout de suite après ma présentation, je vous donnerai les informations importantes prévues selon l''art. 45 LSA.","correct":true},{"text":"Nous établirons ensemble le procès-verbal de cet entretien-conseil.","correct":true},{"text":"Je vérifie rapidement dans mon ordinateur portable l''évolution de vos sinistres et votre morale de paiement. Nous allons alors voir si cela vaut la peine de réaliser un entretien-conseil approfondi.","correct":false,"why_wrong":"Vérifier la morale de paiement n''est pas du conseil client : c''est une sélection de risque, et elle n''a pas sa place en ouverture d''entretien."},{"text":"Monsieur Babic, pour des motifs de protection des données, je vous prie de bien vouloir signer une procuration afin que je puisse saisir vos données personnelles dans notre base clientèle.","correct":false,"why_wrong":"Une procuration n''est pas l''instrument prévu. L''obligation d''information découle de l''art. 45 LSA."}]'::jsonb, 2,
       'L''ouverture d''entretien impose la remise de la fiche d''information client (art. 45 LSA) et l''annonce du procès-verbal de conseil.', 'preserie_vbv', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'conseil'
ON CONFLICT (external_id) DO NOTHING;
INSERT INTO afa_question_notions (question_id, notion_id)
SELECT qu.id, n.id FROM afa_questions qu, afa_notions n
WHERE qu.external_id = 'PRE-1.1' AND n.key = 'lsa_45'
ON CONFLICT DO NOTHING;
INSERT INTO afa_question_notions (question_id, notion_id)
SELECT qu.id, n.id FROM afa_questions qu, afa_notions n
WHERE qu.external_id = 'PRE-1.1' AND n.key = 'phases_4'
ON CONFLICT DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'PRE-1.2', 'maladie_complementaire', t.id, 'multiple',
       'Pour vous conseiller au mieux, j''aurais d''abord quelques questions à vous poser.', 'Quelles questions préliminaires sont pertinentes ?', '[{"text":"Quel est l''état de santé général de votre famille ?","correct":true},{"text":"Qu''attendez-vous de notre entretien-conseil ?","correct":true},{"text":"Pouvez-vous me dire si vous attendez une fille ou un garçon ? Je pourrai alors vous faire parvenir une offre écrite.","correct":false,"why_wrong":"Sans lien avec le besoin d''assurance : le sexe de l''enfant n''a aucune incidence sur la couverture."},{"text":"Aujourd''hui, nous allons parler à la fois de l''assurance obligatoire des soins et des assurances maladie complémentaires. Cela vous convient ?","correct":false,"why_wrong":"C''est une confirmation du plan d''entretien, pas une question d''analyse des besoins."}]'::jsonb, 2,
       'La phase d''analyse cherche l''état de santé et les attentes du client, pas des informations sans portée assurantielle.', 'preserie_vbv', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'conseil'
ON CONFLICT (external_id) DO NOTHING;
INSERT INTO afa_question_notions (question_id, notion_id)
SELECT qu.id, n.id FROM afa_questions qu, afa_notions n
WHERE qu.external_id = 'PRE-1.2' AND n.key = 'phases_4'
ON CONFLICT DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'PRE-1.3', 'maladie_complementaire', t.id, 'single',
       'Pour identifier vos besoins, nous travaillons avec un formulaire d''évaluation des besoins.', 'Quelle question figure légitimement dans ce formulaire ?', '[{"text":"Quelles sont les prestations d''assurance-maladie que vous trouvez importantes ?","correct":true},{"text":"Pour vous, combien de temps doit durer un entretien-conseil ?","correct":false,"why_wrong":"Sans rapport avec l''évaluation des besoins d''assurance."},{"text":"Êtes-vous d''accord que vos données de santé soient utilisées à des fins publicitaires et transmises à des tiers ?","correct":false,"why_wrong":"Contraire à la nLPD : une telle clause est nulle et expose à sanction. Les données de santé ne se transmettent jamais à des tiers à des fins publicitaires."}]'::jsonb, 1,
       'Piège nLPD classique : toute option proposant de transmettre des données de santé à des tiers est fausse.', 'preserie_vbv', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'conseil'
ON CONFLICT (external_id) DO NOTHING;
INSERT INTO afa_question_notions (question_id, notion_id)
SELECT qu.id, n.id FROM afa_questions qu, afa_notions n
WHERE qu.external_id = 'PRE-1.3' AND n.key = 'nlpd_sante'
ON CONFLICT DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'PRE-2.1', 'maladie_complementaire', t.id, 'multiple',
       'Comme j''attends un heureux événement, je voudrais savoir quelles sont les prestations assurées dans l''AOS pour la maternité.', 'Quelles prestations de maternité sont couvertes par l''AOS ?', '[{"text":"Tous les examens de contrôle effectués par des médecins ou des sages-femmes ou médicalement prescrits, pendant et après la grossesse, sont assurés.","correct":true},{"text":"L''accouchement à l''hôpital ou en maison de naissance (tarif du canton de domicile), en ambulatoire ou à domicile, est assuré.","correct":true},{"text":"Les prestations de conseil en allaitement sont prises en charge, par exemple lorsqu''elles sont effectuées par des sages-femmes.","correct":true},{"text":"Les cours de préparation à l''accouchement ne sont pas assurés et doivent passer par une complémentaire.","correct":false,"why_wrong":"Trompeur : les cours de préparation à l''accouchement sont partiellement couverts par l''AOS, jusqu''à 150 CHF."},{"text":"L''AOS verse une allocation allaitement forfaitaire de 200 CHF si la mère allaite au minimum 30 jours.","correct":false,"why_wrong":"Ce forfait n''existe pas dans l''AOS. C''est une invention destinée à piéger."}]'::jsonb, 2,
       'Le conseil en allaitement est la prestation la plus souvent oubliée. Attention aussi aux montants forfaitaires inventés.', 'preserie_vbv', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'lamal_prestations'
ON CONFLICT (external_id) DO NOTHING;
INSERT INTO afa_question_notions (question_id, notion_id)
SELECT qu.id, n.id FROM afa_questions qu, afa_notions n
WHERE qu.external_id = 'PRE-2.1' AND n.key = 'maternite_catalogue'
ON CONFLICT DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'PRE-2.2', 'maladie_complementaire', t.id, 'multiple',
       'Et à quels autres points dois-je faire attention en lien avec la maternité ?', 'Quelles affirmations sont exactes ?', '[{"text":"Dans l''AOS, le risque maternité est toujours assuré. Dans la complémentaire, il peut être inclus séparément ou exclu selon l''assureur et le produit.","correct":true},{"text":"Aucune participation aux coûts légale n''est prélevée sur les prestations de maternité légales.","correct":true},{"text":"Dans l''AOS, il faut payer la franchise et la quote-part même pour les prestations de maternité.","correct":false,"why_wrong":"Faux : les prestations de maternité sont exemptes de franchise et de quote-part."},{"text":"L''assurance-maladie verse l''allocation de maternité au titre de l''AOS.","correct":false,"why_wrong":"PIÈGE MAJEUR : l''allocation de maternité relève des APG (LAPG), pas de la LAMal. La LAMal ne couvre que les prestations médicales."}]'::jsonb, 2,
       'Séparer nettement les deux logiques : la LAMal paie les soins, l''APG remplace le revenu (80 %, 14 semaines, max 220 CHF/jour).', 'preserie_vbv', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'lamal_prestations'
ON CONFLICT (external_id) DO NOTHING;
INSERT INTO afa_question_notions (question_id, notion_id)
SELECT qu.id, n.id FROM afa_questions qu, afa_notions n
WHERE qu.external_id = 'PRE-2.2' AND n.key = 'maternite_exempte'
ON CONFLICT DO NOTHING;
INSERT INTO afa_question_notions (question_id, notion_id)
SELECT qu.id, n.id FROM afa_questions qu, afa_notions n
WHERE qu.external_id = 'PRE-2.2' AND n.key = 'apg_vs_lamal'
ON CONFLICT DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'PRE-2.3', 'maladie_complementaire', t.id, 'single',
       'À partir de quand devons-nous annoncer notre enfant pour l''AOS ?', 'Quel est le délai d''annonce du nouveau-né ?', '[{"text":"Dans les trois mois suivant la naissance.","correct":true},{"text":"Impérativement avant la naissance.","correct":false,"why_wrong":"L''annonce prénatale est possible et utile pour la complémentaire, mais elle n''est pas obligatoire pour l''AOS."},{"text":"Dans les 30 jours suivant la naissance.","correct":false,"why_wrong":"Confusion fréquente : le délai légal est de trois mois, pas 30 jours."}]'::jsonb, 1,
       'Trois mois, comme pour toute prise de domicile en Suisse (art. 3 LAMal).', 'preserie_vbv', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'lamal_bases'
ON CONFLICT (external_id) DO NOTHING;
INSERT INTO afa_question_notions (question_id, notion_id)
SELECT qu.id, n.id FROM afa_questions qu, afa_notions n
WHERE qu.external_id = 'PRE-2.3' AND n.key = 'aos_bebe_3mois'
ON CONFLICT DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'PRE-2.4', 'maladie_complementaire', t.id, 'multiple',
       'Quels avantages une annonce prénatale nous donne-t-elle dans l''assurance-maladie complémentaire ?', 'Quels sont les avantages réels de l''annonce prénatale ?', '[{"text":"L''assurance-maladie décide s''il est possible de conclure une assurance sans réserve.","correct":true},{"text":"Selon l''assurance-maladie, les coûts consécutifs à une infirmité congénitale sont assurés.","correct":true},{"text":"Lorsque l''enfant à naître est assuré en division demi-privée, cette couverture s''applique aussi automatiquement à la mère au moment de la naissance.","correct":false,"why_wrong":"Faux : rien n''est automatique. La couverture de la mère dépend de son propre contrat."},{"text":"Si vous effectuez une annonce prénatale, vous bénéficiez d''un rabais de prime.","correct":false,"why_wrong":"Aucun rabais spécifique n''est lié à l''annonce prénatale."},{"text":"L''acceptation sans réserve peut être garantie avant la naissance moyennant le paiement unique de 250 CHF.","correct":false,"why_wrong":"Montant inventé : aucune garantie ne s''achète par un paiement unique."}]'::jsonb, 2,
       'L''intérêt de l''annonce prénatale est l''acceptation sans réserve et la couverture des infirmités congénitales, jamais un avantage tarifaire.', 'preserie_vbv', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'lca_complementaires'
ON CONFLICT (external_id) DO NOTHING;
INSERT INTO afa_question_notions (question_id, notion_id)
SELECT qu.id, n.id FROM afa_questions qu, afa_notions n
WHERE qu.external_id = 'PRE-2.4' AND n.key = 'lca_liberte'
ON CONFLICT DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'PRE-3.1', 'maladie_complementaire', t.id, 'single',
       'Puis-je inclure la couverture accidents dans l''AOS pendant le congé maternité ?', 'Quelle réponse est correcte ?', '[{"text":"Oui, vous devez même le faire. Vous pouvez choisir librement d''assurer le risque accident auprès de l''AOS ou d''une assurance-accidents privée.","correct":true},{"text":"Oui, vous devez même le faire. Dès que vous réintégrerez votre emploi après le congé maternité, vous pourrez à nouveau exclure la couverture accidents de l''AOS.","correct":false,"why_wrong":"La logique de réintégration est correcte sur le principe, mais la formulation omet la liberté de choix entre AOS et assurance privée."},{"text":"Non, ce n''est pas nécessaire. Pendant le congé maternité, vous continuez de bénéficier de l''assurance-accidents obligatoire.","correct":false,"why_wrong":"Faux : la couverture LAA cesse à l''arrêt du rapport de travail assuré, sous réserve de l''assurance par convention."}]'::jsonb, 1,
       'Dès que la couverture LAA tombe, il faut réintégrer le risque accident dans l''AOS ou souscrire une couverture privée.', 'preserie_vbv', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'laa'
ON CONFLICT (external_id) DO NOTHING;
INSERT INTO afa_question_notions (question_id, notion_id)
SELECT qu.id, n.id FROM afa_questions qu, afa_notions n
WHERE qu.external_id = 'PRE-3.1' AND n.key = 'laa_assujettissement'
ON CONFLICT DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'PRE-3.2', 'maladie_complementaire', t.id, 'single',
       'Est-ce possible que notre bébé soit doublement assuré contre les accidents ?', 'Quelle réponse est correcte ?', '[{"text":"Oui, vous avez raison, c''est une erreur qui nous a échappé.","correct":true},{"text":"Oui, il est judicieux d''assurer le risque accident dans les deux produits.","correct":false,"why_wrong":"Une double couverture ne procure aucun avantage : le principe indemnitaire interdit la double indemnisation."},{"text":"Non, dans l''assurance-maladie complémentaire, l''accident n''est pas assuré.","correct":false,"why_wrong":"Faux : les complémentaires peuvent parfaitement couvrir le risque accident."}]'::jsonb, 1,
       'Reconnaître l''erreur est la bonne posture de conseil : la double couverture fait payer deux fois sans indemniser deux fois.', 'preserie_vbv', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'lca_complementaires'
ON CONFLICT (external_id) DO NOTHING;
INSERT INTO afa_question_notions (question_id, notion_id)
SELECT qu.id, n.id FROM afa_questions qu, afa_notions n
WHERE qu.external_id = 'PRE-3.2' AND n.key = 'lca_indemnitaire'
ON CONFLICT DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'PRE-3.3', 'maladie_complementaire', t.id, 'multiple',
       'Mon employeur a conclu une assurance LAA-C. Se peut-il que je sois doublement assurée contre les accidents dans certains domaines ?', 'Quelles affirmations sont exactes ?', '[{"text":"Oui, selon la couverture LAA-C, vous disposez déjà d''une assurance hospitalière en division demi-privée voire privée.","correct":true},{"text":"Oui, selon la couverture LAA-C, le capital invalidité peut être inclus ou non.","correct":true},{"text":"Non, il n''existe aucun chevauchement entre les prestations LAA-C et celles de l''AOS et des complémentaires.","correct":false,"why_wrong":"Faux : les chevauchements sont fréquents, notamment sur la division hospitalière."},{"text":"Non, comme le risque accident n''est pas assuré dans votre AOS, il ne peut pas y avoir de double assurance.","correct":false,"why_wrong":"Le raisonnement est faux : la complémentaire peut couvrir l''accident indépendamment de l''AOS."}]'::jsonb, 2,
       'La LAA-C recouvre souvent la division hospitalière et le capital invalidité : c''est là qu''il faut chercher les doublons.', 'preserie_vbv', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'laa'
ON CONFLICT (external_id) DO NOTHING;
INSERT INTO afa_question_notions (question_id, notion_id)
SELECT qu.id, n.id FROM afa_questions qu, afa_notions n
WHERE qu.external_id = 'PRE-3.3' AND n.key = 'laa_c'
ON CONFLICT DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'PRE-3.4', 'maladie_complementaire', t.id, 'multiple',
       'J''ai entendu parler de l''assurance-maladie complémentaire. Qu''est-ce qui est correct ?', 'Quelles affirmations sur la complémentaire LCA sont exactes ?', '[{"text":"L''assureur maladie peut refuser la proposition sans indiquer de motifs.","correct":true},{"text":"L''assureur maladie peut se départir du contrat si l''assuré ne paie pas la prime.","correct":true},{"text":"L''assureur maladie peut résilier le contrat en cas de fausses déclarations dans le questionnaire de santé.","correct":true},{"text":"En cas de sinistre, l''assureur maladie peut résilier le contrat après avoir procédé au paiement.","correct":false,"why_wrong":"Possible uniquement si le contrat le prévoit et sous conditions. Présenté comme une règle générale, c''est faux."},{"text":"On peut avoir plusieurs complémentaires pour la même prestation et tous les assureurs paient les prestations intégrales.","correct":false,"why_wrong":"Contraire au principe indemnitaire : pas de double indemnisation pour un même sinistre."},{"text":"On a droit à la réduction de prime pour les assurances-maladies complémentaires.","correct":false,"why_wrong":"Les subsides ne concernent que l''AOS, jamais les complémentaires."}]'::jsonb, 3,
       'La LCA repose sur la liberté contractuelle : refus sans motif, réserves, réticence (art. 6 LCA). Mais pas de double indemnisation ni de subside.', 'preserie_vbv', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'lca_complementaires'
ON CONFLICT (external_id) DO NOTHING;
INSERT INTO afa_question_notions (question_id, notion_id)
SELECT qu.id, n.id FROM afa_questions qu, afa_notions n
WHERE qu.external_id = 'PRE-3.4' AND n.key = 'lca_liberte'
ON CONFLICT DO NOTHING;
INSERT INTO afa_question_notions (question_id, notion_id)
SELECT qu.id, n.id FROM afa_questions qu, afa_notions n
WHERE qu.external_id = 'PRE-3.4' AND n.key = 'lca_reticence'
ON CONFLICT DO NOTHING;
INSERT INTO afa_question_notions (question_id, notion_id)
SELECT qu.id, n.id FROM afa_questions qu, afa_notions n
WHERE qu.external_id = 'PRE-3.4' AND n.key = 'lca_indemnitaire'
ON CONFLICT DO NOTHING;
INSERT INTO afa_question_notions (question_id, notion_id)
SELECT qu.id, n.id FROM afa_questions qu, afa_notions n
WHERE qu.external_id = 'PRE-3.4' AND n.key = 'lca_pas_subside'
ON CONFLICT DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'PRE-3.5', 'maladie_complementaire', t.id, 'multiple',
       'Mon mari Dean souhaite se mettre à son compte et créer une entreprise individuelle. À quoi doit-il prêter attention concernant l''assurance-accidents ?', 'Quelles affirmations sont exactes ?', '[{"text":"En Suisse, il doit obligatoirement s''assurer pour le risque accident.","correct":true},{"text":"Il a le choix entre inclure le risque accident dans l''AOS ou conclure une assurance-accidents facultative selon la LAA.","correct":true},{"text":"S''il met fin à la couverture LAA facultative, il doit immédiatement réintégrer la couverture accidents dans l''AOS.","correct":true},{"text":"Il n''a pas besoin de changer quoi que ce soit.","correct":false,"why_wrong":"Faux : en devenant indépendant, il sort de la LAA obligatoire et doit réorganiser sa couverture."},{"text":"Il doit conclure une assurance-accidents obligatoire à son nom.","correct":false,"why_wrong":"Les indépendants ne sont PAS soumis à la LAA obligatoire. Ils peuvent s''y assurer à titre facultatif."},{"text":"S''il souhaite assurer les prestations stationnaires dans toute la Suisse, l''inclusion du risque accident dans l''AOS suffit.","correct":false,"why_wrong":"L''AOS couvre au tarif du canton de domicile. Le libre choix de l''hôpital en Suisse suppose une complémentaire."}]'::jsonb, 3,
       'Point clé : l''indépendant n''est jamais soumis à la LAA obligatoire, mais il reste tenu de couvrir le risque accident, via l''AOS ou la LAA facultative.', 'preserie_vbv', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'laa'
ON CONFLICT (external_id) DO NOTHING;
INSERT INTO afa_question_notions (question_id, notion_id)
SELECT qu.id, n.id FROM afa_questions qu, afa_notions n
WHERE qu.external_id = 'PRE-3.5' AND n.key = 'laa_assujettissement'
ON CONFLICT DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'PRE-4.1', 'maladie_complementaire', t.id, 'multiple',
       'Pouvez-vous nous parler de la suite de la procédure concernant le changement d''assurance maladie de mon mari Dean ?', 'Quelles affirmations sur la procédure sont exactes ?', '[{"text":"La proposition pour les complémentaires de votre mari sera examinée par l''examen du risque en fonction de son propre risque.","correct":true},{"text":"Si besoin, l''assureur maladie peut demander des rapports aux médecins traitants.","correct":true},{"text":"Dans le cas de la complémentaire, l''assureur peut prononcer des réserves ou des exclusions de prestations à la suite de certains diagnostics.","correct":true},{"text":"Votre mari a le droit de révoquer par écrit sa proposition pour la complémentaire dans les deux mois qui suivent la réception.","correct":false,"why_wrong":"Le délai de révocation LCA est de 14 jours, pas deux mois."},{"text":"Après la signature de la proposition, le devoir d''information selon l''art. 3 LCA prend fin.","correct":false,"why_wrong":"Faux : le devoir d''information se poursuit au-delà de la signature."},{"text":"Votre mari devrait résilier son ancienne complémentaire avant l''acceptation écrite de la nouvelle.","correct":false,"why_wrong":"Erreur de conseil grave : on ne résilie JAMAIS avant l''acceptation écrite, sous peine de trou de couverture."},{"text":"Le changement d''AOS de votre mari peut être refusé.","correct":false,"why_wrong":"L''AOS est obligatoire et l''admission est libre : aucun refus possible."}]'::jsonb, 3,
       'Trois chiffres et règles à ancrer : révocation 14 jours, devoir d''information continu (art. 3 LCA), jamais de résiliation avant acceptation écrite.', 'preserie_vbv', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'lca_complementaires'
ON CONFLICT (external_id) DO NOTHING;
INSERT INTO afa_question_notions (question_id, notion_id)
SELECT qu.id, n.id FROM afa_questions qu, afa_notions n
WHERE qu.external_id = 'PRE-4.1' AND n.key = 'lca_revocation'
ON CONFLICT DO NOTHING;
INSERT INTO afa_question_notions (question_id, notion_id)
SELECT qu.id, n.id FROM afa_questions qu, afa_notions n
WHERE qu.external_id = 'PRE-4.1' AND n.key = 'lca_info_continue'
ON CONFLICT DO NOTHING;
INSERT INTO afa_question_notions (question_id, notion_id)
SELECT qu.id, n.id FROM afa_questions qu, afa_notions n
WHERE qu.external_id = 'PRE-4.1' AND n.key = 'lca_jamais_resilier'
ON CONFLICT DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'PRE-4.2', 'maladie_complementaire', t.id, 'multiple',
       'Madame et Monsieur Babic, je vous remercie de cet entretien. Pour finir, je souhaiterais vous poser quelques questions.', 'Quelles questions de clôture sont appropriées ?', '[{"text":"Vous avez signé une offre sans engagement. Puis-je l''envoyer à l''assurance-maladie pour un examen préalable ?","correct":true},{"text":"Comment avez-vous trouvé l''entretien-conseil ? Qui dans votre entourage pourrait également en bénéficier ?","correct":true},{"text":"Pourrais-je vous contacter et vous accompagner dans la suite de la procédure, à savoir la résiliation auprès de l''assureur précédent, une fois les propositions traitées ?","correct":true},{"text":"Puis-je vous recommander de prendre plus de vitamine C et de fer pendant votre grossesse ?","correct":false,"why_wrong":"Hors compétence : l''intermédiaire ne donne jamais de conseil médical."}]'::jsonb, 2,
       'La clôture couvre l''envoi pour examen préalable, la demande de recommandation et le suivi. L''envoi pour examen préalable est régulièrement oublié.', 'preserie_vbv', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'conseil'
ON CONFLICT (external_id) DO NOTHING;
INSERT INTO afa_question_notions (question_id, notion_id)
SELECT qu.id, n.id FROM afa_questions qu, afa_notions n
WHERE qu.external_id = 'PRE-4.2' AND n.key = 'hors_competence'
ON CONFLICT DO NOTHING;
INSERT INTO afa_question_notions (question_id, notion_id)
SELECT qu.id, n.id FROM afa_questions qu, afa_notions n
WHERE qu.external_id = 'PRE-4.2' AND n.key = 'phases_4'
ON CONFLICT DO NOTHING;

-- EN ATTENTE DE VALIDATION : Le corrigé retenu dans le cahier marque comme correcte l'option « Pour l'admission dans l'AOS, il faut répondre à un questionnaire de santé ». C'est contraire au droit : l'admission à l'AOS est libre et sans questionnaire de santé (le questionnaire ne concerne que les complémentaires LCA). Question désactivée tant que le corrigé officiel n'a pas été revérifié.
INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'PRE-2.5', 'maladie_complementaire', t.id, 'multiple',
       'Dean souhaiterait rejoindre Eiger Assurance maladie pour l''AOS ordinaire. À quoi devons-nous prêter attention ?', 'Quelles affirmations sont exactes ?', '[{"text":"On peut être assuré pour l''AOS et la complémentaire auprès d''assureurs différents.","correct":true},{"text":"Dans l''AOS, il est possible de choisir différents modèles et franchises selon l''assureur.","correct":true},{"text":"Les prestations assurées, de même que les primes de l''AOS, sont identiques pour chaque assurance maladie.","correct":false,"why_wrong":"Piège classique : les PRESTATIONS sont identiques par la loi, mais les PRIMES varient selon la caisse."},{"text":"Il est permis de changer d''AOS et de rejoindre Eiger au 1er juillet de l''année en cours.","correct":false,"why_wrong":"Le changement au 1er juillet n''est ouvert qu''en cas de hausse de prime, avec préavis au 31 mars."},{"text":"Il est permis de changer d''assurance-maladie même en cas d''arriérés ayant fait l''objet d''une sommation.","correct":false,"why_wrong":"Faux : les arriérés avec sommation bloquent le changement de caisse."},{"text":"Pour l''admission dans l''AOS, il faut répondre à un questionnaire de santé.","correct":false,"why_wrong":"À VÉRIFIER — voir raison_mise_en_attente."}]'::jsonb, 3,
       'Le corrigé retenu dans le cahier marque comme correcte l''option « Pour l''admission dans l''AOS, il faut répondre à un questionnaire de santé ». C''est contraire au droit : l''admission à l''AOS est libre et sans questionnaire de santé (le questionnaire ne concerne que les complémentaires LCA). Question désactivée tant que le corrigé officiel n''a pas été revérifié.', 'preserie_vbv', FALSE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'lamal_bases'
ON CONFLICT (external_id) DO NOTHING;

-- ───────── vie_externe.json — Questions à choix multiples issues de questionnaires de formation externes, réponses cochées dans le corrigé d'origine. ─────────
INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'EXT-VIE-001', 'vie', t.id, 'multiple',
       NULL, 'Parmi les personnes ci-dessous, qui doit cotiser à l''AVS ?', '[{"text":"Femme mariée dont le mari gagne 85''000.- par an","correct":false},{"text":"Femme divorcée","correct":true},{"text":"étudiant de 24 ans n''ayant pas d''activité lucrative","correct":true},{"text":"étudiant de 19 ans n''ayant pas d''activité lucrative","correct":false},{"text":"Retraité de 68 ans ayant une activité lucrative de 25''000.- par an","correct":true},{"text":"Personne de 64 ans en préretraite","correct":true}]'::jsonb, 3,
       NULL, 'formation_externe', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'retraite'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'EXT-VIE-002', 'vie', t.id, 'multiple',
       NULL, 'Parmi les personnes ci-dessous, qui doit cotiser à la LPP pour la part épargne ?', '[{"text":"Salarié de 35 ans ayant une activité lucrative de 56''000.- par an","correct":true},{"text":"Indépendant de 35 ans ayant une activité lucrative de 56''000.- par an au total","correct":false},{"text":"Etudiant de 22 ans ayant une activité lucrative de 30''000.- par an au total","correct":false},{"text":"Etudiant de 26 ans ayant une activité lucrative de 30''000.- par an au total","correct":true},{"text":"Etudiant de 26 ans ayant une activité lucrative de 21''000.- par an au total","correct":false},{"text":"Salarié ayant trois activités lucrative à 30 % chacune, avec un revenu total de 57''000.-/an","correct":false}]'::jsonb, 2,
       NULL, 'formation_externe', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'retraite'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'EXT-VIE-003', 'vie', t.id, 'multiple',
       NULL, 'Parmi les personnes ci-dessous, qui doit cotiser à la LPP pour la prime de risque ?', '[{"text":"Salarié de 35 ans ayant une activité lucrative de 56''000.- par an","correct":true},{"text":"Indépendant de 35 ans ayant une activité lucrative de 56''000.- par an au total","correct":false},{"text":"Etudiant de 22 ans ayant une activité lucrative de 30''000.- par an au total","correct":true},{"text":"Etudiant de 26 ans ayant une activité lucrative de 30''000.- par an au total","correct":true},{"text":"Etudiant de 26 ans ayant une activité lucrative de 21''000.- par an au total","correct":false},{"text":"Salarié ayant trois activités lucrative à 30 % chacune pour 57''000.- par an au total","correct":false}]'::jsonb, 3,
       NULL, 'formation_externe', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'retraite'
ON CONFLICT (external_id) DO NOTHING;

-- ───────── vie_klary_complement.json — Banque Klary — complément VIE couvrant heriter_leguer, activite_independante et conseil_vie. Ces 3 thèmes manquaient au seed initial issu du programme externe. ─────────
INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-HL-001', 'vie', t.id, 'single',
       NULL, 'Depuis la réforme du droit successoral entrée en vigueur le 1er janvier 2023, quelle est la réserve héréditaire des descendants ?', '[{"text":"3/4 de leur part légale","correct":false,"why_wrong":"C''était l''ancien droit avant 2023."},{"text":"1/2 de leur part légale","correct":true},{"text":"1/4 de leur part légale","correct":false,"why_wrong":"Il n''a jamais existé de réserve à 1/4 pour les descendants."},{"text":"Aucune réserve, quotité disponible libre","correct":false,"why_wrong":"Les descendants ont TOUJOURS une réserve, même après la réforme."}]'::jsonb, 1,
       'Nouveau droit CC art. 471 : réserve des descendants réduite de 3/4 à 1/2 de la part légale. Réserve du conjoint : inchangée à 1/2. Réserve des parents : supprimée.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'heriter_leguer'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-HL-002', 'vie', t.id, 'single',
       NULL, 'Un couple concubin sans enfants ni testament : que reçoit le concubin survivant si l''autre décède ?', '[{"text":"La moitié de la succession","correct":false,"why_wrong":"Confusion avec le régime du mariage."},{"text":"Le quart de la succession","correct":false},{"text":"Rien : le concubin n''est pas héritier légal","correct":true},{"text":"L''ensemble de la succession si aucun autre héritier","correct":false,"why_wrong":"En l''absence d''héritiers légaux, la succession revient au canton (art. 466 CC), pas au concubin."}]'::jsonb, 1,
       'Le concubin n''a AUCUN droit successoral légal. Pour transmettre à un concubin, il faut testament ou clause bénéficiaire (3a/3b/vie). C''est LE motif principal de conseil vie chez les concubins.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'heriter_leguer'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-HL-003', 'vie', t.id, 'single',
       'Marc, 52 ans, marié, deux enfants majeurs. Patrimoine net : 800 000 CHF. Il souhaite avantager au maximum son épouse.', 'Quelle part maximale peut-il attribuer à son épouse par testament, sans porter atteinte aux réserves ?', '[{"text":"1/4 (réserve de l''épouse) + 1/2 (quotité disponible) = 3/4","correct":true},{"text":"La totalité (100 %)","correct":false,"why_wrong":"Cela porterait atteinte aux réserves des enfants."},{"text":"1/2 seulement","correct":false,"why_wrong":"Ne tient pas compte de la quotité disponible cumulée à la réserve du conjoint."},{"text":"5/8","correct":false}]'::jsonb, 2,
       'Avec conjoint et descendants : part légale conjoint = 1/2, part légale descendants = 1/2. Réserve conjoint = 1/2 de sa part = 1/4. Réserve descendants (nouveau droit) = 1/2 de leur part = 1/4. Quotité disponible = 1 (1/4 + 1/4) = 1/2. Maximum au conjoint = sa réserve 1/4 + quotité 1/2 = 3/4.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'heriter_leguer'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-HL-004', 'vie', t.id, 'multiple',
       NULL, 'Concernant la clause bénéficiaire du pilier 3a (art. 2 OPP 3), quelles affirmations sont exactes ?', '[{"text":"L''ordre des bénéficiaires est IMPOSÉ par la loi, pas librement choisi","correct":true},{"text":"Le conjoint survivant a la priorité absolue","correct":true},{"text":"Le concubin peut être désigné, à condition d''avoir été soutenu de manière substantielle par le défunt ou d''avoir un enfant commun ou d''avoir vécu 5 ans en ménage commun","correct":true},{"text":"Le titulaire peut désigner n''importe qui, comme en 3b","correct":false,"why_wrong":"C''est faux : la 3a suit un ORDRE LÉGAL. La liberté totale n''existe qu''en 3b."},{"text":"Les avoirs 3a échappent à la succession et vont directement au bénéficiaire désigné","correct":true}]'::jsonb, 2,
       'Ordre imposé 3a : 1er = conjoint, 2e = descendants + concubin qualifié + personnes à charge (à parts égales sauf autre répartition), 3e = parents, 4e = frères/sœurs, 5e = autres héritiers. Argument commercial fort : transmission hors masse successorale.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'heriter_leguer'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-HL-005', 'vie', t.id, 'single',
       NULL, 'Quelle forme de testament est valable en droit suisse ?', '[{"text":"Testament dactylographié et signé par le testateur","correct":false,"why_wrong":"Un testament olographe doit être ENTIÈREMENT ÉCRIT à la main."},{"text":"Testament olographe : entièrement manuscrit, daté et signé par le testateur","correct":true},{"text":"Testament oral enregistré sur vidéo","correct":false,"why_wrong":"Le testament oral (art. 506 CC) n''est admis qu''en cas de danger de mort imminent, devant 2 témoins, et perd sa validité 14 jours après."},{"text":"Testament signé uniquement, avec le contenu tapé","correct":false}]'::jsonb, 1,
       'Art. 505 CC : testament olographe = ENTIÈREMENT manuscrit + daté + signé. Alternative : testament public devant notaire et 2 témoins (art. 499-504 CC).', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'heriter_leguer'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-HL-006', 'vie', t.id, 'single',
       NULL, 'Une assurance-vie mixte comporte une clause bénéficiaire nominative pour l''épouse en cas de décès. Le capital-décès versé fait-il partie de la masse successorale ?', '[{"text":"Oui, comme tout capital ","correct":false,"why_wrong":"Un des avantages majeurs de l''assurance-vie avec clause bénéficiaire nominative."},{"text":"Non, il est versé directement au bénéficiaire hors succession","correct":true},{"text":"Oui, mais seulement si le montant dépasse 100 000 CHF","correct":false,"why_wrong":"Aucun seuil de ce type n''existe."},{"text":"Seulement la valeur de rachat entre dans la succession","correct":false,"why_wrong":"Piège : c''est vrai pour le calcul fiscal réserve/réduction dans certains cas, mais pas pour l''attribution du capital."}]'::jsonb, 1,
       'Art. 76-79 LCA : le capital versé au bénéficiaire nominatif ne rentre PAS dans la masse successorale. Impôt sur les successions selon canton, mais aucun droit des héritiers réservataires SAUF action en réduction si atteinte aux réserves (art. 476 CC).', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'heriter_leguer'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-HL-007', 'vie', t.id, 'single',
       NULL, 'Un pacte successoral se distingue d''un testament principalement parce que :', '[{"text":"Il peut être rédigé de la main du testateur seul","correct":false,"why_wrong":"Le pacte exige la forme authentique (notaire + 2 témoins)."},{"text":"Il est bilatéral et ne peut être modifié qu''avec l''accord des parties","correct":true},{"text":"Il n''a pas besoin d''être signé","correct":false},{"text":"Il ne concerne que les couples mariés","correct":false,"why_wrong":"Ouvert à toute personne majeure capable de discernement."}]'::jsonb, 1,
       'Art. 512-515 CC : pacte successoral = acte bilatéral (ou multilatéral) devant notaire. Ne peut être révoqué unilatéralement (au contraire du testament, révocable à tout moment). Utilisé pour verrouiller un accord entre héritiers ou renoncer à des droits.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'heriter_leguer'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-HL-008', 'vie', t.id, 'single',
       NULL, 'L''action en réduction ouverte à un héritier réservataire dont la réserve n''a pas été respectée se prescrit par :', '[{"text":"1 an dès la connaissance de la lésion","correct":true},{"text":"5 ans dès le décès","correct":false,"why_wrong":"Ce délai n''existe pas en droit successoral."},{"text":"10 ans dès le décès","correct":false,"why_wrong":"Confusion avec un délai absolu."},{"text":"3 mois dès l''ouverture du testament","correct":false}]'::jsonb, 1,
       'Art. 533 CC : 1 an dès la connaissance de la lésion, dans tous les cas 10 ans dès la publication du testament ou l''ouverture de la succession. Délai court, donc à rappeler au client.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'heriter_leguer'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-AI-001', 'vie', t.id, 'single',
       NULL, 'Un indépendant est-il obligatoirement assuré à la LAA (assurance-accidents obligatoire) ?', '[{"text":"Oui, dès qu''il commence son activité","correct":false,"why_wrong":"Confusion avec les salariés."},{"text":"Non, mais il peut s''assurer à titre facultatif","correct":true},{"text":"Oui, s''il gagne plus de 21 510 CHF/an","correct":false,"why_wrong":"C''est un seuil LPP, sans lien avec la LAA."},{"text":"Non, il doit obligatoirement passer par une IJM LCA privée","correct":false}]'::jsonb, 1,
       'Art. 4 LAA : les indépendants NE sont PAS soumis à la LAA obligatoire. Ils peuvent s''assurer à titre facultatif auprès de la SUVA (art. 4-5 LAA). PIÈGE : question souvent inversée à l''examen.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'activite_independante'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-AI-002', 'vie', t.id, 'single',
       NULL, 'Quel est le plafond du pilier 3a pour un indépendant sans caisse de pensions LPP, en 2026 ?', '[{"text":"7 258 CHF (petit pilier 3a)","correct":false,"why_wrong":"C''est le plafond du salarié affilié à une LPP."},{"text":"20 % du revenu net d''activité, maximum 36 288 CHF","correct":true},{"text":"10 % du revenu, maximum 20 000 CHF","correct":false},{"text":"50 % du revenu sans plafond","correct":false}]'::jsonb, 1,
       'Art. 7 OPP 3 : indépendant SANS LPP = grand pilier 3a = 20 % du revenu net d''activité, plafonné à 5 fois le plafond LPP art. 8 al. 1 LPP. Plafond 2026 : 36 288 CHF. Argument fiscal massif : déductible du revenu imposable.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'activite_independante'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-AI-003', 'vie', t.id, 'single',
       NULL, 'Un indépendant peut-il toucher des indemnités de l''assurance-chômage (LACI) en cas d''échec de son activité ?', '[{"text":"Oui, comme tout travailleur","correct":false,"why_wrong":"Erreur classique."},{"text":"Non, les indépendants ne sont pas assurés à la LACI","correct":true},{"text":"Oui, mais uniquement pour 90 jours","correct":false,"why_wrong":"Pas de dispositif de ce type."},{"text":"Oui, uniquement si l''activité durait depuis plus de 3 ans","correct":false}]'::jsonb, 1,
       'Art. 2 LACI : cotisent SEULEMENT les salariés. Un indépendant qui cesse son activité ne perçoit AUCUNE indemnité LACI. Il peut retrouver le droit s''il redevient salarié et cotise à nouveau 12 mois sur les 24 précédant l''inscription.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'activite_independante'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-AI-004', 'vie', t.id, 'multiple',
       NULL, 'Quelles couvertures un indépendant devrait-il prioritairement examiner à l''ouverture de son activité ?', '[{"text":"IJM LCA pour couvrir la perte de gain en cas de maladie","correct":true},{"text":"Adhésion facultative LAA (SUVA) pour couvrir les accidents","correct":true},{"text":"Adhésion facultative à la LPP (2e pilier)","correct":true},{"text":"3a grand plafond pour prévoyance + fiscalité","correct":true},{"text":"RC professionnelle selon activité","correct":true},{"text":"Assurance-chômage LACI","correct":false,"why_wrong":"Pas ouverte aux indépendants (art. 2 LACI)."}]'::jsonb, 2,
       'L''indépendant est le profil le plus exposé : aucune couverture d''office. Le conseiller doit couvrir en priorité les 4 grands trous : perte de gain (IJM + LAA), prévoyance vieillesse (LPP + 3a), décès/invalidité (assurance-vie risque pur), responsabilité (RC pro).', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'activite_independante'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-AI-005', 'vie', t.id, 'single',
       NULL, 'Un indépendant qui adhère facultativement à une LPP peut-il déduire ses cotisations du revenu imposable ?', '[{"text":"Non, seul le pilier 3a est déductible","correct":false,"why_wrong":"Piège : le 3a ET la LPP facultative sont déductibles."},{"text":"Oui, intégralement, comme un salarié affilié","correct":true},{"text":"Uniquement 50 % des cotisations","correct":false},{"text":"Uniquement si l''activité génère moins de 100 000 CHF","correct":false}]'::jsonb, 1,
       'Art. 33 al. 1 lit. d LIFD : cotisations LPP entièrement déductibles, y compris pour les indépendants affiliés à titre facultatif. Levier fiscal important pour les revenus > 100 000 CHF.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'activite_independante'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-AI-006', 'vie', t.id, 'single',
       NULL, 'Une indépendante enceinte est-elle couverte par l''allocation-maternité APG (LAPG) ?', '[{"text":"Non, l''APG maternité ne concerne que les salariées","correct":false,"why_wrong":"PIÈGE fréquent. Les indépendantes SONT couvertes."},{"text":"Oui, aux mêmes conditions que les salariées : 80 % du revenu, 14 semaines, max 220 CHF/jour","correct":true},{"text":"Uniquement 50 % du revenu, 8 semaines","correct":false},{"text":"Uniquement si elle a souscrit une LCA facultative","correct":false}]'::jsonb, 1,
       'LAPG : depuis 2005, l''allocation-maternité couvre aussi les indépendantes affiliées à l''AVS, aux mêmes conditions (art. 16b LAPG). Cotisation prélevée sur les cotisations AVS/AI/APG habituelles.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'activite_independante'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-CV-001', 'vie', t.id, 'single',
       NULL, 'Quel document doit être remis obligatoirement au client lors du premier entretien de conseil en prévoyance ?', '[{"text":"Un devis chiffré","correct":false,"why_wrong":"Le devis vient PLUS TARD, en phase solution."},{"text":"La fiche d''information au preneur d''assurance (art. 45 LSA)","correct":true},{"text":"Une copie du contrat CGA","correct":false,"why_wrong":"Les CGA sont remises avec la proposition/police, pas en amont."},{"text":"Une attestation de compétences AFA","correct":false}]'::jsonb, 1,
       'Art. 45 LSA : fiche d''information obligatoire au 1er entretien. Contient l''identité de l''intermédiaire, ses liens de dépendance, ses partenaires, sa formation, la procédure en cas de plainte, l''organe de médiation. Doit être PROUVÉE (signature du client).', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'conseil_vie'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-CV-002', 'vie', t.id, 'single',
       NULL, 'Dans la méthode d''analyse en 4 phases (introduction, analyse, solution, conclusion), à quel moment identifie-t-on la lacune de prévoyance en cas d''invalidité ?', '[{"text":"Phase 1 : introduction","correct":false},{"text":"Phase 2 : analyse","correct":true},{"text":"Phase 3 : solution","correct":false,"why_wrong":"La solution vient RÉPONDRE à la lacune, elle ne l''identifie pas."},{"text":"Phase 4 : conclusion","correct":false}]'::jsonb, 1,
       'Phase 2 = analyse des besoins et de la situation actuelle. On chiffre les prestations 1er/2e/3e pilier attendues, on compare au revenu actuel, on calcule la lacune. La solution (phase 3) répond à cette lacune.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'conseil_vie'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-CV-003', 'vie', t.id, 'single',
       NULL, 'Quel taux de couverture du dernier salaire est généralement recommandé pour maintenir le niveau de vie à la retraite ?', '[{"text":"Environ 40 %","correct":false},{"text":"Environ 60 % (1er + 2e pilier LPP obligatoire)","correct":true},{"text":"Environ 100 %","correct":false,"why_wrong":"Non, le système suisse vise environ 60 % avec les 2 premiers piliers, complétés par le 3e."},{"text":"Environ 20 %","correct":false}]'::jsonb, 1,
       'Objectif constitutionnel (art. 113 Cst) : 1er + 2e pilier = maintenir le niveau de vie antérieur de façon appropriée = ~60 % du dernier salaire. Le 3e pilier vise à combler l''écart vers 80-100 %.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'conseil_vie'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-CV-004', 'vie', t.id, 'multiple',
       NULL, 'Selon les obligations LSA/nLPD, quelles précautions doit prendre un conseiller vie lors du recueil d''informations sur la santé du client ?', '[{"text":"Obtenir le consentement écrit du client pour transmettre les données à l''assureur","correct":true},{"text":"Ne transmettre AUCUNE donnée de santé à des tiers à des fins publicitaires","correct":true},{"text":"Conserver les données de santé aussi longtemps que possible","correct":false,"why_wrong":"Principe de minimisation nLPD : conservation limitée à ce qui est nécessaire."},{"text":"Peut partager oralement avec un collègue conseiller sans autorisation","correct":false,"why_wrong":"Violation du secret professionnel et de la nLPD."},{"text":"Documenter le fondement légal du traitement","correct":true}]'::jsonb, 2,
       'nLPD : les données de santé sont des données sensibles (art. 5 lit. c ch. 2 nLPD). Consentement exprès requis, finalité précise, conservation limitée, sécurité renforcée. Interdiction absolue de finalité publicitaire.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'conseil_vie'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-CV-005', 'vie', t.id, 'single',
       NULL, 'Un client vous demande de recommander médicalement s''il doit s''inquiéter d''un symptôme cardiaque. Que devez-vous faire ?', '[{"text":"Répondre selon vos connaissances générales","correct":false},{"text":"Renvoyer le client vers un médecin ; le conseil médical n''entre pas dans notre périmètre","correct":true},{"text":"Consulter un pharmacien","correct":false},{"text":"Contacter l''assureur pour avis médical","correct":false}]'::jsonb, 1,
       'PIÈGE : toute option évoquant un conseil médical direct est FAUSSE. Le conseiller reste dans son périmètre de compétences (couvertures d''assurance), pas dans la médecine. Renvoi systématique vers le médecin.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'conseil_vie'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-CV-006', 'vie', t.id, 'single',
       NULL, 'Quel est le délai de révocation offert au client après signature d''une proposition d''assurance-vie (LCA) ?', '[{"text":"2 mois","correct":false,"why_wrong":"Piège : confusion avec le délai de résiliation en cas de changement de tarif."},{"text":"14 jours dès signature","correct":true},{"text":"24 heures","correct":false},{"text":"30 jours","correct":false}]'::jsonb, 1,
       'Art. 2a LCA (nouveau droit 2022) : délai de révocation de 14 jours, en la forme écrite ou par un autre moyen permettant la preuve par texte. Point clé à mentionner obligatoirement en conclusion de vente.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'conseil_vie'
ON CONFLICT (external_id) DO NOTHING;

-- ───────── vol_externe.json — Cas pratiques de qualification du vol, issus d'un support de formation externe. Fond : distinction vol simple / vol avec effraction / détroussement. ─────────
INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'EXT-VOL-001', 'non_vie', t.id, 'single',
       'Madame S. se balade dans la rue avec son sac à main suspendu à l''épaule droite. Subrepticement, un cycliste s''approche par derrière. En passant à côté d''elle, il attrape la bretelle, prend le sac de Madame S. et s''en va à toute allure. Madame S. est si mplement stupéfaite et ne peut rien faire d''autre que de se plaindre de la jeunesse actuelle et se rendre au poste de police le plus proche.', 'De quoi s''agit-il juridiquement ?', '[{"text":"Vol avec effraction","correct":false,"why_wrong":null},{"text":"Détroussement","correct":false,"why_wrong":null},{"text":"Vol simple","correct":true}]'::jsonb, 1,
       'Dans le déroulement des faits, la surprise est prépondérante.', 'formation_externe', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'non_vie' AND t.key = 'menage'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'EXT-VOL-002', 'non_vie', t.id, 'single',
       'Un jeune homme se plante de manière provocante devant Monsieur P. et tient en laisse un pitbull - terrier grondant et montrant les crocs. Il désigne son chien du doigt et demande à Monsieur P. de lui donner son portefeuille.', 'De quoi s''agit-il juridiquement ?', '[{"text":"Vol avec effraction","correct":false,"why_wrong":null},{"text":"Détroussement","correct":true},{"text":"Vol simple","correct":false,"why_wrong":null}]'::jsonb, 1,
       'La menace du recours à la force est manifeste. Monsieur P. doit s''attendre à ce que le malfrat lâche son chien sur lui.', 'formation_externe', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'non_vie' AND t.key = 'menage'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'EXT-VOL-003', 'non_vie', t.id, 'single',
       'L''électricien K. est attablé au restaurant pour manger une colla tion bien méritée. En regardant par la fenêtre, il voit un inconnu voler sa caisse à outils d ans son véhicule d''entreprise non fermé à clé. K. sort en courant sans réf léchir et rattrape le voleur environ 10 mètres plus loin. Il veut le saisir par l''épaule et lui demander une explication. A ce moment -là, l''inconnu se retourne et donne un violent coup de poing dans le visage de l''électricien K. qui tombe dans les pommes. Lorsque K. revient à lui, l''inconnu et la caisse à outils ont disparu sans laisser de traces.', 'De quoi s''agit-il juridiquement ?', '[{"text":"Vol avec effraction","correct":false,"why_wrong":null},{"text":"Détroussement","correct":true},{"text":"Vol simple","correct":false,"why_wrong":null}]'::jsonb, 1,
       'Recours à la force pour conserver un objet volé précédemment.', 'formation_externe', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'non_vie' AND t.key = 'menage'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'EXT-VOL-004', 'non_vie', t.id, 'single',
       'Madame S., devenue plus prudente depuis son expérience dans le cas n° 1, est à nouveau en balade dans la même rue. Elle remarque que quelqu''un essaie d''attraper son sac derrière elle. Ses mains s''agrippent à son sac. Elle se retourne. Surpris, le malfrat saisit finalement le sac et l''arra che des mains de Madame S. par un violent coup.', 'De quoi s''agit-il juridiquement ?', '[{"text":"Vol avec effraction","correct":false,"why_wrong":null},{"text":"Détroussement","correct":true},{"text":"Vol simple","correct":false,"why_wrong":null}]'::jsonb, 1,
       'Usage clair de la force pour surmonter l''opposition de Madame S. Page 2 / 2', 'formation_externe', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'non_vie' AND t.key = 'menage'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'EXT-VOL-005', 'non_vie', t.id, 'single',
       'Paul O. n''a pas de chance. Sur une route verglacée, son véhicule dérape et percute un arbre de front. Paul O. s''en sort avec quelques contusions, mais il est coincé entre le siège et le volant. Son attaché- case est projeté hors du véhicule à travers le pare-brise. Après une minute, un bon samaritain vient à son secours. Ce dernier comprend tout de suite la situation : une victime en difficulté a besoin d''aide ! Il appelle un médecin d''urgence et les pompiers sans donner son nom. Le samaritain quitte le lieu de l''accident et emporte également l''attaché-case de Paul O.', 'De quoi s''agit-il juridiquement ?', '[{"text":"Vol avec effraction","correct":false,"why_wrong":null},{"text":"Détroussement","correct":true},{"text":"Vol simple","correct":false,"why_wrong":null}]'::jsonb, 1,
       'Paul O. a été victime d''un accident et il n''est pas en mesure d''opposer une résistance à la suite de l''accident. Mais ce ne sont pas les blessures subies qui l''empêchent de s''opposer, mais sa situation fâcheuse ; le fait d''être coincé dans son véhicule.', 'formation_externe', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'non_vie' AND t.key = 'menage'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'EXT-VOL-006', 'non_vie', t.id, 'single',
       'Joe la Canaille est de nouveau en vadrouille. Avec une échelle, il monte sur le toit plat d''un entrepôt. Il enlève les vis d''une coupole de verre et pénètre dans l''entrepôt. Il dérobe des marchandises d''une valeur totale de CHF 2''000.– sur les rayons et quitte l''entrepôt de la même manière qu''il y était entré.', 'De quoi s''agit-il juridiquement ?', '[{"text":"Vol avec effraction","correct":false,"why_wrong":null},{"text":"Détroussement","correct":false,"why_wrong":null},{"text":"Vol simple","correct":true}]'::jsonb, 1,
       'Joe la Canaille a ouvert une voie d''accès dans le bâtiment, comme il est prévu de l''ouvrir. Aucune détérioration de la substance de la chose, aucun recours à la force, pas d''effraction.', 'formation_externe', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'non_vie' AND t.key = 'menage'
ON CONFLICT (external_id) DO NOTHING;

-- 210 question(s) traitée(s).
