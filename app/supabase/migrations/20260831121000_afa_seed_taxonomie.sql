-- ═════════════════════════════════════════════════════════
-- Klary — Seed taxonomie AFA
-- Source : structure officielle relevée sur my.vbv-afa.ch
--          (NaviCompétence › Compétences opérationnelles)
--          + Profil de qualification VBV art. 190 OS v01 du 03.05.2024
--
-- Les 7 domaines de conseil suivent tous le même déroulé en 4 phases,
-- qui est aussi la structure de l'étude de cas dirigée à l'examen :
--   1 Introduction · 2 Analyse · 3 Solution · 4 Conclusion
-- ═════════════════════════════════════════════════════════

-- ───────── FILIÈRES ─────────
INSERT INTO afa_filieres (key, title, description, passing_pct, duration_min, sort_order) VALUES
  ('maladie_complementaire', 'Assurance maladie complémentaire',
   'Épreuve PV2. Étude de cas dirigée + QCM, 30 min chrono, aucun matériel autorisé.', 60, 30, 1),
  ('vie', 'Vie',
   'Épreuve PV4. Prévoyance, garantie des revenus, retraite, épargne, hériter/léguer.', 60, 30, 2),
  ('non_vie', 'Non-vie',
   'Épreuve PV3. Ménage, véhicule, voyages, propriété du logement, PME, litiges juridiques.', 60, 30, 3),
  ('toutes_branches', 'Toutes branches',
   'Profil complet couvrant vie et non-vie.', 60, 30, 4),
  ('generales', 'Compétences et connaissances générales',
   'Épreuve PV1. Socle commun à tous les profils : industrie, droit, obligations du conseiller.', 60, 30, 0)
ON CONFLICT (key) DO NOTHING;

-- ───────── THÈMES ─────────
-- Socle commun (PV1)
INSERT INTO afa_themes (filiere_key, key, title, description, sort_order) VALUES
  ('generales', 'industrie',      'Industrie de l''assurance',       'Marché, acteurs, formes juridiques, principes de l''assurance.', 1),
  ('generales', 'droit',          'Droit de l''assurance',           'CO, LCA, LSA, obligations du conseiller, LPD/nLPD, LBA, LCD.', 2),
  ('generales', 'acquisition',    'Acquisition et vente',            'Bases de la vente, acquisition de clients, prise de rendez-vous.', 3),
  ('generales', 'litiges',        'Litiges juridiques',              'Protection juridique, responsabilité civile, procédure.', 4)
ON CONFLICT (filiere_key, key) DO NOTHING;

-- Maladie complémentaire (PV2) — filière d'Anisa
INSERT INTO afa_themes (filiere_key, key, title, description, sort_order) VALUES
  ('maladie_complementaire', 'lamal_bases',    'LAMal — bases et affiliation',
   'Obligation d''assurance, délais, résiliation, changement de caisse.', 1),
  ('maladie_complementaire', 'lamal_couts',    'LAMal — participation aux coûts',
   'Franchises, quote-part et son plafond, modèles alternatifs, hospitalisation.', 2),
  ('maladie_complementaire', 'lamal_prestations', 'LAMal — prestations',
   'Catalogue AOS, maternité, étranger, médicaments, prévention.', 3),
  ('maladie_complementaire', 'lca_complementaires', 'LCA — assurances complémentaires',
   'Liberté contractuelle, réserves, réticence, principe indemnitaire, produits et chiffres.', 4),
  ('maladie_complementaire', 'ijm',            'Indemnités journalières maladie',
   'IJM LAMal (art. 67-77) vs IJM LCA, couverture employeur, CO 324a.', 5),
  ('maladie_complementaire', 'laa',            'LAA — assurance accidents',
   'Assujettissement, SUVA, LAA-C, IJ, IAI, rente complémentaire, survivants.', 6),
  ('maladie_complementaire', 'social_connexe', 'Assurances sociales connexes',
   'APG/LAPG, AVS/AI, LACI (chômeurs art. 22a), service militaire, caisse supplétive.', 7),
  ('maladie_complementaire', 'conseil',        'Conduite de l''entretien de conseil',
   'Les 4 phases : introduction, analyse, solution, conclusion. Art. 45 LSA, art. 3 LCA.', 8)
ON CONFLICT (filiere_key, key) DO NOTHING;

-- Vie (PV4)
INSERT INTO afa_themes (filiere_key, key, title, description, sort_order) VALUES
  ('vie', 'garantie_revenus',  'Garantie des revenus',      'Incapacité de gain, invalidité, décès, couverture du ménage.', 1),
  ('vie', 'retraite',          'Retraite',                  '1er/2e/3e pilier, départ à la retraite, rente vs capital.', 2),
  ('vie', 'epargne',           'Épargne',                   'Instruments d''épargne, fonds de placement, 3a/3b.', 3),
  ('vie', 'heriter_leguer',    'Hériter / léguer',          'Héritiers légaux, réserves héréditaires, testament, clause bénéficiaire.', 4),
  ('vie', 'activite_independante', 'Activité indépendante', 'Assurer les indépendants, lacunes de prévoyance.', 5),
  ('vie', 'conseil_vie',       'Conduite de l''entretien',  'Les 4 phases appliquées aux domaines vie.', 6)
ON CONFLICT (filiere_key, key) DO NOTHING;

-- Non-vie (PV3)
INSERT INTO afa_themes (filiere_key, key, title, description, sort_order) VALUES
  ('non_vie', 'menage',            'Ménage',                'RC privée, inventaire du ménage, valeur à neuf.', 1),
  ('non_vie', 'vehicule',          'Véhicule',              'RC véhicule, casco partielle/complète, bonus-malus.', 2),
  ('non_vie', 'voyages',           'Voyages',               'Annulation, assistance, rapatriement, frais de guérison à l''étranger.', 3),
  ('non_vie', 'propriete_logement','Propriété du logement', 'Bâtiment, ECA, transformation, RC propriétaire d''ouvrage.', 4),
  ('non_vie', 'pme',               'PME',                   'Choses, RC entreprise, technique, transport, perte d''exploitation.', 5),
  ('non_vie', 'litiges_nv',        'Litiges juridiques',    'Protection juridique circulation et privée.', 6),
  ('non_vie', 'conseil_nv',        'Conduite de l''entretien','Les 4 phases appliquées aux domaines non-vie.', 7)
ON CONFLICT (filiere_key, key) DO NOTHING;

-- ───────── NOTIONS — filière maladie complémentaire ─────────
-- Les notions marquées is_trap sont les pièges relevés sur les tentatives
-- passées : elles alimentent le mode de révision « pièges ».
INSERT INTO afa_notions (theme_id, key, label, legal_ref, is_trap, trap_note)
SELECT t.id, v.key, v.label, v.legal_ref, v.is_trap, v.trap_note
FROM (VALUES
  -- LAMal bases
  ('lamal_bases', 'aos_obligation',        'Obligation d''assurance AOS : toute personne domiciliée en Suisse, dans les 3 mois', 'art. 3 LAMal'::text, FALSE, NULL::text),
  ('lamal_bases', 'aos_bebe_3mois',        'Annonce du nouveau-né : 3 mois après la naissance (et non 30 jours)', 'art. 3 LAMal', TRUE, 'Confusion fréquente avec un délai de 30 jours.'),
  ('lamal_bases', 'aos_changement',        'Changement de caisse : 1er janvier (préavis 30.11) ou 1er juillet si hausse de prime (préavis 31.03)', 'art. 7 LAMal', TRUE, 'Le 1er juillet n''est ouvert QUE en cas de hausse de prime.'),
  ('lamal_bases', 'aos_arrieres',          'Pas de changement de caisse en cas d''arriérés ayant fait l''objet d''une sommation', 'art. 64a LAMal', FALSE, NULL),
  ('lamal_bases', 'aos_primes_vs_presta',  'Prestations AOS identiques par la loi, mais primes différentes selon la caisse', 'art. 24 LAMal', TRUE, 'Piège classique : on fait dire « primes identiques ». Ce sont les PRESTATIONS qui le sont.'),
  ('lamal_bases', 'service_militaire',     'Suspension de l''AOS pendant le service militaire de plus de 60 jours', 'art. 3 al. 4 LAMal', FALSE, NULL),

  -- LAMal coûts
  ('lamal_couts', 'franchise_adulte',      'Franchise adulte : minimum 300, maximum 2 500 CHF', 'art. 64 LAMal / OAMal', FALSE, NULL),
  ('lamal_couts', 'quotepart_plafond',     'Quote-part 10 %, plafonnée à 700 CHF/an adulte et 350 CHF/an enfant', 'art. 64 LAMal', TRUE, 'Le plafond est souvent oublié : une fois atteint, plus aucune quote-part.'),
  ('lamal_couts', 'quotepart_medicaments', 'Quote-part portée à 40 % sur les médicaments hors génériques', 'art. 38a OPAS', FALSE, NULL),
  ('lamal_couts', 'contribution_hospit',   'Contribution aux frais de séjour hospitalier : 15 CHF/jour', 'art. 104 OAMal', FALSE, NULL),
  ('lamal_couts', 'modeles_alternatifs',   'Modèles alternatifs (médecin de famille, HMO, télémédecine) : rabais de prime en échange d''une restriction d''accès', 'art. 41 al. 4 LAMal', FALSE, NULL),

  -- LAMal prestations
  ('lamal_prestations', 'maternite_exempte',   'Prestations de maternité exemptes de franchise et de quote-part', 'art. 64 al. 7 LAMal', TRUE, 'Aucune participation aux coûts sur les prestations de maternité légales.'),
  ('lamal_prestations', 'maternite_catalogue', 'Catalogue maternité AOS : contrôles, accouchement, conseils d''allaitement, cours de préparation jusqu''à 150 CHF', 'art. 29 LAMal', TRUE, 'Les conseils d''allaitement sont régulièrement oubliés. Il n''existe pas de « forfait allaitement 200 CHF ».'),
  ('lamal_prestations', 'apg_vs_lamal',        'Allocation de maternité = APG (80 %, 14 semaines, max 220 CHF/jour), pas LAMal', 'LAPG', TRUE, 'PIÈGE MAJEUR : la LAMal couvre les prestations médicales, l''APG verse le revenu.'),
  ('lamal_prestations', 'etranger_urgence',    'À l''étranger, la LAMal ne couvre que l''urgence, au maximum au double du tarif suisse', 'art. 36 OAMal', TRUE, 'Le rapatriement n''est JAMAIS couvert par la LAMal : c''est la LCA voyage.'),

  -- LCA complémentaires
  ('lca_complementaires', 'lca_liberte',       'Liberté contractuelle : l''assureur peut refuser une proposition sans indiquer de motif', 'LCA', FALSE, NULL),
  ('lca_complementaires', 'lca_reticence',     'Réticence : fausses déclarations dans le questionnaire de santé → résiliation possible', 'art. 6 LCA', FALSE, NULL),
  ('lca_complementaires', 'lca_revocation',    'Délai de révocation de la proposition : 14 jours', 'art. 2a LCA', TRUE, 'Souvent confondu avec 2 mois.'),
  ('lca_complementaires', 'lca_info_continue', 'Le devoir d''information ne prend pas fin à la signature', 'art. 3 LCA', TRUE, 'On fait dire à tort que le devoir cesse après signature.'),
  ('lca_complementaires', 'lca_indemnitaire',  'Principe indemnitaire : pas de double indemnisation pour un même sinistre', 'LCA', FALSE, NULL),
  ('lca_complementaires', 'lca_pas_subside',   'Pas de réduction de prime (subside) pour les complémentaires : seulement pour l''AOS', 'art. 65 LAMal', FALSE, NULL),
  ('lca_complementaires', 'lca_jamais_resilier','Ne jamais résilier l''ancienne complémentaire avant l''acceptation écrite de la nouvelle', NULL, TRUE, 'Erreur de conseil aux conséquences graves : trou de couverture.'),
  ('lca_complementaires', 'lca_chiffres',      'Ordres de grandeur des remboursements LCA : chirurgie oculaire, médecine alternative, dentaire, lunettes, cures, fitness', NULL, TRUE, 'Gap identifié comme cause probable des échecs : la théorie est maîtrisée, pas les chiffres commerciaux.'),

  -- IJM
  ('ijm', 'ijm_lamal',        'IJM LAMal : facultative, 720 jours sur 900, art. 67-77 LAMal', 'art. 67-77 LAMal', TRUE, 'À reconnaître même quand l''énoncé est formulé à l''envers.'),
  ('ijm', 'ijm_lca_employeur','IJM collective d''employeur : relève en pratique de la LCA, pas de la LAMal', 'LCA', TRUE, NULL),
  ('ijm', 'co_324a',          'CO 324a : obligation de l''employeur de verser le salaire, échelles bernoise/bâloise/zurichoise', 'art. 324a CO', FALSE, NULL),

  -- LAA
  ('laa', 'laa_assujettissement', 'Sont assurés LAA les salariés ; les indépendants peuvent s''assurer à titre facultatif', 'art. 1a, 4 LAA', TRUE, 'Les indépendants ne sont PAS soumis à la LAA obligatoire.'),
  ('laa', 'laa_8h',               'Accidents non professionnels couverts dès 8 heures de travail par semaine', 'art. 13 OLAA', FALSE, NULL),
  ('laa', 'laa_chomeurs',         'Chômeurs : assurés d''office auprès de la SUVA, indépendamment de tout contrat', 'art. 22a LACI', TRUE, 'PIÈGE PRIORITAIRE : erreur répétée. La couverture SUVA est automatique, sans condition d''heures ni de contrat.'),
  ('laa', 'laa_maladie_exclue',   'La LAA ne couvre pas la maladie ordinaire', 'art. 6 LAA', TRUE, 'Lire attentivement la CAUSE : une crise cardiaque à domicile est une maladie, les survivants relèvent de l''AVS/AI.'),
  ('laa', 'laa_iai',              'IAI : capital et non rente, maximum 148 200 CHF, indépendante de l''incapacité de gain', 'art. 24-25 LAA, annexe 3 OLAA', TRUE, 'Ce n''est ni une rente, ni une aide à la réintégration professionnelle.'),
  ('laa', 'laa_rente_compl',      'Rente complémentaire : 90 % du gain assuré, sous déduction de la rente AI', 'art. 20 al. 2 LAA', FALSE, NULL),
  ('laa', 'laa_survivants',       'Rente de veuve : enfants OU âge supérieur à 45 ans OU invalidité aux deux tiers ; sinon allocation en capital', 'art. 29 LAA', TRUE, 'L''allocation en capital pour veuve de moins de 45 ans sans enfants est régulièrement oubliée.'),
  ('laa', 'laa_concubinage',      'Concubinage : aucun droit à la rente de conjoint survivant en LAA', 'art. 29 LAA', FALSE, NULL),
  ('laa', 'laa_c',                'LAA-C : salaire excédentaire, division privée, renonciation à la réduction', NULL, FALSE, NULL),
  ('laa', 'laa_caisse_suppletive','Caisse supplétive : intervient en cas d''employeur défaillant, pas uniquement pour la SUVA', 'art. 73 LAA', FALSE, NULL),

  -- Conseil
  ('conseil', 'lsa_45',       'Art. 45 LSA : fiche d''information client à remettre au premier entretien', 'art. 45 LSA', FALSE, NULL),
  ('conseil', 'nlpd_sante',   'Interdiction absolue de transmettre des données de santé à des tiers à des fins publicitaires', 'nLPD', FALSE, NULL),
  ('conseil', 'phases_4',     'Les 4 phases de l''entretien : introduction, analyse, solution, conclusion', NULL, FALSE, NULL),
  ('conseil', 'hors_competence','Rester dans son périmètre : pas de conseil médical au client', NULL, TRUE, 'Une option « conseil médical » est toujours fausse.')
) AS v(theme_key, key, label, legal_ref, is_trap, trap_note)
JOIN afa_themes t ON t.key = v.theme_key AND t.filiere_key = 'maladie_complementaire'
ON CONFLICT (key) DO NOTHING;
