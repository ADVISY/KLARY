-- ═════════════════════════════════════════════════════════
-- Klary — Seed des questions AFA
-- FICHIER GÉNÉRÉ — ne pas éditer à la main.
-- Source : src/content/afa/*.json
-- Régénérer : node scripts/afa/generate-seed.mjs
-- ═════════════════════════════════════════════════════════

-- ───────── generales_klary_bank.json — Banque Klary GÉNÉRALES (PV1) 120 questions. Socle commun tous profils : industrie assurance, droit CO/LCA/LSA/nLPD/LBA/LSFin, acquisition et vente, litiges et procédures. ─────────
INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-GEN-IN-001', 'generales', t.id, 'single',
       NULL, 'Quelle autorité surveille les entreprises d''assurance privées en Suisse ?', '[{"text":"L''ASA (Association Suisse d''Assurances)","correct":false,"why_wrong":"L''ASA est une organisation faîtière, pas un régulateur."},{"text":"La FINMA (Autorité fédérale de surveillance des marchés financiers)","correct":true},{"text":"L''OFAS (Office fédéral des assurances sociales)","correct":false,"why_wrong":"L''OFAS surveille les assurances sociales (AVS, AI, LPP), pas les assureurs privés."},{"text":"Le SECO","correct":false,"why_wrong":"Le SECO est le Secrétariat d''État à l''économie, sans compétence de surveillance des assureurs."}]'::jsonb, 1,
       'Art. 1 et 46 LSA : la FINMA surveille les entreprises d''assurance privées. Piège classique : ne pas confondre avec l''ASA (faîtière) ni avec l''OFAS (assurances sociales).', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'generales' AND t.key = 'industrie'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-GEN-IN-002', 'generales', t.id, 'single',
       NULL, 'L''ASA (Association Suisse d''Assurances) est :', '[{"text":"Une autorité de surveillance dotée de pouvoirs de sanction","correct":false,"why_wrong":"L''ASA n''a aucun pouvoir de sanction ; les sanctions relèvent de la FINMA."},{"text":"Une organisation faîtière de la branche, sans compétence étatique","correct":true},{"text":"Une caisse de compensation fédérale","correct":false,"why_wrong":"Les caisses de compensation gèrent l''AVS/AI, cela n''a rien à voir avec l''ASA."},{"text":"Une autorité de conciliation obligatoire","correct":false,"why_wrong":"La conciliation relève de l''Ombudsman, pas de l''ASA."}]'::jsonb, 1,
       'L''ASA est l''organisation faîtière des assureurs privés suisses (auto-régulation, statistiques, formation VBV). Elle n''a aucun pouvoir régulatoire : la surveillance relève de la FINMA (LSA).', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'generales' AND t.key = 'industrie'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-GEN-IN-003', 'generales', t.id, 'single',
       NULL, 'L''intervention de l''Ombudsman de l''assurance privée et de la SUVA est :', '[{"text":"Payante, à hauteur de 200 CHF par dossier","correct":false,"why_wrong":"Le service est gratuit pour le consommateur."},{"text":"Gratuite pour le client et non contraignante pour l''assureur","correct":true},{"text":"Gratuite et impose une décision opposable à l''assureur","correct":false,"why_wrong":"PIÈGE MAJEUR : l''Ombudsman ne rend pas de décision opposable."},{"text":"Réservée aux courtiers","correct":false,"why_wrong":"L''Ombudsman est ouvert à tout consommateur d''assurance."}]'::jsonb, 1,
       'L''Ombudsman est gratuit et sa position n''a pas de force exécutoire : il joue un rôle de médiation. Piège récurrent : confusion avec un jugement.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'generales' AND t.key = 'industrie'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-GEN-IN-004', 'generales', t.id, 'multiple',
       NULL, 'Quelles formes juridiques sont autorisées pour une entreprise d''assurance opérant en Suisse ? (art. 7 LSA)', '[{"text":"Société anonyme (SA)","correct":true},{"text":"Société coopérative","correct":true},{"text":"Société en nom collectif","correct":false,"why_wrong":"Exclue par l''art. 7 LSA : responsabilité personnelle incompatible avec la surveillance prudentielle."},{"text":"Entreprise individuelle","correct":false,"why_wrong":"Exclue par la LSA."},{"text":"Succursale d''assureur étranger dûment autorisée","correct":true},{"text":"Association","correct":false,"why_wrong":"L''association au sens du CC ne fait pas partie des formes admises par la LSA."}]'::jsonb, 2,
       'Art. 7 LSA : SA, coopérative, ou succursale d''assureur étranger autorisée. Les autres formes sont exclues (contrôle prudentiel exige capital et structure adéquats).', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'generales' AND t.key = 'industrie'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-GEN-IN-005', 'generales', t.id, 'multiple',
       NULL, 'Quelle loi régit le contrat d''assurance privée conclu entre un assureur et son client ?', '[{"text":"La LCA (Loi sur le contrat d''assurance)","correct":true},{"text":"Le CO à titre subsidiaire (art. 100 al. 1 LCA)","correct":true},{"text":"La LSA (surveillance, mais pas le contrat lui-même)","correct":false,"why_wrong":"La LSA régit la surveillance des assureurs, pas la relation contractuelle avec le client."},{"text":"La LAMal exclusivement","correct":false,"why_wrong":"La LAMal ne régit que l''assurance-maladie sociale obligatoire."},{"text":"Le CP","correct":false,"why_wrong":"Le code pénal ne régit pas la relation contractuelle."}]'::jsonb, 1,
       'La LCA (loi fédérale sur le contrat d''assurance) régit la relation contractuelle assureur/preneur. La LSA régit la surveillance ; le CO est subsidiaire (art. 100 LCA).', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'generales' AND t.key = 'industrie'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-GEN-IN-006', 'generales', t.id, 'single',
       NULL, 'Le principe de l''aléa dans le contrat d''assurance signifie que :', '[{"text":"L''assureur choisit librement les risques qu''il couvre","correct":false,"why_wrong":"Cela relève de la politique de souscription, pas de la définition de l''aléa."},{"text":"La survenance ou la date du sinistre est incertaine au moment de la conclusion","correct":true},{"text":"L''assureur est certain de réaliser un bénéfice","correct":false,"why_wrong":"Notion opposée à l''aléa."},{"text":"Le preneur peut modifier les conditions à tout moment","correct":false,"why_wrong":"Faux : les modifications passent par avenant écrit."}]'::jsonb, 1,
       'Le contrat d''assurance est un contrat aléatoire : les parties ne peuvent pas savoir à la conclusion si, quand ou dans quelle mesure la prestation sera due. Sans aléa (sinistre déjà survenu ou certain) : nullité.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'generales' AND t.key = 'industrie'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-GEN-IN-007', 'generales', t.id, 'multiple',
       NULL, 'Le principe de mutualité en assurance repose sur :', '[{"text":"La mise en commun des primes d''un grand nombre d''assurés exposés à un même risque","correct":true},{"text":"La compensation des sinistres de quelques-uns par les primes de tous","correct":true},{"text":"La loi des grands nombres pour rendre les charges prévisibles","correct":true},{"text":"L''obligation pour chaque assuré de subir le même dommage","correct":false,"why_wrong":"La mutualité ne suppose pas l''identité des dommages, mais la communauté de risque."},{"text":"La garantie de l''État sur les prestations","correct":false,"why_wrong":"L''État ne garantit pas les prestations des assureurs privés."}]'::jsonb, 2,
       'Mutualité = communauté de risque + loi des grands nombres. Les primes du collectif financent les sinistres individuels ; c''est le fondement technique de l''assurance.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'generales' AND t.key = 'industrie'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-GEN-IN-008', 'generales', t.id, 'single',
       NULL, 'Quelle différence essentielle sépare une assurance de sommes (forfaitaire) d''une assurance de dommages (indemnitaire) ?', '[{"text":"L''assurance de dommages verse un montant fixé à l''avance ; l''assurance de sommes rembourse le dommage réel","correct":false,"why_wrong":"Définitions inversées."},{"text":"L''assurance de sommes verse un capital ou une rente convenus ; l''assurance de dommages indemnise le préjudice effectif dans la limite de la somme assurée","correct":true},{"text":"Les deux types imposent une expertise obligatoire du dommage","correct":false,"why_wrong":"L''expertise n''est requise qu''en assurance de dommages selon le cas."},{"text":"L''assurance de sommes est interdite en Suisse","correct":false,"why_wrong":"Elle est parfaitement admise (assurance-vie notamment)."}]'::jsonb, 2,
       'Assurance de sommes (vie, invalidité forfaitaire) : prestation prédéfinie, principe indemnitaire non applicable. Assurance de dommages (ménage, RC, casco) : art. 96 LCA, principe indemnitaire, pas d''enrichissement possible.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'generales' AND t.key = 'industrie'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-GEN-IN-009', 'generales', t.id, 'single',
       NULL, 'Le régime prudentiel applicable aux assureurs suisses est :', '[{"text":"Solvency II (directive UE)","correct":false,"why_wrong":"Solvency II est le régime européen. La Suisse applique son propre modèle."},{"text":"Le Test suisse de solvabilité (SST), fondé sur les risques","correct":true},{"text":"Les accords de Bâle III","correct":false,"why_wrong":"Bâle III concerne les banques, pas les assureurs."},{"text":"La loi COVID d''urgence","correct":false,"why_wrong":"Aucun régime prudentiel n''a été instauré par la loi COVID."}]'::jsonb, 2,
       'Le SST (Swiss Solvency Test) est le régime prudentiel des assureurs suisses depuis 2011, reconnu équivalent à Solvency II par l''UE. Bâle est le régime bancaire.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'generales' AND t.key = 'industrie'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-GEN-IN-010', 'generales', t.id, 'multiple',
       NULL, 'L''OFAS (Office fédéral des assurances sociales) est responsable de la surveillance de quelles branches ?', '[{"text":"AVS / AI","correct":true},{"text":"APG (allocation pour perte de gain)","correct":true},{"text":"Allocations familiales","correct":true},{"text":"Assurances-vie privées","correct":false,"why_wrong":"Compétence FINMA."},{"text":"LPP (prévoyance professionnelle : haute surveillance)","correct":true},{"text":"Assurances complémentaires LCA","correct":false,"why_wrong":"Compétence FINMA."}]'::jsonb, 2,
       'L''OFAS surveille les assurances sociales fédérales (AVS, AI, APG, allocations familiales) et exerce la haute surveillance sur la LPP. L''assurance privée relève de la FINMA (LSA).', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'generales' AND t.key = 'industrie'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-GEN-IN-011', 'generales', t.id, 'single',
       NULL, 'Selon l''art. 40 LSA (nouveau droit), quels intermédiaires doivent obligatoirement s''inscrire au registre FINMA ?', '[{"text":"Tous les intermédiaires, liés et non liés","correct":false,"why_wrong":"Depuis la révision LSA 2024, seuls les non liés s''inscrivent au registre."},{"text":"Uniquement les intermédiaires non liés (courtiers indépendants)","correct":true},{"text":"Uniquement les intermédiaires liés (agents)","correct":false,"why_wrong":"Les liés sont rattachés à leur assureur qui répond de leur activité."},{"text":"Seulement les intermédiaires exerçant à l''étranger","correct":false,"why_wrong":"Le critère est le rattachement ou non, pas le lieu d''exercice."}]'::jsonb, 1,
       'Art. 40 al. 2 et 41 LSA (révision entrée en vigueur 01.01.2024) : seuls les intermédiaires NON liés doivent être inscrits au registre FINMA. Les liés sont couverts par la responsabilité de l''assureur.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'generales' AND t.key = 'industrie'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-GEN-IN-012', 'generales', t.id, 'single',
       NULL, 'Le Fonds national suisse de garantie (BNG) intervient pour :', '[{"text":"Indemniser les victimes de véhicules non identifiés, non assurés ou volés","correct":true},{"text":"Garantir les rentes LPP en cas de faillite d''une caisse","correct":false,"why_wrong":"C''est le rôle du Fonds de garantie LPP (art. 56 LPP)."},{"text":"Compenser les catastrophes naturelles pour les propriétaires","correct":false,"why_wrong":"C''est le pool ECA/ES cantonaux."},{"text":"Rembourser les primes en cas de faillite d''un assureur maladie","correct":false,"why_wrong":"Il existe un institut commun LAMal (art. 18 LAMal), pas le BNG."}]'::jsonb, 1,
       'Art. 76 LCR : le Fonds national suisse de garantie (BNG) indemnise les victimes de véhicules non identifiés, non assurés ou volés. À ne pas confondre avec le Fonds de garantie LPP.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'generales' AND t.key = 'industrie'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-GEN-IN-013', 'generales', t.id, 'multiple',
       NULL, 'Quels éléments sont indispensables à la validité d''un contrat d''assurance selon la LCA ?', '[{"text":"Un risque assurable (aléa)","correct":true},{"text":"Une prime convenue","correct":true},{"text":"Une prestation d''assurance définie","correct":true},{"text":"L''approbation préalable de la FINMA pour chaque police","correct":false,"why_wrong":"La FINMA n''approuve pas les polices individuelles ; elle approuve certains produits (LAA-C) et surveille l''entreprise."},{"text":"Un intérêt assurable pour les assurances de dommages","correct":true},{"text":"La signature d''un notaire","correct":false,"why_wrong":"Aucune forme authentique n''est exigée."}]'::jsonb, 2,
       'Éléments constitutifs : aléa, prime, prestation, intérêt assurable (pour les assurances de dommages, art. 48 LCA). Le contrat est consensuel (pas de forme authentique requise).', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'generales' AND t.key = 'industrie'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-GEN-IN-014', 'generales', t.id, 'single',
       'Un dirigeant de PME vous demande qui surveille son assurance-maladie complémentaire (LCA), sa LAA obligatoire et sa caisse LPP.', 'Quelle réponse est correcte concernant les autorités compétentes ?', '[{"text":"FINMA pour les trois","correct":false,"why_wrong":"FINMA ne surveille pas la LAA ni la LPP directement."},{"text":"OFAS pour les trois","correct":false,"why_wrong":"OFAS ne surveille pas la LCA."},{"text":"FINMA pour la LCA complémentaire, OFSP/SUVA pour la LAA, OFAS + autorités cantonales pour la LPP","correct":true},{"text":"Le Conseil fédéral pour les trois","correct":false,"why_wrong":"Le Conseil fédéral légifère mais ne surveille pas les assureurs individuellement."}]'::jsonb, 2,
       'Répartition : FINMA (assurances privées LCA, LSA) ; SUVA + OFSP pour la LAA ; OFAS haute surveillance LPP + autorités cantonales de surveillance directe (art. 61 LPP).', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'generales' AND t.key = 'industrie'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-GEN-IN-015', 'generales', t.id, 'single',
       NULL, 'Le système suisse de prévoyance est structuré autour de :', '[{"text":"1 pilier unique (AVS)","correct":false,"why_wrong":"La Suisse est structurée sur trois piliers, non un seul."},{"text":"2 piliers (AVS + LPP)","correct":false,"why_wrong":"Le 3e pilier est également un pilier officiel du système (Cst. art. 111)."},{"text":"3 piliers : prévoyance étatique, professionnelle, individuelle","correct":true},{"text":"4 piliers incluant les allocations familiales","correct":false,"why_wrong":"Les allocations familiales sont un régime social, pas un pilier de prévoyance."}]'::jsonb, 1,
       'Cst. art. 111 : système des trois piliers. 1er pilier AVS/AI/PC (couverture minimum vitale), 2e pilier LPP (maintien du niveau de vie), 3e pilier (prévoyance individuelle 3a/3b).', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'generales' AND t.key = 'industrie'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-GEN-IN-016', 'generales', t.id, 'multiple',
       'Vous préparez un support pédagogique interne pour de nouveaux conseillers qui confondent AVS/LAA (obligatoires) avec les complémentaires LCA.', 'Quelles caractéristiques distinguent l''assurance sociale de l''assurance privée ?', '[{"text":"L''assurance sociale est en principe obligatoire (LAMal, AVS, LAA)","correct":true},{"text":"L''assurance privée repose sur la liberté contractuelle et la LCA","correct":true},{"text":"L''assurance sociale utilise la solidarité (redistribution), pas seulement la mutualité","correct":true},{"text":"L''assurance privée impose un tarif unique fixé par l''État","correct":false,"why_wrong":"L''assureur privé fixe librement sa tarification (approbation FINMA pour certaines branches)."},{"text":"L''assurance sociale peut refuser un affilié pour antécédents","correct":false,"why_wrong":"Interdit : pas de sélection dans l''AOS."}]'::jsonb, 3,
       'Assurance sociale : loi impérative, obligation d''affiliation, solidarité redistributive. Assurance privée : consensuelle (LCA), sélection possible, tarification technique.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'generales' AND t.key = 'industrie'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-GEN-IN-017', 'generales', t.id, 'single',
       NULL, 'Dans une compagnie d''assurance de forme mutualiste ou coopérative :', '[{"text":"Les preneurs sont en même temps sociétaires","correct":true},{"text":"Les primes sont fixées par l''État","correct":false,"why_wrong":"Faux : l''assureur mutualiste fixe ses tarifs sous surveillance FINMA."},{"text":"Il n''existe aucune obligation de constituer un capital","correct":false,"why_wrong":"La LSA exige un capital / fonds de garantie."},{"text":"L''entreprise ne peut couvrir que la LAMal","correct":false,"why_wrong":"Aucune restriction de branche liée à la forme mutualiste."}]'::jsonb, 1,
       'Dans une coopérative (art. 828 CO) ou mutuelle, les assurés participent à la vie sociale (assemblée générale, ristournes possibles). L''excédent peut être redistribué. Reste soumise à la LSA.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'generales' AND t.key = 'industrie'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-GEN-IN-018', 'generales', t.id, 'single',
       NULL, 'Dans une société coopérative d''assurance (art. 828 CO), le principe démocratique est :', '[{"text":"Une voix par part sociale détenue","correct":false,"why_wrong":"Piège : c''est le principe SA (art. 692 CO)."},{"text":"Une voix par sociétaire, indépendamment du nombre de parts","correct":true},{"text":"Vote pondéré par la prime versée","correct":false,"why_wrong":"Aucun système de vote pondéré par la prime dans la coopérative."},{"text":"Absence de droit de vote","correct":false,"why_wrong":"Le sociétaire dispose d''un droit de vote (une voix)."}]'::jsonb, 2,
       'Art. 885 CO : dans la coopérative, chaque sociétaire a une seule voix, quel que soit le nombre de parts. Différence structurante avec la SA (art. 692 CO : vote au capital).', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'generales' AND t.key = 'industrie'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-GEN-IN-019', 'generales', t.id, 'multiple',
       NULL, 'Le rôle de la réassurance est :', '[{"text":"Permettre à l''assureur de transférer une partie de ses risques à un autre assureur","correct":true},{"text":"Mutualiser les grands sinistres (catastrophes, cumuls)","correct":true},{"text":"Augmenter la capacité de souscription de l''assureur primaire","correct":true},{"text":"Remplacer l''assurance directe auprès du client final","correct":false,"why_wrong":"La réassurance n''intervient jamais avec le client final."},{"text":"Fixer les tarifs pour toute la branche","correct":false,"why_wrong":"Aucun réassureur ne fixe les tarifs de la branche primaire."}]'::jsonb, 1,
       'La réassurance est un contrat entre assureurs : elle permet la mutualisation des grands risques (catastrophes, cumuls) et l''accès à des capacités additionnelles. Aucune relation avec l''assuré final.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'generales' AND t.key = 'industrie'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-GEN-IN-020', 'generales', t.id, 'single',
       'Un client hésite entre s''assurer chez une société anonyme cotée et chez une coopérative d''assurance.', 'Quelle information objective devez-vous lui donner ?', '[{"text":"La SA est toujours meilleur marché","correct":false,"why_wrong":"Aucune règle générale ; dépend du produit et du portefeuille."},{"text":"La coopérative peut redistribuer un excédent à ses sociétaires-preneurs, la SA verse des dividendes à ses actionnaires","correct":true},{"text":"Seule la SA est surveillée par la FINMA","correct":false,"why_wrong":"Les deux formes sont surveillées par la FINMA."},{"text":"La coopérative n''a pas besoin de capital de départ","correct":false,"why_wrong":"Un fonds de garantie est requis par la LSA."}]'::jsonb, 2,
       'Différence structurelle : SA = orientation actionnaires ; coopérative = orientation sociétaires (excédents distribuables aux preneurs). Les deux relèvent de la surveillance FINMA (LSA).', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'generales' AND t.key = 'industrie'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-GEN-IN-021', 'generales', t.id, 'multiple',
       NULL, 'Quelles missions relèvent de la FINMA (LFINMA / LSA) ?', '[{"text":"Octroyer et retirer l''autorisation d''exercer aux assureurs","correct":true},{"text":"Approuver certains tarifs (LAA complémentaire, prévoyance obligatoire)","correct":true},{"text":"Contrôler la solvabilité (SST) et les provisions techniques","correct":true},{"text":"Fixer les rentes AVS","correct":false,"why_wrong":"Compétence Conseil fédéral / OFAS."},{"text":"Sanctionner un intermédiaire non lié inscrit au registre","correct":true},{"text":"Négocier les CCT de la branche","correct":false,"why_wrong":"Compétence des partenaires sociaux."}]'::jsonb, 2,
       'La FINMA est l''autorité de surveillance intégrée : autorisation, surveillance prudentielle (SST), approbation de certains tarifs, sanction des intermédiaires inscrits (LFINMA + LSA).', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'generales' AND t.key = 'industrie'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-GEN-IN-022', 'generales', t.id, 'single',
       NULL, 'Une prise de position de l''Ombudsman de l''assurance privée a pour effet juridique :', '[{"text":"Force exécutoire immédiate","correct":false,"why_wrong":"PIÈGE : aucune force exécutoire."},{"text":"Une recommandation, sans caractère contraignant pour l''assureur","correct":true},{"text":"Un jugement susceptible d''appel","correct":false,"why_wrong":"L''Ombudsman n''est pas un tribunal."},{"text":"Une amende automatique en cas de refus","correct":false,"why_wrong":"L''Ombudsman ne dispose d''aucun pouvoir d''amende."}]'::jsonb, 1,
       'La prise de position de l''Ombudsman est une recommandation. L''assuré conserve toujours la voie civile (art. 46b LCA). Point souvent testé à l''AFA.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'generales' AND t.key = 'industrie'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-GEN-IN-023', 'generales', t.id, 'single',
       'Une compagnie d''assurance suisse veut lancer un nouveau produit d''assurance-vie liée à des placements (unit-linked) destiné à la clientèle privée. Elle vous demande quelles autorités et quels régimes s''appliquent avant le lancement.', 'Quel enchaînement est correct ?', '[{"text":"Approbation systématique préalable de chaque police par la FINMA","correct":false,"why_wrong":"Depuis la réforme LSA, l''approbation systématique des tarifs a été largement supprimée."},{"text":"Notification/approbation prudentielle FINMA de la solution technique, respect de la LCA pour le contrat, respect de la LSFin pour la distribution du volet instrument financier, respect nLPD sur les données","correct":true},{"text":"Uniquement respect de la LCA, sans autre régime","correct":false,"why_wrong":"Un produit unit-linked touche à la LSFin (information/adéquation) et à la nLPD."},{"text":"Autorisation cantonale préalable pour chaque canton de commercialisation","correct":false,"why_wrong":"La surveillance est fédérale (FINMA)."}]'::jsonb, 3,
       'Un produit vie-placement mobilise plusieurs régimes : LSA (surveillance FINMA), LCA (contrat), LSFin (règles de conduite pour l''instrument financier, adéquation), nLPD (traitement des données). Vision transversale attendue du conseiller.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'generales' AND t.key = 'industrie'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-GEN-IN-024', 'generales', t.id, 'multiple',
       NULL, 'Un événement est assurable s''il est :', '[{"text":"L''événement doit être aléatoire","correct":true},{"text":"L''événement doit être futur","correct":true},{"text":"L''événement doit être licite (art. 20 CO)","correct":true},{"text":"L''événement doit être évaluable en argent","correct":true},{"text":"L''événement doit être certain et déjà survenu","correct":false,"why_wrong":"Contrat nul faute d''aléa."},{"text":"L''événement doit être voulu par le preneur","correct":false,"why_wrong":"La volonté détruirait l''aléa."}]'::jsonb, 1,
       'Critères de l''assurabilité : aléatoire (aléa), futur, licite (art. 20 CO), évaluable en argent. Un événement déjà survenu ou provoqué intentionnellement n''est pas assurable (art. 9 LCA ancien / dispositions LCA).', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'generales' AND t.key = 'industrie'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-GEN-IN-025', 'generales', t.id, 'multiple',
       'Un client structure son patrimoine et demande une vue globale de toutes ses branches, sociales et privées, pour éviter les doublons.', 'Parmi les branches d''assurance ci-dessous, lesquelles appartiennent aux assurances non-vie ?', '[{"text":"Assurance ménage","correct":true},{"text":"Assurance RC véhicule (LCR)","correct":true},{"text":"Assurance-vie mixte","correct":false,"why_wrong":"Branche vie."},{"text":"Assurance protection juridique","correct":true},{"text":"3e pilier a","correct":false,"why_wrong":"Branche vie (prévoyance)."},{"text":"Assurance perte d''exploitation PME","correct":true}]'::jsonb, 3,
       'Non-vie : dommages aux choses, RC, PJ, transport, technique. Vie : capital ou rente lié à la personne (vie, décès, invalidité forfaitaire). Cette distinction structure la surveillance FINMA.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'generales' AND t.key = 'industrie'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-GEN-IN-026', 'generales', t.id, 'multiple',
       NULL, 'Le principe indemnitaire (art. 96 LCA) s''oppose :', '[{"text":"Il interdit l''enrichissement de l''assuré","correct":true},{"text":"Il plafonne la prestation au dommage effectivement subi","correct":true},{"text":"Il justifie la subrogation de l''assureur (art. 95c LCA)","correct":true},{"text":"Il s''oppose à la mutualisation","correct":false,"why_wrong":"Aucune opposition : la mutualisation est en amont, l''indemnitaire en aval."},{"text":"Il s''applique à l''assurance-vie de sommes","correct":false,"why_wrong":"Non : l''assurance de sommes échappe au principe indemnitaire."}]'::jsonb, 2,
       'Principe indemnitaire : dans les assurances de dommages, la prestation est limitée au préjudice réel. Pas de double indemnisation, subrogation de l''assureur (art. 95c LCA).', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'generales' AND t.key = 'industrie'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-GEN-IN-027', 'generales', t.id, 'single',
       NULL, 'Le marché suisse de l''assurance privée se caractérise notamment par :', '[{"text":"Un très faible taux de pénétration (< 1 %)","correct":false,"why_wrong":"La Suisse est parmi les pays au monde à la plus forte pénétration."},{"text":"Une des plus fortes densités de primes par habitant au monde","correct":true},{"text":"Un monopole d''État sur toutes les branches","correct":false,"why_wrong":"Marché ouvert ; seules certaines branches cantonales (ECA) fonctionnent en monopole."},{"text":"Une interdiction des assureurs étrangers","correct":false,"why_wrong":"Les succursales étrangères sont admises (art. 15 LSA)."}]'::jsonb, 1,
       'La Suisse figure structurellement parmi les tout premiers marchés au monde en primes par habitant (vie + non-vie). Marché ouvert, régulé par la FINMA.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'generales' AND t.key = 'industrie'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-GEN-IN-028', 'generales', t.id, 'single',
       'Une entreprise d''assurance holding détient plusieurs filiales suisses (vie, non-vie, réassurance). Elle vous demande comment la FINMA la surveille.', 'Quelle affirmation est correcte ?', '[{"text":"Chaque filiale est surveillée séparément sans coordination","correct":false,"why_wrong":"Contraire à la surveillance de groupe (art. 65 ss LSA)."},{"text":"La FINMA exerce une surveillance sur base individuelle ET une surveillance de groupe consolidée (SST groupe)","correct":true},{"text":"Seul le siège étranger est surveillé","correct":false,"why_wrong":"Faux : la FINMA surveille les entités suisses même si maison mère est à l''étranger."},{"text":"La surveillance est déléguée à l''ASA","correct":false,"why_wrong":"L''ASA n''est pas un régulateur."}]'::jsonb, 3,
       'Art. 65-79 LSA : la FINMA exerce une surveillance individuelle (chaque entité) ET une surveillance de groupe / conglomérat (solvabilité consolidée, gouvernance, gestion des risques). Vise à empêcher un défaut par contagion.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'generales' AND t.key = 'industrie'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-GEN-IN-029', 'generales', t.id, 'single',
       NULL, 'Quelle différence existe entre risque et aléa dans le vocabulaire de l''assurance ?', '[{"text":"Ce sont deux synonymes stricts","correct":false,"why_wrong":"Distinction technique importante."},{"text":"Le risque est l''événement redouté (incendie, décès) ; l''aléa est l''incertitude qui affecte sa survenance ou sa date","correct":true},{"text":"Le risque est certain ; l''aléa est facultatif","correct":false,"why_wrong":"Le risque est justement soumis à l''aléa."},{"text":"Le risque relève du preneur, l''aléa de l''assureur exclusivement","correct":false}]'::jsonb, 2,
       'Risque = l''événement dommageable objet de la couverture. Aléa = caractère incertain de sa survenance. Sans aléa, pas de contrat d''assurance valable.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'generales' AND t.key = 'industrie'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-GEN-IN-030', 'generales', t.id, 'multiple',
       NULL, 'L''auto-régulation de la branche par l''ASA se manifeste notamment par :', '[{"text":"Des règles déontologiques (code de conduite)","correct":true},{"text":"La formation VBV / AFA des intermédiaires","correct":true},{"text":"La publication de statistiques et données de marché","correct":true},{"text":"Des amendes prononcées contre les compagnies","correct":false,"why_wrong":"Seule la FINMA sanctionne (art. 30 ss LFINMA)."},{"text":"Le retrait d''autorisation d''un assureur","correct":false,"why_wrong":"Compétence exclusive de la FINMA."}]'::jsonb, 2,
       'L''ASA est faîtière : code de conduite, formation VBV / AFA, statistiques, lobbying. Aucune compétence de sanction : c''est la FINMA (LFINMA / LSA).', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'generales' AND t.key = 'industrie'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-GEN-DR-001', 'generales', t.id, 'single',
       NULL, 'Depuis quand le nouveau droit LCA (révision majeure) est-il en vigueur ?', '[{"text":"1er janvier 2020","correct":false,"why_wrong":"Aucune révision majeure LCA n''est entrée en vigueur en 2020."},{"text":"1er janvier 2022","correct":true},{"text":"1er septembre 2023","correct":false,"why_wrong":"Confusion avec la nLPD."},{"text":"1er janvier 2024","correct":false,"why_wrong":"Confusion avec la révision LSA."}]'::jsonb, 1,
       'La révision majeure de la LCA (droit de révocation art. 2a, prescription 5 ans art. 46, résiliation ordinaire art. 35a etc.) est en vigueur depuis le 01.01.2022.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'generales' AND t.key = 'droit'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-GEN-DR-002', 'generales', t.id, 'single',
       NULL, 'Quel est le délai de révocation d''une proposition d''assurance selon l''art. 2a LCA ?', '[{"text":"7 jours","correct":false,"why_wrong":"Ce délai ne correspond à aucune disposition LCA."},{"text":"14 jours","correct":true},{"text":"30 jours","correct":false,"why_wrong":"PIÈGE fréquent : ce n''est pas 30 jours."},{"text":"2 mois","correct":false,"why_wrong":"Ancienne durée avant réforme, régulièrement citée par erreur."}]'::jsonb, 1,
       'Art. 2a LCA : le preneur peut révoquer sa proposition ou l''acceptation par écrit dans les 14 jours dès sa connaissance de la conclusion. Piège classique VBV.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'generales' AND t.key = 'droit'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-GEN-DR-003', 'generales', t.id, 'single',
       NULL, 'Quel est le délai de prescription des créances découlant du contrat d''assurance selon l''art. 46 LCA (nouveau droit) ?', '[{"text":"1 an","correct":false,"why_wrong":"Aucun délai LCA n''est fixé à 1 an pour la prescription."},{"text":"2 ans","correct":false,"why_wrong":"Ancien délai avant 2022, régulièrement confondu."},{"text":"5 ans dès la survenance du fait générateur","correct":true},{"text":"10 ans","correct":false,"why_wrong":"C''est le délai ordinaire CO 127, mais la LCA est spéciale."}]'::jsonb, 1,
       'Art. 46 LCA (révision 2022) : les créances découlant du contrat d''assurance se prescrivent par 5 ans dès la survenance du fait sur lequel elles reposent. Avant 2022 : 2 ans.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'generales' AND t.key = 'droit'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-GEN-DR-004', 'generales', t.id, 'multiple',
       NULL, 'Le devoir d''information de l''assureur selon l''art. 3 LCA porte notamment sur :', '[{"text":"L''identité de l''assureur","correct":true},{"text":"L''étendue de la couverture et les exclusions principales","correct":true},{"text":"Les primes et autres obligations du preneur","correct":true},{"text":"Le délai et la forme de résiliation","correct":true},{"text":"Uniquement au moment de la signature, puis plus jamais","correct":false,"why_wrong":"PIÈGE : le devoir d''information est continu pendant toute la durée du contrat."},{"text":"Le traitement des données personnelles","correct":true}]'::jsonb, 2,
       'Art. 3 LCA : information précontractuelle ET continue. Piège classique : croire que l''obligation s''éteint à la signature. Elle perdure pour toute la vie du contrat.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'generales' AND t.key = 'droit'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-GEN-DR-005', 'generales', t.id, 'multiple',
       NULL, 'En cas de réticence (déclaration inexacte ou omission dans le questionnaire de santé), l''assureur peut :', '[{"text":"Résilier le contrat dans les 4 semaines dès la connaissance","correct":true},{"text":"Refuser les prestations liées au fait tu","correct":true},{"text":"Résilier à tout moment sans délai","correct":false,"why_wrong":"La loi impose un délai de 4 semaines."},{"text":"Uniquement diminuer la prime","correct":false,"why_wrong":"La sanction n''est pas une baisse de prime."},{"text":"Rien : la réticence n''a plus d''effet sous le nouveau droit","correct":false,"why_wrong":"La réticence reste sanctionnée par l''art. 6 LCA."}]'::jsonb, 1,
       'Art. 6 LCA : en cas de réticence, l''assureur peut résilier dans les 4 semaines dès qu''il a eu connaissance de la réticence. La libération de prestation vaut pour les sinistres en lien avec le fait tu.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'generales' AND t.key = 'droit'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-GEN-DR-006', 'generales', t.id, 'multiple',
       NULL, 'Quelles conditions cumulatives sont exigées pour qu''une responsabilité civile délictuelle soit engagée selon l''art. 41 CO ?', '[{"text":"Un acte illicite","correct":true},{"text":"Une faute (ou une responsabilité causale légale)","correct":true},{"text":"Un dommage","correct":true},{"text":"Un lien de causalité adéquate","correct":true},{"text":"Un contrat entre auteur et lésé","correct":false,"why_wrong":"C''est la RC contractuelle (art. 97 CO), pas l''art. 41."},{"text":"Une décision pénale préalable","correct":false,"why_wrong":"La condamnation pénale n''est pas nécessaire."}]'::jsonb, 1,
       'Art. 41 CO : conditions cumulatives de la RC délictuelle : acte illicite, faute (ou responsabilité causale légale), dommage, lien de causalité adéquate. Si l''une manque : pas de responsabilité.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'generales' AND t.key = 'droit'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-GEN-DR-007', 'generales', t.id, 'multiple',
       NULL, 'Selon l''art. 45 LSA (obligations d''information et de conduite du conseiller), l''intermédiaire doit remettre au client :', '[{"text":"Son identité et son adresse professionnelle","correct":true},{"text":"Sa qualité (intermédiaire lié ou non lié) et les assureurs qu''il représente","correct":true},{"text":"L''existence de liens contractuels avec des assureurs et sa rémunération de principe","correct":true},{"text":"L''autorité compétente pour les plaintes (Ombudsman)","correct":true},{"text":"Le rendement financier annuel de sa société","correct":false,"why_wrong":"Aucune obligation d''information sur le rendement propre du conseiller."},{"text":"Le nom de tous ses autres clients","correct":false,"why_wrong":"Interdit par le secret professionnel et la nLPD."}]'::jsonb, 2,
       'Art. 45 LSA + OS : la fiche d''information client (FIC) précise identité, statut (lié/non lié), assureurs, rémunération, voies de réclamation. Remise obligatoire lors du premier contact.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'generales' AND t.key = 'droit'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-GEN-DR-008', 'generales', t.id, 'multiple',
       NULL, 'Quelle est la différence essentielle entre un intermédiaire d''assurance lié et non lié au sens de l''art. 40 LSA ?', '[{"text":"Le lié agit dans un rapport de fidélité avec un ou plusieurs assureurs","correct":true},{"text":"Le non lié agit sur mandat du preneur, en toute indépendance","correct":true},{"text":"Le non lié doit être inscrit au registre FINMA (art. 41 LSA)","correct":true},{"text":"Aucune différence, tous les intermédiaires sont juridiquement égaux","correct":false,"why_wrong":"La LSA distingue clairement les deux statuts."},{"text":"Le lié est nécessairement salarié","correct":false,"why_wrong":"Un agent lié peut être indépendant tout en étant rattaché à un ou plusieurs assureurs."}]'::jsonb, 2,
       'Art. 40 LSA : intermédiaire LIÉ = rattaché à un ou plusieurs assureurs (fidélité, souvent salarié / agent) ; NON LIÉ = mandaté par le preneur, indépendant (courtier), inscription au registre FINMA obligatoire.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'generales' AND t.key = 'droit'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-GEN-DR-009', 'generales', t.id, 'single',
       NULL, 'L''inscription au registre FINMA des intermédiaires d''assurance est :', '[{"text":"Obligatoire pour tous les intermédiaires liés et non liés","correct":false,"why_wrong":"Depuis 2024, seuls les non liés doivent s''inscrire."},{"text":"Obligatoire pour les intermédiaires non liés, facultative pour les liés","correct":true},{"text":"Obligatoire pour les liés uniquement","correct":false,"why_wrong":"Les liés relèvent de la responsabilité de leur assureur."},{"text":"Facultative pour tous","correct":false,"why_wrong":"Faux : la LSA rend l''inscription obligatoire pour les non liés."}]'::jsonb, 1,
       'Art. 41 LSA (révision LSA 2024) : obligation d''inscription au registre FINMA uniquement pour les intermédiaires NON liés. Les intermédiaires liés sont couverts par la responsabilité de l''assureur qui les mandate.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'generales' AND t.key = 'droit'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-GEN-DR-010', 'generales', t.id, 'single',
       NULL, 'Depuis quand la nouvelle loi sur la protection des données (nLPD) est-elle en vigueur ?', '[{"text":"1er janvier 2022","correct":false,"why_wrong":"C''est le nouveau droit LCA."},{"text":"1er septembre 2023","correct":true},{"text":"25 mai 2018 (comme le RGPD)","correct":false,"why_wrong":"Date d''entrée en vigueur du RGPD UE, la Suisse a suivi plus tard."},{"text":"1er janvier 2024","correct":false,"why_wrong":"Confusion possible avec la révision LSA, mais la nLPD date du 01.09.2023."}]'::jsonb, 1,
       'La nLPD est entrée en vigueur le 01.09.2023. Elle renforce les droits des personnes concernées, l''obligation de tenir un registre des traitements et rehausse les sanctions pénales pour les responsables.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'generales' AND t.key = 'droit'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-GEN-DR-011', 'generales', t.id, 'multiple',
       'Vous mettez en place un registre des traitements pour votre société de courtage : quels principes structurent chaque fiche ?', 'Quels principes fondamentaux la nLPD impose-t-elle au responsable du traitement ?', '[{"text":"Licéité, bonne foi, proportionnalité, finalité","correct":true},{"text":"Exactitude et mise à jour des données","correct":true},{"text":"Sécurité (mesures techniques et organisationnelles adéquates)","correct":true},{"text":"Transparence (information de la personne concernée)","correct":true},{"text":"Communication libre à tout tiers commercial","correct":false,"why_wrong":"Contraire au principe de finalité."},{"text":"Conservation illimitée par défaut","correct":false,"why_wrong":"Contraire au principe de proportionnalité et de minimisation."}]'::jsonb, 3,
       'Art. 6 nLPD : principes de licéité, bonne foi, proportionnalité, finalité, exactitude, sécurité (art. 8), transparence (art. 19-21). Toute violation expose à des sanctions administratives et pénales.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'generales' AND t.key = 'droit'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-GEN-DR-012', 'generales', t.id, 'single',
       NULL, 'Selon la LBA / OBA, à partir de quel seuil une opération en espèces impose une identification renforcée du client ?', '[{"text":"5''000 CHF","correct":false,"why_wrong":"Seuil trop bas ; la LBA fixe 15''000 CHF pour les espèces."},{"text":"10''000 CHF","correct":false,"why_wrong":"Seuil bancaire général, pas assurance."},{"text":"15''000 CHF","correct":true},{"text":"25''000 CHF","correct":false,"why_wrong":"Piège : c''est le seuil pour la vie à prime unique."}]'::jsonb, 1,
       'Art. 3 LBA et OBA-FINMA : identification obligatoire dès 15''000 CHF pour les opérations en espèces. Piège classique : ne pas confondre avec le seuil vie unique (25''000).', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'generales' AND t.key = 'droit'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-GEN-DR-013', 'generales', t.id, 'single',
       NULL, 'En matière d''assurance-vie à prime unique, le seuil LBA à partir duquel s''applique l''obligation d''identification est :', '[{"text":"15''000 CHF","correct":false,"why_wrong":"Seuil général espèces."},{"text":"25''000 CHF (prime unique)","correct":true},{"text":"100''000 CHF","correct":false,"why_wrong":"Aucun seuil LBA vie unique n''est fixé à 100''000 CHF."},{"text":"Pas de seuil, identification systématique","correct":false,"why_wrong":"Il existe des seuils précis."}]'::jsonb, 1,
       'OBA-FINMA : pour l''assurance-vie à prime unique, seuil d''identification à 25''000 CHF (et 5''000 CHF/an pour les primes périodiques dans certains cas). À distinguer du seuil espèces de 15''000.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'generales' AND t.key = 'droit'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-GEN-DR-014', 'generales', t.id, 'multiple',
       'Vous encaissez pour un nouveau client une prime unique de 40''000 CHF en espèces, avec doutes sur l''origine.', 'Les devoirs de diligence de l''intermédiaire sous la LBA comprennent :', '[{"text":"Identifier le cocontractant","correct":true},{"text":"Identifier l''ayant droit économique","correct":true},{"text":"Clarifier l''arrière-plan économique en cas de risque accru","correct":true},{"text":"Communiquer sans délai au MROS tout soupçon fondé de blanchiment","correct":true},{"text":"Informer préalablement le client du soupçon (tipping-off)","correct":false,"why_wrong":"Interdiction absolue : art. 10a LBA (interdiction d''informer)."},{"text":"Bloquer les valeurs suspectées immédiatement sans autre formalité","correct":true}]'::jsonb, 3,
       'LBA : identification, ADE, clarification, communication MROS, blocage. Interdiction absolue d''informer le client (tipping-off, art. 10a LBA) : sanction pénale à la clé.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'generales' AND t.key = 'droit'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-GEN-DR-015', 'generales', t.id, 'multiple',
       NULL, 'L''article 3 LCD interdit notamment :', '[{"text":"Les indications inexactes ou fallacieuses sur soi-même ou ses produits","correct":true},{"text":"Le dénigrement d''un concurrent","correct":true},{"text":"Les envois publicitaires de masse sans consentement (art. 3 al. 1 let. o)","correct":true},{"text":"Le démarchage abusif ou trompeur (art. 3 al. 1 let. u)","correct":true},{"text":"Toute forme de publicité","correct":false,"why_wrong":"La publicité honnête reste licite."},{"text":"La conclusion d''un contrat avec un concurrent","correct":false,"why_wrong":"La liberté contractuelle demeure."}]'::jsonb, 1,
       'Art. 3 LCD : liste de comportements déloyaux (indications trompeuses, dénigrement, comparaisons inexactes, cadeaux abusifs, appels publicitaires sans consentement, etc.). Cœur du droit de la concurrence.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'generales' AND t.key = 'droit'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-GEN-DR-016', 'generales', t.id, 'multiple',
       NULL, 'Sous la LSFin, un conseiller en assurance-vie liée à des instruments financiers doit :', '[{"text":"Effectuer une vérification d''adéquation en cas de conseil personnalisé","correct":true},{"text":"Effectuer une vérification d''appropriation en cas de conseil sans profil personnalisé","correct":true},{"text":"Documenter la prestation fournie et remettre les informations LSFin","correct":true},{"text":"Éviter toute évaluation, la LSFin ne s''applique jamais à l''assurance","correct":false,"why_wrong":"La LSFin s''applique aux produits d''assurance qualifiables d''instruments financiers."},{"text":"Demander l''accord préalable de la FINMA avant chaque conseil","correct":false,"why_wrong":"Aucune approbation FINMA n''est requise avant chaque conseil individuel."}]'::jsonb, 2,
       'LSFin : différenciation entre pure information/exécution (pas de vérification), conseil (appropriation) et conseil personnalisé (adéquation). S''applique aux produits d''assurance qualifiables d''instruments financiers (vie liée à des placements).', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'generales' AND t.key = 'droit'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-GEN-DR-017', 'generales', t.id, 'multiple',
       'Un candidat AFA vous demande la base constitutionnelle de la trilogie AVS / LPP / LAMal pour son examen.', 'Quels domaines les art. 111 à 117 de la Constitution fédérale (Cst) attribuent-ils à la Confédération ?', '[{"text":"L''AVS et l''AI (art. 112)","correct":true},{"text":"La prévoyance professionnelle (art. 113)","correct":true},{"text":"L''assurance-chômage (art. 114)","correct":true},{"text":"L''assurance-maladie et l''assurance-accidents (art. 117)","correct":true},{"text":"L''organisation judiciaire cantonale exclusive","correct":false,"why_wrong":"Compétence cantonale, pas fédérale."},{"text":"La fixation des impôts communaux","correct":false,"why_wrong":"Compétence communale/cantonale."}]'::jsonb, 3,
       'Cst. 111-117 : bases constitutionnelles des trois piliers, de l''AC et de la LAMal/LAA. Toute assurance sociale suisse trouve son ancrage constitutionnel dans ces articles.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'generales' AND t.key = 'droit'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-GEN-DR-018', 'generales', t.id, 'single',
       'Un client vous offre 500 CHF pour que vous ''oubliez'' d''annoncer un antécédent médical dans la proposition.', 'Quelle attitude est conforme au droit et à l''éthique VBV ?', '[{"text":"Accepter, cela reste dans la limite du raisonnable","correct":false,"why_wrong":"Corruption + réticence, doublement illicite."},{"text":"Refuser, informer le client des conséquences (réticence, résiliation) et rédiger la proposition conformément à la réalité","correct":true},{"text":"Accepter mais reverser l''argent à l''assureur","correct":false,"why_wrong":"Le reversement ne blanchit pas l''infraction ; la réticence subsiste."},{"text":"Refuser mais laisser le client soumettre la proposition inexacte lui-même","correct":false,"why_wrong":"Le devoir de conseil impose d''agir, pas de fermer les yeux."}]'::jsonb, 1,
       'Acceptation = complicité de réticence (art. 6 LCA) + violation art. 45 LSA + potentielle infraction pénale. Le devoir de loyauté impose de refuser fermement et d''informer le client des risques.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'generales' AND t.key = 'droit'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-GEN-DR-019', 'generales', t.id, 'multiple',
       NULL, 'Quelle est la différence entre le contrat de courtage (art. 412 CO) et le contrat de mandat (art. 394 CO) ?', '[{"text":"Le courtage vise l''indication ou la négociation d''un contrat (art. 412 CO)","correct":true},{"text":"Le mandat est l''exécution de services pour autrui (art. 394 CO)","correct":true},{"text":"Le courtier d''assurance combine souvent les deux régimes","correct":true},{"text":"Aucune, ce sont des synonymes","correct":false,"why_wrong":"Régimes juridiques distincts au CO."},{"text":"Le mandat est toujours gratuit","correct":false,"why_wrong":"Le mandat peut être rémunéré (art. 394 al. 3 CO)."}]'::jsonb, 2,
       'Art. 412 CO : le courtier obtient rémunération pour avoir indiqué ou négocié un contrat. Art. 394 CO : le mandataire exécute des affaires pour le compte d''autrui. Le courtier d''assurance combine souvent les deux (courtage pour la conclusion + mandat pour la gestion).', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'generales' AND t.key = 'droit'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-GEN-DR-020', 'generales', t.id, 'multiple',
       'Un intermédiaire non lié récidive dans la non-remise de la FIC. La FINMA ouvre une procédure.', 'Quelles sanctions peut prononcer la FINMA en cas de violation grave de l''art. 45 LSA par un intermédiaire non lié inscrit ?', '[{"text":"Décision en constatation d''illicéité","correct":true},{"text":"Interdiction d''exercer","correct":true},{"text":"Retrait de l''inscription au registre","correct":true},{"text":"Confiscation du gain illicite","correct":true},{"text":"Emprisonnement immédiat","correct":false,"why_wrong":"Une privation de liberté relève du juge pénal, pas de la FINMA."},{"text":"Publication de la décision (naming and shaming)","correct":true}]'::jsonb, 3,
       'LFINMA (art. 30 ss) : la FINMA dispose d''un arsenal administratif (décisions, interdictions, retrait d''inscription, confiscation, publication). La peine privative de liberté relève du juge pénal.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'generales' AND t.key = 'droit'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-GEN-DR-021', 'generales', t.id, 'single',
       NULL, 'La LSA s''applique :', '[{"text":"Aux caisses AVS","correct":false,"why_wrong":"Régies par la LAVS et surveillance OFAS."},{"text":"Aux entreprises d''assurance privées et aux intermédiaires d''assurance","correct":true},{"text":"Aux banques","correct":false,"why_wrong":"LB."},{"text":"Aux caisses de compensation cantonales","correct":false,"why_wrong":"Les caisses de compensation relèvent de la LAVS et de la surveillance OFAS."}]'::jsonb, 1,
       'Art. 1 LSA : la loi régit la surveillance des entreprises d''assurance privées et des intermédiaires. Assurances sociales : lois spécifiques (LAMal, LAVS, LAI, LPP, LAA).', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'generales' AND t.key = 'droit'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-GEN-DR-022', 'generales', t.id, 'multiple',
       'Madame Roulin a signé une proposition d''assurance ménage il y a 10 jours. Elle vous appelle car elle veut annuler après avoir trouvé mieux ailleurs.', 'Que pouvez-vous lui répondre ?', '[{"text":"Elle dispose d''un délai de 14 jours dès la connaissance de la conclusion (art. 2a LCA)","correct":true},{"text":"La révocation doit être faite par écrit","correct":true},{"text":"Trop tard, seul un cas de résiliation extraordinaire permet de sortir","correct":false,"why_wrong":"Le délai de révocation art. 2a LCA (14 jours) n''est pas écoulé."},{"text":"Seulement 7 jours, donc trop tard","correct":false,"why_wrong":"Le délai légal est de 14 jours, pas 7."},{"text":"Elle doit payer la première prime avant de pouvoir résilier","correct":false,"why_wrong":"Aucune condition de paiement préalable."}]'::jsonb, 2,
       'Art. 2a LCA : révocation possible par écrit dans les 14 jours. Ici, 10 jours écoulés : le droit est intact. La révocation efface les effets du contrat rétroactivement.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'generales' AND t.key = 'droit'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-GEN-DR-023', 'generales', t.id, 'single',
       NULL, 'Selon l''art. 12 LCA, quand le contrat d''assurance est-il conclu ?', '[{"text":"Dès la signature de la proposition par le preneur","correct":false,"why_wrong":"La proposition n''est qu''une offre."},{"text":"Dès l''acceptation par l''assureur (accord des volontés)","correct":true},{"text":"Dès le paiement de la première prime","correct":false,"why_wrong":"Le paiement n''est pas condition de conclusion."},{"text":"Dès la délivrance de la police signée par les deux parties","correct":false,"why_wrong":"La police atteste du contrat, elle n''est pas condition de formation."}]'::jsonb, 1,
       'Le contrat est conclu par la rencontre de l''offre (proposition) et de l''acceptation (par l''assureur). La police atteste du contrat ; elle n''est pas condition de formation.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'generales' AND t.key = 'droit'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-GEN-DR-024', 'generales', t.id, 'multiple',
       'Un client omet volontairement de mentionner un traitement contre une hypertension sévère dans la proposition de complémentaire. L''assureur accepte, puis découvre le fait 6 mois plus tard.', 'Quels sont les droits de l''assureur ?', '[{"text":"Résilier le contrat dans les 4 semaines dès la connaissance","correct":true},{"text":"Refuser la prestation pour les sinistres liés au fait tu","correct":true},{"text":"Rien, la réticence n''est jamais opposable si l''assureur a accepté","correct":false,"why_wrong":"L''acceptation ne fait pas obstacle à l''art. 6 LCA."},{"text":"Poursuivre uniquement au pénal","correct":false,"why_wrong":"La voie civile de l''art. 6 LCA est ouverte prioritairement."},{"text":"Retenir 10 % des primes futures","correct":false,"why_wrong":"Aucune sanction de ce type prévue par la LCA."}]'::jsonb, 2,
       'Art. 6 LCA : réticence sanctionnée par la résiliation (4 semaines dès connaissance) et libération de la prestation pour les sinistres liés au fait tu. Point classique VBV.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'generales' AND t.key = 'droit'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-GEN-DR-025', 'generales', t.id, 'multiple',
       'Un assureur veut utiliser des données de santé pour proposer un nouveau produit préventif à ses assurés.', 'Sous la nLPD, quels traitements de données de santé par un assureur sont admissibles ?', '[{"text":"Traitement nécessaire à l''exécution du contrat (souscription, gestion du sinistre)","correct":true},{"text":"Traitement fondé sur le consentement exprès du client","correct":true},{"text":"Traitement fondé sur une obligation légale (LBA, LAMal)","correct":true},{"text":"Transmission à un partenaire commercial à des fins publicitaires sans consentement","correct":false,"why_wrong":"Interdit : donnée sensible, base légale exigée."},{"text":"Publication sur les réseaux sociaux à titre pédagogique","correct":false,"why_wrong":"Manifestement contraire à la nLPD."}]'::jsonb, 3,
       'Les données de santé sont sensibles (art. 5 nLPD). Traitement licite si base légale (contrat, loi) ou consentement libre, éclairé, exprès. Marketing = interdit sans consentement.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'generales' AND t.key = 'droit'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-GEN-DR-026', 'generales', t.id, 'single',
       'Vous concluez une assurance-vie à prime unique de 60''000 CHF pour un nouveau client. Il souhaite verser en espèces, refuse de justifier l''origine des fonds et paraît nerveux.', 'Quelle procédure s''impose ?', '[{"text":"Accepter les fonds, la vente prime","correct":false,"why_wrong":"Grave violation LBA."},{"text":"Identifier le cocontractant et l''ayant droit économique, clarifier l''arrière-plan, et en cas de soupçon fondé communiquer au MROS sans en informer le client","correct":true},{"text":"Refuser purement et simplement et rompre le contact","correct":false,"why_wrong":"L''obligation de communication au MROS demeure."},{"text":"Informer le client du soupçon et le laisser corriger sa position","correct":false,"why_wrong":"Interdiction d''informer (art. 10a LBA), sanction pénale."}]'::jsonb, 3,
       'LBA : identification renforcée + clarification + communication MROS + blocage sans informer. Le tipping-off (art. 10a LBA) est pénalement sanctionné. Toujours documenter la procédure.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'generales' AND t.key = 'droit'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-GEN-DR-027', 'generales', t.id, 'single',
       NULL, 'La LPGA (loi fédérale sur la partie générale du droit des assurances sociales) s''applique :', '[{"text":"Aux assurances privées LCA","correct":false,"why_wrong":"LCA = régime privé."},{"text":"Aux assurances sociales fédérales (AVS, AI, LAA, LAMal, APG, etc.)","correct":true},{"text":"Aux banques","correct":false,"why_wrong":"Les banques relèvent de la LB, pas de la LPGA."},{"text":"Uniquement à la LPP","correct":false,"why_wrong":"La LPP est expressément exclue de la LPGA (art. 2 LPGA)."}]'::jsonb, 1,
       'LPGA (art. 2) : socle commun applicable aux assurances sociales fédérales sauf LPP. Notions communes : prestations, prescription, litige, coordination des prestations.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'generales' AND t.key = 'droit'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-GEN-DR-028', 'generales', t.id, 'single',
       NULL, 'L''obligation de formation continue du conseiller (VBV / AFA) est :', '[{"text":"Facultative","correct":false,"why_wrong":"Elle est exigée par la LSA / OS."},{"text":"Imposée par l''art. 43 LSA et l''OS : formation initiale + continue documentée","correct":true},{"text":"Uniquement recommandée par l''ASA","correct":false,"why_wrong":"L''ASA gère les standards, mais l''obligation est légale."},{"text":"Fixée par le seul contrat de travail","correct":false,"why_wrong":"L''obligation est légale (LSA / OS), au-delà de tout contrat de travail."}]'::jsonb, 2,
       'Art. 43-45 LSA + OS : formation initiale et continue obligatoires, documentées, permettant l''inscription et son maintien au registre FINMA (intermédiaires non liés).', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'generales' AND t.key = 'droit'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-GEN-DR-029', 'generales', t.id, 'single',
       'Vous êtes courtier (intermédiaire non lié). Un assureur vous propose une commission majorée si vous placez ses produits chez vos clients, même quand un concurrent serait mieux adapté.', 'Quelle est la conduite conforme à la LSA / LSFin / éthique VBV ?', '[{"text":"Accepter en silence, la commission n''est pas soumise à information","correct":false,"why_wrong":"Contraire à l''art. 45 LSA (transparence rémunération) et à l''obligation de loyauté du mandataire (art. 398 CO)."},{"text":"Refuser l''incitation ou du moins l''informer intégralement au client, respecter l''obligation d''agir dans son meilleur intérêt (best advice), documenter la décision","correct":true},{"text":"Accepter mais reverser la commission au client sans autre information","correct":false,"why_wrong":"L''obligation de transparence subsiste."},{"text":"Se retirer du courtage sans autre formalité","correct":false,"why_wrong":"Ne résout pas la question du devoir de loyauté au client déjà mandant."}]'::jsonb, 3,
       'Conflit d''intérêts : LSA art. 45 (transparence rémunération), LSFin (règles de conduite), CO art. 398 (loyauté du mandataire). Le courtier doit agir dans le meilleur intérêt du preneur, informer sur les rémunérations et documenter.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'generales' AND t.key = 'droit'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-GEN-DR-030', 'generales', t.id, 'multiple',
       'Un client vous demande d''exercer ses droits nLPD sur les traitements que votre courtage a effectués sur ses données.', 'Quels droits la nLPD confère-t-elle à la personne concernée ?', '[{"text":"Droit d''accès à ses données (art. 25)","correct":true},{"text":"Droit à la rectification des données inexactes","correct":true},{"text":"Droit d''être informé de traitements automatisés produisant des effets juridiques (décision individuelle automatisée)","correct":true},{"text":"Droit à la remise/transfert des données (portabilité art. 28)","correct":true},{"text":"Droit d''exiger la publication publique de ses données","correct":false,"why_wrong":"Aucun droit à publication imposée."},{"text":"Droit d''imposer une amende personnelle au responsable","correct":false,"why_wrong":"Les sanctions relèvent du PFPDT / juge pénal."}]'::jsonb, 3,
       'nLPD : droits d''accès, rectification, information sur les décisions automatisées, portabilité. Sanctions administratives / pénales prononcées par les autorités (PFPDT, juge pénal), pas par la personne concernée.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'generales' AND t.key = 'droit'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-GEN-AC-001', 'generales', t.id, 'single',
       NULL, 'Quelles sont, dans l''ordre, les 4 phases officielles de l''entretien de conseil VBV ?', '[{"text":"Solution, analyse, introduction, conclusion","correct":false,"why_wrong":"Ordre incorrect."},{"text":"Introduction, analyse, solution, conclusion","correct":true},{"text":"Prospection, closing, up-selling, fidélisation","correct":false,"why_wrong":"Ce sont des étapes commerciales, pas les 4 phases officielles VBV."},{"text":"Contact, présentation, prix, signature","correct":false,"why_wrong":"Cette séquence commerciale ne correspond pas à la structure VBV."}]'::jsonb, 1,
       'Les 4 phases VBV (profil de qualification art. 190 OS) : (1) Introduction, (2) Analyse des besoins, (3) Solution / recommandation, (4) Conclusion / suivi. Structure aussi celle de l''étude de cas à l''examen.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'generales' AND t.key = 'acquisition'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-GEN-AC-002', 'generales', t.id, 'multiple',
       NULL, 'L''objectif principal de la phase ''Analyse'' de l''entretien est :', '[{"text":"Identifier la situation, les besoins et les objectifs du client","correct":true},{"text":"Recenser les couvertures existantes et détecter les lacunes","correct":true},{"text":"Documenter la prise d''informations pour le dossier (art. 45 LSA)","correct":true},{"text":"Présenter immédiatement le produit le plus rentable","correct":false,"why_wrong":"La solution vient après l''analyse."},{"text":"Signer la proposition sans autre échange","correct":false,"why_wrong":"Impossible sans recommandation motivée."}]'::jsonb, 1,
       'L''analyse cherche à comprendre la situation personnelle, familiale, financière et de couverture du client. Sans analyse : pas de recommandation adéquate, violation potentielle de l''art. 45 LSA.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'generales' AND t.key = 'acquisition'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-GEN-AC-003', 'generales', t.id, 'multiple',
       'Vous auditez les canaux de prospection de votre équipe et devez signaler les pratiques non conformes.', 'Parmi les sources de prospection admises et éthiques :', '[{"text":"Recommandations de clients existants","correct":true},{"text":"Réseaux professionnels et de proximité","correct":true},{"text":"Événements et salons publics","correct":true},{"text":"Fichiers d''adresses acquis illégalement","correct":false,"why_wrong":"Contraire à la nLPD (base légale, finalité) et à la LCD."},{"text":"Bases publiques (registre du commerce, données ouvertes)","correct":true},{"text":"Écoute téléphonique non autorisée","correct":false,"why_wrong":"Infraction pénale (art. 179ter CP)."}]'::jsonb, 3,
       'Prospection éthique : réseau, recommandations, événements, données publiques. Interdit : fichiers illicites, écoutes, spam sans opt-in (LCD art. 3 al. 1 let. o et u), traitement contraire à la nLPD.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'generales' AND t.key = 'acquisition'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-GEN-AC-004', 'generales', t.id, 'single',
       NULL, 'Une question ouverte se distingue d''une question fermée par :', '[{"text":"Le fait qu''elle appelle une réponse par oui / non","correct":false,"why_wrong":"Description d''une question fermée."},{"text":"Le fait qu''elle invite le client à développer, à raconter, à expliquer","correct":true},{"text":"Le fait qu''elle est toujours technique","correct":false,"why_wrong":"Une question ouverte peut être très simple, pas nécessairement technique."},{"text":"Le fait qu''elle est réservée aux experts","correct":false,"why_wrong":"Aucune restriction d''utilisation."}]'::jsonb, 1,
       'Question ouverte (que, comment, pourquoi, dites-moi) : invite à développer, essentielle en phase d''analyse. Question fermée : oui/non, utile pour valider un point précis ou clôturer.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'generales' AND t.key = 'acquisition'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-GEN-AC-005', 'generales', t.id, 'single',
       'Un client dit : ''Votre offre est plus chère que celle de votre concurrent.''', 'Quelle réponse est la plus professionnelle et éthique ?', '[{"text":"Casser immédiatement le prix de 20 %","correct":false,"why_wrong":"Perte de crédibilité et marge, sans traiter le fond."},{"text":"Questionner ce qui est comparé (couverture, franchise, exclusions), reformuler le besoin, valoriser les différences objectives, puis décider","correct":true},{"text":"Dénigrer le concurrent","correct":false,"why_wrong":"Interdit par l''art. 3 al. 1 let. a LCD (dénigrement)."},{"text":"Ignorer l''objection et poursuivre","correct":false,"why_wrong":"Une objection ignorée revient au moment du closing."}]'::jsonb, 2,
       'Traitement d''objection prix : décomposer, comparer sur base équivalente, valoriser les différences (franchise, exclusions, service). Le dénigrement du concurrent est prohibé par la LCD.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'generales' AND t.key = 'acquisition'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-GEN-AC-006', 'generales', t.id, 'multiple',
       NULL, 'La technique de closing dite ''alternative'' consiste à :', '[{"text":"Poser une question binaire présupposant la décision (franchise 500 ou 1''000)","correct":true},{"text":"Proposer deux options positives équivalentes en couverture","correct":true},{"text":"Menacer d''une hausse de prime","correct":false,"why_wrong":"Pression indue contraire à la déontologie et potentiellement LCD."},{"text":"Ne rien dire et attendre","correct":false,"why_wrong":"Le silence prolongé n''est pas une technique de closing structurée."},{"text":"Répéter systématiquement le prix","correct":false,"why_wrong":"Répéter le prix accentue l''objection."}]'::jsonb, 1,
       'Closing alternatif : proposer deux options positives, la question posée n''étant plus ''si'' mais ''quel''. Reste éthique tant qu''aucune pression indue n''est exercée.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'generales' AND t.key = 'acquisition'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-GEN-AC-007', 'generales', t.id, 'multiple',
       'Votre direction commerciale vous demande d''argumenter le cross-selling comme levier de rentabilité éthique.', 'Le cross-selling (vente croisée) permet notamment :', '[{"text":"D''élargir le champ de couverture du client à ses besoins réels","correct":true},{"text":"D''améliorer la rentabilité et la fidélisation du portefeuille","correct":true},{"text":"D''augmenter les revenus par client sans nouvelle acquisition","correct":true},{"text":"De contourner l''obligation d''analyse des besoins","correct":false,"why_wrong":"L''obligation d''analyse (art. 45 LSA) demeure entière."},{"text":"De vendre systématiquement le produit le plus rentable pour l''assureur","correct":false,"why_wrong":"Contraire au best advice."}]'::jsonb, 3,
       'Cross-selling : bénéfique s''il répond à un besoin analysé (ex. RC ménage + PJ + inventaire). Il ne dispense jamais de l''analyse de besoins et du best advice.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'generales' AND t.key = 'acquisition'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-GEN-AC-008', 'generales', t.id, 'single',
       NULL, 'Un courtier (intermédiaire non lié) reçoit ses instructions de :', '[{"text":"L''assureur exclusivement","correct":false,"why_wrong":"C''est l''intermédiaire lié."},{"text":"Le preneur d''assurance (mandant)","correct":true},{"text":"La FINMA","correct":false,"why_wrong":"La FINMA ne donne pas d''instructions individuelles au courtier."},{"text":"L''Ombudsman","correct":false,"why_wrong":"L''Ombudsman ne donne aucune instruction au courtier."}]'::jsonb, 1,
       'Le courtier agit sur mandat du preneur (art. 40 al. 2 LSA + art. 394 CO). Sa loyauté première va au client. L''agent lié, lui, représente l''assureur qui le mandate.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'generales' AND t.key = 'acquisition'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-GEN-AC-009', 'generales', t.id, 'single',
       'Vous téléphonez à un prospect particulier pour proposer un rendez-vous. Il refuse et raccroche.', 'Quelle est la conduite conforme LCD / éthique ?', '[{"text":"Le rappeler chaque jour jusqu''à obtenir un oui","correct":false,"why_wrong":"Harcèlement, contraire à la LCD (art. 3 al. 1 let. u)."},{"text":"Respecter le refus, noter et cesser toute sollicitation","correct":true},{"text":"Le rappeler d''un autre numéro pour tromper l''affichage","correct":false,"why_wrong":"Manœuvre trompeuse contraire à la LCD art. 3."},{"text":"Passer par un proche pour contourner","correct":false,"why_wrong":"Détournement caractéristique, contraire à la LCD et à la bonne foi."}]'::jsonb, 2,
       'Un refus doit être respecté. La LCD (art. 3 al. 1 let. u) interdit les sollicitations non désirées et les manœuvres trompeuses. Documenter l''opt-out et arrêter.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'generales' AND t.key = 'acquisition'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-GEN-AC-010', 'generales', t.id, 'multiple',
       NULL, 'En début d''entretien, le ''brise-glace'' sert principalement à :', '[{"text":"Établir un climat de confiance","correct":true},{"text":"Détendre l''atmosphère et faciliter la parole du client","correct":true},{"text":"Faire signer une pré-proposition","correct":false,"why_wrong":"Signer sans analyse est une faute professionnelle."},{"text":"Contourner l''analyse des besoins","correct":false,"why_wrong":"Le brise-glace ne dispense d''aucune obligation."},{"text":"Fixer la commission","correct":false,"why_wrong":"Aucun lien entre brise-glace et rémunération."}]'::jsonb, 1,
       'Le brise-glace (small talk professionnel) permet la mise en confiance, condition d''un entretien productif. Il ne remplace jamais l''analyse ni la remise de la fiche d''information client (art. 45 LSA).', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'generales' AND t.key = 'acquisition'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-GEN-AC-011', 'generales', t.id, 'multiple',
       NULL, 'Parmi ces éléments, lesquels constituent des signaux d''achat du client ?', '[{"text":"Il demande des précisions sur les modalités de paiement","correct":true},{"text":"Il commence à se projeter (utilisation du ''quand j''aurai le contrat...'')","correct":true},{"text":"Il pose des questions détaillées sur le fonctionnement en cas de sinistre","correct":true},{"text":"Il regarde ostensiblement sa montre pour couper court","correct":false,"why_wrong":"Signal négatif : demande d''écourter."},{"text":"Il croise les bras et se tait","correct":false,"why_wrong":"Signal plutôt défensif."}]'::jsonb, 2,
       'Signaux d''achat : questions concrètes de mise en œuvre, projection dans l''avenir avec le produit, prise de notes, comparaison de scénarios. Utile pour amorcer le closing.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'generales' AND t.key = 'acquisition'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-GEN-AC-012', 'generales', t.id, 'single',
       NULL, 'La méthode SPIN (Situation, Problème, Implication, Need-payoff / bénéfice) est particulièrement utile :', '[{"text":"En phase de closing","correct":false,"why_wrong":"C''est un outil de découverte, pas de closing."},{"text":"En phase d''analyse des besoins pour faire prendre conscience du problème et du bénéfice de la solution","correct":true},{"text":"En phase de suivi","correct":false,"why_wrong":"La méthode SPIN structure la découverte, pas le suivi."},{"text":"Elle est interdite en Suisse","correct":false,"why_wrong":"Aucune interdiction : c''est une méthode commerciale reconnue."}]'::jsonb, 2,
       'SPIN (Rackham) est une méthode de questionnement structuré en phase 2 (analyse) : elle transforme un besoin latent en besoin explicite, condition d''une recommandation acceptée.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'generales' AND t.key = 'acquisition'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-GEN-AC-013', 'generales', t.id, 'multiple',
       NULL, 'L''empathie en entretien de conseil consiste à :', '[{"text":"Reformuler et reconnaître le point de vue du client","correct":true},{"text":"Valider verbalement l''émotion du client sans nécessairement l''approuver","correct":true},{"text":"Toujours donner raison au client","correct":false,"why_wrong":"Confusion avec la complaisance, non professionnelle."},{"text":"Éviter tout contact visuel","correct":false,"why_wrong":"Contraire à la posture d''écoute active."},{"text":"Parler plus vite pour convaincre","correct":false,"why_wrong":"L''empathie ne dépend pas du débit de parole."}]'::jsonb, 1,
       'Empathie professionnelle : comprendre le vécu et les émotions du client, les valider verbalement (reformulation), sans renoncer à son propre rôle de conseil (best advice).', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'generales' AND t.key = 'acquisition'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-GEN-AC-014', 'generales', t.id, 'multiple',
       'Vous formez un jeune conseiller qui panique devant les objections et souhaite un protocole clair.', 'Face à une objection, quelles étapes structurées permettent un traitement professionnel ?', '[{"text":"Écouter jusqu''au bout sans interrompre","correct":true},{"text":"Reformuler pour vérifier la bonne compréhension","correct":true},{"text":"Isoler l''objection (est-ce le seul point ?)","correct":true},{"text":"Argumenter avec un fait ou un bénéfice, puis confirmer","correct":true},{"text":"Contredire immédiatement et hausser le ton","correct":false,"why_wrong":"Contre-productif et non professionnel."},{"text":"Ignorer l''objection en changeant de sujet","correct":false,"why_wrong":"Perte de confiance."}]'::jsonb, 3,
       'Traitement d''objection : écouter, reformuler, isoler, argumenter, valider. Une objection non traitée revient au moment du closing.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'generales' AND t.key = 'acquisition'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-GEN-AC-015', 'generales', t.id, 'multiple',
       NULL, 'La reformulation permet notamment de :', '[{"text":"Vérifier la compréhension mutuelle","correct":true},{"text":"Montrer une écoute active au client","correct":true},{"text":"Sécuriser la suite de l''entretien avant de proposer une solution","correct":true},{"text":"Gagner du temps sans écouter","correct":false,"why_wrong":"La reformulation exige justement une écoute attentive."},{"text":"Éviter de répondre à l''objection","correct":false,"why_wrong":"Elle prépare la réponse, elle ne l''esquive pas."}]'::jsonb, 1,
       'La reformulation est un pilier de l''écoute active : elle valide la bonne compréhension, montre au client qu''il est entendu et sécurise la suite de l''entretien.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'generales' AND t.key = 'acquisition'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-GEN-AC-016', 'generales', t.id, 'single',
       'Un client se referme, ne répond plus à vos questions, hoche la tête sans conviction.', 'Quelle réaction est la plus professionnelle ?', '[{"text":"Pousser la conclusion et signer","correct":false,"why_wrong":"Vente forcée, potentiellement contraire à l''éthique et au best advice."},{"text":"Marquer une pause, poser une question ouverte sur ce qui le préoccupe, laisser un silence pour l''inviter à s''exprimer","correct":true},{"text":"Baisser immédiatement le prix","correct":false,"why_wrong":"Baisser le prix ne traite pas la réserve non exprimée."},{"text":"Terminer l''entretien sans un mot","correct":false,"why_wrong":"Fermeture prématurée non professionnelle."}]'::jsonb, 2,
       'Face au retrait, la réponse professionnelle est de rouvrir la parole (question ouverte + silence). Le silence est un outil puissant qui invite le client à verbaliser sa réserve.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'generales' AND t.key = 'acquisition'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-GEN-AC-017', 'generales', t.id, 'multiple',
       NULL, 'L''up-selling consiste à :', '[{"text":"Proposer une couverture d''un niveau supérieur (casco complète vs partielle)","correct":true},{"text":"Augmenter le capital assuré sur un même besoin identifié","correct":true},{"text":"Proposer un produit d''une autre branche","correct":false,"why_wrong":"C''est le cross-selling, pas l''up-selling."},{"text":"Baisser le prix pour convaincre","correct":false,"why_wrong":"Aucun lien avec l''up-selling."},{"text":"Résilier l''ancienne police du client","correct":false,"why_wrong":"Aucun lien avec la notion d''up-selling."}]'::jsonb, 1,
       'Up-selling = monter en gamme sur le même besoin (casco partielle → complète, LCA basique → premium). Cross-selling = étendre à d''autres besoins (ménage + PJ).', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'generales' AND t.key = 'acquisition'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-GEN-AC-018', 'generales', t.id, 'multiple',
       'Vous préparez la trame d''un premier rendez-vous type conforme LSA/LCA pour toute votre équipe.', 'Les devoirs pré-contractuels du conseiller comprennent :', '[{"text":"Remettre la fiche d''information client (art. 45 LSA)","correct":true},{"text":"Informer sur la couverture, les exclusions, les primes (art. 3 LCA)","correct":true},{"text":"Documenter l''analyse des besoins et le conseil donné","correct":true},{"text":"Cacher les commissions perçues","correct":false,"why_wrong":"Contraire à l''art. 45 LSA (transparence)."},{"text":"Faire signer avant même l''analyse","correct":false,"why_wrong":"Contraire au processus VBV et au best advice."}]'::jsonb, 3,
       'Pré-contractuel : information (LCA 3), FIC (LSA 45), documentation de l''analyse des besoins et du conseil. Base juridique de la traçabilité et de la protection de l''assuré.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'generales' AND t.key = 'acquisition'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-GEN-AC-019', 'generales', t.id, 'single',
       'Vous démarchez un prospect via LinkedIn et souhaitez lui envoyer une offre personnalisée par email.', 'Quelle règle nLPD / LCD s''applique ?', '[{"text":"Tout est permis, LinkedIn étant public","correct":false,"why_wrong":"La publicité de la source ne dispense pas des règles nLPD et LCD."},{"text":"Vous devez respecter la finalité de la collecte, informer sur le traitement (nLPD art. 19-21) et obtenir l''accord préalable pour les envois publicitaires (LCD art. 3 al. 1 let. o)","correct":true},{"text":"Vous pouvez envoyer l''offre par email sans jamais indiquer votre identité","correct":false,"why_wrong":"Contraire à l''obligation d''identifier l''expéditeur (LCD / nLPD)."},{"text":"Il suffit d''ajouter ''confidentiel'' à l''email","correct":false,"why_wrong":"La mention ne dispense d''aucune obligation légale."}]'::jsonb, 2,
       'nLPD : information sur la collecte et la finalité. LCD art. 3 al. 1 let. o : envois publicitaires massifs sans opt-in prohibés. La prospection professionnelle ''B2B'' reste encadrée.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'generales' AND t.key = 'acquisition'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-GEN-AC-020', 'generales', t.id, 'single',
       NULL, 'La fiche d''information client (art. 45 LSA) doit être remise :', '[{"text":"Après la signature du contrat","correct":false,"why_wrong":"Trop tard : la fonction est de pré-informer."},{"text":"Lors du premier contact / avant la conclusion du contrat","correct":true},{"text":"Uniquement sur demande du client","correct":false,"why_wrong":"La remise est proactive et obligatoire, pas conditionnelle."},{"text":"Une fois par an","correct":false,"why_wrong":"Aucun rythme annuel : la remise se fait dès le premier contact."}]'::jsonb, 1,
       'Art. 45 LSA + OS : remise au premier contact ou en tout cas avant la conclusion, sur support durable. Sanction FINMA en cas d''omission.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'generales' AND t.key = 'acquisition'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-GEN-AC-021', 'generales', t.id, 'single',
       'Madame Berger, 42 ans, indépendante, mariée avec 2 enfants, vient d''ouvrir son cabinet. Elle vous demande de tout revoir : prévoyance, RC pro, ménage, PJ. Vous avez 1 heure.', 'Quelle démarche VBV structurée devez-vous suivre ?', '[{"text":"Signer immédiatement une offre ''toutes couvertures'' pour rentabiliser l''entretien","correct":false,"why_wrong":"Aucune analyse, best advice violé."},{"text":"Suivre les 4 phases : introduction (FIC + cadre), analyse (situation, besoins, couvertures existantes, lacunes), solution (proposer une hiérarchisation avec chiffres), conclusion (proposition, calendrier, prochaine étape), en documentant chaque étape","correct":true},{"text":"Aborder uniquement la prévoyance et laisser tomber le reste","correct":false,"why_wrong":"Ne répond pas à la demande."},{"text":"Renvoyer la cliente vers un autre conseiller","correct":false,"why_wrong":"Renvoi non justifié dans le contexte."}]'::jsonb, 3,
       'Cas complexe multi-produits : la structure des 4 phases VBV s''applique intégralement, avec priorisation (risque de perte de revenu > protection famille > protection biens) et documentation (art. 45 LSA).', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'generales' AND t.key = 'acquisition'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-GEN-AC-022', 'generales', t.id, 'multiple',
       NULL, 'Quelles obligations distinguent, dans la pratique, un agent lié d''un courtier vis-à-vis du client ?', '[{"text":"L''agent lié doit informer sur les assureurs qu''il représente","correct":true},{"text":"Le courtier agit sur mandat du preneur (loyauté première au client)","correct":true},{"text":"Le courtier doit être inscrit au registre FINMA (art. 41 LSA)","correct":true},{"text":"Les deux sont soumis à l''art. 45 LSA (informations à fournir)","correct":true},{"text":"Seul l''agent lié doit suivre une formation initiale","correct":false,"why_wrong":"Formation obligatoire pour les deux (art. 43 LSA)."},{"text":"Le courtier peut cacher ses commissions","correct":false,"why_wrong":"Transparence exigée."}]'::jsonb, 2,
       'Les deux catégories relèvent de l''art. 45 LSA. Différence structurelle : rattachement à un assureur (lié) vs mandat du preneur et inscription obligatoire au registre FINMA (non lié).', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'generales' AND t.key = 'acquisition'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-GEN-AC-023', 'generales', t.id, 'multiple',
       NULL, 'Le ''handoff'' (passage de relais entre commercial et gestionnaire) sert à :', '[{"text":"Éviter que le client soit livré à lui-même après la signature","correct":true},{"text":"Sécuriser l''expérience de gestion sinistre","correct":true},{"text":"Réduire les annulations post-vente","correct":true},{"text":"Se débarrasser du client","correct":false,"why_wrong":"Contraire à l''objectif de fidélisation."},{"text":"Éviter les questions du client","correct":false,"why_wrong":"Contraire au devoir d''information continue."},{"text":"Réduire les prestations d''assurance","correct":false,"why_wrong":"Aucun lien avec le handoff."}]'::jsonb, 1,
       'Le handoff sécurise la satisfaction et la fidélisation : présentation nominale du gestionnaire, transfert du dossier, cadrage des prochaines étapes. Réduit le taux d''annulation post-vente.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'generales' AND t.key = 'acquisition'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-GEN-AC-024', 'generales', t.id, 'single',
       'Un client très satisfait vous dit qu''il vous recommandera à son frère.', 'Que faites-vous concrètement ?', '[{"text":"Le remercier vaguement et attendre","correct":false,"why_wrong":"Passivité : opportunité de recommandation perdue."},{"text":"Le remercier, demander explicitement l''autorisation d''être présenté, fixer un canal (email / appel), et remercier après l''échange effectif","correct":true},{"text":"Appeler directement son frère avec les coordonnées trouvées en ligne","correct":false,"why_wrong":"Traitement nLPD sans base et démarchage LCD douteux."},{"text":"Envoyer un cadeau au client sans plus formaliser","correct":false,"why_wrong":"Cadeaux à surveiller (LCD, LBA), sans traiter la recommandation."}]'::jsonb, 2,
       'Recommandation active : capitaliser sur l''ouverture, formaliser l''autorisation (nLPD), s''assurer d''un canal, boucler avec un remerciement. Le NPS se construit à ces moments.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'generales' AND t.key = 'acquisition'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-GEN-AC-025', 'generales', t.id, 'multiple',
       NULL, 'Quel délai typique de suivi post-vente est reconnu comme bonne pratique ?', '[{"text":"Un contact dans les 30 à 90 jours après la conclusion","correct":true},{"text":"Un point annuel systématique","correct":true},{"text":"Un contact déclenché à chaque événement de vie majeur (mariage, enfant, achat immobilier)","correct":true},{"text":"Aucun suivi n''est nécessaire","correct":false,"why_wrong":"Contraire au devoir d''information continue (art. 3 LCA)."},{"text":"Tous les 5 ans seulement","correct":false,"why_wrong":"Cadence trop faible pour un conseil de qualité."},{"text":"Uniquement en cas de sinistre","correct":false,"why_wrong":"Insuffisant : l''analyse des besoins évolue avec la vie du client."}]'::jsonb, 1,
       'Bonne pratique : contact rapproché post-vente (30-90 jours) pour vérifier la mise en place, puis revue annuelle. Ancrage aussi dans le devoir d''information continu (art. 3 LCA).', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'generales' AND t.key = 'acquisition'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-GEN-AC-026', 'generales', t.id, 'single',
       'Vous êtes en négociation avec un chef d''entreprise pour un package : LAA-C, IJM collective, LPP surobligatoire, RC professionnelle. Il exige 15 % de rabais sur toutes les primes.', 'Comment structurer une réponse professionnelle ?', '[{"text":"Refuser en bloc et clôturer","correct":false,"why_wrong":"Ferme la relation sans exploration de solutions équilibrées."},{"text":"Accepter tout, quitte à sacrifier la marge","correct":false,"why_wrong":"Risque de mauvaise recommandation et de perte de crédibilité."},{"text":"Ré-analyser les besoins réels, ajuster les couvertures (franchises, exclusions, capitaux), objectiver ce qui peut baisser sans dégrader la protection critique, et documenter le résultat","correct":true},{"text":"Diminuer la couverture LAA-C obligatoire en dessous du minimum légal","correct":false,"why_wrong":"Illégal."}]'::jsonb, 3,
       'Négociation multi-lignes : n''est pas ''discount global''. Rebâtir la structure (analyse), objectiver les leviers (franchise, capitaux, garanties optionnelles), documenter la décision, respecter les seuils légaux (LAA).', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'generales' AND t.key = 'acquisition'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-GEN-AC-027', 'generales', t.id, 'multiple',
       'Votre responsable qualité inspecte les techniques de closing pour identifier les pratiques à risque LCD/LSA.', 'Parmi les techniques de closing suivantes, lesquelles sont considérées comme éthiques et compatibles avec le devoir de conseil ?', '[{"text":"Closing par récapitulatif des bénéfices convenus","correct":true},{"text":"Closing alternatif (deux options positives)","correct":true},{"text":"Closing par question directe une fois les objections traitées","correct":true},{"text":"Closing par mensonge sur la disponibilité limitée du produit","correct":false,"why_wrong":"Manœuvre trompeuse LCD."},{"text":"Closing par pression émotionnelle sur la santé d''un proche","correct":false,"why_wrong":"Non professionnel et potentiellement abusif."}]'::jsonb, 3,
       'Closing éthique : récapitulatif, alternatif, direct. Interdits : mensonges (LCD), pression indue, urgence artificielle. La conclusion doit être un choix éclairé.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'generales' AND t.key = 'acquisition'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-GEN-AC-028', 'generales', t.id, 'multiple',
       NULL, 'L''écoute active implique notamment :', '[{"text":"Contact visuel et posture ouverte","correct":true},{"text":"Reformulation et prise de notes","correct":true},{"text":"Questions de clarification et silences respectés","correct":true},{"text":"Interrompre pour montrer sa compétence","correct":false,"why_wrong":"Contraire à l''écoute active."},{"text":"Répondre au téléphone pendant que le client parle","correct":false,"why_wrong":"Comportement disqualifiant en entretien."}]'::jsonb, 1,
       'Écoute active : contact visuel, posture ouverte, reformulation, prise de notes, questions de clarification. Base d''un entretien de qualité et d''une bonne analyse.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'generales' AND t.key = 'acquisition'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-GEN-AC-029', 'generales', t.id, 'single',
       NULL, 'L''analyse des besoins peut s''appuyer sur la pyramide de Maslow pour :', '[{"text":"Rappeler au client qu''il est irrationnel","correct":false,"why_wrong":"Attaque personnelle contre-productive."},{"text":"Hiérarchiser les besoins : sécurité de base (LAA, LAMal), stabilité (LPP, IJM), projets (3a, ménage, PJ), accomplissement (épargne, prévoyance libre)","correct":true},{"text":"Vendre systématiquement le produit le plus cher","correct":false,"why_wrong":"Contraire au best advice."},{"text":"Négliger la partie ''protection'' au profit du ''plaisir''","correct":false,"why_wrong":"Inverse la logique de Maslow appliquée à l''assurance."}]'::jsonb, 2,
       'Maslow appliqué : partir de la protection vitale (sécurité) puis remonter (projets, patrimoine). Aide à structurer l''entretien et à hiérarchiser les priorités.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'generales' AND t.key = 'acquisition'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-GEN-AC-030', 'generales', t.id, 'multiple',
       NULL, 'La fidélisation d''un portefeuille repose principalement sur :', '[{"text":"La qualité du suivi et la disponibilité en cas de sinistre","correct":true},{"text":"La revue régulière des besoins","correct":true},{"text":"La transparence sur les rémunérations et les décisions","correct":true},{"text":"Le prix le plus bas systématiquement","correct":false,"why_wrong":"Un prix bas seul ne fidélise pas si la qualité fait défaut."},{"text":"Les cadeaux de fin d''année exclusivement","correct":false,"why_wrong":"Insuffisant : ne remplace pas la relation de conseil."},{"text":"Le silence après la vente","correct":false,"why_wrong":"Absence de suivi = risque d''attrition majeure."}]'::jsonb, 1,
       'Fidélisation = confiance x accessibilité x pertinence. Le suivi de sinistre est un moment clé de vérité. Une revue annuelle est également un puissant levier de rétention et de cross-selling utile.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'generales' AND t.key = 'acquisition'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-GEN-LT-001', 'generales', t.id, 'multiple',
       NULL, 'L''Ombudsman de l''assurance privée et de la SUVA joue le rôle de :', '[{"text":"Médiateur neutre entre l''assuré et l''assureur","correct":true},{"text":"Service gratuit pour l''assuré","correct":true},{"text":"Recommandation non contraignante à l''égard de l''assureur","correct":true},{"text":"Tribunal privé qui rend des décisions exécutoires","correct":false,"why_wrong":"Ni tribunal ni décision exécutoire."},{"text":"Autorité de police","correct":false,"why_wrong":"L''Ombudsman n''a aucun pouvoir de police."},{"text":"Chambre de commerce","correct":false,"why_wrong":"Aucun lien avec les chambres de commerce."}]'::jsonb, 1,
       'L''Ombudsman est un médiateur neutre et indépendant. Service gratuit pour l''assuré, ses prises de position ne sont pas contraignantes. Voie civile toujours ouverte (art. 46b LCA).', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'generales' AND t.key = 'litiges'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-GEN-LT-002', 'generales', t.id, 'single',
       NULL, 'Selon l''art. 46 al. 1 LCA (révision 2022), les créances découlant du contrat d''assurance se prescrivent par :', '[{"text":"2 ans dès la connaissance du fait","correct":false,"why_wrong":"Ancien délai."},{"text":"5 ans dès la survenance du fait sur lequel elles reposent","correct":true},{"text":"10 ans dès la conclusion du contrat","correct":false},{"text":"1 an dès le refus de l''assureur","correct":false}]'::jsonb, 1,
       'Art. 46 al. 1 LCA (dès 2022) : prescription de 5 ans dès la survenance du fait générateur (avant : 2 ans). Nouvelle règle facile à confondre à l''examen.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'generales' AND t.key = 'litiges'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-GEN-LT-003', 'generales', t.id, 'single',
       NULL, 'Le for compétent pour une action civile fondée sur un contrat d''assurance (art. 46b LCA) est :', '[{"text":"Uniquement le siège de l''assureur","correct":false,"why_wrong":"L''art. 46b LCA offre une alternative au preneur, au for de son domicile."},{"text":"Au choix du preneur : son domicile suisse ou le siège / la succursale suisse de l''assureur","correct":true},{"text":"Uniquement à Zurich (siège FINMA)","correct":false,"why_wrong":"La FINMA n''a aucun rôle judiciaire pour les litiges individuels."},{"text":"Le domicile du témoin","correct":false,"why_wrong":"Aucun for lié au témoin."}]'::jsonb, 1,
       'Art. 46b LCA : le preneur peut agir soit à son domicile suisse, soit au siège / succursale suisse de l''assureur. Disposition protectrice de l''assuré, impérative.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'generales' AND t.key = 'litiges'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-GEN-LT-004', 'generales', t.id, 'multiple',
       NULL, 'Quelles étapes standard structurent le traitement d''un sinistre par un assureur ?', '[{"text":"Réception et enregistrement de l''annonce","correct":true},{"text":"Vérification de la couverture (contrat, exclusions, délais)","correct":true},{"text":"Évaluation du dommage (expertise si nécessaire)","correct":true},{"text":"Décision (acceptation / refus / offre transactionnelle)","correct":true},{"text":"Paiement ou décision motivée","correct":true},{"text":"Suppression automatique du contrat sans notification","correct":false,"why_wrong":"Aucune règle n''impose la suppression sans notification."}]'::jsonb, 2,
       'Cycle sinistre : annonce, ouverture, vérification, évaluation, décision, règlement. Chaque étape doit être documentée. Refus : motivé et notifié au preneur, avec voies de recours (Ombudsman, action civile).', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'generales' AND t.key = 'litiges'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-GEN-LT-005', 'generales', t.id, 'single',
       NULL, 'Le principe indemnitaire (art. 96 LCA) signifie que :', '[{"text":"L''indemnité peut dépasser le dommage subi","correct":false,"why_wrong":"Contraire au principe."},{"text":"L''indemnité est plafonnée au dommage effectivement subi","correct":true},{"text":"L''assureur peut refuser toute indemnité","correct":false,"why_wrong":"Contraire au principe indemnitaire qui prévoit une indemnisation à hauteur du dommage."},{"text":"Le sinistre doit être supérieur à 10''000 CHF","correct":false,"why_wrong":"Aucun seuil légal de ce type."}]'::jsonb, 1,
       'Principe fondamental des assurances de dommages : pas d''enrichissement. Justifie l''interdiction du cumul, la subrogation (art. 95c LCA) et l''exigence d''un intérêt assurable (art. 48 LCA).', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'generales' AND t.key = 'litiges'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-GEN-LT-006', 'generales', t.id, 'single',
       NULL, 'La subrogation légale de l''assureur (art. 95c LCA, ex-art. 72 LCA ancien) implique que :', '[{"text":"L''assureur, ayant indemnisé son assuré, se substitue à ce dernier dans ses droits contre le tiers responsable jusqu''à concurrence de l''indemnité versée","correct":true},{"text":"L''assureur reverse à l''assuré ses propres réserves techniques","correct":false,"why_wrong":"Aucun lien avec la subrogation."},{"text":"Le tiers responsable peut refuser toute action","correct":false,"why_wrong":"Le responsable reste débiteur, y compris envers l''assureur subrogé."},{"text":"L''assuré perd tous ses droits contre le tiers","correct":false,"why_wrong":"Il ne les perd que dans la mesure indemnisée."}]'::jsonb, 2,
       'Subrogation (art. 95c LCA, révision 2022 ; anciennement art. 72 LCA) : mécanisme central des assurances de dommages. Empêche l''enrichissement et permet à l''assureur de récupérer auprès du responsable.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'generales' AND t.key = 'litiges'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-GEN-LT-007', 'generales', t.id, 'multiple',
       NULL, 'L''obligation d''aviser sans retard l''assureur du sinistre (art. 38 LCA) incombe :', '[{"text":"Au preneur d''assurance dès qu''il en a connaissance","correct":true},{"text":"À l''ayant droit à la prestation (bénéficiaire)","correct":true},{"text":"Uniquement à l''assureur","correct":false,"why_wrong":"L''assureur est destinataire, pas débiteur de l''annonce."},{"text":"À l''expert désigné","correct":false,"why_wrong":"L''expert n''a pas d''obligation légale d''annonce."},{"text":"À la FINMA","correct":false,"why_wrong":"La FINMA n''est pas destinataire des annonces individuelles."}]'::jsonb, 1,
       'Art. 38 LCA : obligation d''annonce sans retard. Une déclaration tardive peut, selon les conditions, entraîner une réduction de la prestation si l''assureur a subi un préjudice (art. 45 LCA).', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'generales' AND t.key = 'litiges'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-GEN-LT-008', 'generales', t.id, 'single',
       'Un client reçoit un refus de prestation par courrier de son assureur pour un sinistre ménage.', 'Quelles voies de recours devez-vous lui indiquer ?', '[{"text":"Aucune voie de recours possible","correct":false,"why_wrong":"Toujours au moins la voie civile ouverte (art. 46b LCA)."},{"text":"Contestation motivée à l''assureur, saisine de l''Ombudsman (gratuit), puis action civile devant le juge compétent (art. 46b LCA) dans le délai de prescription (5 ans art. 46 LCA)","correct":true},{"text":"Plainte pénale immédiate","correct":false,"why_wrong":"Sans indice d''infraction, la voie pénale n''a pas sa place."},{"text":"Recours à l''ASA","correct":false,"why_wrong":"L''ASA ne tranche pas les litiges individuels."}]'::jsonb, 2,
       'Chaîne classique : contestation interne, médiation Ombudsman, action civile. Respecter la prescription (5 ans art. 46 LCA) et le for (art. 46b LCA).', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'generales' AND t.key = 'litiges'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-GEN-LT-009', 'generales', t.id, 'multiple',
       'Un client vous demande s''il doit renoncer à agir en justice après avoir saisi l''Ombudsman : rassurez-le et cadrez.', 'Quelles limites encadrent l''action de l''Ombudsman de l''assurance privée ?', '[{"text":"Ses prises de position ne sont pas contraignantes","correct":true},{"text":"Il n''a pas le pouvoir d''ordonner une expertise judiciaire","correct":true},{"text":"Il n''interrompt pas la prescription de plein droit sans démarche complémentaire","correct":true},{"text":"Il peut être saisi gratuitement par l''assuré","correct":true},{"text":"Il rend des jugements exécutoires immédiatement","correct":false,"why_wrong":"Confusion classique : ce n''est pas un juge."},{"text":"Il remplace le juge civil","correct":false,"why_wrong":"L''action civile reste ouverte (art. 46b LCA)."}]'::jsonb, 3,
       'Ombudsman = médiation gratuite non contraignante. Attention à ne pas laisser courir la prescription (5 ans art. 46 LCA) pendant la médiation : conseiller le client sur des actes interruptifs si nécessaire (art. 135 CO).', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'generales' AND t.key = 'litiges'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-GEN-LT-010', 'generales', t.id, 'single',
       NULL, 'Une clause d''arbitrage figurant dans les CGA d''assurance :', '[{"text":"Est toujours valable, même sans consentement individuel","correct":false,"why_wrong":"Sans consentement clair, la clause est fragilisée."},{"text":"N''est valable que si le consentement du preneur est clair et si les règles impératives sur le for (art. 46b LCA) et le CPC sont respectées","correct":true},{"text":"Est expressément interdite en Suisse","correct":false,"why_wrong":"L''arbitrage reste admissible sous conditions."},{"text":"Nécessite l''accord préalable de la FINMA","correct":false,"why_wrong":"Aucune autorisation FINMA requise."}]'::jsonb, 1,
       'Une clause d''arbitrage doit résulter d''un consentement clair du consommateur et respecter les règles impératives protectrices (for LCA 46b, CPC). Prudence dans le conseil : la voie ordinaire reste normalement offerte.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'generales' AND t.key = 'litiges'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-GEN-LT-011', 'generales', t.id, 'multiple',
       'Suite à un accrochage, le lésé réclame directement à l''assureur RC véhicule du responsable.', 'Quel principe s''applique en RC circulation ?', '[{"text":"Le lésé dispose d''une action directe contre l''assureur RC véhicule du responsable (art. 65 LCR)","correct":true},{"text":"L''assureur peut opposer certaines exclusions valables au lésé, mais pas les moyens tirés du seul rapport interne au responsable","correct":true},{"text":"Le lésé ne peut agir que contre le responsable, jamais contre l''assureur","correct":false,"why_wrong":"Faux : l''action directe est expressément consacrée par l''art. 65 LCR."},{"text":"L''assureur peut refuser toute discussion tant qu''un jugement n''est pas rendu","correct":false,"why_wrong":"Refus contraire à l''obligation de traiter le sinistre."},{"text":"Le lésé doit d''abord attaquer la FINMA","correct":false,"why_wrong":"La FINMA n''est pas une instance de recours pour les litiges individuels."}]'::jsonb, 2,
       'Art. 65 LCR : action directe du lésé contre l''assureur RC véhicule. Exception marquée au relatif du contrat, en raison du caractère obligatoire de la couverture.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'generales' AND t.key = 'litiges'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-GEN-LT-012', 'generales', t.id, 'single',
       NULL, 'En cas de faute grave du preneur (art. 14 LCA), l''assureur peut :', '[{"text":"Refuser toute prestation systématiquement, quelle que soit la gravité","correct":false,"why_wrong":"Refus uniquement dans certaines conditions ; en général, réduction proportionnelle."},{"text":"Réduire la prestation dans une mesure correspondant au degré de la faute","correct":true},{"text":"Résilier le contrat sans autre formalité pour tous ses clients","correct":false,"why_wrong":"La sanction reste individuelle, jamais collective."},{"text":"Doubler la prime future","correct":false,"why_wrong":"Aucune règle légale d''un doublement automatique."}]'::jsonb, 1,
       'Art. 14 LCA : sinistre par faute grave → réduction dans la mesure du degré de la faute. Faute intentionnelle : refus. Négligence légère : pas de réduction. Distinction cruciale à connaître.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'generales' AND t.key = 'litiges'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-GEN-LT-013', 'generales', t.id, 'multiple',
       'Vous instruisez un dossier de RC : lister méthodiquement les conditions à démontrer pour engager la responsabilité.', 'L''action en responsabilité civile fondée sur l''art. 41 CO exige la démonstration :', '[{"text":"D''un acte illicite (violation d''une norme)","correct":true},{"text":"D''une faute (intention ou négligence)","correct":true},{"text":"D''un dommage patrimonial ou tort moral","correct":true},{"text":"D''un lien de causalité naturelle ET adéquate entre l''acte et le dommage","correct":true},{"text":"D''une décision pénale préalable","correct":false,"why_wrong":"Non exigée."},{"text":"D''un contrat entre auteur et lésé","correct":false,"why_wrong":"Le contrat n''est pas requis en RC délictuelle (autrement : art. 97 CO, responsabilité contractuelle)."}]'::jsonb, 3,
       'Art. 41 CO : illicéité, faute (ou responsabilité causale légale), dommage, causalité. Grille structurante à maîtriser en RC (privée, véhicule, professionnelle).', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'generales' AND t.key = 'litiges'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-GEN-LT-014', 'generales', t.id, 'multiple',
       NULL, 'En cas d''aggravation essentielle du risque en cours de contrat imputable au preneur (art. 28 LCA), celui-ci doit :', '[{"text":"En informer l''assureur sans délai par écrit (art. 28 LCA)","correct":true},{"text":"Documenter la nature et l''ampleur de l''aggravation","correct":true},{"text":"Rien signaler, l''assureur s''en rendra compte","correct":false,"why_wrong":"Devoir d''information explicite."},{"text":"Résilier immédiatement le contrat","correct":false,"why_wrong":"La résiliation appartient à l''assureur dans ce contexte."},{"text":"Attendre la prochaine échéance","correct":false,"why_wrong":"L''obligation est immédiate."}]'::jsonb, 1,
       'Art. 28 LCA (nouveau droit) : le preneur doit annoncer par écrit toute aggravation essentielle. À défaut : l''assureur peut résilier / réduire la prestation. Devoir de collaboration renforcé.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'generales' AND t.key = 'litiges'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-GEN-LT-015', 'generales', t.id, 'single',
       NULL, 'Dans le nouveau droit LCA, en cas de diminution essentielle du risque, le preneur peut :', '[{"text":"Rien exiger : la prime reste identique","correct":false,"why_wrong":"Contraire à l''art. 30 LCA (symétrie avec l''aggravation)."},{"text":"Demander une réduction de la prime pour l''avenir (art. 30 LCA)","correct":true},{"text":"Obtenir le remboursement de toutes les primes passées","correct":false,"why_wrong":"Effet pour l''avenir, pas rétroactif."},{"text":"Résilier gratuitement pendant 5 ans","correct":false,"why_wrong":"Aucun droit de résiliation gratuit sur 5 ans."}]'::jsonb, 2,
       'Art. 30 LCA : symétrie de l''aggravation, en cas de diminution essentielle et durable du risque, le preneur peut exiger une adaptation de la prime pour l''avenir.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'generales' AND t.key = 'litiges'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-GEN-LT-016', 'generales', t.id, 'single',
       'Un sinistre ménage est couvert simultanément par la RC privée du responsable et par l''assurance ménage de la victime.', 'Comment se règle la coordination des prestations ?', '[{"text":"La victime peut cumuler les deux indemnisations","correct":false,"why_wrong":"Contraire au principe indemnitaire."},{"text":"L''assurance de choses de la victime paie et se subroge dans les droits contre le responsable (ou son assureur RC) selon art. 95c LCA","correct":true},{"text":"Le responsable ne doit rien tant que l''assureur de la victime n''a pas payé","correct":false,"why_wrong":"Le responsable reste débiteur, la subrogation intervient ensuite."},{"text":"L''Ombudsman tranche automatiquement","correct":false,"why_wrong":"L''Ombudsman n''a pas de compétence de trancher les recours subrogatoires."}]'::jsonb, 3,
       'Interaction classique assurance de choses / RC : l''assureur de dommages avance la prestation à la victime puis se retourne contre le responsable via la subrogation (art. 95c LCA). Empêche la double indemnisation.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'generales' AND t.key = 'litiges'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-GEN-LT-017', 'generales', t.id, 'single',
       NULL, 'La sur-indemnisation est interdite en assurance de dommages car :', '[{"text":"Elle contrevient au principe indemnitaire (art. 96 LCA)","correct":true},{"text":"Elle est parfaitement admise si le client cotise deux fois","correct":false,"why_wrong":"Interdiction stricte de l''enrichissement en assurance de dommages."},{"text":"Elle n''existe que dans les assurances-vie","correct":false,"why_wrong":"L''assurance-vie de sommes n''est pas soumise au principe indemnitaire."},{"text":"Elle est autorisée en cas d''invalidité","correct":false,"why_wrong":"Faux : dépend du type de couverture (indemnitaire ou forfaitaire)."}]'::jsonb, 1,
       'Assurance de dommages : indemnitaire strict (art. 96 LCA). Assurance de sommes (vie) : cumul possible car pas indemnitaire. Distinction clé du programme VBV.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'generales' AND t.key = 'litiges'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-GEN-LT-018', 'generales', t.id, 'multiple',
       'Un assuré souhaite comprendre le déroulé complet de la saisine Ombudsman avant de s''engager.', 'Quelles étapes suit typiquement une procédure devant l''Ombudsman de l''assurance privée ?', '[{"text":"L''assuré doit d''abord avoir présenté sa réclamation à l''assureur","correct":true},{"text":"Dépôt gratuit d''une demande écrite / en ligne à l''Ombudsman","correct":true},{"text":"Instruction contradictoire avec les parties","correct":true},{"text":"Prise de position (recommandation non contraignante)","correct":true},{"text":"Décision exécutoire immédiate avec titre exécutoire","correct":false,"why_wrong":"Confusion : l''Ombudsman n''est pas un juge."},{"text":"Recours obligatoire à la FINMA","correct":false,"why_wrong":"La FINMA n''est pas une instance de recours pour les litiges individuels."}]'::jsonb, 3,
       'Procédure Ombudsman : réclamation préalable, saisine gratuite, instruction, prise de position. Sans force exécutoire ; l''action civile reste ouverte (art. 46b LCA).', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'generales' AND t.key = 'litiges'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-GEN-LT-019', 'generales', t.id, 'single',
       'Un preneur oublie de payer sa prime. L''assureur lui adresse une sommation écrite avec fixation d''un délai de 14 jours.', 'Que se passe-t-il si le preneur ne paie pas dans le délai (art. 20 LCA) ?', '[{"text":"La couverture est suspendue dès l''expiration du délai jusqu''au paiement","correct":true},{"text":"Le contrat est immédiatement résilié sans autre procédure","correct":false,"why_wrong":"Suspension d''abord, puis résiliation possible."},{"text":"L''assureur perd tout droit à la prime","correct":false,"why_wrong":"L''assureur conserve sa créance de prime pour la période due."},{"text":"Le sinistre survenu pendant la suspension reste couvert","correct":false,"why_wrong":"PIÈGE fréquent : pendant la suspension, aucun sinistre n''est couvert."}]'::jsonb, 2,
       'Art. 20 LCA : sommation + délai 14 jours. À défaut de paiement, suspension de la couverture. L''assureur peut ensuite résilier (art. 21 LCA) ou reprendre le contrat au paiement effectif.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'generales' AND t.key = 'litiges'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-GEN-LT-020', 'generales', t.id, 'multiple',
       NULL, 'Selon l''art. 35a LCA (nouveau droit), après un premier renouvellement le preneur peut résilier :', '[{"text":"Après 3 ans de contrat, avec un préavis (art. 35a LCA)","correct":true},{"text":"En respectant la forme écrite prévue au contrat ou par la loi","correct":true},{"text":"À tout moment sans indemnité","correct":false,"why_wrong":"Faux : le droit de résiliation ordinaire est encadré."},{"text":"Uniquement en cas de sinistre","correct":false,"why_wrong":"C''est un cas de résiliation extraordinaire, distinct."},{"text":"Uniquement avec l''accord de la FINMA","correct":false,"why_wrong":"La FINMA n''intervient pas dans les résiliations individuelles."}]'::jsonb, 1,
       'Art. 35a LCA (nouveau droit 2022) : le contrat de longue durée peut être résilié après 3 ans, moyennant le respect du préavis prévu. Renforce la position du preneur.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'generales' AND t.key = 'litiges'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-GEN-LT-021', 'generales', t.id, 'single',
       'Un assuré tombe malade en voyage à l''étranger et doit être hospitalisé.', 'Quelle est la coordination LAMal / LCA voyage ?', '[{"text":"La LAMal couvre uniquement l''urgence, jusqu''au double du tarif suisse ; la LCA voyage peut compléter (frais réels, rapatriement, assistance)","correct":true},{"text":"La LAMal rembourse intégralement partout dans le monde","correct":false,"why_wrong":"Faux : le remboursement est plafonné."},{"text":"Le rapatriement médical est couvert par la LAMal","correct":false,"why_wrong":"Non : le rapatriement relève d''une LCA voyage / complémentaire."},{"text":"La FINMA prend en charge les frais","correct":false,"why_wrong":"La FINMA ne rembourse aucun frais individuel."}]'::jsonb, 2,
       'Art. 36 OAMal : LAMal = urgence à l''étranger, plafonnée au double du tarif suisse. LCA voyage = complément indispensable (frais réels, rapatriement, assistance 24 h).', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'generales' AND t.key = 'litiges'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-GEN-LT-022', 'generales', t.id, 'multiple',
       'Un enquêteur suspecte une fraude au sinistre chez un client historique. Quelles actions structurer ?', 'En cas de déclaration frauduleuse du preneur lors d''un sinistre (art. 40 LCA), l''assureur peut :', '[{"text":"Refuser la prestation","correct":true},{"text":"Résilier le contrat","correct":true},{"text":"Demander la restitution des prestations déjà versées si elles reposent sur la fraude","correct":true},{"text":"Dénoncer les faits au ministère public si un délit est constitué (escroquerie art. 146 CP)","correct":true},{"text":"Doubler automatiquement la prime des autres assurés","correct":false,"why_wrong":"Aucun automatisme légal."},{"text":"Emprisonner l''assuré lui-même","correct":false,"why_wrong":"Compétence exclusive du juge pénal."}]'::jsonb, 3,
       'Art. 40 LCA : la fraude au sinistre libère l''assureur de toute prestation en lien. Résiliation possible. Selon la gravité : plainte pénale pour escroquerie (art. 146 CP). Un des sujets sensibles VBV.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'generales' AND t.key = 'litiges'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-GEN-LT-023', 'generales', t.id, 'single',
       'Un accident implique un cycliste (blessé), un piéton (blessé) et une voiture (endommagée) : le conducteur automobile est fautif à 100 %.', 'Comment se règlent les indemnisations ?', '[{"text":"Rien à indemniser, seul le conducteur est en cause","correct":false,"why_wrong":"L''assurance RC obligatoire du véhicule prend en charge les tiers lésés."},{"text":"L''assureur RC véhicule du conducteur indemnise les tiers lésés (piéton, cycliste, dommages matériels adverses) ; les blessures relèvent aussi de la LAA / LAMal des victimes, avec subrogation possible contre l''assureur RC (art. 72 LPGA)","correct":true},{"text":"Chacun paie ses propres dommages","correct":false,"why_wrong":"Faux : le principe de responsabilité et l''assurance RC obligatoire s''appliquent."},{"text":"L''État indemnise directement","correct":false,"why_wrong":"L''État n''indemnise pas directement ; il existe le BNG pour les cas résiduels."}]'::jsonb, 3,
       'RC obligatoire véhicule : les tiers sont indemnisés par l''assureur RC (action directe art. 65 LCR). Les prestations LAA / LAMal des victimes ouvrent une subrogation légale (art. 72 LPGA) contre l''assureur RC : coordination des assurances sociales et privées.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'generales' AND t.key = 'litiges'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-GEN-LT-024', 'generales', t.id, 'single',
       NULL, 'L''action de l''assuré pour obtenir la prestation d''assurance se prescrit selon l''art. 46 LCA (dès 2022) par :', '[{"text":"1 an","correct":false,"why_wrong":"Aucun délai LCA de 1 an pour la prescription."},{"text":"5 ans dès la survenance du fait","correct":true},{"text":"10 ans","correct":false,"why_wrong":"Délai du CO ordinaire (art. 127), la LCA est plus courte."},{"text":"6 mois","correct":false,"why_wrong":"Aucun délai LCA de 6 mois."}]'::jsonb, 1,
       'Art. 46 al. 1 LCA (nouveau droit) : 5 ans dès la survenance du fait. Rappel : la médiation Ombudsman n''interrompt pas automatiquement la prescription (art. 135 CO), documenter les actes interruptifs si besoin.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'generales' AND t.key = 'litiges'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-GEN-LT-025', 'generales', t.id, 'multiple',
       NULL, 'Quelle est la conséquence principale de l''art. 40 LCA (sinistre invoqué à tort par le preneur) ?', '[{"text":"L''assureur est libéré de sa prestation liée au sinistre invoqué à tort","correct":true},{"text":"L''assureur peut résilier le contrat","correct":true},{"text":"L''assureur doit payer intégralement","correct":false,"why_wrong":"Contraire au texte de l''art. 40 LCA."},{"text":"L''assureur doit rembourser toutes les primes précédentes","correct":false,"why_wrong":"Aucune règle de remboursement rétroactif."},{"text":"L''assureur perd tout droit à agir pénalement","correct":false,"why_wrong":"La voie pénale reste ouverte selon les infractions."}]'::jsonb, 2,
       'Art. 40 LCA : la dissimulation ou déclaration inexacte destinée à obtenir une prestation indue libère l''assureur du lien contractuel. Il peut aussi résilier et refuser la prestation.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'generales' AND t.key = 'litiges'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-GEN-LT-026', 'generales', t.id, 'multiple',
       'Un client hésite à souscrire une PJ et veut comprendre ce qui est réellement pris en charge.', 'Une assurance protection juridique privée couvre typiquement :', '[{"text":"Les honoraires d''avocat","correct":true},{"text":"Les frais judiciaires et de procédure","correct":true},{"text":"Les frais d''expertise nécessaires","correct":true},{"text":"Les amendes pénales","correct":false,"why_wrong":"Les amendes sont exclues (art. 92 al. 1 let. c CP a contrario, principe général)."},{"text":"Les dommages causés à un tiers par l''assuré","correct":false,"why_wrong":"Rôle de la RC, pas de la PJ."}]'::jsonb, 3,
       'PJ = prise en charge des frais liés à la défense juridique. Ne couvre pas la RC (rôle de la RC privée) ni les amendes/peines pénales.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'generales' AND t.key = 'litiges'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-GEN-LT-027', 'generales', t.id, 'single',
       NULL, 'Avant d''ouvrir une procédure civile ordinaire, une tentative de conciliation devant l''autorité de conciliation cantonale (art. 197 CPC) est :', '[{"text":"Facultative","correct":false,"why_wrong":"Elle est en principe obligatoire, avec quelques exceptions."},{"text":"En principe obligatoire, sauf exceptions prévues (art. 198 CPC)","correct":true},{"text":"Interdite en assurance","correct":false,"why_wrong":"Aucune interdiction : la conciliation civile reste applicable."},{"text":"Réservée aux causes de plus de 100''000 CHF","correct":false,"why_wrong":"Aucun seuil de ce type ; la conciliation est indépendante de la valeur litigieuse."}]'::jsonb, 1,
       'Art. 197-198 CPC : conciliation obligatoire préalable dans la plupart des cas civils. Exceptions : procédures sommaires, mesures provisionnelles, certaines matières particulières.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'generales' AND t.key = 'litiges'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-GEN-LT-028', 'generales', t.id, 'single',
       'Une assurance ménage indemnise un vol par effraction pour 20''000 CHF. La police est prise avec valeur à neuf, sans sous-assurance.', 'Comment appliquer le principe indemnitaire dans ce cas ?', '[{"text":"L''assureur verse la valeur à neuf convenue, jusqu''à concurrence du dommage effectif et de la somme d''assurance, sans permettre d''enrichissement","correct":true},{"text":"L''assureur peut verser le double de la valeur à neuf","correct":false,"why_wrong":"Contraire au principe indemnitaire."},{"text":"L''assureur ne verse rien si la somme d''assurance n''est pas atteinte","correct":false,"why_wrong":"Confusion avec la sous-assurance."},{"text":"La FINMA fixe le montant de l''indemnité","correct":false,"why_wrong":"La FINMA n''intervient pas dans le règlement de sinistres individuels."}]'::jsonb, 3,
       'Valeur à neuf = remplacement à l''équivalent. Reste plafonné au dommage réel et à la somme d''assurance. Pas d''enrichissement : principe indemnitaire (art. 96 LCA).', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'generales' AND t.key = 'litiges'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-GEN-LT-029', 'generales', t.id, 'single',
       NULL, 'Les frais d''avocat sont pris en charge par la PJ :', '[{"text":"Sans aucune limite ni cadre","correct":false,"why_wrong":"Toutes les PJ posent des plafonds et des conditions."},{"text":"Dans les limites contractuelles (montant maximal, choix de l''avocat selon règles LCA / LSA, cas assurés)","correct":true},{"text":"Uniquement en cas de succès judiciaire","correct":false,"why_wrong":"La couverture PJ ne dépend pas de l''issue du procès."},{"text":"Jamais si un règlement amiable est signé","correct":false,"why_wrong":"Faux : la PJ soutient aussi les règlements amiables."}]'::jsonb, 2,
       'PJ : couverture plafonnée, cas assurés définis, libre choix de l''avocat en principe (art. 32 LSA / dispositions harmonisées), pas d''obligation de gagner le procès.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'generales' AND t.key = 'litiges'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-GEN-LT-030', 'generales', t.id, 'single',
       NULL, 'L''ultime voie de recours contre un jugement cantonal en matière civile assurantielle est :', '[{"text":"Le recours au Tribunal fédéral (LTF)","correct":true},{"text":"Un recours à la FINMA","correct":false,"why_wrong":"FINMA n''est pas une instance de recours judiciaire."},{"text":"Un recours à l''ASA","correct":false,"why_wrong":"L''ASA n''est pas une juridiction."},{"text":"Un recours à l''Ombudsman","correct":false,"why_wrong":"L''Ombudsman n''a pas de compétence de révision de jugements."}]'::jsonb, 1,
       'Après épuisement des voies cantonales, recours au Tribunal fédéral (LTF art. 72 ss pour les affaires civiles), sous conditions (valeur litigieuse, question juridique de principe).', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'generales' AND t.key = 'litiges'
ON CONFLICT (external_id) DO NOTHING;

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

-- ───────── maladie_klary_bank.json — Banque Klary MALADIE COMPLÉMENTAIRE (PV2) 180 questions couvrant les 7 thèmes vides/creux (hors LAA déjà couvert). Préparation ciblée 7e tentative examen. ─────────
INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-MAL-LB-001', 'maladie_complementaire', t.id, 'multiple',
       'Nadia arrive à Genève depuis l''Espagne le 10 janvier 2026.', 'Dans quel délai toute personne prenant domicile en Suisse doit-elle s''affilier à une caisse-maladie AOS ?', '[{"text":"30 jours","correct":false,"why_wrong":"30 jours est le délai souvent confondu avec l''annonce d''un nouveau-né mais pas avec l''affiliation LAMal."},{"text":"3 mois","correct":true},{"text":"6 mois","correct":false,"why_wrong":"Aucun texte ne prévoit 6 mois : le délai légal est 3 mois (art. 3 LAMal)."},{"text":"1 an","correct":false},{"text":"La couverture prend effet rétroactivement à la prise de domicile","correct":true}]'::jsonb, 1,
       'Art. 3 LAMal : toute personne domiciliée en Suisse doit s''assurer pour les soins en cas de maladie dans les 3 mois qui suivent la prise de domicile ou la naissance.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'lamal_bases'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-MAL-LB-002', 'maladie_complementaire', t.id, 'multiple',
       'Sophie a accouché le 4 mars 2026. Elle hésite à annoncer son nouveau-né à sa caisse-maladie et pense avoir 30 jours.', 'Quel est le délai réel d''annonce d''un nouveau-né à la caisse-maladie AOS ?', '[{"text":"30 jours","correct":false,"why_wrong":"Piège classique : on confond avec un autre délai administratif. Le délai LAMal est 3 mois."},{"text":"3 mois","correct":true},{"text":"6 mois","correct":false,"why_wrong":"Pas de base légale à 6 mois."},{"text":"1 mois","correct":false,"why_wrong":"Le délai est 3 mois, pas 1 mois."},{"text":"La couverture démarre rétroactivement à la date de naissance","correct":true}]'::jsonb, 2,
       'Art. 3 LAMal : l''annonce du nouveau-né doit avoir lieu dans les 3 mois suivant la naissance. Avec un enregistrement rétroactif à la naissance, il n''y a aucun trou de couverture.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'lamal_bases'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-MAL-LB-003', 'maladie_complementaire', t.id, 'multiple',
       NULL, 'Quelle est la date de changement de caisse ordinaire pour l''AOS et quel préavis faut-il respecter ?', '[{"text":"1er janvier, préavis au 30 novembre","correct":true},{"text":"1er janvier, préavis au 31 décembre","correct":false,"why_wrong":"Le préavis doit parvenir à la caisse au 30 novembre au plus tard."},{"text":"1er avril, préavis 3 mois avant","correct":false,"why_wrong":"La date de changement est le 1er janvier."},{"text":"1er juillet uniquement","correct":false,"why_wrong":"Le 1er juillet n''est ouvert qu''en cas de hausse de prime."},{"text":"Possibilité complémentaire au 1er juillet en cas de hausse de prime (préavis 31.03)","correct":true}]'::jsonb, 1,
       'Art. 7 LAMal : changement au 1er janvier avec préavis parvenant à la caisse au 30 novembre. Possibilité complémentaire au 1er juillet en cas de hausse de prime (préavis 31 mars).', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'lamal_bases'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-MAL-LB-004', 'maladie_complementaire', t.id, 'multiple',
       'Marc reçoit en octobre un avis de hausse de prime AOS applicable au 1er janvier.', 'Quelle date de résiliation extraordinaire peut-il utiliser et jusqu''à quand doit-il envoyer son préavis ?', '[{"text":"1er juillet, préavis au 31 mars","correct":false,"why_wrong":"Le 1er juillet est réservé aux hausses de prime au 1er juillet, pas aux hausses au 1er janvier."},{"text":"1er janvier, préavis au 30 novembre","correct":true},{"text":"1er février, préavis au 31 décembre","correct":false,"why_wrong":"Aucune base légale pour février."},{"text":"N''importe quand, sans préavis","correct":false},{"text":"Résiliation adressée sous forme démontrable par texte à la caisse","correct":true}]'::jsonb, 2,
       'Art. 7 al. 2 LAMal : en cas de communication de hausse de prime, la caisse doit informer 2 mois avant, et l''assuré peut résilier pour le 31 décembre (effet 1er janvier) avec préavis au 30 novembre. La possibilité du 1er juillet vise les hausses en cours d''année.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'lamal_bases'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-MAL-LB-005', 'maladie_complementaire', t.id, 'multiple',
       NULL, 'Parmi les affirmations suivantes sur l''AOS, lesquelles sont exactes ?', '[{"text":"Les prestations AOS sont identiques d''une caisse à l''autre car fixées par la loi","correct":true},{"text":"Les primes AOS varient d''une caisse à l''autre et par région","correct":true},{"text":"Une caisse-maladie ne peut pas refuser une affiliation AOS","correct":true},{"text":"Les primes AOS sont identiques pour toutes les caisses d''un même canton","correct":false,"why_wrong":"Piège classique : ce sont les PRESTATIONS qui sont identiques, pas les primes."},{"text":"Une caisse peut refuser une personne pour raisons de santé en AOS","correct":false,"why_wrong":"L''AOS est obligatoire ET sans réserve de santé (art. 4 LAMal)."}]'::jsonb, 3,
       'Art. 24 LAMal (prestations identiques), art. 61 LAMal (primes par caisse et par région), art. 4 LAMal (interdiction de refus et de réserves en AOS). Ne pas confondre avec la LCA où l''assureur est libre.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'lamal_bases'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-MAL-LB-006', 'maladie_complementaire', t.id, 'multiple',
       'Un jeune adulte part au service long (école de recrue prolongée) pour 4 mois.', 'Quelle est la durée minimum de service militaire à partir de laquelle l''AOS peut être suspendue ?', '[{"text":"30 jours","correct":false,"why_wrong":"Le seuil légal est de plus de 60 jours."},{"text":"Plus de 60 jours","correct":true},{"text":"Plus de 90 jours","correct":false,"why_wrong":"Le seuil est fixé à plus de 60 jours par l''art. 3 al. 4 LAMal."},{"text":"Aucune suspension possible","correct":false},{"text":"La couverture est reprise par l''assurance militaire durant le service","correct":true}]'::jsonb, 1,
       'Art. 3 al. 4 LAMal : suspension possible de la couverture AOS pour les personnes accomplissant un service militaire de plus de 60 jours (couverture assurée par l''assurance militaire).', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'lamal_bases'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-MAL-LB-007', 'maladie_complementaire', t.id, 'multiple',
       NULL, 'Un assuré n''a pas payé plusieurs primes AOS et a fait l''objet d''une sommation. Peut-il changer de caisse au 1er janvier suivant ?', '[{"text":"Oui, sans condition","correct":false,"why_wrong":"La loi bloque le changement en cas d''arriérés notifiés."},{"text":"Non, l''ancienne caisse peut s''opposer au changement tant que les arriérés ne sont pas soldés","correct":true},{"text":"Oui, mais avec un préavis de 6 mois","correct":false},{"text":"Oui, mais uniquement chez une caisse publique","correct":false},{"text":"La caisse peut poursuivre la procédure de recouvrement au canton","correct":true}]'::jsonb, 2,
       'Art. 64a LAMal : la caisse peut refuser le changement en cas d''arriérés ayant fait l''objet d''une sommation ou d''actes de défaut de biens, jusqu''au paiement intégral. Objectif : éviter la fuite en avant.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'lamal_bases'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-MAL-LB-008', 'maladie_complementaire', t.id, 'multiple',
       NULL, 'Quelles personnes sont soumises à l''obligation d''affiliation AOS en Suisse ?', '[{"text":"Tout titulaire d''un permis B, C, L, F ou N domicilié en Suisse","correct":true},{"text":"Les enfants de parents domiciliés en Suisse","correct":true},{"text":"Les demandeurs d''asile","correct":true},{"text":"Les touristes en séjour de 2 semaines","correct":false,"why_wrong":"Aucun domicile en Suisse : pas d''obligation LAMal."},{"text":"Les diplomates étrangers accrédités en Suisse","correct":false,"why_wrong":"Exemption prévue pour le personnel diplomatique (art. 2 OAMal)."}]'::jsonb, 3,
       'Art. 3 LAMal + art. 1-2 OAMal : le critère est le domicile en Suisse. Les diplomates étrangers et certaines catégories très spécifiques sont exemptés. Les touristes ne sont pas concernés (pas de domicile).', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'lamal_bases'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-MAL-LB-009', 'maladie_complementaire', t.id, 'multiple',
       'Karim travaille en Suisse et vit en France comme frontalier.', 'Quel dispositif s''applique à sa couverture santé obligatoire ?', '[{"text":"Il est automatiquement affilié à l''AOS suisse","correct":false,"why_wrong":"Le frontalier bénéficie d''un droit d''option, pas d''une affiliation automatique."},{"text":"Il dispose d''un droit d''option entre AOS suisse et système français (CMU/assurance privée)","correct":true},{"text":"Il ne peut pas s''affilier à l''AOS suisse","correct":false,"why_wrong":"L''affiliation AOS est ouverte via le droit d''option."},{"text":"Il est obligatoirement affilié en France","correct":false},{"text":"Choix à formaliser dans les 3 mois de la prise d''emploi","correct":true}]'::jsonb, 2,
       'Accords bilatéraux CH-UE : les frontaliers CH/FR/DE/AT/IT disposent d''un droit d''option entre l''AOS suisse et l''assurance de leur pays de résidence. Choix à formaliser dans les 3 mois de la prise d''emploi.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'lamal_bases'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-MAL-LB-010', 'maladie_complementaire', t.id, 'multiple',
       'Deux voisins comparent leur prime AOS mensuelle et constatent des différences.', 'Le calcul des primes AOS repose principalement sur quel principe ?', '[{"text":"Prime individuelle par tête (per capita), indépendante du revenu","correct":true},{"text":"Prime proportionnelle au salaire","correct":false,"why_wrong":"Confusion avec les cotisations AVS/AI : la prime AOS n''est pas proportionnelle au revenu."},{"text":"Prime forfaitaire nationale unique","correct":false,"why_wrong":"La prime varie par canton, région et caisse."},{"text":"Prime fixée par l''employeur","correct":false},{"text":"Prime différenciée par canton et région (max 3 régions)","correct":true}]'::jsonb, 1,
       'Art. 61 LAMal : la prime AOS est perçue par tête (per capita), différenciée par canton, région de primes (max 3) et catégorie d''âge (enfant, jeune adulte 19-25 ans, adulte). Elle ne dépend pas du revenu.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'lamal_bases'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-MAL-LB-011', 'maladie_complementaire', t.id, 'multiple',
       NULL, 'Quelles catégories de primes AOS existent selon l''âge de l''assuré ?', '[{"text":"Enfants (0 à 18 ans)","correct":true},{"text":"Jeunes adultes (19 à 25 ans)","correct":true},{"text":"Adultes (dès 26 ans)","correct":true},{"text":"Seniors (dès 65 ans) avec prime majorée","correct":false,"why_wrong":"Pas de catégorie senior LAMal : la prime adulte reste stable après 25 ans."},{"text":"Étudiants avec prime spécifique","correct":false,"why_wrong":"Pas de tarif étudiant dédié : ils entrent dans la catégorie jeunes adultes."}]'::jsonb, 3,
       'Art. 61 al. 3 LAMal : trois catégories d''âge. Depuis 1996, aucune majoration en fonction de l''âge après 25 ans (interdiction de discriminer les seniors sur la prime AOS).', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'lamal_bases'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-MAL-LB-012', 'maladie_complementaire', t.id, 'multiple',
       NULL, 'Combien de régions de primes maximum un canton peut-il compter selon l''OFSP ?', '[{"text":"1","correct":false,"why_wrong":"La loi autorise jusqu''à 3 régions par canton."},{"text":"2","correct":false},{"text":"3","correct":true},{"text":"5","correct":false,"why_wrong":"Le plafond fixé par l''OFSP est de 3 régions."},{"text":"Zones urbaine, semi-urbaine, rurale possibles","correct":true}]'::jsonb, 1,
       'Art. 61 al. 2 LAMal + ordonnance OFSP : maximum 3 régions de primes par canton, distinguant zones urbaines, semi-urbaines et rurales selon les coûts effectifs.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'lamal_bases'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-MAL-LB-013', 'maladie_complementaire', t.id, 'multiple',
       'Bruno rédige la résiliation de sa caisse-maladie pour la 1re fois.', 'Sous quelle forme la résiliation d''une caisse AOS doit-elle être adressée pour être valable ?', '[{"text":"Verbalement par téléphone","correct":false,"why_wrong":"La forme écrite (recommandée) est requise pour la preuve."},{"text":"Par écrit, avec accusé de réception avant l''échéance","correct":true},{"text":"Par SMS","correct":false},{"text":"Par simple email non signé","correct":false,"why_wrong":"L''email brut ne prouve pas la réception dans les délais."},{"text":"Lettre recommandée avec preuve de réception recommandée","correct":true}]'::jsonb, 1,
       'Art. 7 LAMal : la résiliation doit parvenir à la caisse (pas seulement être envoyée) avant l''échéance. Pratique standard : lettre recommandée avec preuve de réception.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'lamal_bases'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-MAL-LB-014', 'maladie_complementaire', t.id, 'multiple',
       'Un futur retraité de 62 ans envisage de changer de caisse pour économiser.', 'En AOS, une caisse peut-elle imposer des réserves de santé lors de l''affiliation ?', '[{"text":"Oui, comme en LCA","correct":false,"why_wrong":"Confusion avec la LCA : en AOS, aucune réserve n''est possible."},{"text":"Non, jamais (interdiction absolue)","correct":true},{"text":"Oui, mais uniquement pour les nouveaux arrivants en Suisse","correct":false},{"text":"Oui, si l''assuré a plus de 55 ans","correct":false},{"text":"Ni examen médical, ni questionnaire de santé ne peuvent être exigés en AOS","correct":true}]'::jsonb, 1,
       'Art. 4 LAMal : les caisses AOS acceptent chaque personne domiciliée en Suisse SANS réserve, SANS examen médical, SANS refus. C''est un pilier du système obligatoire.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'lamal_bases'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-MAL-LB-015', 'maladie_complementaire', t.id, 'multiple',
       'Nadia (30 ans) veut changer de caisse au 1er janvier 2027 pour économiser sur sa prime.', 'Quelles conditions doit-elle respecter pour que le changement soit valable ?', '[{"text":"Envoyer sa résiliation avant le 30 novembre 2026 (réception effective)","correct":true},{"text":"Signer un contrat avec la nouvelle caisse avant la fin de l''année","correct":true},{"text":"Ne pas avoir d''arriérés de prime sommés à l''ancienne caisse","correct":true},{"text":"Obtenir l''accord écrit de son médecin traitant","correct":false,"why_wrong":"L''AOS ne dépend pas de considérations médicales : aucun accord médical requis."},{"text":"Attendre 12 mois d''ancienneté avant de pouvoir changer","correct":false,"why_wrong":"Aucun délai d''ancienneté n''est exigé."}]'::jsonb, 3,
       'Art. 7 et 64a LAMal : 3 conditions pratiques : préavis reçu au 30.11, adhésion à la nouvelle caisse continue, absence d''arriérés sommés. Piège de conseil : ne jamais résilier sans confirmation d''adhésion sinon risque d''affiliation d''office.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'lamal_bases'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-MAL-LB-016', 'maladie_complementaire', t.id, 'multiple',
       'Un jeune expatrié fraîchement installé oublie son affiliation LAMal.', 'Que se passe-t-il si une personne domiciliée en Suisse ne s''affilie pas dans les 3 mois ?', '[{"text":"Elle n''a plus le droit d''avoir la LAMal","correct":false,"why_wrong":"Elle sera affiliée d''office, pas exclue."},{"text":"Le canton (autorité désignée) l''affilie d''office à une caisse","correct":true},{"text":"Elle est automatiquement exemptée","correct":false},{"text":"Elle paie une amende de 5 000 CHF","correct":false,"why_wrong":"Sanction possible mais mesure principale = affiliation d''office."},{"text":"Les primes non payées peuvent être perçues rétroactivement","correct":true}]'::jsonb, 1,
       'Art. 6 LAMal : les cantons désignent une autorité pour affilier d''office toute personne qui ne respecte pas son obligation, avec effet rétroactif à la prise de domicile (primes dues). Objectif : universalité de la couverture.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'lamal_bases'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-MAL-LB-017', 'maladie_complementaire', t.id, 'multiple',
       'Une famille à revenus modestes reçoit une hausse de prime AOS.', 'Qui décide de l''octroi des subsides cantonaux pour la prime AOS ?', '[{"text":"La caisse-maladie","correct":false,"why_wrong":"La caisse encaisse la prime, elle ne décide pas des subsides."},{"text":"L''OFSP","correct":false,"why_wrong":"L''OFSP surveille les tarifs mais ne fixe pas les subsides individuels."},{"text":"Le canton (via son service dédié) selon des critères de revenu et fortune","correct":true},{"text":"L''employeur","correct":false},{"text":"La caisse-maladie n''a aucun pouvoir de décision sur l''octroi du subside","correct":true}]'::jsonb, 1,
       'Art. 65 LAMal : les cantons accordent des réductions de primes aux assurés de condition économique modeste selon leurs propres barèmes (revenu et fortune). Un client à revenus modestes doit être orienté vers son service cantonal.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'lamal_bases'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-MAL-LB-018', 'maladie_complementaire', t.id, 'multiple',
       NULL, 'Quels documents ou éléments prouvent l''existence d''une couverture AOS active ?', '[{"text":"La carte d''assuré délivrée par la caisse","correct":true},{"text":"La police AOS avec numéro d''affiliation","correct":true},{"text":"Une attestation de la caisse","correct":true},{"text":"Un simple bulletin de versement de prime","correct":false,"why_wrong":"Un bulletin de versement ne prouve pas la couverture, seulement une intention de paiement."},{"text":"La carte d''identité suisse","correct":false,"why_wrong":"La CI ne renseigne pas sur l''affiliation AOS."}]'::jsonb, 3,
       'Art. 42a LAMal : les assureurs remettent une carte d''assuré. Cette carte, la police et une attestation de la caisse font foi. Le bulletin de versement seul ne prouve rien.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'lamal_bases'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-MAL-LB-019', 'maladie_complementaire', t.id, 'multiple',
       'Bruno, 22 ans, étudiant à Genève, veut savoir dans quelle catégorie de prime AOS il se trouve.', 'À quelle catégorie tarifaire appartient-il ?', '[{"text":"Enfant (prime réduite jusqu''à 18 ans)","correct":false,"why_wrong":"Bruno a plus de 18 ans."},{"text":"Jeune adulte (19 à 25 ans)","correct":true},{"text":"Adulte (26 ans et plus)","correct":false,"why_wrong":"La catégorie adulte commence à 26 ans."},{"text":"Étudiant (tarif spécifique)","correct":false,"why_wrong":"Il n''existe pas de tarif étudiant dédié en LAMal."},{"text":"Le tarif jeune adulte est en général inférieur au tarif adulte plein","correct":true}]'::jsonb, 2,
       'Art. 61 al. 3 LAMal : la catégorie jeune adulte couvre les 19 à 25 ans révolus. Bruno relève de cette catégorie jusqu''à ses 26 ans. Le tarif jeune adulte est en général inférieur au tarif adulte plein.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'lamal_bases'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-MAL-LB-020', 'maladie_complementaire', t.id, 'multiple',
       NULL, 'L''AOS suisse couvre-t-elle un traitement médical pratiqué à titre non urgent aux États-Unis ?', '[{"text":"Oui, intégralement","correct":false,"why_wrong":"La LAMal ne couvre le hors-Suisse que pour l''urgence, plafonnée à 2× le tarif suisse (art. 36 OAMal)."},{"text":"Non, l''AOS ne couvre à l''étranger que les urgences","correct":true},{"text":"Oui, à 50 %","correct":false},{"text":"Uniquement dans les hôpitaux universitaires américains","correct":false},{"text":"Une LCA voyage/assistance est nécessaire pour couvrir le hors urgence","correct":true}]'::jsonb, 1,
       'Art. 34 LAMal + art. 36 OAMal : à l''étranger, l''AOS prend en charge uniquement les soins d''URGENCE au maximum au double du tarif suisse. Un traitement programmé aux États-Unis n''entre pas dans la couverture.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'lamal_bases'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-MAL-LB-021', 'maladie_complementaire', t.id, 'multiple',
       NULL, 'Quels systèmes de facturation coexistent dans le cadre de l''AOS ?', '[{"text":"Tiers payant : le fournisseur adresse la facture à la caisse","correct":true},{"text":"Tiers garant : l''assuré paie le fournisseur puis se fait rembourser","correct":true},{"text":"Facturation directe au patient uniquement","correct":false,"why_wrong":"Le patient n''est jamais le seul débiteur : la caisse rembourse ou paie directement."},{"text":"Facturation forfaitaire imposée par l''OFSP","correct":false},{"text":"Prépaiement obligatoire par la caisse","correct":false,"why_wrong":"Aucun système de prépaiement systématique en LAMal."}]'::jsonb, 3,
       'Art. 42 LAMal : deux systèmes coexistent. Tiers garant est le régime légal ordinaire pour les médecins ; le tiers payant est standard pour l''hospitalier et pharmacies. Conventions tarifaires précisent l''application.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'lamal_bases'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-MAL-LB-022', 'maladie_complementaire', t.id, 'multiple',
       NULL, 'Un assuré peut-il changer chaque année de franchise et de modèle d''assurance ?', '[{"text":"Non, la franchise est fixée à vie","correct":false,"why_wrong":"L''assuré peut ajuster sa franchise annuellement."},{"text":"Oui, à chaque 1er janvier avec préavis conforme","correct":true},{"text":"Une seule fois tous les 5 ans","correct":false},{"text":"Uniquement en cas de changement de caisse","correct":false,"why_wrong":"Le changement de franchise est possible même en restant dans la même caisse."},{"text":"Modification du modèle possible également au 1er janvier","correct":true}]'::jsonb, 1,
       'Art. 94 OAMal : possibilité de modifier la franchise et le modèle (médecin de famille, HMO, etc.) au 1er janvier avec préavis au 30 novembre à la caisse. Point de conseil clé pour optimiser la prime.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'lamal_bases'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-MAL-LB-023', 'maladie_complementaire', t.id, 'multiple',
       NULL, 'Un ressortissant suisse déménage à Berlin le 1er mai. Que devient son AOS ?', '[{"text":"Elle continue automatiquement","correct":false,"why_wrong":"L''AOS suit le domicile en Suisse : le départ met fin à l''obligation."},{"text":"Elle prend fin le jour du départ effectif (résiliation extraordinaire)","correct":true},{"text":"Elle reste valable 12 mois après le départ","correct":false},{"text":"Il doit continuer à payer la prime pendant 5 ans","correct":false},{"text":"L''assuré doit se couvrir dans son nouveau pays de résidence","correct":true}]'::jsonb, 2,
       'Art. 3 LAMal (couplé au domicile) : la fin du domicile en Suisse fait tomber l''obligation d''assurance. L''assuré résilie sur présentation de la preuve du départ. Il doit ensuite se couvrir dans le pays d''accueil.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'lamal_bases'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-MAL-LB-024', 'maladie_complementaire', t.id, 'multiple',
       NULL, 'Un employé suisse est envoyé en mission au Japon par son employeur pour 8 mois. Quel régime LAMal s''applique ?', '[{"text":"Il perd toute couverture LAMal","correct":false,"why_wrong":"La couverture peut être maintenue selon les règles de détachement."},{"text":"Il reste soumis à l''AOS suisse pendant sa mission temporaire (avec règles particulières de coordination)","correct":true},{"text":"Il doit obligatoirement s''affilier au Japon","correct":false},{"text":"Il bascule automatiquement en LCA voyage","correct":false,"why_wrong":"L''AOS ne devient jamais LCA voyage : le contrat de base subsiste."},{"text":"Une LCA voyage complémentaire est fortement recommandée pour le rapatriement","correct":true}]'::jsonb, 2,
       'Art. 3 LAMal + art. 4-5 OAMal : en cas de détachement temporaire par un employeur suisse, l''assuré reste soumis à l''AOS. Une LCA voyage complémentaire est fortement recommandée pour couvrir rapatriement et frais étrangers au-delà du plafond LAMal.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'lamal_bases'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-MAL-LB-025', 'maladie_complementaire', t.id, 'multiple',
       NULL, 'Quels acteurs jouent un rôle dans le système LAMal ?', '[{"text":"L''OFSP (surveillance, approbation des primes)","correct":true},{"text":"Les caisses-maladie agréées","correct":true},{"text":"Les cantons (réductions de primes, hôpitaux, planification)","correct":true},{"text":"La FINMA en tant qu''autorité d''approbation des primes AOS","correct":false,"why_wrong":"La FINMA surveille les assureurs privés (LCA), pas les primes AOS. C''est l''OFSP qui approuve les primes AOS."},{"text":"La CNA/SUVA en tant qu''assureur AOS","correct":false,"why_wrong":"La SUVA est un acteur LAA, pas LAMal."}]'::jsonb, 3,
       'Répartition classique : OFSP (approbation primes AOS, surveillance), caisses (mise en oeuvre), cantons (planification hospitalière, subsides). La FINMA se concentre sur LCA ; la SUVA sur LAA.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'lamal_bases'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-MAL-LB-026', 'maladie_complementaire', t.id, 'multiple',
       NULL, 'Les primes AOS 2026 augmentent-elles avec l''état de santé ou l''historique de sinistres de l''assuré ?', '[{"text":"Oui, un bonus/malus est appliqué","correct":false,"why_wrong":"Aucun bonus/malus n''est admis en AOS."},{"text":"Non, la prime est indépendante de l''état de santé et des sinistres","correct":true},{"text":"Oui, mais seulement en cas d''accident","correct":false},{"text":"Uniquement si l''assuré change de caisse","correct":false},{"text":"Prime uniforme dans une catégorie d''âge, canton et région donnés","correct":true}]'::jsonb, 1,
       'Art. 61 LAMal : la prime AOS est per capita, uniforme dans une catégorie d''âge, d''un canton et d''une région, indépendamment de la santé. Aucun bonus/malus n''est admis. En LCA en revanche, des rabais sinistralité peuvent exister.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'lamal_bases'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-MAL-LB-027', 'maladie_complementaire', t.id, 'multiple',
       'Lucia arrive à Zurich le 15 juin 2026 depuis l''Italie avec un permis B pour prendre un emploi.', 'Que doit-elle faire concernant l''AOS ?', '[{"text":"S''affilier à une caisse-maladie dans les 3 mois","correct":true},{"text":"La couverture prend effet rétroactivement au 15 juin (prise de domicile)","correct":true},{"text":"Choisir une franchise entre 300 et 2 500 CHF","correct":true},{"text":"Demander une exemption car elle est déjà couverte en Italie","correct":false,"why_wrong":"Le domicile en Suisse crée l''obligation. La couverture italienne cesse au départ."},{"text":"Attendre 6 mois pour évaluer les meilleures caisses","correct":false,"why_wrong":"Le délai est de 3 mois, pas 6."}]'::jsonb, 3,
       'Art. 3 LAMal + art. 5 al. 1 LAMal : affiliation obligatoire dans les 3 mois, effet rétroactif à la prise de domicile. Le choix de la franchise (300 à 2 500 CHF adulte) fait partie du contrat initial. Lucia doit compléter par une LCA santé complémentaire si elle veut plus.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'lamal_bases'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-MAL-LB-028', 'maladie_complementaire', t.id, 'multiple',
       NULL, 'Combien de caisses-maladie agréées LAMal existe-t-il approximativement en Suisse en 2026 ?', '[{"text":"Environ 5","correct":false,"why_wrong":"Le marché compte plusieurs dizaines d''acteurs."},{"text":"Environ 40 à 50 caisses","correct":true},{"text":"Plus de 500","correct":false},{"text":"1 seule (caisse unique nationale)","correct":false,"why_wrong":"L''initiative caisse unique a été refusée en 2014."},{"text":"Le marché a connu une concentration progressive ces 20 dernières années","correct":true}]'::jsonb, 1,
       'Le marché AOS compte environ 40 à 50 caisses agréées par l''OFSP en 2026 (concentration progressive). La caisse unique a été refusée en votation. Argument de vente : comparaison annuelle des primes.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'lamal_bases'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-MAL-LB-029', 'maladie_complementaire', t.id, 'multiple',
       NULL, 'Une caisse-maladie AOS peut-elle exiger un questionnaire de santé lors du changement d''affiliation ?', '[{"text":"Oui, comme pour la LCA","correct":false,"why_wrong":"Confusion LCA/AOS : le questionnaire santé est propre à la LCA."},{"text":"Non, jamais en AOS","correct":true},{"text":"Oui, uniquement pour les personnes de plus de 60 ans","correct":false},{"text":"Uniquement pour les modèles alternatifs","correct":false,"why_wrong":"Les modèles alternatifs sont un choix contractuel, sans questionnaire de santé."},{"text":"L''AOS accueille chaque personne domiciliée sans condition de santé","correct":true}]'::jsonb, 2,
       'Art. 4 LAMal : interdiction pour l''AOS de discriminer selon la santé. Aucun questionnaire n''est admis. La LCA au contraire fonde la prime et la police sur les déclarations de santé (réserves possibles).', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'lamal_bases'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-MAL-LB-030', 'maladie_complementaire', t.id, 'multiple',
       NULL, 'Que doit vérifier un conseiller avant qu''un client résilie son AOS pour changer de caisse ?', '[{"text":"Que la nouvelle caisse a accepté l''affiliation par écrit avant l''échéance","correct":true},{"text":"L''absence d''arriérés de primes sommés à l''ancienne caisse","correct":true},{"text":"Le respect du préavis (30.11 pour effet au 1er janvier)","correct":true},{"text":"L''accord du médecin traitant du client","correct":false,"why_wrong":"Sans objet en AOS."},{"text":"L''acceptation d''un questionnaire de santé par la nouvelle caisse","correct":false,"why_wrong":"Aucun questionnaire n''est admis en AOS."}]'::jsonb, 3,
       'Bonnes pratiques de conseil (art. 45 LSA, devoir d''information) : garantir la continuité (jamais de trou de couverture), vérifier les arriérés (blocage art. 64a LAMal), respecter le calendrier. Confusion LCA/AOS à éviter.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'lamal_bases'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-MAL-LC-001', 'maladie_complementaire', t.id, 'multiple',
       'Sarah, 27 ans, souhaite comprendre la franchise minimum de son AOS.', 'Quelle est la franchise minimum ordinaire AOS pour un adulte en 2026 ?', '[{"text":"0 CHF","correct":false,"why_wrong":"0 CHF est le minimum pour les enfants, pas pour les adultes."},{"text":"300 CHF","correct":true},{"text":"500 CHF","correct":false,"why_wrong":"500 CHF est un choix de franchise à option, pas le minimum légal."},{"text":"1 000 CHF","correct":false},{"text":"La franchise 300 CHF est la franchise ordinaire adulte (art. 103 OAMal)","correct":true}]'::jsonb, 1,
       'Art. 64 LAMal + art. 103 OAMal : franchise ordinaire adulte = 300 CHF (minimum légal). Franchises à option : 500, 1 000, 1 500, 2 000, 2 500 CHF (rabais de prime croissant).', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'lamal_couts'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-MAL-LC-002', 'maladie_complementaire', t.id, 'multiple',
       NULL, 'Quelle est la franchise maximum à option pour un adulte en 2026 ?', '[{"text":"1 500 CHF","correct":false,"why_wrong":"1 500 CHF est une option intermédiaire."},{"text":"2 000 CHF","correct":false},{"text":"2 500 CHF","correct":true},{"text":"3 000 CHF","correct":false,"why_wrong":"Le maximum légal reste 2 500 CHF pour l''adulte."},{"text":"Rabais de prime croissant en contrepartie du risque financier assumé","correct":true}]'::jsonb, 1,
       'Art. 103 OAMal : franchise maximum adulte = 2 500 CHF. Choix : 300 / 500 / 1 000 / 1 500 / 2 000 / 2 500 CHF.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'lamal_couts'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-MAL-LC-003', 'maladie_complementaire', t.id, 'multiple',
       NULL, 'Quelle est la franchise maximum à option pour un enfant en 2026 ?', '[{"text":"0 CHF","correct":false,"why_wrong":"0 CHF est le minimum enfant, pas le maximum."},{"text":"300 CHF","correct":false},{"text":"600 CHF","correct":true},{"text":"1 000 CHF","correct":false,"why_wrong":"1 000 CHF n''existe pas pour les enfants."},{"text":"La franchise enfant ordinaire est 0 CHF","correct":true}]'::jsonb, 1,
       'Art. 103 al. 2 OAMal : franchise enfant de 0 (ordinaire) à 600 CHF maximum. Paliers : 0 / 100 / 200 / 300 / 400 / 500 / 600 CHF.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'lamal_couts'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-MAL-LC-004', 'maladie_complementaire', t.id, 'single',
       'Sarah cumule des soins ambulatoires importants tout au long de l''année.', 'Quel est le plafond annuel de la quote-part LAMal pour un adulte ?', '[{"text":"500 CHF","correct":false,"why_wrong":"Aucune base légale à 500 CHF."},{"text":"700 CHF","correct":true},{"text":"1 000 CHF","correct":false,"why_wrong":"1 000 CHF est parfois confondu mais le plafond légal est 700."},{"text":"2 500 CHF","correct":false,"why_wrong":"2 500 est la franchise adulte maximum, pas le plafond de la quote-part."}]'::jsonb, 2,
       'Art. 64 al. 2 LAMal + art. 103 al. 2 OAMal : quote-part 10 % après franchise, plafonnée à 700 CHF/an pour les adultes. Au-delà, la caisse rembourse 100 %.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'lamal_couts'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-MAL-LC-005', 'maladie_complementaire', t.id, 'multiple',
       NULL, 'Quel est le plafond annuel de la quote-part LAMal pour un enfant ?', '[{"text":"350 CHF","correct":true},{"text":"500 CHF","correct":false,"why_wrong":"500 CHF n''existe pas comme plafond enfant."},{"text":"700 CHF","correct":false,"why_wrong":"700 est le plafond adulte, pas enfant."},{"text":"175 CHF","correct":false},{"text":"Le plafond enfant est exactement la moitié du plafond adulte","correct":true}]'::jsonb, 1,
       'Art. 103 OAMal : plafond quote-part enfant = 350 CHF/an (moitié du plafond adulte). Piège classique : ne pas confondre avec le plafond adulte.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'lamal_couts'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-MAL-LC-006', 'maladie_complementaire', t.id, 'single',
       'Ahmed (adulte, franchise 300) accumule 10 000 CHF de soins couverts en 2026.', 'Combien paiera-t-il de sa poche au total (franchise + quote-part) ?', '[{"text":"300 CHF","correct":false,"why_wrong":"La quote-part 10 % s''ajoute (plafonnée)."},{"text":"1 000 CHF","correct":true},{"text":"1 270 CHF","correct":false,"why_wrong":"La quote-part est plafonnée à 700 CHF (art. 64 LAMal), pas 970."},{"text":"1 700 CHF","correct":false,"why_wrong":"Le plafond de quote-part est 700 CHF/an adulte."}]'::jsonb, 2,
       'Art. 64 LAMal : franchise 300 + quote-part 10 % sur 9 700 = 970 mais plafonnée à 700. Total = 300 + 700 = 1 000 CHF (coût max annuel adulte franchise ordinaire, hors hospit 15 CHF/jour).', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'lamal_couts'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-MAL-LC-007', 'maladie_complementaire', t.id, 'single',
       'Marta (adulte, franchise 300) engendre 15 000 CHF de frais AOS en 2026.', 'Quel est son coût total à sa charge (franchise + quote-part) ?', '[{"text":"300 CHF","correct":false,"why_wrong":"La quote-part 10 % s''ajoute (plafonnée)."},{"text":"1 000 CHF (300 franchise + 700 plafond quote-part)","correct":true},{"text":"1 500 CHF","correct":false,"why_wrong":"Le plafond de quote-part bloque à 700."},{"text":"2 700 CHF","correct":false,"why_wrong":"10 % de 15 000 = 1 500 mais plafonné à 700."}]'::jsonb, 2,
       'Art. 64 LAMal : franchise 300 + quote-part 10 % sur 14 700 = 1 470 mais plafonnée à 700 CHF. Coût max annuel adulte franchise ordinaire = 300 + 700 = 1 000 CHF (hors hospit 15 CHF/jour).', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'lamal_couts'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-MAL-LC-008', 'maladie_complementaire', t.id, 'single',
       'Louis (adulte, franchise 2 500) engendre 20 000 CHF de frais AOS en 2026.', 'Coût maximum total à sa charge ?', '[{"text":"2 500 CHF","correct":false,"why_wrong":"Il faut ajouter la quote-part."},{"text":"3 200 CHF (2 500 + 700)","correct":true},{"text":"5 000 CHF","correct":false,"why_wrong":"Plafond quote-part 700 empêche ce montant."},{"text":"700 CHF","correct":false}]'::jsonb, 2,
       'Coût max adulte franchise 2 500 = franchise 2 500 + plafond quote-part 700 = 3 200 CHF/an (hors hospit). Argument de vente pour LCA hospit ou LCA franchise complémentaire.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'lamal_couts'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-MAL-LC-009', 'maladie_complementaire', t.id, 'multiple',
       'Ahmed est hospitalisé pour une opération non urgente en division commune.', 'Quelle est la contribution journalière aux frais de séjour hospitalier pour un adulte AOS ?', '[{"text":"10 CHF/jour","correct":false,"why_wrong":"Le montant fixé par l''OAMal est 15 CHF."},{"text":"15 CHF/jour","correct":true},{"text":"25 CHF/jour","correct":false},{"text":"50 CHF/jour","correct":false,"why_wrong":"50 CHF/jour est une somme parfois trouvée en LCA hospit, pas AOS."},{"text":"Cette contribution s''ajoute à la franchise et à la quote-part","correct":true}]'::jsonb, 1,
       'Art. 104 OAMal : contribution de 15 CHF par jour d''hospitalisation à charge de l''assuré adulte. Cette contribution s''ajoute à la franchise et à la quote-part sans plafond spécifique.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'lamal_couts'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-MAL-LC-010', 'maladie_complementaire', t.id, 'multiple',
       NULL, 'Qui est exempté de la contribution hospitalière de 15 CHF/jour ?', '[{"text":"Les enfants","correct":true},{"text":"Les jeunes adultes en formation (jusqu''à 25 ans)","correct":true},{"text":"Les femmes en séjour lié à la maternité","correct":true},{"text":"Les personnes âgées de plus de 65 ans","correct":false,"why_wrong":"Pas d''exonération liée à l''âge après 26 ans."},{"text":"Les patients avec franchise à 2 500 CHF","correct":false,"why_wrong":"Le choix de franchise n''exempte pas de la contribution hospit."}]'::jsonb, 3,
       'Art. 104 OAMal : sont exemptés les enfants (0-18), les jeunes adultes en formation (19-25) et les femmes pour les prestations de maternité. Adulte lambda paie 15 CHF/jour.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'lamal_couts'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-MAL-LC-011', 'maladie_complementaire', t.id, 'multiple',
       NULL, 'Quelle quote-part s''applique aux médicaments originaux quand un générique de moins de 20 % moins cher existe ?', '[{"text":"10 %","correct":false,"why_wrong":"10 % est la quote-part ordinaire, mais elle passe à 40 % si l''assuré refuse le générique."},{"text":"20 %","correct":false},{"text":"40 %","correct":true},{"text":"50 %","correct":false,"why_wrong":"Aucune base légale à 50 %."},{"text":"Levier pédagogique en conseil pour orienter vers le générique","correct":true}]'::jsonb, 1,
       'Art. 38a OPAS : quote-part portée à 40 % (au lieu de 10 %) sur les médicaments originaux si un générique nettement moins cher existe et que l''assuré demande néanmoins l''original. Levier pédagogique en conseil.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'lamal_couts'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-MAL-LC-012', 'maladie_complementaire', t.id, 'multiple',
       'Un client interroge son conseiller sur le principe du médecin de famille.', 'Le principe du modèle médecin de famille repose sur :', '[{"text":"Un rabais de prime en échange de l''engagement de consulter d''abord son médecin de famille","correct":true},{"text":"Une couverture élargie sans restriction","correct":false,"why_wrong":"Le rabais s''obtient contre une restriction, jamais une extension."},{"text":"Un remboursement à 100 % sans franchise","correct":false},{"text":"L''interdiction d''aller à l''hôpital","correct":false,"why_wrong":"L''urgence hospitalière reste toujours ouverte."},{"text":"L''urgence hospitalière reste toujours ouverte sans passage préalable","correct":true}]'::jsonb, 1,
       'Art. 41 al. 4 LAMal : modèles alternatifs (médecin de famille, HMO, télémédecine) offrent un rabais de prime en contrepartie d''une restriction du libre choix. Toujours détailler les exceptions (urgence, gynécologie, ophtalmologie) en conseil.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'lamal_couts'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-MAL-LC-013', 'maladie_complementaire', t.id, 'multiple',
       NULL, 'Quels modèles alternatifs LAMal existent typiquement sur le marché suisse ?', '[{"text":"Médecin de famille (Hausarzt)","correct":true},{"text":"HMO (centre médical)","correct":true},{"text":"Télémédecine (appel préalable)","correct":true},{"text":"Modèle premium sans restriction avec rabais 30 %","correct":false,"why_wrong":"Aucun rabais sans contrepartie de restriction."},{"text":"Modèle direct hôpital","correct":false,"why_wrong":"Aucun modèle alternatif n''oriente d''abord vers l''hôpital."}]'::jsonb, 3,
       'Art. 41 al. 4 LAMal : trois modèles alternatifs standards. Rabais typiques : 10 à 20 % de la prime standard. Piège : ne pas oublier les exceptions d''urgence dans l''entretien de vente.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'lamal_couts'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-MAL-LC-014', 'maladie_complementaire', t.id, 'single',
       'Sarah (30 ans) choisit le modèle télémédecine avec rabais 15 %. Elle consulte directement un spécialiste sans passer par l''appel préalable.', 'Quelle est la conséquence ?', '[{"text":"Aucune, la prestation est prise en charge normalement","correct":false,"why_wrong":"La violation contractuelle a des conséquences."},{"text":"La caisse peut refuser ou réduire la prise en charge selon le règlement","correct":true},{"text":"Elle perd sa couverture AOS complète","correct":false,"why_wrong":"L''AOS de base subsiste, seul le rabais/modèle est en cause."},{"text":"Elle doit rembourser 3 ans de primes","correct":false}]'::jsonb, 2,
       'Art. 41 al. 4 LAMal + règlement de la caisse : le non-respect du modèle alternatif peut entraîner une prise en charge selon le tarif standard sans rabais, voire une non-prise en charge. À expliciter au client à la signature.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'lamal_couts'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-MAL-LC-015', 'maladie_complementaire', t.id, 'multiple',
       NULL, 'Quelles prestations sont EXEMPTÉES de participation aux coûts (franchise ET quote-part) en AOS ?', '[{"text":"Les prestations de maternité au sens de l''art. 29 LAMal","correct":true},{"text":"Certaines prestations préventives listées par l''OPAS (dépistage, vaccinations couvertes)","correct":true},{"text":"Les prestations liées à une IVG légale","correct":true},{"text":"Toutes les consultations chez un généraliste","correct":false,"why_wrong":"Une consultation ordinaire est soumise à franchise + quote-part."},{"text":"L''hospitalisation ordinaire","correct":false,"why_wrong":"L''hospit est soumise franchise + quote-part + 15 CHF/jour."}]'::jsonb, 3,
       'Art. 64 al. 7 LAMal : maternité et IVG exemptes. Art. 26 LAMal + OPAS : certaines prestations préventives également (mammographie, coloscopie de dépistage selon règles). Point de vente maternité clé.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'lamal_couts'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-MAL-LC-016', 'maladie_complementaire', t.id, 'multiple',
       'Un assuré demande à quelle date reprendre ses soins programmés en fin d''année.', 'À quelle fréquence la franchise se réinitialise-t-elle ?', '[{"text":"Tous les 1er janvier (année civile)","correct":true},{"text":"À la date anniversaire du contrat","correct":false,"why_wrong":"La franchise LAMal suit l''année civile, pas l''anniversaire."},{"text":"Tous les 3 mois","correct":false},{"text":"Une seule fois pour toute la durée du contrat","correct":false,"why_wrong":"Elle se réinitialise chaque année."},{"text":"Le plafond de quote-part se calcule aussi sur l''année civile","correct":true}]'::jsonb, 1,
       'Art. 64 LAMal : franchise et plafond de quote-part se calculent sur l''année civile (1er janvier au 31 décembre). Argumentaire : consulter en fin d''année si franchise atteinte, sinon reporter début d''année suivante.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'lamal_couts'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-MAL-LC-017', 'maladie_complementaire', t.id, 'multiple',
       NULL, 'Quels choix de franchise adulte AOS existent en 2026 ?', '[{"text":"300 CHF","correct":true},{"text":"500 CHF","correct":true},{"text":"1 500 CHF","correct":true},{"text":"2 500 CHF","correct":true},{"text":"3 000 CHF","correct":false,"why_wrong":"3 000 CHF n''existe pas, plafond légal 2 500."}]'::jsonb, 3,
       'Art. 103 OAMal : les 6 paliers adulte sont 300 / 500 / 1 000 / 1 500 / 2 000 / 2 500 CHF. Rabais de prime croissant en contrepartie du risque financier.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'lamal_couts'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-MAL-LC-018', 'maladie_complementaire', t.id, 'multiple',
       NULL, 'Quels choix de franchise enfant AOS existent en 2026 ?', '[{"text":"0 CHF","correct":true},{"text":"100 CHF","correct":true},{"text":"300 CHF","correct":true},{"text":"600 CHF","correct":true},{"text":"1 000 CHF","correct":false,"why_wrong":"Pas de palier au-dessus de 600 CHF pour les enfants."}]'::jsonb, 1,
       'Art. 103 al. 2 OAMal : franchise enfant = 0 / 100 / 200 / 300 / 400 / 500 / 600 CHF. La franchise 0 est la norme pour un enfant.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'lamal_couts'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-MAL-LC-019', 'maladie_complementaire', t.id, 'single',
       NULL, 'Un cumul franchise à option ET modèle alternatif est-il possible sur le même contrat AOS ?', '[{"text":"Non, on doit choisir entre les deux","correct":false,"why_wrong":"Le cumul est admis."},{"text":"Oui, les rabais se cumulent pour réduire la prime","correct":true},{"text":"Uniquement si l''assuré a plus de 40 ans","correct":false},{"text":"Uniquement pour la franchise 300","correct":false}]'::jsonb, 2,
       'Art. 62 LAMal + art. 93a OAMal : les caisses admettent le cumul franchise à option + modèle alternatif, cumulant les rabais. Optimisation classique de conseil pour clients en bonne santé.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'lamal_couts'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-MAL-LC-020', 'maladie_complementaire', t.id, 'multiple',
       'Un client insiste pour obtenir un bonus fidélité 5 ans sans sinistre.', 'Un rabais de prime AOS peut-il être accordé pour bonne santé ou absence de sinistre ?', '[{"text":"Oui, chaque caisse peut le prévoir","correct":false,"why_wrong":"L''AOS n''admet ni bonus/malus, ni tarification à l''état de santé."},{"text":"Non, les seuls rabais admis sont la franchise à option et le modèle alternatif","correct":true},{"text":"Oui, à hauteur de 10 % après 5 ans sans sinistre","correct":false},{"text":"Uniquement pour les jeunes adultes","correct":false},{"text":"Aucun rabais fidélité admis en AOS (contrairement à la LCA)","correct":true}]'::jsonb, 1,
       'Art. 61 LAMal : primes uniformes. Seuls la franchise à option (art. 62) et les modèles alternatifs (art. 41 al. 4) donnent droit à rabais. Contrairement à la LCA où bonus/malus et rabais fidélité existent.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'lamal_couts'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-MAL-LC-021', 'maladie_complementaire', t.id, 'multiple',
       'Un client demande à changer sa franchise du 300 au 2 500 en cours d''année (juillet).', 'Peut-il le faire ?', '[{"text":"Oui, à tout moment avec préavis 30 jours","correct":false,"why_wrong":"Aucun changement en cours d''année."},{"text":"Non, le changement de franchise ne prend effet qu''au 1er janvier suivant, préavis 30 novembre","correct":true},{"text":"Oui, mais uniquement en cas de sinistre","correct":false},{"text":"Oui, au 1er juillet avec préavis 31 mars","correct":false,"why_wrong":"La possibilité de juillet est réservée à la résiliation en cas de hausse de prime, pas à un changement de franchise."},{"text":"Modification également possible avec le changement de caisse au 1er janvier","correct":true}]'::jsonb, 2,
       'Art. 94 OAMal : la modification de franchise est possible au 1er janvier avec préavis au 30 novembre. Un souhait de baisse de franchise en cours d''année n''est pas admis (protection anti-sélection).', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'lamal_couts'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-MAL-LC-022', 'maladie_complementaire', t.id, 'multiple',
       'Jean (10 ans, franchise 0) est hospitalisé 20 jours pour une opération programmée.', 'Quelle contribution hospitalière lui sera demandée ?', '[{"text":"300 CHF (20 x 15)","correct":false,"why_wrong":"Les enfants sont exemptés de la contribution 15 CHF/jour."},{"text":"0 CHF","correct":true},{"text":"700 CHF","correct":false,"why_wrong":"700 est le plafond quote-part adulte, sans rapport avec la contribution enfant."},{"text":"150 CHF","correct":false},{"text":"Les jeunes adultes en formation sont également exemptés (jusqu''à 25 ans)","correct":true}]'::jsonb, 2,
       'Art. 104 OAMal : les enfants sont exemptés de la contribution journalière hospitalière de 15 CHF. Seule la quote-part 10 % (plafonnée à 350) peut s''appliquer sur la partie ambulatoire ou couverte.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'lamal_couts'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-MAL-LC-023', 'maladie_complementaire', t.id, 'multiple',
       'Léa (28 ans, franchise 1 500) accumule 3 000 CHF de frais AOS en 2026 dont 500 CHF de médicaments originaux (générique 10 % moins cher disponible).', 'Comment se répartit sa participation aux coûts ?', '[{"text":"Elle paie l''intégralité des 1 500 CHF de franchise","correct":true},{"text":"Sur les 1 500 CHF restants (hors médicaments originaux), quote-part 10 % = 150 CHF (plafonnée à 700 : effective)","correct":true},{"text":"Sur les 500 CHF de médicaments originaux, quote-part 40 % = 200 CHF (soumis au plafond global 700)","correct":true},{"text":"Aucune franchise car il s''agit de médicaments","correct":false,"why_wrong":"La franchise s''applique aux médicaments comme au reste."},{"text":"Plafond quote-part 350 CHF adulte","correct":false,"why_wrong":"Plafond adulte = 700, pas 350."}]'::jsonb, 3,
       'Art. 64 LAMal + art. 38a OPAS : franchise 1 500 puis quote-part différenciée (10 % standard, 40 % originaux). Total = 1 500 + 150 + 200 = 1 850 CHF (plafond 700 non atteint). Cas typique VBV.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'lamal_couts'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-MAL-LC-024', 'maladie_complementaire', t.id, 'multiple',
       NULL, 'Vrai ou faux : la franchise LAMal s''applique aussi aux prestations de maternité ?', '[{"text":"Vrai","correct":false,"why_wrong":"Piège classique : les prestations de maternité sont exemptes."},{"text":"Faux, les prestations de maternité sont exemptes de franchise ET de quote-part","correct":true},{"text":"Vrai, sauf pour les femmes de moins de 25 ans","correct":false},{"text":"Vrai, sauf en cas d''accouchement à domicile","correct":false},{"text":"Argument fort à mettre en avant lors du conseil grossesse","correct":true}]'::jsonb, 2,
       'Art. 64 al. 7 LAMal : les prestations de maternité (art. 29 LAMal) sont exemptes de franchise et de quote-part. Argument fort en conseil grossesse.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'lamal_couts'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-MAL-LC-025', 'maladie_complementaire', t.id, 'multiple',
       NULL, 'Quel est le rabais de prime typique offert par un modèle alternatif (fourchette indicative marché suisse) ?', '[{"text":"0 à 5 %","correct":false,"why_wrong":"Trop faible : les modèles offrent en moyenne 10 à 20 %."},{"text":"10 à 20 % de la prime standard","correct":true},{"text":"30 à 50 %","correct":false,"why_wrong":"Rabais irréaliste."},{"text":"Toujours 25 % fixes","correct":false},{"text":"Chaque assureur communique sa propre grille de rabais","correct":true}]'::jsonb, 1,
       'Le marché suisse propose des rabais typiques de 10 à 20 % pour les modèles médecin de famille, HMO ou télémédecine. Argument commercial standard, à documenter avec les grilles de la caisse.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'lamal_couts'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-MAL-LC-026', 'maladie_complementaire', t.id, 'multiple',
       NULL, 'Une consultation ambulatoire est-elle soumise à la contribution hospitalière de 15 CHF/jour ?', '[{"text":"Oui","correct":false,"why_wrong":"La contribution 15 CHF/jour ne concerne que le séjour hospitalier stationnaire."},{"text":"Non, uniquement pour un séjour hospitalier stationnaire","correct":true},{"text":"Uniquement pour les consultations en urgence","correct":false},{"text":"Uniquement pour les adultes de plus de 55 ans","correct":false},{"text":"La contribution ne s''applique donc pas aux consultations ambulatoires","correct":true}]'::jsonb, 1,
       'Art. 104 OAMal : la contribution de 15 CHF/jour vise le séjour stationnaire hospitalier. L''ambulatoire est soumis à franchise + quote-part uniquement.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'lamal_couts'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-MAL-LC-027', 'maladie_complementaire', t.id, 'multiple',
       NULL, 'Quels leviers un conseiller peut-il utiliser pour réduire la prime AOS d''un client jeune en bonne santé ?', '[{"text":"Augmenter la franchise à option (jusqu''à 2 500 CHF)","correct":true},{"text":"Choisir un modèle alternatif (médecin de famille, HMO, télémédecine)","correct":true},{"text":"Comparer les primes entre caisses agréées","correct":true},{"text":"Souscrire une LCA hospitalisation privée","correct":false,"why_wrong":"La LCA ne réduit pas la prime AOS, elle ajoute une couverture."},{"text":"Demander un rabais fidélité","correct":false,"why_wrong":"Pas de rabais fidélité en AOS."}]'::jsonb, 3,
       '3 leviers légaux : franchise à option, modèle alternatif, changement de caisse. Toujours documenter le breakeven (franchise 2 500 = risque max 3 200 CHF/an contre économie de prime).', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'lamal_couts'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-MAL-LC-028', 'maladie_complementaire', t.id, 'multiple',
       NULL, 'Un adulte franchise 1 500 dépense 800 CHF de frais AOS dans l''année. Combien lui reste-t-il à charge ?', '[{"text":"800 CHF (car en dessous de la franchise)","correct":true},{"text":"80 CHF (quote-part 10 %)","correct":false,"why_wrong":"La franchise 1 500 n''est pas atteinte : tout est à charge."},{"text":"150 CHF","correct":false},{"text":"700 CHF (plafond quote-part)","correct":false,"why_wrong":"Sans dépasser la franchise, la quote-part ne s''applique pas."},{"text":"Impact conseil : franchise haute = risque de payer plus en petit sinistre","correct":true}]'::jsonb, 2,
       'Art. 64 LAMal : tant que le total annuel des frais reste inférieur à la franchise, tout est à charge de l''assuré. Pas de quote-part avant franchise atteinte. Impact conseil : franchise haute = risque de payer plus si petit sinistre.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'lamal_couts'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-MAL-LC-029', 'maladie_complementaire', t.id, 'multiple',
       NULL, 'La prime AOS d''un enfant est-elle plus élevée ou plus basse qu''un adulte ?', '[{"text":"Plus élevée","correct":false,"why_wrong":"Le tarif enfant est réduit."},{"text":"Plus basse (rabais légal important)","correct":true},{"text":"Identique","correct":false},{"text":"Nulle jusqu''à 18 ans","correct":false,"why_wrong":"L''AOS enfant a une prime, réduite mais non nulle."},{"text":"Les jeunes adultes (19-25) bénéficient aussi d''un tarif réduit","correct":true}]'::jsonb, 1,
       'Art. 61 al. 3 LAMal : les enfants (0-18) paient une prime nettement réduite (souvent 20 à 25 % du tarif adulte). Les jeunes adultes 19-25 bénéficient aussi d''un tarif réduit.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'lamal_couts'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-MAL-LC-030', 'maladie_complementaire', t.id, 'multiple',
       'Marie, 32 ans, en bonne santé, envisage franchise 2 500 CHF + modèle télémédecine + changement de caisse pour 2027.', 'Quels points le conseiller doit-il vérifier avec elle ?', '[{"text":"Sa capacité financière à assumer 3 200 CHF en cas de gros sinistre (2 500 + 700)","correct":true},{"text":"Sa compréhension de la restriction du modèle télémédecine (appel préalable)","correct":true},{"text":"Le respect du préavis 30 novembre 2026 pour effet 1er janvier 2027","correct":true},{"text":"L''absence d''arriérés de primes sommés à l''ancienne caisse","correct":true},{"text":"Le questionnaire de santé de la nouvelle caisse","correct":false,"why_wrong":"Aucun questionnaire en AOS."}]'::jsonb, 3,
       'Combinaison classique d''optimisation : gain de prime significatif contre risque financier et restriction contractuelle. À documenter dans le PV de conseil pour couvrir la responsabilité du conseiller (art. 45 LSA).', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'lamal_couts'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-MAL-LP-001', 'maladie_complementaire', t.id, 'multiple',
       'Un conseiller réexplique à un client où trouver la définition des prestations AOS.', 'Sur quel article repose le catalogue des prestations de l''AOS ?', '[{"text":"Art. 3 LAMal","correct":false,"why_wrong":"Art. 3 traite de l''obligation d''assurance."},{"text":"Art. 25 LAMal","correct":true},{"text":"Art. 45 LAMal","correct":false,"why_wrong":"Art. 45 régit le rapport avec les fournisseurs."},{"text":"Art. 64 LAMal","correct":false,"why_wrong":"Art. 64 traite de la participation aux coûts."},{"text":"Complété par l''OPAS et la LiMA pour le détail","correct":true}]'::jsonb, 1,
       'Art. 25 LAMal : catalogue général des prestations (mesures diagnostiques et thérapeutiques). Complété par l''OPAS (ordonnance sur les prestations) et la LiMA.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'lamal_prestations'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-MAL-LP-002', 'maladie_complementaire', t.id, 'multiple',
       NULL, 'Quel article LAMal régit les prestations de maternité ?', '[{"text":"Art. 25 LAMal","correct":false,"why_wrong":"Art. 25 = catalogue général."},{"text":"Art. 29 LAMal","correct":true},{"text":"Art. 36 LAMal","correct":false,"why_wrong":"Art. 36 traite du service à l''étranger."},{"text":"Art. 42 LAMal","correct":false},{"text":"Prestations exemptes de participation aux coûts (art. 64 al. 7)","correct":true}]'::jsonb, 1,
       'Art. 29 LAMal : catalogue spécifique de la maternité (contrôles prénatals, accouchement, conseils d''allaitement, cours de préparation jusqu''à 150 CHF, contrôle post-partum).', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'lamal_prestations'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-MAL-LP-003', 'maladie_complementaire', t.id, 'multiple',
       NULL, 'Que couvre spécifiquement l''AOS au titre des prestations de maternité (art. 29) ?', '[{"text":"Les contrôles prénataux prévus","correct":true},{"text":"L''accouchement (sage-femme, médecin, hôpital)","correct":true},{"text":"Les conseils d''allaitement","correct":true},{"text":"Le cours de préparation à l''accouchement jusqu''à 150 CHF","correct":true},{"text":"Un forfait allaitement de 200 CHF","correct":false,"why_wrong":"Aucun forfait 200 CHF : c''est un piège classique."}]'::jsonb, 3,
       'Art. 29 LAMal : 4 postes couverts (contrôles, accouchement, conseils allaitement, cours prépa max 150 CHF). Ne pas oublier que ces prestations sont EXEMPTES de franchise et quote-part (art. 64 al. 7).', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'lamal_prestations'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-MAL-LP-004', 'maladie_complementaire', t.id, 'multiple',
       'Emma est enceinte et effectue un contrôle prénatal ordinaire à la 20e semaine.', 'Quelle participation aux coûts lui sera-t-elle demandée ?', '[{"text":"Franchise + quote-part 10 %","correct":false,"why_wrong":"Piège majeur : les prestations de maternité sont exemptes."},{"text":"Aucune (exemption franchise ET quote-part)","correct":true},{"text":"Quote-part 10 % uniquement","correct":false,"why_wrong":"Exempte de tout."},{"text":"Franchise 300 CHF uniquement","correct":false},{"text":"Point de vente majeur en conseil grossesse","correct":true}]'::jsonb, 2,
       'Art. 64 al. 7 LAMal : les prestations de maternité au sens de l''art. 29 sont exemptes de participation aux coûts. Point de vente majeur en conseil grossesse.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'lamal_prestations'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-MAL-LP-005', 'maladie_complementaire', t.id, 'multiple',
       'Fabien, en vacances à Montréal, se casse une jambe et est traité localement.', 'Un traitement médical URGENT est reçu par un assuré suisse en vacances au Canada. Comment l''AOS intervient-elle ?', '[{"text":"Prise en charge intégrale du tarif canadien","correct":false,"why_wrong":"Le plafond légal est le double du tarif suisse."},{"text":"Prise en charge urgence uniquement, plafonnée au double du tarif suisse","correct":true},{"text":"Aucune couverture","correct":false,"why_wrong":"L''urgence est bien couverte."},{"text":"Prise en charge complète et rapatriement inclus","correct":false,"why_wrong":"Rapatriement JAMAIS couvert par LAMal."},{"text":"Le rapatriement reste à charge d''une LCA voyage","correct":true}]'::jsonb, 2,
       'Art. 36 OAMal : à l''étranger, l''AOS couvre uniquement l''urgence, au maximum au DOUBLE du tarif suisse. Rapatriement toujours à la charge d''une LCA voyage. Piège VBV classique.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'lamal_prestations'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-MAL-LP-006', 'maladie_complementaire', t.id, 'multiple',
       NULL, 'Vrai ou faux : le rapatriement médical depuis l''étranger est pris en charge par la LAMal ?', '[{"text":"Vrai, dans la limite du double du tarif suisse","correct":false,"why_wrong":"Le rapatriement n''est jamais couvert par la LAMal."},{"text":"Faux, jamais (relève d''une LCA voyage ou assistance)","correct":true},{"text":"Vrai, mais uniquement en Europe","correct":false},{"text":"Vrai, mais soumis à une franchise supplémentaire","correct":false},{"text":"La LAMal couvre uniquement les frais médicaux d''urgence (double tarif suisse)","correct":true}]'::jsonb, 2,
       'Art. 36 OAMal : la LAMal couvre les frais médicaux d''urgence à l''étranger. Le rapatriement (transport) est TOUJOURS exclu et relève d''une assurance voyage LCA. Piège VBV majeur.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'lamal_prestations'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-MAL-LP-007', 'maladie_complementaire', t.id, 'multiple',
       NULL, 'Sur quelle liste sont inscrits les médicaments remboursés par l''AOS ?', '[{"text":"La liste des spécialités (LS) de l''OFSP","correct":true},{"text":"La liste FINMA","correct":false,"why_wrong":"La FINMA ne gère pas la liste des médicaments."},{"text":"Le catalogue de Swissmedic uniquement","correct":false,"why_wrong":"Swissmedic autorise mais ne fixe pas le remboursement."},{"text":"La liste des caisses-maladie","correct":false},{"text":"Swissmedic autorise la mise sur le marché en amont","correct":true}]'::jsonb, 1,
       'Art. 52 LAMal + OPAS : les médicaments remboursés sont ceux inscrits sur la Liste des Spécialités (LS) tenue par l''OFSP, avec prix maximum. Swissmedic autorise la mise sur le marché, l''OFSP décide du remboursement.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'lamal_prestations'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-MAL-LP-008', 'maladie_complementaire', t.id, 'multiple',
       NULL, 'Quelles disciplines de médecine complémentaire sont couvertes par l''AOS (sous conditions) ?', '[{"text":"Acupuncture","correct":true},{"text":"Médecine anthroposophique","correct":true},{"text":"Homéopathie","correct":true},{"text":"Phytothérapie","correct":true},{"text":"Ostéopathie","correct":false,"why_wrong":"L''ostéopathie n''est pas dans les 5 disciplines couvertes AOS ordinaire (LCA uniquement)."}]'::jsonb, 3,
       'Art. 35 LAMal + OPAS : 5 disciplines de médecine complémentaire couvertes par l''AOS sous conditions (acupuncture, médecine anthroposophique, homéopathie, phytothérapie, MTC) si dispensées par un médecin FMH avec certification. Ostéopathie et naturopathie = LCA.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'lamal_prestations'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-MAL-LP-009', 'maladie_complementaire', t.id, 'multiple',
       NULL, 'Un adulte a-t-il droit au remboursement de ses lunettes par l''AOS ?', '[{"text":"Oui, jusqu''à 300 CHF/an","correct":false,"why_wrong":"Aucune couverture pour adultes en AOS ordinaire."},{"text":"Non, sauf en cas de maladie oculaire spécifique documentée","correct":true},{"text":"Oui, tous les 2 ans","correct":false},{"text":"Oui, sur prescription","correct":false,"why_wrong":"Les lunettes adulte relèvent de la LCA."},{"text":"Sur prescription en cas de pathologie oculaire spécifique","correct":true}]'::jsonb, 2,
       'Art. 25 LAMal + OPAS : plus de forfait annuel adulte depuis 2011. Les lunettes adultes relèvent d''une LCA. Exception : lésion médicale grave (post-opératoire, pathologie spécifique) prise en charge sur prescription.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'lamal_prestations'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-MAL-LP-010', 'maladie_complementaire', t.id, 'multiple',
       NULL, 'Quel montant annuel maximal l''AOS rembourse-t-elle pour les lunettes des enfants (jusqu''à 18 ans) ?', '[{"text":"0 CHF (comme adulte)","correct":false,"why_wrong":"Les enfants ont un forfait légal."},{"text":"180 CHF/an sur prescription médicale","correct":true},{"text":"500 CHF/an","correct":false,"why_wrong":"Le forfait légal est 180 CHF."},{"text":"300 CHF tous les 2 ans","correct":false},{"text":"Sur prescription ophtalmologique, pour les moins de 18 ans","correct":true}]'::jsonb, 1,
       'OPAS art. 3c : 180 CHF/an maximum pour les moins de 18 ans, sur prescription ophtalmologique. Piège : ne concerne QUE les enfants.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'lamal_prestations'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-MAL-LP-011', 'maladie_complementaire', t.id, 'single',
       'Jean demande si un traitement de racine dentaire est remboursé AOS.', 'Le traitement dentaire ordinaire est-il couvert par l''AOS ?', '[{"text":"Oui, à 50 %","correct":false,"why_wrong":"Aucune couverture dentaire ordinaire en AOS."},{"text":"Non, sauf traitement rendu nécessaire par une maladie grave non évitable (art. 31 LAMal)","correct":true},{"text":"Oui, jusqu''à 500 CHF/an","correct":false},{"text":"Oui, uniquement l''orthodontie enfant","correct":false}]'::jsonb, 2,
       'Art. 31 LAMal : les soins dentaires ordinaires ne sont pas couverts. Exceptions : maladie grave non évitable du système masticateur, maladie systémique ayant provoqué l''atteinte, séquelles d''accident (LAA). Sinon LCA dentaire.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'lamal_prestations'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-MAL-LP-012', 'maladie_complementaire', t.id, 'multiple',
       NULL, 'Quelles prestations préventives sont typiquement couvertes par l''AOS ?', '[{"text":"Vaccinations recommandées par l''OFSP","correct":true},{"text":"Mammographie de dépistage selon programme cantonal","correct":true},{"text":"Coloscopie de dépistage à partir de 50 ans (conditions OPAS)","correct":true},{"text":"Cures thermales de bien-être","correct":false,"why_wrong":"Les cures thermales de bien-être ne sont pas remboursées AOS (LCA uniquement)."},{"text":"Abonnement fitness","correct":false,"why_wrong":"Fitness relève de la LCA uniquement."}]'::jsonb, 3,
       'Art. 26 LAMal + OPAS : catalogue de mesures préventives limitatif (vaccinations, dépistages ciblés). Cures et fitness sont clairement LCA.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'lamal_prestations'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-MAL-LP-013', 'maladie_complementaire', t.id, 'single',
       NULL, 'L''allocation de maternité (revenu pendant le congé) relève-t-elle de la LAMal ?', '[{"text":"Oui, elle est versée par la caisse-maladie","correct":false,"why_wrong":"Piège majeur : LAMal couvre les prestations médicales, pas le revenu."},{"text":"Non, elle relève de la LAPG (14 semaines, 80 %, max 220 CHF/jour)","correct":true},{"text":"Oui, elle est financée par la quote-part","correct":false},{"text":"Non, elle relève de l''assurance-chômage","correct":false}]'::jsonb, 1,
       'LAPG : allocation maternité = 14 semaines, 80 % du revenu, plafond 220 CHF/jour (2026). La LAMal couvre uniquement les prestations médicales (art. 29). Piège VBV majeur.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'lamal_prestations'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-MAL-LP-014', 'maladie_complementaire', t.id, 'multiple',
       NULL, 'Quelles prestations la LAMal exclut-elle expressément (couverture LCA nécessaire) ?', '[{"text":"Chirurgie oculaire au laser (LASIK) purement esthétique/de confort","correct":true},{"text":"Soins dentaires ordinaires","correct":true},{"text":"Rapatriement médical depuis l''étranger","correct":true},{"text":"Vaccinations recommandées OFSP","correct":false,"why_wrong":"Les vaccinations recommandées sont couvertes AOS."},{"text":"Prestations d''urgence en Suisse","correct":false,"why_wrong":"Les urgences en Suisse sont couvertes."}]'::jsonb, 3,
       'LASIK confort, dentaire ordinaire, rapatriement = LCA. Vaccinations OFSP et urgences en Suisse sont couvertes AOS. Argumentaire vente LCA.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'lamal_prestations'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-MAL-LP-015', 'maladie_complementaire', t.id, 'single',
       NULL, 'Combien de séances de physiothérapie l''AOS rembourse-t-elle par prescription initiale avant réévaluation ?', '[{"text":"3 séances","correct":false,"why_wrong":"Le paquet standard est plus long."},{"text":"9 séances","correct":true},{"text":"20 séances","correct":false,"why_wrong":"20 nécessite une nouvelle prescription."},{"text":"50 séances","correct":false}]'::jsonb, 2,
       'OPAS : 9 séances par prescription initiale de physiothérapie couvertes AOS. Renouvellement possible sur nouvelle prescription médicale. Au-delà, prise de position du médecin-conseil.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'lamal_prestations'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-MAL-LP-016', 'maladie_complementaire', t.id, 'single',
       'Marc a besoin d''un suivi psychologique post-burnout via un psychologue non médecin.', 'L''AOS couvre-t-elle la psychothérapie non médicale (psychologue) ?', '[{"text":"Non, jamais","correct":false,"why_wrong":"Depuis 2022, remboursement possible sous conditions."},{"text":"Oui depuis 2022, sur prescription médicale, avec fournisseur reconnu","correct":true},{"text":"Oui, sans conditions","correct":false},{"text":"Uniquement pour les enfants","correct":false}]'::jsonb, 1,
       'Modèle de prescription (dès 2022) : la psychothérapie déléguée à un psychologue-psychothérapeute reconnu est couverte AOS sur prescription médicale, avec conditions d''exercice OFSP.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'lamal_prestations'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-MAL-LP-017', 'maladie_complementaire', t.id, 'single',
       NULL, 'Quel est le plafond de remboursement AOS pour le transport médical (autre que sauvetage) ?', '[{"text":"50 % des frais, max 500 CHF/an","correct":true},{"text":"100 % des frais","correct":false,"why_wrong":"Ni 100 %, ni sans plafond."},{"text":"Illimité","correct":false},{"text":"1 000 CHF/an","correct":false,"why_wrong":"Le plafond OPAS est 500 CHF/an."}]'::jsonb, 1,
       'OPAS : 50 % des frais de transport médicalement nécessaire, plafonnés à 500 CHF/an. Le sauvetage a un plafond distinct de 5 000 CHF (50 % des frais).', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'lamal_prestations'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-MAL-LP-018', 'maladie_complementaire', t.id, 'single',
       NULL, 'Quel est le plafond de remboursement AOS pour un sauvetage (montagne, mer, etc.) ?', '[{"text":"50 % des frais, max 500 CHF/an","correct":false,"why_wrong":"500 CHF = transport ordinaire, pas sauvetage."},{"text":"50 % des frais, max 5 000 CHF/an","correct":true},{"text":"Illimité","correct":false},{"text":"100 % des frais","correct":false,"why_wrong":"L''AOS rembourse la moitié, pas la totalité."}]'::jsonb, 1,
       'OPAS : sauvetage = 50 % des frais avec plafond 5 000 CHF/an. Argument classique en faveur d''une LCA voyage/rapatriement (frais réels très supérieurs).', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'lamal_prestations'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-MAL-LP-019', 'maladie_complementaire', t.id, 'single',
       NULL, 'Un nouveau-né est-il couvert immédiatement à la naissance ?', '[{"text":"Non, il faut attendre 30 jours","correct":false,"why_wrong":"La couverture est effective rétroactivement dès la naissance."},{"text":"Oui, l''affiliation rétroactive dès la naissance couvre les soins (à condition d''annoncer dans les 3 mois)","correct":true},{"text":"Il est couvert par l''assurance de la mère à vie","correct":false,"why_wrong":"Il doit avoir sa propre affiliation."},{"text":"Non, jusqu''à 3 mois révolus","correct":false}]'::jsonb, 2,
       'Art. 3 LAMal : l''affiliation rétroactive à la naissance couvre l''ensemble des frais dès le jour 1 si annoncée dans les 3 mois. Nécessite de choisir la caisse et la franchise du nouveau-né rapidement.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'lamal_prestations'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-MAL-LP-020', 'maladie_complementaire', t.id, 'multiple',
       'Jean, 55 ans, part en vacances en Thaïlande. Il souffre d''une crise cardiaque et est hospitalisé 10 jours à Bangkok, puis rapatrié en jet médicalisé (coût 60 000 CHF).', 'Comment se répartissent les prises en charge ?', '[{"text":"AOS : hospitalisation d''urgence, plafonnée à 2 x le tarif suisse (art. 36 OAMal)","correct":true},{"text":"AOS : franchise et quote-part appliquées normalement","correct":true},{"text":"Rapatriement : à la charge d''une LCA voyage/assistance ou de Jean","correct":true},{"text":"AOS : rapatriement intégralement pris en charge","correct":false,"why_wrong":"Piège absolu : rapatriement JAMAIS AOS."},{"text":"Aucune couverture AOS en Thaïlande","correct":false,"why_wrong":"L''urgence est bien couverte, plafonnée."}]'::jsonb, 3,
       'Art. 36 OAMal : urgence à l''étranger couverte au double du tarif suisse. Rapatriement (60 000 CHF !) toujours hors LAMal. Argumentaire massif LCA voyage/assistance : les 60 000 CHF sont totalement à charge sans couverture privée.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'lamal_prestations'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-MAL-LP-021', 'maladie_complementaire', t.id, 'single',
       NULL, 'Un traitement à l''étranger PROGRAMMÉ (non urgent) peut-il être pris en charge par l''AOS ?', '[{"text":"Oui, dans tous les cas","correct":false,"why_wrong":"Le principe est celui de la territorialité."},{"text":"Non, sauf dérogation OFSP exceptionnelle (traitement non disponible en Suisse)","correct":true},{"text":"Oui, si le coût est inférieur au tarif suisse","correct":false},{"text":"Oui, uniquement en Europe","correct":false}]'::jsonb, 1,
       'Art. 34 LAMal + art. 36a OAMal : la LAMal couvre les soins prodigués en Suisse (principe de territorialité). Dérogation possible pour un traitement non disponible en Suisse et sur autorisation préalable.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'lamal_prestations'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-MAL-LP-022', 'maladie_complementaire', t.id, 'multiple',
       NULL, 'Quels types de fournisseurs peuvent facturer à l''AOS (art. 35 et suivants) ?', '[{"text":"Médecins agréés","correct":true},{"text":"Pharmacies conventionnées","correct":true},{"text":"Hôpitaux figurant sur la liste cantonale","correct":true},{"text":"Naturopathes non médecins","correct":false,"why_wrong":"Les naturopathes ne sont pas fournisseurs LAMal (LCA uniquement)."},{"text":"Coach fitness certifié","correct":false,"why_wrong":"Le fitness n''est pas un fournisseur LAMal."}]'::jsonb, 3,
       'Art. 35-40 LAMal : liste limitative des fournisseurs admis (médecins, pharmaciens, hôpitaux, sages-femmes, physio, ergo, chiro, diététicien, etc.). Naturopathes et coachs = LCA.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'lamal_prestations'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-MAL-LP-023', 'maladie_complementaire', t.id, 'single',
       NULL, 'Une IVG légale est-elle prise en charge par l''AOS et avec quelle participation ?', '[{"text":"Non, non couverte","correct":false,"why_wrong":"L''IVG légale est prise en charge AOS."},{"text":"Oui, exempte de franchise et de quote-part (art. 64 al. 7 LAMal)","correct":true},{"text":"Oui, avec franchise et quote-part normales","correct":false,"why_wrong":"Exempte comme la maternité."},{"text":"Uniquement remboursée par le canton","correct":false}]'::jsonb, 2,
       'Art. 30 LAMal + art. 64 al. 7 : IVG légale prise en charge et exempte de participation aux coûts, au même titre que les prestations de maternité.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'lamal_prestations'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-MAL-LP-024', 'maladie_complementaire', t.id, 'single',
       NULL, 'Quelle organisation autorise la mise sur le marché des médicaments en Suisse ?', '[{"text":"L''OFSP","correct":false,"why_wrong":"L''OFSP décide du remboursement (LS), pas de la mise sur le marché."},{"text":"Swissmedic","correct":true},{"text":"La FINMA","correct":false,"why_wrong":"La FINMA surveille les assurances privées."},{"text":"Santésuisse","correct":false,"why_wrong":"Santésuisse est une association de caisses."}]'::jsonb, 1,
       'Swissmedic autorise la mise sur le marché (sécurité, efficacité). L''OFSP décide de l''inscription sur la Liste des Spécialités (remboursement AOS) avec prix maximum.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'lamal_prestations'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-MAL-LP-025', 'maladie_complementaire', t.id, 'single',
       NULL, 'Un ambulancier facture 800 CHF pour un transport médical d''urgence. Combien l''AOS rembourse-t-elle ?', '[{"text":"800 CHF (100 %)","correct":false,"why_wrong":"L''AOS ne prend que 50 % avec plafond 500 CHF/an transport."},{"text":"400 CHF (50 %), sous plafond 500 CHF/an","correct":true},{"text":"0 CHF","correct":false},{"text":"5 000 CHF (plafond sauvetage)","correct":false,"why_wrong":"5 000 = sauvetage, pas transport."}]'::jsonb, 2,
       'OPAS : transport médical AOS = 50 % des frais, max 500 CHF/an. Sur 800 CHF : 400 CHF pris en charge (dans le plafond). Argument LCA transport/rapatriement pour combler.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'lamal_prestations'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-MAL-LP-026', 'maladie_complementaire', t.id, 'single',
       NULL, 'Combien de temps une femme peut-elle bénéficier de conseils d''allaitement remboursés par la LAMal ?', '[{"text":"1 mois après l''accouchement","correct":false,"why_wrong":"La durée est plus longue."},{"text":"Jusqu''à 3 séances (art. 29 LAMal + OPAS)","correct":true},{"text":"1 an","correct":false},{"text":"Aucune couverture","correct":false,"why_wrong":"Prestation clairement couverte."}]'::jsonb, 2,
       'Art. 29 LAMal + OPAS art. 16 : 3 séances de conseils d''allaitement dispensées par une sage-femme, infirmière ou personne formée. Sans franchise ni quote-part.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'lamal_prestations'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-MAL-LP-027', 'maladie_complementaire', t.id, 'single',
       NULL, 'Un contrôle gynécologique préventif est-il remboursé par l''AOS ?', '[{"text":"Oui, tous les ans intégralement","correct":false,"why_wrong":"Fréquence encadrée."},{"text":"Oui, tous les 3 ans (frottis PAP inclus)","correct":true},{"text":"Non, uniquement en cas de symptôme","correct":false},{"text":"Uniquement à partir de 50 ans","correct":false}]'::jsonb, 1,
       'OPAS : contrôle gynécologique préventif tous les 3 ans (frottis cytologique). Franchise et quote-part s''appliquent (contrairement à la maternité).', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'lamal_prestations'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-MAL-LP-028', 'maladie_complementaire', t.id, 'multiple',
       NULL, 'Que couvre spécifiquement la LAMal en cas de maladie ?', '[{"text":"Le diagnostic et le traitement médical","correct":true},{"text":"Les médicaments de la Liste des Spécialités","correct":true},{"text":"L''hospitalisation en division commune du canton de résidence","correct":true},{"text":"L''indemnité journalière obligatoire en cas d''incapacité de travail","correct":false,"why_wrong":"L''IJM LAMal est FACULTATIVE (art. 67)."},{"text":"L''allocation de maternité","correct":false,"why_wrong":"APG, pas LAMal."}]'::jsonb, 3,
       'Art. 25 LAMal : catalogue des prestations en nature (diagnostic, traitement, médicaments LS, hospitalisation division commune). L''IJM LAMal est facultative. L''allocation maternité relève de la LAPG.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'lamal_prestations'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-MAL-LP-029', 'maladie_complementaire', t.id, 'single',
       NULL, 'Une consultation chez un ostéopathe est-elle prise en charge par l''AOS ?', '[{"text":"Oui, sans conditions","correct":false,"why_wrong":"L''ostéopathie n''est pas dans le catalogue AOS."},{"text":"Non, elle relève d''une LCA (médecine complémentaire)","correct":true},{"text":"Oui, dans les 5 disciplines couvertes","correct":false,"why_wrong":"L''ostéopathie ne fait pas partie des 5 disciplines couvertes."},{"text":"Oui, jusqu''à 500 CHF/an","correct":false}]'::jsonb, 1,
       'OPAS : les 5 disciplines LAMal sont acupuncture, médecine anthroposophique, homéopathie, phytothérapie, médecine traditionnelle chinoise. Ostéopathie et naturopathie = LCA médecine complémentaire.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'lamal_prestations'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-MAL-LP-030', 'maladie_complementaire', t.id, 'multiple',
       'Fatou attend son 2e enfant. Elle demande à son conseiller ce qui est couvert par la LAMal et ce qui ne l''est pas.', 'Quelles réponses le conseiller doit-il apporter ?', '[{"text":"Contrôles prénataux, accouchement, conseils d''allaitement : couverts et exemptés de participation aux coûts","correct":true},{"text":"Cours de préparation à l''accouchement : jusqu''à 150 CHF","correct":true},{"text":"Allocation maternité (revenu) : par la LAPG, non LAMal","correct":true},{"text":"Chambre privée ou semi-privée : nécessite une LCA hospitalisation","correct":true},{"text":"Rapatriement en cas de complication à l''étranger : couvert par LAMal","correct":false,"why_wrong":"Rapatriement JAMAIS LAMal (LCA voyage)."}]'::jsonb, 3,
       'Rappels art. 29 + 64 al. 7 LAMal + LAPG. Argumentaire complet grossesse : LAMal pour prestations médicales, LAPG pour le revenu, LCA hospitalisation pour le confort. Le conseiller structure une offre cohérente.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'lamal_prestations'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-MAL-LX-001', 'maladie_complementaire', t.id, 'single',
       'Un client refusé par un assureur LCA demande à un conseiller les motifs.', 'En LCA santé complémentaire, l''assureur peut-il refuser une proposition sans indiquer de motif ?', '[{"text":"Non, refus interdit","correct":false,"why_wrong":"Confusion avec l''AOS : la LCA est libre."},{"text":"Oui, la liberté contractuelle s''applique (contrairement à l''AOS)","correct":true},{"text":"Oui, mais uniquement pour raisons financières","correct":false},{"text":"Uniquement pour les personnes de plus de 60 ans","correct":false}]'::jsonb, 1,
       'Principe LCA : liberté contractuelle. L''assureur peut refuser sans motiver, poser des réserves, ou fixer une prime majorée. Contraste net avec l''art. 4 LAMal (obligation d''accepter en AOS).', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'lca_complementaires'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-MAL-LX-002', 'maladie_complementaire', t.id, 'single',
       NULL, 'Quel est le délai légal de révocation d''une proposition d''assurance LCA ?', '[{"text":"7 jours","correct":false,"why_wrong":"Le délai légal est 14 jours."},{"text":"14 jours (art. 2a LCA)","correct":true},{"text":"1 mois","correct":false},{"text":"2 mois","correct":false,"why_wrong":"Piège classique : on confond avec un autre délai. La bonne référence est 14 jours."}]'::jsonb, 2,
       'Art. 2a LCA : le preneur peut révoquer sa proposition ou son acceptation par écrit ou sous forme démontrable par texte dans les 14 jours. Piège récurrent : ne pas confondre avec 2 mois.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'lca_complementaires'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-MAL-LX-003', 'maladie_complementaire', t.id, 'single',
       NULL, 'Une réticence (fausses déclarations au questionnaire de santé) permet à l''assureur de :', '[{"text":"Doubler la prime rétroactivement","correct":false,"why_wrong":"La sanction est la résiliation, non le doublement."},{"text":"Résilier le contrat dans les 4 semaines après connaissance (art. 6 LCA)","correct":true},{"text":"Aucune conséquence","correct":false},{"text":"Uniquement refuser le sinistre concerné","correct":false,"why_wrong":"Sanction plus large : résiliation du contrat."}]'::jsonb, 2,
       'Art. 6 LCA : en cas de réticence, l''assureur peut résilier le contrat dans les 4 semaines dès qu''il en a connaissance. Il peut aussi refuser les prestations liées. Objectif : sanctionner la mauvaise foi.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'lca_complementaires'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-MAL-LX-004', 'maladie_complementaire', t.id, 'multiple',
       NULL, 'En LCA santé complémentaire, quelles pratiques sont autorisées à l''assureur ?', '[{"text":"Refuser une proposition sans motiver","correct":true},{"text":"Poser des réserves de santé (exclusions temporaires ou permanentes)","correct":true},{"text":"Majorer la prime en fonction du risque","correct":true},{"text":"Résilier au 1er sinistre sans motif","correct":false,"why_wrong":"La résiliation au sinistre a été supprimée par la LCA révisée en 2022."},{"text":"Recueillir des données médicales sans consentement","correct":false,"why_wrong":"Consentement requis (nLPD, art. 5-6)."}]'::jsonb, 3,
       'Liberté contractuelle LCA vs contrôle nLPD. La LCA révisée (2022) a supprimé le droit de résiliation en cas de sinistre pour les branches d''importance sociale (santé notamment). Réserves possibles, jamais dissimulées.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'lca_complementaires'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-MAL-LX-005', 'maladie_complementaire', t.id, 'single',
       'Un client accidenté possède 2 LCA hospit et cherche à cumuler les remboursements.', 'Le principe indemnitaire en LCA signifie que :', '[{"text":"L''assuré ne peut pas être indemnisé au-delà du dommage effectif (pas d''enrichissement)","correct":true},{"text":"L''assuré est payé forfaitairement","correct":false,"why_wrong":"Le forfaitaire (assurance de sommes) suit une autre logique."},{"text":"L''assuré perçoit toujours le double du sinistre","correct":false},{"text":"Aucune prestation n''est due tant que le sinistre n''est pas total","correct":false}]'::jsonb, 2,
       'Principe indemnitaire LCA : la prestation ne peut excéder le dommage. Pas de double indemnisation par cumul de contrats sur un même sinistre. À distinguer de l''assurance de sommes (vie, IJ forfaitaire) où le forfait est libre.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'lca_complementaires'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-MAL-LX-006', 'maladie_complementaire', t.id, 'single',
       NULL, 'L''ordre à respecter absolument avant de résilier une ancienne LCA santé est :', '[{"text":"Résilier d''abord, puis chercher un nouveau contrat","correct":false,"why_wrong":"Erreur majeure : risque de trou de couverture sans acceptation confirmée."},{"text":"Obtenir l''acceptation écrite de la nouvelle LCA AVANT de résilier l''ancienne","correct":true},{"text":"Résilier simultanément","correct":false},{"text":"Aucun ordre à respecter","correct":false}]'::jsonb, 1,
       'Règle d''or du conseil LCA : ne JAMAIS résilier avant l''acceptation écrite de la nouvelle police, y compris des réserves éventuelles. Un client refusé après résiliation se retrouve sans couverture complémentaire (santé antérieure exclue à vie possible).', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'lca_complementaires'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-MAL-LX-007', 'maladie_complementaire', t.id, 'single',
       NULL, 'Un client demande une LCA hospitalisation privée. Cette catégorie signifie :', '[{"text":"Chambre à 2 lits, choix limité du médecin","correct":false,"why_wrong":"C''est la définition demi-privée."},{"text":"Chambre individuelle, libre choix du médecin dans l''hôpital","correct":true},{"text":"Chambre commune, sans supplément","correct":false,"why_wrong":"La division commune est couverte par l''AOS."},{"text":"Chambre à 4 lits","correct":false}]'::jsonb, 2,
       'LCA hospitalisation : demi-privée (chambre 2 lits + choix médecin) et privée (chambre individuelle + libre choix médecin). L''AOS ne couvre que la division commune du canton de résidence.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'lca_complementaires'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-MAL-LX-008', 'maladie_complementaire', t.id, 'multiple',
       NULL, 'Quels avantages typiques offre une LCA hospitalisation demi-privée par rapport à la division commune AOS ?', '[{"text":"Chambre à 2 lits","correct":true},{"text":"Choix restreint du médecin/spécialiste","correct":true},{"text":"Prise en charge dans l''ensemble de la Suisse (pas seulement canton de résidence)","correct":true},{"text":"Réduction de la prime AOS de 50 %","correct":false,"why_wrong":"Pas d''impact sur la prime AOS."},{"text":"Gratuité de la franchise AOS","correct":false,"why_wrong":"La LCA ne modifie pas la franchise AOS."}]'::jsonb, 3,
       'LCA demi-privée : confort et choix médecin dans l''hôpital contracté, extension nationale ou plus. Ne modifie ni la prime AOS, ni la franchise AOS (couches indépendantes).', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'lca_complementaires'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-MAL-LX-009', 'maladie_complementaire', t.id, 'single',
       NULL, 'L''obligation d''information de l''assureur LCA prend-elle fin à la signature du contrat ?', '[{"text":"Oui, une fois signé, le devoir cesse","correct":false,"why_wrong":"Le devoir est continu (art. 3 LCA)."},{"text":"Non, le devoir est continu tout au long du contrat (art. 3 LCA)","correct":true},{"text":"Oui, sauf en cas de sinistre","correct":false},{"text":"Uniquement à la reconduction annuelle","correct":false}]'::jsonb, 1,
       'Art. 3 LCA : devoir d''information continu. L''assureur doit informer notamment en cas de modification tarifaire, de conditions générales, de restructuration de la police. Base de la relation de confiance.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'lca_complementaires'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-MAL-LX-010', 'maladie_complementaire', t.id, 'single',
       NULL, 'Existe-t-il un subside cantonal pour les primes LCA santé complémentaire ?', '[{"text":"Oui, comme pour l''AOS","correct":false,"why_wrong":"Le subside cantonal ne concerne que l''AOS (art. 65 LAMal)."},{"text":"Non, les subsides sont réservés à l''AOS","correct":true},{"text":"Oui, à hauteur de 20 %","correct":false},{"text":"Uniquement pour les LCA hospitalisation","correct":false}]'::jsonb, 2,
       'Art. 65 LAMal : les subsides cantonaux (réduction de prime) sont exclusivement destinés à l''AOS. La LCA relève de la responsabilité contractuelle privée, sans aide publique.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'lca_complementaires'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-MAL-LX-011', 'maladie_complementaire', t.id, 'multiple',
       'Un client jeune actif liste ce qu''il attend en LCA ambulatoire complémentaire.', 'Quelles prestations sont typiquement couvertes par une LCA santé complémentaire ambulatoire ?', '[{"text":"Médecine complémentaire (ostéopathie, naturopathie...) non couverte AOS","correct":true},{"text":"Lunettes/lentilles adultes (100 à 400 CHF/an selon contrat)","correct":true},{"text":"Abonnement fitness (200 à 500 CHF/an typique)","correct":true},{"text":"Franchise AOS","correct":false,"why_wrong":"La franchise AOS est un choix de l''assuré, pas une couverture LCA."},{"text":"Cotisations AVS","correct":false,"why_wrong":"Sans rapport avec la santé."}]'::jsonb, 3,
       'LCA ambulatoire typique : catalogue étendu (méd. complémentaire, prévention, lunettes, fitness, chirurgie oculaire). Chiffres commerciaux à connaître par coeur (gap identifié Anisa).', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'lca_complementaires'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-MAL-LX-012', 'maladie_complementaire', t.id, 'single',
       NULL, 'Un LASIK (chirurgie oculaire au laser correctrice) est-il typiquement couvert par une LCA ?', '[{"text":"Oui, intégralement dans tout contrat LCA","correct":false,"why_wrong":"Le remboursement est plafonné selon contrat."},{"text":"Oui, plafonné généralement à 1 000 à 3 000 CHF selon la LCA","correct":true},{"text":"Non, jamais","correct":false,"why_wrong":"Nombreuses LCA le couvrent partiellement."},{"text":"Oui, mais uniquement pour les moins de 30 ans","correct":false}]'::jsonb, 2,
       'LCA ambulatoire haut de gamme : chirurgie oculaire au laser typiquement plafonnée entre 1 000 et 3 000 CHF (une fois par oeil, à vie). Chiffres commerciaux à connaître (piège Anisa identifié).', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'lca_complementaires'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-MAL-LX-013', 'maladie_complementaire', t.id, 'single',
       NULL, 'Un remboursement typique en LCA médecine alternative se situe autour de :', '[{"text":"10 % des frais, max 100 CHF/an","correct":false,"why_wrong":"Trop faible : les gammes marché sont bien supérieures."},{"text":"75 à 90 % des frais, plafond annuel 500 à 3 000 CHF selon contrat","correct":true},{"text":"100 % sans plafond","correct":false,"why_wrong":"Aucun contrat n''offre l''illimité pour la médecine alternative."},{"text":"50 %, plafond 5 000 CHF/mois","correct":false}]'::jsonb, 2,
       'LCA médecine alternative marché suisse : remboursement 75-90 % avec plafonds annuels entre 500 et 3 000 CHF selon la gamme. Point sensible en conseil (positionnement produit).', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'lca_complementaires'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-MAL-LX-014', 'maladie_complementaire', t.id, 'single',
       'Un adulte souhaite couvrir un futur bridge dentaire à 4 000 CHF.', 'Une LCA dentaire adulte prend typiquement en charge :', '[{"text":"100 % des soins sans plafond","correct":false,"why_wrong":"Toujours plafonné en LCA dentaire."},{"text":"50 à 75 % des frais avec plafonds annuels échelonnés dans le temps","correct":true},{"text":"Uniquement le détartrage","correct":false},{"text":"Aucun soin conservateur","correct":false,"why_wrong":"Les soins conservateurs sont typiquement couverts."}]'::jsonb, 1,
       'LCA dentaire adulte : remboursement 50-75 %, plafonds annuels souvent croissants (500 en année 1, 1 000 en année 2, jusqu''à 3 000-5 000 à terme). Réserves fréquentes pour dents déjà atteintes.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'lca_complementaires'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-MAL-LX-015', 'maladie_complementaire', t.id, 'multiple',
       NULL, 'Quels risques une réserve de santé LCA peut-elle prendre ?', '[{"text":"Exclusion temporaire (ex : 5 ans) d''une pathologie donnée","correct":true},{"text":"Exclusion permanente d''une pathologie donnée","correct":true},{"text":"Majoration de prime pour un risque aggravé","correct":true},{"text":"Résiliation automatique au 1er sinistre","correct":false,"why_wrong":"Résiliation au sinistre supprimée en LCA santé révisée."},{"text":"Modification unilatérale du plafond en cours d''année","correct":false,"why_wrong":"Modification unilatérale non admise."}]'::jsonb, 3,
       'Art. 3 LCA + pratique : les réserves santé sont écrites, précises, limitées dans le temps ou permanentes selon le contrat. Elles doivent être communiquées lors de l''acceptation. La révision LCA 2022 a renforcé la protection de l''assuré.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'lca_complementaires'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-MAL-LX-016', 'maladie_complementaire', t.id, 'single',
       'Camille signe une LCA médecine alternative le 5 mars 2026. Le 15 mars, elle change d''avis et souhaite se rétracter.', 'Peut-elle le faire ?', '[{"text":"Non, le contrat est ferme dès la signature","correct":false,"why_wrong":"La LCA prévoit un droit de révocation."},{"text":"Oui, dans le délai de 14 jours (art. 2a LCA)","correct":true},{"text":"Oui, sous 2 mois","correct":false,"why_wrong":"Confusion classique : c''est 14 jours."},{"text":"Uniquement avec l''accord de l''assureur","correct":false}]'::jsonb, 2,
       'Art. 2a LCA : révocation possible dans les 14 jours dès l''acceptation. Camille est dans le délai (10 jours après signature). Notifier par écrit ou forme démontrable par texte.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'lca_complementaires'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-MAL-LX-017', 'maladie_complementaire', t.id, 'single',
       NULL, 'Quelle autorité surveille les assureurs LCA ?', '[{"text":"L''OFSP","correct":false,"why_wrong":"L''OFSP surveille l''AOS."},{"text":"La FINMA","correct":true},{"text":"Le canton","correct":false},{"text":"Swissmedic","correct":false,"why_wrong":"Swissmedic autorise les médicaments."}]'::jsonb, 1,
       'LSA + FINMA : la Finma surveille les assureurs privés (dont LCA santé complémentaire). L''OFSP surveille les caisses AOS. Deux régulateurs distincts pour un même marché de santé.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'lca_complementaires'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-MAL-LX-018', 'maladie_complementaire', t.id, 'single',
       'Un assuré souhaite quitter sa LCA hospit privée pour une offre concurrente.', 'Quel délai de résiliation ordinaire s''applique typiquement à une LCA santé complémentaire ?', '[{"text":"30 novembre pour effet 1er janvier (comme LAMal)","correct":false,"why_wrong":"La LCA suit ses propres conditions générales."},{"text":"3 mois avant l''échéance annuelle (selon conditions générales)","correct":true},{"text":"Aucun délai","correct":false},{"text":"10 ans minimum sans résiliation","correct":false,"why_wrong":"Aucun contrat LCA ne peut être verrouillé aussi longtemps."}]'::jsonb, 2,
       'Pratique LCA : préavis 3 mois avant l''échéance annuelle (souvent 31.12) prévu dans les CGA. La LCA révisée (2022) impose une possibilité de résiliation annuelle (art. 35a LCA).', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'lca_complementaires'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-MAL-LX-019', 'maladie_complementaire', t.id, 'multiple',
       NULL, 'Quels critères l''assureur LCA utilise-t-il pour fixer la prime ?', '[{"text":"L''âge de l''assuré","correct":true},{"text":"L''état de santé (résultat questionnaire, exclusions)","correct":true},{"text":"Le niveau de couverture choisi","correct":true},{"text":"Le revenu de l''assuré","correct":false,"why_wrong":"Le revenu n''est pas un critère LCA santé."},{"text":"Le canton de résidence uniquement (comme AOS)","correct":false,"why_wrong":"La LCA utilise plus de critères que le seul canton."}]'::jsonb, 3,
       'Contraste LCA/AOS : la LCA tarifie selon âge, santé, couverture, sinistralité, sexe (selon produit). L''AOS uniformise dans la catégorie (âge, région, canton). Le revenu n''entre pas en LCA santé.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'lca_complementaires'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-MAL-LX-020', 'maladie_complementaire', t.id, 'single',
       NULL, 'Une LCA hospitalisation privée à l''étranger inclut typiquement :', '[{"text":"Uniquement les cliniques suisses","correct":false,"why_wrong":"L''extension étranger fait justement partie de l''offre."},{"text":"La couverture hospitalière étranger, transport et rapatriement selon contrat","correct":true},{"text":"Aucune couverture à l''étranger","correct":false},{"text":"Le remboursement des primes AOS","correct":false}]'::jsonb, 2,
       'LCA hospit privée haut de gamme : extension étranger sans plafond ou avec plafond élevé, transport médical et rapatriement inclus. Complète le manque flagrant de l''AOS (double tarif suisse seulement, pas de rapatriement).', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'lca_complementaires'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-MAL-LX-021', 'maladie_complementaire', t.id, 'single',
       NULL, 'L''AOS et la LCA doivent-elles être auprès de la même caisse ?', '[{"text":"Oui, obligatoirement","correct":false,"why_wrong":"Libre choix des deux couvertures."},{"text":"Non, l''assuré est libre de séparer AOS et LCA chez deux compagnies différentes","correct":true},{"text":"Uniquement si l''assuré a plus de 40 ans","correct":false},{"text":"Uniquement pour la LCA hospitalisation","correct":false}]'::jsonb, 1,
       'Aucune obligation légale : le client peut avoir son AOS chez la caisse A et sa LCA chez l''assureur B. Argument pour comparer et optimiser chaque couche séparément.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'lca_complementaires'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-MAL-LX-022', 'maladie_complementaire', t.id, 'single',
       NULL, 'Le principe indemnitaire empêche-t-il le cumul d''une LCA hospit demi-privée et d''une seconde LCA hospit demi-privée sur le même sinistre ?', '[{"text":"Non, on peut cumuler et être surindemnisé","correct":false,"why_wrong":"Principe indemnitaire l''interdit."},{"text":"Oui, il n''est pas possible d''être indemnisé au-delà du dommage réel","correct":true},{"text":"Uniquement si les deux LCA sont chez la même compagnie","correct":false},{"text":"Uniquement pour la médecine alternative","correct":false}]'::jsonb, 2,
       'Principe indemnitaire LCA : pas de double indemnisation pour un même sinistre. Deux LCA hospit se répartissent proportionnellement. Aucun intérêt à double-souscrire par erreur.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'lca_complementaires'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-MAL-LX-023', 'maladie_complementaire', t.id, 'multiple',
       'Karim, 38 ans, souscrit une nouvelle LCA hospitalisation privée. Il a une hernie discale connue depuis 2020, sans intervention prévue.', 'Que doit-il anticiper ?', '[{"text":"L''assureur peut poser une réserve de santé sur la colonne vertébrale (temporaire ou permanente)","correct":true},{"text":"L''assureur peut majorer la prime","correct":true},{"text":"L''assureur peut refuser la proposition sans motiver","correct":true},{"text":"L''assureur est obligé de l''accepter comme en AOS","correct":false,"why_wrong":"AOS obligatoire, LCA libre."},{"text":"Résilier immédiatement son ancienne LCA pour économiser","correct":false,"why_wrong":"Erreur majeure : jamais résilier avant acceptation écrite."}]'::jsonb, 3,
       'Consequences de la liberté contractuelle LCA + questionnaire de santé. Règle d''or : garder l''ancienne couverture jusqu''à confirmation formelle (avec réserves finalisées) de la nouvelle.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'lca_complementaires'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-MAL-LX-024', 'maladie_complementaire', t.id, 'single',
       NULL, 'Une LCA fitness/prévention prend typiquement en charge :', '[{"text":"Jusqu''à 500 CHF/an d''abonnement fitness ou sport reconnu","correct":true},{"text":"Uniquement les cures thermales","correct":false,"why_wrong":"Les cures sont un autre poste LCA."},{"text":"Uniquement les médicaments","correct":false},{"text":"Aucune activité sportive","correct":false,"why_wrong":"La prévention couvre bien le fitness."}]'::jsonb, 1,
       'LCA prévention : forfaits annuels typiques 200 à 500 CHF pour abonnement fitness/piscine/sport en centre reconnu. Argument acquisition jeune adulte. Chiffres commerciaux à maîtriser.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'lca_complementaires'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-MAL-LX-025', 'maladie_complementaire', t.id, 'multiple',
       'Un client hésite entre AOS et LCA et demande au conseiller les vraies différences.', 'En quoi la LCA se distingue-t-elle fondamentalement de l''AOS ?', '[{"text":"Liberté contractuelle (refus, réserves, majoration possibles)","correct":true},{"text":"Prime individualisée selon âge, santé, sexe (non uniforme)","correct":true},{"text":"Prestations personnalisées et évolutives selon contrat","correct":true},{"text":"Subsides cantonaux disponibles comme en AOS","correct":false,"why_wrong":"Aucun subside pour LCA (art. 65 LAMal)."},{"text":"Obligation légale de souscription universelle","correct":false,"why_wrong":"LCA facultative, AOS obligatoire."}]'::jsonb, 3,
       'Résumé des 5 différences fondamentales : liberté vs obligation ; prime individualisée vs per capita ; prestations variables vs identiques ; pas de subside vs subside AOS ; refus possible vs interdiction. À maîtriser en conseil.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'lca_complementaires'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-MAL-IJ-001', 'maladie_complementaire', t.id, 'single',
       'Un artisan indépendant demande à son conseiller s''il doit obligatoirement souscrire une IJM.', 'L''IJM LAMal (art. 67-77) est-elle obligatoire ?', '[{"text":"Oui, comme l''AOS","correct":false,"why_wrong":"L''IJM LAMal est facultative (art. 67)."},{"text":"Non, elle est facultative","correct":true},{"text":"Obligatoire uniquement pour les salariés","correct":false},{"text":"Obligatoire à partir de 18 ans","correct":false}]'::jsonb, 1,
       'Art. 67 LAMal : IJM LAMal FACULTATIVE, souscrite individuellement ou collectivement (employeur). À distinguer de l''obligation CO 324a qui pèse sur l''employeur.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'ijm'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-MAL-IJ-002', 'maladie_complementaire', t.id, 'single',
       NULL, 'Quelle est la durée maximale de versement d''une IJM LAMal (art. 72) ?', '[{"text":"360 jours sur 540","correct":false,"why_wrong":"Chiffre erroné."},{"text":"720 jours sur 900","correct":true},{"text":"730 jours sur 1000","correct":false,"why_wrong":"Piège classique : chiffre proche mais faux."},{"text":"365 jours sur 365","correct":false}]'::jsonb, 2,
       'Art. 72 LAMal : IJM versée pendant 720 jours dans une période de 900 jours consécutifs. Chiffre à connaître par coeur (piège récurrent VBV).', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'ijm'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-MAL-IJ-003', 'maladie_complementaire', t.id, 'single',
       'Un employeur PME souscrit une IJM collective pour son personnel.', 'L''IJM collective d''employeur relève en pratique de quel régime ?', '[{"text":"LAMal art. 67-77","correct":false,"why_wrong":"En pratique, la LCA est utilisée pour l''IJM collective."},{"text":"LCA (loi sur le contrat d''assurance)","correct":true},{"text":"LAA","correct":false,"why_wrong":"LAA = accidents, pas maladie."},{"text":"LPP","correct":false}]'::jsonb, 1,
       'En pratique : les IJM collectives conclues par les employeurs relèvent typiquement de la LCA (marché privé, souplesse). Piège VBV : ne pas confondre avec l''IJM LAMal facultative individuelle.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'ijm'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-MAL-IJ-004', 'maladie_complementaire', t.id, 'multiple',
       NULL, 'Quelles échelles de durée de versement du salaire par l''employeur existent (art. 324a CO) ?', '[{"text":"Échelle bernoise","correct":true},{"text":"Échelle bâloise","correct":true},{"text":"Échelle zurichoise","correct":true},{"text":"Échelle genevoise","correct":false,"why_wrong":"Pas d''échelle genevoise officielle : la pratique GE suit typiquement Berne."},{"text":"Échelle nationale unique","correct":false,"why_wrong":"Aucune échelle nationale unique en CO 324a."}]'::jsonb, 3,
       'Art. 324a CO : à défaut d''accord conventionnel, la doctrine et la pratique cantonale ont dégagé 3 échelles (Berne, Bâle, Zurich). Chacune fixe la durée selon les années d''ancienneté.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'ijm'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-MAL-IJ-005', 'maladie_complementaire', t.id, 'single',
       NULL, 'Selon l''échelle bernoise, un salarié en 1re année d''ancienneté a droit au salaire pendant :', '[{"text":"1 semaine","correct":false,"why_wrong":"Le minimum légal est 3 semaines."},{"text":"3 semaines","correct":true},{"text":"1 mois","correct":false,"why_wrong":"1 mois correspond à l''année 2."},{"text":"6 mois","correct":false,"why_wrong":"6 mois correspond à une ancienneté beaucoup plus longue."}]'::jsonb, 2,
       'Échelle bernoise (référence CO 324a al. 2) : 3 semaines la 1re année, 1 mois la 2e année, puis progression selon l''ancienneté. Le minimum absolu légal est 3 semaines dès l''année 1.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'ijm'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-MAL-IJ-006', 'maladie_complementaire', t.id, 'single',
       NULL, 'Un employeur qui a conclu une IJM LCA équivalente est libéré de son obligation CO 324a s''il :', '[{"text":"Ne participe pas à la prime","correct":false,"why_wrong":"La libération suppose une contribution significative de l''employeur."},{"text":"Prend en charge au moins 50 % de la prime IJM","correct":true},{"text":"Paie 100 % de la prime","correct":false,"why_wrong":"50 % suffit selon la jurisprudence."},{"text":"Prend en charge 25 % maximum","correct":false}]'::jsonb, 2,
       'Jurisprudence CO 324a : pour libérer l''employeur de son obligation directe, l''IJM collective LCA doit être équivalente ou meilleure ET la prime supportée au moins à 50 % par l''employeur. Sinon obligation directe subsiste.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'ijm'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-MAL-IJ-007', 'maladie_complementaire', t.id, 'single',
       'Un dirigeant PME compare 3 offres IJM du marché.', 'Quel taux d''indemnité IJM est typiquement offert dans les contrats collectifs LCA du marché suisse ?', '[{"text":"50 % du salaire","correct":false,"why_wrong":"Le standard marché est 80 %."},{"text":"80 % du salaire","correct":true},{"text":"100 % du salaire","correct":false,"why_wrong":"100 % est rare (couvrirait au-delà du principe indemnitaire)."},{"text":"40 %","correct":false}]'::jsonb, 1,
       'Standard marché LCA IJM : 80 % du salaire brut. Certains contrats vont à 90 % ou 100 %, souvent avec délai d''attente allongé pour compenser.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'ijm'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-MAL-IJ-008', 'maladie_complementaire', t.id, 'multiple',
       NULL, 'Quels sont les leviers pour réduire la prime IJM (collective ou individuelle) ?', '[{"text":"Allonger le délai d''attente (30, 60, 90 jours)","correct":true},{"text":"Réduire la durée de prestation (par ex 730 jours)","correct":true},{"text":"Diminuer le taux (par ex 80 % au lieu de 90 %)","correct":true},{"text":"Augmenter le nombre de sinistres passés","correct":false,"why_wrong":"Cela augmente la prime, ne la réduit pas."},{"text":"Passer d''une couverture LCA à une IJM LAMal collective sans limite","correct":false,"why_wrong":"L''IJM LAMal a une limite légale de 720/900."}]'::jsonb, 2,
       '3 leviers standards : délai d''attente, durée, taux. Le tarif suit une logique risque : plus l''assureur supporte tôt et longtemps, plus la prime augmente.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'ijm'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-MAL-IJ-009', 'maladie_complementaire', t.id, 'single',
       NULL, 'L''IJM LAMal admet-elle des réserves de santé ?', '[{"text":"Oui, comme la LCA","correct":false,"why_wrong":"L''IJM LAMal exclut les réserves permanentes."},{"text":"Non, réserves limitées à 5 ans max si pathologie préexistante (art. 69 LAMal)","correct":true},{"text":"Oui, sans limite","correct":false},{"text":"Aucune réserve possible","correct":false,"why_wrong":"Une réserve de 5 ans est admise."}]'::jsonb, 1,
       'Art. 69 LAMal : l''IJM LAMal peut exclure les maladies existantes lors de l''affiliation, mais la réserve tombe au plus tard après 5 ans. Contrairement à la LCA (réserves permanentes possibles).', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'ijm'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-MAL-IJ-010', 'maladie_complementaire', t.id, 'single',
       'Marc, employé année 4 (ancienneté), tombe malade. Son employeur applique l''échelle bernoise.', 'Combien de temps l''employeur doit-il verser le salaire selon l''échelle bernoise (année 4) ?', '[{"text":"1 mois","correct":false,"why_wrong":"1 mois = année 2."},{"text":"2 mois","correct":true},{"text":"6 mois","correct":false,"why_wrong":"6 mois correspond à une ancienneté bien plus longue."},{"text":"3 semaines","correct":false,"why_wrong":"3 semaines = année 1."}]'::jsonb, 2,
       'Échelle bernoise : 3 semaines (année 1), 1 mois (année 2), 2 mois (années 3-4), 3 mois (années 5-9), 4 mois (années 10-14), etc. Marc année 4 = 2 mois.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'ijm'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-MAL-IJ-011', 'maladie_complementaire', t.id, 'single',
       'Un indépendant récent s''étonne que son ancien employeur n''ait plus d''obligation envers lui.', 'Le CO 324a s''applique-t-il aux indépendants ?', '[{"text":"Oui, comme aux salariés","correct":false,"why_wrong":"Le CO 324a régit uniquement le contrat de travail."},{"text":"Non, l''indépendant doit se couvrir librement (IJM LCA individuelle)","correct":true},{"text":"Oui, si affilié à une caisse","correct":false},{"text":"Uniquement au conjoint travaillant dans l''entreprise","correct":false}]'::jsonb, 1,
       'Art. 324a CO : obligation de l''employeur envers le salarié. L''indépendant n''a pas d''employeur : il doit souscrire une IJM LCA individuelle pour se couvrir. Argument central de conseil aux indépendants.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'ijm'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-MAL-IJ-012', 'maladie_complementaire', t.id, 'single',
       NULL, 'Combien de temps est cumulable une IJM LAMal si le salarié tombe malade avec plusieurs interruptions sur 3 ans ?', '[{"text":"Illimité","correct":false,"why_wrong":"Le plafond est 720/900."},{"text":"720 jours cumulés dans les 900 jours consécutifs","correct":true},{"text":"365 jours par période","correct":false},{"text":"1 000 jours cumulés","correct":false,"why_wrong":"Chiffre erroné."}]'::jsonb, 2,
       'Art. 72 LAMal : le compteur 720/900 s''applique aux jours indemnisés cumulés dans la fenêtre glissante de 900 jours consécutifs pour la même cause. Piège VBV : bien retenir 720 sur 900.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'ijm'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-MAL-IJ-013', 'maladie_complementaire', t.id, 'multiple',
       NULL, 'Quelles autres prestations peuvent se cumuler avec l''IJM (avec règle de surindemnisation) ?', '[{"text":"APG maternité (14 semaines)","correct":true},{"text":"AI (rente invalidité)","correct":true},{"text":"LAA (indemnité journalière accident)","correct":true},{"text":"Subsides cantonaux d''AOS","correct":false,"why_wrong":"Les subsides réduisent la prime AOS, sans rapport avec l''IJM."},{"text":"3e pilier B non lié","correct":false,"why_wrong":"3b relève de l''épargne privée, pas des prestations sociales."}]'::jsonb, 2,
       'Cumul possible avec règles de coordination : le total ne peut dépasser le revenu net perdu (principe indemnitaire pour la LCA + coordination LPGA). L''AOS ne verse pas d''IJ.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'ijm'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-MAL-IJ-014', 'maladie_complementaire', t.id, 'single',
       NULL, 'Un délai d''attente typique en IJM LCA collective (avec CO 324a en amont) est de :', '[{"text":"0 jour","correct":false,"why_wrong":"Souvent 30 à 90 jours pour économiser la prime."},{"text":"30, 60 ou 90 jours (coordination avec obligation CO 324a de l''employeur)","correct":true},{"text":"1 an","correct":false,"why_wrong":"Bien trop long en pratique."},{"text":"365 jours","correct":false}]'::jsonb, 2,
       'Délai d''attente IJM collective LCA typique 30-90 jours pour laisser l''employeur assumer ses obligations CO 324a en premier. La coordination doit garantir la continuité du salaire.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'ijm'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-MAL-IJ-015', 'maladie_complementaire', t.id, 'single',
       NULL, 'Quelle est la limite de salaire retenue par l''IJM LAMal ?', '[{"text":"Aucune limite (couvre le salaire réel)","correct":false,"why_wrong":"L''IJM LAMal n''obligatoirement couvre pas le salaire réel intégral."},{"text":"Fixée par le contrat, souvent alignée sur le salaire déclaré","correct":true},{"text":"148 200 CHF (comme LAA)","correct":false,"why_wrong":"148 200 CHF = plafond LAA."},{"text":"90 720 CHF (comme LPP)","correct":false,"why_wrong":"90 720 CHF = salaire max LPP obligatoire."}]'::jsonb, 1,
       'IJM LAMal : le montant assuré est convenu contractuellement (individuel ou collectif). Pas de plafond légal spécifique comme en LAA. Attention à la déclaration correcte du salaire pour éviter la sous-assurance.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'ijm'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-MAL-IJ-016', 'maladie_complementaire', t.id, 'single',
       'Sophie est enceinte et reçoit l''APG maternité. Peut-elle aussi toucher son IJM LCA collective pendant les 14 semaines ?', NULL, '[{"text":"Oui, cumul intégral","correct":false,"why_wrong":"Interdiction de surindemnisation."},{"text":"Non, l''APG couvre le revenu pendant les 14 semaines maternité (pas de cumul IJM)","correct":true},{"text":"Oui, mais uniquement pour la 15e semaine","correct":false},{"text":"L''APG et l''IJM se cumulent sans coordination","correct":false,"why_wrong":"Coordination LPGA appliquée."}]'::jsonb, 2,
       'LAPG + LCA : l''APG maternité prime pendant les 14 semaines à hauteur de 80 % (max 220 CHF/j). L''IJM ne verse pas de doublon. Elle peut compléter au-delà des 14 semaines si l''incapacité persiste pour maladie liée.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'ijm'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-MAL-IJ-017', 'maladie_complementaire', t.id, 'single',
       NULL, 'Une IJM LCA sans réserve peut-elle être conclue pour un salarié malade au moment de la souscription ?', '[{"text":"Oui, obligatoirement","correct":false,"why_wrong":"L''assureur peut poser une réserve ou refuser."},{"text":"Non, l''assureur peut refuser ou poser des réserves (liberté contractuelle LCA)","correct":true},{"text":"Oui, avec surprime automatique","correct":false},{"text":"Non, uniquement avec accord du médecin traitant","correct":false}]'::jsonb, 1,
       'Liberté contractuelle LCA + art. 6 LCA sur la réticence : l''assureur peut refuser, poser des réserves ou majorer la prime. Différence majeure avec l''IJM LAMal (réserves limitées à 5 ans).', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'ijm'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-MAL-IJ-018', 'maladie_complementaire', t.id, 'multiple',
       'Léa (année 6 ancienneté, échelle zurichoise) tombe malade. Son employeur a une IJM collective LCA avec délai d''attente 60 jours, taux 80 %, durée 730 jours.', 'Comment se déroule la couverture ?', '[{"text":"L''employeur verse le salaire selon l''échelle zurichoise pendant sa durée d''obligation","correct":true},{"text":"L''IJM LCA commence à verser 80 % du salaire dès le 61e jour (fin délai d''attente)","correct":true},{"text":"La couverture IJM peut aller jusqu''à 730 jours (contrat)","correct":true},{"text":"L''employeur peut se libérer sans participer à la prime IJM","correct":false,"why_wrong":"50 % de la prime est requis pour la libération CO 324a."},{"text":"L''IJM couvre 100 % du salaire dès le 1er jour","correct":false,"why_wrong":"Le taux est 80 %, avec délai d''attente."}]'::jsonb, 3,
       'Coordination CO 324a + IJM LCA : employeur d''abord, puis IJM prend le relais. Le contrat IJM doit être communiqué au salarié (art. 3 LCA). Vérifier la coordination pour éviter tout trou.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'ijm'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-MAL-IJ-019', 'maladie_complementaire', t.id, 'single',
       NULL, 'Le libre passage entre IJM LAMal et IJM LCA existe-t-il ?', '[{"text":"Oui, automatique et sans questionnaire","correct":false,"why_wrong":"Le passage LAMal → LCA n''est pas automatique."},{"text":"Un passage individuel LAMal → LCA nécessite un nouveau questionnaire de santé","correct":true},{"text":"Impossible","correct":false,"why_wrong":"Le passage est possible mais soumis aux règles LCA."},{"text":"Uniquement au 1er janvier","correct":false}]'::jsonb, 2,
       'L''IJM LAMal et l''IJM LCA sont deux régimes distincts. Le libre passage individuel LAMal → LCA suppose l''acceptation LCA (questionnaire santé, réserves). Un droit de libre passage collectif peut exister à la sortie d''un contrat collectif LCA.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'ijm'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-MAL-IJ-020', 'maladie_complementaire', t.id, 'single',
       'Un chômeur inscrit à l''ORP tombe malade et se demande qui prend en charge.', 'Un chômeur qui tombe malade est couvert par :', '[{"text":"L''IJM LAMal automatique","correct":false,"why_wrong":"Pas de couverture LAMal IJM automatique pour un chômeur."},{"text":"L''assurance-chômage prolonge sous conditions, avec limites (art. 28 LACI)","correct":true},{"text":"L''AOS uniquement","correct":false,"why_wrong":"L''AOS couvre les soins, pas le revenu."},{"text":"Aucune prestation","correct":false}]'::jsonb, 1,
       'Art. 28 LACI : en cas de maladie, le chômeur inscrit reçoit ses indemnités pendant 30 jours, puis les limitations s''appliquent. Argument pour souscrire une IJM LCA individuelle en anticipation.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'ijm'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-MAL-IJ-021', 'maladie_complementaire', t.id, 'single',
       NULL, 'L''échelle bâloise se distingue de l''échelle bernoise principalement par :', '[{"text":"Des durées identiques","correct":false,"why_wrong":"Chaque échelle a ses propres durées."},{"text":"Une progression de durée légèrement différente selon les années d''ancienneté","correct":true},{"text":"L''application aux indépendants","correct":false,"why_wrong":"CO 324a ne s''applique jamais aux indépendants."},{"text":"Un taux différent (40 % au lieu de 100 %)","correct":false,"why_wrong":"Le taux CO 324a est 100 % du salaire."}]'::jsonb, 2,
       'Les 3 échelles (Berne, Bâle, Zurich) proposent des durées de versement du salaire par l''employeur selon les années d''ancienneté. Le taux est toujours 100 % du salaire (contre 80 % pour l''IJM qui prend le relais).', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'ijm'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-MAL-IJ-022', 'maladie_complementaire', t.id, 'single',
       NULL, 'Le taux CO 324a de versement du salaire par l''employeur est :', '[{"text":"80 % du salaire","correct":false,"why_wrong":"80 % est le taux IJM collective LCA, pas CO 324a."},{"text":"100 % du salaire","correct":true},{"text":"50 %","correct":false},{"text":"60 %","correct":false}]'::jsonb, 1,
       'Art. 324a CO : l''employeur verse le SALAIRE (100 %) pendant la durée d''obligation légale ou conventionnelle. C''est ensuite l''IJM (typiquement 80 %) qui prend le relais après délai d''attente.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'ijm'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-MAL-IJ-023', 'maladie_complementaire', t.id, 'multiple',
       NULL, 'Un contrat collectif d''IJM LCA à la sortie d''un emploi permet typiquement :', '[{"text":"Un passage à titre individuel avec l''assureur du contrat collectif","correct":true},{"text":"Sans nouveau questionnaire de santé (dans certains contrats)","correct":true},{"text":"Dans un délai limité après la fin du contrat de travail (souvent 30-90 jours)","correct":true},{"text":"Le maintien intégral du financement par l''ancien employeur","correct":false,"why_wrong":"Le financement passe au titulaire à titre individuel."},{"text":"Uniquement si l''assuré est en incapacité","correct":false}]'::jsonb, 2,
       'CGA IJM LCA collective : clause de libre passage individuel à la sortie de l''entreprise. Point clé de conseil pour éviter la perte de couverture lors d''un changement d''emploi. Formaliser rapidement.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'ijm'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-MAL-IJ-024', 'maladie_complementaire', t.id, 'single',
       'Un salarié malade épuise ses 720 jours d''IJM sur 900 jours consécutifs. Il est reconnu invalide à 100 %.', 'Quelle prestation prend le relais ?', '[{"text":"Rien : il perd toute couverture","correct":false,"why_wrong":"La rente AI/LPP prend le relais."},{"text":"Rente AI + rente LPP invalidité","correct":true},{"text":"APG maternité","correct":false},{"text":"AOS avec 100 % du salaire","correct":false,"why_wrong":"L''AOS ne verse pas de revenu."}]'::jsonb, 2,
       'Coordination sociale : IJM 720 jours puis rente AI (dès taux 40 %) + rente invalidité LPP (dès taux 40 %, échelonnée). Argument pour PLP (perte de gain longue durée) et couverture LPP complémentaire.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'ijm'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-MAL-IJ-025', 'maladie_complementaire', t.id, 'single',
       'Un consultant indépendant analyse s''il faut préférer IJM LAMal ou LCA.', 'Un indépendant peut-il s''affilier à une IJM LAMal ?', '[{"text":"Non, jamais","correct":false,"why_wrong":"L''IJM LAMal individuelle est ouverte à toute personne domiciliée en Suisse."},{"text":"Oui, à titre facultatif (art. 67 LAMal), avec évaluation médicale","correct":true},{"text":"Uniquement si son revenu est inférieur à 50 000 CHF","correct":false},{"text":"Uniquement pour les indépendants agricoles","correct":false}]'::jsonb, 1,
       'Art. 67 LAMal : toute personne domiciliée en Suisse (indépendant inclus) peut souscrire une IJM LAMal individuelle. Réserves possibles (limite 5 ans). Alternative IJM LCA individuelle avec plus de souplesse mais réserves permanentes.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'ijm'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-MAL-SC-001', 'maladie_complementaire', t.id, 'single',
       NULL, 'Quelle est la durée de l''allocation de maternité APG en Suisse en 2026 ?', '[{"text":"8 semaines","correct":false,"why_wrong":"8 semaines correspond au minimum légal d''interdiction de travail post-partum."},{"text":"14 semaines","correct":true},{"text":"16 semaines","correct":false,"why_wrong":"16 semaines n''est pas prévu par la LAPG."},{"text":"6 mois","correct":false}]'::jsonb, 1,
       'LAPG : allocation maternité = 14 semaines (98 jours) à 80 % du revenu, plafonnée à 220 CHF/jour (2026). Interdiction de travail 8 semaines post-partum.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'social_connexe'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-MAL-SC-002', 'maladie_complementaire', t.id, 'single',
       NULL, 'Quel est le taux de l''allocation maternité APG ?', '[{"text":"60 %","correct":false,"why_wrong":"Le taux légal est 80 %."},{"text":"80 %","correct":true},{"text":"100 %","correct":false,"why_wrong":"Aucune allocation LAPG n''est à 100 %."},{"text":"50 %","correct":false}]'::jsonb, 1,
       'LAPG art. 16b : 80 % du revenu antérieur soumis AVS, plafond 220 CHF/jour (2026). Convertible en mois : environ 6 600 CHF/mois maximum.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'social_connexe'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-MAL-SC-003', 'maladie_complementaire', t.id, 'single',
       NULL, 'Quel est le montant maximum journalier de l''APG maternité en 2026 ?', '[{"text":"180 CHF","correct":false,"why_wrong":"Chiffre erroné."},{"text":"220 CHF","correct":true},{"text":"240 CHF","correct":false,"why_wrong":"Chiffre erroné pour 2026."},{"text":"300 CHF","correct":false}]'::jsonb, 1,
       'LAPG : plafond journalier 220 CHF (soit 80 % d''un revenu 100 000 CHF/an environ). Chiffre à connaître pour argumentaire IJM LCA (comble la différence pour hauts revenus).', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'social_connexe'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-MAL-SC-004', 'maladie_complementaire', t.id, 'single',
       NULL, 'Quelle est la durée du congé paternité APG en Suisse en 2026 ?', '[{"text":"1 semaine","correct":false,"why_wrong":"Le congé paternité est de 2 semaines depuis 2021."},{"text":"2 semaines (10 jours ouvrables)","correct":true},{"text":"4 semaines","correct":false},{"text":"Aucun congé","correct":false,"why_wrong":"Le congé paternité existe depuis 2021."}]'::jsonb, 1,
       'LAPG art. 16i (dès 2021) : congé paternité 2 semaines à 80 % du revenu, plafond 220 CHF/jour, à prendre dans les 6 mois suivant la naissance.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'social_connexe'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-MAL-SC-005', 'maladie_complementaire', t.id, 'single',
       'Une conseillère explique la couverture accident d''un demandeur d''emploi.', 'Quel article de la LACI règle la couverture accidents des chômeurs ?', '[{"text":"Art. 22 LACI","correct":false,"why_wrong":"Art. 22 LACI traite du montant des indemnités."},{"text":"Art. 22a LACI","correct":true},{"text":"Art. 28 LACI","correct":false,"why_wrong":"Art. 28 traite de la maladie."},{"text":"Art. 45 LACI","correct":false}]'::jsonb, 1,
       'Art. 22a LACI : les chômeurs sont assurés d''office contre les accidents auprès de la SUVA, indépendamment de tout contrat ou de la durée de travail. Piège VBV majeur.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'social_connexe'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-MAL-SC-006', 'maladie_complementaire', t.id, 'multiple',
       NULL, 'Un chômeur inscrit à l''ORP est couvert par quelles assurances sociales ?', '[{"text":"LAA (accidents pro et non pro) via SUVA (art. 22a LACI)","correct":true},{"text":"AVS/AI/APG (cotisations prélevées sur les indemnités)","correct":true},{"text":"AOS (LAMal) : reste à sa charge","correct":true},{"text":"LPP obligatoire (2e pilier)","correct":false,"why_wrong":"Le 2e pilier obligatoire est suspendu ; l''assurance risques est facultative via prestations de libre passage."},{"text":"IJM LAMal automatique","correct":false,"why_wrong":"L''IJM LAMal reste facultative."}]'::jsonb, 2,
       'Couverture chômeur : SUVA obligatoire (accidents), AVS/AI/APG continue (via LACI), AOS individuelle. Le 2e pilier obligatoire s''arrête ; le libre passage protège les avoirs. Piège Anisa : SUVA sans condition d''heures.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'social_connexe'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-MAL-SC-007', 'maladie_complementaire', t.id, 'single',
       NULL, 'Quel est le taux de cotisation LACI 2026 pour les salaires jusqu''au plafond LAA ?', '[{"text":"1 %","correct":false,"why_wrong":"Le taux est plus élevé."},{"text":"2,2 % (1,1 % employeur + 1,1 % salarié)","correct":true},{"text":"5 %","correct":false},{"text":"0,5 %","correct":false}]'::jsonb, 1,
       'LACI : 2,2 % au total (paritaire 1,1 %/1,1 %) jusqu''au plafond 148 200 CHF/an. Cotisation de solidarité 1 % au-delà.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'social_connexe'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-MAL-SC-008', 'maladie_complementaire', t.id, 'single',
       NULL, 'Un service militaire ouvre-t-il droit à des APG (revenu) ?', '[{"text":"Non, aucune indemnité","correct":false,"why_wrong":"Les APG service couvrent bien le revenu."},{"text":"Oui, l''APG service verse une allocation calculée sur le revenu antérieur (LAPG)","correct":true},{"text":"Oui, l''AVS verse le salaire","correct":false},{"text":"Oui, la LAMal verse le salaire","correct":false,"why_wrong":"La LAMal ne verse pas de revenu."}]'::jsonb, 2,
       'LAPG : les APG service (militaire, civil, protection civile) versent une allocation basée sur le revenu antérieur, avec composantes de base, garde d''enfants, exploitation. Financement paritaire avec la maternité.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'social_connexe'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-MAL-SC-009', 'maladie_complementaire', t.id, 'single',
       NULL, 'Quel article LAA règle l''intervention de la caisse supplétive LAA ?', '[{"text":"Art. 22a LACI","correct":false,"why_wrong":"22a LACI = SUVA chômeurs."},{"text":"Art. 73 LAA","correct":true},{"text":"Art. 1a LAA","correct":false},{"text":"Art. 45 LSA","correct":false}]'::jsonb, 1,
       'Art. 73 LAA : la caisse supplétive LAA intervient en cas d''employeur défaillant (non assuré, insolvable) pour garantir les prestations LAA à l''assuré. Piège VBV : elle ne dépend pas uniquement de la SUVA.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'social_connexe'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-MAL-SC-010', 'maladie_complementaire', t.id, 'single',
       'Karim, chômeur inscrit, glisse sur le trottoir en allant à un entretien d''embauche.', 'Quelle assurance couvre son accident ?', '[{"text":"L''AOS uniquement","correct":false,"why_wrong":"L''accident est couvert par la SUVA au titre de l''art. 22a LACI."},{"text":"La SUVA (LAA) automatiquement (art. 22a LACI)","correct":true},{"text":"L''APG militaire","correct":false},{"text":"Aucune couverture","correct":false}]'::jsonb, 2,
       'Art. 22a LACI : couverture SUVA automatique pour tout chômeur, sans condition. Cela évite un passage forcé par l''AOS (moins bien couvrante). Piège VBV majeur (Anisa).', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'social_connexe'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-MAL-SC-011', 'maladie_complementaire', t.id, 'single',
       'Un futur retraité vérifie le calcul de sa rente AVS 2026.', 'L''AVS 2026 verse une rente mensuelle minimum de :', '[{"text":"1 000 CHF","correct":false,"why_wrong":"Chiffre 2026 = 1 260."},{"text":"1 260 CHF","correct":true},{"text":"1 500 CHF","correct":false},{"text":"800 CHF","correct":false}]'::jsonb, 1,
       'AVS 2026 : rente minimum 1 260 CHF/mois, rente maximum simple 2 520 CHF/mois. Rente couple plafonnée à 150 % de la rente maximum.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'social_connexe'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-MAL-SC-012', 'maladie_complementaire', t.id, 'single',
       NULL, 'La rente AVS 2026 maximum (simple) est :', '[{"text":"2 250 CHF/mois","correct":false,"why_wrong":"Chiffre incorrect."},{"text":"2 520 CHF/mois","correct":true},{"text":"3 000 CHF/mois","correct":false},{"text":"1 800 CHF/mois","correct":false}]'::jsonb, 1,
       'AVS 2026 : rente maximum simple 2 520 CHF/mois. Nécessite carrière complète (44 ans) au revenu déterminant maximal. Rente couple max 150 %.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'social_connexe'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-MAL-SC-013', 'maladie_complementaire', t.id, 'multiple',
       NULL, 'Quelles prestations APG existent en Suisse (LAPG) ?', '[{"text":"APG service militaire, civil et protection civile","correct":true},{"text":"APG maternité (14 semaines, 80 %, max 220 CHF/j)","correct":true},{"text":"APG paternité (2 semaines, 80 %, max 220 CHF/j)","correct":true},{"text":"APG adoption (2 semaines, dès 2023)","correct":true},{"text":"APG chômage","correct":false,"why_wrong":"Le chômage relève de la LACI, pas de la LAPG."}]'::jsonb, 2,
       'LAPG : 5 régimes (service, maternité, paternité, adoption, prise en charge d''un enfant gravement atteint). Financement paritaire, cotisation totale 0,5 % du salaire.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'social_connexe'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-MAL-SC-014', 'maladie_complementaire', t.id, 'single',
       NULL, 'Le taux total de cotisation AVS/AI/APG en 2026 (paritaire, part salariale) est :', '[{"text":"5,3 %","correct":true},{"text":"7 %","correct":false,"why_wrong":"Chiffre trop élevé pour la part salariale."},{"text":"8,7 %","correct":false,"why_wrong":"8,7 % est le taux total AVS seule paritaire (2×4,35 arrondi selon année)."},{"text":"10 %","correct":false}]'::jsonb, 2,
       'Cotisations paritaires 2026 : AVS 8,7 % (4,35 % chacun), AI 1,4 % (0,7 % chacun), APG 0,5 % (0,25 % chacun) = 10,6 % total dont 5,3 % salariale. Retenir la répartition paritaire.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'social_connexe'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-MAL-SC-015', 'maladie_complementaire', t.id, 'single',
       NULL, 'Un salarié en incapacité totale reçoit une IJM LCA 80 % + rente AI 40 %. Comment gère-t-on le cumul ?', '[{"text":"100 % additionné (surindemnisation acceptée)","correct":false,"why_wrong":"La coordination LPGA interdit la surindemnisation."},{"text":"Coordination LPGA : la prestation totale ne dépasse pas le revenu net perdu","correct":true},{"text":"Aucun cumul possible","correct":false,"why_wrong":"Cumul possible avec coordination."},{"text":"IJM prime toujours sur AI","correct":false}]'::jsonb, 2,
       'Coordination LPGA : la somme des prestations ne peut dépasser le dommage effectif (revenu net perdu). L''IJM se réduit à concurrence de la rente AI selon règles contractuelles LCA.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'social_connexe'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-MAL-SC-016', 'maladie_complementaire', t.id, 'single',
       'Une salariée en burn-out est reconnue invalide à 45 %.', 'Le taux minimum d''invalidité ouvrant droit à une rente AI est :', '[{"text":"20 %","correct":false,"why_wrong":"Taux insuffisant."},{"text":"40 %","correct":true},{"text":"50 %","correct":false,"why_wrong":"50 % ouvre une demi-rente, pas le premier quart."},{"text":"70 %","correct":false,"why_wrong":"70 % ouvre une rente entière."}]'::jsonb, 2,
       'Art. 28 LAI : rente AI dès 40 % d''invalidité (échelonnement linéaire jusqu''à 70 % = rente entière). Piège VBV : bien retenir le seuil 40 % (rente initiale).', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'social_connexe'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-MAL-SC-017', 'maladie_complementaire', t.id, 'single',
       NULL, 'L''APG paternité prise en charge se paie-t-elle en jours ou en semaines ?', '[{"text":"10 jours ouvrables (2 semaines)","correct":true},{"text":"14 jours calendaires","correct":false,"why_wrong":"Le décompte est en jours ouvrables."},{"text":"30 jours","correct":false},{"text":"60 jours","correct":false}]'::jsonb, 1,
       'LAPG art. 16j : congé paternité = 10 jours ouvrables (2 semaines) à prendre dans les 6 mois suivant la naissance, en une fois ou fractionné.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'social_connexe'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-MAL-SC-018', 'maladie_complementaire', t.id, 'single',
       NULL, 'Un employeur défaillant (sans assurance LAA) laisse un accidenté sans couverture. Qui intervient ?', '[{"text":"La SUVA obligatoirement","correct":false,"why_wrong":"La SUVA n''intervient que pour ses branches assurées."},{"text":"La caisse supplétive LAA (art. 73 LAA)","correct":true},{"text":"L''AOS","correct":false,"why_wrong":"L''AOS n''assume pas les frais accidents relevant LAA."},{"text":"Le canton","correct":false}]'::jsonb, 1,
       'Art. 73 LAA : la caisse supplétive garantit les prestations LAA quand un employeur soumis n''a pas assuré ses salariés. Recours contre l''employeur ensuite.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'social_connexe'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-MAL-SC-019', 'maladie_complementaire', t.id, 'multiple',
       'Nadia, salariée 32 ans, tombe enceinte. Elle vient consulter son conseiller pour comprendre ses droits.', 'Que peut-elle attendre concrètement ?', '[{"text":"LAMal : prise en charge maternité (art. 29) exempte de participation aux coûts","correct":true},{"text":"LAPG : allocation maternité 14 semaines à 80 % (max 220 CHF/jour) après l''accouchement","correct":true},{"text":"Employeur : maintien du salaire selon CO 324a et LTr (interdiction de travail 8 semaines post-partum)","correct":true},{"text":"APG à la place de la LAMal pour les frais médicaux","correct":false,"why_wrong":"APG couvre le revenu, LAMal les frais médicaux."},{"text":"Résiliation de son contrat de travail possible pendant la grossesse","correct":false,"why_wrong":"Protection contre le licenciement pendant grossesse + 16 semaines (art. 336c CO)."}]'::jsonb, 3,
       'Panorama complet : LAMal (soins) + LAPG (revenu) + CO/LTr (protection travail). Conseil global grossesse : ne pas confondre les régimes. Compléter éventuellement par une LCA hospit privée pour le confort.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'social_connexe'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-MAL-SC-020', 'maladie_complementaire', t.id, 'single',
       'Un consultant IT indépendant demande s''il est couvert LAA d''office.', 'Un indépendant est-il obligatoirement affilié à la LAA ?', '[{"text":"Oui, comme les salariés","correct":false,"why_wrong":"Piège VBV majeur : les indépendants NE sont PAS soumis à la LAA obligatoire."},{"text":"Non, LAA facultative pour les indépendants (art. 4 LAA)","correct":true},{"text":"Uniquement s''il emploie du personnel","correct":false,"why_wrong":"L''employeur assure ses employés, mais pour lui-même c''est facultatif."},{"text":"Uniquement en cas d''activité manuelle","correct":false}]'::jsonb, 1,
       'Art. 1a et 4 LAA : les salariés sont couverts obligatoirement. Les indépendants (et membres de famille non salariés) peuvent s''assurer à titre facultatif. Point de conseil essentiel aux indépendants.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'social_connexe'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-MAL-CO-001', 'maladie_complementaire', t.id, 'single',
       'Un client demande une copie de sa fiche d''information avant tout entretien.', 'Quel article de la LSA impose la remise d''une fiche d''information client au 1er entretien ?', '[{"text":"Art. 40 LSA","correct":false,"why_wrong":"Art. 40 distingue courtier et agent lié."},{"text":"Art. 45 LSA","correct":true},{"text":"Art. 3 LCA","correct":false,"why_wrong":"Art. 3 LCA = devoir d''information de l''assureur."},{"text":"Art. 6 LCA","correct":false}]'::jsonb, 1,
       'Art. 45 LSA : l''intermédiaire doit remettre au client au 1er contact une fiche d''information (identité, produits, rémunération, autorité de surveillance, procédure de plainte).', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'conseil'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-MAL-CO-002', 'maladie_complementaire', t.id, 'single',
       NULL, 'Quelles sont les 4 phases de l''entretien de conseil VBV ?', '[{"text":"Introduction, argumentation, vente, encaissement","correct":false,"why_wrong":"Vocabulaire commercial, pas VBV."},{"text":"Introduction, analyse, solution, conclusion","correct":true},{"text":"Acquisition, présentation, négociation, closing","correct":false},{"text":"Prise de contact, questionnaire, tarification, signature","correct":false}]'::jsonb, 1,
       'Structure officielle VBV : 4 phases (introduction, analyse des besoins, présentation de la solution, conclusion). Ces 4 phases structurent aussi l''étude de cas dirigée à l''examen.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'conseil'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-MAL-CO-003', 'maladie_complementaire', t.id, 'multiple',
       NULL, 'Que doit typiquement contenir la fiche d''information client (art. 45 LSA) ?', '[{"text":"Identité de l''intermédiaire et de l''assureur","correct":true},{"text":"Nature de la relation (courtier indépendant ou agent lié)","correct":true},{"text":"Rémunération (commissions, honoraires)","correct":true},{"text":"Autorité de surveillance et procédure de plainte","correct":true},{"text":"Historique médical du conseiller","correct":false,"why_wrong":"L''historique médical n''a rien à voir avec la fiche."}]'::jsonb, 2,
       'Art. 45 LSA : la fiche doit assurer la transparence sur l''intermédiaire, sa rémunération, son statut et les voies de recours. Document conservé et signé par le client.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'conseil'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-MAL-CO-004', 'maladie_complementaire', t.id, 'single',
       'Un intermédiaire souhaite envoyer les données santé d''un client à son courtier partenaire.', 'Selon la nLPD, les données de santé sont :', '[{"text":"Ordinaires, traitables librement","correct":false,"why_wrong":"Elles sont classées sensibles."},{"text":"Sensibles (art. 5 lit. c ch. 2 nLPD), consentement explicite et sécurisation renforcée","correct":true},{"text":"Publiques","correct":false},{"text":"Secrètes uniquement en cas de séropositivité","correct":false}]'::jsonb, 2,
       'Art. 5 lit. c ch. 2 nLPD : les données concernant la santé sont sensibles, exigeant consentement explicite, sécurisation renforcée, base légale claire pour tout traitement. Levier majeur en conseil santé.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'conseil'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-MAL-CO-005', 'maladie_complementaire', t.id, 'single',
       NULL, 'Un conseiller peut-il donner un avis médical personnalisé à un client ?', '[{"text":"Oui, si formé","correct":false,"why_wrong":"Piège classique : hors périmètre professionnel."},{"text":"Non, jamais (hors compétence : renvoyer au médecin)","correct":true},{"text":"Oui, pour les cas simples","correct":false},{"text":"Uniquement pour les diagnostics psychologiques","correct":false}]'::jsonb, 1,
       'Éthique et cadre de la LSA : le conseiller ne dispense JAMAIS de conseil médical. Renvoi systématique au médecin traitant ou spécialiste. Option ''conseil médical'' toujours fausse en VBV.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'conseil'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-MAL-CO-006', 'maladie_complementaire', t.id, 'single',
       NULL, 'Un courtier (art. 40 LSA) se distingue d''un agent lié par :', '[{"text":"Son indépendance à l''égard des assureurs (représente le client)","correct":true},{"text":"Son mandat unique auprès d''un seul assureur","correct":false,"why_wrong":"C''est la définition de l''agent lié."},{"text":"L''absence de rémunération","correct":false,"why_wrong":"Le courtier reçoit aussi une rémunération."},{"text":"L''exclusion de la surveillance FINMA","correct":false,"why_wrong":"Les deux sont surveillés."}]'::jsonb, 2,
       'Art. 40 LSA : le courtier agit en tant qu''intermédiaire indépendant, mandaté par le client, sans lien contractuel exclusif avec un assureur. L''agent lié représente un ou plusieurs assureurs qui l''ont mandaté.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'conseil'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-MAL-CO-007', 'maladie_complementaire', t.id, 'multiple',
       NULL, 'Que doit couvrir la phase Analyse d''un entretien de conseil santé ?', '[{"text":"Situation personnelle et familiale du client","correct":true},{"text":"Situation financière et professionnelle","correct":true},{"text":"Couvertures existantes (AOS, LCA, IJM)","correct":true},{"text":"Besoins prioritaires exprimés","correct":true},{"text":"Signature immédiate du contrat","correct":false,"why_wrong":"La signature est en phase Conclusion, pas Analyse."}]'::jsonb, 2,
       'Phase Analyse : recueil exhaustif d''informations pertinentes. Base d''une proposition adaptée, protège aussi le conseiller (traçabilité, obligation LSA).', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'conseil'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-MAL-CO-008', 'maladie_complementaire', t.id, 'single',
       'Un conseiller expérimenté rappelle à son stagiaire les preuves à conserver.', 'Le PV de conseil (procès-verbal d''entretien) est :', '[{"text":"Facultatif","correct":false,"why_wrong":"Il est essentiel pour la traçabilité et la protection du conseiller."},{"text":"Fortement recommandé, sert de trace écrite du conseil donné et signé par le client","correct":true},{"text":"Un document interne de la compagnie","correct":false},{"text":"Un document de l''autorité fiscale","correct":false}]'::jsonb, 1,
       'PV de conseil : trace la situation analysée, les besoins identifiés, la solution proposée, les recommandations écartées. Signé par le client. Protection majeure en cas de litige (art. 45 LSA + jurisprudence).', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'conseil'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-MAL-CO-009', 'maladie_complementaire', t.id, 'single',
       'Karim consulte pour la 1re fois. Le conseiller lui propose immédiatement un contrat sans questionnaire préalable.', 'Quelle règle est violée ?', '[{"text":"Aucune, la vente rapide est encouragée","correct":false,"why_wrong":"L''analyse est obligatoire."},{"text":"Devoir d''analyse des besoins (art. 45 LSA + phase Analyse VBV)","correct":true},{"text":"Interdiction de vente le lundi","correct":false,"why_wrong":"Aucune telle règle."},{"text":"Devoir de confidentialité","correct":false}]'::jsonb, 2,
       'Art. 45 LSA + méthode VBV : impossible de proposer une solution adaptée sans phase d''analyse. La proposition doit reposer sur des besoins identifiés. Vente forcée = manquement disciplinaire potentiel.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'conseil'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-MAL-CO-010', 'maladie_complementaire', t.id, 'single',
       'Un futur intermédiaire indépendant prépare son dossier FINMA.', 'Un conseiller doit-il être inscrit à un registre public ?', '[{"text":"Non","correct":false,"why_wrong":"L''inscription au registre FINMA est requise pour les intermédiaires non liés."},{"text":"Oui, au registre FINMA des intermédiaires (art. 42 et 43 LSA)","correct":true},{"text":"Uniquement les courtiers étrangers","correct":false},{"text":"Uniquement les indépendants","correct":false}]'::jsonb, 1,
       'Art. 42 LSA : registre public FINMA des intermédiaires non liés (courtiers). L''agent lié est enregistré via sa compagnie. Vérification possible sur le site FINMA.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'conseil'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-MAL-CO-011', 'maladie_complementaire', t.id, 'single',
       NULL, 'Le devoir d''information de l''assureur LCA cesse-t-il à la signature du contrat (art. 3 LCA) ?', '[{"text":"Oui, une fois signé","correct":false,"why_wrong":"Piège Anisa : le devoir est continu."},{"text":"Non, il est continu tout au long de la relation contractuelle","correct":true},{"text":"Uniquement pour les cas de sinistre","correct":false},{"text":"Uniquement en cas de changement de prime","correct":false}]'::jsonb, 1,
       'Art. 3 LCA : devoir d''information continu (avant, pendant, après signature). Toute modification tarifaire, contractuelle, réglementaire doit être communiquée. Base de la relation de confiance.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'conseil'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-MAL-CO-012', 'maladie_complementaire', t.id, 'multiple',
       NULL, 'Quels documents un conseiller doit-il typiquement conserver pour une durée légale ?', '[{"text":"Fiche d''information client signée (art. 45 LSA)","correct":true},{"text":"PV de conseil daté et signé","correct":true},{"text":"Contrats et avenants signés","correct":true},{"text":"Dossier médical intégral du client","correct":false,"why_wrong":"Le dossier médical intégral ne relève pas du conseiller."},{"text":"Photocopie de la carte de crédit du client","correct":false,"why_wrong":"Aucune raison légitime, violation nLPD/LBA."}]'::jsonb, 2,
       'Traçabilité minimale : fiche LSA, PV, contrats. Durée de conservation : 10 ans après fin de contrat (CO 962). Interdiction de conserver plus que nécessaire pour la finalité (nLPD).', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'conseil'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-MAL-CO-013', 'maladie_complementaire', t.id, 'single',
       NULL, 'Combien d''heures de formation continue sont typiquement exigées pour un intermédiaire d''assurance ?', '[{"text":"5 heures/an","correct":false,"why_wrong":"Chiffre trop bas."},{"text":"20 heures/an (60 heures sur 3 ans, standard VBV)","correct":true},{"text":"100 heures/an","correct":false},{"text":"Aucune obligation","correct":false,"why_wrong":"Obligation de formation continue existe."}]'::jsonb, 2,
       'Cercle des intermédiaires + VBV : 20 heures de formation continue/an ou 60 heures/3 ans, à documenter. Depuis LSA révisée, obligation renforcée pour maintenir l''agrément.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'conseil'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-MAL-CO-014', 'maladie_complementaire', t.id, 'single',
       NULL, 'Un client refuse de signer le consentement de traitement de ses données de santé. Que doit faire le conseiller ?', '[{"text":"Continuer et enregistrer les données quand même","correct":false,"why_wrong":"Violation majeure nLPD art. 5-6."},{"text":"Respecter le refus, expliquer les conséquences (offre impossible à personnaliser) et documenter le refus","correct":true},{"text":"Signer à la place du client","correct":false,"why_wrong":"Faux en documents."},{"text":"Menacer d''un refus définitif de toute assurance","correct":false}]'::jsonb, 2,
       'nLPD art. 5-6 : consentement explicite requis pour les données sensibles. Refus opposable : le conseiller documente et informe des conséquences (impossibilité d''offrir un produit personnalisé). Respect absolu.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'conseil'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-MAL-CO-015', 'maladie_complementaire', t.id, 'multiple',
       NULL, 'La phase Conclusion d''un entretien de conseil comprend typiquement :', '[{"text":"Récapitulatif de la solution retenue","correct":true},{"text":"Signature de la proposition/police","correct":true},{"text":"Rappel du droit de révocation (14 jours art. 2a LCA)","correct":true},{"text":"Prise de RDV de suivi","correct":true},{"text":"Récupération immédiate de la carte de crédit","correct":false,"why_wrong":"Encaissement de la prime ne se fait pas sans mandat spécifique."}]'::jsonb, 2,
       'Phase Conclusion (VBV 4e phase) : bouclage clair, engagement écrit, information sur droits post-signature, prochain contact. Base d''une relation client durable.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'conseil'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-MAL-CO-016', 'maladie_complementaire', t.id, 'single',
       'Une cliente demande à voir toutes ses données conservées par la compagnie.', 'Le droit d''accès du client à ses données personnelles est régi par :', '[{"text":"Art. 3 LCA","correct":false,"why_wrong":"Art. 3 LCA = devoir d''information de l''assureur, pas accès aux données."},{"text":"Art. 25 nLPD (droit d''accès)","correct":true},{"text":"Art. 40 LSA","correct":false},{"text":"Art. 6 LCA","correct":false}]'::jsonb, 1,
       'Art. 25 nLPD : le client peut demander l''accès à ses données personnelles auprès du responsable de traitement, avec délai de 30 jours pour répondre. Devoir renforcé en 2023 avec l''entrée en vigueur de la nLPD.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'conseil'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-MAL-CO-017', 'maladie_complementaire', t.id, 'single',
       'Marie signe une LCA hospitalisation privée. Elle appelle 10 jours plus tard pour se rétracter, invoquant une meilleure offre concurrente.', 'Quelle est la réponse à lui apporter ?', '[{"text":"Le contrat est ferme, aucune rétractation possible","correct":false,"why_wrong":"Droit de révocation 14 jours applicable."},{"text":"Elle peut se rétracter dans le délai de 14 jours (art. 2a LCA) par écrit ou forme démontrable par texte","correct":true},{"text":"Rétractation seulement avec accord de la compagnie","correct":false},{"text":"Rétractation impossible après paiement de la 1re prime","correct":false}]'::jsonb, 2,
       'Art. 2a LCA : révocation 14 jours dès l''acceptation de la proposition ou dès réception de la police. Aucun frais, sans motif. Marie est à J+10, dans les délais.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'conseil'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-MAL-CO-018', 'maladie_complementaire', t.id, 'single',
       'Un directeur commercial propose de partager les données santé avec un partenaire pub.', 'Un conseiller peut-il transmettre les données de santé du client à un partenaire commercial à des fins publicitaires ?', '[{"text":"Oui, avec consentement implicite","correct":false,"why_wrong":"Consentement explicite requis, interdiction pour la publicité."},{"text":"Non, jamais (interdiction absolue nLPD art. 5-6 pour les données sensibles à des fins étrangères)","correct":true},{"text":"Oui, dans les 30 jours suivant la signature","correct":false},{"text":"Uniquement si le partenaire est en Suisse","correct":false}]'::jsonb, 1,
       'nLPD art. 5 lit. c ch. 2 + art. 6 : données de santé sensibles. Interdiction absolue de transmission à des tiers pour marketing sans base légale et consentement explicite spécifique. Sanction pénale possible.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'conseil'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-MAL-CO-019', 'maladie_complementaire', t.id, 'multiple',
       'Ali, 45 ans, consulte pour la 1re fois. Il souhaite optimiser sa couverture santé (AOS, IJM en tant qu''indépendant, LCA hospit privée).', 'Quelles obligations le conseiller doit-il respecter ?', '[{"text":"Remise de la fiche d''information client (art. 45 LSA)","correct":true},{"text":"Analyse complète des besoins (phase 2 VBV)","correct":true},{"text":"Consentement écrit pour le traitement des données de santé (nLPD)","correct":true},{"text":"Rédaction d''un PV de conseil signé","correct":true},{"text":"Prescription médicale préalable","correct":false,"why_wrong":"Aucune prescription requise pour un conseil en assurance."}]'::jsonb, 3,
       'Enchaînement classique : LSA + nLPD + méthode VBV. Un dossier complet et signé protège le conseiller et documente la valeur ajoutée du conseil. Base pour la formation continue.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'conseil'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-MAL-CO-020', 'maladie_complementaire', t.id, 'multiple',
       NULL, 'Quelles règles éthiques et légales encadrent la conduite d''un intermédiaire en assurance ?', '[{"text":"Devoir de loyauté et de diligence envers le client (art. 45 LSA)","correct":true},{"text":"Formation continue documentée (obligation professionnelle)","correct":true},{"text":"Respect de la nLPD (données sensibles santé)","correct":true},{"text":"Respect de la LCD (concurrence loyale)","correct":true},{"text":"Signalement obligatoire des états de santé au fisc","correct":false,"why_wrong":"Aucune obligation de ce type : violation du secret professionnel."}]'::jsonb, 2,
       'Cadre éthique/légal : LSA (devoir professionnel), nLPD (données), LCD (concurrence loyale), formation continue. Le secret professionnel protège les données du client. Ne jamais transmettre au fisc/tiers sans base légale expresse.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'maladie_complementaire' AND t.key = 'conseil'
ON CONFLICT (external_id) DO NOTHING;

-- ───────── nonvie_gaps.json — Compléments Klary NON-VIE gaps 35 questions. Ciblage thèmes légers : propriété du logement (10), litiges juridiques (10), conduite de l'entretien non-vie (15). ─────────
INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-NV-GAP-001', 'non_vie', t.id, 'multiple',
       NULL, 'Dans quels cantons romands ou alémaniques l''assurance bâtiment ECA (assurance immobilière cantonale) est-elle obligatoire et monopolistique ?', '[{"text":"Vaud (VD)","correct":true},{"text":"Fribourg (FR)","correct":true},{"text":"Jura (JU)","correct":true},{"text":"Neuchâtel (NE)","correct":true},{"text":"Bâle-Ville (BS)","correct":true},{"text":"Genève (GE)","correct":false,"why_wrong":"Genève est un canton dit GUSTAVO (marché privé), pas d''ECA cantonale."},{"text":"Zurich (ZH)","correct":false,"why_wrong":"Zurich a bien un établissement cantonal mais avec particularités ; le point clé du QCM est qu''ECA romande est présente à VD/FR/JU/NE + GL/GR/BS."},{"text":"Valais (VS)","correct":false,"why_wrong":"Valais est en marché privé."}]'::jsonb, 2,
       'Cantons à ECA obligatoire (monopoles cantonaux) : AG, BE, BL, BS, FR, GL, GR, JU, LU, NE, NW, SG, SH, SO, TG, VD, ZG, ZH. Cantons GUSTAVO (marché privé) : GE, VS, TI, UR, SZ, OW, AI, AR.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'non_vie' AND t.key = 'propriete_logement'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-NV-GAP-002', 'non_vie', t.id, 'single',
       'M. Baumann réalise une extension importante (véranda + panneaux photovoltaïques) de sa villa vaudoise, augmentant la valeur du bâtiment de 25 %.', 'Que doit-il obligatoirement faire vis-à-vis de son assureur bâtiment (ECA VD ou complément privé) ?', '[{"text":"Annoncer immédiatement la modification et la nouvelle valeur pour adapter la somme d''assurance (art. 51 LCA / règlement ECA)","correct":true},{"text":"Rien : l''ECA couvre automatiquement toute augmentation","correct":false,"why_wrong":"Aucune couverture automatique en cas d''aggravation du risque."},{"text":"Attendre le sinistre pour recalculer","correct":false,"why_wrong":"Attendre le sinistre = sous-assurance et application règle proportionnelle art. 69 LCA."},{"text":"Résilier son contrat et en souscrire un nouveau","correct":false}]'::jsonb, 2,
       'Art. 51 LCA (aggravation) + règlements ECA cantonales : annoncer les modifications significatives du bâtiment. Défaut d''annonce = risque de sous-assurance (règle proportionnelle) ou de résiliation.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'non_vie' AND t.key = 'propriete_logement'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-NV-GAP-003', 'non_vie', t.id, 'single',
       NULL, 'Sur quelle base légale repose la responsabilité civile du propriétaire d''immeuble pour dommages causés par vices de construction ou défauts d''entretien ?', '[{"text":"Art. 58 CO : responsabilité causale objective du propriétaire d''ouvrage","correct":true},{"text":"Art. 41 CO : responsabilité pour acte illicite fautif","correct":false,"why_wrong":"L''art. 41 exige une faute ; l''art. 58 est causal, sans faute."},{"text":"Art. 55 CO : responsabilité de l''employeur","correct":false,"why_wrong":"Concerne les auxiliaires salariés, pas les ouvrages."},{"text":"Art. 328 CO : protection de la personnalité du travailleur","correct":false}]'::jsonb, 2,
       'Art. 58 CO : le propriétaire d''un bâtiment ou de tout autre ouvrage répond du dommage causé par des vices de construction ou par le défaut d''entretien. Responsabilité causale, sans faute exigée.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'non_vie' AND t.key = 'propriete_logement'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-NV-GAP-004', 'non_vie', t.id, 'single',
       'M. Delacroix mandate un entrepreneur pour rénover sa toiture. Un ouvrier chute d''un échafaudage mal sécurisé et se blesse gravement.', 'Quelle responsabilité peut être engagée pour le maître d''ouvrage particulier et quelle assurance intervient ?', '[{"text":"Responsabilité du maître d''ouvrage art. 58 CO + RC entreprise du poseur ; couverture par RC propriétaire d''ouvrage (RC chantier)","correct":true},{"text":"Aucune responsabilité du maître d''ouvrage : seul l''entrepreneur répond","correct":false,"why_wrong":"Le maître d''ouvrage peut être coresponsable en cas de manquement à son devoir de coordination (SIA/CFC)."},{"text":"Uniquement RC véhicule si l''ouvrier est arrivé en voiture","correct":false,"why_wrong":"Aucun rapport avec la LCR pour un accident sur chantier."},{"text":"RC privée classique du particulier","correct":false,"why_wrong":"La RC privée exclut les risques liés à un chantier de construction significatif."}]'::jsonb, 2,
       'Pour tout chantier privé important : souscrire une RC propriétaire d''ouvrage (RC chantier / RC constructeur), en complément de la RC pro des entreprises. Base : art. 58 CO + CGA type marché.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'non_vie' AND t.key = 'propriete_logement'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-NV-GAP-005', 'non_vie', t.id, 'single',
       NULL, 'Quelle est la différence essentielle entre valeur à neuf et valeur vénale d''un bâtiment ?', '[{"text":"Valeur à neuf = coût de reconstruction à neuf ; valeur vénale = valeur à neuf moins vétusté","correct":true},{"text":"Valeur à neuf = valeur du terrain ; valeur vénale = valeur du bâtiment seul","correct":false,"why_wrong":"Confusion avec valeur immobilière globale."},{"text":"Valeur à neuf = prix de vente ; valeur vénale = valeur d''incendie","correct":false,"why_wrong":"La valeur d''incendie est en réalité la valeur à neuf assurée par l''ECA."},{"text":"Aucune différence en pratique","correct":false}]'::jsonb, 1,
       'Assurance bâtiment (ECA/privée) : indemnité normalement calculée sur valeur à neuf (coût actuel de reconstruction). La valeur vénale est le prix probable de vente (valeur à neuf déduction faite de la vétusté).', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'non_vie' AND t.key = 'propriete_logement'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-NV-GAP-006', 'non_vie', t.id, 'single',
       NULL, 'À quoi sert l''indice ICH (indice des coûts de construction) dans un contrat d''assurance bâtiment ?', '[{"text":"Adapter annuellement la somme d''assurance à l''évolution des coûts de construction pour éviter la sous-assurance","correct":true},{"text":"Fixer le taux d''imposition foncière","correct":false,"why_wrong":"L''ICH n''a aucune fonction fiscale."},{"text":"Calculer la prime uniquement en fonction des sinistres passés","correct":false,"why_wrong":"L''ICH est un indice de coût, pas une statistique sinistres."},{"text":"Déterminer la valeur cadastrale","correct":false,"why_wrong":"La valeur cadastrale relève des cantons, indépendante de l''ICH."}]'::jsonb, 1,
       'Indice cantonal des coûts de construction (ICH) : ajuste automatiquement la somme d''assurance bâtiment pour suivre l''inflation des coûts. Anti sous-assurance (art. 69 LCA).', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'non_vie' AND t.key = 'propriete_logement'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-NV-GAP-007', 'non_vie', t.id, 'single',
       'Une maison assurée pour 500 000 CHF vaut réellement 800 000 CHF (valeur à neuf). Un incendie détruit pour 200 000 CHF.', 'Quel montant d''indemnité l''assureur privé (hors ECA monopolistique) versera-t-il en application de l''art. 69 LCA ?', '[{"text":"125 000 CHF (200 000 x 500 000 / 800 000)","correct":true},{"text":"200 000 CHF (le dommage complet)","correct":false,"why_wrong":"Ignore la règle proportionnelle applicable en cas de sous-assurance."},{"text":"500 000 CHF (somme assurée)","correct":false,"why_wrong":"Le dommage est inférieur à la somme assurée : le plafond ne joue pas."},{"text":"0 CHF (contrat nul)","correct":false,"why_wrong":"La sous-assurance réduit l''indemnité, n''annule pas le contrat."}]'::jsonb, 3,
       'Art. 69 al. 2 LCA (règle proportionnelle) : indemnité = dommage x (somme assurée / valeur réelle). 200 000 x (500 000 / 800 000) = 125 000 CHF.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'non_vie' AND t.key = 'propriete_logement'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-NV-GAP-008', 'non_vie', t.id, 'multiple',
       NULL, 'Quels dommages sont typiquement couverts par une assurance bâtiment complémentaire privée (au-delà de l''ECA) ?', '[{"text":"Dégâts d''eau (rupture de conduites, refoulement, pluie)","correct":true},{"text":"Bris de glaces du bâtiment","correct":true},{"text":"Vol par effraction dans les parties communes","correct":true},{"text":"Tremblement de terre selon options du canton","correct":true},{"text":"Usure normale des matériaux","correct":false,"why_wrong":"L''usure n''est pas un sinistre au sens de la LCA."},{"text":"Négligence intentionnelle du propriétaire","correct":false,"why_wrong":"L''intentionnel est exclu (art. 14 LCA)."}]'::jsonb, 2,
       'ECA cantonale couvre incendie et éléments naturels (art. 33 LCA + règlements cantonaux). Compléments privés : dégâts d''eau, vol, bris glaces, séisme selon canton.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'non_vie' AND t.key = 'propriete_logement'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-NV-GAP-009', 'non_vie', t.id, 'single',
       NULL, 'Que couvre spécifiquement une RC propriétaire d''immeuble locatif (non habité par le propriétaire) ?', '[{"text":"Les dommages causés à des tiers (locataires, visiteurs) par le bâtiment lui-même ou son entretien","correct":true},{"text":"Les loyers impayés des locataires","correct":false,"why_wrong":"Cela relève d''une assurance loyers, pas d''une RC."},{"text":"Les dommages aux biens propres du propriétaire","correct":false,"why_wrong":"L''assurance choses les couvre, pas la RC."},{"text":"Les frais d''entretien courant","correct":false,"why_wrong":"Aucune assurance couvre l''entretien courant."}]'::jsonb, 1,
       'RC propriétaire d''immeuble : couverture des prétentions de tiers fondées sur l''art. 58 CO (dommage causé par vice ou défaut d''entretien du bâtiment). Indispensable pour tout immeuble de rendement.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'non_vie' AND t.key = 'propriete_logement'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-NV-GAP-010', 'non_vie', t.id, 'single',
       'Une PPE en Valais (canton GUSTAVO, sans ECA) doit s''assurer pour l''incendie et les éléments naturels.', 'Quelle est la particularité du marché valaisan pour l''assurance bâtiment ?', '[{"text":"Marché privé ouvert : la PPE choisit librement un assureur privé, avec offre compétitive","correct":true},{"text":"Monopole cantonal ECA Valais obligatoire","correct":false,"why_wrong":"VS est GUSTAVO, pas d''ECA."},{"text":"Interdiction totale d''assurer contre l''incendie","correct":false,"why_wrong":"Absurde : la couverture est obligatoire, seulement via marché privé."},{"text":"Obligation d''auto-assurance","correct":false}]'::jsonb, 2,
       'Cantons GUSTAVO (GE, VS, TI, UR, SZ, OW, AI, AR) : bâtiment assuré via marché privé, pas d''ECA. Concurrence entre assureurs privés.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'non_vie' AND t.key = 'propriete_logement'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-NV-GAP-011', 'non_vie', t.id, 'single',
       NULL, 'Quelle est la différence essentielle entre protection juridique circulation et protection juridique privée ?', '[{"text":"La PJ circulation couvre les litiges liés au véhicule et à la LCR ; la PJ privée couvre les autres domaines (travail, bail, consommation, patrimoine)","correct":true},{"text":"La PJ circulation est facultative ; la PJ privée est obligatoire","correct":false,"why_wrong":"Les deux sont facultatives (LCA)."},{"text":"Aucune différence : elles se substituent l''une à l''autre","correct":false,"why_wrong":"Chacune couvre un périmètre distinct."},{"text":"PJ circulation prend en charge les amendes","correct":false,"why_wrong":"Les amendes pénales sont exclues des PJ."}]'::jsonb, 1,
       'Marché suisse : PJ circulation (usage véhicule, sinistre LCR, recours, permis) et PJ privée (bail, travail, consommation, voisinage, patrimoine, contrats). Souvent combinées, jamais confondues.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'non_vie' AND t.key = 'litiges_nv'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-NV-GAP-012', 'non_vie', t.id, 'single',
       NULL, 'Quand l''assuré peut-il exercer le libre choix de l''avocat selon la LSA ?', '[{"text":"Dès qu''un conflit d''intérêts avec l''assureur PJ apparaît, ou dès qu''une procédure judiciaire ou administrative est engagée (art. 32 LSA)","correct":true},{"text":"Uniquement pour les affaires supérieures à 100 000 CHF","correct":false,"why_wrong":"Aucun seuil monétaire ; c''est l''existence de la procédure ou du conflit qui déclenche."},{"text":"Jamais : l''assureur impose son avocat","correct":false,"why_wrong":"Violation de l''art. 32 LSA."},{"text":"Uniquement en droit pénal","correct":false,"why_wrong":"Le libre choix couvre tous les domaines dès qu''une procédure ou un conflit intervient."}]'::jsonb, 2,
       'Art. 32 LSA : libre choix de l''avocat garanti dès conflit d''intérêts assuré/assureur ou dès qu''une procédure judiciaire ou administrative doit être ouverte. Directive UE reprise en droit suisse.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'non_vie' AND t.key = 'litiges_nv'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-NV-GAP-013', 'non_vie', t.id, 'multiple',
       NULL, 'Quels domaines sont typiquement exclus des CGA de protection juridique privée sur le marché suisse ?', '[{"text":"Litiges de droit de la famille (divorce, garde, entretien)","correct":true},{"text":"Procès pénaux pour crime ou faute grave intentionnelle","correct":true},{"text":"Litiges liés au patrimoine spéculatif et jeux de hasard","correct":true},{"text":"Litiges bailleur professionnel/locataire dans certains produits","correct":true},{"text":"Litige salarial d''un employé assuré (couvert avec délai de carence)","correct":false,"why_wrong":"Généralement couvert (avec délai carence 3 mois), pas exclu."},{"text":"Recours automobile après collision","correct":false,"why_wrong":"Recours LCR : cœur de la PJ circulation."}]'::jsonb, 2,
       'Exclusions typiques PJ privée (CGA marché) : droit de la famille, pénal grave intentionnel, spéculation, guerre, dette de jeu. Les litiges de bail et travail sont en principe inclus (délai carence).', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'non_vie' AND t.key = 'litiges_nv'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-NV-GAP-014', 'non_vie', t.id, 'single',
       'Un salarié souscrit une PJ privée le 1er février et cite son employeur en justice le 15 mars pour un litige salarial dont il connaissait l''existence en janvier.', 'L''assureur PJ intervient-il ?', '[{"text":"Non : délai de carence typique 3 mois pour litiges de travail et litige préexistant à la souscription","correct":true},{"text":"Oui, sans réserve","correct":false,"why_wrong":"Ignore le délai de carence et l''antériorité du litige."},{"text":"Oui, mais uniquement pour les frais d''avocat","correct":false,"why_wrong":"Aucune couverture partielle : sinistre antérieur à la couverture."},{"text":"Oui, si le préjudice dépasse 10 000 CHF","correct":false,"why_wrong":"Aucun seuil ne fait renaître un litige préexistant."}]'::jsonb, 2,
       'CGA type PJ privée : délai carence 3 mois pour bail, travail, contrats ; exclusion des litiges préexistants (art. 9 LCA sinistre déjà survenu). Sinistre non couvert.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'non_vie' AND t.key = 'litiges_nv'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-NV-GAP-015', 'non_vie', t.id, 'single',
       NULL, 'Quelles sommes d''assurance PJ retrouve-t-on classiquement sur le marché suisse ?', '[{"text":"Entre 250 000 CHF et 600 000 CHF par cas, selon le produit","correct":true},{"text":"10 000 à 20 000 CHF par cas","correct":false,"why_wrong":"Trop bas ; les PJ standard sont plus larges."},{"text":"1 000 000 à 5 000 000 CHF systématique","correct":false,"why_wrong":"Fourchette exceptionnelle, pas standard."},{"text":"Illimité pour tous les produits","correct":false,"why_wrong":"Aucun assureur PJ suisse ne propose une somme illimitée standard."}]'::jsonb, 1,
       'Sommes d''assurance PJ marché suisse : 250 000 à 600 000 CHF par cas est la fourchette standard, avec sous-limites selon la nature du litige et l''étranger.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'non_vie' AND t.key = 'litiges_nv'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-NV-GAP-016', 'non_vie', t.id, 'single',
       NULL, 'Comment la LSA garantit-elle l''indépendance de la gestion des sinistres PJ vis-à-vis de l''assureur de responsabilité ?', '[{"text":"Séparation organisationnelle (entreprise distincte, gestion externalisée, ou déclaration d''indépendance) selon art. 32 LSA et OS","correct":true},{"text":"Interdiction totale d''appartenir à un même groupe","correct":false,"why_wrong":"Le groupe est admis avec séparation ; pas d''interdiction absolue."},{"text":"Aucune obligation particulière","correct":false,"why_wrong":"Violerait la directive européenne reprise en LSA."},{"text":"Contrôle direct de la FINMA pour chaque sinistre","correct":false}]'::jsonb, 2,
       'Art. 32 LSA : séparation organisationnelle (Chinese wall), entité juridique distincte ou externalisation. But : éviter conflit d''intérêts entre RC et PJ.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'non_vie' AND t.key = 'litiges_nv'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-NV-GAP-017', 'non_vie', t.id, 'single',
       'L''assureur PJ estime les chances de succès de l''assuré insuffisantes et refuse la prise en charge d''une procédure.', 'Quel droit essentiel possède l''assuré dans ce cas ?', '[{"text":"Demander une expertise arbitrale (arbitre indépendant) ou saisir l''ombudsman ; passer outre à ses frais et être remboursé si succès","correct":true},{"text":"Aucun recours possible","correct":false,"why_wrong":"Contraire aux CGA type et à la LSA."},{"text":"Attaquer directement l''assureur devant la FINMA","correct":false,"why_wrong":"La FINMA ne tranche pas les litiges individuels."},{"text":"Exiger le paiement immédiat de la somme assurée","correct":false,"why_wrong":"La somme assurée n''est pas une prestation forfaitaire."}]'::jsonb, 3,
       'CGA type PJ + art. 32 LSA : en cas de refus pour chances de succès insuffisantes, l''assuré peut demander une expertise arbitrale (arbitre) ; ombudsman assurance privée ; s''il gagne à ses frais, prise en charge rétroactive.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'non_vie' AND t.key = 'litiges_nv'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-NV-GAP-018', 'non_vie', t.id, 'single',
       NULL, 'Une PJ entreprise couvre-t-elle par défaut les litiges de l''entreprise contre ses propres salariés ?', '[{"text":"Oui, les litiges droit du travail (employeur/employé) sont typiquement couverts, avec délai de carence 3 mois","correct":true},{"text":"Non, exclus systématiquement","correct":false,"why_wrong":"Les CGA PJ entreprise couvrent en général ce risque."},{"text":"Uniquement si l''entreprise emploie moins de 5 personnes","correct":false,"why_wrong":"Aucun seuil d''effectif fixé par la loi."},{"text":"Uniquement en cas de licenciement collectif","correct":false,"why_wrong":"Non limité aux licenciements collectifs."}]'::jsonb, 2,
       'PJ entreprise couvre litiges de l''employeur (droit du travail, bail commercial, contrats fournisseurs, encaissement) avec sous-limites et délai de carence 3 mois.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'non_vie' AND t.key = 'litiges_nv'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-NV-GAP-019', 'non_vie', t.id, 'multiple',
       NULL, 'Que prend en charge la PJ dans le cadre d''un litige couvert ?', '[{"text":"Honoraires d''avocat","correct":true},{"text":"Frais de justice et de procédure","correct":true},{"text":"Frais d''expertise judiciaire","correct":true},{"text":"Dépens alloués à la partie adverse en cas de perte","correct":true},{"text":"Amendes pénales prononcées contre l''assuré","correct":false,"why_wrong":"Les amendes sont exclues (art. 14 LCA + ordre public)."},{"text":"Peines pécuniaires ou dommages punitifs","correct":false,"why_wrong":"Exclusion d''ordre public : ces sanctions sont personnelles."}]'::jsonb, 2,
       'Prestations PJ (CGA marché) : avocat, frais de procédure, expertise, dépens adverses, cautions à concurrence de la somme assurée. Amendes et dommages punitifs exclus.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'non_vie' AND t.key = 'litiges_nv'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-NV-GAP-020', 'non_vie', t.id, 'single',
       NULL, 'Une PJ circulation couvre-t-elle un litige commercial entre l''assuré et son fournisseur de pièces auto ?', '[{"text":"Non : la PJ circulation vise l''usage du véhicule et les litiges LCR, pas les contrats commerciaux avec fournisseurs","correct":true},{"text":"Oui, tout ce qui touche au véhicule est couvert","correct":false,"why_wrong":"Interprétation trop large : la PJ circulation cible l''usage routier."},{"text":"Oui, uniquement si le fournisseur est étranger","correct":false,"why_wrong":"L''étranger ne modifie pas la matière du litige."},{"text":"Oui, dans la limite de 5 000 CHF","correct":false,"why_wrong":"Aucune sous-limite ne fait entrer un litige contractuel dans la PJ circulation."}]'::jsonb, 1,
       'PJ circulation (CGA marché) : recours après accident, permis, responsabilité pénale liée à la conduite, contrat de véhicule direct (achat, réparation). Litiges commerciaux type garantie fournisseur : plutôt PJ privée.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'non_vie' AND t.key = 'litiges_nv'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-NV-GAP-021', 'non_vie', t.id, 'single',
       NULL, 'Depuis la révision LCA 2022, après combien d''années le preneur peut-il résilier annuellement un contrat à durée pluriannuelle ?', '[{"text":"Après 3 ans, chaque année, avec préavis 3 mois (art. 35a LCA)","correct":true},{"text":"Uniquement à l''échéance initiale de 5 ans","correct":false,"why_wrong":"Ancien droit avant 2022 ; désormais résiliation annuelle après 3 ans."},{"text":"Après 10 ans","correct":false,"why_wrong":"Aucune durée de 10 ans dans la LCA révisée."},{"text":"À tout moment sans préavis","correct":false,"why_wrong":"Un préavis de 3 mois est requis."}]'::jsonb, 1,
       'Art. 35a LCA (révision 2022) : droit de résiliation ordinaire pour la fin de la 3e année, puis chaque année, avec préavis 3 mois. Impératif : ne peut être modifié au détriment du preneur.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'non_vie' AND t.key = 'conseil_nv'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-NV-GAP-022', 'non_vie', t.id, 'single',
       NULL, 'Après un sinistre indemnisé, dans quel délai les parties peuvent-elles résilier le contrat selon la LCA révisée ?', '[{"text":"14 jours à compter de la connaissance du versement (art. 42 LCA)","correct":true},{"text":"30 jours","correct":false,"why_wrong":"Ancien droit ; le délai est descendu à 14 jours en 2022."},{"text":"3 mois","correct":false,"why_wrong":"Confusion avec la résiliation ordinaire, pas la sinistre."},{"text":"Aucune résiliation possible après sinistre","correct":false,"why_wrong":"Faux : art. 42 LCA prévoit explicitement ce droit."}]'::jsonb, 1,
       'Art. 42 LCA (2022) : après un sinistre indemnisé, chacune des parties peut résilier dans un délai de 14 jours à compter du versement de l''indemnité. Effet fin en général 4 semaines après.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'non_vie' AND t.key = 'conseil_nv'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-NV-GAP-023', 'non_vie', t.id, 'multiple',
       NULL, 'Que doit communiquer l''assureur au preneur avant la conclusion du contrat selon l''art. 3a LCA (devoir d''information) ?', '[{"text":"Identité de l''assureur","correct":true},{"text":"Risques assurés et étendue de la couverture","correct":true},{"text":"Montant de la prime et autres frais","correct":true},{"text":"Durée et modalités de résiliation","correct":true},{"text":"Traitement des données personnelles","correct":true},{"text":"Le salaire du dirigeant de la compagnie","correct":false,"why_wrong":"Aucune obligation légale de le publier au client."},{"text":"La stratégie de placement du portefeuille interne","correct":false,"why_wrong":"Non exigé par l''art. 3 LCA."}]'::jsonb, 2,
       'Art. 3 LCA révisé : devoir d''information précontractuelle étendu (identité, risques, prime, durée, résiliation, données). Sanction (art. 3a) : droit de résiliation du preneur pendant 4 semaines si défaut d''information.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'non_vie' AND t.key = 'conseil_nv'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-NV-GAP-024', 'non_vie', t.id, 'single',
       'Un preneur a omis, au questionnaire de santé, de mentionner un traitement antihypertenseur qu''il suit depuis 3 ans.', 'Quel est le régime de la réticence selon l''art. 6 LCA révisé ?', '[{"text":"L''assureur peut résilier dans les 4 semaines dès qu''il a connaissance de la réticence ; ses prestations peuvent être réduites en lien de causalité avec le fait tu","correct":true},{"text":"Nullité automatique du contrat","correct":false,"why_wrong":"Ancien droit ; le régime actuel est la résiliation dans les 4 semaines."},{"text":"Aucune sanction : le questionnaire est purement indicatif","correct":false,"why_wrong":"Faux : le devoir de déclaration reste précis (art. 4 LCA)."},{"text":"Amende pénale immédiate","correct":false,"why_wrong":"Aucune amende pénale automatique en matière civile de LCA."}]'::jsonb, 2,
       'Art. 6 LCA révisé : réticence sanctionnée par résiliation possible dans 4 semaines dès connaissance ; refus ou réduction de prestation uniquement en cas de lien de causalité entre le fait tu et le sinistre.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'non_vie' AND t.key = 'conseil_nv'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-NV-GAP-025', 'non_vie', t.id, 'multiple',
       NULL, 'Que doit contenir obligatoirement la fiche d''information de l''intermédiaire d''assurance selon l''art. 45 LSA ?', '[{"text":"Nom et adresse de l''intermédiaire","correct":true},{"text":"Statut : intermédiaire lié ou non lié","correct":true},{"text":"Compagnies partenaires ou représentées","correct":true},{"text":"Nature et source de la rémunération","correct":true},{"text":"Modalités du traitement des données personnelles","correct":true},{"text":"Le nom des concurrents directs","correct":false,"why_wrong":"Aucune obligation légale."},{"text":"L''organigramme complet de la maison mère","correct":false}]'::jsonb, 2,
       'Art. 45 LSA : fiche d''information écrite remise au preneur avant conclusion. Preuve à conserver. Preuve d''ancrage LCD (transparence, art. 3 LCD).', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'non_vie' AND t.key = 'conseil_nv'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-NV-GAP-026', 'non_vie', t.id, 'single',
       NULL, 'En cas de vente à distance (téléphone, internet) d''un contrat d''assurance en Suisse, quel droit essentiel possède le preneur ?', '[{"text":"Droit de révocation de 14 jours dès conclusion ou remise des documents (art. 2a LCA)","correct":true},{"text":"Droit de révocation de 30 jours","correct":false,"why_wrong":"Ancien projet ; le délai adopté en 2022 est 14 jours."},{"text":"Aucun droit spécifique","correct":false,"why_wrong":"Contraire à la nouvelle LCA."},{"text":"Résiliation immédiate uniquement en visioconférence","correct":false}]'::jsonb, 2,
       'Art. 2a LCA (2022) : droit de révocation 14 jours pour tout contrat conclu (par écrit, à distance ou en présentiel), avec exceptions (contrat < 1 mois, prov.). Renforce la protection du consommateur.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'non_vie' AND t.key = 'conseil_nv'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-NV-GAP-027', 'non_vie', t.id, 'single',
       NULL, 'Le devoir de conseil / recommandation personnalisée de l''intermédiaire d''assurance découle de quelle base ?', '[{"text":"Art. 45 LSA (information et documentation) et art. 3 LCA (devoir d''info), avec responsabilité art. 68 LSA","correct":true},{"text":"Uniquement de la LSFin","correct":false,"why_wrong":"La LSFin n''est en principe pas applicable aux contrats d''assurance dommage (art. 3 let. b LSFin) ; la source est LSA/LCA."},{"text":"Aucune base légale : pratique purement commerciale","correct":false,"why_wrong":"Base légale claire dans LSA et LCA révisées."},{"text":"Art. 41 CO exclusivement","correct":false,"why_wrong":"L''art. 41 CO est une base résiduelle, pas la base spécifique du conseil assurance."}]'::jsonb, 2,
       'Devoir de conseil intermédiaire : art. 45 LSA (fiche + analyse), art. 3 LCA (info précontractuelle). Responsabilité de l''intermédiaire (art. 68 LSA) en cas de faute de conseil.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'non_vie' AND t.key = 'conseil_nv'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-NV-GAP-028', 'non_vie', t.id, 'multiple',
       NULL, 'Selon la nLPD (en vigueur 01.09.2023) appliquée à un intermédiaire non-vie, quels sont les principes clés à respecter ?', '[{"text":"Licéité et finalité","correct":true},{"text":"Proportionnalité et minimisation","correct":true},{"text":"Exactitude et sécurité","correct":true},{"text":"Information et transparence (annonce en cas de violation)","correct":true},{"text":"Interdiction totale de toute donnée sensible","correct":false,"why_wrong":"Les données sensibles peuvent être traitées avec consentement explicite ou base légale."},{"text":"Anonymisation obligatoire de tous les dossiers en 24 h","correct":false}]'::jsonb, 2,
       'Art. 6 ss nLPD : principes de licéité, finalité, proportionnalité, exactitude, sécurité, information. Art. 24 nLPD : notification des violations au PFPDT dans les meilleurs délais.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'non_vie' AND t.key = 'conseil_nv'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-NV-GAP-029', 'non_vie', t.id, 'single',
       'Un intermédiaire non lié conclut un contrat multirisques PME avec un client. Après signature, il reçoit d''une compagnie non retenue une commission plus élevée.', 'Comment doit-il gérer ce conflit d''intérêts selon LSA + règles marché ?', '[{"text":"Divulguer la structure de rémunération, refuser tout incitatif altérant l''objectivité du conseil et documenter la décision dans le dossier","correct":true},{"text":"Changer discrètement la recommandation vers la compagnie plus rémunératrice sans en informer le client","correct":false,"why_wrong":"Violation grave art. 45 LSA + LCD + devoir de fidélité mandataire."},{"text":"Ignorer le fait : ce n''est pas juridiquement pertinent","correct":false,"why_wrong":"Le conflit d''intérêts doit être géré et documenté (art. 45 LSA)."},{"text":"Facturer la différence au client","correct":false}]'::jsonb, 3,
       'Gestion des conflits d''intérêts (art. 45 LSA + LCD art. 3) : transparence rémunération, primauté de l''intérêt client, documentation. Sanction FINMA et civile (art. 398 CO mandat).', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'non_vie' AND t.key = 'conseil_nv'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-NV-GAP-030', 'non_vie', t.id, 'single',
       NULL, 'Quelles obligations subsistent pour l''intermédiaire une fois le contrat conclu (obligations post-contractuelles) ?', '[{"text":"Suivi du client, information sur les changements pertinents, conservation du dossier et disponibilité en cas de sinistre","correct":true},{"text":"Aucune : la mission cesse à la signature","correct":false,"why_wrong":"Violation du mandat (art. 394 ss CO) et du devoir continu de l''art. 3 LCA."},{"text":"Uniquement facturer le renouvellement annuel","correct":false,"why_wrong":"Insuffisant : le service post-conclusion est central."},{"text":"Envoyer un cadeau annuel au client","correct":false}]'::jsonb, 1,
       'Obligations post-contractuelles : suivi et actualisation (art. 3 LCA + mandat art. 394 CO), conservation dossier (nLPD + LSA 10 ans typiquement), assistance sinistre. Base de la fidélisation.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'non_vie' AND t.key = 'conseil_nv'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-NV-GAP-031', 'non_vie', t.id, 'single',
       NULL, 'Quelle sanction majeure sur un contrat existant si l''assureur a manqué à son devoir d''information précontractuelle (art. 3 LCA) ?', '[{"text":"Le preneur peut résilier le contrat dans un délai de 4 semaines dès qu''il a eu connaissance du manquement, avec effet ex tunc pour les primes non couvertes","correct":true},{"text":"Aucune sanction : le contrat est parfait","correct":false,"why_wrong":"Contraire à la LCA révisée qui protège le consommateur."},{"text":"Amende pénale automatique à l''assureur","correct":false,"why_wrong":"Aucune amende pénale directe en matière civile LCA."},{"text":"Nullité rétroactive absolue et remboursement de toutes les prestations reçues","correct":false,"why_wrong":"La sanction est la résiliation, pas la nullité absolue."}]'::jsonb, 2,
       'Art. 3a LCA : en cas de manquement au devoir d''information, le preneur peut résilier le contrat par déclaration écrite dans les 4 semaines dès connaissance, au plus tard 2 ans après conclusion.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'non_vie' AND t.key = 'conseil_nv'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-NV-GAP-032', 'non_vie', t.id, 'single',
       'Une assurée découvre une clause qu''elle juge insolite dans les CGA de son contrat non-vie, non explicitée par le conseiller.', 'Comment le juge apprécie-t-il la validité de cette clause ?', '[{"text":"Règle des clauses insolites : nulle si inhabituelle et non spécifiquement portée à l''attention du preneur (jurisprudence TF, art. 8 LCD)","correct":true},{"text":"Elle est toujours valable dès signature","correct":false,"why_wrong":"Faux : la jurisprudence exclut les clauses insolites non signalées."},{"text":"Elle doit être ratifiée par la FINMA","correct":false,"why_wrong":"La FINMA ne ratifie pas les clauses individuelles."},{"text":"Elle est traitée comme un usage local","correct":false}]'::jsonb, 2,
       'Doctrine et TF (règle des clauses insolites) : clause CGA inhabituelle et défavorable non spécifiquement signalée n''est pas opposable. Art. 8 LCD sanctionne également les clauses abusives.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'non_vie' AND t.key = 'conseil_nv'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-NV-GAP-033', 'non_vie', t.id, 'multiple',
       'Un intermédiaire prépare un rendez-vous non-vie complet avec un couple propriétaire d''une villa VD, 2 véhicules, 3 enfants, revenus 200 000 CHF.', 'Quels éléments doit-il documenter et remettre pour être conforme LCA/LSA révisées + nLPD ?', '[{"text":"Fiche d''information art. 45 LSA (statut, rémunération, données)","correct":true},{"text":"Analyse besoins couvrant ménage, RC privée, véhicules, bâtiment ECA + complément, PJ, voyages","correct":true},{"text":"Devoir d''info art. 3 LCA respecté (couverture, prime, durée, résiliation)","correct":true},{"text":"PV / dossier de conseil signé et conservé selon délais LSA","correct":true},{"text":"Consentement nLPD sur traitement et éventuel partage avec compagnies","correct":true},{"text":"Copie du permis de conduire des enfants mineurs de 8 et 10 ans","correct":false,"why_wrong":"Sans permis, sans finalité : violation minimisation nLPD."},{"text":"Photocopie de la carte bancaire complète","correct":false,"why_wrong":"Interdit par nLPD + risques fraude."}]'::jsonb, 3,
       'Entretien non-vie conforme : art. 45 LSA + art. 3 LCA + analyse documentée + PV + nLPD (données strictement nécessaires, finalité, sécurité). Best practice VBV.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'non_vie' AND t.key = 'conseil_nv'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-NV-GAP-034', 'non_vie', t.id, 'single',
       NULL, 'Selon l''art. 4 LCA, à qui incombe le devoir de déclarer précisément les faits importants pour l''appréciation du risque ?', '[{"text":"Au proposant (preneur), pour les faits que l''assureur lui demande par écrit et qui influencent son appréciation","correct":true},{"text":"À l''assureur seul, qui doit tout deviner","correct":false,"why_wrong":"Le proposant a le devoir de déclarer, à la question posée."},{"text":"À l''intermédiaire, en solidarité","correct":false,"why_wrong":"L''intermédiaire assiste, la déclaration reste celle du proposant."},{"text":"À personne : la LCA a supprimé toute déclaration","correct":false,"why_wrong":"Faux : art. 4 LCA maintient le devoir."}]'::jsonb, 1,
       'Art. 4 LCA : le proposant doit déclarer par écrit à l''assureur tous les faits importants pour l''appréciation du risque qui lui sont ou doivent lui être connus, selon les questions écrites de l''assureur.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'non_vie' AND t.key = 'conseil_nv'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-NV-GAP-035', 'non_vie', t.id, 'single',
       'Un assureur modifie unilatéralement ses CGA en cours de contrat, en augmentant les primes de 15 %.', 'Quel droit essentiel possède le preneur selon la LCA révisée ?', '[{"text":"Résilier le contrat dans les 30 jours suivant la communication de la modification (art. 35 LCA)","correct":true},{"text":"Aucun : la compagnie modifie librement le contrat","correct":false,"why_wrong":"Contraire à l''art. 35 LCA qui protège le preneur."},{"text":"Il doit accepter tacitement","correct":false,"why_wrong":"La modification tacite est encadrée : le preneur conserve un droit de résiliation."},{"text":"Il peut résilier sans délai, sans forme","correct":false,"why_wrong":"Un délai formel de 30 jours par écrit s''impose."}]'::jsonb, 3,
       'Art. 35 LCA : en cas d''adaptation contractuelle unilatérale (prime, CGA), le preneur peut résilier le contrat dans les 30 jours à compter de la communication, avec effet à la date d''entrée en vigueur de la modification.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'non_vie' AND t.key = 'conseil_nv'
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

-- ───────── vie_gaps.json — Compléments Klary VIE gaps 35 questions. Ciblage thèmes légers : hériter/léguer (10), activité indépendante (10), conduite de l'entretien vie (15). ─────────
INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-GAP-001', 'vie', t.id, 'single',
       NULL, 'Depuis la révision du droit successoral entrée en vigueur le 01.01.2023, à combien s''élève la réserve héréditaire des descendants ?', '[{"text":"1/2 de leur part légale","correct":true},{"text":"3/4 de leur part légale","correct":false,"why_wrong":"Ancienne réserve avant la révision 2023 : abaissée à 1/2 depuis."},{"text":"1/3 de leur part légale","correct":false,"why_wrong":"Aucune fraction de ce type dans le CC pour les descendants."},{"text":"La totalité de leur part légale","correct":false}]'::jsonb, 1,
       'Art. 471 CC (révisé 2023) : la réserve des descendants est de 1/2 de leur droit de succession (auparavant 3/4). La quotité disponible du de cujus s''agrandit d''autant.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'heriter_leguer'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-GAP-002', 'vie', t.id, 'single',
       'Marc décède en laissant son épouse et deux enfants. Sa succession nette est de 800 000 CHF. Aucun testament.', 'Quelle est la quotité disponible dont Marc aurait pu disposer par testament ?', '[{"text":"200 000 CHF","correct":false,"why_wrong":"Calcul faux : la réserve conjoint + descendants ne mange pas 3/4 depuis la révision 2023."},{"text":"500 000 CHF","correct":true},{"text":"400 000 CHF","correct":false,"why_wrong":"Correspondrait à l''ancien droit avant 2023."},{"text":"800 000 CHF","correct":false}]'::jsonb, 2,
       'Art. 471 CC (2023) : réserve conjoint = 1/2 de sa part légale (1/4 x 1/2 = 1/8 = 100 000). Réserve descendants = 1/2 x 3/4 = 3/8 = 300 000. Quotité disponible = 800 000 - 400 000 = 500 000 CHF (5/8).', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'heriter_leguer'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-GAP-003', 'vie', t.id, 'single',
       NULL, 'Sous quelle forme un pacte successoral doit-il obligatoirement être conclu pour être valable ?', '[{"text":"Acte authentique devant notaire, en présence de 2 témoins","correct":true},{"text":"Simple écrit signé par les parties","correct":false,"why_wrong":"L''écrit privé n''est admis que pour le testament olographe, jamais pour un pacte."},{"text":"Testament olographe daté et signé","correct":false,"why_wrong":"Un pacte est bilatéral : il ne peut prendre la forme d''un testament unilatéral."},{"text":"Convention notariée sans témoins","correct":false,"why_wrong":"Les 2 témoins restent exigés par la loi."}]'::jsonb, 2,
       'Art. 512 CC : le pacte successoral n''est valable qu''en la forme du testament public, soit acte authentique devant officier public (notaire) et 2 témoins.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'heriter_leguer'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-GAP-004', 'vie', t.id, 'multiple',
       NULL, 'Quelles conditions doit remplir un testament olographe pour être valable ?', '[{"text":"Rédigé entièrement à la main par le testateur","correct":true},{"text":"Daté (jour, mois, année) de la main du testateur","correct":true},{"text":"Signé de la main du testateur","correct":true},{"text":"Contresigné par 2 témoins","correct":false,"why_wrong":"Les témoins concernent le testament public, pas l''olographe."},{"text":"Enregistré auprès du registre foncier","correct":false,"why_wrong":"Aucun enregistrement obligatoire pour l''olographe."},{"text":"Rédigé à l''ordinateur puis signé","correct":false,"why_wrong":"L''écriture manuscrite intégrale est exigée, sinon nullité."}]'::jsonb, 2,
       'Art. 505 CC : testament olographe = écriture manuscrite intégrale, date complète et signature, tous 3 de la main du testateur. Défaut = nullité.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'heriter_leguer'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-GAP-005', 'vie', t.id, 'single',
       'Sophie a été lésée dans sa réserve par un legs excessif fait au concubin de sa mère décédée. Elle apprend la lésion 5 mois après l''ouverture de la succession.', 'Dans quel délai Sophie doit-elle intenter l''action en réduction pour ne pas être forclose ?', '[{"text":"1 an dès qu''elle a connaissance de la lésion, et 10 ans dès l''ouverture","correct":true},{"text":"3 mois dès l''ouverture de la succession, sans exception","correct":false,"why_wrong":"Aucun délai de 3 mois dans l''art. 533 CC pour l''action en réduction."},{"text":"5 ans à compter du décès dans tous les cas","correct":false,"why_wrong":"5 ans n''est pas prévu ; le délai relatif est de 1 an dès connaissance."},{"text":"Aucun délai : imprescriptible en présence de réservataires","correct":false,"why_wrong":"L''action se prescrit par 1 an relatif / 10 ans absolu."}]'::jsonb, 3,
       'Art. 533 al. 1 CC : action en réduction prescrite par 1 an dès la connaissance de la lésion et, dans tous les cas, par 10 ans dès l''ouverture du testament ou dès la mort pour les autres dispositions.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'heriter_leguer'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-GAP-006', 'vie', t.id, 'single',
       NULL, 'Quelle est la différence essentielle entre le rapport (art. 626 CC) et la réduction (art. 522 CC) ?', '[{"text":"Le rapport concerne les héritiers légaux entre eux ; la réduction protège la réserve d''un héritier lésé","correct":true},{"text":"Le rapport vise uniquement les biens immobiliers ; la réduction les biens mobiliers","correct":false,"why_wrong":"Aucune distinction selon la nature du bien."},{"text":"Le rapport se demande au juge, la réduction par acte notarié","correct":false,"why_wrong":"Confusion procédurale : les deux se règlent en principe par action civile."},{"text":"La réduction s''applique aux dons manuels, le rapport aux legs","correct":false,"why_wrong":"Inverse : les legs subissent la réduction, les libéralités entre vifs sont rapportables."}]'::jsonb, 2,
       'Art. 626 CC : rapport = obligation pour héritier légal de rapporter à la masse ce qu''il a reçu du vivant en avancement d''hoirie. Art. 522 CC : réduction = action pour restaurer la réserve d''un héritier lésé par un legs ou une libéralité excessive.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'heriter_leguer'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-GAP-007', 'vie', t.id, 'single',
       'Franz, ressortissant suisse et allemand, domicilié à Genève, souhaite rédiger un testament couvrant ses biens en Suisse et en Allemagne.', 'Quelle option juridique lui permet d''unifier le droit applicable à sa succession internationale ?', '[{"text":"Une professio juris : élire le droit de sa nationalité (allemand) au titre de l''art. 90 al. 2 LDIP","correct":true},{"text":"Un simple testament olographe suisse, valable partout","correct":false,"why_wrong":"L''olographe n''unifie pas le droit applicable ; les biens à l''étranger restent soumis au droit local sans professio."},{"text":"Un testament international selon la Convention de Washington 1973, obligatoirement","correct":false,"why_wrong":"La Convention règle la forme et son admission ; elle ne détermine pas le droit applicable au fond."},{"text":"Rien : la Suisse impose son droit à tous les Suisses domiciliés","correct":false}]'::jsonb, 3,
       'Art. 90 al. 2 LDIP : un étranger domicilié en Suisse peut soumettre sa succession au droit de l''un de ses États nationaux (professio juris). Franz, bi-national, peut ainsi désigner le droit allemand.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'heriter_leguer'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-GAP-008', 'vie', t.id, 'multiple',
       NULL, 'Une clause bénéficiaire en faveur d''un tiers dans un pilier 3a produit quels effets successoraux ?', '[{"text":"Le capital 3a passe hors succession directement au bénéficiaire","correct":true},{"text":"Le capital reste soumis à l''action en réduction si la réserve est lésée","correct":true},{"text":"L''ordre des bénéficiaires 3a est fixé par ordonnance OPP3 art. 2","correct":true},{"text":"Le bénéficiaire supporte l''impôt sur les prestations en capital indépendant","correct":true},{"text":"Le capital tombe automatiquement dans la masse successorale","correct":false,"why_wrong":"Contradiction : la prévoyance liée est hors succession en principe."},{"text":"Le tiers hérite sans aucune fiscalité","correct":false,"why_wrong":"Impôt cantonal sur prestations en capital applicable, taux séparé."}]'::jsonb, 2,
       'Art. 2 OPP3 : ordre légal 3a strict. Le capital sort hors succession civile mais reste attaquable en réduction si atteinte à la réserve (art. 522 CC). Fiscalité : impôt séparé sur prestation en capital (art. 38 LIFD).', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'heriter_leguer'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-GAP-009', 'vie', t.id, 'single',
       NULL, 'Un concubin non marié peut-il hériter légalement (ab intestat) en Suisse ?', '[{"text":"Non, il n''a aucun droit successoral légal ; il doit être institué par testament","correct":true},{"text":"Oui, après 5 ans de vie commune prouvée","correct":false,"why_wrong":"Aucune reconnaissance légale de la concubinat en droit successoral suisse."},{"text":"Oui, dans la limite de 1/4 de la succession","correct":false,"why_wrong":"Aucune fraction légale prévue pour un concubin."},{"text":"Oui, s''il partage un enfant avec le défunt","correct":false,"why_wrong":"L''enfant hérite en tant que descendant, pas le concubin."}]'::jsonb, 1,
       'CC (art. 457 ss) : le concubin n''est pas héritier légal. Pour lui laisser des biens : testament ou pacte successoral, dans les limites de la quotité disponible (art. 470 CC).', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'heriter_leguer'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-GAP-010', 'vie', t.id, 'single',
       'Pierre, veuf, laisse 3 enfants et une succession de 1 200 000 CHF. Il avait fait 10 ans avant son décès une donation de 300 000 CHF à sa fille aînée, sans dispense de rapport.', 'Comment se calcule la masse à partager et la part de chaque enfant ?', '[{"text":"Masse rapportée = 1 500 000 CHF, part de chacun 500 000, fille aînée reçoit 200 000 nets","correct":true},{"text":"Masse 1 200 000, part 400 000 chacun sans rapport","correct":false,"why_wrong":"Ignore l''obligation de rapport de la donation en avancement d''hoirie."},{"text":"Masse 1 500 000, part 500 000, mais fille aînée reçoit 0","correct":false,"why_wrong":"Le rapport est en valeur : elle conserve les 300 000, reçoit le complément 200 000."},{"text":"Masse 1 200 000, la fille aînée est exclue du partage","correct":false}]'::jsonb, 3,
       'Art. 626 CC : sans dispense de rapport expresse, la donation est rapportable. Masse = 1 200 000 + 300 000 = 1 500 000. Chaque enfant reçoit 500 000. La fille aînée déduit les 300 000 déjà perçus : elle touche 200 000 nets.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'heriter_leguer'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-GAP-011', 'vie', t.id, 'single',
       NULL, 'Un salarié qui devient indépendant sans être affilié à une caisse LPP peut cotiser au pilier 3a jusqu''à quel plafond en 2026 ?', '[{"text":"20 % du revenu AVS, max 36 288 CHF","correct":true},{"text":"7 258 CHF (petit 3a)","correct":false,"why_wrong":"C''est le plafond du salarié affilié LPP, pas de l''indépendant sans LPP."},{"text":"10 % du revenu, sans plafond","correct":false,"why_wrong":"Aucun taux de 10 % ni d''absence de plafond dans l''OPP3."},{"text":"50 % du revenu AVS","correct":false,"why_wrong":"Confusion avec le rachat LPP maximum, pas 3a."}]'::jsonb, 1,
       'Art. 7 al. 1 let. b OPP3 : indépendant sans 2e pilier peut cotiser jusqu''à 20 % du revenu d''activité lucrative, plafonné à 36 288 CHF en 2026 (grand 3a).', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'activite_independante'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-GAP-012', 'vie', t.id, 'multiple',
       NULL, 'Quels sont les avantages du grand pilier 3a (indépendant sans LPP) par rapport à une LPP facultative ?', '[{"text":"Plafond de déduction fiscale beaucoup plus élevé (36 288 vs 7 258 CHF)","correct":true},{"text":"Souplesse de contribution année par année","correct":true},{"text":"Rachats supplémentaires possibles en LPP fac. pour combler des lacunes","correct":false,"why_wrong":"C''est un avantage de la LPP fac., pas du 3a."},{"text":"Prestations d''invalidité et de décès à définir dans le contrat 3a","correct":true},{"text":"Couverture obligatoire pour risques décès/invalidité","correct":false,"why_wrong":"Aucune obligation légale : le 3a bancaire pur n''assure pas ces risques."}]'::jsonb, 2,
       'Art. 7 OPP3 : indépendant sans LPP a un plafond 3a très élevé. Souplesse annuelle et choix des risques dans version assurance. La LPP fac. offre en revanche les rachats de prévoyance (art. 79b LPP) et une couverture décès/invalidité systématique.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'activite_independante'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-GAP-013', 'vie', t.id, 'single',
       'Julie, salariée avec 90 000 CHF de salaire AVS, quitte son emploi pour devenir consultante indépendante.', 'Que doit-elle faire en priorité pour éviter une lacune de prévoyance ?', '[{"text":"S''affilier à une caisse LPP facultative ou verser sa prestation de libre passage sur un compte LPP, puis planifier 3a et risques","correct":true},{"text":"Retirer tout son avoir LPP en capital et le placer sur son compte bancaire privé","correct":false,"why_wrong":"Retrait anticipé LPP indépendant possible (art. 5 LFLP) mais sans planification, perte fiscale et couverture risques."},{"text":"Ne rien faire : l''AVS suffit à couvrir la retraite","correct":false,"why_wrong":"L''AVS seule (rente max 2 520 CHF) ne maintient jamais le niveau de vie."},{"text":"Souscrire uniquement une RC pro et une IJM","correct":false,"why_wrong":"Insuffisant : ne couvre pas la retraite ni l''invalidité longue durée."}]'::jsonb, 2,
       'Passage salarié à indépendant : art. 5 LFLP autorise retrait LP mais mieux vaut affiliation LPP fac. ou compte LP + grand 3a + IJM + RC pro. Analyse complète des besoins (art. 3 LCA, art. 45 LSA).', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'activite_independante'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-GAP-014', 'vie', t.id, 'single',
       'Un artisan indépendant de 58 ans souhaite transmettre son entreprise individuelle à son fils.', 'Quel dispositif fiscal fédéral peut-il utiliser pour reporter l''imposition des réserves latentes lors de la remise ?', '[{"text":"Le report d''imposition par transfert à un successeur poursuivant l''activité, sur demande, art. 18a LIFD","correct":true},{"text":"Une exonération pure et simple des réserves latentes en cas de succession familiale","correct":false,"why_wrong":"Aucune exonération totale : seul un report d''imposition est possible sous conditions."},{"text":"L''impôt anticipé fédéral remplace tout impôt sur le revenu","correct":false,"why_wrong":"L''IA n''est pas un substitut à l''IFD, il s''agit de deux impôts distincts."},{"text":"L''immunisation via un pilier 3a","correct":false,"why_wrong":"3a n''a aucun effet sur les réserves latentes d''une entreprise individuelle."}]'::jsonb, 3,
       'Art. 18a LIFD : report d''imposition des réserves latentes en cas de reprise par un membre de la famille poursuivant l''exploitation. À combiner avec art. 37b LIFD pour taux privilégié sur bénéfice de liquidation à la retraite.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'activite_independante'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-GAP-015', 'vie', t.id, 'single',
       NULL, 'Quelle assurance est indispensable pour un consultant IT indépendant afin de couvrir un défaut de conseil ayant causé une perte financière au client ?', '[{"text":"RC professionnelle avec extension pertes patrimoniales pures","correct":true},{"text":"RC privée seule (art. 41 CO)","correct":false,"why_wrong":"La RC privée exclut expressément l''activité pro lucrative indépendante."},{"text":"Assurance choses PME","correct":false,"why_wrong":"Couvre les biens matériels, pas la responsabilité pour dommage financier."},{"text":"Protection juridique circulation","correct":false,"why_wrong":"Ne concerne que les litiges de la circulation routière."}]'::jsonb, 2,
       'RC professionnelle avec avenant pertes patrimoniales pures (préjudice financier sans dommage corporel ni matériel préalable) : indispensable pour métiers de conseil (fiduciaire, IT, ingénieur). Base LCA + CGA marché.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'activite_independante'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-GAP-016', 'vie', t.id, 'multiple',
       NULL, 'Quels risques cyber concrets doit couvrir la police d''un indépendant traitant des données clients ?', '[{"text":"Frais de restauration des données après ransomware","correct":true},{"text":"Frais d''annonce nLPD au PFPDT et aux personnes concernées","correct":true},{"text":"Perte d''exploitation liée à l''indisponibilité IT","correct":true},{"text":"Responsabilité civile pour violation nLPD envers tiers","correct":true},{"text":"Vol physique du véhicule professionnel","correct":false,"why_wrong":"Cela relève de la casco véhicule, pas de la cyber."},{"text":"Franchise médicale AOS du dirigeant","correct":false}]'::jsonb, 2,
       'Police cyber PME/indépendant : restauration data, notification nLPD (art. 24 nLPD), interruption d''activité, RC data. Distincte des couvertures classiques choses et RC.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'activite_independante'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-GAP-017', 'vie', t.id, 'single',
       NULL, 'Un indépendant en incapacité de travail totale bénéficie-t-il d''office d''indemnités journalières maladie ?', '[{"text":"Non, il doit souscrire volontairement une IJM LCA ou LAMal facultative","correct":true},{"text":"Oui, la LAA le couvre automatiquement dès le 3e jour","correct":false,"why_wrong":"La LAA obligatoire ne concerne que les salariés."},{"text":"Oui, dès 30 jours, sans démarche","correct":false,"why_wrong":"Aucune IJM automatique pour indépendant."},{"text":"Oui, par l''APG","correct":false,"why_wrong":"L''APG couvre service militaire, maternité, paternité, proche aidant, pas la maladie ordinaire."}]'::jsonb, 1,
       'Indépendant : IJM non obligatoire. Options : IJM LCA privée ou IJM LAMal facultative (art. 67 ss LAMal). Sans souscription, aucune couverture perte de gain maladie.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'activite_independante'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-GAP-018', 'vie', t.id, 'single',
       'Sébastien, indépendant affilié à une caisse LPP fac., dispose d''une lacune de rachat de 120 000 CHF selon sa caisse.', 'Que doit-il vérifier avant d''effectuer un rachat déductible fiscalement ?', '[{"text":"Absence de retrait EPL/versement anticipé dans les 3 dernières années et respect de la période de blocage 3 ans avant retrait en capital","correct":true},{"text":"Rien : le rachat est toujours immédiatement retirable en capital","correct":false,"why_wrong":"Blocage 3 ans avant retrait en capital sous peine de reprise fiscale."},{"text":"L''accord obligatoire de l''AVS","correct":false,"why_wrong":"L''AVS n''a aucun rôle décisionnel dans le rachat LPP."},{"text":"Que sa fortune privée ne dépasse pas 500 000 CHF","correct":false}]'::jsonb, 2,
       'Art. 79b LPP + circulaire AFC 3/2024 : rachat déductible sous conditions. Blocage 3 ans avant retrait en capital sinon reprise imposition et annulation déduction. Précédents EPL doivent être remboursés avant rachat.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'activite_independante'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-GAP-019', 'vie', t.id, 'single',
       'Une indépendante décède subitement à 52 ans. Son mari (salarié) et 2 enfants restent. Elle ne cotisait qu''à l''AVS et 3a.', 'Quelles sont les prestations de prévoyance disponibles pour la famille survivante ?', '[{"text":"Rente veuve/enfants AVS + capital 3a selon ordre OPP3 art. 2 ; aucune rente LPP","correct":true},{"text":"Rente veuve LPP obligatoire à 60 % de la rente projetée","correct":false,"why_wrong":"Pas de LPP si non affiliée : aucune rente LPP versée."},{"text":"Capital LAA sur 12 fois le salaire mensuel","correct":false,"why_wrong":"LAA ne concerne pas les indépendants sauf couverture facultative art. 4 LAA (à souscrire)."},{"text":"Aucune prestation : indépendante sans droits","correct":false,"why_wrong":"L''AVS et le 3a produisent bien des prestations."}]'::jsonb, 3,
       'Décès indépendante non affiliée LPP : AVS survivants (art. 23 ss LAVS) + versement capital 3a selon ordre OPP3 (conjoint puis descendants). Lacune LPP = message clé du conseil aux indépendants.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'activite_independante'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-GAP-020', 'vie', t.id, 'single',
       NULL, 'Un indépendant part à la retraite et retire son avoir 3a en une année : à quel régime fiscal est soumise cette prestation en capital ?', '[{"text":"Impôt séparé sur les prestations en capital, taux réduit (1/5 du barème ordinaire) au niveau fédéral","correct":true},{"text":"Barème ordinaire IFD, cumulé avec le revenu de l''année","correct":false,"why_wrong":"Non : imposition séparée pour éviter la progressivité."},{"text":"Exonération totale d''impôt","correct":false,"why_wrong":"Aucune exonération : impôt réduit mais dû."},{"text":"Impôt anticipé de 35 % libératoire","correct":false,"why_wrong":"L''IA ne s''applique pas ainsi ; c''est un impôt à la source récupérable."}]'::jsonb, 2,
       'Art. 38 LIFD : prestations en capital de prévoyance imposées séparément à un taux correspondant à 1/5 du barème ordinaire. Étaler retraits (3a + LP) sur plusieurs années réduit la charge cantonale progressive.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'activite_independante'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-GAP-021', 'vie', t.id, 'single',
       NULL, 'Selon la LSFin, dans quelle classe de clients se trouve par défaut un particulier salarié sans expérience particulière ?', '[{"text":"Client privé","correct":true},{"text":"Client professionnel","correct":false,"why_wrong":"Le client pro est défini strictement (art. 4 al. 3 LSFin) : institut financier, entité publique, entreprise avec trésorerie pro."},{"text":"Client institutionnel","correct":false,"why_wrong":"Réservé aux banques, assurances, fonds selon art. 4 al. 4 LSFin."},{"text":"Client qualifié LPCC","correct":false,"why_wrong":"Notion LPCC, pas LSFin."}]'::jsonb, 1,
       'Art. 4 LSFin : segmentation en 3 classes (privé / professionnel / institutionnel). Un particulier lambda est client privé et bénéficie de la protection maximale.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'conseil_vie'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-GAP-022', 'vie', t.id, 'multiple',
       NULL, 'Quelles obligations le prestataire doit-il remplir vis-à-vis d''un client privé selon la LSFin ?', '[{"text":"Vérifier le caractère approprié (art. 11 LSFin) pour un simple conseil transactionnel","correct":true},{"text":"Vérifier l''adéquation (art. 12 LSFin) pour un conseil en placement portefeuille","correct":true},{"text":"Fournir la fiche d''information de base FIB pour instruments financiers concernés (art. 60 LSFin)","correct":true},{"text":"Documenter le conseil (art. 15 LSFin)","correct":true},{"text":"Aucune obligation de documentation pour un client privé","correct":false,"why_wrong":"L''art. 15 LSFin impose au contraire la documentation obligatoire."},{"text":"Utiliser exclusivement des produits maison","correct":false}]'::jsonb, 2,
       'Art. 7 à 15 LSFin : règles de comportement (info, adéquation/appropriation, documentation, transparence, diligence). Application intégrale pour client privé.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'conseil_vie'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-GAP-023', 'vie', t.id, 'single',
       'Un couple marié de 45 ans, 2 enfants (8 et 11 ans), revenus 180 000 CHF, souhaite planifier prévoyance et couverture décès.', 'Quelle étape de l''analyse des besoins est prioritaire pour ce couple ?', '[{"text":"Calculer les lacunes AVS/LPP en cas de décès du conjoint principal et projeter les besoins des enfants jusqu''à leur majorité/formation","correct":true},{"text":"Proposer immédiatement un fonds actions agressif","correct":false,"why_wrong":"Avant produit, il faut l''analyse : sinon violation art. 12 LSFin (adéquation)."},{"text":"Faire signer d''abord un mandat de gestion","correct":false,"why_wrong":"Le mandat vient après l''analyse et le PV de conseil."},{"text":"Vendre un pilier 3a bancaire à chacun sans analyse","correct":false,"why_wrong":"Défaut de conseil : sanction civile et FINMA possible."}]'::jsonb, 2,
       'Phase analyse (LSFin art. 7 + méthode 4 phases) : identifier situation familiale, revenus, patrimoine, objectifs, tolérance au risque, calculer lacunes avant toute solution.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'conseil_vie'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-GAP-024', 'vie', t.id, 'single',
       NULL, 'Que couvre exactement le devoir d''information de l''art. 8 LSFin ?', '[{"text":"Information sur le prestataire, ses services, coûts, conflits d''intérêts, offre de marché considérée","correct":true},{"text":"Seulement les frais annuels du produit vendu","correct":false,"why_wrong":"L''art. 8 est bien plus large que les seuls frais."},{"text":"Uniquement le nom du produit et son rendement passé","correct":false,"why_wrong":"Insuffisant : information sur la nature du service, risques, coûts, conflits est obligatoire."},{"text":"Rien : c''est l''art. 45 LSA qui régit tout","correct":false,"why_wrong":"L''art. 45 LSA vise l''intermédiation assurance, l''art. 8 LSFin la prestation de services financiers."}]'::jsonb, 2,
       'Art. 8 LSFin : le prestataire informe le client privé de son identité, statut, services, coûts, risques, éventuels conflits d''intérêts et de l''offre de marché prise en compte.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'conseil_vie'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-GAP-025', 'vie', t.id, 'single',
       'Sarah recommande à son client Marc, retraité prudent, un produit structuré à capital garanti mais avec longue durée et pénalité de sortie.', 'Quelle règle LSFin Sarah doit-elle impérativement respecter pour ne pas engager sa responsabilité ?', '[{"text":"Vérifier l''adéquation avec objectifs, situation financière, connaissances et tolérance au risque de Marc (art. 12 LSFin)","correct":true},{"text":"Uniquement vérifier l''appropriation de la transaction (art. 11 LSFin)","correct":false,"why_wrong":"Le conseil en placement porte sur un portefeuille : l''adéquation art. 12 est la règle."},{"text":"Aucune vérification : Marc a signé le contrat","correct":false,"why_wrong":"La signature ne dispense pas des règles LSFin d''ordre public."},{"text":"Se limiter à l''exécution simple sans conseil","correct":false,"why_wrong":"Ce serait requalifier le service, ce que l''analyse des faits ne permet pas."}]'::jsonb, 3,
       'Art. 12 LSFin : le conseil en placement portefeuille impose la vérification d''adéquation (suitability). Défaut = responsabilité civile et sanction FINMA.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'conseil_vie'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-GAP-026', 'vie', t.id, 'multiple',
       NULL, 'Quels éléments doivent figurer dans un procès-verbal de conseil (PV) selon la LSFin ?', '[{"text":"Besoins et objectifs du client","correct":true},{"text":"Raisons de la recommandation formulée","correct":true},{"text":"Situation financière et de risque du client","correct":true},{"text":"Produits présentés et retenus","correct":true},{"text":"Le salaire du conseiller","correct":false,"why_wrong":"Non requis dans le PV : ce sont les frais, coûts et rémunérations liés au service qui doivent être divulgués."},{"text":"L''adresse email personnelle de la famille du conseiller","correct":false}]'::jsonb, 2,
       'Art. 15 LSFin + FSN : le PV de conseil documente le processus (besoins, objectifs, situation, produits, motifs, alternatives). Preuve essentielle en cas de litige.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'conseil_vie'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-GAP-027', 'vie', t.id, 'single',
       NULL, 'Un client dépose une réclamation formelle. Quelle est l''obligation minimale du prestataire selon la LSFin ?', '[{"text":"Adhérer à un organe de médiation reconnu (ombudsman) et informer le client de cette possibilité (art. 74 ss LSFin)","correct":true},{"text":"Refuser de traiter la réclamation si elle n''est pas envoyée par pli recommandé","correct":false,"why_wrong":"Aucune exigence de forme opposable au client."},{"text":"Payer immédiatement l''indemnité demandée","correct":false,"why_wrong":"Le paiement n''est pas automatique : il dépend du bien-fondé."},{"text":"Résilier immédiatement la relation d''affaires","correct":false}]'::jsonb, 1,
       'Art. 74 à 78 LSFin : tout prestataire doit être affilié à un organe de médiation reconnu et informer le client de la procédure ombudsman en cas de désaccord persistant.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'conseil_vie'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-GAP-028', 'vie', t.id, 'single',
       NULL, 'Le secret professionnel de l''intermédiaire d''assurance peut-il être levé sur simple demande d''un tiers curieux ?', '[{"text":"Non, seuls le consentement écrit du client ou une base légale (autorité, juge) le permettent","correct":true},{"text":"Oui, si le tiers est un membre de la famille","correct":false,"why_wrong":"Aucun automatisme familial ; secret protégé strictement."},{"text":"Oui, si le tiers présente une carte professionnelle","correct":false,"why_wrong":"Une carte pro ne vaut pas base légale."},{"text":"Oui, dans tous les cas si le montant est faible","correct":false,"why_wrong":"Aucun seuil ne dispense du secret."}]'::jsonb, 2,
       'Art. 47 LB par analogie + art. 35 nLPD + art. 45 LSA : intermédiaires soumis à un devoir de discrétion. Levée sur consentement écrit ou décision d''autorité.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'conseil_vie'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-GAP-029', 'vie', t.id, 'single',
       'Un intermédiaire non lié conseille des solutions LPP surobligatoire. Il perçoit une commission de la compagnie retenue.', 'Quelle règle LSFin s''applique impérativement à ces rémunérations ?', '[{"text":"Communication transparente et, à défaut d''accord explicite, transfert de la rétrocession au client (art. 26 LSFin)","correct":true},{"text":"La commission est libre et n''a pas à être communiquée","correct":false,"why_wrong":"Violation art. 26 LSFin et jurisprudence TF sur les rétrocessions."},{"text":"Elle doit être remise obligatoirement à la FINMA","correct":false,"why_wrong":"Aucune obligation de remise à la FINMA."},{"text":"Elle est nulle et non avenue automatiquement","correct":false}]'::jsonb, 2,
       'Art. 26 LSFin : information sur les rémunérations reçues de tiers. Sans consentement éclairé du client, la commission doit lui revenir. Notion issue de la jurisprudence TF (rétrocessions).', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'conseil_vie'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-GAP-030', 'vie', t.id, 'single',
       NULL, 'Qui doit obligatoirement s''inscrire au registre des intermédiaires d''assurance tenu par la FINMA ?', '[{"text":"Les intermédiaires non liés (indépendants d''une compagnie) et, depuis 2024, également les intermédiaires liés","correct":true},{"text":"Uniquement les courtiers agréés en assurance-vie collective","correct":false,"why_wrong":"Restriction inexacte : la LSA vise tous les intermédiaires."},{"text":"Aucun : le registre est purement facultatif","correct":false,"why_wrong":"Registre obligatoire pour exercer légalement."},{"text":"Uniquement les personnes morales","correct":false,"why_wrong":"Personnes physiques exerçant l''intermédiation doivent aussi être inscrites."}]'::jsonb, 1,
       'Art. 40 à 44 LSA (révisée 2024) : registre FINMA obligatoire pour intermédiaires non liés ; formation continue et conditions personnelles également exigées.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'conseil_vie'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-GAP-031', 'vie', t.id, 'multiple',
       NULL, 'Que doit contenir la fiche d''information transmise au preneur d''assurance selon l''art. 45 LSA ?', '[{"text":"Identité et adresse de l''intermédiaire","correct":true},{"text":"Rapports contractuels avec les compagnies (lié / non lié)","correct":true},{"text":"Mode de rémunération de l''intermédiaire","correct":true},{"text":"Modalités du traitement des données personnelles","correct":true},{"text":"Le CV professionnel complet du conseiller","correct":false,"why_wrong":"Non exigé par art. 45 LSA."},{"text":"Le nom du chef de la FINMA en poste","correct":false}]'::jsonb, 2,
       'Art. 45 LSA : fiche d''information obligatoire avant conclusion, avec identité, statut, liens contractuels, rémunération, protection des données. Preuve à conserver.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'conseil_vie'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-GAP-032', 'vie', t.id, 'single',
       'Un client institutionnel (caisse de pension) demande des services d''investissement à une société de gestion.', 'Quelles règles LSFin s''appliquent à cette relation ?', '[{"text":"La plupart des règles de comportement art. 8 à 16 LSFin ne s''appliquent pas ; le client institutionnel peut y renoncer (art. 20 LSFin)","correct":true},{"text":"Toutes les règles LSFin s''appliquent intégralement, sans dérogation possible","correct":false,"why_wrong":"La LSFin gradue explicitement la protection selon le segment (art. 20 LSFin)."},{"text":"Seule la nLPD s''applique","correct":false,"why_wrong":"La LSFin s''applique toujours en principe, avec des allègements."},{"text":"Les règles LBA sont dispensées","correct":false,"why_wrong":"La LBA reste applicable à tout intermédiaire financier."}]'::jsonb, 3,
       'Art. 20 LSFin : le client institutionnel est réputé disposer de l''expertise ; les règles art. 8 à 16 sont applicables sur base opt-in ou renonciation. Protection graduée.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'conseil_vie'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-GAP-033', 'vie', t.id, 'single',
       NULL, 'En cas d''opting-up d''un client privé fortuné (élection en client professionnel), quelle est la conséquence principale ?', '[{"text":"Perte partielle de la protection LSFin : allègement documentation, adéquation, information","correct":true},{"text":"Aucun impact : la protection est identique dans les 3 classes","correct":false,"why_wrong":"Faux : la LSFin gradue la protection selon la classe."},{"text":"Il devient client institutionnel automatiquement","correct":false,"why_wrong":"L''opting-up mène à la classe professionnelle, pas institutionnelle."},{"text":"La FINMA doit valider individuellement chaque opting-up","correct":false,"why_wrong":"Aucune validation individuelle FINMA requise."}]'::jsonb, 2,
       'Art. 5 LSFin : opting-up des clients privés fortunés (patrimoine ≥ 500 000 CHF + connaissances) vers client professionnel. Consentement écrit. Allègement de la protection.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'conseil_vie'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-GAP-034', 'vie', t.id, 'single',
       NULL, 'Quelle obligation de formation continue s''impose aux intermédiaires d''assurance sous la LSA révisée ?', '[{"text":"Formation continue régulière obligatoire, dont le contenu et la durée sont fixés par les standards de la branche (BVK/AFA)","correct":true},{"text":"Aucune obligation : la seule formation initiale suffit à vie","correct":false,"why_wrong":"Contraire à l''art. 43 LSA révisé qui impose formation continue."},{"text":"Formation d''au moins 200 heures par an","correct":false,"why_wrong":"Aucun standard fixé à 200 heures ; les branches définissent le volume."},{"text":"Formation uniquement en cas de plainte client","correct":false,"why_wrong":"Aucun lien avec les plaintes ; obligation permanente."}]'::jsonb, 1,
       'Art. 43 LSA : obligation de formation initiale et continue pour intermédiaires. Standards fixés par organisations de branche (SAQ, BVK/AFA). Cybelia = pièce du dossier FINMA.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'conseil_vie'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-GAP-035', 'vie', t.id, 'multiple',
       'Une conseillère prépare un entretien vie avec un couple d''indépendants, revenus mixtes 250 000 CHF, 3 enfants, patrimoine 900 000 CHF.', 'Quels documents et éléments doit-elle préparer et remettre avant/pendant l''entretien pour respecter LSFin et LSA ?', '[{"text":"Fiche d''information art. 45 LSA (identité, statut, rémunération, données)","correct":true},{"text":"Segmentation LSFin du couple (privé par défaut, opting-up éventuel)","correct":true},{"text":"Questionnaire de besoins couvrant prévoyance, décès, invalidité, patrimoine, entreprise","correct":true},{"text":"FIB des produits envisagés (art. 60 LSFin) et rappel des rétrocessions (art. 26)","correct":true},{"text":"PV de conseil détaillé signé par les deux parties","correct":true},{"text":"Photocopie de la CNI de tous les proches non concernés","correct":false,"why_wrong":"Aucune base légale : violerait la nLPD (minimisation des données)."},{"text":"Extrait du casier judiciaire des enfants mineurs","correct":false,"why_wrong":"Aucune pertinence, atteinte à la nLPD."}]'::jsonb, 3,
       'Entretien conforme : fiche art. 45 LSA, segmentation LSFin, analyse besoins documentée (art. 7 LSFin), FIB (art. 60), rémunérations (art. 26), PV signé (art. 15). Respect nLPD (minimisation, finalité, sécurité).', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'conseil_vie'
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

-- ───────── vie_klary_prevoyance_privee.json — Banque Klary : prévoyance privée VIE 75 questions. Types d'assurance vie (risque pur/mixte/capitalisation/unit-linked), 3a vs 3b, banque vs assurance, protection famille (veuve/orphelin/capital décès), lien avec accident/maladie/décès. ─────────
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
       NULL, 'Comparaison pilier 3a vs pilier 3b : quelles affirmations sont exactes ?', '[{"text":"Le pilier 3b n''a AUCUN plafond fédéral de versement","correct":true},{"text":"Le pilier 3a est déductible du revenu imposable, dans la limite du plafond","correct":true},{"text":"Les versements 3b sont déductibles du revenu imposable comme le 3a","correct":false,"why_wrong":"Faux : les versements 3b ne sont PAS déductibles au niveau fédéral. Seules quelques déductions cantonales limitées existent (Genève, Vaud)."},{"text":"Le pilier 3a est bloqué jusqu''à 5 ans avant l''âge de référence AVS","correct":true},{"text":"Le pilier 3b est librement disponible en tout temps (rachat/résiliation)","correct":true}]'::jsonb, 3,
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
       NULL, 'Avantages et inconvénients d''une assurance-vie mixte : quelles affirmations sont exactes ?', '[{"text":"Avantage : cumul d''une protection décès et d''une épargne garantie à l''échéance","correct":true},{"text":"Avantage : discipline d''épargne (engagement pluriannuel)","correct":true},{"text":"Inconvénient : rendement souvent inférieur à un placement banque + assurance risque pur séparée","correct":true},{"text":"Inconvénient : peu de souplesse contractuelle (durée, primes)","correct":true},{"text":"Avantage : liquidité totale à tout moment sans coût","correct":false,"why_wrong":"Faux : le rachat anticipé entraîne une perte significative dans les premières années."}]'::jsonb, 3,
       'Mixte = solution combinée mais coûteuse. Comparaison à faire avec la stratégie ''buy term and invest the difference'' : temporaire décès + compte 3a titres, souvent plus performant sur longue durée.', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'garantie_revenus'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-PP-041', 'vie', t.id, 'multiple',
       NULL, 'Avantages et inconvénients d''une assurance-vie unit-linked : quelles affirmations sont exactes ?', '[{"text":"Avantage : potentiel de rendement supérieur à long terme","correct":true},{"text":"Avantage : choix des fonds selon le profil de risque du client","correct":true},{"text":"Inconvénient : risque de perte en capital, aucune garantie sauf option spécifique","correct":true},{"text":"Inconvénient : frais internes de fonds cumulés aux frais d''assurance","correct":true},{"text":"Avantage : capital garanti à l''échéance dans tous les cas","correct":false,"why_wrong":"Faux : la garantie est facultative et payante."}]'::jsonb, 3,
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
       NULL, 'Concernant la rente de veuve du 1er pilier (AVS), quelles conditions doivent être remplies ?', '[{"text":"La veuve a des enfants (à charge), sans condition d''âge ni de durée de mariage","correct":true},{"text":"La veuve sans enfant : mariage de 5 ans au moins ET veuve d''au moins 45 ans révolus","correct":true},{"text":"La rente de veuve est versée à vie ou jusqu''au remariage","correct":true},{"text":"Aucune condition, toute veuve a automatiquement droit à la rente","correct":false,"why_wrong":"Faux : conditions strictes d''âge et de mariage."},{"text":"La rente est de 100 % de la rente AVS du défunt","correct":false,"why_wrong":"Faux : 80 % de la rente de vieillesse du défunt."}]'::jsonb, 1,
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
       NULL, 'Un salarié décède, laissant conjoint + 2 enfants mineurs. Quelle rente LPP obligatoire par enfant orphelin ?', '[{"text":"20 % de la rente d''invalidité du défunt","correct":true},{"text":"40 % de la rente d''invalidité","correct":false,"why_wrong":"Confusion avec l''AVS (rente orphelin = 40 % rente vieillesse défunt)."},{"text":"10 %","correct":false},{"text":"60 %","correct":false,"why_wrong":"Confusion avec la rente de conjoint LPP."}]'::jsonb, 1,
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
       NULL, 'Concernant le choix entre rente et capital LPP à la retraite (art. 37 LPP), quelles affirmations sont exactes ?', '[{"text":"Le retrait sous forme de capital du régime obligatoire est un droit d''au moins 25 % du capital","correct":true},{"text":"Le règlement de caisse peut autoriser le retrait à 100 % en capital","correct":true},{"text":"Le retrait en capital doit être demandé dans un délai prévu par le règlement (souvent 3 ans avant la retraite)","correct":true},{"text":"Un salarié marié doit obtenir l''accord écrit de son conjoint pour un retrait en capital","correct":true},{"text":"Le capital est imposé comme un revenu ordinaire progressif","correct":false,"why_wrong":"Faux : imposition séparée à taux réduit (art. 38 LIFD)."}]'::jsonb, 3,
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
       NULL, 'Avantages et inconvénients de l''anticipation de la rente AVS :', '[{"text":"Avantage : rente plus tôt, utile en cas de fin d''activité forcée ou souhaitée","correct":true},{"text":"Avantage : plus d''années de perception si espérance de vie limitée","correct":true},{"text":"Inconvénient : rente réduite à vie","correct":true},{"text":"Inconvénient : cotisation AVS obligatoire jusqu''à l''âge de référence sur les revenus d''activité subsistants","correct":true},{"text":"Avantage : capital versé en plus","correct":false,"why_wrong":"Faux : l''AVS ne verse jamais un capital, uniquement une rente."}]'::jsonb, 1,
       'Anticiper = compromis. Utile si santé fragile, revenu suffisant sinon, cessation d''activité. Attention : la réduction est PERMANENTE, la rente ne remonte pas à l''âge de référence. Cotisation AVS due jusqu''à l''âge de référence (art. 4 LAVS).', 'klary_interne', TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'retraite'
ON CONFLICT (external_id) DO NOTHING;

INSERT INTO afa_questions
  (external_id, filiere_key, theme_id, question_type, context, question, options, points, explanation, source, active)
SELECT 'KLARY-VIE-PP-072', 'vie', t.id, 'multiple',
       NULL, 'Avantages et inconvénients de l''ajournement de la rente AVS :', '[{"text":"Avantage : rente majorée à vie (jusqu''à +31,5 %)","correct":true},{"text":"Avantage : diminue l''impôt sur le revenu pendant les années d''ajournement","correct":true},{"text":"Inconvénient : moins d''années de perception (risque de décès prématuré)","correct":true},{"text":"Inconvénient : nécessite d''autres ressources pendant l''ajournement","correct":true},{"text":"Avantage : rente rétroactivement doublée après l''ajournement","correct":false,"why_wrong":"Faux : la majoration est actuarielle, pas rétroactive."}]'::jsonb, 1,
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

-- 855 question(s) traitée(s).
