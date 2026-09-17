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

-- ───────── nonvie_klary_bank_v2.json — Banque Klary v2, extension NON-VIE 110 questions couvrant les 7 thèmes officiels VBV, avec ancrages législatifs et cas concrets. ─────────
INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-NV-MN-001', 'non_vie', t.id, 'single',
       NULL, 'Sur quelle base légale repose la responsabilité civile privée (RC privée) d''un particulier en Suisse ?', '[{"text":"Art. 41 CO : responsabilité pour acte illicite fautif","correct":true},{"text":"Art. 63 LCR : circulation routière","correct":false,"why_wrong":"La LCR encadre la RC véhicule, pas la RC privée générale."},{"text":"Art. 45 LSA : fiche d''information","correct":false,"why_wrong":"La LSA règle la surveillance, pas la responsabilité."},{"text":"Art. 55 CO seulement (chef de famille)","correct":false,"why_wrong":"L''art. 55 CO vise la responsabilité de l''employeur ou du chef de famille, mais la base générale reste l''art. 41 CO."}]'::jsonb, 1,
       'Art. 41 CO : celui qui cause un dommage à autrui par un acte illicite fautif doit le réparer. La RC privée LCA couvre ce risque pour les actes de la vie quotidienne.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'non_vie' AND t.key = 'menage'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-NV-MN-002', 'non_vie', t.id, 'single',
       NULL, 'Comment se calcule l''inventaire du ménage à déclarer sur un contrat choses ménage ?', '[{"text":"Valeur à neuf de tous les biens mobiliers, y compris vêtements et provisions","correct":true},{"text":"Valeur d''occasion sur brocante ou eBay","correct":false,"why_wrong":"L''assureur indemnise en valeur à neuf ; sous-évaluer expose à la règle proportionnelle."},{"text":"Uniquement la valeur des objets de plus de 500 CHF","correct":false,"why_wrong":"Aucun seuil : l''ensemble du contenu compte."},{"text":"Prix moyen d''un ménage suisse (~30 000 CHF)","correct":false,"why_wrong":"Fourchette indicative pour vendre, jamais une base d''inventaire réelle."}]'::jsonb, 1,
       'Choses ménage : somme d''assurance = valeur à NEUF de tous les biens meubles (habits, meubles, appareils, provisions). Une sous-évaluation déclenche l''art. 69 al. 2 LCA (règle proportionnelle en cas de sous-assurance).', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'non_vie' AND t.key = 'menage'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-NV-MN-003', 'non_vie', t.id, 'single',
       'Un client déclare 60 000 CHF d''inventaire pour un ménage réellement estimé à 100 000 CHF. Un incendie détruit pour 40 000 CHF de biens.', 'Combien va-t-il percevoir de son assureur choses ménage ?', '[{"text":"40 000 CHF (dommage réel)","correct":false,"why_wrong":"Ignorerait la sous-assurance."},{"text":"24 000 CHF (60/100 x 40 000)","correct":true},{"text":"60 000 CHF (somme assurée)","correct":false,"why_wrong":"Piège : le plafond ne s''applique que si le dommage dépasse la somme, pas ici."},{"text":"0 CHF (contrat nul)","correct":false,"why_wrong":"La sous-assurance réduit l''indemnité, elle n''annule pas le contrat."}]'::jsonb, 2,
       'Règle proportionnelle art. 69 al. 2 LCA : indemnité = dommage x (somme assurée / valeur réelle). Ici 40 000 x (60 000 / 100 000) = 24 000 CHF. Argument fort du conseil : mettre à jour l''inventaire chaque année.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'non_vie' AND t.key = 'menage'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-NV-MN-004', 'non_vie', t.id, 'multiple',
       NULL, 'Qui est assuré par la RC privée souscrite par le chef de famille ?', '[{"text":"Le preneur lui-même","correct":true},{"text":"Son conjoint ou partenaire enregistré vivant sous le même toit","correct":true},{"text":"Les enfants mineurs sous autorité parentale","correct":true},{"text":"Les enfants majeurs sans revenu vivant à la maison, aux études","correct":true},{"text":"Le beau-frère de passage pour un week-end","correct":false,"why_wrong":"Un simple invité n''entre pas dans le cercle assuré."},{"text":"L''employé de maison salarié pour ses activités professionnelles","correct":false,"why_wrong":"L''employé de maison relève d''un contrat de travail (art. 328 CO) et sa faute pro n''est pas couverte par la RC privée du ménage."}]'::jsonb, 2,
       'Cercle des personnes assurées RC privée (usage marché suisse) : preneur + membres de la communauté domestique (art. 331 CC), y compris enfants majeurs à charge en formation. Sur base des CGA type Zurich, AXA, Mobilière.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'non_vie' AND t.key = 'menage'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-NV-MN-005', 'non_vie', t.id, 'single',
       'Un fiduciaire indépendant reçoit son propre client dans son bureau à Vevey.', 'Ce fiduciaire renverse par mégarde du café sur l''ordinateur portable de son client (valeur 2 800 CHF). Sa RC privée intervient-elle ?', '[{"text":"Oui, la RC privée couvre tous les dommages non intentionnels","correct":false,"why_wrong":"Erreur classique : la RC privée EXCLUT explicitement l''activité professionnelle."},{"text":"Non, il faut une RC professionnelle ou d''entreprise","correct":true},{"text":"Oui, si le montant reste inférieur à 5 000 CHF","correct":false,"why_wrong":"Aucun seuil ne fait basculer un risque pro dans une RC privée."},{"text":"Oui, uniquement si le client a lui-même une RC privée","correct":false}]'::jsonb, 1,
       'Toutes les CGA RC privée du marché suisse excluent les dommages causés dans l''exercice d''une activité professionnelle ou lucrative indépendante. Base : art. 33 LCA (portée du contrat) et clauses standards. Solution : RC professionnelle LCA.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'non_vie' AND t.key = 'menage'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-NV-MN-006', 'non_vie', t.id, 'single',
       NULL, 'En RC privée, un père est-il couvert lorsque sa fille de 8 ans casse par accident la vitrine d''un magasin ?', '[{"text":"Oui, au titre de la responsabilité du chef de famille (art. 333 CC)","correct":true},{"text":"Non, un enfant mineur est incapable de discernement donc ni lui ni ses parents ne répondent","correct":false,"why_wrong":"Piège juridique : les parents restent responsables à titre de garde (art. 333 CC), et la RC privée s''active."},{"text":"Oui, mais uniquement si le père était physiquement présent","correct":false,"why_wrong":"La présence n''est pas la condition, la garde légale suffit."},{"text":"Non, sauf option enfant en supplément","correct":false,"why_wrong":"Aucune option supplémentaire n''est requise pour ses propres enfants sous autorité parentale."}]'::jsonb, 1,
       'Art. 333 CC : le chef de famille répond du dommage causé par les personnes mineures placées sous son autorité. La RC privée couvre systématiquement les enfants du ménage.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'non_vie' AND t.key = 'menage'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-NV-MN-007', 'non_vie', t.id, 'single',
       'Le chien Labrador d''une famille lausannoise mord un livreur venu déposer un colis à la porte.', 'Sur quelle assurance faut-il déclarer le sinistre corporel du livreur ?', '[{"text":"La casco du véhicule du livreur","correct":false,"why_wrong":"Aucun rapport avec un dommage corporel causé par un chien."},{"text":"La RC privée du détenteur du chien (avec inclusion animaux)","correct":true},{"text":"La LAMal du livreur uniquement","correct":false,"why_wrong":"La LAMal soigne, mais le lésé garde une créance civile contre le détenteur qui doit être couvert par la RC privée."},{"text":"L''assurance ménage inventaire","correct":false,"why_wrong":"L''inventaire couvre des choses, pas la responsabilité pour un chien."}]'::jsonb, 1,
       'Art. 56 CO : le détenteur d''un animal répond du dommage causé. La quasi-totalité des RC privées suisses incluent les chiens et chats du ménage. Certaines races (Rottweiler, Amstaff) nécessitent une attention CGA.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'non_vie' AND t.key = 'menage'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-NV-MN-008', 'non_vie', t.id, 'multiple',
       NULL, 'Quelles affirmations sont exactes concernant la distinction vol simple / vol avec effraction en choses ménage ?', '[{"text":"Le vol avec effraction (art. 139 CP) est couvert en base jusqu''à la somme d''inventaire","correct":true},{"text":"Le vol simple (sans effraction) est une garantie OPTIONNELLE","correct":true},{"text":"Le vol simple est plafonné à des sous-limites (souvent 2 000, 5 000 ou 10 000 CHF)","correct":true},{"text":"Aucune différence, tout est couvert au même montant","correct":false,"why_wrong":"Piège : le vol simple est une garantie optionnelle et fortement limitée."},{"text":"Le vol avec effraction est une garantie optionnelle","correct":false,"why_wrong":"L''effraction fait partie de la couverture de base des choses ménage."}]'::jsonb, 2,
       'Vol avec effraction (traces d''effraction, art. 139 CP) : garantie de base jusqu''à la somme d''inventaire. Vol simple (sans effraction, ex. sac oublié) : garantie optionnelle plafonnée souvent à 2 000, 5 000 ou 10 000 CHF.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'non_vie' AND t.key = 'menage'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-NV-MN-009', 'non_vie', t.id, 'single',
       NULL, 'Une cliente stocke des bijoux d''une valeur de 40 000 CHF chez elle. Comment le contrat choses ménage traite-t-il ce risque ?', '[{"text":"Ils sont couverts sans limite dans la somme d''inventaire","correct":false,"why_wrong":"Sous-limite systématique pour les objets de valeur, sauf déclaration expresse."},{"text":"Sous-limite typique de 20 à 30% de la somme d''inventaire, ou plafond fixe (souvent 10 000 CHF)","correct":true},{"text":"Ils sont automatiquement exclus","correct":false,"why_wrong":"Ils sont couverts, mais dans une sous-limite ; il faut souvent une assurance objets de valeur séparée pour le solde."},{"text":"Seul le coffre de banque les couvre","correct":false,"why_wrong":"Le coffre bancaire est une option, pas la règle."}]'::jsonb, 1,
       'Sous-limite CGA marché suisse : bijoux, montres, oeuvres d''art, collections plafonnés (souvent 10 000 CHF ou 20 à 30% de l''inventaire). Au-delà : déclaration séparée ou police valeurs séparée.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'non_vie' AND t.key = 'menage'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-NV-MN-010', 'non_vie', t.id, 'single',
       'Une locataire de 3,5 pièces à Renens rentre du travail : le flexible de sa machine à laver a lâché, causant 8 000 CHF de dégâts à son mobilier.', 'Quelle assurance intervient pour indemniser ses biens abîmés ?', '[{"text":"La casco du véhicule","correct":false,"why_wrong":"Aucun lien avec un dégât d''eau domestique."},{"text":"La couverture dégâts d''eau de son assurance choses ménage","correct":true},{"text":"La RC de la régie","correct":false,"why_wrong":"La régie est responsable des installations fixes du bâtiment, pas du contenu de la locataire."},{"text":"L''assurance bâtiment du propriétaire","correct":false,"why_wrong":"L''assurance bâtiment couvre la structure, pas le mobilier de la locataire."}]'::jsonb, 1,
       'Choses ménage, garantie dégâts d''eau : ruptures de conduites intérieures, refoulement d''eau, débordements. Les biens fixes du bâtiment sont couverts par l''assurance bâtiment (art. 58 CO et ECA cantonale).', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'non_vie' AND t.key = 'menage'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-NV-MN-011', 'non_vie', t.id, 'multiple',
       NULL, 'Quels événements font partie de la couverture INCENDIE de base d''une assurance choses ménage ?', '[{"text":"Feu, fumée soudaine et accidentelle","correct":true},{"text":"Foudre directe","correct":true},{"text":"Explosion, implosion","correct":true},{"text":"Chute d''aéronefs ou parties de ceux-ci","correct":true},{"text":"Fatigue naturelle et usure normale des meubles","correct":false,"why_wrong":"L''usure est explicitement exclue de toute assurance choses."},{"text":"Brûlure d''un fer à repasser sur un tapis (dommage isolé sans propagation)","correct":false,"why_wrong":"Piège : les dommages sans propagation (dommages par un foyer utile) sont couverts uniquement en option ''dommages incendie sans feu'' non incluse en base."}]'::jsonb, 2,
       'Couverture incendie de base : feu, foudre, explosion, chute d''aéronefs (art. standard des CGA suisses, alignés sur l''ancienne norme ECA). Dommages par la chaleur sans feu (fer à repasser) : option séparée.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'non_vie' AND t.key = 'menage'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-NV-MN-012', 'non_vie', t.id, 'single',
       NULL, 'Que veut dire le système de couverture ''premier risque'' dans une assurance choses ?', '[{"text":"L''assureur ne paie que le premier sinistre de l''année","correct":false,"why_wrong":"N''a aucun sens contractuel."},{"text":"La somme assurée constitue un plafond fixe, sans application de la règle proportionnelle en cas de sous-assurance","correct":true},{"text":"Le client doit assurer ses biens au prix de neuf uniquement","correct":false},{"text":"L''assureur exige un premier paiement dans les 30 jours","correct":false,"why_wrong":"Confusion avec la prime, sans lien avec le premier risque."}]'::jsonb, 1,
       'Premier risque : la somme convenue est le plafond, la règle proportionnelle art. 69 LCA ne s''applique pas. Pratique pour garanties additionnelles (bijoux, argent liquide, vol simple à l''extérieur).', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'non_vie' AND t.key = 'menage'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-NV-MN-013', 'non_vie', t.id, 'multiple',
       'Une famille part en vacances 3 semaines à Bali et emporte du matériel photo (7 000 CHF) et deux ordinateurs portables (4 500 CHF chacun).', 'Quelles affirmations sur la couverture ''à l''extérieur'' de la choses ménage sont EXACTES ?', '[{"text":"La couverture ''à l''extérieur'' du domicile existe dans la police choses ménage","correct":true},{"text":"Elle est souvent plafonnée à environ 20% de la somme d''inventaire (ou plafond fixe)","correct":true},{"text":"Il faut vérifier CGA avant un départ prolongé et envisager une police valeurs dédiée si besoin","correct":true},{"text":"Les biens sont couverts partout dans le monde sans aucune sous-limite","correct":false,"why_wrong":"Le plafond hors domicile est toujours réduit."},{"text":"Les biens ne sont jamais couverts hors du domicile","correct":false,"why_wrong":"La couverture externe existe, dans une sous-limite."}]'::jsonb, 2,
       'CGA choses ménage : les biens sont couverts partout dans le monde (''lieu d''assurance étendu'') mais avec une sous-limite (souvent 20% ou plafond fixe). Vérifier avant un départ prolongé, sinon police valeurs dédiée.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'non_vie' AND t.key = 'menage'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-NV-MN-014', 'non_vie', t.id, 'single',
       NULL, 'Un client a perdu la clé principale de son appartement à Lausanne. Le remplacement du cylindre coûte 900 CHF. Quelle assurance couvre ?', '[{"text":"L''assurance bâtiment de la régie","correct":false,"why_wrong":"La régie n''a pas à supporter ce risque personnel du locataire."},{"text":"L''option ''perte de clés / frais de serrurier'' de la choses ménage ou RC privée selon assureur","correct":true},{"text":"L''assurance RC privée intégralement","correct":false,"why_wrong":"La RC privée intervient s''il y a un dommage à autrui, ici le dommage est le coût propre du locataire."},{"text":"La casco du véhicule","correct":false}]'::jsonb, 1,
       'Option marché courante : ''perte de clés'' rembourse le remplacement de serrures et cylindres. Rattachée soit à la choses ménage (couverture des propres coûts) soit à la RC (dommage locatif dû à la perte d''une clé maîtresse).', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'non_vie' AND t.key = 'menage'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-NV-MN-015', 'non_vie', t.id, 'single',
       'Un client emploie une aide de ménage 4 heures par semaine, payée 30 CHF/heure, non déclarée.', 'Quel risque juridique et assurantiel majeur l''expose ?', '[{"text":"Aucun, les petits emplois de moins de 5 heures sont exemptés","correct":false,"why_wrong":"Faux : dès le 1er franc versé, il y a une relation employeur/employé au sens du CO."},{"text":"Il doit affilier à l''AVS, souscrire l''assurance-accidents obligatoire (LAA) et cotiser dès la 1ère heure","correct":true},{"text":"Il doit uniquement déclarer aux impôts","correct":false,"why_wrong":"Correct mais insuffisant : il manque tout le volet social LAA/AVS."},{"text":"L''aide de ménage doit souscrire elle-même sa LAA","correct":false,"why_wrong":"La LAA salariés est à la charge de l''employeur (art. 91 al. 1 LAA)."}]'::jsonb, 2,
       'Employer une aide de ménage = obligation AVS/AI/APG/AC + LAA obligatoire dès la 1ère heure de travail. Procédure simplifiée : Chèque-Emploi (Cantons romands). Non-affiliation = risque de recours de la CNA et amendes.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'non_vie' AND t.key = 'menage'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-NV-MN-016', 'non_vie', t.id, 'single',
       NULL, 'Le fils de 20 ans du preneur, étudiant à Zurich, loue seul un studio. Est-il encore couvert par la RC privée familiale de ses parents ?', '[{"text":"Non, dès qu''il a son propre ménage il en sort du cercle assuré","correct":true},{"text":"Oui, jusqu''à 25 ans systématiquement","correct":false,"why_wrong":"Erreur : la limite d''âge existe (souvent 25 ans) MAIS uniquement s''il vit dans la communauté domestique."},{"text":"Oui, à condition que ses parents paient son loyer","correct":false,"why_wrong":"Le financement du loyer ne remplace pas le critère de la communauté domestique."},{"text":"Oui, tant qu''il est étudiant","correct":false}]'::jsonb, 1,
       'CGA marché : membres du ménage assurés = communauté domestique effective. Quitter le foyer = sortir du cercle. Argument commercial : proposer une RC privée jeune adulte peu coûteuse dès l''installation en studio.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'non_vie' AND t.key = 'menage'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-NV-MN-017', 'non_vie', t.id, 'multiple',
       NULL, 'Quels dommages sont typiquement EXCLUS d''une assurance RC privée ?', '[{"text":"Dommages causés à sa propre famille cohabitante","correct":true},{"text":"Dommages causés dans l''exercice d''une activité professionnelle indépendante","correct":true},{"text":"Dommages avec un véhicule à moteur soumis à la LCR","correct":true},{"text":"Dommages intentionnels","correct":true},{"text":"Verre cassé lors d''une partie de football entre amis dans un jardin privé","correct":false,"why_wrong":"Cas classique couvert par la RC privée."},{"text":"Dommage causé au domicile d''un tiers en tant qu''invité","correct":false,"why_wrong":"Cas type couvert (dommage à la chose confiée dans certaines CGA, ou dommage matériel courant)."}]'::jsonb, 2,
       'Exclusions marché standard RC privée : sa propre famille (pas de tiers), activité pro, véhicules à moteur (relèvent de la RC LCR), intention (art. 14 LCA). Base : CGA type Zurich/Mobilière.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'non_vie' AND t.key = 'menage'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-NV-MN-018', 'non_vie', t.id, 'single',
       NULL, 'Un locataire abîme la porte du studio qu''il vient de louer. Quelle assurance intervient ?', '[{"text":"La RC privée avec inclusion ''dommages aux locaux loués'' ou ''RC locative''","correct":true},{"text":"L''assurance bâtiment du propriétaire","correct":false,"why_wrong":"La régie va facturer le locataire, la police bâtiment ne prend pas en charge un dommage causé par le locataire."},{"text":"L''assurance ménage inventaire","correct":false,"why_wrong":"L''inventaire couvre les biens du locataire, pas les dommages qu''il cause au bâtiment."},{"text":"La casco du véhicule","correct":false}]'::jsonb, 1,
       'Inclusion standard ''dommages aux locaux loués'' de la RC privée LCA : couvre les dégâts causés à la chose louée. Sans cette inclusion, la régie facture le locataire au titre de l''art. 267 CO (restitution en bon état).', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'non_vie' AND t.key = 'menage'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-NV-MN-019', 'non_vie', t.id, 'single',
       NULL, 'Quelle est la différence entre valeur à neuf et valeur actuelle dans une police choses ménage ?', '[{"text":"La valeur à neuf ne s''applique qu''aux véhicules","correct":false,"why_wrong":"Concept général en assurance choses."},{"text":"La valeur à neuf = coût de remplacement par un bien équivalent neuf ; la valeur actuelle = valeur à neuf moins vétusté","correct":true},{"text":"La valeur actuelle est toujours la même que la valeur à neuf","correct":false,"why_wrong":"Elle en est déduite de la vétusté."},{"text":"La valeur actuelle est la valeur de revente sur le marché de l''occasion","correct":false,"why_wrong":"Confusion fréquente : la valeur actuelle assurantielle diffère du marché d''occasion."}]'::jsonb, 1,
       'Convention CGA choses : indemnisation en valeur à neuf tant que la vétusté n''excède pas ~40 ; au-delà, retour à la valeur actuelle. Objectif : éviter l''enrichissement (art. 62 LCA).', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'non_vie' AND t.key = 'menage'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-NV-MN-020', 'non_vie', t.id, 'single',
       'Une adolescente garde ponctuellement les enfants du voisin (baby-sitting occasionnel, 20 CHF/soir).', 'Est-elle assurée en RC pendant cette activité ?', '[{"text":"Oui, la RC privée du chef de famille couvre le baby-sitting occasionnel","correct":true},{"text":"Non, elle est en activité professionnelle indépendante","correct":false,"why_wrong":"Piège : le baby-sitting occasionnel n''est pas considéré comme une activité professionnelle au sens des CGA."},{"text":"Oui, uniquement si le voisin déclare l''emploi à l''AVS","correct":false,"why_wrong":"Aucun impact sur la couverture RC privée."},{"text":"Non, seule la RC des parents des enfants gardés peut jouer","correct":false,"why_wrong":"C''est ELLE qui doit être couverte, pas l''inverse."}]'::jsonb, 2,
       'CGA marché suisse : baby-sitting, cours de soutien scolaire, petits jobs occasionnels d''ado sont considérés comme extension de la vie privée. La RC privée du ménage couvre les dommages qu''elle cause (aux enfants, à l''appartement).', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'non_vie' AND t.key = 'menage'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-NV-VH-100', 'non_vie', t.id, 'single',
       'Un client compare deux offres RC véhicule à sommes différentes (5 mio vs 100 mio CHF).', 'Quelle est la somme d''assurance minimale LÉGALE de la RC véhicule en Suisse depuis 2015 ?', '[{"text":"1 million CHF par sinistre","correct":false,"why_wrong":"Ancien minimum d''avant réforme."},{"text":"5 millions CHF par sinistre","correct":true},{"text":"10 millions CHF par sinistre","correct":false,"why_wrong":"Pratique commerciale de nombreux assureurs, mais pas le minimum légal."},{"text":"100 millions CHF par sinistre","correct":false,"why_wrong":"Plafond illimité proposé chez certains assureurs, pas le minimum légal."}]'::jsonb, 1,
       'Art. 3 OAV : la somme d''assurance minimale de la RC véhicule est de 5 millions CHF par sinistre (personnes et choses confondus) depuis le 1er janvier 2015. En pratique, la plupart des CGA offrent 100 millions ou illimité.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'non_vie' AND t.key = 'vehicule'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-NV-VH-101', 'non_vie', t.id, 'single',
       'Un propriétaire prête sa voiture à un ami pour un week-end à Interlaken. L''ami provoque un accident, dommages 25 000 CHF au tiers.', 'Comment intervient l''assurance RC véhicule ?', '[{"text":"La RC ne joue pas car l''ami n''est pas le preneur","correct":false,"why_wrong":"La RC véhicule suit le VÉHICULE, pas le conducteur."},{"text":"La RC du véhicule couvre le dommage au tiers ; l''assureur peut ensuite examiner un éventuel recours contre l''ami en cas de faute grave","correct":true},{"text":"L''ami doit avoir sa propre RC véhicule","correct":false,"why_wrong":"Faux : la RC véhicule accompagne le véhicule immatriculé."},{"text":"Aucune assurance ne prend en charge un prêt de véhicule","correct":false}]'::jsonb, 1,
       'Art. 65 LCR : la RC véhicule couvre le détenteur ET tout conducteur autorisé. Recours possible en cas de faute grave (alcool, drogue, vitesse excessive) au sens de l''art. 65 al. 3 LCR et art. 14 LCA.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'non_vie' AND t.key = 'vehicule'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-NV-VH-102', 'non_vie', t.id, 'single',
       'Un conducteur provoque un accident avec 1,2 pour mille d''alcool dans le sang. L''assureur RC indemnise la victime pour 350 000 CHF.', 'Que peut faire l''assureur RC contre le conducteur fautif ?', '[{"text":"Rien, le contrat interdit tout recours","correct":false,"why_wrong":"L''ivresse qualifiée est un cas classique de recours."},{"text":"Exercer un recours (regress) contre le conducteur pour une part du montant versé","correct":true},{"text":"Annuler rétroactivement l''assurance","correct":false,"why_wrong":"L''assureur doit d''abord indemniser la victime (protection LCR) puis se retourne."},{"text":"Confisquer le véhicule directement","correct":false,"why_wrong":"Aucune compétence privée : c''est un acte d''autorité (art. 90a LCR)."}]'::jsonb, 2,
       'Art. 65 al. 3 LCR : l''assureur peut recourir contre le preneur ou le conducteur en cas de faute grave (alcool, drogue, vitesse). Barème de recours interne (règles de la CSAM) selon degré de responsabilité, jusqu''à 100% dans les cas les plus lourds.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'non_vie' AND t.key = 'vehicule'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-NV-VH-103', 'non_vie', t.id, 'single',
       NULL, 'Qu''est-ce que l''assurance ''occupants'' d''un véhicule ?', '[{"text":"Une couverture accident pour les personnes transportées, indépendante de la RC","correct":true},{"text":"Une extension de la RC pour les invités du preneur","correct":false,"why_wrong":"L''occupants est indépendante de la RC."},{"text":"L''obligation légale de l''art. 63 LCR pour tous les passagers","correct":false,"why_wrong":"L''obligation légale ne concerne que la RC, l''occupants est facultative."},{"text":"Une assurance qui rembourse les billets d''auto-partage","correct":false}]'::jsonb, 1,
       'L''assurance occupants LCA est facultative. Elle verse un capital en cas d''invalidité/décès et couvre les frais médicaux non pris en charge par la LAMal/LAA pour les personnes transportées. Utile pour les invités non-Suisses ou non assurés LAA.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'non_vie' AND t.key = 'vehicule'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-NV-VH-104', 'non_vie', t.id, 'single',
       NULL, 'Un conducteur suisse voyage en voiture jusqu''en Serbie. Que doit-il présenter obligatoirement à la frontière ?', '[{"text":"Une carte verte internationale d''assurance","correct":true},{"text":"Sa police d''assurance en 3 exemplaires","correct":false,"why_wrong":"La police complète n''est pas exigée : c''est la carte verte."},{"text":"Une lettre notariée de son assureur","correct":false},{"text":"Rien, la RC suisse est reconnue dans le monde entier","correct":false,"why_wrong":"Système carte verte requis hors Espace Économique Européen."}]'::jsonb, 1,
       'Système carte verte (Council of Bureaux) : preuve internationale de couverture RC véhicule. Obligatoire hors UE/AELE (dont Serbie). Fournie gratuitement par l''assureur RC.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'non_vie' AND t.key = 'vehicule'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-NV-VH-105', 'non_vie', t.id, 'multiple',
       NULL, 'Quelles affirmations sur le système bonus-malus RC véhicule en Suisse sont EXACTES ?', '[{"text":"Le degré de prime évolue à la baisse chaque année sans sinistre","correct":true},{"text":"Le degré remonte de plusieurs échelons après un sinistre responsable","correct":true},{"text":"Il existe un bonus-malus séparé pour la RC et pour la casco","correct":true},{"text":"Bonusserv permet à l''assureur de consulter l''historique sinistres du preneur","correct":true},{"text":"Le bonus double chaque année sans sinistre","correct":false,"why_wrong":"Progression standardisée d''un degré par an, pas doublement."},{"text":"Chaque sinistre annule tout le bonus accumulé","correct":false,"why_wrong":"Recul par degrés selon barème, pas remise à zéro."}]'::jsonb, 2,
       'Bonus-malus RC : barème par degrés (souvent 22 à 0), 1 degré gagné par année sans sinistre, plusieurs degrés perdus par sinistre. Bonus-malus séparés RC et casco. Consultation possible via le système Bonusserv (info sinistres RC entre assureurs suisses).', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'non_vie' AND t.key = 'vehicule'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-NV-VH-106', 'non_vie', t.id, 'single',
       NULL, 'Après un accident où l''assureur casco a versé 12 000 CHF, quel est le délai pour résilier le contrat casco selon le nouveau droit LCA ?', '[{"text":"30 jours dès la survenance du sinistre","correct":false,"why_wrong":"Ancien délai avant réforme 2022."},{"text":"14 jours dès versement de l''indemnité","correct":true},{"text":"1 mois avant la prochaine échéance annuelle uniquement","correct":false,"why_wrong":"Confusion avec la résiliation ordinaire annuelle."},{"text":"Impossible avant 3 ans","correct":false,"why_wrong":"L''art. 42 LCA prévoit un droit spécial après sinistre."}]'::jsonb, 1,
       'Art. 42 LCA (nouveau, 1er janvier 2022) : chaque partie peut résilier le contrat après sinistre, dans les 14 jours dès versement de l''indemnité. Cette réciprocité doit être connue du conseiller.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'non_vie' AND t.key = 'vehicule'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-NV-VH-107', 'non_vie', t.id, 'single',
       'Un client de 35 ans conduit une Tesla Model 3 en leasing sur 4 ans (48 000 CHF de résiduel). Il souhaite réduire ses primes.', 'Il demande une casco PARTIELLE seulement. Que lui répondez-vous ?', '[{"text":"OK, la partielle suffit s''il conduit prudemment","correct":false,"why_wrong":"Ne couvre pas la collision propre : la dette de leasing reste exposée."},{"text":"Le contrat de leasing impose la casco COMPLÈTE pour toute la durée ; refuser expose le client à la dette résiduelle en cas de sinistre total","correct":true},{"text":"Le leasing implique automatiquement la RC uniquement","correct":false},{"text":"La casco complète n''existe pas pour les véhicules électriques","correct":false,"why_wrong":"Elle existe, avec parfois option ''batterie'' spécifique."}]'::jsonb, 1,
       'Contrat de leasing standard : casco complète obligatoire jusqu''à restitution. Le loueur reste économiquement propriétaire. Sinistre total sans complète = client débiteur du solde de leasing (souvent > 30 000 CHF sur véhicule électrique).', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'non_vie' AND t.key = 'vehicule'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-NV-VH-108', 'non_vie', t.id, 'multiple',
       'Le véhicule d''un client est endommagé sur un parking de centre commercial sans témoin (1 800 CHF de dégâts).', 'Quelles affirmations sont VRAIES concernant les ''dommages de parking'' ?', '[{"text":"La garantie ''dommages de parking'' (casco) rembourse ce type de dommage","correct":true},{"text":"L''événement est souvent limité en nombre par an (2 à 4 événements par CGA)","correct":true},{"text":"L''impact sur le degré de bonus casco est généralement limité voire nul","correct":true},{"text":"La RC du responsable inconnu paie automatiquement","correct":false,"why_wrong":"Impossible d''engager la RC d''un tiers non identifié sans preuve."},{"text":"L''assurance protection juridique rembourse le sinistre matériel","correct":false,"why_wrong":"La PJ finance des honoraires d''avocat, elle ne rembourse pas le sinistre matériel."}]'::jsonb, 2,
       'Option ''dommages de parking'' des CGA casco : couvre les dommages causés par des tiers inconnus quand le véhicule est stationné. Souvent avec un plafond annuel (2 à 4 événements) et impact bonus limité.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'non_vie' AND t.key = 'vehicule'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-NV-VH-109', 'non_vie', t.id, 'single',
       NULL, 'Une casco partielle couvre-t-elle une collision avec un chevreuil sur route de campagne ?', '[{"text":"Oui, la collision avec animaux sauvages fait partie de la casco partielle","correct":true},{"text":"Non, il faut la casco complète","correct":false,"why_wrong":"Piège classique : les animaux sauvages font partie de la partielle."},{"text":"Uniquement si l''animal meurt sur place","correct":false,"why_wrong":"Aucune condition de ce type dans les CGA."},{"text":"Uniquement en dehors des heures nocturnes","correct":false}]'::jsonb, 1,
       'Casco partielle standard : vol, feu, éléments naturels, bris de glace, collision avec animaux sauvages. Cette dernière est un cas fréquent en Suisse (chevreuils, sangliers).', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'non_vie' AND t.key = 'vehicule'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-NV-VH-110', 'non_vie', t.id, 'multiple',
       NULL, 'Quels dommages sont EXCLUS des couvertures RC véhicule et casco d''origine (à moins d''option spécifique) ?', '[{"text":"Dommages au véhicule lors d''une course de vitesse sur circuit","correct":true},{"text":"Dommages causés par un conducteur sans permis valable","correct":true},{"text":"Dommages intentionnels du preneur","correct":true},{"text":"Effets personnels dans le véhicule volé (bagages)","correct":false,"why_wrong":"Piège : les effets personnels sont couverts jusqu''à un plafond dans la casco partielle."},{"text":"Bris de glace sur autoroute","correct":false,"why_wrong":"Bris de glace = garantie casco partielle."}]'::jsonb, 2,
       'Exclusions marché standard : compétitions et courses (art. CGA), conduite sans permis, actes intentionnels (art. 14 al. 1 LCA). Pour les courses : option ''events sportifs'' spécifique. Base : art. 14 LCA.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'non_vie' AND t.key = 'vehicule'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-NV-VH-111', 'non_vie', t.id, 'single',
       NULL, 'Comment le nouveau droit LCA 2022 traite-t-il la faute grave (négligence grave) du preneur (art. 14 LCA) ?', '[{"text":"L''assureur peut réduire ses prestations en proportion","correct":true},{"text":"L''assureur doit toujours payer 100%","correct":false,"why_wrong":"Faux, la faute grave permet une réduction."},{"text":"Le contrat est nul rétroactivement","correct":false,"why_wrong":"Confusion avec le dol/intention."},{"text":"L''assureur ne peut jamais réduire ses prestations","correct":false,"why_wrong":"Réduction possible pour négligence grave."}]'::jsonb, 1,
       'Art. 14 LCA : intention = l''assureur n''est pas lié ; négligence grave = réduction possible dans la mesure correspondant au degré de faute. Depuis la réforme 2022, la clause type impose une réduction proportionnelle claire.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'non_vie' AND t.key = 'vehicule'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-NV-VH-112', 'non_vie', t.id, 'single',
       NULL, 'Un client dépose les plaques d''immatriculation pour l''hiver. Que se passe-t-il pour son assurance ?', '[{"text":"Le contrat est résilié automatiquement","correct":false,"why_wrong":"Non : il est SUSPENDU."},{"text":"Le contrat est suspendu, la RC continue via une garantie ''plaques déposées'' réduite, prime au prorata","correct":true},{"text":"Le client doit continuer à payer la prime pleine","correct":false,"why_wrong":"Pratique commerciale : réduction si plaques déposées."},{"text":"Le véhicule doit être revendu obligatoirement","correct":false}]'::jsonb, 1,
       'Convention SVV (association suisse d''assurances) : plaques déposées auprès du SAN = contrat suspendu, garantie de base pour le véhicule en garage (feu, vol, éléments naturels), prime au prorata. Réactivation à la reprise des plaques.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'non_vie' AND t.key = 'vehicule'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-NV-VH-113', 'non_vie', t.id, 'single',
       'Un conducteur commet un délit de fuite après avoir endommagé une voiture stationnée sur un parking de la Migros. L''auteur reste introuvable malgré la vidéosurveillance.', 'Comment la victime est-elle indemnisée pour les 6 200 CHF de dégâts ?', '[{"text":"Par le Fonds national de garantie automobile (art. 76 LCR)","correct":true},{"text":"Par la LAMal","correct":false,"why_wrong":"La LAMal ne couvre pas les dommages matériels au véhicule."},{"text":"Par sa RC véhicule personnelle","correct":false,"why_wrong":"La RC véhicule couvre les dommages qu''ON CAUSE, pas ceux qu''on subit."},{"text":"Par la casco partielle uniquement","correct":false,"why_wrong":"Partielle ne couvre pas la collision par tiers inconnu ; c''est la casco complète ''stationnement'' ou le Fonds qui interviennent."}]'::jsonb, 1,
       'Art. 76 LCR : Fonds national suisse de garantie automobile (FNG) intervient quand le responsable est non identifié, non assuré ou insolvable. Franchise standard de 1 000 CHF à la charge de la victime pour les dommages matériels.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'non_vie' AND t.key = 'vehicule'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-NV-VH-114', 'non_vie', t.id, 'single',
       NULL, 'Qu''entend-on par ''assurance protection du bonus'' (option marché suisse) ?', '[{"text":"Option permettant de garder son degré de bonus après un premier sinistre responsable dans l''année","correct":true},{"text":"Ristourne prime en cas d''année sans sinistre","correct":false,"why_wrong":"Confusion avec le bonus classique."},{"text":"Option qui bloque le contrat pendant 3 ans","correct":false},{"text":"Option qui supprime la franchise casco","correct":false,"why_wrong":"Ce serait une option ''franchise réduite''."}]'::jsonb, 1,
       'Option ''protection bonus'' : le degré ne recule pas après un premier sinistre (souvent 1 fois par période) malgré la responsabilité. Argument commercial fort pour un client qui vient d''atteindre le plein bonus.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'non_vie' AND t.key = 'vehicule'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-NV-VH-115', 'non_vie', t.id, 'single',
       NULL, 'Un client possède une moto de 125 cm3. Doit-il souscrire la même RC véhicule qu''une voiture ?', '[{"text":"Non, les motos jusqu''à 125 cm3 sont exemptées","correct":false,"why_wrong":"Fausse exemption : dès 50 cm3 ou 45 km/h, RC obligatoire."},{"text":"Oui, toute moto immatriculée doit être couverte en RC selon l''art. 63 LCR","correct":true},{"text":"Non, la RC privée du ménage suffit","correct":false,"why_wrong":"La RC privée exclut les véhicules à moteur soumis à la LCR."},{"text":"Oui, mais seulement en été","correct":false}]'::jsonb, 1,
       'Art. 63 LCR : tout véhicule immatriculé (voitures, motos, scooters, cyclomoteurs, tracteurs) doit être assuré en RC véhicule. Sans attestation : pas de permis de circulation.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'non_vie' AND t.key = 'vehicule'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-NV-VH-116', 'non_vie', t.id, 'single',
       'Un client déclare le vol de sa voiture. Il retrouve son véhicule 4 semaines plus tard, gravement dégradé.', 'Quelle garantie casco intervient ?', '[{"text":"Casco partielle : vol et déprédations consécutives au vol sont couvertes","correct":true},{"text":"Casco complète uniquement","correct":false,"why_wrong":"Piège : le vol relève de la casco PARTIELLE."},{"text":"RC véhicule","correct":false,"why_wrong":"La RC ne couvre jamais les propres dommages du preneur."},{"text":"Aucune, le véhicule ayant été retrouvé","correct":false,"why_wrong":"Non : les dégradations sont indemnisées comme sinistre partiel."}]'::jsonb, 2,
       'Art. 76 al. 2 LCR et CGA casco partielle : le vol et les dégradations consécutives sont couverts. Si le véhicule reste introuvable après 30 jours, indemnisation en valeur totale (valeur vénale majorée en début de contrat).', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'non_vie' AND t.key = 'vehicule'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-NV-VH-117', 'non_vie', t.id, 'single',
       NULL, 'Un client casse son pare-brise sur autoroute. Il peut le faire réparer par un vitrier partenaire de l''assureur. Que se passe-t-il ?', '[{"text":"Franchise standard casco pleine et impact sur le bonus","correct":false,"why_wrong":"Le bris de glace ne recule pas le bonus, et la franchise est souvent réduite en réparation."},{"text":"Franchise réduite (parfois supprimée) si réparation par le partenaire, aucun impact sur le degré de bonus","correct":true},{"text":"Le sinistre est refusé","correct":false,"why_wrong":"Bris de glace = garantie casco partielle."},{"text":"Il faut passer par un expert automobile obligatoirement","correct":false,"why_wrong":"Aucune obligation d''expert pour un simple bris de glace."}]'::jsonb, 1,
       'Pratique du marché : le bris de glace fait partie de la casco partielle, sans influence sur le bonus, et la plupart des assureurs offrent franchise réduite (ou nulle) via un réseau partenaire (Carglass, Belron etc.).', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'non_vie' AND t.key = 'vehicule'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-NV-VH-118', 'non_vie', t.id, 'single',
       'Un conducteur est percuté par un tiers responsable identifié. Les réparations sur son véhicule s''élèvent à 8 500 CHF.', 'Quelle assurance indemnise en priorité ?', '[{"text":"Sa propre casco complète (avec franchise à sa charge)","correct":false,"why_wrong":"Possible en dépannage, mais l''assureur du tiers responsable rembourse en priorité (subrogation)."},{"text":"La RC véhicule du tiers responsable","correct":true},{"text":"Sa protection juridique","correct":false,"why_wrong":"La PJ paye les honoraires d''avocat, pas les réparations."},{"text":"Le Fonds national de garantie","correct":false,"why_wrong":"Le Fonds intervient si le responsable est inconnu, insolvable ou non assuré."}]'::jsonb, 2,
       'Principe : le responsable indemnise via sa RC véhicule (art. 58 LCR). L''assureur casco propre peut avancer via ''casco de complaisance'' puis se subroger contre l''assureur RC adverse (art. 72 LCA).', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'non_vie' AND t.key = 'vehicule'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-NV-VH-119', 'non_vie', t.id, 'single',
       'Un client équipe sa BMW avec des jantes 22'''' à 6 000 CHF, un système audio hifi et un wrap intégral.', 'Ces accessoires ''tuning'' après achat sont-ils assurés par la casco d''origine ?', '[{"text":"Oui, sans limite","correct":false,"why_wrong":"Sous-limite pour les accessoires non déclarés."},{"text":"Uniquement s''ils sont déclarés à l''assureur (extension casco pour accessoires spéciaux)","correct":true},{"text":"Non, jamais","correct":false,"why_wrong":"Cela l''est via extension déclarée."},{"text":"Oui, dans la limite de 500 CHF","correct":false,"why_wrong":"Sous-limite typique existe (souvent 2 à 5 000 CHF), à vérifier CGA au cas par cas."}]'::jsonb, 1,
       'CGA casco : les accessoires spéciaux (jantes, système audio hi-fi, wrap complet) au-delà d''une sous-limite doivent être déclarés et donnent lieu à une prime additionnelle. Sinon, indemnisation limitée en cas de vol/vandalisme.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'non_vie' AND t.key = 'vehicule'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-NV-VG-100', 'non_vie', t.id, 'multiple',
       NULL, 'Que sait-on de la couverture LAMal à l''étranger (art. 36 OAMal) ?', '[{"text":"L''urgence est couverte à hauteur maximale du double du tarif suisse applicable","correct":true},{"text":"Le rapatriement médical n''est jamais couvert par la LAMal","correct":true},{"text":"Les soins programmés à l''étranger sont hors LAMal (sauf autorisation préalable)","correct":true},{"text":"L''urgence est couverte à 100% du tarif étranger","correct":false,"why_wrong":"Piège fréquent : le tarif suisse doublé est la limite."},{"text":"La LAMal ne rembourse jamais rien à l''étranger","correct":false,"why_wrong":"Elle rembourse partiellement en cas d''urgence."}]'::jsonb, 2,
       'Art. 36 OAMal : la LAMal couvre les urgences médicales à l''étranger jusqu''à un maximum du double du tarif applicable en Suisse. Hors urgence : rien. Rapatriement : jamais. Ceci justifie l''assurance voyage LCA.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'non_vie' AND t.key = 'voyages'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-NV-VG-101', 'non_vie', t.id, 'single',
       'Un client demande où appeler s''il tombe malade en voyage à Bali.', 'L''assistance voyage 24h/24h fait-elle partie de la LAMal ?', '[{"text":"Oui, la LAMal offre une hotline 24h/24h internationale","correct":false,"why_wrong":"La LAMal n''offre pas de plateforme d''assistance."},{"text":"Non, l''assistance (téléphone, orientation médicale, avance de frais) est une prestation exclusive des polices voyage LCA privées","correct":true},{"text":"Oui, mais uniquement en Europe","correct":false},{"text":"Non, seule la LAA la propose","correct":false,"why_wrong":"La LAA ne propose pas d''assistance de type voyage."}]'::jsonb, 1,
       'Assistance voyage : plateforme 24h/24h, avance des frais d''hospitalisation, mise en contact avec des médecins référencés, organisation du rapatriement médical. Prestation LCA hors LAMal (art. 36 OAMal ne l''inclut pas).', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'non_vie' AND t.key = 'voyages'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-NV-VG-102', 'non_vie', t.id, 'single',
       'Une cliente réserve un voyage aux Maldives pour 8 500 CHF (2 personnes). Deux semaines avant le départ, son conjoint est hospitalisé pour un infarctus.', 'Comment se calcule l''indemnisation annulation ?', '[{"text":"Remboursement des frais annulation facturés par le tour-opérateur, sous plafond CGA, franchise typique 100 à 300 CHF","correct":true},{"text":"Remboursement à 100% du voyage sans questions","correct":false,"why_wrong":"Le remboursement porte sur les frais RÉELS d''annulation (barème du tour-opérateur), pas sur le prix total systématiquement."},{"text":"Rien, l''annulation n''est jamais couverte moins de 15 jours avant départ","correct":false,"why_wrong":"Faux, aucune telle limite."},{"text":"Uniquement en cas de décès","correct":false,"why_wrong":"Maladie grave d''un proche = motif classique de couverture."}]'::jsonb, 2,
       'Annulation LCA : remboursement des frais annulation contractuels du prestataire (typiquement 100% dès 7 jours du départ selon CGV) sous plafond de la police et déduction d''une franchise. Motif imprévisible et grave = infarctus du conjoint (oui).', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'non_vie' AND t.key = 'voyages'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-NV-VG-103', 'non_vie', t.id, 'single',
       'Un client suisse en séjour à New York fait un AVC. Il doit être rapatrié par vol médicalisé transcontinental, coût 45 000 CHF.', 'Qui prend en charge le rapatriement ?', '[{"text":"La LAMal, comme urgence à l''étranger","correct":false,"why_wrong":"PIÈGE ULTRA-CLASSIQUE : la LAMal ne couvre JAMAIS le rapatriement (art. 36 OAMal)."},{"text":"L''assurance voyage / assistance LCA","correct":true},{"text":"L''ambassade suisse à titre humanitaire","correct":false,"why_wrong":"Elle peut coordonner, jamais financer."},{"text":"L''hôpital de New York en garantie de solvabilité","correct":false}]'::jsonb, 2,
       'Rapatriement médical = jamais LAMal. C''est la première raison de souscrire une assurance voyage / assistance LCA. Coûts typiques : Europe 3 000 à 15 000 CHF, transcontinental médicalisé 30 000 à 100 000 CHF.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'non_vie' AND t.key = 'voyages'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-NV-VG-104', 'non_vie', t.id, 'multiple',
       NULL, 'Quels motifs sont TYPIQUEMENT EXCLUS de l''assurance annulation voyage ?', '[{"text":"Simple changement d''avis du client","correct":true},{"text":"Grève de compagnie aérienne annoncée avant réservation","correct":true},{"text":"Pandémie déclarée avant la souscription","correct":true},{"text":"Guerre ou troubles civils dans la région de destination connus au moment de l''achat","correct":true},{"text":"Maladie soudaine et grave du conjoint diagnostiquée après la réservation","correct":false,"why_wrong":"Cas classique COUVERT."},{"text":"Décès d''un frère ou d''une soeur","correct":false,"why_wrong":"Cas classique COUVERT."}]'::jsonb, 2,
       'Exclusions marché : convenance personnelle, événements connus/prévisibles au moment de la souscription, risques politiques/sanitaires annoncés. Base contractuelle : art. 4 LCA (bonne foi + risques déjà connus).', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'non_vie' AND t.key = 'voyages'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-NV-VG-105', 'non_vie', t.id, 'multiple',
       'Un client prévoit un voyage ''aventure'' en Nouvelle-Zélande : canyoning, saut à l''élastique, plongée à 45 m.', 'Quelles activités sont typiquement EXCLUES d''une police voyage standard (sans option) ?', '[{"text":"Canyoning","correct":true},{"text":"Parachutisme et saut à l''élastique","correct":true},{"text":"Plongée sous-marine au-delà de 40 m","correct":true},{"text":"Alpinisme au-delà de 4 000 m","correct":true},{"text":"Balade en bateau touristique dans une baie fermée","correct":false,"why_wrong":"Activité de tourisme standard, couverte."},{"text":"Randonnée pédestre en sentier balisé","correct":false,"why_wrong":"Activité loisir courante, couverte."}]'::jsonb, 2,
       'CGA marché : les sports considérés à risque (canyoning, parachutisme, kite-surf, plongée > 40m, alpinisme > 4 000m) sont exclus de la base, disponibles en option ''sports aventure''. Toujours vérifier avant de recommander.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'non_vie' AND t.key = 'voyages'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-NV-VG-106', 'non_vie', t.id, 'single',
       NULL, 'Le retard d''un vol de plus de 4 heures est-il indemnisé par l''assurance voyage ?', '[{"text":"Oui, dans les couvertures marché suisse, avec un forfait ou remboursement des frais raisonnables (repas, hôtel)","correct":true},{"text":"Non, jamais","correct":false,"why_wrong":"C''est une prestation d''assistance standard sur les polices voyages haut de gamme."},{"text":"Uniquement à partir de 24 heures","correct":false,"why_wrong":"Seuil habituel 4 à 6 heures selon CGA."},{"text":"Uniquement par la compagnie aérienne","correct":false,"why_wrong":"La compagnie a une obligation (Règlement UE 261/2004) mais l''assureur voyage complète."}]'::jsonb, 1,
       'Prestation ''retard de transport public'' : forfait 50 à 300 CHF ou remboursement des frais engagés (repas, nuit d''hôtel) au-delà d''un seuil de 4 à 6 heures. Cumulable avec les droits UE 261/2004.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'non_vie' AND t.key = 'voyages'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-NV-VG-107', 'non_vie', t.id, 'single',
       NULL, 'La responsabilité de la compagnie aérienne en cas de perte définitive de bagages est plafonnée par quelle convention internationale ?', '[{"text":"Convention de Vienne","correct":false,"why_wrong":"Convention diplomatique, sans lien."},{"text":"Convention de Montréal 1999, ~1 288 DTS (~1 400 CHF)","correct":true},{"text":"Traité de Rome","correct":false},{"text":"Convention de Bâle","correct":false}]'::jsonb, 1,
       'Convention de Montréal 1999 : plafonne la responsabilité de la compagnie aérienne en cas de perte définitive à 1 288 DTS (env. 1 400 CHF). Au-delà, l''assurance bagages LCA complète (souvent jusqu''à 2 000 à 5 000 CHF).', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'non_vie' AND t.key = 'voyages'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-NV-VG-108', 'non_vie', t.id, 'single',
       NULL, 'Un client demande si son assurance voyage annuelle couvre un séjour de 90 jours consécutifs en Australie. Que vérifiez-vous en priorité ?', '[{"text":"La durée maximum d''un voyage individuel prévue par la police (souvent 45 à 90 jours)","correct":true},{"text":"Sa vaccination anti-hépatite","correct":false,"why_wrong":"Question médicale hors assurance."},{"text":"Son degré de bonus casco","correct":false,"why_wrong":"Sans rapport."},{"text":"Sa RC privée","correct":false,"why_wrong":"Sans rapport avec la durée voyage."}]'::jsonb, 1,
       'Assurance voyage annuelle : la couverture s''applique à condition que chaque voyage individuel ne dépasse pas une durée max (souvent 45, 60 ou 90 jours). Au-delà : produit ''long séjour'' spécifique.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'non_vie' AND t.key = 'voyages'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-NV-VG-109', 'non_vie', t.id, 'single',
       NULL, 'Un enfant de 14 ans part en camp linguistique en Angleterre pour 3 semaines. Peut-il être assuré seul ?', '[{"text":"Non, il faut impérativement une assurance des parents","correct":false,"why_wrong":"Une police voyage individuelle est possible dès l''enfance."},{"text":"Oui, une police voyage individuelle ou une extension de la police familiale existante couvre le séjour","correct":true},{"text":"Non, sauf en cas de séjour < 7 jours","correct":false,"why_wrong":"Aucune limite courte de ce type."},{"text":"Oui, mais uniquement pour la RC","correct":false}]'::jsonb, 1,
       'Camp linguistique enfant : couverture typique = assistance médicale, rapatriement, annulation, bagages, RC privée. Extension familiale suffit si l''enfant y est nommé. Vérifier la limite ''séjour scolaire encadré''.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'non_vie' AND t.key = 'voyages'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-NV-VG-110', 'non_vie', t.id, 'single',
       'Un client suisse perd son passeport lors d''un séjour à Bali (à 5 jours de la fin du séjour).', 'L''assurance voyage prend-elle en charge les démarches et frais ?', '[{"text":"Oui, prise en charge des frais de remplacement (émoluments) et assistance juridique/consulaire","correct":true},{"text":"Non, aucune assurance ne couvre ce risque","correct":false,"why_wrong":"C''est un service standard des polices voyage haut de gamme."},{"text":"Uniquement si le passeport est volé, pas perdu","correct":false,"why_wrong":"Certaines CGA distinguent, la plupart couvrent perte et vol."},{"text":"Uniquement dans les pays de l''UE","correct":false}]'::jsonb, 1,
       'Prestation d''assistance ''documents de voyage'' : émoluments consulaires, avance sur billet de retour si nécessaire, mise en relation ambassade. Utile lorsque le client doit prolonger son séjour en attendant un laissez-passer.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'non_vie' AND t.key = 'voyages'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-NV-VG-111', 'non_vie', t.id, 'single',
       'Une cliente déclare le vol de son sac à main à Barcelone (contenu 800 CHF).', 'Quelle est la franchise typique par événement pour un sinistre bagages en assurance voyage LCA ?', '[{"text":"5 000 CHF fixes","correct":false,"why_wrong":"Serait le PLAFOND, pas la franchise."},{"text":"100 à 300 CHF selon police","correct":true},{"text":"10 CHF","correct":false,"why_wrong":"Trop faible."},{"text":"Aucune franchise","correct":false,"why_wrong":"Rare en bagages, sauf produit premium spécifique."}]'::jsonb, 1,
       'Franchise typique bagages voyage : 100 à 300 CHF (Zurich, AXA, Helvetia, Mobilière). Cette franchise vise à éviter la déclaration d''objets mineurs.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'non_vie' AND t.key = 'voyages'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-NV-VG-112', 'non_vie', t.id, 'multiple',
       'Une famille de 4 personnes voyage 2 fois par an à l''étranger et fait 15 sorties ski par saison.', 'Quels arguments justifient une assurance voyage annuelle familiale ?', '[{"text":"Prime globalement inférieure à l''addition de polices ponctuelles","correct":true},{"text":"Aucune démarche à effectuer avant chaque départ","correct":true},{"text":"Couverture continue pendant 12 mois (voyages < 45-60 jours)","correct":true},{"text":"Ajout typique des sports d''hiver dans les options familiales","correct":true},{"text":"La LAMal étranger devient inutile","correct":false,"why_wrong":"La LAMal reste et intervient toujours en base (double tarif suisse en urgence)."},{"text":"La casco du véhicule est comprise en assurance annuelle","correct":false,"why_wrong":"Aucun rapport : casco = police véhicule."}]'::jsonb, 2,
       'Profil idéal annuelle familiale : 250 à 450 CHF/an couvrant les 4 membres pour tous les voyages < 45 à 60 jours + activités sportives. Argument fort : prévoyance sereine (rapatriement compris).', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'non_vie' AND t.key = 'voyages'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-NV-VG-113', 'non_vie', t.id, 'single',
       NULL, 'Un client se voit refuser un visa touristique 3 semaines avant son départ. Ce motif est-il couvert par l''assurance annulation ?', '[{"text":"Toujours","correct":false,"why_wrong":"Non systématique, dépend de la CGA."},{"text":"Uniquement si l''option ''refus de visa non prévisible'' est incluse ou activée","correct":true},{"text":"Non, jamais","correct":false,"why_wrong":"Possible avec option ou couverture spécifique."},{"text":"Uniquement pour les Suisses résidant à l''étranger","correct":false}]'::jsonb, 1,
       'Refus de visa : couverture souvent optionnelle ou conditionnelle (demande faite dans les délais, dossier complet). À valider avec le client au moment de la souscription (art. 3 LCA : information continue).', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'non_vie' AND t.key = 'voyages'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-NV-VG-114', 'non_vie', t.id, 'single',
       'Un cadre suisse doit se rendre à Bagdad pour signer un contrat, zone déconseillée par le DFAE.', 'Comment est traité ce voyage professionnel côté assurance ?', '[{"text":"Aucune assurance voyage LCA ne couvre les zones expressément déconseillées par les autorités","correct":true},{"text":"Sa RC privée le couvre","correct":false,"why_wrong":"La RC privée ne couvre pas les frais médicaux ni les zones à risque."},{"text":"Sa police famille standard suffit","correct":false,"why_wrong":"Zones de guerre / voyage déconseillé DFAE = exclusion CGA."},{"text":"Sa casco s''applique en cas de dommage matériel","correct":false,"why_wrong":"La casco couvre le véhicule, hors sujet."}]'::jsonb, 2,
       'Exclusion CGA classique : zones de guerre, régions désignées comme dangereuses par le DFAE. Solution : produits ''business travel high risk'' spéciaux (Lloyd''s, souscripteurs spécialisés), avec surprime et validation cas par cas.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'non_vie' AND t.key = 'voyages'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-NV-PL-001', 'non_vie', t.id, 'single',
       'Un client déménage de Zurich vers Neuchâtel. Il possède 3 immeubles en Suisse (ZH, NE, GE) et vous demande de faire le point sur l''ECA.', 'Dans quels cantons romands l''assurance ECA (établissement cantonal) est-elle OBLIGATOIRE et monopolistique ?', '[{"text":"GE, TI, VS, ZH","correct":false,"why_wrong":"GE a bien un ECA obligatoire (via ECAB) mais TI, VS et ZH sont cantons GUSTAVO (marché libre)."},{"text":"VD, FR, JU, NE (ainsi que GL, GR, BS...)","correct":true},{"text":"Tous les cantons suisses","correct":false,"why_wrong":"19 cantons sur 26 seulement (les GUSTAVO en sont exclus)."},{"text":"Aucun canton (le marché est totalement libre)","correct":false,"why_wrong":"Faux : 19 cantons ont un ECA obligatoire."}]'::jsonb, 1,
       'Système suisse : 19 cantons à ECA obligatoire (assurance monopolistique) : VD, FR, NE, JU, BE, LU, ZG, SO, BL, BS, SH, AR, AI, SG, GR, GL, TG, NW, OW. 7 cantons GUSTAVO à marché libre : GE (particulier), TI, UR, SZ, VS, AG, ZH.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'non_vie' AND t.key = 'propriete_logement'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-NV-PL-002', 'non_vie', t.id, 'single',
       NULL, 'Comment est calculée la valeur d''assurance d''un bâtiment (contrat marché privé) ?', '[{"text":"Valeur vénale de marché (prix de vente)","correct":false,"why_wrong":"Concept immobilier, pas assurantiel."},{"text":"Valeur à neuf (coût de reconstruction) réactualisée par l''indice ICH (indice des coûts de construction)","correct":true},{"text":"Valeur fiscale communale","correct":false,"why_wrong":"Utile pour l''impôt, pas l''assurance."},{"text":"Prix de vente initial de la construction","correct":false,"why_wrong":"Ignorerait l''inflation du secteur bâti."}]'::jsonb, 1,
       'Assurance bâtiment : valeur à neuf = coût de reconstruction à l''identique. Indexation via ICH (Chambre suisse d''experts en bâtiment) pour éviter la sous-assurance liée à l''inflation. Vérification tous les 5 à 10 ans conseillée.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'non_vie' AND t.key = 'propriete_logement'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-NV-PL-003', 'non_vie', t.id, 'single',
       NULL, 'Un propriétaire fait construire une extension de 40m² sur sa villa (piscine intérieure). Que doit-il faire côté assurance ?', '[{"text":"Rien, la police bâtiment s''adapte automatiquement","correct":false,"why_wrong":"L''adaptation nécessite une déclaration."},{"text":"Déclarer la transformation à l''assureur (obligation d''annonce, art. 28 LCA) et adapter la valeur assurée","correct":true},{"text":"Souscrire une nouvelle police complète","correct":false,"why_wrong":"Un avenant suffit."},{"text":"Attendre la fin des travaux pour aviser","correct":false,"why_wrong":"L''annonce doit être faite dès la modification du risque."}]'::jsonb, 1,
       'Art. 28 LCA : aggravation du risque = obligation d''annonce. Non-annonce = risque de refus de prestation. Pour un chantier, il faut aussi une RC prop. d''ouvrage (art. 58 CO) et une assurance construction (SIA 118).', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'non_vie' AND t.key = 'propriete_logement'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-NV-PL-004', 'non_vie', t.id, 'single',
       'Un particulier construit lui-même une piscine à côté de sa villa (chantier de 3 mois).', 'Quelle assurance spécifique est INDISPENSABLE ?', '[{"text":"RC propriétaire d''ouvrage / RC maître d''ouvrage","correct":true},{"text":"Casco complète véhicule","correct":false,"why_wrong":"Sans lien."},{"text":"Protection juridique circulation","correct":false},{"text":"Assurance ménage inventaire","correct":false,"why_wrong":"Ne couvre pas la responsabilité chantier."}]'::jsonb, 2,
       'Art. 58 CO : le propriétaire d''ouvrage répond des dommages causés par l''ouvrage en construction (chute d''un enfant dans la fouille, effondrement blessant un passant). RC prop. d''ouvrage LCA : couverture spécifique + assurance construction pour l''ouvrage lui-même.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'non_vie' AND t.key = 'propriete_logement'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-NV-PL-005', 'non_vie', t.id, 'multiple',
       'Un locataire glisse dans l''escalier mal éclairé d''un immeuble et se blesse (fracture, 3 mois d''ITT).', 'Quelles affirmations sont VRAIES sur la responsabilité du propriétaire ?', '[{"text":"L''art. 58 CO fonde une responsabilité CAUSALE (objective) du propriétaire d''immeuble","correct":true},{"text":"Le défaut d''éclairage relève d''un défaut d''entretien couvert par l''art. 58 CO","correct":true},{"text":"La RC propriétaire d''immeuble LCA prend en charge le dommage corporel du locataire","correct":true},{"text":"L''art. 65 LCR s''applique","correct":false,"why_wrong":"LCR = véhicules, aucun rapport."},{"text":"Le propriétaire s''exonère facilement en prouvant l''absence de faute","correct":false,"why_wrong":"Responsabilité OBJECTIVE : la faute n''est pas la condition."}]'::jsonb, 2,
       'Art. 58 CO : responsabilité causale du propriétaire d''immeuble pour tout défaut de construction ou d''entretien. C''est une responsabilité OBJECTIVE (sans faute). Couverture : RC prop. d''immeuble LCA (obligatoire dans les cantons ECA).', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'non_vie' AND t.key = 'propriete_logement'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-NV-PL-006', 'non_vie', t.id, 'multiple',
       'Un couple emménage dans sa nouvelle maison à Fribourg et vous demande ce qui va dans la police BÂTIMENT vs CONTENU.', 'Quels éléments font partie du BÂTIMENT et non du contenu (choses ménage) ?', '[{"text":"Chaudière et installations de chauffage fixes","correct":true},{"text":"Cuisine intégrée fixe","correct":true},{"text":"Sanitaires fixes","correct":true},{"text":"Cheminée maçonnée","correct":true},{"text":"Meubles rembourrés du salon","correct":false,"why_wrong":"Contenu : choses ménage."},{"text":"Vêtements du preneur","correct":false,"why_wrong":"Contenu : choses ménage."}]'::jsonb, 2,
       'Ligne de partage : le bâtiment inclut tout ce qui est fixé au bâtiment ou fait partie de sa structure (installations techniques, cuisines intégrées, revêtements). Contenu = mobilier meuble, effets personnels, appareils portables.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'non_vie' AND t.key = 'propriete_logement'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-NV-PL-007', 'non_vie', t.id, 'single',
       'Un propriétaire assure sa villa à 900 000 CHF (bâtiment). Valeur à neuf réelle : 1 200 000 CHF. Un dégât d''eau cause 60 000 CHF.', 'Combien l''assurance verse-t-elle ?', '[{"text":"60 000 CHF","correct":false,"why_wrong":"Ignorerait la sous-assurance."},{"text":"45 000 CHF (60 000 x 900 000 / 1 200 000)","correct":true},{"text":"900 000 CHF (plafond)","correct":false,"why_wrong":"Le plafond ne joue qu''en cas de dommage supérieur à la somme assurée."},{"text":"0 CHF","correct":false}]'::jsonb, 2,
       'Règle proportionnelle art. 69 al. 2 LCA appliquée au bâtiment. Le sous-assuré paie sa ''part''. Argument commercial fort : ajuster la valeur d''assurance à chaque transformation.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'non_vie' AND t.key = 'propriete_logement'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-NV-PL-008', 'non_vie', t.id, 'single',
       NULL, 'Un propriétaire en PPE loue son appartement : qui doit assurer le contenu (mobilier meublé) laissé sur place ?', '[{"text":"Le propriétaire (le mobilier lui appartient)","correct":true},{"text":"Le locataire","correct":false,"why_wrong":"Le locataire assure SON contenu, pas celui appartenant au propriétaire."},{"text":"La régie du bâtiment","correct":false,"why_wrong":"La régie gère l''immeuble, elle n''assure pas."},{"text":"L''ECA cantonale","correct":false,"why_wrong":"L''ECA (là où monopolistique) couvre le bâtiment, pas le mobilier meublé du propriétaire."}]'::jsonb, 1,
       'Assurance choses : chaque partie assure ce qui lui appartient. Location meublée = le propriétaire doit inscrire dans son inventaire ménage le mobilier laissé (au titre ''logement loué'').', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'non_vie' AND t.key = 'propriete_logement'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-NV-PL-009', 'non_vie', t.id, 'single',
       NULL, 'Un dégât d''eau important dû au refoulement des égouts publics touche une villa. Est-ce couvert par la garantie dégâts d''eau bâtiment ?', '[{"text":"Oui, systématiquement en base","correct":false,"why_wrong":"Le refoulement d''égouts est souvent en option ou avec limite."},{"text":"En option ou avec sous-limite (souvent 25 000 à 100 000 CHF), à vérifier CGA","correct":true},{"text":"Non, jamais","correct":false,"why_wrong":"C''est un risque assurable, souvent en option."},{"text":"Uniquement par l''ECA","correct":false}]'::jsonb, 1,
       'CGA marché : le refoulement des égouts est en option ''dégâts d''eau étendus''. Recommandation forte pour les biens en zones basses ou au sous-sol. En cas de sinistre grave, montants vite élevés (contenu + bâtiment).', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'non_vie' AND t.key = 'propriete_logement'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-NV-PL-010', 'non_vie', t.id, 'single',
       'Un propriétaire fait installer 45 m² de panneaux photovoltaïques sur son toit à Sion (18 000 CHF).', 'Comment les faire couvrir en assurance ?', '[{"text":"Aucun besoin, ils sont inclus d''office dans le bâtiment","correct":false,"why_wrong":"Ils doivent être déclarés (aggravation de risque + valeur d''assurance)."},{"text":"Déclarer à l''assureur bâtiment pour extension de la valeur assurée + couverture spécifique ''installations solaires''","correct":true},{"text":"Inscrire dans l''inventaire ménage","correct":false,"why_wrong":"PV = installation fixe = bâtiment, pas contenu."},{"text":"Prendre une casco spéciale","correct":false,"why_wrong":"Casco = véhicules."}]'::jsonb, 2,
       'Art. 28 LCA : aggravation du risque, obligation d''annonce. Panneaux PV = installation fixe du bâtiment. Extension polices : incendie, foudre, grêle, vandalisme + perte de production optionnelle.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'non_vie' AND t.key = 'propriete_logement'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-NV-PL-011', 'non_vie', t.id, 'multiple',
       NULL, 'Quelles affirmations sont VRAIES concernant la garantie ''perte de loyer'' d''un propriétaire bailleur ?', '[{"text":"Elle indemnise le loyer perdu quand le logement est inhabitable suite à sinistre couvert","correct":true},{"text":"Le déclencheur type est un feu, un dégât d''eau ou un événement naturel","correct":true},{"text":"La durée d''indemnisation est plafonnée par CGA (souvent 12 à 24 mois)","correct":true},{"text":"Elle rembourse le loyer si le locataire est insolvable","correct":false,"why_wrong":"Cela relève de la couverture ''garantie de loyer'' (produit différent, rare et restrictif)."},{"text":"Elle protège contre la baisse du marché immobilier","correct":false,"why_wrong":"Aucun rapport, pas un risque assurable."}]'::jsonb, 2,
       'Perte de loyer bâtiment : suite à incendie, dégât d''eau, tempête rendant l''appartement inhabitable, l''assureur indemnise le loyer non encaissé jusqu''à remise en état (souvent 12 à 24 mois plafond).', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'non_vie' AND t.key = 'propriete_logement'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-NV-PL-012', 'non_vie', t.id, 'single',
       NULL, 'Le pool suisse des dommages tremblement de terre couvre-t-il tous les propriétaires automatiquement ?', '[{"text":"Oui, la couverture est automatique pour tout bâtiment assuré","correct":false,"why_wrong":"Le pool suisse verse dans certaines conditions et jusqu''à un plafond global."},{"text":"Non, il s''agit d''une couverture solidaire limitée (~2 milliards CHF au global), ne remplaçant pas une assurance tremblement de terre spécifique","correct":true},{"text":"Oui, mais seulement dans les cantons monopolistiques","correct":false,"why_wrong":"Le pool suisse dépasse le clivage ECA/marché libre."},{"text":"Non, aucune couverture n''existe en Suisse","correct":false,"why_wrong":"Le pool suisse existe."}]'::jsonb, 1,
       'Pool suisse pour la couverture des dommages sismiques : environ 2 milliards CHF au niveau national, franchise cantonale, prestations partielles selon barème. Pour zones à risque (Valais, Bâle) : couverture privée spécifique à conseiller.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'non_vie' AND t.key = 'propriete_logement'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-NV-PL-013', 'non_vie', t.id, 'single',
       'Un jeune locataire installe seul sa machine à laver et néglige le raccord d''évacuation. Un dégât d''eau important abîme le parquet de son appartement et celui du voisin d''en dessous.', 'Sur quelle assurance intervient-il pour couvrir sa responsabilité envers la régie et le voisin ?', '[{"text":"L''assurance bâtiment de la régie","correct":false,"why_wrong":"L''assureur bâtiment paie mais se retourne contre le locataire (subrogation art. 72 LCA)."},{"text":"Sa RC privée avec inclusion ''RC locative'' pour les dommages qu''il cause aux locaux loués","correct":true},{"text":"L''assurance ménage inventaire du propriétaire","correct":false},{"text":"Le Fonds national de garantie","correct":false,"why_wrong":"Le FNG est pour la circulation, sans rapport."}]'::jsonb, 1,
       'RC privée avec ''dommages aux locaux loués'' : indispensable pour tout locataire. Sinon subrogation de l''assureur bâtiment (art. 72 LCA) contre lui + facture régie.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'non_vie' AND t.key = 'propriete_logement'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-NV-PL-014', 'non_vie', t.id, 'single',
       NULL, 'Un chantier de rénovation de 200 000 CHF sur une villa nécessite quelle assurance TECHNIQUE dédiée ?', '[{"text":"L''assurance travaux SIA 118 (assurance construction) et RC constructeur","correct":true},{"text":"La casco complète","correct":false,"why_wrong":"Casco = véhicules."},{"text":"L''assurance annulation voyage","correct":false},{"text":"L''assurance protection juridique circulation","correct":false}]'::jsonb, 1,
       'Chantier de rénovation : assurance construction (SIA 118 norme suisse) pour l''ouvrage lui-même + RC constructeur (dommages tiers). Souvent souscrite par l''entrepreneur mais à vérifier avec le maître d''ouvrage.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'non_vie' AND t.key = 'propriete_logement'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-NV-PL-015', 'non_vie', t.id, 'single',
       'Une famille achète un appartement en PPE de 3,5 pièces à Lausanne (750 000 CHF).', 'Quelles assurances non-vie doit-elle typiquement souscrire ?', '[{"text":"Uniquement l''assurance ménage inventaire","correct":false,"why_wrong":"Incomplet : RC privée + PPE + assurance bâtiment cantonale (VD) sont indispensables."},{"text":"ECA VD (obligatoire pour bâtiment), assurance ménage inventaire, RC privée (souvent avec ''RC prop. immeuble'' PPE si non couverte par la copropriété)","correct":true},{"text":"Casco complète du véhicule et rien d''autre","correct":false},{"text":"Aucune, tout est couvert par le fonds propre PPE","correct":false,"why_wrong":"Le fonds propre finance l''entretien, pas les sinistres."}]'::jsonb, 2,
       'Panier NON-VIE type d''un propriétaire PPE Lausanne : (1) ECA VD (bâtiment monopole, incendie/éléments naturels), (2) Choses ménage inventaire, (3) RC privée avec option ''propriétaire d''immeuble PPE'' si pas déjà couverte par la copropriété. Base : ECA VD 1998 + art. 58 CO.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'non_vie' AND t.key = 'propriete_logement'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-NV-PM-001', 'non_vie', t.id, 'single',
       NULL, 'Quelle est la base légale de la responsabilité civile d''entreprise ?', '[{"text":"Art. 41 CO (acte illicite) et art. 55 CO (chef d''entreprise et famille du chef)","correct":true},{"text":"Art. 63 LCR","correct":false,"why_wrong":"Concerne les véhicules."},{"text":"Art. 36 OAMal","correct":false,"why_wrong":"Couverture LAMal étranger."},{"text":"Art. 45 LSA","correct":false,"why_wrong":"Information client, pas RC."}]'::jsonb, 1,
       'RC entreprise = art. 41 CO (responsabilité pour acte illicite fautif) + art. 55 CO (responsabilité du chef d''entreprise / commettant pour les actes de ses employés dans l''exécution de leur travail). L''entreprise reste responsable si elle prouve n''avoir pas violé son devoir de diligence.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'non_vie' AND t.key = 'pme'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-NV-PM-002', 'non_vie', t.id, 'multiple',
       NULL, 'Que couvre la RC d''EXPLOITATION d''une PME ?', '[{"text":"Les dommages corporels causés à des tiers par l''exploitation","correct":true},{"text":"Les dommages matériels causés à des tiers par l''exploitation","correct":true},{"text":"Les dommages causés par les employés dans l''exécution de leur travail (art. 55 CO)","correct":true},{"text":"Les dommages financiers purs sans support corporel/matériel","correct":false,"why_wrong":"La perte financière pure est EXCLUE de la RC exploitation (RC pro dédiée)."},{"text":"Les propres biens et machines de l''entreprise","correct":false,"why_wrong":"Ce serait choses PME."},{"text":"Les frais d''avocat pour litiges commerciaux","correct":false,"why_wrong":"Ce serait protection juridique entreprise."}]'::jsonb, 2,
       'RC exploitation : dommages corporels et matériels causés à des tiers par l''activité, les locaux, le personnel (art. 41+55 CO). N''inclut pas la RC professionnelle (erreurs de conseil) ni les pertes financières pures (produits séparés).', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'non_vie' AND t.key = 'pme'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-NV-PM-003', 'non_vie', t.id, 'single',
       'Un fiduciaire à Fribourg commet une erreur dans une déclaration fiscale, causant à son client PME une amende AVS de 12 000 CHF plus 3 000 CHF d''intérêts.', 'Quelle couverture d''assurance intervient sur cette perte financière du client ?', '[{"text":"RC exploitation","correct":false,"why_wrong":"Perte financière pure : hors RC exploitation."},{"text":"RC professionnelle (RC erreurs et omissions du fiduciaire)","correct":true},{"text":"Choses PME","correct":false,"why_wrong":"Couvre les biens de l''entreprise."},{"text":"Casco complète","correct":false}]'::jsonb, 2,
       'Perte financière pure (dommage sans support corporel ou matériel) = RC professionnelle spécifique (RC erreurs et omissions). Indispensable pour toutes les professions du conseil : fiduciaires, avocats, courtiers d''assurance, architectes.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'non_vie' AND t.key = 'pme'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-NV-PM-004', 'non_vie', t.id, 'multiple',
       NULL, 'Que couvre une assurance perte d''exploitation d''une PME ?', '[{"text":"Les frais fixes que l''entreprise continue de supporter","correct":true},{"text":"La marge brute que l''entreprise ne peut plus générer","correct":true},{"text":"L''interruption d''activité suite à un sinistre couvert par la police choses PME sous-jacente","correct":true},{"text":"Les vols de marchandises","correct":false,"why_wrong":"Couvert par choses PME."},{"text":"Le salaire du dirigeant en maladie personnelle","correct":false,"why_wrong":"Perte de gain, produit distinct (LCA)."}]'::jsonb, 2,
       'Perte d''exploitation LCA : lorsqu''un sinistre couvert bloque l''activité, l''assureur verse la marge brute que l''entreprise aurait générée + les frais fixes qu''elle continue de supporter. Période d''indemnisation typique : 12 à 24 mois.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'non_vie' AND t.key = 'pme'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-NV-PM-005', 'non_vie', t.id, 'multiple',
       NULL, 'Quels risques sont couverts par l''assurance CHOSES PME de base ?', '[{"text":"Incendie, foudre, explosion","correct":true},{"text":"Dégâts d''eau (rupture conduite, refoulement)","correct":true},{"text":"Vol avec effraction et vandalisme après effraction","correct":true},{"text":"Événements naturels (tempête, grêle, avalanche, glissement de terrain)","correct":true},{"text":"Cyberattaque / rançongiciel","correct":false,"why_wrong":"Risque cyber = police cyber PME dédiée."},{"text":"Perte financière due à un changement de législation","correct":false,"why_wrong":"Risque business non assurable."}]'::jsonb, 2,
       'Choses PME base : feu, dégâts d''eau, événements naturels, vol/vandalisme. Cyber, bris de machine, transport, machines de chantier = extensions spécifiques.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'non_vie' AND t.key = 'pme'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-NV-PM-006', 'non_vie', t.id, 'single',
       'Un fabricant de jouets suisse basé à Aarau exporte 30% de son CA en Allemagne. Un défaut de peinture cause des lésions à un enfant à Munich.', 'Quelle assurance intervient sur la responsabilité du fabricant ?', '[{"text":"RC produits (part de la RC entreprise), avec extension géographique EU/monde selon police","correct":true},{"text":"La casco du véhicule de livraison","correct":false,"why_wrong":"Sans rapport."},{"text":"L''assurance ménage","correct":false},{"text":"Aucune, la responsabilité produits n''existe pas en Suisse","correct":false,"why_wrong":"LRFP (Loi fédérale sur la responsabilité du fait des produits) = responsabilité objective du fabricant."}]'::jsonb, 1,
       'LRFP + art. 41 CO : responsabilité objective du fabricant pour défaut de produit. RC produits = souvent incluse dans la RC entreprise, avec extension géographique déclarée. À vérifier obligatoirement pour les exportateurs.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'non_vie' AND t.key = 'pme'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-NV-PM-007', 'non_vie', t.id, 'multiple',
       'Une PME de 40 salariés est victime d''un rançongiciel (ransomware) qui chiffre tous les serveurs. L''exploitation est bloquée 8 jours.', 'Quelles couvertures active-t-elle typiquement via une assurance cyber PME ?', '[{"text":"Frais d''expertise forensic (analyse technique de l''attaque)","correct":true},{"text":"Perte d''exploitation cyber pendant la période de blocage","correct":true},{"text":"Frais de notification aux personnes concernées (art. 24 nLPD)","correct":true},{"text":"RC cyber envers les tiers (clients, partenaires) dont les données ont fuité","correct":true},{"text":"Rançon versée aux attaquants, selon CGA et sous conditions strictes","correct":true},{"text":"Achat de nouveaux serveurs neufs (renouvellement matériel programmé)","correct":false,"why_wrong":"Renouvellement volontaire = investissement, pas sinistre."},{"text":"Salaire du dirigeant pendant qu''il gère la crise","correct":false,"why_wrong":"Perte de gain personnelle non liée à la police cyber."}]'::jsonb, 3,
       'Cyber PME (marché suisse 2020-2026) : perte d''exploitation cyber, coûts de restauration des données, forensic, notification aux personnes concernées (art. 24 nLPD), RC cyber envers tiers, rançon selon CGA. Nouveauté ancrée dans le VBV depuis la révision programme 2024.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'non_vie' AND t.key = 'pme'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-NV-PM-008', 'non_vie', t.id, 'single',
       NULL, 'Qu''est-ce qu''une couverture ''dommages consécutifs'' en RC entreprise ?', '[{"text":"Les dommages générés en conséquence directe du sinistre initial (ex. perte financière subie par un tiers en aval)","correct":true},{"text":"Les dommages qui surviennent après le contrat","correct":false,"why_wrong":"Confusion avec la ''claims made'' / date d''effet."},{"text":"Les dommages du contrat suivant","correct":false},{"text":"Les dommages moraux uniquement","correct":false,"why_wrong":"Confusion avec le tort moral."}]'::jsonb, 1,
       'Dommages consécutifs : le sinistre initial (défaut de produit, prestation défectueuse) génère des dommages en cascade chez le client (perte de production, retards). Extension importante en RC entreprise B2B.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'non_vie' AND t.key = 'pme'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-NV-PM-009', 'non_vie', t.id, 'single',
       NULL, 'Une PME transporte des marchandises fragiles de Zurich à Milan. Que doit-elle assurer ?', '[{"text":"L''assurance transport (marchandises en cours de route) : couverture ''de dépôt à dépôt''","correct":true},{"text":"La casco complète du chauffeur","correct":false,"why_wrong":"Casco = véhicule, pas marchandises."},{"text":"L''assurance ménage inventaire du destinataire","correct":false},{"text":"La RC véhicule","correct":false,"why_wrong":"Couvre les dommages aux TIERS, pas la propre marchandise transportée."}]'::jsonb, 1,
       'Assurance transport marchandises (assurance-transport LCA) : couvre les marchandises pendant le transport (route, rail, mer, air) sur base d''Incoterms définis. Prime en % de la valeur, faible mais essentielle en export.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'non_vie' AND t.key = 'pme'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-NV-PM-010', 'non_vie', t.id, 'single',
       NULL, 'Une entreprise emploie 25 personnes. Quelle assurance est OBLIGATOIRE dès la 1ère heure de travail d''un salarié ?', '[{"text":"L''assurance-accidents obligatoire (LAA)","correct":true},{"text":"L''assurance perte de gain maladie","correct":false,"why_wrong":"Non obligatoire fédéralement (obligatoire seulement dans certains cantons via CCT)."},{"text":"La cyber-assurance","correct":false},{"text":"La RC produits","correct":false}]'::jsonb, 1,
       'LAA (Loi fédérale sur l''assurance-accidents) : obligation employeur pour tout salarié. Accidents professionnels + non professionnels si > 8h/semaine (art. 7 al. 2 LAA). Cotisations : AP à charge employeur, ANP à charge salarié.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'non_vie' AND t.key = 'pme'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-NV-PM-011', 'non_vie', t.id, 'multiple',
       'Une PME est victime d''un vol par effraction sur son site principal : les serrures ont été forcées, 60 000 CHF de matériel volé.', 'Quelles affirmations sont VRAIES concernant la couverture du sinistre ?', '[{"text":"L''effraction est couverte en base par la choses PME","correct":true},{"text":"Les CGA imposent souvent le respect de mesures de sécurité (alarme raccordée, coffre pour espèces)","correct":true},{"text":"Le non-respect des mesures de sécurité peut entraîner une réduction des prestations","correct":true},{"text":"La perte d''exploitation liée peut être indemnisée si l''option existe","correct":true},{"text":"Le vol n''est jamais couvert en choses PME","correct":false,"why_wrong":"L''effraction est couverte en base."},{"text":"La RC exploitation intervient pour indemniser le matériel volé","correct":false,"why_wrong":"RC exploitation = tiers, pas propres biens."}]'::jsonb, 2,
       'Vol avec effraction PME (art. 139 CP) = couverture de base. Attention aux clauses de sécurité (alarme raccordée, coffre pour espèces au-delà d''un seuil). Non-respect : réduction de prestations.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'non_vie' AND t.key = 'pme'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-NV-PM-012', 'non_vie', t.id, 'multiple',
       NULL, 'Que couvre l''assurance ''bris de machine'' d''une PME industrielle ?', '[{"text":"Une rupture soudaine d''axe ou de composant mécanique","correct":true},{"text":"Un court-circuit ou une défaillance électrique interne","correct":true},{"text":"Une erreur de manipulation par un opérateur","correct":true},{"text":"Le vol de la machine","correct":false,"why_wrong":"Vol = choses PME."},{"text":"La perte de valeur due à l''obsolescence technique","correct":false,"why_wrong":"Usure/obsolescence = jamais assurable."},{"text":"Les dommages incendie sur la machine","correct":false,"why_wrong":"Incendie = choses PME de base."}]'::jsonb, 2,
       'Assurance bris de machine (assurance-technique) : couvre les dommages internes soudains et imprévus qui ne relèvent pas des risques choses classiques. Indispensable pour industrie de production, ateliers, hôpitaux avec équipements médicaux.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'non_vie' AND t.key = 'pme'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-NV-PM-013', 'non_vie', t.id, 'single',
       NULL, 'Un employeur est tenu à quel devoir principal envers ses salariés selon l''art. 328 CO ?', '[{"text":"Devoir de protection de la personnalité et de la santé (obligation de sécurité)","correct":true},{"text":"Devoir de fournir un véhicule d''entreprise","correct":false},{"text":"Devoir de payer une prime annuelle","correct":false},{"text":"Devoir d''assurer la casco de sa voiture privée","correct":false}]'::jsonb, 1,
       'Art. 328 CO : l''employeur protège la personnalité et la santé du travailleur (mesures de sécurité, prévention, aménagements raisonnables). Violation = responsabilité art. 41 CO + LAA (dénonciation à la CNA / SUVA).', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'non_vie' AND t.key = 'pme'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-NV-PM-014', 'non_vie', t.id, 'single',
       NULL, 'Une PME souhaite couvrir la perte de gain de ses salariés en cas de maladie (au-delà des 3 semaines art. 324a CO). Quel produit conseiller ?', '[{"text":"L''assurance-accidents LAA","correct":false,"why_wrong":"LAA couvre l''accident, pas la maladie."},{"text":"Une assurance indemnité journalière maladie collective (LCA)","correct":true},{"text":"L''assurance choses PME","correct":false},{"text":"L''assurance protection juridique circulation","correct":false}]'::jsonb, 1,
       'Indemnité journalière maladie collective LCA (parfois LAMal art. 67) : couvre 720 ou 730 jours d''incapacité maladie à 80% du salaire (délai d''attente 30 à 90 jours). Souvent imposée par une CCT (construction, hôtellerie, nettoyage).', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'non_vie' AND t.key = 'pme'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-NV-PM-015', 'non_vie', t.id, 'single',
       NULL, 'Une PME artisanale ouvre son entrepôt à des visiteurs. Un client trébuche sur un câble et se casse le poignet. Quelle assurance ?', '[{"text":"Choses PME","correct":false,"why_wrong":"Choses PME couvre les biens de l''entreprise."},{"text":"RC exploitation (dommage corporel causé à un tiers dans les locaux de l''entreprise)","correct":true},{"text":"La LAMal du client","correct":false,"why_wrong":"La LAMal soigne, l''entreprise reste civilement responsable envers le client (art. 41 CO)."},{"text":"Aucune","correct":false}]'::jsonb, 1,
       'RC exploitation = dommage corporel/matériel causé aux visiteurs dans les locaux ou en lien avec l''activité (art. 41 + 55 CO). Absolument indispensable pour tout commerce accueillant du public.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'non_vie' AND t.key = 'pme'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-NV-PM-016', 'non_vie', t.id, 'single',
       NULL, 'Un dirigeant PME s''inquiète du risque de fraude interne (détournement par un employé). Que peut-on lui proposer ?', '[{"text":"Une assurance ''abus de confiance'' / ''fidélité'' (dommages financiers causés par les propres employés)","correct":true},{"text":"La RC exploitation","correct":false,"why_wrong":"RC exploitation = tiers, pas propres pertes internes."},{"text":"La casco complète","correct":false},{"text":"La LAMal","correct":false}]'::jsonb, 1,
       'Assurance ''abus de confiance'' (fidélité) : couvre les pertes financières causées par des actes délictueux d''employés (détournement, vol, escroquerie, art. 138 et 146 CP). Souvent proposée comme extension cyber ou en police séparée.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'non_vie' AND t.key = 'pme'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-NV-PM-017', 'non_vie', t.id, 'multiple',
       NULL, 'Quels éléments composent typiquement un ''paquet PME'' proposé par les assureurs suisses ?', '[{"text":"RC entreprise","correct":true},{"text":"Choses PME (feu, dégâts d''eau, vol, événements naturels)","correct":true},{"text":"Perte d''exploitation","correct":true},{"text":"Assurance technique (bris de machine, cyber selon option)","correct":true},{"text":"Casco individuelle du dirigeant (voiture privée)","correct":false,"why_wrong":"Produit personnel du dirigeant, non collectif entreprise."},{"text":"Assurance annulation voyages loisirs","correct":false,"why_wrong":"Produit voyages, hors paquet PME."}]'::jsonb, 2,
       'Paquet PME standard (Zurich, AXA, Vaudoise, Mobilière) : RC + choses PME + perte d''exploitation + technique/cyber. Options : transport, RC pro, LAA complémentaire, IJM collective.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'non_vie' AND t.key = 'pme'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-NV-PM-018', 'non_vie', t.id, 'single',
       'Une boulangerie subit un incendie qui détruit le four principal. Impossible de produire pendant 4 mois. CA perdu : 320 000 CHF, marge brute : 40%, frais fixes maintenus : 45 000 CHF.', 'Combien la perte d''exploitation devrait-elle indemniser (avant franchise) ?', '[{"text":"0 CHF, l''incendie ne déclenche pas la perte d''exploitation","correct":false,"why_wrong":"Faux : la perte d''exploitation se déclenche sur les risques du contrat choses PME sous-jacent."},{"text":"~173 000 CHF (marge brute 128 000 + frais fixes 45 000)","correct":true},{"text":"320 000 CHF (tout le CA)","correct":false,"why_wrong":"L''assureur ne rembourse pas le CA total, seulement la marge et les frais fixes."},{"text":"45 000 CHF (seulement les frais fixes)","correct":false,"why_wrong":"La marge brute est également due."}]'::jsonb, 2,
       'Perte d''exploitation LCA : marge brute perdue (CA x taux de marge) + frais fixes maintenus pendant l''interruption. Ici 320 000 x 40% + 45 000 = 173 000 CHF. Période d''indemnisation limitée au plafond CGA.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'non_vie' AND t.key = 'pme'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-NV-PM-019', 'non_vie', t.id, 'single',
       NULL, 'Une PME possède 5 véhicules d''entreprise. Comment optimiser leur assurance ?', '[{"text":"5 polices individuelles séparées","correct":false,"why_wrong":"Peu efficient administrativement et financièrement."},{"text":"Un contrat flotte (fleet) : gestion centralisée, bonus/malus global, prime négociée sur volume","correct":true},{"text":"Aucune assurance requise, la RC entreprise suffit","correct":false,"why_wrong":"Chaque véhicule immatriculé doit avoir sa RC véhicule (art. 63 LCR)."},{"text":"L''ECA cantonale","correct":false,"why_wrong":"L''ECA concerne les bâtiments, pas les véhicules."}]'::jsonb, 1,
       'Contrat flotte véhicules d''entreprise : gestion simplifiée (un seul contrat), bonus/malus global (moins volatile), prime volumétrique. Seuil d''accès typique : 5 à 10 véhicules selon assureur.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'non_vie' AND t.key = 'pme'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-NV-PM-020', 'non_vie', t.id, 'single',
       'Un restaurant à Genève subit une perte d''exploitation liée à une pandémie déclarée par les autorités qui impose la fermeture 3 mois.', 'L''assurance perte d''exploitation classique intervient-elle ?', '[{"text":"Oui, systématiquement","correct":false,"why_wrong":"Le risque pandémie est presque toujours exclu depuis 2020."},{"text":"Non : les fermetures administratives dues à des pandémies sont typiquement EXCLUES des CGA marché suisse depuis la révision post-Covid","correct":true},{"text":"Oui, si la pandémie est mondiale","correct":false},{"text":"Uniquement pour les entreprises de moins de 10 salariés","correct":false}]'::jsonb, 2,
       'Depuis 2020, la majorité des CGA suisses ont expressément exclu le risque pandémique et les fermetures administratives liées. Solutions dédiées : produits paramétriques ou extensions spécifiques (rares et chères). À expliquer sans ambiguïté au client.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'non_vie' AND t.key = 'pme'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-NV-LJ-001', 'non_vie', t.id, 'single',
       NULL, 'Que couvre la protection juridique circulation ?', '[{"text":"Les frais juridiques (avocat, expert, procès) liés à un litige survenu en tant qu''usager de la route","correct":true},{"text":"Les dommages matériels au véhicule","correct":false,"why_wrong":"Ce sont la casco / la RC adverse."},{"text":"Les amendes de circulation","correct":false,"why_wrong":"Les amendes pénales ne sont JAMAIS assurables."},{"text":"Les frais de dépannage sur autoroute","correct":false,"why_wrong":"Prestation assistance, hors PJ."}]'::jsonb, 1,
       'PJ circulation : couvre les honoraires d''avocat, frais d''expert et de justice pour tout litige lié à l''usage d''un véhicule (accident, contravention à contester, litige garagiste, litige achat/vente véhicule). Pas les amendes pénales (art. 14 al. 1 LCA).', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'non_vie' AND t.key = 'litiges_nv'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-NV-LJ-002', 'non_vie', t.id, 'multiple',
       NULL, 'Quels domaines relèvent typiquement de la protection juridique PRIVÉE (par opposition à la circulation) ?', '[{"text":"Litiges de bail (locataire)","correct":true},{"text":"Litiges de consommation (achat internet, produits défectueux)","correct":true},{"text":"Litiges avec l''employeur (droit du travail)","correct":true},{"text":"Litiges LAMal / assurance maladie","correct":true},{"text":"Litiges de circulation (accident véhicule)","correct":false,"why_wrong":"Cela relève de la PJ CIRCULATION, pas privée."},{"text":"Litiges familiaux (divorce, autorité parentale)","correct":false,"why_wrong":"Exclusion classique de la PJ privée."}]'::jsonb, 2,
       'PJ privée : bail, consommation, droit du travail, assurances sociales, voisinage, propriété. Circulation à part. Exclusions typiques : famille, droit fiscal, pénal grave.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'non_vie' AND t.key = 'litiges_nv'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-NV-LJ-003', 'non_vie', t.id, 'single',
       NULL, 'Une personne assurée en PJ peut-elle choisir librement son avocat ?', '[{"text":"Non, l''assureur impose son avocat interne","correct":false,"why_wrong":"L''art. 32 LSA garantit le libre choix dans certaines conditions."},{"text":"Oui, en cas de conflit d''intérêts ou pour toute procédure judiciaire/administrative (art. 32 LSA)","correct":true},{"text":"Oui, uniquement s''il paie la moitié des honoraires","correct":false,"why_wrong":"Aucune franchise supplémentaire de ce type imposée par la loi."},{"text":"Non, jamais","correct":false}]'::jsonb, 1,
       'Art. 32 LSA (libre choix de l''avocat) : l''assuré peut choisir un avocat pour toute procédure judiciaire, administrative ou en cas de conflit d''intérêts avec l''assureur. Directive européenne équivalente 87/344/CEE (reprise en droit suisse).', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'non_vie' AND t.key = 'litiges_nv'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-NV-LJ-004', 'non_vie', t.id, 'multiple',
       NULL, 'Quelles affirmations sont vraies concernant le délai de carence en PJ privée ?', '[{"text":"Un délai de carence de 1 à 3 mois s''applique typiquement","correct":true},{"text":"Il vise à éviter la souscription juste avant un litige déjà connu","correct":true},{"text":"La PJ circulation est souvent sans carence","correct":true},{"text":"La couverture est toujours immédiate","correct":false,"why_wrong":"Un délai de carence est très fréquent en PJ privée."},{"text":"Le délai standard est de 5 ans","correct":false,"why_wrong":"Trop long, non commercial."}]'::jsonb, 2,
       'Délai de carence CGA (Wartefrist) : période initiale (souvent 1 à 3 mois) pendant laquelle certains litiges ne sont pas couverts. Objectif : éviter la souscription ''juste avant un litige connu''. Circulation : souvent sans carence.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'non_vie' AND t.key = 'litiges_nv'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-NV-LJ-005', 'non_vie', t.id, 'multiple',
       NULL, 'Que rembourse concrètement une protection juridique ?', '[{"text":"Honoraires d''avocat","correct":true},{"text":"Frais de justice et de tribunal","correct":true},{"text":"Frais d''expertises et de traduction","correct":true},{"text":"Dépens alloués à la partie adverse en cas de perte","correct":true},{"text":"Amendes pénales prononcées contre l''assuré","correct":false,"why_wrong":"Les amendes ne sont JAMAIS assurables (art. 14 al. 1 LCA + ordre public)."},{"text":"Dommages-intérêts que l''assuré doit verser à la partie adverse","correct":false,"why_wrong":"Ce serait la RC privée ou entreprise, pas la PJ."}]'::jsonb, 2,
       'PJ = uniquement les FRAIS pour faire valoir un droit ou se défendre. Jamais les amendes, jamais les dommages-intérêts (relèvent des RC). Plafond typique 250 000 à 600 000 CHF/cas.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'non_vie' AND t.key = 'litiges_nv'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-NV-LJ-006', 'non_vie', t.id, 'single',
       'Un client est mis en prévention pour un vol qualifié (crime intentionnel grave).', 'Sa protection juridique privée finance-t-elle son avocat pénaliste ?', '[{"text":"Oui, sans condition","correct":false,"why_wrong":"L''intention exclut la couverture selon CGA marché."},{"text":"Non : les procédures pénales pour crimes/délits intentionnels sont exclues (couverture rétablie uniquement en cas d''acquittement)","correct":true},{"text":"Oui, uniquement pour un vol","correct":false},{"text":"Oui, si le montant en jeu dépasse 100 000 CHF","correct":false,"why_wrong":"Aucun seuil de ce type."}]'::jsonb, 1,
       'CGA PJ : intention = exclusion (base : ordre public + art. 14 al. 1 LCA). Certaines polices rétablissent la couverture rétroactivement en cas d''acquittement ou de classement (avance des frais, remboursement à l''issue).', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'non_vie' AND t.key = 'litiges_nv'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-NV-LJ-007', 'non_vie', t.id, 'single',
       NULL, 'Un locataire à Lausanne veut contester une hausse de loyer devant la commission de conciliation. Sa PJ privée intervient-elle ?', '[{"text":"Non, les litiges de bail sont exclus","correct":false,"why_wrong":"Faux : les litiges de bail sont un CAS COURANT de PJ privée."},{"text":"Oui, à condition que le délai de carence soit expiré et que la valeur litigieuse dépasse le seuil CGA","correct":true},{"text":"Oui, uniquement si la hausse est illicite","correct":false,"why_wrong":"La PJ finance la procédure, l''issue de la contestation est une autre question."},{"text":"Oui, sans aucune condition","correct":false,"why_wrong":"Délai de carence typique 1 à 3 mois."}]'::jsonb, 1,
       'Bail = coeur de métier PJ privée. Prise en charge des honoraires d''avocat, frais commission conciliation, tribunal des baux, sous réserve du délai de carence et de la valeur litigieuse minimale (souvent 200 à 500 CHF).', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'non_vie' AND t.key = 'litiges_nv'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-NV-LJ-008', 'non_vie', t.id, 'single',
       'Un client se retrouve en conflit familial (divorce contesté).', 'Sa PJ privée intervient-elle ?', '[{"text":"Oui, la PJ couvre systématiquement le divorce","correct":false,"why_wrong":"Erreur classique : le droit de la famille est EXCLU."},{"text":"Non : le droit de la famille (divorce, autorité parentale, succession) est typiquement EXCLU des CGA PJ privée","correct":true},{"text":"Oui, si le divorce est prononcé par consentement mutuel","correct":false},{"text":"Oui, uniquement pour les demandes de pension alimentaire","correct":false,"why_wrong":"Aucune telle sous-condition."}]'::jsonb, 2,
       'Exclusion CGA marché : droit de la famille (divorce, succession, autorité parentale) toujours hors couverture. Alternative : conseil juridique via associations, aide juridique cantonale sous conditions de revenu.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'non_vie' AND t.key = 'litiges_nv'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-NV-LJ-009', 'non_vie', t.id, 'single',
       NULL, 'Quel est le plafond typique par cas d''une PJ privée standard sur le marché suisse ?', '[{"text":"5 000 CHF","correct":false,"why_wrong":"Trop faible pour un procès sérieux."},{"text":"250 000 à 600 000 CHF selon assureur, avec sous-limites étranger","correct":true},{"text":"10 millions CHF","correct":false,"why_wrong":"Serait la RC véhicule."},{"text":"Aucun plafond","correct":false,"why_wrong":"Toute PJ a un plafond CGA."}]'::jsonb, 1,
       'Plafond marché suisse : 250 000 à 600 000 CHF par cas (Assista, AXA-ARAG, Coop PJ, Protekta, Orion). Sous-limites en Europe (souvent 50 000) et hors Europe (souvent 25 000).', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'non_vie' AND t.key = 'litiges_nv'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-NV-LJ-010', 'non_vie', t.id, 'multiple',
       NULL, 'Quelles différences distinguent la PJ CIRCULATION de la PJ PRIVÉE ?', '[{"text":"La PJ circulation couvre les litiges d''usage de véhicules (accident, achat, garagiste)","correct":true},{"text":"La PJ privée couvre bail, consommation, travail, LAMal, voisinage","correct":true},{"text":"La PJ circulation est souvent sans carence","correct":true},{"text":"Elles peuvent être souscrites séparément ou en combiné","correct":true},{"text":"La PJ circulation est obligatoire par la loi","correct":false,"why_wrong":"Aucune PJ n''est obligatoire ; c''est la RC véhicule qui l''est (art. 63 LCR)."},{"text":"La PJ privée couvre les amendes routières","correct":false,"why_wrong":"Amendes = jamais assurables."}]'::jsonb, 2,
       'Deux produits distincts, souvent commercialisés ensemble par les assureurs (combi PJ). Circulation = usage véhicule ; Privée = tout le reste de la vie civile. Argument commercial : ~250 CHF/an pour les 2 = investissement raisonnable.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'non_vie' AND t.key = 'litiges_nv'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-NV-CN-100', 'non_vie', t.id, 'multiple',
       NULL, 'Quelles obligations sont à respecter DURANT chaque phase de l''entretien de conseil non-vie ?', '[{"text":"Remettre la fiche d''information art. 45 LSA en prise de contact","correct":true},{"text":"Analyser les besoins (situation, biens, personnes à charge, budget) avant proposition","correct":true},{"text":"Motiver par écrit la recommandation retenue et les alternatives écartées","correct":true},{"text":"Documenter dans un PV de conseil signé du client","correct":true},{"text":"Ne présenter qu''une seule offre pour aller plus vite","correct":false,"why_wrong":"Contraire au devoir de conseil : plusieurs solutions doivent être comparées."},{"text":"Résilier le contrat de l''assureur précédent à la place du client","correct":false,"why_wrong":"Interdit : seul le client peut résilier son contrat."}]'::jsonb, 2,
       'Structure VBV canonique du conseil non-vie : (1) Contact et fiche d''info art. 45 LSA, (2) Analyse des besoins, (3) Proposition motivée, (4) Conclusion + suivi + PV de conseil. Toutes doivent être documentées.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'non_vie' AND t.key = 'conseil_nv'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-NV-CN-101', 'non_vie', t.id, 'single',
       'Un futur conseiller vous demande la différence entre les statuts inscrits sur la fiche d''information art. 45 LSA.', 'Quelle est la différence entre un intermédiaire d''assurance LIÉ et NON LIÉ selon la LSA ?', '[{"text":"Aucune, les termes sont synonymes","correct":false,"why_wrong":"Distinction juridique fondamentale."},{"text":"L''intermédiaire LIÉ agit pour une ou plusieurs entreprises d''assurance ; le NON LIÉ agit dans un rapport de fidélité envers le preneur (courtier indépendant)","correct":true},{"text":"Le lié n''est pas rémunéré, le non lié l''est","correct":false,"why_wrong":"Les deux sont rémunérés (commissions ou honoraires)."},{"text":"Le lié travaille à l''étranger","correct":false}]'::jsonb, 1,
       'Art. 40 al. 1 LSA (révisée) : l''intermédiaire lié agit pour le compte d''un ou plusieurs assureurs. L''intermédiaire NON lié est dans un rapport de fidélité envers le PRENEUR (courtier). Depuis 2024, seuls les non liés doivent s''inscrire au registre FINMA.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'non_vie' AND t.key = 'conseil_nv'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-NV-CN-102', 'non_vie', t.id, 'single',
       'Nouveau régime FINMA depuis le 1er janvier 2024.', 'Qui doit s''inscrire obligatoirement au registre FINMA des intermédiaires depuis 2024 ?', '[{"text":"Tous les intermédiaires, liés et non liés","correct":false,"why_wrong":"Réforme 2024 : seuls les NON LIÉS sont inscrits par la FINMA. Les liés sont inscrits dans un registre interne par leur assureur."},{"text":"Seuls les intermédiaires NON LIÉS (courtiers) sont soumis à l''inscription au registre FINMA","correct":true},{"text":"Uniquement les intermédiaires ayant plus de 10 ans d''expérience","correct":false},{"text":"Uniquement ceux qui traitent de l''assurance-vie","correct":false,"why_wrong":"Toutes les branches sont concernées."}]'::jsonb, 2,
       'LSA révisée (en vigueur depuis 2024) : le registre FINMA public ne concerne que les intermédiaires NON LIÉS. Les intermédiaires liés sont inscrits dans un registre interne géré par leur assureur. Formation continue obligatoire (art. 43 LSA) dans les deux cas.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'non_vie' AND t.key = 'conseil_nv'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-NV-CN-103', 'non_vie', t.id, 'single',
       NULL, 'Quel est le régime de résiliation ordinaire pour un contrat non-vie de longue durée (nouveau droit LCA depuis 2022) ?', '[{"text":"Aucune résiliation avant l''échéance","correct":false,"why_wrong":"Faux depuis la réforme."},{"text":"Droit ordinaire de résiliation annuel après 3 ans (art. 35a LCA), même si le contrat est de plus longue durée","correct":true},{"text":"Résiliation à tout moment sans motif","correct":false,"why_wrong":"Sauf produits spécifiques, ce n''est pas la règle générale non-vie."},{"text":"Résiliation uniquement en cas de sinistre","correct":false}]'::jsonb, 1,
       'Art. 35a LCA (nouveau) : après 3 ans, le preneur peut résilier annuellement, même si le contrat est de 5 ou 10 ans. Argument commercial fort à connaître : fin des contrats longs ''verrouillés'' d''avant 2022.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'non_vie' AND t.key = 'conseil_nv'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-NV-CN-104', 'non_vie', t.id, 'multiple',
       NULL, 'Quelles informations doit contenir la fiche d''information au preneur (art. 45 LSA) ?', '[{"text":"Identité et statut de l''intermédiaire (lié / non lié)","correct":true},{"text":"Partenaires (assureurs représentés)","correct":true},{"text":"Formation continue de l''intermédiaire","correct":true},{"text":"Coordonnées de l''organe de médiation (Ombudsman)","correct":true},{"text":"Mode de rémunération (commissions, honoraires)","correct":true},{"text":"Numéro AVS du preneur","correct":false,"why_wrong":"Absurde, aucune obligation LSA de ce type."},{"text":"Salaire du dirigeant de la compagnie","correct":false,"why_wrong":"Aucun sens et confidentiel."}]'::jsonb, 2,
       'Art. 45 LSA : contenu obligatoire de la fiche d''information à remettre au preneur AVANT toute conclusion. Identité, statut, partenaires, rémunération, organe de médiation, formation, protection des données. Signée et documentée en dossier.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'non_vie' AND t.key = 'conseil_nv'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-NV-CN-105', 'non_vie', t.id, 'single',
       'Un preneur adopte un chien Rottweiler 8 mois après avoir souscrit sa RC privée. Il vous appelle pour savoir quoi faire.', 'Que doit-il faire selon la LCA ?', '[{"text":"Ne rien faire, tant que le contrat est en cours","correct":false,"why_wrong":"Faux, obligation d''annonce."},{"text":"L''annoncer à l''assureur (art. 28 LCA) : l''assureur peut ajuster la prime ou dénoncer le contrat","correct":true},{"text":"Résilier immédiatement","correct":false,"why_wrong":"Pas systématique, à discuter avec l''assureur."},{"text":"Souscrire une police complémentaire","correct":false,"why_wrong":"Pas obligatoire : l''ajustement du contrat existant est la voie normale."}]'::jsonb, 2,
       'Art. 28 LCA : le preneur doit annoncer les modifications importantes qui aggravent le risque. Non-annonce = risque de refus de prestation. L''assureur peut ajuster la prime ou résilier avec préavis 30 jours.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'non_vie' AND t.key = 'conseil_nv'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-NV-CN-106', 'non_vie', t.id, 'single',
       NULL, 'Un preneur a fait de fausses déclarations en souscrivant (art. 6 LCA). Quelle est la conséquence ?', '[{"text":"L''assureur peut résilier le contrat dans les 4 semaines dès connaissance de la réticence","correct":true},{"text":"Le contrat reste valable sans aucune conséquence","correct":false,"why_wrong":"Faux : la LCA prévoit un régime spécifique de la réticence."},{"text":"Le contrat est automatiquement nul rétroactivement","correct":false,"why_wrong":"Piège : le nouveau droit (2022) a atténué les conséquences ; le contrat n''est plus nul de plein droit."},{"text":"Le preneur doit payer une amende à la FINMA","correct":false,"why_wrong":"Aucune sanction administrative directe."}]'::jsonb, 1,
       'Art. 6 LCA (révisé 2022) : en cas de réticence (déclaration inexacte de faits importants), l''assureur peut résilier dans les 4 semaines dès qu''il en a connaissance. Prestations passées peuvent être remises en cause si lien causal avec le fait tu.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'non_vie' AND t.key = 'conseil_nv'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-NV-CN-107', 'non_vie', t.id, 'single',
       'Un client souscrit une nouvelle police RC entreprise. Le conseiller rédige un PV de conseil.', 'Quel élément est INDISPENSABLE pour la valeur probante du PV ?', '[{"text":"Les besoins identifiés, les solutions proposées, les motifs de la recommandation, la date, la signature du client","correct":true},{"text":"La photo d''identité du conseiller","correct":false},{"text":"Le numéro de compte bancaire du client","correct":false,"why_wrong":"Sans lien avec le conseil."},{"text":"Le nom du directeur régional","correct":false}]'::jsonb, 2,
       'Le PV de conseil sert de preuve en cas de litige (LSFin, LSA, jurisprudence Trib. féd.). Contenu obligatoire : besoins, solutions, motifs, alternatives écartées, date, signature. Protection majeure du conseiller.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'non_vie' AND t.key = 'conseil_nv'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-NV-CN-108', 'non_vie', t.id, 'multiple',
       NULL, 'Selon l''art. 3 LCA (information avant la conclusion), quelles informations le preneur doit-il OBLIGATOIREMENT recevoir avant la signature ?', '[{"text":"Identité de l''assureur","correct":true},{"text":"Risques assurés et étendue de la couverture","correct":true},{"text":"Prime et durée du contrat","correct":true},{"text":"Exclusions principales","correct":true},{"text":"Traitement des données personnelles (art. 24 nLPD)","correct":true},{"text":"Salaire annuel du CEO de l''assureur","correct":false,"why_wrong":"Absurde, aucune obligation légale."},{"text":"Adresse privée de l''agent général","correct":false,"why_wrong":"Sans lien avec l''information contractuelle art. 3 LCA."}]'::jsonb, 2,
       'Art. 3 LCA : information avant la conclusion du contrat. Assureur, risques, étendue, exclusions, prime, durée, traitement des données personnelles (art. 24 nLPD). Le preneur bénéficie du droit de révocation art. 2a LCA (14 jours) dès la conclusion.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'non_vie' AND t.key = 'conseil_nv'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-NV-CN-109', 'non_vie', t.id, 'single',
       'Un client résilie sa RC ménage après un sinistre payé 3 500 CHF par l''assureur.', 'Dans quel délai peut-il le faire selon le nouveau droit LCA ?', '[{"text":"30 jours dès sinistre","correct":false,"why_wrong":"Ancien délai avant réforme 2022."},{"text":"14 jours dès versement de l''indemnité (art. 42 LCA nouveau)","correct":true},{"text":"1 mois avant la fin du contrat","correct":false,"why_wrong":"Confusion avec la résiliation ordinaire."},{"text":"Impossible avant 3 ans","correct":false,"why_wrong":"L''art. 42 LCA prévoit un droit spécial après sinistre."}]'::jsonb, 2,
       'Art. 42 LCA (nouveau, 1er janvier 2022) : après le paiement d''une indemnité, chacune des parties peut résilier dans les 14 jours. Réciproque et à annoncer au client dès le conseil (protection du preneur ET de l''assureur).', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'non_vie' AND t.key = 'conseil_nv'
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

-- ───────── vie_klary_bank_v2.json — Banque Klary v2 : extension VIE de 90 questions couvrant les 6 thèmes officiels VBV (garantie des revenus, retraite, épargne, hériter/léguer, activité indépendante, conduite de l'entretien) avec ancrages législatifs suisses et cas pratiques. ─────────
INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-GR-001', 'vie', t.id, 'single',
       NULL, 'Quel est le montant du gain annuel maximum assuré par la LAA en 2026 ?', '[{"text":"88''200 CHF","correct":false,"why_wrong":"C''est le salaire max LPP obligatoire, pas LAA."},{"text":"148''200 CHF","correct":true},{"text":"90''720 CHF","correct":false,"why_wrong":"C''est le salaire max LPP obligatoire 2026, pas LAA."},{"text":"300''000 CHF","correct":false}]'::jsonb, 1,
       'Art. 15 LAA et art. 22 OLAA : gain annuel maximum assuré fixé à 148''200 CHF. Piège classique : ne pas confondre avec le salaire max LPP (90''720 CHF).', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'garantie_revenus'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-GR-002', 'vie', t.id, 'single',
       NULL, 'À quel taux est versée l''indemnité journalière LAA et à partir de quel jour ?', '[{"text":"100 % du gain assuré dès le 1er jour","correct":false,"why_wrong":"Le taux LAA est 80 %, pas 100 %."},{"text":"80 % du gain assuré à partir du 3e jour suivant l''accident","correct":true},{"text":"80 % dès le 1er jour","correct":false,"why_wrong":"Le délai d''attente est de 2 jours."},{"text":"90 % à partir du 8e jour","correct":false}]'::jsonb, 1,
       'Art. 16 al. 2 LAA : indemnité journalière égale à 80 % du gain assuré, versée dès le 3e jour qui suit celui de l''accident. Les 2 premiers jours sont à la charge de l''employeur (obligation CO 324a) ou du prévoyant.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'garantie_revenus'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-GR-003', 'vie', t.id, 'single',
       NULL, 'Quel taux d''invalidité minimum ouvre le droit à une rente AI complète ?', '[{"text":"40 %","correct":false,"why_wrong":"40 % ouvre le droit à un quart de rente."},{"text":"50 %","correct":false,"why_wrong":"50 % correspond à une demi-rente."},{"text":"60 %","correct":false,"why_wrong":"60 % correspond à trois quarts de rente."},{"text":"70 %","correct":true}]'::jsonb, 1,
       'Art. 28 LAI : rente entière dès 70 % d''invalidité. Système de rentes linéaires depuis 2022 pour les taux entre 40 % et 69 % (échelonnement au pourcent).', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'garantie_revenus'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-GR-004', 'vie', t.id, 'single',
       NULL, 'Quel est le taux de conversion minimum LPP applicable à l''avoir de vieillesse obligatoire lors du calcul de la rente d''invalidité (projection à l''âge de référence) ?', '[{"text":"6,8 %","correct":true},{"text":"5,0 %","correct":false,"why_wrong":"5,0 % est un taux souvent utilisé dans le surobligatoire, pas dans l''obligatoire."},{"text":"7,2 %","correct":false,"why_wrong":"7,2 % était l''ancien taux, supprimé depuis longtemps."},{"text":"3,5 %","correct":false}]'::jsonb, 1,
       'Art. 14 al. 2 LPP et art. 24 LPP : le taux de conversion minimum sur l''avoir de vieillesse LPP obligatoire est de 6,8 %. La rente d''invalidité LPP obligatoire = avoir vieillesse projeté sans intérêts x 6,8 %.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'garantie_revenus'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-GR-005', 'vie', t.id, 'single',
       'Michel, salarié, subit un accident non professionnel. Il perçoit déjà une rente AI de 60 % du revenu déterminant. La LAA lui verse aussi une rente complémentaire.', 'Quel est le plafond de surindemnisation applicable au cumul rente AI et rente complémentaire LAA ?', '[{"text":"80 % du gain assuré","correct":false,"why_wrong":"80 % concerne l''indemnité journalière, pas le cumul rentes."},{"text":"90 % du gain assuré","correct":true},{"text":"100 % du gain assuré","correct":false,"why_wrong":"La loi impose une contribution à la charge de l''assuré : la couverture cumulée est plafonnée en dessous de 100 %."},{"text":"70 % du gain assuré","correct":false}]'::jsonb, 2,
       'Art. 20 al. 2 LAA et art. 32 OLAA : la rente LAA complète la rente AI jusqu''à concurrence de 90 % du gain assuré. La rente LAA seule (sans rente AI) est de 80 % du gain assuré pour une invalidité totale.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'garantie_revenus'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-GR-006', 'vie', t.id, 'single',
       NULL, 'En cas de décès d''un salarié LPP, à quelle hauteur est fixée la rente pour le conjoint survivant selon la LPP obligatoire ?', '[{"text":"40 % de la rente d''invalidité projetée","correct":false},{"text":"60 % de la rente d''invalidité projetée","correct":true},{"text":"80 % de la rente d''invalidité projetée","correct":false,"why_wrong":"80 % correspond à une IJ LAA, pas à la rente de conjoint LPP."},{"text":"100 % de la rente d''invalidité projetée","correct":false}]'::jsonb, 1,
       'Art. 21 al. 1 LPP : rente de conjoint survivant = 60 % de la rente d''invalidité entière. Rente d''orphelin = 20 % (art. 21 al. 1 LPP).', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'garantie_revenus'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-GR-007', 'vie', t.id, 'multiple',
       'Jean et Lucie vivent en concubinage depuis 7 ans, sans enfant commun. Jean est salarié affilié à une caisse LPP qui prévoit la rente de conjoint pour les concubins.', 'Quelles conditions cumulatives permettent à Lucie de prétendre à la rente de conjoint LPP au décès de Jean (art. 20a LPP) ?', '[{"text":"Le règlement de la caisse doit expressément prévoir cette possibilité","correct":true},{"text":"Au moins 5 ans de ménage commun ininterrompu jusqu''au décès (ou enfant commun, ou entretien substantiel)","correct":true},{"text":"Le concubin doit avoir été annoncé de son vivant à la caisse","correct":true},{"text":"Aucune condition, la prestation est automatique dès qu''il y a domicile commun","correct":false,"why_wrong":"L''article 20a LPP est facultatif pour la caisse et pose des conditions strictes."},{"text":"Le concubinage doit obligatoirement être enregistré à l''état civil","correct":false,"why_wrong":"L''état civil ne connaît pas d''enregistrement de concubinage en Suisse."}]'::jsonb, 2,
       'Art. 20a LPP : les caisses PEUVENT (option, non obligation) inclure le concubin comme bénéficiaire. Conditions cumulatives : règlement le prévoit + 5 ans ménage commun OU enfant commun OU entretien substantiel + annonce préalable à la caisse. Point crucial du conseil : vérifier au règlement pour chaque client concubin.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'garantie_revenus'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-GR-008', 'vie', t.id, 'multiple',
       NULL, 'Selon le CO 324a (obligation de l''employeur de payer le salaire en cas d''incapacité), quelles affirmations sont exactes ?', '[{"text":"Le salarié a droit au salaire pendant un temps limité selon son ancienneté","correct":true},{"text":"Les échelles bâloise, bernoise et zurichoise chiffrent la durée par années d''ancienneté","correct":true},{"text":"L''employeur est libéré s''il conclut une assurance perte de gain LCA au moins équivalente et paie 50 % de la prime","correct":true},{"text":"Le salarié a droit à 100 % du salaire pendant 2 ans quel que soit son ancienneté","correct":false,"why_wrong":"Cette obligation est bien plus courte : 3 semaines la 1re année (règle minimum)."},{"text":"L''obligation CO 324a s''applique aussi aux indépendants","correct":false,"why_wrong":"Le CO 324a régit le contrat de travail, il ne s''applique qu''aux salariés."}]'::jsonb, 2,
       'Art. 324a CO : durée limitée (3 semaines la 1re année, puis selon échelle cantonale). Une IJM LCA équivalente ou meilleure, avec cofinancement 50/50 minimum, libère l''employeur de l''obligation directe.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'garantie_revenus'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-GR-009', 'vie', t.id, 'single',
       NULL, 'Un chômeur inscrit à l''ORP est-il assuré contre les accidents ?', '[{"text":"Non, il perd toute couverture LAA pendant sa période de chômage","correct":false,"why_wrong":"Piège classique. Le chômeur reste couvert."},{"text":"Oui, il est assuré d''office auprès de la SUVA au titre de l''art. 22a al. 4 LACI","correct":true},{"text":"Oui, mais uniquement pour les accidents professionnels","correct":false,"why_wrong":"Le chômeur est couvert pour les accidents professionnels ET non professionnels."},{"text":"Oui, s''il paie une prime supplémentaire à sa caisse-maladie","correct":false}]'::jsonb, 1,
       'Art. 22a al. 4 LACI et art. 2 OACI : les personnes au chômage bénéficient d''une couverture LAA obligatoire auprès de la SUVA. Prime déduite de l''indemnité de chômage. Question piège très fréquente à l''examen.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'garantie_revenus'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-GR-010', 'vie', t.id, 'single',
       NULL, 'Le rapatriement médical depuis l''étranger est-il couvert par la LAMal ?', '[{"text":"Oui, jusqu''à concurrence de la moitié des frais","correct":true},{"text":"Oui, intégralement et sans plafond","correct":false,"why_wrong":"La LAMal ne couvre pas intégralement les frais à l''étranger."},{"text":"Non, jamais : c''est le rôle exclusif d''une LCA voyage","correct":false,"why_wrong":"Piège classique. La LAMal participe."},{"text":"Uniquement en cas d''accident, pas de maladie","correct":false}]'::jsonb, 1,
       'Art. 36 al. 4 OAMal : en cas de traitement à l''étranger, la LAMal rembourse au maximum le double du montant qui aurait été payé en Suisse. Pour le rapatriement médical, la LAMal participe à hauteur de 50 %. La différence justifie une LCA voyage ou une complémentaire ambulatoire avec option assistance.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'garantie_revenus'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-GR-011', 'vie', t.id, 'multiple',
       NULL, 'Quelles couvertures peuvent combler la lacune de revenu d''un salarié en cas d''invalidité totale ?', '[{"text":"Rente AI (1er pilier)","correct":true},{"text":"Rente d''invalidité LPP (2e pilier)","correct":true},{"text":"Rente d''invalidité LAA si accident","correct":true},{"text":"Assurance-vie risque pur avec libération des primes et rente d''invalidité","correct":true},{"text":"Assurance perte de gain maladie LCA jusqu''à l''ouverture du droit à la rente","correct":true},{"text":"Prestation LACI (assurance-chômage)","correct":false,"why_wrong":"La LACI n''indemnise pas l''incapacité de gain, elle couvre la perte d''emploi."}]'::jsonb, 2,
       'Empilage classique : 1er + 2e piliers publics couvrent environ 60 % du dernier revenu. La lacune (30 à 40 %) doit être comblée par du 3e pilier (assurance-vie risque, 3a avec incapacité de gain, IJM LCA en pont). Un conseiller doit chiffrer la lacune AI/LPP puis proposer la couverture manquante.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'garantie_revenus'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-GR-012', 'vie', t.id, 'single',
       NULL, 'En LAA obligatoire, à partir de combien d''heures de travail hebdomadaire un salarié est-il couvert contre les accidents non professionnels ?', '[{"text":"Dès la 1re heure de travail","correct":false},{"text":"8 heures par semaine chez le même employeur","correct":true},{"text":"20 heures par semaine","correct":false,"why_wrong":"20 heures est parfois cité par erreur, la règle exacte est 8 heures."},{"text":"40 heures par semaine","correct":false}]'::jsonb, 1,
       'Art. 13 OLAA : un salarié est couvert pour les accidents non professionnels (ANP) dès qu''il travaille au moins 8 heures par semaine chez le même employeur. En dessous de 8 heures, seuls les accidents professionnels sont couverts par la LAA.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'garantie_revenus'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-GR-013', 'vie', t.id, 'single',
       'Sarah, 35 ans, mariée, un enfant, gagne 90''000 CHF. Elle demande combien elle toucherait en cas d''invalidité totale à 100 % due à un accident non professionnel.', 'Quelles prestations perçoit-elle grosso modo ?', '[{"text":"Rente AI + rente enfant AI + rente d''invalidité LPP obligatoire","correct":false,"why_wrong":"Il manque la rente LAA, prépondérante en cas d''accident."},{"text":"Rente AI + rente enfant AI + rente complémentaire LAA (le tout plafonné à 90 % du gain assuré)","correct":true},{"text":"Uniquement une IJ LAA à vie","correct":false,"why_wrong":"L''IJ LAA est temporaire, elle est remplacée par la rente LAA une fois la stabilisation médicale atteinte."},{"text":"Uniquement la rente AI, la LAA ne verse pas de rente d''invalidité","correct":false,"why_wrong":"La LAA verse bien des rentes d''invalidité (art. 18 LAA)."}]'::jsonb, 2,
       'Cumul typique après stabilisation médicale : AI (rente principale + rente pour enfant) + LAA rente complémentaire. Plafond de surindemnisation 90 % du gain assuré (art. 20 al. 2 LAA). La LPP verse aussi une rente d''invalidité, mais elle est coordonnée avec la LAA.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'garantie_revenus'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-GR-014', 'vie', t.id, 'multiple',
       'Nadia, mère au foyer, 2 enfants de 4 et 7 ans, son mari travaille à 100 %. Elle veut évaluer la couverture ménage nécessaire en cas de décès.', 'Quels éléments doit-on estimer pour chiffrer la couverture ménage ?', '[{"text":"La valeur économique des tâches domestiques (heures x tarif de remplacement)","correct":true},{"text":"Les frais de garde des enfants jusqu''à leur autonomie","correct":true},{"text":"Le manque à gagner AVS lié à la baisse des cotisations du conjoint survivant","correct":true},{"text":"La valeur du bien immobilier de la famille","correct":false,"why_wrong":"Cela relève de la couverture patrimoniale, pas de la couverture ménage."},{"text":"Uniquement les frais funéraires","correct":false,"why_wrong":"Poste marginal, ne suffit pas à couvrir le besoin réel."}]'::jsonb, 2,
       'La couverture ménage évalue le remplacement des prestations non rémunérées (garde, cuisine, transport, tâches domestiques) sur la période jusqu''à l''autonomie du dernier enfant. Chiffrage réel : heures x tarif horaire employé de maison. Poste souvent sous-évalué au 1er entretien.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'garantie_revenus'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-GR-015', 'vie', t.id, 'single',
       NULL, 'En cas d''incapacité de travail pour maladie, à partir de quand la LPP verse-t-elle en principe une rente d''invalidité ?', '[{"text":"Dès le 1er jour d''incapacité","correct":false,"why_wrong":"La LPP n''intervient qu''après une longue attente."},{"text":"Dès la 4e semaine d''incapacité","correct":false,"why_wrong":"C''est plus proche du délai IJM LCA."},{"text":"En principe à l''ouverture du droit à la rente AI (après 12 mois d''incapacité de travail moyenne de 40 %)","correct":true},{"text":"Après 5 ans d''incapacité de travail","correct":false}]'::jsonb, 1,
       'Art. 26 LPP : le droit aux prestations d''invalidité LPP suit celui de l''AI. Or l''AI ouvre le droit à la rente après 12 mois d''incapacité de travail (art. 28 al. 1 LAI). Pendant ces 12 mois, c''est l''IJM LCA (ou l''obligation CO 324a) qui prend le relais.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'garantie_revenus'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-RT-001', 'vie', t.id, 'single',
       NULL, 'Quel est l''âge de référence AVS pour les hommes et les femmes après la mise en oeuvre complète de la réforme AVS 21 ?', '[{"text":"64 ans pour les femmes, 65 ans pour les hommes","correct":false,"why_wrong":"C''était le régime avant la réforme AVS 21."},{"text":"65 ans pour les hommes et les femmes","correct":true},{"text":"66 ans pour les deux sexes","correct":false,"why_wrong":"La réforme n''a pas relevé l''âge à 66 ans."},{"text":"64 ans pour les deux sexes","correct":false}]'::jsonb, 1,
       'Art. 21 LAVS (réforme AVS 21, votée le 25.09.2022, entrée en vigueur 01.01.2024 avec relèvement progressif de l''âge des femmes) : âge de référence commun 65 ans. Anciennes cohortes féminines : montée progressive par tranches de 3 mois.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'retraite'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-RT-002', 'vie', t.id, 'multiple',
       'Bertrand, 62 ans, veut anticiper sa rente AVS avant l''âge de référence 65 ans.', 'Quelles règles s''appliquent à l''anticipation de la rente AVS (art. 40 LAVS) ?', '[{"text":"L''anticipation peut aller jusqu''à 2 ans avant l''âge de référence","correct":true},{"text":"La rente est réduite actuariellement en fonction du nombre de mois anticipés","correct":true},{"text":"L''anticipation peut se faire mois par mois (pas seulement en années pleines)","correct":true},{"text":"L''anticipation peut aller jusqu''à 5 ans avant l''âge de référence","correct":false,"why_wrong":"5 ans est le maximum d''AJOURNEMENT, pas d''anticipation."},{"text":"L''anticipation n''a aucun impact sur le montant final de la rente","correct":false,"why_wrong":"Réduction actuarielle systématique, environ 6,8 % par année anticipée."}]'::jsonb, 2,
       'Art. 40 LAVS : anticipation d''un mois à 2 ans avec réduction actuarielle (environ 6,8 % par année anticipée). Ajournement art. 39 LAVS : jusqu''à 5 ans avec supplément croissant.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'retraite'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-RT-003', 'vie', t.id, 'single',
       NULL, 'Quel est le montant de la rente AVS simple maximale versée à une personne seule ?', '[{"text":"1''260 CHF par mois","correct":false,"why_wrong":"C''est la rente AVS simple MINIMALE."},{"text":"2''520 CHF par mois","correct":true},{"text":"3''780 CHF par mois","correct":false,"why_wrong":"Aucun palier officiel de rente AVS à ce niveau."},{"text":"5''040 CHF par mois","correct":false}]'::jsonb, 1,
       'Art. 34 LAVS : le rapport rente minimale / rente maximale est de 1 à 2. En 2024, valeurs de référence : minimale 1''260 CHF, maximale 2''520 CHF. Rente d''un couple marié plafonnée à 150 % de la rente max simple = 3''780 CHF (art. 35 LAVS).', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'retraite'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-RT-004', 'vie', t.id, 'single',
       NULL, 'Quel est le plafond commun de la somme des rentes AVS d''un couple marié ?', '[{"text":"100 % de la rente max simple","correct":false},{"text":"150 % de la rente max simple","correct":true},{"text":"200 % de la rente max simple","correct":false,"why_wrong":"Le splitting n''aboutit pas à 200 %, il y a bien un plafonnement à 150 %."},{"text":"175 % de la rente max simple","correct":false}]'::jsonb, 1,
       'Art. 35 LAVS : la somme des rentes du couple marié est plafonnée à 150 % de la rente maximale d''une personne seule. Argument commercial : pousse à sécuriser le niveau de vie par le 2e et le 3e piliers, surtout en début de retraite.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'retraite'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-RT-005', 'vie', t.id, 'single',
       NULL, 'Quelle bonification de vieillesse LPP obligatoire s''applique à un salarié de 32 ans ?', '[{"text":"7 %","correct":true},{"text":"10 %","correct":false,"why_wrong":"10 % s''applique dès 35 ans."},{"text":"15 %","correct":false,"why_wrong":"15 % s''applique dès 45 ans."},{"text":"18 %","correct":false}]'::jsonb, 1,
       'Art. 16 LPP : bonifications de vieillesse par tranches d''âge : 25 à 34 ans = 7 %, 35 à 44 ans = 10 %, 45 à 54 ans = 15 %, 55 ans à l''âge de référence = 18 %. Taux appliqués au salaire coordonné.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'retraite'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-RT-006', 'vie', t.id, 'single',
       NULL, 'Quel est le taux de conversion LPP minimal légal appliqué à l''avoir de vieillesse obligatoire à l''âge de référence ?', '[{"text":"5,0 %","correct":false,"why_wrong":"5,0 % est courant en surobligatoire, mais pas le minimum légal."},{"text":"6,0 %","correct":false,"why_wrong":"6,0 % était un compromis discuté lors de la réforme LPP 21, refusée en votation."},{"text":"6,8 %","correct":true},{"text":"7,2 %","correct":false}]'::jsonb, 1,
       'Art. 14 al. 2 LPP : taux de conversion minimum obligatoire = 6,8 %. Une rente LPP obligatoire = avoir vieillesse LPP x 6,8 %. Point sensible : la réforme LPP 21 qui prévoyait 6,0 % a été refusée en votation populaire en septembre 2024.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'retraite'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-RT-007', 'vie', t.id, 'single',
       NULL, 'Quel est le seuil d''entrée LPP obligatoire (salaire annuel minimum) en 2026 ?', '[{"text":"21''510 CHF","correct":false,"why_wrong":"Valeur antérieure."},{"text":"22''050 CHF","correct":false,"why_wrong":"Valeur intermédiaire, dépassée depuis 2025."},{"text":"22''680 CHF","correct":true},{"text":"25''725 CHF","correct":false,"why_wrong":"C''est la déduction de coordination, pas le seuil d''entrée."}]'::jsonb, 1,
       'Art. 2 al. 1 et art. 7 LPP : seuil d''entrée = 3/4 de la rente AVS maximale, soit 22''680 CHF pour 2025-2026. En dessous, pas d''affiliation LPP obligatoire (mais 2e pilier facultatif via institution supplétive).', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'retraite'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-RT-008', 'vie', t.id, 'single',
       NULL, 'Quel est le montant de la déduction de coordination LPP en 2026 ?', '[{"text":"22''680 CHF","correct":false,"why_wrong":"C''est le seuil d''entrée LPP."},{"text":"25''725 CHF","correct":true},{"text":"29''400 CHF","correct":false,"why_wrong":"Valeur ancienne."},{"text":"88''200 CHF","correct":false}]'::jsonb, 1,
       'Art. 8 al. 1 LPP : déduction de coordination = 7/8 de la rente AVS max = 25''725 CHF. Elle sert à calculer le salaire coordonné (salaire déterminant AVS moins déduction), plafonné à 65''000 CHF environ.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'retraite'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-RT-009', 'vie', t.id, 'single',
       'Anna, salariée, gagne 90''720 CHF (plafond LPP obligatoire).', 'Quel est son salaire coordonné en 2026 ?', '[{"text":"90''720 CHF","correct":false,"why_wrong":"Il faut déduire la déduction de coordination."},{"text":"64''995 CHF","correct":true},{"text":"88''200 CHF","correct":false,"why_wrong":"Confusion avec l''ancien plafond."},{"text":"68''040 CHF","correct":false}]'::jsonb, 2,
       'Salaire coordonné 2026 = 90''720 (plafond) moins 25''725 (déduction) = 64''995 CHF. Sur ce salaire s''appliquent les bonifications de vieillesse (7/10/15/18 %) et le taux de conversion 6,8 % à l''âge de référence.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'retraite'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-RT-010', 'vie', t.id, 'single',
       NULL, 'Un assuré souhaite retirer son avoir LPP sous forme de capital plutôt qu''en rente. Quelle est la principale exigence formelle imposée par la loi ?', '[{"text":"Décision orale devant témoin","correct":false},{"text":"Déclaration écrite déposée au moins 3 mois avant la retraite (délai réglementaire minimum)","correct":true},{"text":"Aucune exigence formelle","correct":false,"why_wrong":"La loi ET les règlements exigent un formalisme strict."},{"text":"Décision annuelle renouvelée depuis l''âge de 50 ans","correct":false}]'::jsonb, 1,
       'Art. 37 al. 4 LPP : l''assuré peut demander le versement en capital pour au moins 1/4 de son avoir vieillesse LPP obligatoire. Les caisses fixent un délai (souvent 3 ans à l''avance en pratique), légalement 3 mois minimum. Si l''assuré est marié, consentement écrit du conjoint requis (signature certifiée).', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'retraite'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-RT-011', 'vie', t.id, 'single',
       'Marc, marié, 63 ans, veut retirer sa prestation de vieillesse LPP en capital.', 'Quel accord doit-il produire ?', '[{"text":"Aucun, la décision est individuelle","correct":false,"why_wrong":"Piège fréquent : le mariage impose le consentement du conjoint."},{"text":"Consentement écrit de son épouse, signature certifiée conforme","correct":true},{"text":"Autorisation de la caisse de compensation AVS","correct":false},{"text":"Accord préalable de l''administration fiscale","correct":false}]'::jsonb, 2,
       'Art. 37 al. 5 LPP : versement en capital d''une personne mariée soumis au consentement écrit du conjoint. La signature doit être authentifiée (notaire ou autorité). Ratio legis : protéger le conjoint face à un choix irréversible qui prive potentiellement de la rente de conjoint.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'retraite'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-RT-012', 'vie', t.id, 'multiple',
       NULL, 'Quels arguments plaident pour un versement en RENTE plutôt qu''en CAPITAL LPP ?', '[{"text":"Sécurité de revenu à vie, indépendante des marchés","correct":true},{"text":"Rente conjoint automatique en cas de décès (60 %)","correct":true},{"text":"Pas de risque de longévité pour l''assuré","correct":true},{"text":"Fiscalité plus favorable au moment de la sortie","correct":false,"why_wrong":"C''est plutôt le CAPITAL qui bénéficie d''un taux d''imposition privilégié (art. 38 LIFD)."},{"text":"Flexibilité totale pour un projet immobilier","correct":false,"why_wrong":"C''est un argument pour le capital, pas pour la rente."}]'::jsonb, 2,
       'Rente = sécurité (à vie, indexée partiellement, rente conjoint). Capital = liberté (immo, transmission), imposition privilégiée à la sortie mais rendement à porter par l''assuré. Décision structurante à documenter dans le PV de conseil.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'retraite'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-RT-013', 'vie', t.id, 'multiple',
       'Julien quitte son emploi en juin pour reprendre un poste chez un nouvel employeur en septembre.', 'Quelles affirmations décrivent correctement la prestation de libre passage entre les deux emplois ?', '[{"text":"L''avoir LPP doit être transféré à la nouvelle caisse dès la reprise","correct":true},{"text":"En cas d''inactivité prolongée, l''avoir doit être parqué sur un compte ou une police de libre passage","correct":true},{"text":"L''avoir reste bloqué jusqu''à un cas de prévoyance (retraite, invalidité, décès) sauf motif légal de retrait","correct":true},{"text":"L''assuré peut retirer l''avoir en espèces librement pour financer un projet personnel","correct":false,"why_wrong":"Retrait en espèces uniquement sur motif LFLP (départ Suisse, indépendance, montant modique)."},{"text":"L''avoir peut être versé au concubin de l''assuré à sa demande","correct":false,"why_wrong":"Aucun retrait au bénéfice d''un tiers n''est prévu par la LFLP."}]'::jsonb, 2,
       'Art. 3-5 LFLP : lorsque le rapport de travail prend fin sans cas de prévoyance, l''avoir LPP est transféré à la nouvelle caisse (ou compte/police de libre passage). Blocage jusqu''au cas de prévoyance, sauf motifs légaux (art. 5 LFLP).', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'retraite'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-RT-014', 'vie', t.id, 'multiple',
       NULL, 'Quels sont les motifs de retrait anticipé de la prestation de libre passage prévus par la LFLP ?', '[{"text":"Départ définitif de la Suisse","correct":true},{"text":"Passage à une activité indépendante","correct":true},{"text":"Achat de résidence principale (encouragement propriété du logement)","correct":true},{"text":"Achat d''une résidence secondaire","correct":false,"why_wrong":"Seule la résidence principale (à usage propre) est éligible."},{"text":"Financement d''un voyage autour du monde","correct":false,"why_wrong":"Aucun motif de ce type ne figure dans la LFLP."},{"text":"Rente d''invalidité entière AI","correct":true}]'::jsonb, 2,
       'Art. 5 LFLP : motifs de retrait en espèces = départ définitif Suisse, indépendance, montant modique (moins d''une année de cotisations). Art. 30c LPP : retrait EPL pour résidence principale. Cas de prévoyance = invalidité, décès, retraite.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'retraite'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-RT-015', 'vie', t.id, 'single',
       NULL, 'Un rachat volontaire dans la LPP est-il déductible du revenu imposable ?', '[{"text":"Non, seuls les rachats du pilier 3a sont déductibles","correct":false,"why_wrong":"Piège : les rachats LPP sont bien déductibles, souvent plus que le plafond 3a."},{"text":"Oui, entièrement","correct":true},{"text":"Uniquement à hauteur de 50 %","correct":false},{"text":"Uniquement si l''assuré a plus de 55 ans","correct":false,"why_wrong":"Aucun seuil d''âge, mais interdiction de retirer le capital dans les 3 ans qui suivent le rachat (art. 79b al. 3 LPP)."}]'::jsonb, 1,
       'Art. 33 al. 1 lit. d LIFD : les rachats LPP sont intégralement déductibles du revenu imposable. Blocage art. 79b al. 3 LPP : pas de retrait en capital dans les 3 ans qui suivent le rachat (sinon reprise fiscale).', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'retraite'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-RT-016', 'vie', t.id, 'single',
       NULL, 'Quel est le taux global des cotisations AVS/AI/APG à la charge du salarié en 2026 ?', '[{"text":"5,3 %","correct":true},{"text":"6,4 %","correct":false,"why_wrong":"C''est le taux INDEPENDANT sans employeur."},{"text":"10,6 %","correct":false,"why_wrong":"C''est le taux global (salarié + employeur cumulés)."},{"text":"8,7 %","correct":false}]'::jsonb, 1,
       'Cotisations 2026 sur salaire déterminant : AVS 8,7 % + AI 1,4 % + APG 0,5 % = 10,6 %, partagées 50/50 entre salarié et employeur. Part salariée = 5,3 %. Prélevé sur salaire brut, sans plafond.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'retraite'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-RT-017', 'vie', t.id, 'single',
       'Un couple marié divorce après 20 ans de mariage.', 'Comment sont partagés les revenus AVS pour le calcul futur des rentes ?', '[{"text":"Aucune division : chaque conjoint garde ses propres revenus","correct":false,"why_wrong":"La règle est le splitting, principe central du 1er pilier."},{"text":"Les revenus réalisés pendant les années de mariage communes sont partagés par moitié entre les deux ex-conjoints (splitting)","correct":true},{"text":"Le conjoint qui a le plus gagné cède 30 % au moins gagnant","correct":false},{"text":"Le partage se fait uniquement à la retraite, pas au divorce","correct":false,"why_wrong":"Le splitting est calculé au moment du divorce."}]'::jsonb, 2,
       'Art. 29quinquies LAVS : splitting AVS. Les revenus des années de mariage communes sont additionnés et partagés en deux. Chaque ex-conjoint reçoit sa moitié qui s''ajoute à ses propres revenus. Vise l''égalité de traitement, notamment pour le conjoint moins actif professionnellement.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'retraite'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-RT-018', 'vie', t.id, 'multiple',
       'Une cliente, mère de 2 enfants, prend soin également de sa mère invalide.', 'Quelles bonifications AVS peut-elle cumuler pour améliorer sa future rente ?', '[{"text":"Bonification pour tâches éducatives tant qu''un enfant a moins de 16 ans","correct":true},{"text":"Bonification pour tâches d''assistance à un proche impotent nécessitant des soins","correct":true},{"text":"Les deux bonifications peuvent être cumulées pour une même année si les conditions sont remplies","correct":false,"why_wrong":"Piège fréquent : elles ne sont PAS cumulables pour une même année, la LAVS accorde une seule bonification à la fois."},{"text":"Bonification pour bons employeurs","correct":false,"why_wrong":"Aucune bonification de ce type n''existe."},{"text":"Aucune bonification, seule la cotisation compte","correct":false,"why_wrong":"La LAVS reconnaît le travail non rémunéré via les bonifications."}]'::jsonb, 2,
       'Art. 29sexies LAVS (tâches éducatives) et art. 29septies LAVS (tâches d''assistance) : les deux bonifications existent mais NE se cumulent PAS pour une même année. Montant = 3 fois la rente AVS annuelle minimale. À parts égales entre les 2 parents mariés.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'retraite'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-RT-019', 'vie', t.id, 'single',
       NULL, 'Une personne à revenus modestes qui n''atteint pas le minimum vital malgré l''AVS peut demander :', '[{"text":"Une allocation pour impotent uniquement","correct":false,"why_wrong":"L''API répond à un besoin d''aide, pas à la précarité financière."},{"text":"Les prestations complémentaires (PC) à l''AVS/AI","correct":true},{"text":"Une rente extraordinaire remboursable","correct":false},{"text":"Un supplément de rente automatique","correct":false}]'::jsonb, 1,
       'LPC : les prestations complémentaires couvrent la différence entre le revenu et les dépenses reconnues (loyer, prime LAMal, alimentation) pour les rentiers AVS/AI dont les moyens sont insuffisants. Prestation non remboursable. Point clé du conseil : à mentionner en cas de retraite modeste.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'retraite'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-RT-020', 'vie', t.id, 'single',
       'Sonia, 60 ans, veuve, veut ajourner sa rente AVS pour cotiser encore.', 'Quel est le supplément maximum en cas d''ajournement AVS de 5 ans ?', '[{"text":"Environ 10 %","correct":false},{"text":"Environ 20 %","correct":false,"why_wrong":"Le supplément à 5 ans dépasse largement 20 %."},{"text":"Environ 31,5 %","correct":true},{"text":"50 %","correct":false}]'::jsonb, 2,
       'Art. 39 LAVS : ajournement d''un an à 5 ans. Supplément mensuel qui monte progressivement jusqu''à environ 31,5 % pour un ajournement de 5 ans (barème actuariel). Argument à pondérer : moins pertinent en cas de faible espérance de vie.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'retraite'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-EP-001', 'vie', t.id, 'single',
       NULL, 'Quel est le plafond de versement 3a pour un salarié affilié à une caisse LPP en 2026 ?', '[{"text":"6''883 CHF","correct":false,"why_wrong":"Valeur ancienne."},{"text":"7''056 CHF","correct":false,"why_wrong":"Valeur ancienne."},{"text":"7''258 CHF","correct":true},{"text":"36''288 CHF","correct":false,"why_wrong":"C''est le grand plafond réservé aux indépendants sans LPP."}]'::jsonb, 1,
       'Art. 7 al. 1 lit. a OPP 3 : plafond petit pilier 3a 2026 = 7''258 CHF. Ce plafond s''applique aux salariés affiliés à une LPP. Déductible du revenu imposable, imposé à un taux réduit au retrait (art. 38 LIFD).', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'epargne'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-EP-002', 'vie', t.id, 'single',
       NULL, 'Quel est le plafond de versement 3a pour un indépendant sans LPP en 2026 ?', '[{"text":"7''258 CHF","correct":false,"why_wrong":"C''est le petit plafond salarié."},{"text":"20 % du revenu net, maximum 36''288 CHF","correct":true},{"text":"50 % du revenu, sans plafond","correct":false},{"text":"100 % du revenu net","correct":false}]'::jsonb, 1,
       'Art. 7 al. 1 lit. b OPP 3 : grand plafond 3a pour l''indépendant sans LPP = 20 % du revenu net d''activité, plafonné à 5 fois le petit plafond, soit 36''288 CHF pour 2026. Levier fiscal massif pour les indépendants à revenus élevés.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'epargne'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-EP-003', 'vie', t.id, 'single',
       NULL, 'Un titulaire d''un 3a exerçant une activité lucrative jusqu''à quand peut-il alimenter son 3a ?', '[{"text":"Uniquement jusqu''à l''âge de référence AVS","correct":false,"why_wrong":"La loi permet la prolongation si activité maintenue."},{"text":"Jusqu''à 5 ans après l''âge de référence AVS, à condition d''exercer encore une activité lucrative","correct":true},{"text":"Toute sa vie, sans limite d''âge","correct":false},{"text":"Uniquement jusqu''à 60 ans","correct":false}]'::jsonb, 1,
       'Art. 3 al. 1 OPP 3 : versement possible jusqu''à 5 ans après l''âge de référence AVS si activité lucrative maintenue. Sans activité, le versement doit cesser à l''âge de référence.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'epargne'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-EP-004', 'vie', t.id, 'multiple',
       NULL, 'Quels sont les motifs légaux de retrait anticipé d''un pilier 3a ?', '[{"text":"Achat de résidence principale (EPL)","correct":true},{"text":"Amortissement d''une hypothèque de résidence principale","correct":true},{"text":"Passage à une activité indépendante ou changement d''indépendance","correct":true},{"text":"Départ définitif de la Suisse","correct":true},{"text":"Rachat dans le 2e pilier LPP","correct":true},{"text":"Financement d''une voiture neuve","correct":false,"why_wrong":"Aucun motif de ce type dans la loi."}]'::jsonb, 2,
       'Art. 3 OPP 3 : motifs de retrait anticipé = EPL résidence principale, indépendance, départ définitif Suisse, rachat LPP, invalidité entière AI, décès. Retrait ordinaire = 5 ans avant l''âge de référence AVS jusqu''à l''âge de référence (ou +5 ans si activité).', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'epargne'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-EP-005', 'vie', t.id, 'single',
       NULL, 'Quel est le montant minimum d''un retrait EPL LPP (encouragement propriété du logement) ?', '[{"text":"5''000 CHF","correct":false},{"text":"10''000 CHF","correct":false},{"text":"20''000 CHF","correct":true},{"text":"50''000 CHF","correct":false,"why_wrong":"Confusion possible avec des plafonds hypothécaires, mais la loi fixe 20''000 CHF."}]'::jsonb, 1,
       'Art. 5 al. 1 OEPL : montant minimum du retrait ou de la mise en gage EPL = 20''000 CHF. Exception : rachat de parts sociales de coopératives d''habitation, pas de minimum.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'epargne'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-EP-006', 'vie', t.id, 'multiple',
       'Un couple envisage un retrait EPL LPP pour financer sa résidence principale.', 'Quelles règles régissent ce retrait EPL LPP ?', '[{"text":"Montant minimum du retrait : 20''000 CHF (sauf coopérative d''habitation)","correct":true},{"text":"Fréquence maximale : un retrait tous les 5 ans","correct":true},{"text":"Le retrait doit intervenir au moins 3 ans avant l''âge de référence AVS","correct":true},{"text":"Le conjoint doit donner son consentement écrit avec signature certifiée","correct":true},{"text":"Le retrait est possible chaque année sans plafond","correct":false,"why_wrong":"Fréquence limitée à un retrait tous les 5 ans (art. 5 al. 3 OEPL)."},{"text":"Le retrait est utilisable pour une résidence secondaire","correct":false,"why_wrong":"Seule la résidence principale à usage propre est éligible."}]'::jsonb, 2,
       'Art. 30c LPP + art. 5 OEPL : retrait EPL pour résidence principale, minimum 20''000 CHF, tous les 5 ans, au moins 3 ans avant la retraite, consentement conjoint certifié. Réduit les prestations d''invalidité/décès à due concurrence.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'epargne'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-EP-007', 'vie', t.id, 'single',
       NULL, 'À partir de quel âge le retrait EPL LPP n''est-il plus possible ?', '[{"text":"50 ans","correct":false},{"text":"3 ans avant l''âge de référence AVS","correct":true},{"text":"65 ans","correct":false,"why_wrong":"La limite est fixée avant l''âge de référence."},{"text":"60 ans","correct":false}]'::jsonb, 1,
       'Art. 30c al. 1 LPP : le retrait EPL doit intervenir au moins 3 ans avant l''ouverture du droit aux prestations de vieillesse. Au-delà, seul le retrait ordinaire à la retraite est possible.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'epargne'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-EP-008', 'vie', t.id, 'single',
       NULL, 'Comment le capital 3a est-il imposé au moment du retrait ?', '[{"text":"Comme un revenu ordinaire, pleinement soumis au taux marginal","correct":false,"why_wrong":"Fiscalité privilégiée : imposition séparée."},{"text":"À un taux réduit, séparément du revenu ordinaire","correct":true},{"text":"Uniquement au niveau cantonal, pas fédéral","correct":false,"why_wrong":"Fédéral ET cantonal, à taux réduit."},{"text":"Il est totalement exonéré","correct":false}]'::jsonb, 1,
       'Art. 38 LIFD (et lois cantonales similaires) : prestations en capital de la prévoyance imposées séparément du reste du revenu, à 1/5 du barème ordinaire. Argument fiscal fort pour échelonner les retraits sur plusieurs comptes 3a.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'epargne'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-EP-009', 'vie', t.id, 'multiple',
       NULL, 'Quelles différences fondamentales existent entre le 3a et le 3b ?', '[{"text":"Le 3a est soumis à un plafond légal, le 3b non","correct":true},{"text":"Le 3a est déductible fiscalement, le 3b généralement pas (sauf cantonalement dans une faible mesure)","correct":true},{"text":"Le 3a a un ordre de bénéficiaires imposé par la loi, le 3b est libre","correct":true},{"text":"Le 3b permet un retrait à tout moment (police vie liée à la vie)","correct":true},{"text":"Le 3b bénéficie du taux réduit LIFD art. 38","correct":false,"why_wrong":"Le 3b ne bénéficie pas du taux réduit ; les prestations sont souvent imposées différemment (rachat exonéré sous conditions)."},{"text":"Le 3a peut être versé à n''importe qui, le 3b non","correct":false,"why_wrong":"C''est exactement l''inverse."}]'::jsonb, 2,
       '3a = pilier lié (fiscal, plafonné, ordre légal art. 2 OPP 3). 3b = pilier libre (flexible, clause bénéficiaire libre art. 76 LCA). Le conseiller choisit selon l''objectif : optimisation fiscale (3a) vs souplesse successorale et transmission (3b).', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'epargne'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-EP-010', 'vie', t.id, 'single',
       NULL, 'Pourquoi est-il souvent recommandé d''ouvrir plusieurs comptes 3a échelonnés plutôt qu''un seul ?', '[{"text":"Pour bénéficier de meilleurs taux d''intérêt","correct":false,"why_wrong":"L''argument principal n''est pas le taux."},{"text":"Pour étaler la fiscalité au retrait grâce à la progressivité du barème LIFD art. 38","correct":true},{"text":"Parce que la loi impose au moins 3 comptes 3a","correct":false,"why_wrong":"Aucune obligation légale de multi-compte."},{"text":"Pour bénéficier d''un plafond fiscal supérieur","correct":false,"why_wrong":"Le plafond est individuel, pas par compte."}]'::jsonb, 1,
       'Le taux d''imposition sur capital 3a (art. 38 LIFD et cantonal) est progressif : plus le retrait est gros, plus le taux marginal grimpe. Retirer 3 comptes en 3 années fiscales séparées casse la progression et diminue l''impôt total. Pratique standard : ouvrir un nouveau compte tous les 5 à 7 ans.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'epargne'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-EP-011', 'vie', t.id, 'single',
       'Marie, 42 ans, hérite de 250''000 CHF. Elle a un 3a bien fourni, une LPP obligatoire, une hypothèque de 400''000 CHF sur sa résidence principale.', 'Quelle stratégie est la plus pertinente pour sécuriser sa retraite ?', '[{"text":"Verser tout dans son 3a en une fois","correct":false,"why_wrong":"Le plafond annuel 7''258 CHF interdit ce volume."},{"text":"Effectuer un rachat LPP pour combler ses lacunes de prévoyance et amortir partiellement l''hypothèque","correct":true},{"text":"Placer tout en actions volatiles pour maximiser le rendement","correct":false,"why_wrong":"Ne respecte ni le profil client ni l''objectif retraite."},{"text":"Souscrire une assurance-vie 3b sur 15 ans pour l''intégralité du montant","correct":false,"why_wrong":"Ignore le levier fiscal du rachat LPP, souvent plus performant."}]'::jsonb, 2,
       'Priorité 1 : combler la lacune LPP par rachat (déductible fiscalement, art. 33 al. 1 lit. d LIFD). Priorité 2 : amortir hypothèque de manière raisonnée (attention au maintien de la déduction fiscale des intérêts). Le conseil doit passer par un chiffrage complet (attestation LPP).', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'epargne'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-EP-012', 'vie', t.id, 'single',
       NULL, 'Un rachat LPP effectué en 2026 peut-il être retiré en capital en 2028 ?', '[{"text":"Oui, sans conséquence","correct":false,"why_wrong":"Piège fréquent. Blocage 3 ans."},{"text":"Non : blocage de 3 ans après tout rachat (art. 79b al. 3 LPP)","correct":true},{"text":"Oui, mais uniquement pour financer une résidence principale","correct":false,"why_wrong":"Le blocage vaut aussi pour l''EPL."},{"text":"Uniquement si les taux d''intérêt baissent","correct":false}]'::jsonb, 1,
       'Art. 79b al. 3 LPP : le rachat volontaire ne peut être retiré en capital dans les 3 ans qui suivent le versement (durée aussi pour un retrait EPL). En cas d''infraction, l''administration fiscale reprend la déduction. Important à documenter au dossier client.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'epargne'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-EP-013', 'vie', t.id, 'single',
       NULL, 'Est-il possible de mettre en gage son avoir LPP pour obtenir un prêt hypothécaire, au lieu de le retirer ?', '[{"text":"Non, seul le retrait est prévu par la loi","correct":false,"why_wrong":"La mise en gage est explicitement prévue."},{"text":"Oui, la LPP prévoit expressément la mise en gage à côté du retrait","correct":true},{"text":"Uniquement pour les indépendants","correct":false},{"text":"Uniquement si l''assuré a plus de 60 ans","correct":false}]'::jsonb, 1,
       'Art. 30b LPP et art. 8 OEPL : mise en gage de l''avoir LPP possible pour financer une résidence principale. Avantage vs retrait : maintien de la couverture invalidité/décès LPP intacte. À privilégier tant que possible.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'epargne'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-EP-014', 'vie', t.id, 'single',
       NULL, 'L''assurance-vie 3a en unités de compte (liée à des fonds) présente principalement :', '[{"text":"Une garantie de capital identique à un compte 3a bancaire","correct":false,"why_wrong":"Pas de garantie : c''est le principal risque."},{"text":"Un potentiel de rendement plus élevé mais avec un risque de marché","correct":true},{"text":"Une exonération totale d''impôt à la sortie","correct":false,"why_wrong":"Le taux réduit art. 38 LIFD s''applique, pas une exonération."},{"text":"Une déductibilité renforcée au-delà du plafond 3a","correct":false}]'::jsonb, 1,
       'Une assurance-vie 3a en unités de compte investit tout ou partie des primes en fonds de placement. Le rendement dépend des marchés (potentiellement supérieur à un 3a bancaire) mais expose l''assuré au risque de fluctuation. À proposer selon horizon (10 ans minimum) et profil de risque du client.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'epargne'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-EP-015', 'vie', t.id, 'single',
       NULL, 'Un salarié qui verse chaque année le plafond 3a pendant 30 ans économise en impôts, sur toute la période, en moyenne :', '[{"text":"Rien : l''imposition à la sortie annule l''économie","correct":false,"why_wrong":"Le différentiel de taux (marginal vs art. 38 LIFD) génère un gain net structurel."},{"text":"Un gain fiscal net structurel grâce au différentiel entre le taux marginal (versement) et le taux réduit LIFD art. 38 (retrait)","correct":true},{"text":"Uniquement au niveau fédéral","correct":false},{"text":"Uniquement dans les cantons romands","correct":false}]'::jsonb, 1,
       'Argument commercial central du 3a : différentiel de taux entre versement (déduction au taux marginal, souvent 25 à 40 %) et retrait (taux réduit 5 à 10 % environ selon canton et montant). Levier fiscal amplifié par l''échelonnement des retraits.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'epargne'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-HL-100', 'vie', t.id, 'single',
       NULL, 'Selon le CC, quel est l''ordre des parentèles pour la dévolution successorale légale ?', '[{"text":"1re parentèle : parents, 2e : frères/soeurs, 3e : grands-parents","correct":false,"why_wrong":"Confusion d''ordre : les descendants passent en premier."},{"text":"1re parentèle : descendants, 2e : parents et leur descendance, 3e : grands-parents et leur descendance","correct":true},{"text":"1re parentèle : conjoint, 2e : descendants, 3e : parents","correct":false,"why_wrong":"Le conjoint n''appartient à aucune parentèle : il concourt avec la 1re ou la 2e."},{"text":"1re parentèle : petits-enfants uniquement, 2e : enfants","correct":false}]'::jsonb, 1,
       'Art. 457-460 CC : trois parentèles : descendants (souche du défunt), parents et leur descendance (frères/soeurs, neveux/nièces), grands-parents et leur descendance (oncles/tantes, cousins). Le conjoint est traité séparément (art. 462 CC).', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'heriter_leguer'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-HL-101', 'vie', t.id, 'single',
       NULL, 'Quelle est la part légale du conjoint survivant lorsqu''il concourt avec les descendants (art. 462 CC) ?', '[{"text":"1/4","correct":false,"why_wrong":"1/4 est sa RÉSERVE, pas sa part légale."},{"text":"1/2 de la succession","correct":true},{"text":"3/4","correct":false},{"text":"L''intégralité","correct":false,"why_wrong":"Il faut respecter les parts des descendants."}]'::jsonb, 1,
       'Art. 462 ch. 1 CC : conjoint + descendants = conjoint reçoit 1/2, descendants se partagent l''autre 1/2. Sans descendants, avec parentèle 2, le conjoint reçoit 3/4 (art. 462 ch. 2 CC).', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'heriter_leguer'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-HL-102', 'vie', t.id, 'single',
       NULL, 'Quelle réserve légale prévoit le CC pour les PARENTS du défunt depuis la réforme du droit successoral entrée en vigueur le 01.01.2023 ?', '[{"text":"1/2 de leur part légale","correct":false,"why_wrong":"C''est l''ancien droit avant 2023."},{"text":"1/4 de leur part légale","correct":false,"why_wrong":"Aucune réserve à ce taux n''a existé pour les parents."},{"text":"Aucune réserve : la réserve des parents a été supprimée","correct":true},{"text":"3/4 de leur part légale","correct":false}]'::jsonb, 1,
       'Nouveau droit successoral 2023, art. 471 CC : réserve des descendants réduite de 3/4 à 1/2 de leur part légale, réserve du conjoint maintenue à 1/2 de sa part légale, RÉSERVE DES PARENTS SUPPRIMÉE. Point clé pour les couples sans enfants souhaitant tout léguer au conjoint.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'heriter_leguer'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-HL-103', 'vie', t.id, 'single',
       'Un couple marié sans enfants. Les parents du mari sont vivants. Le mari décède ; patrimoine net 600''000 CHF.', 'Que peut-il maximum léguer à son épouse par testament (nouveau droit 2023) ?', '[{"text":"3/8 de la succession","correct":false},{"text":"1/2 de la succession","correct":false},{"text":"L''intégralité de la succession","correct":true},{"text":"7/8 de la succession","correct":false,"why_wrong":"Correspondait à l''ancien droit où subsistait une réserve pour les parents."}]'::jsonb, 2,
       'Nouveau droit : parents n''ont plus de réserve. L''épouse (part légale 3/4 en concours avec parentèle 2) peut donc recevoir 100 % par testament. Argument fort du conseiller pour couples sans enfants dont les parents sont encore vivants.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'heriter_leguer'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-HL-104', 'vie', t.id, 'multiple',
       'Un client de 68 ans veut rédiger seul son testament, sans passer chez le notaire.', 'Quelles conditions doit respecter un testament olographe pour être valable (art. 505 CC) ?', '[{"text":"Être entièrement écrit à la main par le testateur","correct":true},{"text":"Comporter une date complète (jour, mois, année)","correct":true},{"text":"Être signé de la main du testateur","correct":true},{"text":"Être signé par 2 témoins majeurs","correct":false,"why_wrong":"Ce sont les exigences du testament public, pas de l''olographe."},{"text":"Être obligatoirement déposé chez un notaire pour être valide","correct":false,"why_wrong":"Le dépôt est prudent mais non obligatoire."},{"text":"Être imprimé et signé","correct":false,"why_wrong":"Un texte imprimé n''est pas manuscrit ; seule la signature ne suffit pas."}]'::jsonb, 2,
       'Art. 505 CC : testament olographe = entièrement manuscrit + daté (jour, mois, année) + signé. Un défaut de date ou de signature entraîne la nullité. Conseiller : recommander la conservation en lieu sûr (banque, notaire, autorité).', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'heriter_leguer'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-HL-105', 'vie', t.id, 'single',
       NULL, 'Quel est le régime matrimonial ordinaire en Suisse en l''absence de contrat de mariage ?', '[{"text":"Séparation de biens","correct":false,"why_wrong":"Il faut un contrat de mariage."},{"text":"Participation aux acquêts","correct":true},{"text":"Communauté universelle","correct":false,"why_wrong":"Il faut un contrat de mariage."},{"text":"Communauté réduite aux acquêts","correct":false}]'::jsonb, 1,
       'Art. 181 CC : à défaut de contrat de mariage, le régime légal ordinaire est la participation aux acquêts (art. 196-220 CC). Chaque conjoint conserve ses biens propres (biens acquis avant mariage, héritages, dons) ; les acquêts (revenus du travail, économies pendant le mariage) sont partagés par moitié à la dissolution.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'heriter_leguer'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-HL-106', 'vie', t.id, 'single',
       'Couple marié en participation aux acquêts. Au décès du mari, ses acquêts nets sont de 400''000 CHF, ceux de l''épouse 200''000 CHF.', 'Quel bénéfice l''épouse tire-t-elle du régime matrimonial AVANT la répartition successorale ?', '[{"text":"Rien : les acquêts appartiennent chacun à leur titulaire","correct":false,"why_wrong":"La liquidation prévoit un partage."},{"text":"100''000 CHF (moitié de la différence 400''000 moins 200''000)","correct":true},{"text":"400''000 CHF (elle prend tous les acquêts du mari)","correct":false,"why_wrong":"Le partage est par moitié, pas total."},{"text":"300''000 CHF","correct":false}]'::jsonb, 2,
       'Art. 215 CC : chaque conjoint a droit à la moitié du bénéfice (acquêts nets) de l''autre. Ici, mari 400''000 moins épouse 200''000 = 200''000, dont 1/2 revient à l''épouse = 100''000 CHF. La succession ne porte QUE sur ce qui reste au défunt APRÈS liquidation du régime matrimonial.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'heriter_leguer'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-HL-107', 'vie', t.id, 'multiple',
       NULL, 'Quelles sont les manières d''AVANTAGER son conjoint au maximum en droit suisse ?', '[{"text":"Contrat de mariage attribuant tout le bénéfice de l''union à l''un des conjoints","correct":true},{"text":"Testament attribuant la quotité disponible au conjoint","correct":true},{"text":"Assurance-vie 3b avec clause bénéficiaire libre en faveur du conjoint","correct":true},{"text":"Pacte successoral avec renonciation à héritage des descendants","correct":true},{"text":"Testament olographe non daté","correct":false,"why_wrong":"Le défaut de date rend le testament nul."},{"text":"Verser tout son 3a à son concubin","correct":false,"why_wrong":"L''ordre 3a est imposé, le conjoint est prioritaire."}]'::jsonb, 2,
       'Boîte à outils : régime matrimonial (attribution intégrale du bénéfice, art. 216 CC), testament (quotité disponible), pacte successoral avec renonciation des enfants, assurance-vie 3b, désignation 3a. Combinés, ces outils permettent d''atteindre 100 % avec l''accord des héritiers réservataires.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'heriter_leguer'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-HL-108', 'vie', t.id, 'multiple',
       'Alain vient d''apprendre le décès de son père, dont il pense la succession déficitaire.', 'Quelles affirmations sont exactes concernant la répudiation d''une succession en Suisse ?', '[{"text":"Le délai pour répudier est de 3 mois","correct":true},{"text":"Le délai court dès la connaissance du décès (ou de la qualité d''héritier si plus tardive)","correct":true},{"text":"Le silence pendant le délai vaut acceptation tacite","correct":true},{"text":"L''héritier peut demander un bénéfice d''inventaire pour limiter sa responsabilité","correct":true},{"text":"La répudiation doit se faire dans les 30 jours du décès","correct":false,"why_wrong":"Le délai légal est de 3 mois, pas 30 jours."},{"text":"La répudiation est irrévocable une fois déclarée","correct":true}]'::jsonb, 2,
       'Art. 567 CC : délai de répudiation 3 mois dès connaissance. Silence = acceptation tacite (art. 571 CC). Alternative : bénéfice d''inventaire (art. 580 CC) qui limite la responsabilité aux dettes inventoriées. Répudiation irrévocable une fois déclarée.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'heriter_leguer'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-HL-109', 'vie', t.id, 'single',
       NULL, 'Le bénéfice d''inventaire (art. 580 CC) permet à l''héritier :', '[{"text":"De prendre uniquement les actifs, en refusant les dettes","correct":false,"why_wrong":"Le principe reste l''universalité, il ne s''agit pas d''un tri."},{"text":"De limiter sa responsabilité aux dettes inventoriées, en cas d''incertitude sur le passif","correct":true},{"text":"De renoncer à la succession sans délai","correct":false},{"text":"De demander une expertise gratuite au notaire","correct":false}]'::jsonb, 1,
       'Art. 580-588 CC : l''héritier peut demander un inventaire officiel des actifs et passifs. Il n''est ensuite tenu que des dettes portées à l''inventaire (celles non annoncées créancier connu ou révélées plus tard ne l''engagent pas). Alternative à la répudiation quand on soupçonne un passif caché.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'heriter_leguer'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-HL-110', 'vie', t.id, 'single',
       NULL, 'Le capital-décès versé par une assurance-vie avec clause bénéficiaire nominative est-il ajouté à la masse successorale ?', '[{"text":"Oui, comme tout capital du défunt","correct":false,"why_wrong":"Piège majeur : la clause bénéficiaire opère hors succession."},{"text":"Non, il est versé directement au bénéficiaire","correct":true},{"text":"Uniquement si le montant dépasse 100''000 CHF","correct":false,"why_wrong":"Aucun seuil de ce type."},{"text":"Uniquement si le contrat a moins de 5 ans","correct":false}]'::jsonb, 1,
       'Art. 76-79 LCA : capital versé au bénéficiaire nommément désigné = versement direct hors masse successorale. Attention à l''ACTION EN RÉDUCTION (art. 476 CC) si le versement porte atteinte aux réserves : les héritiers réservataires peuvent demander réduction dans la limite de leur réserve.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'heriter_leguer'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-HL-111', 'vie', t.id, 'single',
       NULL, 'Une clause bénéficiaire en assurance-vie peut-elle être révoquée par le preneur ?', '[{"text":"Non, elle est toujours définitive","correct":false},{"text":"Oui, tant qu''elle n''a pas été rendue irrévocable par acte écrit du preneur","correct":true},{"text":"Uniquement avec l''accord de l''assureur","correct":false,"why_wrong":"L''assureur n''a rien à valider."},{"text":"Uniquement en cas de divorce","correct":false}]'::jsonb, 1,
       'Art. 76-77 LCA : clause bénéficiaire librement révocable par principe. Le preneur peut la rendre IRRÉVOCABLE par acte écrit remis au bénéficiaire (art. 77 LCA). L''assurance devient alors intouchable, souvent utilisée en garantie hypothécaire ou en pension alimentaire.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'heriter_leguer'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-HL-112', 'vie', t.id, 'single',
       NULL, 'Quel document est requis pour désigner de façon valable un exécuteur testamentaire ?', '[{"text":"Une simple lettre au notaire","correct":false,"why_wrong":"L''exécuteur ne peut être désigné que dans un testament valable."},{"text":"Un testament (olographe ou public) mentionnant expressément l''exécuteur","correct":true},{"text":"Un contrat notarié entre héritiers","correct":false},{"text":"Un jugement de tribunal","correct":false}]'::jsonb, 1,
       'Art. 517-518 CC : l''exécuteur testamentaire ne peut être désigné que par disposition à cause de mort (testament ou pacte successoral). Il administre la succession selon les instructions du défunt, sous surveillance de l''autorité. Missions : payer les dettes, exécuter les legs, remettre les biens aux héritiers.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'heriter_leguer'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-HL-113', 'vie', t.id, 'single',
       'Famille recomposée : Pierre a 2 enfants d''un 1er mariage, remarié avec Sophie sans enfants communs. Il souhaite protéger Sophie sans déshériter ses enfants.', 'Quelle est la solution la PLUS robuste ?', '[{"text":"Testament olographe attribuant tout à Sophie","correct":false,"why_wrong":"Portera atteinte aux réserves des enfants et sera réductible."},{"text":"Pacte successoral impliquant les 2 enfants qui renoncent à leur réserve moyennant contreparties","correct":true},{"text":"Assurance-vie 3a avec Sophie en 1re position","correct":false,"why_wrong":"Les enfants restent héritiers réservataires ; ils peuvent contester par action en réduction."},{"text":"Contrat de mariage en séparation de biens","correct":false,"why_wrong":"Défavorise Sophie plutôt que de la protéger."}]'::jsonb, 2,
       'Art. 512-515 CC : pacte successoral bilatéral, forme authentique (notaire + 2 témoins). Renonciation partielle ou totale des enfants moyennant compensation (assurance-vie, donation intergénérationnelle). Verrouille l''accord et évite l''action en réduction. Best practice recommandée pour recomposées.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'heriter_leguer'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-HL-114', 'vie', t.id, 'single',
       NULL, 'Le partenaire enregistré au sens de la LPart (avant l''ouverture du mariage aux couples de même sexe) bénéficie en matière successorale :', '[{"text":"D''un statut proche mais moindre que celui du conjoint","correct":false,"why_wrong":"Le statut a été aligné sur celui du conjoint."},{"text":"Du même statut successoral que le conjoint (part légale et réserve)","correct":true},{"text":"D''aucun statut successoral automatique","correct":false,"why_wrong":"C''est le sort du concubin, pas du partenaire enregistré."},{"text":"Uniquement d''une part libre d''impôt","correct":false}]'::jsonb, 1,
       'Art. 462 CC et LPart : le partenaire enregistré est traité comme le conjoint pour la dévolution légale (part et réserve identiques). Depuis 2022, les couples de même sexe peuvent se marier ; nouveaux partenariats enregistrés impossibles, ceux existants perdurent.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'heriter_leguer'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-AI-100', 'vie', t.id, 'multiple',
       'Un graphiste veut se faire reconnaître comme indépendant par la caisse de compensation AVS.', 'Quels indices concrets la caisse examinera-t-elle pour reconnaître le statut d''INDÉPENDANT (art. 5 et 9 LAVS) ?', '[{"text":"Facturation sous son propre nom à plusieurs mandants","correct":true},{"text":"Prise du risque économique par la personne elle-même","correct":true},{"text":"Propres locaux, outils, matériel","correct":true},{"text":"Liberté d''organisation du travail (horaires, lieu, méthodes)","correct":true},{"text":"Statut choisi librement sur le formulaire d''inscription","correct":false,"why_wrong":"Ce n''est pas un choix, c''est une qualification appréciée par la caisse sur faisceau d''indices."},{"text":"Chiffre d''affaires minimum de 100''000 CHF","correct":false,"why_wrong":"Aucun seuil chiffré (le seuil 100''000 concerne la TVA et le registre du commerce)."}]'::jsonb, 2,
       'Art. 5 al. 2 et 9 LAVS : le statut d''indépendant est reconnu par la caisse de compensation sur un faisceau d''indices convergents (facturation propre, plusieurs mandants, propres moyens, prise de risque, liberté d''organisation). Sans reconnaissance, la personne reste salariée avec cotisations paritaires.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'activite_independante'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-AI-101', 'vie', t.id, 'single',
       NULL, 'Quel est le TAUX MAXIMAL de cotisation AVS/AI/APG pour un indépendant à revenu élevé (2026) ?', '[{"text":"5,3 %","correct":false,"why_wrong":"C''est le taux salarié (moitié)."},{"text":"10,0 %","correct":true},{"text":"12,0 %","correct":false},{"text":"15,0 %","correct":false}]'::jsonb, 1,
       'Art. 8 LAVS : indépendant paie SEUL sa cotisation (pas d''employeur). Taux maximal AVS/AI/APG cumulé environ 10,0 % au-dessus d''un certain seuil de revenu. Barème dégressif pour les faibles revenus (taux minimum d''environ 5,371 %).', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'activite_independante'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-AI-102', 'vie', t.id, 'multiple',
       'Une architecte indépendante veut se prévoyance-couvrir via une LPP facultative.', 'Auprès de qui peut-elle s''affilier au 2e pilier (art. 44 LPP) ?', '[{"text":"L''institution de prévoyance de son association professionnelle","correct":true},{"text":"L''institution de prévoyance de ses propres salariés si elle en emploie","correct":true},{"text":"La Fondation institution supplétive LPP","correct":true},{"text":"N''importe quel assureur privé sans conditions particulières","correct":false,"why_wrong":"L''art. 44 LPP limite les voies d''affiliation à 3 options précises."},{"text":"Uniquement si elle a plus de 45 ans","correct":false,"why_wrong":"Aucune condition d''âge n''est prévue."}]'::jsonb, 2,
       'Art. 44 LPP : 3 voies d''affiliation facultative pour l''indépendant. Adhésion irrévocable une fois choisie. Décision structurante : arbitrage entre 3a grand plafond (sans LPP) et LPP facultative + 3a petit plafond.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'activite_independante'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-AI-103', 'vie', t.id, 'single',
       NULL, 'L''adhésion facultative à la LAA d''un indépendant doit obligatoirement passer par :', '[{"text":"Un assureur LCA quelconque","correct":false,"why_wrong":"La LAA ne se souscrit pas en LCA."},{"text":"La SUVA ou un autre assureur LAA agréé (selon la branche d''activité)","correct":true},{"text":"L''AVS et l''AI uniquement","correct":false},{"text":"L''employeur du conjoint","correct":false}]'::jsonb, 1,
       'Art. 4-5 LAA : l''indépendant peut s''assurer facultativement à la LAA auprès de la SUVA ou d''un assureur privé agréé (selon la branche d''activité). Attention : possibilité aussi d''inclure des membres de la famille non salariés qui collaborent à l''entreprise.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'activite_independante'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-AI-104', 'vie', t.id, 'single',
       NULL, 'Un indépendant à titre principal peut-il continuer à cotiser au petit pilier 3a plafonné 7''258 CHF ?', '[{"text":"Oui, si et seulement s''il est affilié à une LPP","correct":true},{"text":"Non, il n''a droit qu''au grand pilier 3a","correct":false,"why_wrong":"S''il s''affilie à une LPP facultative, il retombe sur le petit plafond."},{"text":"Oui, sans condition","correct":false},{"text":"Non, le 3a est réservé aux salariés","correct":false}]'::jsonb, 1,
       'Art. 7 OPP 3 : petit plafond 3a (7''258 CHF) réservé aux affiliés à une LPP (salariés OU indépendants ayant adhéré à titre facultatif). Grand plafond 3a (20 % du revenu jusqu''à 36''288 CHF) réservé aux indépendants SANS LPP. Choix stratégique à documenter dans le PV de conseil.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'activite_independante'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-AI-105', 'vie', t.id, 'single',
       'Julien, menuisier indépendant depuis 3 mois, 35 ans, revenu annuel estimé 85''000 CHF, marié, 2 enfants.', 'Quel enchaînement de couvertures est le PLUS prioritaire ?', '[{"text":"3b libre en priorité, LAA en dernier","correct":false,"why_wrong":"Un menuisier a un risque accident élevé : la LAA doit primer."},{"text":"LAA facultative (SUVA) + IJM LCA + 3a grand plafond + assurance-vie risque pur pour la famille","correct":true},{"text":"LACI + LAA + LPP","correct":false,"why_wrong":"Un indépendant n''est pas assurable LACI."},{"text":"3a petit uniquement, en attendant la stabilisation de l''activité","correct":false,"why_wrong":"Ignore les risques immédiats (accident, arrêt maladie, décès)."}]'::jsonb, 2,
       'Priorités indépendant à risque physique : (1) LAA facultative pour accident, (2) IJM LCA pour maladie, (3) 3a grand pour prévoyance vieillesse et fiscalité, (4) assurance-vie risque pur pour famille (capital-décès et rente d''invalidité). RC pro et RC entreprise ajoutées selon activité.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'activite_independante'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-AI-106', 'vie', t.id, 'single',
       NULL, 'L''assurance perte de gain maladie (IJM LCA) est-elle obligatoire pour un indépendant ?', '[{"text":"Oui, dès le début de l''activité","correct":false,"why_wrong":"Confusion avec l''IJM d''entreprise pour salariés."},{"text":"Non, elle est facultative (mais fortement recommandée en pratique)","correct":true},{"text":"Oui, mais seulement si l''indépendant emploie du personnel","correct":false,"why_wrong":"L''IJM devient impérative pour ses salariés (via CO 324a), pas pour lui-même."},{"text":"Non, seule la LAMal couvre déjà tout","correct":false}]'::jsonb, 1,
       'La LCA (perte de gain maladie) n''est PAS obligatoire pour l''indépendant. En cas d''incapacité de travail pour maladie, aucune indemnité obligatoire n''est prévue avant l''ouverture d''une éventuelle rente AI (12 mois). L''IJM LCA vient combler cette lacune critique.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'activite_independante'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-AI-107', 'vie', t.id, 'single',
       NULL, 'Une indépendante enceinte a-t-elle droit à l''APG maternité ?', '[{"text":"Non, l''APG maternité ne concerne que les salariées","correct":false,"why_wrong":"PIÈGE. Les indépendantes sont couvertes depuis 2005."},{"text":"Oui, 80 % du revenu, 14 semaines, plafonné à 220 CHF/jour","correct":true},{"text":"Uniquement 60 %, 8 semaines","correct":false},{"text":"Uniquement en cas d''accouchement multiple","correct":false}]'::jsonb, 1,
       'Art. 16b LAPG : indépendantes affiliées à l''AVS bénéficient de l''APG maternité aux mêmes conditions que les salariées. Prestation = 80 % du revenu, 14 semaines, plafond 220 CHF/jour, financée par la cotisation APG.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'activite_independante'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-AI-108', 'vie', t.id, 'single',
       NULL, 'Un indépendant qui adhère à titre facultatif à la LAA a-t-il également la couverture des accidents non professionnels ?', '[{"text":"Non, uniquement les accidents professionnels","correct":false},{"text":"Oui, il peut assurer tant les accidents professionnels que non professionnels","correct":true},{"text":"Oui, mais uniquement s''il travaille plus de 20 h par semaine","correct":false,"why_wrong":"Aucune règle de ce type pour l''indépendant."},{"text":"Non, uniquement les maladies professionnelles","correct":false,"why_wrong":"La LAA ne couvre que les accidents (et certaines maladies professionnelles)."}]'::jsonb, 1,
       'Art. 5 LAA : l''indépendant peut s''assurer facultativement contre les accidents professionnels ET non professionnels (au choix). La couverture optimale inclut les deux, sans quoi une lacune subsiste pour les accidents privés.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'activite_independante'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-AI-109', 'vie', t.id, 'multiple',
       'Karim, salarié, décide de se lancer comme indépendant et de retirer son avoir LPP existant.', 'Quelles règles s''appliquent à ce retrait en espèces (art. 5 LFLP) ?', '[{"text":"Le passage à l''indépendance permet le retrait en espèces de la prestation de libre passage","correct":true},{"text":"L''imposition se fait à taux réduit et séparément du revenu (art. 38 LIFD)","correct":true},{"text":"Le consentement écrit du conjoint marié avec signature certifiée est requis","correct":true},{"text":"La demande doit être accompagnée d''un justificatif du statut d''indépendant délivré par la caisse AVS","correct":true},{"text":"Le retrait est possible sans aucun impôt","correct":false,"why_wrong":"Imposition à taux réduit art. 38 LIFD, mais imposition tout de même."},{"text":"Le retrait est possible même sans reconnaissance officielle du statut indépendant","correct":false,"why_wrong":"La caisse exige la reconnaissance du statut par la caisse AVS."}]'::jsonb, 2,
       'Art. 5 al. 1 lit. b LFLP : passage à l''indépendance = motif de retrait en espèces. Imposition à taux réduit art. 38 LIFD. Justificatif AVS + consentement du conjoint requis. Décision structurante : à documenter dans le PV de conseil.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'activite_independante'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-AI-110', 'vie', t.id, 'multiple',
       NULL, 'Un indépendant employant du personnel doit prendre en compte quelles obligations LÉGALES concernant ses SALARIÉS ?', '[{"text":"Affiliation obligatoire à une caisse LPP dès le seuil d''entrée atteint","correct":true},{"text":"Affiliation LAA obligatoire dès la 1re heure de travail","correct":true},{"text":"Cotisations AVS/AI/APG paritaires (50/50)","correct":true},{"text":"Contribution LACI paritaire","correct":true},{"text":"IJM LCA facultative pour se libérer du CO 324a","correct":true},{"text":"3a obligatoire pour tous les salariés","correct":false,"why_wrong":"Le 3a est individuel et facultatif."}]'::jsonb, 2,
       'L''indépendant employeur cumule les obligations : LPP + LAA + AVS/AI/APG + LACI (paritaires) + décompte annuel + certificat de salaire. L''IJM LCA n''est pas obligatoire mais recommandée pour couvrir les 3 semaines à 3 mois d''obligation CO 324a.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'activite_independante'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-AI-111', 'vie', t.id, 'single',
       NULL, 'À partir de quel chiffre d''affaires annuel un indépendant est-il obligatoirement assujetti à la TVA ?', '[{"text":"50''000 CHF","correct":false},{"text":"100''000 CHF","correct":true},{"text":"150''000 CHF","correct":false,"why_wrong":"Confusion avec certains seuils spécifiques (sport, culture, aide sociale)."},{"text":"200''000 CHF","correct":false}]'::jsonb, 1,
       'Art. 10 LTVA : assujettissement obligatoire dès un chiffre d''affaires imposable de 100''000 CHF par an. Certaines activités bénéficient d''un seuil plus élevé (associations sportives, culturelles, d''utilité publique à 250''000 CHF). Assujettissement volontaire possible en dessous.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'activite_independante'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-AI-112', 'vie', t.id, 'single',
       NULL, 'L''inscription au registre du commerce devient-elle obligatoire pour un indépendant ?', '[{"text":"Toujours","correct":false},{"text":"Jamais","correct":false},{"text":"Dès que le chiffre d''affaires annuel atteint 100''000 CHF","correct":true},{"text":"Dès l''engagement du 1er salarié","correct":false,"why_wrong":"L''engagement d''un salarié n''entraîne pas automatiquement l''inscription."}]'::jsonb, 1,
       'Art. 934 CO : entreprise individuelle obligatoirement inscrite au registre du commerce à partir de 100''000 CHF de chiffre d''affaires annuel. En dessous, inscription facultative (mais souvent utile pour crédibilité et accès à la protection du nom).', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'activite_independante'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-AI-113', 'vie', t.id, 'single',
       'Claire, consultante indépendante, 55 ans, revenu net 180''000 CHF, sans LPP.', 'Combien peut-elle verser au maximum dans son pilier 3a en 2026 ?', '[{"text":"7''258 CHF (petit plafond salarié)","correct":false,"why_wrong":"Elle est indépendante sans LPP, elle a droit au grand plafond."},{"text":"20 % de 180''000 = 36''000 CHF, plafonné à 36''288 CHF","correct":true},{"text":"50''000 CHF (rachat + 3a)","correct":false},{"text":"L''intégralité de son bénéfice","correct":false}]'::jsonb, 2,
       'Art. 7 al. 1 lit. b OPP 3 : indépendant sans LPP = 20 % du revenu net, plafonné à 36''288 CHF en 2026. Ici 20 % de 180''000 = 36''000, en dessous du plafond, donc 36''000 CHF déductibles. Levier fiscal considérable (économie de 10''000 à 15''000 CHF selon canton).', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'activite_independante'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-AI-114', 'vie', t.id, 'single',
       NULL, 'Le conjoint aidant qui travaille dans l''entreprise sans être salarié doit :', '[{"text":"Cotiser à titre d''indépendant à l''AVS s''il exerce une activité substantielle","correct":true},{"text":"Rien : il est couvert par le statut de son conjoint","correct":false,"why_wrong":"Piège fréquent. Une activité substantielle non couverte crée un trou de prévoyance."},{"text":"Uniquement cotiser à la LPP","correct":false},{"text":"Cotiser à la LACI uniquement","correct":false}]'::jsonb, 1,
       'Art. 3 al. 3 LAVS : conjoint qui collabore à l''entreprise dans une mesure notablement supérieure à ce qu''exige l''entretien du ménage doit être affilié à titre indépendant (ou salarié). Point critique du conseil : sans cotisations propres, pas de rente AVS individuelle et pas de rente d''invalidité.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'activite_independante'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-CV-100', 'vie', t.id, 'single',
       NULL, 'En cas de RÉTICENCE (fausse déclaration sur un questionnaire de santé), quel est le délai pendant lequel l''assureur peut résilier une assurance-vie LCA ?', '[{"text":"1 mois dès la conclusion du contrat","correct":false},{"text":"4 semaines dès la découverte de la réticence","correct":true},{"text":"6 mois dès la souscription","correct":false},{"text":"Aucun délai, l''assureur peut résilier à tout moment","correct":false,"why_wrong":"Un délai strict encadre la faculté de résiliation."}]'::jsonb, 1,
       'Art. 6 LCA (révisé) : en cas de réticence, l''assureur peut résilier le contrat dans les 4 semaines qui suivent la découverte, avec effet rétroactif. Prescription absolue : 5 ans après la conclusion du contrat (art. 6 al. 2 LCA). Point clé pour la vente : formuler les questions de santé avec pédagogie.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'conseil_vie'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-CV-101', 'vie', t.id, 'multiple',
       'Une conseillère suit un couple client depuis 5 ans. Situation stable, contrat vie signé il y a 3 ans.', 'Dans quelles situations le devoir d''information CONTINU exige-t-il d''alerter le client ?', '[{"text":"Changement de situation familiale (mariage, naissance, divorce, décès)","correct":true},{"text":"Changement professionnel majeur (perte d''emploi, passage à l''indépendance)","correct":true},{"text":"Modification législative impactant les prestations (réforme AVS, LPP)","correct":true},{"text":"Uniquement au renouvellement annuel du contrat","correct":false,"why_wrong":"L''obligation est continue, elle ne se limite pas à un rendez-vous annuel."},{"text":"Uniquement à la demande expresse du client","correct":false,"why_wrong":"Le conseiller doit AGIR proactivement, sans attendre la demande du client."},{"text":"En cas de changement produit chez l''assureur (nouvelle version, refonte)","correct":true}]'::jsonb, 2,
       'Art. 3 LCA et art. 45 LSA : information continue tout au long de la relation. À chaque événement pertinent, le conseiller doit alerter proactivement le client. Justifie la revue annuelle systématique et la documentation des contacts.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'conseil_vie'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-CV-102', 'vie', t.id, 'single',
       NULL, 'Selon la nLPD entrée en vigueur en 2023, quelle catégorie de données une donnée de santé fait-elle partie ?', '[{"text":"Donnée personnelle ordinaire","correct":false,"why_wrong":"La santé bénéficie d''un régime renforcé."},{"text":"Donnée personnelle SENSIBLE (art. 5 lit. c ch. 2 nLPD)","correct":true},{"text":"Donnée commerciale","correct":false},{"text":"Donnée technique","correct":false}]'::jsonb, 1,
       'Art. 5 lit. c ch. 2 nLPD : les données concernant la santé, la sphère intime, l''appartenance à une race ou une ethnie, les mesures d''aide sociale, les poursuites administratives ou pénales sont des données sensibles. Traitement soumis à consentement exprès (art. 6 al. 7 nLPD) et sécurité renforcée.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'conseil_vie'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-CV-103', 'vie', t.id, 'multiple',
       NULL, 'Quelles informations doit contenir la FICHE D''INFORMATION art. 45 LSA remise au 1er entretien ?', '[{"text":"Identité et coordonnées de l''intermédiaire","correct":true},{"text":"Statut de l''intermédiaire (lié ou non lié) et rémunération","correct":true},{"text":"Adresse de l''organe de médiation compétent","correct":true},{"text":"Nature et étendue du traitement des données personnelles","correct":true},{"text":"Copie de la police d''assurance du client","correct":false,"why_wrong":"La police n''est pas encore établie au 1er entretien."},{"text":"Barème détaillé des commissions de tous les assureurs partenaires","correct":false,"why_wrong":"Nature générale de la rémunération suffit ; barème détaillé non requis, mais transparence indispensable."}]'::jsonb, 2,
       'Art. 45 LSA : la fiche doit permettre au client d''identifier l''intermédiaire, son statut (lié ou courtier), son mode de rémunération, ses partenaires assureurs, sa procédure de plainte, l''organe de médiation compétent. Doit être remise AVANT la conclusion, signature client requise.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'conseil_vie'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-CV-104', 'vie', t.id, 'single',
       NULL, 'Quelle est la différence essentielle entre un COURTIER et un AGENT LIÉ ?', '[{"text":"Le courtier vend uniquement de l''assurance-vie","correct":false},{"text":"Le courtier représente le CLIENT et travaille avec plusieurs assureurs, l''agent lié représente UN assureur","correct":true},{"text":"L''agent lié doit détenir un doctorat en assurance","correct":false},{"text":"Ils ont les mêmes obligations et le même statut au registre","correct":false,"why_wrong":"Registre FINMA obligatoire uniquement pour les non liés."}]'::jsonb, 1,
       'Art. 40 LSA : intermédiaires liés (représentent un ou plusieurs assureurs sur mandat) vs non liés (courtiers, mandatés par le client). Seuls les intermédiaires NON LIÉS doivent s''enregistrer au registre FINMA (art. 41 LSA depuis la révision LSA 2024). Statut à indiquer clairement au client.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'conseil_vie'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-CV-105', 'vie', t.id, 'single',
       NULL, 'Selon la LSFin art. 8, quelle est l''obligation principale liée à la vérification de l''adéquation d''un produit financier ?', '[{"text":"Prouver que le produit rapporte plus que l''inflation","correct":false},{"text":"S''assurer que le produit correspond aux objectifs, à la situation financière et à la tolérance au risque du client","correct":true},{"text":"Comparer le produit à la moyenne du marché","correct":false},{"text":"Obtenir l''accord des héritiers du client","correct":false}]'::jsonb, 1,
       'Art. 8 LSFin : l''adéquation impose au prestataire de connaître le client (objectifs, situation, tolérance au risque) et de proposer un produit qui correspond à ce profil. Documentation obligatoire (art. 15 LSFin) opposable en cas de litige.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'conseil_vie'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-CV-106', 'vie', t.id, 'single',
       'Un client refuse de répondre au questionnaire de santé complet lors d''une souscription assurance-vie.', 'Quelle est la conduite CORRECTE du conseiller ?', '[{"text":"Proposer au client de mentir sur le formulaire pour aller vite","correct":false,"why_wrong":"Illégal : incitation à la réticence, faute grave professionnelle."},{"text":"Expliquer que sans questionnaire complet, l''assureur refusera la couverture ou l''accordera avec des réserves, et documenter le refus","correct":true},{"text":"Compléter le formulaire à la place du client sur base de suppositions","correct":false,"why_wrong":"Faux en écriture, faute grave, engage la responsabilité pénale."},{"text":"Faire signer un formulaire vide et le remplir plus tard","correct":false,"why_wrong":"Contraire à l''obligation d''exactitude et de bonne foi."}]'::jsonb, 2,
       'Le devoir de loyauté et l''art. 4 LCA (obligation du preneur de déclarer les faits importants) imposent une réponse complète et sincère. En cas de refus, il faut informer le client des conséquences, documenter le refus par écrit et NE PAS soumettre le dossier. Toute autre attitude expose à des sanctions FINMA et pénales.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'conseil_vie'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-CV-107', 'vie', t.id, 'single',
       NULL, 'Quelle utilité a le PROCÈS-VERBAL de conseil signé par le client ?', '[{"text":"Simple formalité administrative sans portée juridique","correct":false,"why_wrong":"Portée juridique forte en cas de litige."},{"text":"Preuve du conseil délivré, opposable en cas de litige et exigée par la FINMA lors des contrôles","correct":true},{"text":"Permet de facturer des honoraires supplémentaires au client","correct":false},{"text":"Sert uniquement à des fins internes de l''entreprise","correct":false}]'::jsonb, 1,
       'Le PV de conseil (obligatoire dans la pratique post-LSA/LSFin) documente : besoins identifiés, produits proposés, produits écartés et raisons, décisions du client. En cas de litige, il inverse la charge de la preuve. Utilité renforcée depuis la nLPD et la révision LSA 2024.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'conseil_vie'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-CV-108', 'vie', t.id, 'single',
       NULL, 'Lorsqu''un client signe une proposition d''assurance-vie LCA, le CONTRAT prend effet :', '[{"text":"Immédiatement à la signature","correct":false,"why_wrong":"L''assureur doit accepter la proposition."},{"text":"Dès l''acceptation par l''assureur (émission de la police), sous réserve du droit de révocation 14 jours","correct":true},{"text":"Uniquement au paiement de la 1re prime","correct":false,"why_wrong":"Le paiement n''est pas la condition de formation, il est une condition d''exigibilité de la prestation."},{"text":"Au bout de 30 jours de délai de réflexion","correct":false}]'::jsonb, 1,
       'Art. 1er LCA (concordance des volontés) : le contrat naît de l''acceptation par l''assureur de la proposition. La police en est la preuve. Art. 2a LCA : droit de révocation de 14 jours dès signature de la proposition (nouveau droit 2022). Bien documenter les dates de signature et d''acceptation.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'conseil_vie'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-CV-109', 'vie', t.id, 'single',
       NULL, 'L''analyse des besoins (phase 2 des 4 phases) inclut typiquement :', '[{"text":"Uniquement le calcul des primes possibles","correct":false,"why_wrong":"La phase 2 est plus large : elle chiffre les besoins."},{"text":"Situation familiale, revenus, patrimoine, prévoyance actuelle (1er/2e/3e piliers), objectifs et lacunes chiffrées","correct":true},{"text":"Uniquement la santé du client","correct":false},{"text":"Le choix du produit final","correct":false,"why_wrong":"Le choix relève de la phase 3 (solution)."}]'::jsonb, 1,
       'Phase 2 (analyse) : recueillir la situation complète, chiffrer les prestations attendues des 1er/2e piliers en cas de décès, invalidité, retraite. Comparer à l''objectif (souvent 80 à 100 % du revenu à préserver). La lacune ainsi identifiée guide la phase 3 (solution).', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'conseil_vie'
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

-- ───────── vie_klary_prevoyance_privee.json — Banque Klary — prévoyance privée VIE 75 questions. Types d'assurance vie (risque pur/mixte/capitalisation/unit-linked), 3a vs 3b, banque vs assurance, protection famille (veuve/orphelin/capital décès), lien avec accident/maladie/décès. ─────────
INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-PP-001', 'vie', t.id, 'single',
       NULL, 'Quel est le plafond du pilier 3a en 2026 pour un salarié affilié à une institution LPP ?', '[{"text":"7 258 CHF","correct":true},{"text":"6 883 CHF","correct":false,"why_wrong":"Plafond 2023, plus en vigueur."},{"text":"7 056 CHF","correct":false,"why_wrong":"Plafond 2024, plus en vigueur."},{"text":"36 288 CHF","correct":false,"why_wrong":"C''est le plafond du grand pilier 3a pour indépendant sans LPP."}]'::jsonb, 1,
       'Art. 7 al. 1 lit. a OPP 3 : petit pilier 3a pour salarié affilié LPP = 8 % de la limite supérieure du salaire coordonné (art. 8 al. 1 LPP). Montant 2026 : 7 258 CHF, intégralement déductible du revenu imposable.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'epargne'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-PP-002', 'vie', t.id, 'single',
       NULL, 'Un indépendant SANS caisse LPP peut verser dans son pilier 3a en 2026 :', '[{"text":"20 % du revenu net d''activité, maximum 36 288 CHF","correct":true},{"text":"20 % du revenu net d''activité, maximum 7 258 CHF","correct":false,"why_wrong":"Confusion avec le petit pilier 3a du salarié."},{"text":"10 % du revenu net, sans plafond","correct":false},{"text":"50 % du revenu net, maximum 100 000 CHF","correct":false}]'::jsonb, 1,
       'Art. 7 al. 1 lit. b OPP 3 : grand pilier 3a = 20 % du revenu net d''activité indépendante, plafonné à 5 fois le petit pilier 3a. 2026 : 5 × 7 258 = 36 288 CHF. Levier fiscal massif pour les indépendants à revenu élevé.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'epargne'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-PP-003', 'vie', t.id, 'multiple',
       NULL, 'Comparaison pilier 3a vs pilier 3b : quelles affirmations sont exactes ?', '[{"text":"Le pilier 3b n''a AUCUN plafond fédéral de versement","correct":true},{"text":"Le pilier 3a est déductible du revenu imposable, dans la limite du plafond","correct":true},{"text":"Les versements 3b sont déductibles du revenu imposable comme le 3a","correct":false,"why_wrong":"Faux : les versements 3b ne sont PAS déductibles au niveau fédéral. Seules quelques déductions cantonales limitées existent (Genève, Vaud)."},{"text":"Le pilier 3a est bloqué jusqu''à 5 ans avant l''âge de référence AVS","correct":true},{"text":"Le pilier 3b est librement disponible en tout temps (rachat/résiliation)","correct":true}]'::jsonb, 2,
       '3a = prévoyance liée, plafonnée et fiscalement avantageuse, mais bloquée. 3b = prévoyance libre, sans plafond ni déduction, disponible en tout temps. Art. 82 LPP et OPP 3 encadrent le 3a ; le 3b relève du droit privé (LCA/CO).', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'epargne'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-PP-004', 'vie', t.id, 'single',
       NULL, 'Un salarié affilié LPP verse 10 000 CHF sur son pilier 3a en 2026. Que se passe-t-il fiscalement ?', '[{"text":"7 258 CHF sont déductibles, l''excédent de 2 742 CHF doit être remboursé par la banque","correct":true},{"text":"10 000 CHF sont intégralement déductibles","correct":false,"why_wrong":"Faux : le plafond légal 2026 est 7 258 CHF pour un salarié."},{"text":"Rien n''est déductible car le plafond est dépassé","correct":false,"why_wrong":"La déduction reste possible jusqu''au plafond, seul l''excédent est refusé."},{"text":"10 000 CHF déductibles avec supplément d''impôt","correct":false}]'::jsonb, 2,
       'Art. 7 al. 1 lit. a OPP 3 + art. 33 al. 1 lit. e LIFD : la déduction est limitée au plafond légal (7 258 CHF en 2026). Toute somme excédentaire doit être remboursée par la fondation 3a. Contrôle systématique lors de la déclaration.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'epargne'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-PP-005', 'vie', t.id, 'multiple',
       NULL, 'Comment sont imposées les prestations en capital du pilier 3a lors du retrait ? Cochez les affirmations exactes.', '[{"text":"Elles sont imposées séparément des autres revenus, à un taux réduit (env. 1/5 du barème ordinaire)","correct":true},{"text":"Elles ne sont PAS soumises aux cotisations AVS/AI/APG","correct":true},{"text":"Elles sont imposées tant au niveau fédéral que cantonal, mais à taux réduit","correct":true},{"text":"Elles sont cumulées au revenu ordinaire pour former l''assiette imposable","correct":false,"why_wrong":"Faux : imposition séparée, pas cumulée au revenu."},{"text":"Elles sont totalement exonérées d''impôt fédéral direct","correct":false,"why_wrong":"Faux : imposition existe, mais à taux réduit."}]'::jsonb, 2,
       'Art. 38 LIFD + LHID art. 11 al. 3 : les prestations en capital de la prévoyance sont imposées séparément du revenu à un taux réduit (env. 1/5 du barème ordinaire), tant au niveau fédéral que cantonal. Pas soumises aux cotisations AVS/AI/APG (revenu de prévoyance et non d''activité).', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'epargne'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-PP-006', 'vie', t.id, 'single',
       NULL, 'Concernant les primes versées dans une police d''assurance-vie 3b à prime périodique susceptible de rachat, quelle affirmation est correcte au niveau de l''IFD ?', '[{"text":"Les primes sont déductibles du revenu comme un pilier 3a","correct":false,"why_wrong":"Faux : les primes 3b ne bénéficient pas de la déduction spéciale 3a."},{"text":"Les primes ne sont PAS déductibles du revenu imposable au niveau fédéral","correct":true},{"text":"50 % des primes sont déductibles","correct":false},{"text":"Les primes sont déductibles à hauteur de 50 % du salaire brut","correct":false}]'::jsonb, 1,
       'IFD (art. 33 al. 1 lit. g LIFD) : uniquement la déduction générale des primes d''assurance dans une limite forfaitaire (env. 1 700 CHF pour une personne seule, doublée si mariée, avec supplément par enfant). Aucune déduction spécifique 3b. Certains cantons (Genève, Vaud) offrent une déduction cantonale supplémentaire limitée.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'epargne'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-PP-007', 'vie', t.id, 'multiple',
       NULL, 'Ordre légal des bénéficiaires du pilier 3a (art. 2 OPP 3) : quelles affirmations sont exactes ?', '[{"text":"Le conjoint survivant ou le partenaire enregistré vient EN PREMIER","correct":true},{"text":"Le concubin peut être bénéficiaire à des conditions strictes (ménage commun 5 ans, enfant commun ou entretien substantiel)","correct":true},{"text":"Le titulaire peut désigner un bénéficiaire libre, comme en 3b","correct":false,"why_wrong":"Faux : le 3a suit un ORDRE LÉGAL, aucune liberté totale."},{"text":"En l''absence de conjoint et de descendants, les parents peuvent être désignés","correct":true},{"text":"Les frères et sœurs peuvent être désignés uniquement s''il n''existe ni conjoint, ni descendants, ni parents","correct":true}]'::jsonb, 2,
       'Art. 2 OPP 3, ordre imposé : 1° conjoint / partenaire enregistré ; 2° descendants + concubin qualifié + personnes à charge ; 3° parents ; 4° frères et sœurs ; 5° autres héritiers. Le titulaire peut seulement modifier la répartition à l''intérieur d''un rang.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'epargne'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-PP-008', 'vie', t.id, 'single',
       NULL, 'Dans une police d''assurance-vie 3b avec clause bénéficiaire nominative, qui désigne le titulaire de la police en cas de décès ?', '[{"text":"Toute personne librement, sans contrainte d''ordre légal","correct":true},{"text":"Uniquement le conjoint et les descendants","correct":false,"why_wrong":"Faux : c''est le régime restrictif du 3a."},{"text":"Uniquement les héritiers légaux","correct":false},{"text":"Uniquement le conjoint, avec accord notarié","correct":false}]'::jsonb, 1,
       'Art. 76-79 LCA : liberté totale de désignation dans une police 3b. Le capital-décès est versé hors succession au bénéficiaire, sous réserve de l''action en réduction (art. 476 CC) si les réserves héréditaires sont atteintes.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'epargne'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-PP-009', 'vie', t.id, 'multiple',
       NULL, 'Quels sont les motifs de retrait anticipé autorisés du pilier 3a (art. 3 al. 2 et 3 OPP 3) ?', '[{"text":"Acquisition ou construction de la résidence principale (encouragement PPE)","correct":true},{"text":"Amortissement d''un prêt hypothécaire de la résidence principale","correct":true},{"text":"Départ définitif de Suisse","correct":true},{"text":"Début d''une activité indépendante","correct":true},{"text":"Rente d''invalidité entière AI","correct":true},{"text":"Financement d''une voiture ou de vacances","correct":false,"why_wrong":"Aucun motif de consommation n''est admis."}]'::jsonb, 2,
       'Art. 3 al. 2 et 3 OPP 3 : motifs strictement limités. Retrait ordinaire dès 5 ans avant l''âge de référence AVS. Retrait anticipé possible : PPE (résidence principale), départ définitif de la Suisse, indépendance, invalidité totale (AI), décès.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'epargne'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-PP-010', 'vie', t.id, 'multiple',
       NULL, 'Concernant le rachat d''une police 3b classique (assurance-vie susceptible de rachat), quelles affirmations sont exactes ?', '[{"text":"Elle peut être rachetée en tout temps par le preneur d''assurance (art. 89-93 LCA)","correct":true},{"text":"La valeur de rachat des premières années est souvent inférieure aux primes versées (frais d''acquisition)","correct":true},{"text":"Le rachat est bloqué jusqu''à l''âge de la retraite","correct":false,"why_wrong":"Confusion avec le régime du pilier 3a."},{"text":"Le rachat est uniquement admis en cas de décès ou d''invalidité","correct":false},{"text":"Le rachat nécessite l''accord de la FINMA","correct":false}]'::jsonb, 1,
       'Art. 89-93 LCA : le preneur d''une assurance-vie 3b susceptible de rachat peut la résilier en tout temps et obtenir la valeur de rachat. Attention : dans les premières années, cette valeur reste souvent inférieure aux primes versées (frais d''acquisition, technique de zillmerisation).', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'epargne'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-PP-011', 'vie', t.id, 'multiple',
       NULL, 'Un compte 3a bancaire (sans placement) présente typiquement quelles caractéristiques ?', '[{"text":"Un taux d''intérêt variable, généralement supérieur à un compte d''épargne classique","correct":true},{"text":"Aucune couverture décès ni invalidité intégrée","correct":true},{"text":"Des frais de gestion très faibles ou nuls","correct":true},{"text":"Une souplesse totale sur les montants et la périodicité des versements (dans la limite du plafond)","correct":true},{"text":"Une garantie de capital minimum en cas de décès","correct":false,"why_wrong":"Aucune garantie décès en compte bancaire pur. Il faut une police d''assurance."}]'::jsonb, 2,
       'Compte 3a banque : véhicule d''épargne pur, ni couverture de risque, ni obligation d''alimenter chaque année. Souple, peu coûteux, mais sans garantie de capital ni protection en cas de coup dur. Peut être complété par une assurance risque pur séparée.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'epargne'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-PP-012', 'vie', t.id, 'multiple',
       NULL, 'Une police 3a d''assurance mixte comporte typiquement :', '[{"text":"Un capital garanti à l''échéance","correct":true},{"text":"Une participation aux excédents non garantie","correct":true},{"text":"Une couverture décès intégrée","correct":true},{"text":"Une libération du paiement des primes en cas d''incapacité de gain","correct":true},{"text":"Une prime annuelle contractuellement fixée, engagement pluriannuel","correct":true},{"text":"Un rendement systématiquement supérieur à un compte 3a bancaire sur 20 ans","correct":false,"why_wrong":"Les frais d''acquisition et de gestion des polices 3a sont élevés. En pratique, sur longue période, le compte bancaire (ou 3a-titres) est souvent plus rentable."}]'::jsonb, 2,
       'Police 3a assurance = épargne + couverture risque. Argument majeur : la libération de prime protège l''objectif d''épargne en cas d''incapacité. Argument à opposer : la rigidité contractuelle et les frais élevés (surtout années 1 à 5). Choix : profil et besoins du client.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'epargne'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-PP-013', 'vie', t.id, 'single',
       'Léa, 28 ans, célibataire, sans enfants, employée de commerce (salaire 78 000 CHF), souhaite commencer sa prévoyance 3a. Le conseiller lui présente une police d''assurance-vie 3a mixte avec prime annuelle de 7 000 CHF sur 37 ans.', 'Quelle est la critique principale à formuler à l''encontre de cette recommandation ?', '[{"text":"Elle n''a besoin d''aucune couverture décès ni invalidité prioritaire, un compte bancaire 3a (voire 3a-titres) serait plus flexible et moins coûteux","correct":true},{"text":"Le plafond annuel est dépassé","correct":false,"why_wrong":"Plafond 2026 = 7 258 CHF, donc 7 000 CHF est admis."},{"text":"Un célibataire ne peut pas ouvrir de police 3a","correct":false,"why_wrong":"Toute personne exerçant une activité lucrative peut ouvrir un 3a."},{"text":"L''assurance-vie 3a n''existe que pour les indépendants","correct":false}]'::jsonb, 3,
       'Devoir de conseil (art. 45 LSA + art. 44 al. 1 LSA) : la recommandation doit correspondre aux besoins. Une jeune célibataire sans charge n''a pas besoin de la protection décès intégrée. Un compte 3a bancaire (voire 3a-titres) offre plus de flexibilité, moins de frais et une meilleure rentabilité sur 37 ans.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'epargne'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-PP-014', 'vie', t.id, 'single',
       NULL, 'Un preneur résilie sa police d''assurance-vie 3a après 3 ans. Que constate-t-on typiquement au niveau de la valeur de rachat ?', '[{"text":"Elle est nettement inférieure au total des primes versées, en raison des frais d''acquisition amortis en début de contrat","correct":true},{"text":"Elle est égale à la somme des primes versées, majorée des intérêts","correct":false,"why_wrong":"Faux : les frais réduisent significativement la valeur de rachat dans les premières années."},{"text":"Elle est nulle, aucun rachat n''est possible avant 5 ans","correct":false,"why_wrong":"La police est rachetable dès qu''une valeur de rachat existe (art. 90 LCA)."},{"text":"Elle est majorée d''un bonus de sortie","correct":false}]'::jsonb, 1,
       'Frais d''acquisition (zillmerisation) : les commissions et frais d''établissement sont amortis dans les premières années. Résultat : la valeur de rachat peut être 30 à 60 % inférieure aux primes versées durant les 5 premières années. À expliciter au client (devoir d''information art. 3 LCA).', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'epargne'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-PP-015', 'vie', t.id, 'multiple',
       NULL, 'Que couvre typiquement une police d''assurance-vie 3a mixte au niveau des risques ?', '[{"text":"Le capital décès garanti à la personne bénéficiaire","correct":true},{"text":"La libération du paiement des primes en cas d''incapacité de gain durable","correct":true},{"text":"Une rente d''invalidité éventuelle si la couverture complémentaire est souscrite","correct":true},{"text":"La perte de gain immédiate en cas de maladie (IJM)","correct":false,"why_wrong":"L''IJM est une couverture distincte (LCA collective d''employeur ou individuelle), pas incluse dans une 3a."},{"text":"Les frais d''hospitalisation LAMal","correct":false,"why_wrong":"Prestations relevant de la LAMal / LCA maladie, pas de la 3a."}]'::jsonb, 2,
       'Une police 3a mixte cumule épargne + capital décès + libération de prime. La rente d''invalidité est en option. Elle ne remplace ni l''IJM (perte de gain maladie), ni la LAMal (frais médicaux). Le conseil doit clairement délimiter le périmètre des couvertures.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'epargne'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-PP-016', 'vie', t.id, 'single',
       NULL, 'Un client résilie sa police 3a avant l''échéance mais sans motif légal de retrait 3a. Que devient la valeur de rachat ?', '[{"text":"Elle doit être transférée à une autre institution 3a (compte ou police), elle NE peut PAS être versée au client","correct":true},{"text":"Elle est intégralement versée au client, imposée séparément","correct":false,"why_wrong":"Faux : sans motif légal de retrait, les fonds restent liés."},{"text":"Elle est perdue au profit de la compagnie","correct":false},{"text":"Elle est versée à moitié au client, à moitié à la fondation","correct":false}]'::jsonb, 2,
       'Art. 3 OPP 3 : le retrait n''est autorisé que pour les motifs limitativement énumérés. En cas de résiliation anticipée sans motif, la valeur de rachat doit être TRANSFÉRÉE à une autre solution 3a (compte bancaire ou police), et non versée au client.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'epargne'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-PP-017', 'vie', t.id, 'multiple',
       NULL, 'Quelles caractéristiques distinguent un compte 3a-titres (avec fonds de placement) d''un compte 3a bancaire classique ?', '[{"text":"Potentiel de rendement supérieur à long terme","correct":true},{"text":"Risque de perte en capital (pas de garantie)","correct":true},{"text":"Frais de gestion des fonds supplémentaires (TER)","correct":true},{"text":"Rendement systématiquement garanti supérieur","correct":false,"why_wrong":"Aucune garantie : la valeur peut baisser."},{"text":"Exonération fiscale totale à l''échéance","correct":false,"why_wrong":"Le régime fiscal est le même : imposition séparée à taux réduit lors du retrait."},{"text":"Une immobilisation supplémentaire de 5 ans par rapport au compte classique","correct":false}]'::jsonb, 2,
       'Le 3a-titres investit tout ou partie de l''avoir dans des fonds. Sur longue durée (> 15 ans), le rendement attendu dépasse celui du compte classique, mais le capital n''est pas garanti et les frais de fonds réduisent la performance. À réserver aux profils tolérants au risque et à horizon long.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'epargne'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-PP-018', 'vie', t.id, 'multiple',
       NULL, 'Pourquoi conseiller de répartir son 3a sur PLUSIEURS comptes ou polices ?', '[{"text":"Permet d''étaler les retraits sur plusieurs années fiscales et réduire la progressivité de l''impôt sur les prestations en capital","correct":true},{"text":"Permet de diversifier les stratégies (compte + fonds + police)","correct":true},{"text":"Permet d''augmenter le plafond annuel de versement","correct":false,"why_wrong":"Le plafond annuel s''applique à la personne, pas au compte."},{"text":"Diversifie le risque de contrepartie sur la banque / la compagnie","correct":true}]'::jsonb, 2,
       'Astuce classique : ouvrir 3 à 5 comptes 3a distincts et les vider sur 3 à 5 ans à partir de 60 ans. Chaque année : imposition séparée à taux réduit. Sur un canton comme Genève ou Vaud, l''économie fiscale cumulée peut atteindre plusieurs milliers de francs.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'epargne'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-PP-019', 'vie', t.id, 'multiple',
       NULL, 'Concernant la participation aux excédents versée dans une police d''assurance-vie, quelles affirmations sont exactes ?', '[{"text":"Elle n''est PAS garantie contractuellement","correct":true},{"text":"Elle dépend du résultat réel de la compagnie (mortalité, gestion, financier)","correct":true},{"text":"Le client doit distinguer capital garanti et prestation prévisionnelle sur participation","correct":true},{"text":"Elle est fixée contractuellement chaque année","correct":false,"why_wrong":"Seul le capital garanti est contractuel, les excédents ne le sont pas."},{"text":"Elle est régulée par la FINMA à un taux minimal annuel garanti","correct":false}]'::jsonb, 1,
       'Les excédents proviennent des trois sources techniques (risque, coûts, capital). Ils NE sont PAS garantis. Le client doit distinguer clairement, à la lecture de la proposition, la prestation garantie de la prestation prévisionnelle sur participation (art. 3 LCA, devoir d''information).', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'epargne'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-PP-020', 'vie', t.id, 'multiple',
       NULL, 'Un client demande à cumuler dans son 3a un compte bancaire ET une police d''assurance-vie 3a. Quelles affirmations sont exactes ?', '[{"text":"Le cumul est autorisé tant que le total annuel ne dépasse pas le plafond légal","correct":true},{"text":"Il peut également ouvrir un 3a-titres en parallèle chez un troisième prestataire","correct":true},{"text":"Le nombre de supports 3a n''est pas limité par la loi","correct":true},{"text":"Un seul type de 3a est autorisé par personne","correct":false,"why_wrong":"Aucune interdiction légale."},{"text":"Le cumul n''est autorisé qu''aux indépendants","correct":false},{"text":"Le cumul est possible uniquement avec deux banques distinctes","correct":false}]'::jsonb, 2,
       'La loi limite le MONTANT TOTAL versé par personne et par année (art. 7 OPP 3), pas le nombre ni la nature des supports. Un client peut parfaitement combiner un compte bancaire, un compte 3a-titres et une police d''assurance-vie 3a, à condition de respecter le plafond global.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'epargne'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-PP-021', 'vie', t.id, 'single',
       NULL, 'Un client souhaite retirer 100 000 CHF de son 2e pilier pour amortir sa résidence principale. Quel est le montant minimum admissible pour un retrait anticipé PPE ?', '[{"text":"20 000 CHF, sauf si le retrait sert à rembourser un prêt hypothécaire existant lié à des parts de coopérative","correct":true},{"text":"10 000 CHF minimum, sans exception","correct":false},{"text":"50 000 CHF minimum","correct":false},{"text":"Aucun minimum légal","correct":false,"why_wrong":"Faux : un minimum de 20 000 CHF est expressément prévu."}]'::jsonb, 2,
       'Art. 5 al. 1 OEPL : montant minimum du retrait anticipé PPE = 20 000 CHF. Exception : parts de coopérative de logement, où aucun minimum n''est requis. Objectif : éviter la fragmentation excessive de l''avoir de prévoyance.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'epargne'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-PP-022', 'vie', t.id, 'multiple',
       NULL, 'Quelles conditions doivent être remplies pour un retrait anticipé du pilier 3a pour la propriété du logement (PPE) ?', '[{"text":"Il doit s''agir de la résidence principale du titulaire (domicile)","correct":true},{"text":"Le retrait peut servir à l''acquisition, à la construction, à des transformations, ou à l''amortissement d''un prêt hypothécaire","correct":true},{"text":"Le retrait est possible pour une résidence secondaire ou de vacances","correct":false,"why_wrong":"Faux : uniquement la résidence principale."},{"text":"Le retrait est possible tous les 5 ans","correct":true},{"text":"Un retrait est possible pour financer un investissement locatif","correct":false,"why_wrong":"Faux : jamais pour un bien locatif."}]'::jsonb, 2,
       'Art. 3 al. 3 OPP 3 + art. 5 al. 1 lit. b OPP 3 : retrait PPE uniquement pour résidence principale (propriété du logement à usage personnel). Périodicité : possible tous les 5 ans. Interdiction stricte pour résidence secondaire ou investissement locatif.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'epargne'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-PP-023', 'vie', t.id, 'single',
       NULL, 'Les prestations en capital du 3a sont-elles soumises aux cotisations AVS/AI/APG ?', '[{"text":"Non, contrairement au salaire ou à une rente","correct":true},{"text":"Oui, à hauteur de 8,7 % comme un salaire","correct":false,"why_wrong":"Confusion avec les revenus d''activité."},{"text":"Oui, à hauteur de 5,3 % (part employé)","correct":false},{"text":"Uniquement au-delà de 100 000 CHF","correct":false}]'::jsonb, 1,
       'Les prestations en capital de la prévoyance (2e et 3e pilier) NE sont PAS un revenu d''activité, donc NON soumises aux cotisations AVS/AI/APG. Elles sont uniquement soumises à l''impôt sur les prestations en capital (art. 38 LIFD).', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'epargne'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-PP-024', 'vie', t.id, 'single',
       'Marc, 60 ans, marié, deux comptes 3a de 100 000 CHF chacun. Il envisage de tout retirer en une seule fois en 2026.', 'Comment optimiser fiscalement le retrait ?', '[{"text":"Étaler les retraits sur 2 années fiscales distinctes (par ex. 2026 puis 2027), un compte par année","correct":true},{"text":"Tout retirer en une seule fois en 2026, l''imposition est identique de toute façon","correct":false,"why_wrong":"Faux : plusieurs retraits la même année sont additionnés dans l''assiette de l''impôt sur les prestations en capital."},{"text":"Attendre 65 ans et tout retirer d''un coup","correct":false},{"text":"Transférer les 3a vers un 3b avant de retirer","correct":false}]'::jsonb, 3,
       'Art. 38 LIFD + jurisprudence : les prestations en capital versées la MÊME année civile sont ADDITIONNÉES pour déterminer le taux (progressivité). En les étalant sur 2 années civiles, chaque tranche est imposée à un taux moindre. Économie fiscale directe.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'epargne'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-PP-025', 'vie', t.id, 'single',
       'Simon, salarié affilié LPP, atteint 60 ans en 2026. Il souhaite retirer son 3a mais son âge de référence AVS est fixé à 65 ans.', 'À partir de quand un salarié peut-il retirer ordinairement son pilier 3a et quelle stratégie fiscale recommander ?', '[{"text":"5 ans avant l''âge de référence AVS, donc dès 60 ans, avec possibilité d''étaler les retraits sur les 5 années fiscales suivantes","correct":true},{"text":"À 55 ans, sans étalement possible","correct":false},{"text":"Uniquement à l''âge de référence AVS exact, en une seule fois","correct":false,"why_wrong":"Faux : possible dès 5 ans avant, et l''étalement est légal."},{"text":"10 ans avant l''âge de référence AVS","correct":false}]'::jsonb, 3,
       'Art. 3 al. 1 OPP 3 : les prestations 3a peuvent être versées au plus tôt cinq ans avant l''âge de référence de l''art. 21 al. 1 LAVS. Elles deviennent exigibles à l''âge de référence. Ouvrir plusieurs comptes 3a et retirer un par année (art. 38 LIFD, taux réduit) : levier fiscal reconnu.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'epargne'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-PP-026', 'vie', t.id, 'multiple',
       NULL, 'Un salarié de 66 ans continue à exercer une activité lucrative après l''âge de référence AVS. Concernant le pilier 3a, quelles affirmations sont exactes ?', '[{"text":"Il peut continuer à verser sur son 3a jusqu''à 5 ans après l''âge de référence","correct":true},{"text":"La poursuite des versements est conditionnée à l''exercice d''une activité lucrative soumise à cotisation AVS","correct":true},{"text":"Le plafond annuel reste inchangé pendant l''ajournement","correct":true},{"text":"Plus aucun versement 3a n''est possible après l''âge de référence","correct":false,"why_wrong":"Faux : l''ajournement est autorisé jusqu''à 70 ans max."},{"text":"L''ajournement est réservé aux indépendants","correct":false}]'::jsonb, 2,
       'Art. 7 al. 2 OPP 3 : ajournement du 3a possible jusqu''à 5 ans après l''âge de référence, sous condition d''exercer une activité lucrative soumise à l''AVS. Plafond identique (7 258 CHF pour salarié LPP 2026). Levier fiscal intéressant après 65 ans.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'epargne'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-PP-027', 'vie', t.id, 'multiple',
       NULL, 'Concernant la mise en gage d''un avoir de pilier 3a en garantie d''un prêt hypothécaire :', '[{"text":"Elle est admise pour l''acquisition ou l''amortissement de la résidence principale","correct":true},{"text":"Elle permet de conserver l''avoir en prévoyance tout en garantissant le crédit","correct":true},{"text":"Elle est admise pour financer une voiture","correct":false,"why_wrong":"Interdite : seule la PPE est visée."},{"text":"Elle nécessite l''accord écrit du conjoint le cas échéant","correct":true},{"text":"Elle transfère la propriété de l''avoir à la banque","correct":false,"why_wrong":"Faux : le gage n''est pas un transfert, l''avoir reste au client tant que le prêt est honoré."}]'::jsonb, 2,
       'Art. 4 OEPL applicable par renvoi à la 3a : mise en gage possible pour PPE. Différence avec le retrait : l''avoir reste investi et continue à rapporter, aucun impôt à la mise en gage. La banque n''intervient qu''en cas de défaut du client.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'epargne'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-PP-028', 'vie', t.id, 'single',
       NULL, 'Les prestations d''excédents versées par une compagnie d''assurance sur une police 3a sont-elles soumises à l''impôt anticipé LIA ?', '[{"text":"Oui, à 35 % au moment du versement, récupérable si régulièrement déclaré","correct":true},{"text":"Non, elles en sont expressément exonérées","correct":false},{"text":"Uniquement au-delà de 5 000 CHF","correct":false},{"text":"Uniquement pour les non-résidents","correct":false}]'::jsonb, 1,
       'Art. 4 al. 1 LIA : les rendements d''assurance-vie sont en principe soumis à l''impôt anticipé de 35 %, récupérable via la déclaration fiscale. Sur une police 3a la retenue LIA sur les excédents est standard, restitution après déclaration.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'epargne'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-PP-029', 'vie', t.id, 'multiple',
       NULL, 'Un titulaire 3a décède. Concernant le devenir de l''avoir, quelles affirmations sont exactes ?', '[{"text":"Il est versé aux bénéficiaires selon l''ordre légal de l''art. 2 OPP 3, hors succession","correct":true},{"text":"Il peut être pris en compte pour l''action en réduction art. 476 CC si un héritier réservataire est lésé","correct":true},{"text":"Il est soumis à l''impôt sur les prestations en capital pour le bénéficiaire (art. 38 LIFD)","correct":true},{"text":"Il tombe intégralement dans la masse successorale et est partagé par les héritiers légaux","correct":false,"why_wrong":"Faux : le 3a est versé au bénéficiaire selon l''ordre imposé."},{"text":"Il est perdu au profit de la fondation","correct":false},{"text":"Il est reversé à l''AVS","correct":false}]'::jsonb, 2,
       'Art. 2 OPP 3 : le capital 3a est attribué au bénéficiaire selon l''ordre légal, hors masse successorale au sens strict. Il peut toutefois être pris en compte pour le calcul des réserves (action en réduction art. 476 CC) si le montant lèse un héritier réservataire. Fiscalement : art. 38 LIFD, taux réduit.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'epargne'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-PP-030', 'vie', t.id, 'single',
       'Nadia, 62 ans, veuve, propriétaire de sa résidence principale (dette hypothécaire 350 000 CHF). Elle dispose de 180 000 CHF de 3a. Elle envisage d''amortir totalement son hypothèque avec son 3a.', 'Quelle est la principale objection à formuler ?', '[{"text":"L''amortissement total peut être fiscalement contre-productif : perte de la déduction des intérêts, coût d''opportunité, imposition en capital sur le retrait","correct":true},{"text":"Le 3a ne peut pas servir à amortir une dette hypothécaire existante","correct":false,"why_wrong":"Faux : c''est un motif de retrait PPE reconnu (art. 3 al. 3 OPP 3)."},{"text":"À 62 ans, le retrait ordinaire n''est pas encore possible","correct":false,"why_wrong":"5 ans avant l''âge de référence AVS, donc dès 60 ans."},{"text":"Une veuve n''a pas droit au retrait 3a","correct":false}]'::jsonb, 3,
       'Trois freins fiscaux à examiner : (1) perte de déduction des intérêts hypothécaires du revenu imposable ; (2) le retrait 3a subit l''impôt sur les prestations en capital ; (3) valeur locative maintenue même sans dette. Souvent, l''amortissement partiel + maintien d''une dette optimale est plus avantageux.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'epargne'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-PP-031', 'vie', t.id, 'single',
       NULL, 'Une assurance temporaire décès (Termfix) verse-t-elle un capital en cas de survie à l''échéance du contrat ?', '[{"text":"Non, aucune prestation n''est due si l''assuré est en vie à l''échéance","correct":true},{"text":"Oui, le total des primes versées est restitué","correct":false,"why_wrong":"Faux : c''est une assurance risque pur, aucune valeur d''épargne."},{"text":"Oui, un capital garanti est versé, comme dans une mixte","correct":false},{"text":"50 % du capital assuré est versé","correct":false}]'::jsonb, 1,
       'Assurance temporaire décès (Termfix) = risque pur. Capital versé UNIQUEMENT en cas de décès pendant la durée contractuelle. Aucune valeur d''épargne ni de rachat. Prime faible, ciblage familial (protection dettes hypothécaires, éducation enfants).', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'garantie_revenus'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-PP-032', 'vie', t.id, 'multiple',
       NULL, 'Concernant l''assurance-vie entière (vie totale), quelles affirmations sont exactes ?', '[{"text":"Le capital est versé au décès de l''assuré, quel qu''en soit le moment","correct":true},{"text":"Elle constitue une valeur de rachat croissante avec le temps","correct":true},{"text":"La prime est plus élevée qu''une temporaire décès à capital identique","correct":true},{"text":"Le capital est versé à une date fixée d''avance, même si l''assuré est en vie","correct":false,"why_wrong":"Confusion avec l''assurance mixte."},{"text":"Aucun capital n''est jamais versé si l''assuré vit au-delà de 90 ans","correct":false,"why_wrong":"Faux : le décès est certain, le capital sera versé tôt ou tard."}]'::jsonb, 1,
       'Vie entière : couverture décès à vie, sans terme fixé. Capital garanti versé au décès aux bénéficiaires. Valeur de rachat croissante. Prime plus élevée qu''une temporaire décès. Utilité : transmission patrimoniale, liquidité successorale.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'garantie_revenus'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-PP-033', 'vie', t.id, 'single',
       NULL, 'Une assurance mixte (endowment) verse le capital dans quel cas ?', '[{"text":"Au décès pendant la durée du contrat OU à l''échéance en cas de survie","correct":true},{"text":"Uniquement au décès","correct":false,"why_wrong":"Confusion avec la temporaire décès ou la vie entière."},{"text":"Uniquement en cas de survie à l''échéance","correct":false,"why_wrong":"Confusion avec la capitalisation pure."},{"text":"Uniquement en cas d''invalidité","correct":false}]'::jsonb, 1,
       'Mixte (endowment) = double garantie : capital au décès pendant la durée contractuelle OU capital à l''échéance en cas de survie. Cumule épargne et protection. Prime plus élevée. Souvent utilisée en pilier 3a.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'garantie_revenus'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-PP-034', 'vie', t.id, 'single',
       NULL, 'Une assurance de capitalisation pure se distingue de la mixte par :', '[{"text":"L''absence totale de couverture décès (épargne pure, aucune prestation-risque)","correct":true},{"text":"Une couverture décès renforcée","correct":false},{"text":"Une prime moins élevée qu''une mixte","correct":false,"why_wrong":"Piège : la capitalisation pure a effectivement des frais plus faibles, mais la caractéristique définissante est l''absence de couverture décès."},{"text":"Une durée obligatoirement viagère","correct":false}]'::jsonb, 1,
       'Capitalisation pure = véhicule d''épargne pur sans couverture décès (donc sans prime de risque). Moins utilisée que la mixte, car les banques offrent des solutions d''épargne équivalentes à moindre coût.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'garantie_revenus'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-PP-035', 'vie', t.id, 'multiple',
       NULL, 'Une assurance-vie liée à des fonds de placement (unit-linked) présente quelles caractéristiques ?', '[{"text":"La prestation à l''échéance dépend de la valeur des fonds sous-jacents choisis","correct":true},{"text":"Le capital n''est PAS garanti (sauf option de garantie spécifique)","correct":true},{"text":"Un potentiel de rendement supérieur à long terme, contre un risque de perte","correct":true},{"text":"Le rendement est garanti au taux technique annuel","correct":false,"why_wrong":"Faux : par définition, unit-linked signifie que la performance suit les fonds, non garantie."},{"text":"Le preneur d''assurance choisit ses fonds parmi une gamme proposée","correct":true}]'::jsonb, 2,
       'Unit-linked = investissement en fonds au sein d''une enveloppe assurance. Le risque de placement est supporté par le preneur. Devoir d''information renforcé (art. 3 LCA + LSFin) : profil de risque, horizon, tolérance à la perte.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'garantie_revenus'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-PP-036', 'vie', t.id, 'single',
       NULL, 'Une rente viagère immédiate est :', '[{"text":"Une rente à vie versée dès la conclusion du contrat, en contrepartie d''un capital versé en prime unique","correct":true},{"text":"Une rente qui commence 10 ans après la souscription","correct":false,"why_wrong":"Confusion avec la rente différée."},{"text":"Une rente versée sur une durée limitée","correct":false,"why_wrong":"Confusion avec la rente certaine."},{"text":"Une rente d''invalidité","correct":false}]'::jsonb, 1,
       'Rente viagère immédiate : contre prime unique, la compagnie s''engage à verser une rente à vie à l''assuré. Utile pour convertir un capital retraite en revenu régulier garanti (par ex. capital LPP retiré, héritage).', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'garantie_revenus'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-PP-037', 'vie', t.id, 'single',
       NULL, 'Une rente viagère différée se caractérise par :', '[{"text":"Une phase d''épargne avec primes périodiques, suivie d''une phase de rente à vie","correct":true},{"text":"Une prime unique et une rente immédiate","correct":false,"why_wrong":"Confusion avec la rente viagère immédiate."},{"text":"Une rente à durée limitée","correct":false},{"text":"Une rente uniquement pour orphelins","correct":false}]'::jsonb, 1,
       'Rente différée : constitution d''un capital pendant la vie active, converti en rente à un âge convenu (souvent l''âge de retraite). Alternative privée à la LPP, souvent en 3a.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'garantie_revenus'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-PP-038', 'vie', t.id, 'multiple',
       NULL, 'Une assurance dotale (études d''enfant) prévoit typiquement :', '[{"text":"Un capital versé à l''enfant à un âge fixé (18-25 ans), pour financer ses études","correct":true},{"text":"Une exemption de primes en cas de décès du parent souscripteur","correct":true},{"text":"Un capital à l''enfant même si le parent décède avant l''échéance","correct":true},{"text":"Un capital versé exclusivement en cas de décès du parent","correct":false,"why_wrong":"Faux : elle vise l''enfant à un âge précis, pas seulement le décès du parent."},{"text":"Un rachat impossible avant l''échéance","correct":false,"why_wrong":"Le rachat est possible comme toute police 3b (art. 90 LCA), avec valeur de rachat."}]'::jsonb, 2,
       'Dotale = protection ciblée du projet éducatif de l''enfant, indépendante du sort du parent grâce à l''exemption de primes. Souvent en 3b (bénéficiaire = enfant nominatif).', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'garantie_revenus'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-PP-039', 'vie', t.id, 'multiple',
       NULL, 'Avantages et inconvénients d''une assurance temporaire décès (Termfix) : quelles affirmations sont exactes ?', '[{"text":"Avantage : prime faible pour une couverture décès élevée","correct":true},{"text":"Avantage : idéale pour couvrir une dette hypothécaire pendant sa durée","correct":true},{"text":"Inconvénient : aucune valeur si l''assuré est en vie à l''échéance","correct":true},{"text":"Avantage : constitue un capital épargne à l''échéance","correct":false,"why_wrong":"Faux : aucune épargne, aucune valeur de rachat."},{"text":"Inconvénient : coût élevé identique à une vie entière","correct":false,"why_wrong":"Au contraire, la prime est nettement inférieure à celle d''une vie entière."}]'::jsonb, 2,
       'Temporaire décès = protection pure, faible coût, ciblée sur une période de risque (crédit hypothécaire, enfants à charge). Après la période, le contrat s''éteint sans contrepartie. Pertinent quand le besoin de protection est temporaire.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'garantie_revenus'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-PP-040', 'vie', t.id, 'multiple',
       NULL, 'Avantages et inconvénients d''une assurance-vie mixte : quelles affirmations sont exactes ?', '[{"text":"Avantage : cumul d''une protection décès et d''une épargne garantie à l''échéance","correct":true},{"text":"Avantage : discipline d''épargne (engagement pluriannuel)","correct":true},{"text":"Inconvénient : rendement souvent inférieur à un placement banque + assurance risque pur séparée","correct":true},{"text":"Inconvénient : peu de souplesse contractuelle (durée, primes)","correct":true},{"text":"Avantage : liquidité totale à tout moment sans coût","correct":false,"why_wrong":"Faux : le rachat anticipé entraîne une perte significative dans les premières années."}]'::jsonb, 2,
       'Mixte = solution combinée mais coûteuse. Comparaison à faire avec la stratégie ''buy term and invest the difference'' : temporaire décès + compte 3a titres, souvent plus performant sur longue durée.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'garantie_revenus'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-PP-041', 'vie', t.id, 'multiple',
       NULL, 'Avantages et inconvénients d''une assurance-vie unit-linked : quelles affirmations sont exactes ?', '[{"text":"Avantage : potentiel de rendement supérieur à long terme","correct":true},{"text":"Avantage : choix des fonds selon le profil de risque du client","correct":true},{"text":"Inconvénient : risque de perte en capital, aucune garantie sauf option spécifique","correct":true},{"text":"Inconvénient : frais internes de fonds cumulés aux frais d''assurance","correct":true},{"text":"Avantage : capital garanti à l''échéance dans tous les cas","correct":false,"why_wrong":"Faux : la garantie est facultative et payante."}]'::jsonb, 2,
       'Unit-linked = enveloppe à performance liée. Attention à la double couche de frais (assurance + fonds). Recommandé aux clients avertis, horizon long, tolérance au risque. LSFin s''applique pour l''information sur les instruments financiers.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'garantie_revenus'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-PP-042', 'vie', t.id, 'multiple',
       NULL, 'Avantages et inconvénients d''une assurance-vie entière : quelles affirmations sont exactes ?', '[{"text":"Avantage : capital garanti aux héritiers à coup sûr (le décès survient forcément)","correct":true},{"text":"Avantage : outil de transmission patrimoniale et de liquidité successorale","correct":true},{"text":"Inconvénient : prime élevée pendant toute la vie","correct":true},{"text":"Inconvénient : illiquidité, valeur de rachat < primes durant les premières années","correct":true},{"text":"Avantage : rendement garanti supérieur à un placement obligataire","correct":false,"why_wrong":"Faux : la vie entière est un produit de protection, pas de rendement."}]'::jsonb, 2,
       'Vie entière = outil successoral avant tout. Utile pour financer les droits de succession, désintéresser un héritier, protéger un concubin ou un enfant handicapé. Coût élevé, à réserver aux besoins spécifiques.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'garantie_revenus'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-PP-043', 'vie', t.id, 'multiple',
       NULL, 'Un preneur d''assurance mixte ne peut plus payer ses primes. Quelles solutions la LCA lui offre-t-elle ?', '[{"text":"La libération du paiement des primes : la police est maintenue avec un capital réduit (art. 90 al. 2 LCA)","correct":true},{"text":"Le rachat de la police avec versement de la valeur de rachat (art. 90 al. 1 LCA)","correct":true},{"text":"Résiliation d''office par la compagnie sans aucune contrepartie","correct":false,"why_wrong":"Faux : la LCA offre libération ou rachat au preneur."},{"text":"Suspension automatique et gratuite pendant 12 mois","correct":false},{"text":"Remboursement intégral des primes versées majorées d''intérêts","correct":false,"why_wrong":"Faux : seule la valeur de rachat contractuelle est due."}]'::jsonb, 1,
       'Art. 90 LCA : deux options au choix du preneur. Rachat (résiliation avec paiement de la valeur de rachat) ou libération de prime (maintien de la police avec capital réduit calculé sur les primes déjà versées). Alternative au rachat, préférable si le besoin de protection subsiste.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'garantie_revenus'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-PP-044', 'vie', t.id, 'multiple',
       NULL, 'La participation aux excédents servie sur une police d''assurance-vie provient de quelles sources techniques ?', '[{"text":"Excédent de risque (mortalité effective < mortalité attendue)","correct":true},{"text":"Excédent de coûts (frais réels < frais chargés)","correct":true},{"text":"Excédent financier (rendement > taux technique garanti)","correct":true},{"text":"Chiffre d''affaires publicitaire de la compagnie","correct":false,"why_wrong":"Aucun lien avec les excédents techniques."},{"text":"Bénéfice sur les opérations non-vie","correct":false,"why_wrong":"Les excédents vie proviennent des opérations vie uniquement."}]'::jsonb, 1,
       'Trois piliers techniques : excédent de risque (mortalité effective < mortalité attendue), excédent de coûts (frais réels < frais chargés), excédent financier (rendement > taux technique). Non garantis, dépendent des résultats effectifs de la compagnie.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'garantie_revenus'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-PP-045', 'vie', t.id, 'single',
       'Yann verse 100 000 CHF en prime unique dans une assurance-vie 3b. Il rachète la police après 3 ans avec une valeur de rachat de 108 000 CHF.', 'Comment est imposé le gain de 8 000 CHF au niveau de l''IFD ?', '[{"text":"Les 8 000 CHF sont imposés comme revenu, car la police à prime unique est rachetée avant 5 ans (art. 20 al. 1 lit. a LIFD)","correct":true},{"text":"Aucune imposition, le gain est un revenu du capital exonéré","correct":false,"why_wrong":"Piège classique : l''exonération ne s''applique qu''à certaines conditions (durée, âge)."},{"text":"Uniquement 50 % du gain est imposé","correct":false},{"text":"Imposition au taux réduit des prestations en capital","correct":false}]'::jsonb, 3,
       'Art. 20 al. 1 lit. a LIFD : les prestations en capital d''assurances-vie à prime unique susceptibles de rachat sont imposables comme revenu si le contrat est racheté avant 5 ans OU si le preneur a moins de 60 ans à l''échéance. Piège fréquent en conseil : anticiper l''incidence fiscale.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'garantie_revenus'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-PP-046', 'vie', t.id, 'multiple',
       NULL, 'Concernant la rente de veuve du 1er pilier (AVS), quelles conditions doivent être remplies ?', '[{"text":"La veuve a des enfants (à charge), sans condition d''âge ni de durée de mariage","correct":true},{"text":"La veuve sans enfant : mariage de 5 ans au moins ET veuve d''au moins 45 ans révolus","correct":true},{"text":"La rente de veuve est versée à vie ou jusqu''au remariage","correct":true},{"text":"Aucune condition, toute veuve a automatiquement droit à la rente","correct":false,"why_wrong":"Faux : conditions strictes d''âge et de mariage."},{"text":"La rente est de 100 % de la rente AVS du défunt","correct":false,"why_wrong":"Faux : 80 % de la rente de vieillesse du défunt."}]'::jsonb, 2,
       'Art. 23 LAVS : rente de veuve = 80 % de la rente de vieillesse. Conditions : (a) enfants à charge OU (b) sans enfant : mariage min 5 ans + veuvage à 45 ans+. S''éteint en cas de remariage (art. 23 al. 4 LAVS).', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'garantie_revenus'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-PP-047', 'vie', t.id, 'single',
       NULL, 'Jusqu''à quel âge est versée la rente d''orphelin AVS ?', '[{"text":"18 ans, ou 25 ans si l''enfant poursuit une formation","correct":true},{"text":"16 ans dans tous les cas","correct":false,"why_wrong":"Confusion possible avec l''obligation d''entretien de l''ancien droit."},{"text":"20 ans dans tous les cas","correct":false},{"text":"Jusqu''au mariage de l''orphelin","correct":false}]'::jsonb, 1,
       'Art. 25 al. 5 LAVS : rente d''orphelin versée jusqu''à 18 ans, prolongée jusqu''à 25 ans si l''orphelin est en formation. Montant : 40 % de la rente de vieillesse (60 % si double orphelin).', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'garantie_revenus'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-PP-048', 'vie', t.id, 'single',
       NULL, 'Concernant la rente de veuf du 1er pilier AVS, quelle est la situation légale (avant l''harmonisation en cours) ?', '[{"text":"Le veuf n''a droit à la rente que s''il a des enfants mineurs à charge ; la rente s''éteint à la majorité du dernier enfant","correct":true},{"text":"Le veuf est traité comme la veuve, à vie","correct":false,"why_wrong":"Inégalité de traitement reconnue par la CEDH, une réforme est en cours mais pas encore en vigueur pour la génération actuelle."},{"text":"Le veuf n''a aucun droit AVS","correct":false},{"text":"Le veuf reçoit uniquement une rente de 3 ans","correct":false}]'::jsonb, 2,
       'Art. 24 LAVS : rente de veuf uniquement pour enfants mineurs à charge, extinction à la majorité du dernier enfant. Arrêt CEDH Beeler c. Suisse (2022) et projet en cours d''harmonisation homme/femme. Enseigner l''état actuel + mentionner la réforme.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'garantie_revenus'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-PP-049', 'vie', t.id, 'multiple',
       'L''assuré marié décède en activité. La caisse doit déterminer les prestations dues à ses proches selon la LPP obligatoire.', 'Prestations LPP en cas de décès de l''assuré actif, quelles rentes prévoit la loi ?', '[{"text":"Rente de conjoint survivant (art. 19 LPP)","correct":true},{"text":"Rente d''orphelin par enfant (art. 20 LPP)","correct":true},{"text":"Rente pour partenaire enregistré, assimilé au conjoint (art. 19 al. 3 LPP)","correct":true},{"text":"Rente pour concubin, sans condition supplémentaire","correct":false,"why_wrong":"Faux : le concubin n''a droit à une rente que si le règlement de la caisse le prévoit et sous conditions (art. 20a LPP)."},{"text":"Rente pour parents à charge, dans tous les cas","correct":false,"why_wrong":"Uniquement dans le cadre facultatif art. 20a LPP si le règlement le prévoit."}]'::jsonb, 3,
       'LPP obligatoire : rente conjoint (60 % rente inv.), rente orphelin (20 % rente inv. par enfant). Le partenaire enregistré est assimilé (art. 19 al. 3 LPP). Le concubin doit être expressément prévu par le règlement de la caisse (art. 20a LPP).', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'garantie_revenus'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-PP-050', 'vie', t.id, 'single',
       NULL, 'Un salarié décède, laissant conjoint + 2 enfants mineurs. Quelle rente LPP obligatoire par enfant orphelin ?', '[{"text":"20 % de la rente d''invalidité du défunt","correct":true},{"text":"40 % de la rente d''invalidité","correct":false,"why_wrong":"Confusion avec l''AVS (rente orphelin = 40 % rente vieillesse défunt)."},{"text":"10 %","correct":false},{"text":"60 %","correct":false,"why_wrong":"Confusion avec la rente de conjoint LPP."}]'::jsonb, 2,
       'Art. 21 LPP : rente d''orphelin LPP obligatoire = 20 % de la rente d''invalidité présumée du défunt, par enfant. La rente de conjoint est de 60 %. Cumul possible avec 1er pilier.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'garantie_revenus'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-PP-051', 'vie', t.id, 'multiple',
       NULL, 'À quelles conditions un concubin peut-il être bénéficiaire d''une rente LPP (art. 20a LPP) ?', '[{"text":"Le règlement de la caisse de pensions doit expressément prévoir la couverture des concubins","correct":true},{"text":"Le concubin doit avoir été soutenu de manière substantielle par le défunt","correct":true},{"text":"OU le concubin doit avoir vécu en ménage commun avec le défunt durant les 5 dernières années au moins avant le décès","correct":true},{"text":"OU le concubin doit assumer l''entretien d''un enfant commun","correct":true},{"text":"La désignation du concubin doit avoir été communiquée par écrit à la caisse de pensions","correct":true},{"text":"Aucune formalité n''est nécessaire, le lien de fait suffit","correct":false,"why_wrong":"Faux : la déclaration écrite est indispensable pour valoir désignation."}]'::jsonb, 3,
       'Art. 20a LPP : possibilité facultative. Trois conditions cumulatives : règlement le prévoit, situation matérielle admise (soutien, ménage 5 ans, ou enfant commun), déclaration écrite. À vérifier systématiquement pour les concubins lors de l''analyse.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'garantie_revenus'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-PP-052', 'vie', t.id, 'single',
       'Couple marié, 2 enfants (8 et 12 ans). Époux salarié, revenu net 90 000 CHF, dette hypothécaire 500 000 CHF. Rente veuve AVS + LPP estimée à 55 000 CHF / an.', 'Quel capital-décès complémentaire suggérer pour couvrir la lacune familiale ?', '[{"text":"Environ 500 000 CHF (dettes) + 300 000 CHF (5 ans de coussin famille + éducation enfants), soit env. 800 000 CHF à ajuster selon situation","correct":true},{"text":"50 000 CHF, la LPP couvre déjà tout","correct":false,"why_wrong":"Faux : la lacune de revenu et la dette hypothécaire justifient un capital significatif."},{"text":"Uniquement l''amortissement de la dette hypothécaire (500 000 CHF)","correct":false,"why_wrong":"Incomplet : ne couvre pas les besoins courants et l''éducation."},{"text":"Aucun capital n''est nécessaire","correct":false}]'::jsonb, 3,
       'Approche standard : (1) dettes à amortir (hypothèque, crédits) + (2) coussin financier veuve 5-10 ans (revenu manquant × durée) + (3) provisions éducation enfants jusqu''à autonomie. Total à ajuster selon patrimoine existant, 3a/LPP éventuellement retirés en capital.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'garantie_revenus'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-PP-053', 'vie', t.id, 'single',
       NULL, 'Le capital d''un pilier 3a est versé au décès du titulaire :', '[{"text":"Aux bénéficiaires selon l''ordre légal de l''art. 2 OPP 3, hors succession","correct":true},{"text":"Uniquement au conjoint, jamais aux enfants","correct":false,"why_wrong":"Les descendants viennent en 2e rang après le conjoint."},{"text":"Uniquement aux héritiers réservataires","correct":false},{"text":"Uniquement à la personne désignée par testament","correct":false,"why_wrong":"Faux : c''est l''ordre légal 3a qui s''applique, pas le testament."}]'::jsonb, 1,
       'Art. 2 OPP 3 : le capital 3a est versé hors succession selon l''ordre imposé. Argument fort de conseil : le 3a permet la transmission rapide et directe au conjoint (1er rang), contournant les délais successoraux.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'garantie_revenus'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-PP-054', 'vie', t.id, 'multiple',
       NULL, 'Concernant le capital-décès d''une police d''assurance-vie 3b avec clause bénéficiaire nominative, quelles affirmations sont exactes ?', '[{"text":"Il est versé directement au bénéficiaire désigné, hors masse successorale (art. 76-79 LCA)","correct":true},{"text":"Il peut faire l''objet d''une action en réduction si les réserves héréditaires sont atteintes (art. 476 CC)","correct":true},{"text":"Le titulaire peut modifier la clause bénéficiaire à tout moment (art. 77 LCA)","correct":true},{"text":"Il entre systématiquement dans la masse successorale et est partagé entre héritiers","correct":false,"why_wrong":"Faux : la désignation nominative permet le versement direct hors succession."},{"text":"Il est bloqué jusqu''à la clôture officielle de la succession","correct":false},{"text":"Il est reversé à l''AVS","correct":false}]'::jsonb, 2,
       'Art. 76-79 LCA : versement direct au bénéficiaire nominatif, hors succession. Clause révocable en tout temps par le preneur. Toutefois, art. 476 CC : les héritiers réservataires peuvent agir en réduction si la désignation a porté atteinte à leur réserve. À anticiper dans le conseil.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'garantie_revenus'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-PP-055', 'vie', t.id, 'single',
       NULL, 'Quel est le délai de prescription de l''action en réduction des héritiers réservataires (art. 533 CC) ?', '[{"text":"1 an dès la connaissance de la lésion, 10 ans au maximum dès l''ouverture de la succession","correct":true},{"text":"5 ans dès le décès, sans autre délai","correct":false},{"text":"30 ans, comme pour la revendication successorale","correct":false},{"text":"6 mois seulement","correct":false}]'::jsonb, 1,
       'Art. 533 CC : action en réduction se prescrit par 1 an dès que l''héritier a connu la lésion de sa réserve, dans tous les cas 10 ans dès la publication du testament (ou l''ouverture de la succession pour dispositions non testamentaires). Délai court : à rappeler au client.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'garantie_revenus'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-PP-056', 'vie', t.id, 'multiple',
       NULL, 'Concernant le choix entre rente et capital LPP à la retraite (art. 37 LPP), quelles affirmations sont exactes ?', '[{"text":"Le retrait sous forme de capital du régime obligatoire est un droit d''au moins 25 % du capital","correct":true},{"text":"Le règlement de caisse peut autoriser le retrait à 100 % en capital","correct":true},{"text":"Le retrait en capital doit être demandé dans un délai prévu par le règlement (souvent 3 ans avant la retraite)","correct":true},{"text":"Un salarié marié doit obtenir l''accord écrit de son conjoint pour un retrait en capital","correct":true},{"text":"Le capital est imposé comme un revenu ordinaire progressif","correct":false,"why_wrong":"Faux : imposition séparée à taux réduit (art. 38 LIFD)."}]'::jsonb, 2,
       'Art. 37 al. 2 LPP : minimum 25 % du capital retirable. Art. 37 al. 5 LPP : accord écrit du conjoint obligatoire. Formalités du règlement à respecter (délai de préavis). Effet fiscal : capital = taux réduit ponctuel, rente = imposition annuelle ordinaire.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'retraite'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-PP-057', 'vie', t.id, 'single',
       NULL, 'Comment sont imposées les rentes LPP versées à la retraite ?', '[{"text":"À 100 %, comme revenu ordinaire (art. 22 LIFD)","correct":true},{"text":"À 40 %, comme les rentes viagères privées","correct":false,"why_wrong":"Confusion avec les rentes viagères privées (art. 22 al. 3 LIFD)."},{"text":"À un taux réduit séparé","correct":false,"why_wrong":"Confusion avec le capital LPP."},{"text":"Exonérées d''IFD","correct":false}]'::jsonb, 1,
       'Art. 22 al. 1 LIFD : les rentes de la prévoyance professionnelle sont imposables intégralement comme revenu ordinaire. Contrairement au capital (taux réduit art. 38 LIFD) et à la rente viagère privée (40 % art. 22 al. 3 LIFD).', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'retraite'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-PP-058', 'vie', t.id, 'multiple',
       NULL, 'Concernant l''imposition du capital LPP retiré à la retraite, quelles affirmations sont exactes ?', '[{"text":"Il est imposé séparément des autres revenus (art. 38 LIFD)","correct":true},{"text":"À un taux réduit (env. 1/5 du barème ordinaire)","correct":true},{"text":"Le même régime s''applique au niveau cantonal (LHID art. 11 al. 3)","correct":true},{"text":"Il est imposé à 100 %, cumulé au revenu ordinaire","correct":false,"why_wrong":"Faux : imposition séparée à taux réduit."},{"text":"Il est totalement exonéré d''impôt fédéral direct","correct":false}]'::jsonb, 1,
       'Art. 38 LIFD : imposition séparée à un taux réduit. Idem au niveau cantonal (LHID art. 11 al. 3). Effet : la sortie en capital est ponctuellement lourde mais évite l''imposition à vie des rentes.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'retraite'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-PP-059', 'vie', t.id, 'multiple',
       NULL, 'Avantages du choix de la rente LPP à la retraite :', '[{"text":"Sécurité viagère : revenu garanti à vie, indépendamment de la longévité","correct":true},{"text":"Rente de survivant automatique au conjoint (60 % de la rente en général)","correct":true},{"text":"Aucune gestion financière à assurer par le retraité","correct":true},{"text":"Transmission intégrale du capital aux héritiers en cas de décès","correct":false,"why_wrong":"Faux : à l''inverse, le capital ''restant'' est perdu (hors rente survivant limitée)."},{"text":"Liberté d''utiliser le capital pour investir","correct":false,"why_wrong":"Faux : le capital est converti en rente irrévocable."}]'::jsonb, 2,
       'Rente LPP = protection viagère et automatisation. Idéal pour profils prudents, sans compétence de gestion, mariés. Inconvénient : capital ''perdu'' pour les héritiers au décès (hors rente conjoint réduite).', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'retraite'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-PP-060', 'vie', t.id, 'multiple',
       NULL, 'Avantages du choix du capital LPP à la retraite :', '[{"text":"Liberté totale d''utilisation (immobilier, placement, projets)","correct":true},{"text":"Transmission du capital aux héritiers en cas de décès","correct":true},{"text":"Imposition unique à taux réduit, pas d''imposition récurrente sur la rente","correct":true},{"text":"Le capital est garanti à vie sans risque de placement","correct":false,"why_wrong":"Faux : le retraité assume seul le risque de longévité et de placement."},{"text":"Sécurité viagère automatique","correct":false,"why_wrong":"Faux : c''est l''avantage de la rente, pas du capital."}]'::jsonb, 2,
       'Capital LPP = liberté, transmission, taux réduit. Risque : longévité (survivre à son capital), gestion, placement. À réserver aux profils avertis, patrimoine diversifié, souhait de transmission.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'retraite'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-PP-061', 'vie', t.id, 'single',
       'Sylvie, 63 ans, célibataire, veut partir à la retraite à 65 ans avec 700 000 CHF LPP. Ses charges mensuelles sont 4 500 CHF, sa rente AVS estimée à 2 400 CHF/mois, sa rente LPP intégrale à 3 100 CHF/mois. Elle craint la longévité (mère décédée à 96 ans).', 'Quelle recommandation de retrait LPP privilégier ?', '[{"text":"Prendre principalement la rente (pour sécuriser le minimum vital viager) et sortir une partie limitée en capital pour projets et réserve d''urgence","correct":true},{"text":"Prendre 100 % en capital, la stratégie financière produira une rente équivalente","correct":false,"why_wrong":"Risque de longévité élevé (mère 96 ans) et absence de conjoint pour rente survivant : la rente sécurise mieux."},{"text":"Prendre 100 % en rente, aucune sortie en capital","correct":false,"why_wrong":"Trop rigide : aucune réserve pour projets ou dépenses imprévues."},{"text":"Renoncer aux prestations et laisser à la caisse","correct":false}]'::jsonb, 3,
       'Profil célibataire + espérance de vie élevée + charges fixes couvertes = argument fort pour la rente. Un complément en capital (25 % minimum art. 37 LPP) offre la souplesse pour projets ou dépenses ponctuelles. Sortir 100 % en capital reporte le risque de longévité sur le retraité seul.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'retraite'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-PP-062', 'vie', t.id, 'single',
       NULL, 'Un salarié dispose de 5 comptes 3a et souhaite optimiser fiscalement le retrait à la retraite. Que faire ?', '[{"text":"Retirer un compte par année civile sur 5 ans, avant l''âge de référence AVS","correct":true},{"text":"Tout retirer en une seule fois, la fiscalité est linéaire","correct":false,"why_wrong":"Faux : l''impôt est progressif, cumul dans la même année pénalise."},{"text":"Attendre l''âge de référence pour tout retirer","correct":false},{"text":"Transférer tous les 3a en 3b avant retrait","correct":false}]'::jsonb, 2,
       'Retrait ordinaire dès 5 ans avant l''âge de référence AVS. Étalement sur 5 années civiles distinctes = 5 impositions séparées à taux réduit (art. 38 LIFD). Le cumul dans la même année déclenche la progressivité (jurisprudence constante).', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'retraite'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-PP-063', 'vie', t.id, 'single',
       NULL, 'Une rente viagère ''avec restitution'' se distingue par :', '[{"text":"En cas de décès prématuré, le capital restant (ou une partie) est versé aux héritiers désignés","correct":true},{"text":"La rente est restituée à la compagnie chaque année","correct":false,"why_wrong":"Contresens."},{"text":"La rente est garantie à 100 % du capital versé","correct":false},{"text":"La rente est indexée à l''inflation","correct":false}]'::jsonb, 2,
       'Rente viagère avec restitution : protection contre le décès prématuré. Le capital non consommé est restitué aux héritiers. Contrepartie : rente périodique inférieure à celle d''une rente sans restitution.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'retraite'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-PP-064', 'vie', t.id, 'single',
       NULL, 'Une rente viagère ''sans restitution'' présente quelle particularité ?', '[{"text":"En cas de décès, aucun capital n''est restitué aux héritiers (la compagnie conserve le solde)","correct":true},{"text":"La rente cesse au bout de 10 ans","correct":false,"why_wrong":"Confusion avec la rente certaine."},{"text":"Elle inclut une rente de survivant automatique","correct":false},{"text":"Le capital est intégralement restitué au décès","correct":false,"why_wrong":"Faux : c''est la version ''avec restitution''."}]'::jsonb, 1,
       'Rente sans restitution : taux de rente supérieur, mais aucun héritage au décès. Choix adapté aux personnes seules, sans héritier à protéger, cherchant à maximiser le revenu périodique.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'retraite'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-PP-065', 'vie', t.id, 'single',
       NULL, 'Une rente viagère ''certaine'' garantit le versement de la rente :', '[{"text":"Pendant une durée minimum fixée (par ex. 10 ans), même si l''assuré décède plus tôt","correct":true},{"text":"À vie sans aucune condition","correct":false,"why_wrong":"Toutes les rentes viagères sont à vie ; la ''certaine'' ajoute une durée minimum garantie."},{"text":"Uniquement en cas d''invalidité","correct":false},{"text":"Uniquement pour les femmes","correct":false}]'::jsonb, 1,
       'Rente certaine (ou ''à annuités garanties'') : la rente est due au minimum pendant X années (souvent 5, 10, 15 ans), même en cas de décès. Après cette période, elle continue à vie si l''assuré vit. Compromis entre rente pure et restitution.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'retraite'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-PP-066', 'vie', t.id, 'single',
       NULL, 'Comment est imposée fiscalement une rente viagère privée (3b) au niveau de l''IFD ?', '[{"text":"40 % de la rente est imposée comme revenu (art. 22 al. 3 LIFD)","correct":true},{"text":"100 % de la rente est imposée comme revenu","correct":false,"why_wrong":"C''est la règle pour les rentes AVS/LPP, pas pour les rentes viagères privées."},{"text":"La rente est exonérée d''IFD","correct":false},{"text":"Uniquement les excédents sont imposés","correct":false}]'::jsonb, 1,
       'Art. 22 al. 3 LIFD : les rentes viagères privées sont imposées à 40 % du montant versé. Les 60 % restants sont considérés comme un remboursement de capital (donc non imposables). Avantage fiscal notable par rapport aux rentes LPP.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'retraite'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-PP-067', 'vie', t.id, 'multiple',
       NULL, 'Concernant la rente viagère indexée à l''inflation, quelles affirmations sont exactes ?', '[{"text":"Son montant augmente chaque année selon un indice défini","correct":true},{"text":"Elle démarre à un niveau initial plus bas qu''une rente non indexée à prime équivalente","correct":true},{"text":"Elle offre une protection contre l''érosion monétaire à long terme","correct":true},{"text":"Elle est systématiquement moins chère qu''une rente non indexée","correct":false,"why_wrong":"Inverse : à prime unique équivalente, elle offre une rente initiale plus faible."},{"text":"Elle est garantie à 5 % d''augmentation par an","correct":false},{"text":"Elle n''existe qu''en 1er pilier","correct":false}]'::jsonb, 1,
       'Rente indexée : protection contre l''érosion monétaire à long terme. Contrepartie : rente initiale plus faible à prime équivalente. Rarement souscrite car coût élevé et concurrence des placements en fonds.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'retraite'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-PP-068', 'vie', t.id, 'multiple',
       NULL, 'Une assurance-vie mixte 3a peut être utilisée comme complément retraite. Quelles affirmations sont exactes ?', '[{"text":"L''échéance est fixée à l''âge de référence, le capital complète le revenu AVS + LPP","correct":true},{"text":"Le versement des primes durant la vie active est déductible du revenu (dans les limites du plafond 3a)","correct":true},{"text":"Le capital échéance est imposé séparément à taux réduit (art. 38 LIFD)","correct":true},{"text":"L''échéance doit être fixée avant 40 ans","correct":false,"why_wrong":"L''objectif retraite implique une échéance à la retraite."},{"text":"Elle est obligatoirement à prime unique","correct":false},{"text":"Elle est réservée aux indépendants","correct":false}]'::jsonb, 2,
       'Mixte 3a échéance retraite (par ex. 65 ans) : capital garanti + participation excédents servent de complément au revenu de retraite. Avantage fiscal 3a : déduction des versements, taux réduit à la sortie (art. 33 al. 1 lit. e + 38 LIFD).', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'retraite'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-PP-069', 'vie', t.id, 'single',
       NULL, 'Selon l''art. 40 LAVS, un assuré peut anticiper le versement de sa rente AVS :', '[{"text":"D''un ou deux ans (voire au mois près depuis AVS 21), avec réduction actuarielle de la rente","correct":true},{"text":"De 5 ans, sans réduction","correct":false,"why_wrong":"Faux : max 2 ans, avec réduction."},{"text":"Uniquement pour les cas d''invalidité","correct":false},{"text":"Uniquement pour les femmes","correct":false}]'::jsonb, 2,
       'Art. 40 LAVS (nouvelle teneur AVS 21) : anticipation possible sur 1 ou 2 ans (au mois près), réduction actuarielle (env. 6,8 % par année anticipée pour les revenus élevés, taux transitoires plus favorables pour les femmes 1961-1969). Rente réduite à vie.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'retraite'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-PP-070', 'vie', t.id, 'single',
       NULL, 'Selon l''art. 39 LAVS, l''ajournement de la rente AVS peut se faire :', '[{"text":"D''un à cinq ans, avec majoration actuarielle (env. 5,2 % à 31,5 %)","correct":true},{"text":"De 10 ans avec majoration doublée","correct":false,"why_wrong":"Max 5 ans."},{"text":"Sans limite de temps","correct":false},{"text":"Uniquement en cas de poursuite d''activité","correct":false,"why_wrong":"L''ajournement n''exige pas la poursuite d''activité, mais elle est fréquente."}]'::jsonb, 2,
       'Art. 39 LAVS : ajournement de 1 à 5 ans, majoration actuarielle allant de 5,2 % (1 an) à 31,5 % (5 ans). Rente majorée à vie. Pertinent pour les retraités en bonne santé, à espérance de vie élevée, avec autres revenus disponibles pendant l''ajournement.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'retraite'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-PP-071', 'vie', t.id, 'multiple',
       NULL, 'Avantages et inconvénients de l''anticipation de la rente AVS :', '[{"text":"Avantage : rente plus tôt, utile en cas de fin d''activité forcée ou souhaitée","correct":true},{"text":"Avantage : plus d''années de perception si espérance de vie limitée","correct":true},{"text":"Inconvénient : rente réduite à vie","correct":true},{"text":"Inconvénient : cotisation AVS obligatoire jusqu''à l''âge de référence sur les revenus d''activité subsistants","correct":true},{"text":"Avantage : capital versé en plus","correct":false,"why_wrong":"Faux : l''AVS ne verse jamais un capital, uniquement une rente."}]'::jsonb, 2,
       'Anticiper = compromis. Utile si santé fragile, revenu suffisant sinon, cessation d''activité. Attention : la réduction est PERMANENTE, la rente ne remonte pas à l''âge de référence. Cotisation AVS due jusqu''à l''âge de référence (art. 4 LAVS).', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'retraite'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-PP-072', 'vie', t.id, 'multiple',
       NULL, 'Avantages et inconvénients de l''ajournement de la rente AVS :', '[{"text":"Avantage : rente majorée à vie (jusqu''à +31,5 %)","correct":true},{"text":"Avantage : diminue l''impôt sur le revenu pendant les années d''ajournement","correct":true},{"text":"Inconvénient : moins d''années de perception (risque de décès prématuré)","correct":true},{"text":"Inconvénient : nécessite d''autres ressources pendant l''ajournement","correct":true},{"text":"Avantage : rente rétroactivement doublée après l''ajournement","correct":false,"why_wrong":"Faux : la majoration est actuarielle, pas rétroactive."}]'::jsonb, 2,
       'Ajourner = pari sur la longévité. Recommandé aux profils en bonne santé, revenus alternatifs disponibles, patrimoine suffisant. Point mort actuariel : env. 80 ans. Au-delà : rentabilité positive.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'retraite'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-PP-073', 'vie', t.id, 'single',
       'Sophie, 52 ans, cadre supérieur (revenu imposable 180 000 CHF). Son certificat LPP indique une lacune de rachat maximale de 90 000 CHF. Elle envisage un rachat de 30 000 CHF cette année.', 'Un assuré peut effectuer des rachats facultatifs dans sa LPP (art. 79b LPP). Quelle est la principale conséquence fiscale à mettre en avant dans le conseil ?', '[{"text":"Les rachats sont intégralement déductibles du revenu imposable dans l''année du versement","correct":true},{"text":"Les rachats sont soumis à l''impôt anticipé de 35 %","correct":false},{"text":"Les rachats sont uniquement déductibles à 50 %","correct":false},{"text":"Les rachats sont non déductibles mais génèrent un bonus fiscal à la retraite","correct":false}]'::jsonb, 3,
       'Art. 79b LPP + art. 33 al. 1 lit. d LIFD : les rachats facultatifs LPP sont intégralement déductibles du revenu imposable. Levier fiscal massif pour les hauts revenus. Bien planifier avec le certificat LPP annuel (lacune de prévoyance chiffrée).', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'retraite'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-PP-074', 'vie', t.id, 'single',
       'Julien, 58 ans, effectue un rachat facultatif LPP de 50 000 CHF en 2026, déduit fiscalement. Il envisage de retirer 200 000 CHF de LPP en capital lors de son départ anticipé en 2028 (60 ans).', 'Quelle est la principale règle à connaître (art. 79b al. 3 LPP) ?', '[{"text":"Le retrait en capital dans les 3 ans suivant un rachat est FISCALEMENT contesté et entraîne la reprise de la déduction","correct":true},{"text":"Le retrait en capital est libre 12 mois après le rachat","correct":false,"why_wrong":"Faux : le délai légal est de 3 ans."},{"text":"Aucune restriction ne s''applique","correct":false,"why_wrong":"Faux : art. 79b al. 3 LPP fixe une restriction de 3 ans."},{"text":"Le rachat doit être remboursé avant tout retrait en capital","correct":false}]'::jsonb, 3,
       'Art. 79b al. 3 LPP : les prestations en capital résultant d''un rachat ne peuvent être versées avant 3 ans, sinon la déduction fiscale est reprise (arrêt TF 2C_658/2009). Timing du rachat vs retrait à planifier avec précision.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'retraite'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-PP-075', 'vie', t.id, 'single',
       NULL, 'Un salarié qui continue à travailler après l''âge de référence AVS peut-il continuer à cotiser à sa LPP ?', '[{"text":"Oui, jusqu''à 5 ans après l''âge de référence si le règlement de caisse le prévoit (art. 33b LPP)","correct":true},{"text":"Non, plus aucune cotisation LPP après l''âge de référence","correct":false,"why_wrong":"Faux : art. 33b LPP autorise la poursuite jusqu''à 70 ans."},{"text":"Uniquement pour les indépendants","correct":false},{"text":"Uniquement avec l''accord de la FINMA","correct":false}]'::jsonb, 2,
       'Art. 33b LPP : poursuite facultative des cotisations LPP jusqu''à 5 ans après l''âge de référence (soit 70 ans pour les hommes et femmes après AVS 21) si le règlement de la caisse l''autorise. Levier fiscal complémentaire pour les seniors actifs.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'retraite'
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

-- 485 question(s) traitée(s).
