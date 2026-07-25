-- ═════════════════════════════════════════════════════════
-- Klary — Seed Module LPP (Libre Passage)
--   • Cadre légal LPP + LFLP + OLP
--   • Reconstitution comptes multiples
--   • Retrait EPL (encouragement à la propriété)
--   • Fiscalité au retrait, achats rétroactifs
--   • Cas études clients réalistes
--   • Règlement Klary spécifique LPP (fonds retraite = obligations
--     renforcées de conseil + confidentialité + non-sollicitation)
-- Cooldown : 24h après échec.
-- ═════════════════════════════════════════════════════════

-- Cooldown module LPP identique à Maladie
UPDATE training_modules SET retry_cooldown_hours = 24 WHERE key = 'lpp';

INSERT INTO training_questions
  (module_key, external_id, category, question_type, question, options, correct, explanation, why_wrong, consequence, active) VALUES

-- ───────── LPP — BASES LÉGALES ─────────

('lpp','L001','LPP — Cadre légal','single',
$QK$Selon la LPP, quel salarié est assuré obligatoirement à la prévoyance professionnelle (2ᵉ pilier) ?$QK$,
$QK$["Tout salarié dès le 1er franc de salaire annuel", "Tout salarié soumis à l'AVS dont le salaire annuel dépasse le seuil d'entrée (≈ 22 680 CHF en 2026)", "Uniquement les cadres avec plus de 5 ans d'ancienneté", "Uniquement les employés à temps plein"]$QK$::jsonb,
1,
$QK$Art. 2 LPP : sont assurés obligatoirement les salariés soumis à l'AVS dont le salaire annuel dépasse le seuil d'entrée (montant ajusté périodiquement, ≈ 22 680 CHF en 2026 = 3/4 de la rente AVS max). En dessous du seuil, affiliation facultative uniquement.$QK$,
$QK$["FAUX — un seuil d'entrée existe (art. 2 al. 1 LPP).", null, "L'ancienneté et le statut cadre ne sont pas des critères d'affiliation LPP obligatoire.", "Le temps de travail n'est pas le critère — c'est le salaire annuel soumis AVS."]$QK$::jsonb,
$QK$Erreur = conseiller un employé à temps partiel qu'il n'est pas assuré alors qu'il dépasse le seuil (ou l'inverse). Client mal orienté = perte de droits ou double affiliation inutile.$QK$,
TRUE),

('lpp','L002','LPP — Cadre légal','single',
$QK$Que couvre le 2ᵉ pilier obligatoire (LPP) ?$QK$,
$QK$["Uniquement la vieillesse", "Uniquement l'invalidité", "Vieillesse, invalidité et décès (survivants)", "Uniquement l'accident professionnel"]$QK$::jsonb,
2,
$QK$Le 2ᵉ pilier couvre les 3 risques prévoyance : vieillesse (rente ou capital retraite), invalidité (rente d'invalidité), décès (rente de survivants pour conjoint/partenaire enregistré + enfants). L'accident est couvert par la LAA (assurance accidents obligatoire), distincte.$QK$,
$QK$["FAUX — pas seulement vieillesse.", "FAUX — invalidité n'est qu'un des 3 volets.", null, "FAUX — l'accident professionnel relève de la LAA, pas de la LPP."]$QK$::jsonb,
$QK$Erreur = client qui pense être uniquement couvert vieillesse par sa LPP → il souscrit une LCA prévoyance décès superflue, ou l'inverse : il croit être couvert décès et il ne l'est pas assez. Défaut de conseil sur périmètre.$QK$,
TRUE),

('lpp','L003','LPP — Libre passage','single',
$QK$Un salarié quitte son employeur. Sans nouvel emploi immédiat, que devient son avoir de vieillesse LPP ?$QK$,
$QK$["Il est versé cash automatiquement", "Il est transféré sur une police de libre passage OU un compte de libre passage — au choix de l'assuré", "Il reste bloqué chez l'ancien employeur", "Il est reversé à la caisse AVS"]$QK$::jsonb,
1,
$QK$Art. 4 LFLP : au départ, l'institution de prévoyance transfère l'avoir vers une INSTITUTION DE LIBRE PASSAGE (police auprès d'une assurance OU compte bancaire) désignée par l'assuré. Si l'assuré ne désigne rien dans les 6 mois, transfert d'office à la Fondation Institution supplétive.$QK$,
$QK$["FAUX — retrait cash uniquement dans des cas très encadrés (départ définitif Suisse hors UE, indépendance, achat logement principal, invalidité, faible avoir).", null, "FAUX — l'employeur ne peut plus conserver l'avoir après la sortie.", "FAUX — LPP et AVS sont deux systèmes distincts (2ᵉ vs 1ᵉʳ pilier)."]$QK$::jsonb,
$QK$Erreur = agent qui dit "vous récupérez votre LPP cash à votre départ" = fausse information légale. Client peut faire des projets financiers sur cette base et découvrir plus tard que les fonds sont bloqués jusqu'à 60/65 ans. Poursuite civile probable.$QK$,
TRUE),

('lpp','L004','LPP — Libre passage','single',
$QK$Un client a 5 emplois successifs sur 15 ans. Combien d'avoirs de libre passage possibles au maximum ?$QK$,
$QK$["Un seul, tout est automatiquement regroupé", "Autant que d'employeurs successifs sans nouveau contrat immédiat + comptes ouverts sans instruction = potentiellement 5 ou plus", "Deux maximum par la loi", "Aucun s'il retrouve un emploi rapidement"]$QK$::jsonb,
1,
$QK$Chaque sortie d'emploi sans transfert direct vers une nouvelle caisse LPP crée POTENTIELLEMENT un compte/police de libre passage distinct. Beaucoup de clients ont 2-5 avoirs éparpillés sans le savoir. La reconstitution (recherche via Fonds de garantie LPP) est une des missions clés du courtier prévoyance.$QK$,
$QK$["FAUX — aucun regroupement automatique. C'est à l'assuré/courtier de le faire.", null, "FAUX — aucune limite légale au nombre de comptes.", "FAUX — retrouver un emploi ne fait pas fusionner l'ancien avoir dans la nouvelle caisse (sauf demande explicite de transfert)."]$QK$::jsonb,
$QK$Erreur = ne pas systématiquement questionner le client sur ses emplois passés + ne pas déclencher la RECONSTITUTION via Fonds de garantie LPP. Le client peut avoir 40-80k CHF oubliés dans d'anciens comptes. C'est LE service à valeur ajoutée n°1 du courtier prévoyance.$QK$,
TRUE),

('lpp','L005','LPP — Reconstitution','single',
$QK$Où interroger officiellement pour retrouver les avoirs de libre passage oubliés d'un client ?$QK$,
$QK$["Auprès de son ancien employeur uniquement", "Auprès du Fonds de garantie LPP (via formulaire officiel avec procuration signée du client)", "Auprès de l'AVS", "Auprès de l'administration fiscale cantonale"]$QK$::jsonb,
1,
$QK$Le Fonds de garantie LPP (Sicherheitsfonds BVG) tient un registre central des avoirs de libre passage sans contact. Le courtier envoie un formulaire officiel avec procuration signée du client → le Fonds interroge les institutions et remonte les comptes trouvés (numéro, montant, gestionnaire). Service gratuit.$QK$,
$QK$["FAUX — l'ancien employeur n'a plus de trace après quelques années.", null, "FAUX — l'AVS gère le 1er pilier, pas le 2e.", "FAUX — l'administration fiscale n'a pas ces informations."]$QK$::jsonb,
$QK$Erreur = courtier qui n'interroge pas le Fonds de garantie = laisse potentiellement des dizaines de milliers de CHF perdus pour le client. C'est un manquement au devoir de conseil sur un point où la valeur ajoutée est massive.$QK$,
TRUE),

('lpp','L006','LPP — Reconstitution','single',
$QK$Après reconstitution, le courtier trouve 4 comptes/polices de libre passage pour un client. Que recommander en priorité ?$QK$,
$QK$["Laisser en l'état, éviter les frais", "Étudier une consolidation sur 2 institutions maximum (règle du split), pour optimiser rendement + fiscalité au retrait", "Tout retirer immédiatement en cash", "Fusionner sur un seul compte pour simplifier"]$QK$::jsonb,
1,
$QK$Bonne pratique en libre passage : fractionner l'avoir sur MAX 2 institutions différentes. Raison : au retrait (retraite ou EPL), chaque institution peut être retirée sur une année fiscale distincte → l'imposition séparée de la prestation en capital devient PROGRESSIVE mais SPLITTÉE, donc taux effectif plus bas grâce au barème dégressif. Consolider sur 1 seul compte = pic fiscal élevé.$QK$,
$QK$["FAUX — ne pas agir = laisser potentiellement des frais élevés + pas d'optimisation fiscale au retrait.", null, "FAUX — retrait cash pré-retraite impossible sauf cas spéciaux (art. 5 LFLP).", "FAUX — 1 seul compte = concentration fiscale au retrait, moins optimal. Voir règle du split fiscal."]$QK$::jsonb,
$QK$Erreur = tout consolider sur 1 compte "pour faire propre" → au retrait, le client paie plusieurs milliers de CHF de plus d'impôt à cause du barème progressif. Perte sèche pour le client, imputable au courtier.$QK$,
TRUE),

-- ───────── LPP — RETRAIT EPL ─────────

('lpp','L007','LPP — Retrait EPL','single',
$QK$Un client de 40 ans veut acheter sa résidence principale. Peut-il utiliser son avoir LPP en apport ?$QK$,
$QK$["Non, l'avoir LPP est intouchable jusqu'à 60 ans", "Oui, dispositif EPL (encouragement à la propriété du logement) : retrait anticipé possible pour la résidence principale (art. 30a-30g LPP)", "Oui, sans aucune restriction ni limite", "Uniquement s'il a plus de 55 ans"]$QK$::jsonb,
1,
$QK$Dispositif EPL (art. 30c LPP) : retrait anticipé du 2e pilier possible pour l'acquisition ou construction de sa RÉSIDENCE PRINCIPALE (pas résidence secondaire ni bien locatif), remboursement d'hypothèque sur logement principal, ou financement de parts sociales dans une coopérative d'habitation. Dernière demande possible 3 ans avant l'âge de retraite ordinaire.$QK$,
$QK$["FAUX — l'EPL est un dispositif majeur, à connaître par cœur.", null, "FAUX — EPL strictement encadré : usage résidence principale uniquement, montant plafonné jusqu'à 50 ans (100% de l'avoir), au-dessus limité à l'avoir à 50 ans.", "FAUX — accessible dès n'importe quel âge, avec plafonds."]$QK$::jsonb,
$QK$Erreur = client mal informé se rue vers un crédit hypothécaire cher alors qu'il pouvait mobiliser 200k CHF de LPP → perte estimée en intérêts sur 25 ans à des dizaines de milliers de CHF. Défaut de conseil très pénalisant.$QK$,
TRUE),

('lpp','L008','LPP — Retrait EPL','single',
$QK$Client 55 ans, avoir LPP 400k CHF, veut retirer TOUT en EPL pour rembourser son hypothèque. Est-ce autorisé ?$QK$,
$QK$["Oui, sans restriction", "Partiellement : à partir de 50 ans, le retrait EPL est limité au maximum entre l'avoir actuel des cotisations libres OU l'avoir qu'il possédait à 50 ans (règle de plafonnement 50 ans)", "Non, le retrait EPL est interdit après 50 ans", "Uniquement 100 000 CHF max"]$QK$::jsonb,
1,
$QK$Art. 30c al. 2 LPP + OEPL : dès 50 ans, le retrait EPL est plafonné au max entre (a) l'avoir qu'il possédait à 50 ans et (b) la moitié de son avoir actuel. But de la règle : préserver un solde retraite minimum. Point critique à connaître pour ne pas promettre au client un retrait qu'il ne peut pas obtenir.$QK$,
$QK$["FAUX — plafonnement légal existe dès 50 ans.", null, "FAUX — le retrait est possible mais plafonné, pas interdit.", "FAUX — pas de plafond fixe 100 000 CHF, c'est un calcul individuel."]$QK$::jsonb,
$QK$Erreur = promettre 400k au client, ne pas vérifier la règle 50 ans, il découvre à la demande de retrait qu'il ne peut sortir que 250k → son projet immobilier s'effondre en dernière minute. Plainte massive.$QK$,
TRUE),

('lpp','L009','LPP — Retrait EPL','single',
$QK$Le retrait EPL d'un avoir LPP est-il imposé fiscalement ?$QK$,
$QK$["Non, jamais", "Oui — imposition séparée du revenu ordinaire, au taux réduit de la prestation en capital de prévoyance", "Oui, au taux du revenu ordinaire", "Uniquement si supérieur à 100 000 CHF"]$QK$::jsonb,
1,
$QK$Le retrait EPL LPP subit une imposition SÉPARÉE du revenu ordinaire, à un taux réduit spécifique aux prestations en capital de prévoyance (barème dégressif progressif selon canton). Impôt fédéral + cantonal + communal. Le taux varie selon montant + canton — de 4% (petit montant Zoug) à 15% (gros montant Genève).$QK$,
$QK$["FAUX — imposition existe, souvent 5-15%.", null, "FAUX — pas imposé au taux ordinaire, sinon la charge serait énorme.", "FAUX — pas de seuil d'exonération 100k, l'impôt commence dès le 1er CHF."]$QK$::jsonb,
$QK$Erreur = ne pas mentionner l'impôt au retrait → client budgète 400k EPL, il reçoit 340k après impôt cantonal, plainte "on ne m'avait rien dit". Simulation fiscale AVANT signature est un devoir de conseil.$QK$,
TRUE),

('lpp','L010','LPP — Retrait EPL','single',
$QK$Le montant retiré en EPL revient-il obligatoirement dans la caisse LPP si le bien est vendu plus tard ?$QK$,
$QK$["Non, jamais", "Oui — obligation de remboursement en cas de vente du logement principal, art. 30d LPP", "Uniquement si le vendeur a moins de 40 ans", "Uniquement si vente en moins de 5 ans après retrait"]$QK$::jsonb,
1,
$QK$Art. 30d LPP : en cas de vente du logement principal, le montant retiré doit être remboursé à la caisse LPP (ou à un compte libre passage) — dans les 6 mois. Exception : si vendeur > 3 ans avant retraite. Restriction inscrite au registre foncier (mention EPL). Point souvent oublié qui peut créer des mauvaises surprises fiscales/juridiques.$QK$,
$QK$["FAUX — obligation légale de remboursement en cas de revente.", null, "FAUX — pas de critère d'âge, sauf approche retraite.", "FAUX — pas de délai forfaitaire, obligation tant que sous l'âge retraite."]$QK$::jsonb,
$QK$Erreur = client vend son logement 10 ans après retrait EPL, ne rembourse pas, se fait rappeler à l'ordre par la caisse LPP + fisc (car récupération éventuelle de l'avantage fiscal du retrait). Devoir d'information proactif.$QK$,
TRUE),

-- ───────── LPP — RETRAIT EN CAPITAL / RENTE ─────────

('lpp','L011','LPP — Retraite','single',
$QK$À la retraite, un assuré peut choisir entre rente et capital sur son avoir LPP. Quelle est la règle du minimum obligatoire en RENTE ?$QK$,
$QK$["Aucun minimum : 100 % en capital si voulu", "Au minimum 25 % de l'avoir de vieillesse OBLIGATOIRE doit être versé en rente (art. 37 LPP) — le règlement de la caisse peut être plus favorable et permettre 100 % capital", "50 % obligatoire en rente", "100 % en rente obligatoire"]$QK$::jsonb,
1,
$QK$Art. 37 LPP : l'assuré peut exiger que 25 % de l'avoir vieillesse OBLIGATOIRE (partie légale minimum) soit versé en capital. Inversement, l'assuré peut demander jusqu'à 100 % en capital SI le règlement de la caisse le permet (la plupart des caisses le permettent). Sur la PARTIE surobligatoire, plus de flexibilité selon règlement.$QK$,
$QK$["FAUX — l'ancienne règle imposait rente par défaut. La flexibilité est encadrée par le règlement.", null, "FAUX — pas de seuil 50%.", "FAUX — pas 100% obligatoire, c'est une option de la caisse."]$QK$::jsonb,
$QK$Erreur = agent qui affirme "vous prenez tout en capital" sans vérifier le règlement caisse. Client qui prépare un projet retraite sur 800k cash découvre à l'ouverture des droits qu'il ne peut sortir que 600k. Plainte.$QK$,
TRUE),

('lpp','L012','LPP — Retraite','single',
$QK$Rente vs capital à la retraite : quel argument doit peser LE PLUS dans le conseil du courtier ?$QK$,
$QK$["Le rendement personnel du courtier sur la commission", "L'analyse individualisée : espérance de vie, autres revenus retraite (AVS+3e pilier), état civil (survivants), fiscalité canton, gestion patrimoine post-retrait", "Toujours capital, c'est plus flexible", "Toujours rente, c'est plus sûr"]$QK$::jsonb,
1,
$QK$Devoir de conseil renforcé sur le choix rente/capital : c'est une décision IRREVOCABLE avec impact 20-30 ans. Analyse à faire : espérance de vie estimée, situation matrimoniale (rente survivant si conjoint), autres revenus assurés, gestion post-retrait (capacité à investir soi-même), fiscalité canton de résidence retraite. Le tableau comparatif chiffré doit être remis au client par écrit.$QK$,
$QK$["Faute déontologique grave — la commission ne doit pas influencer le conseil.", null, "Simpliste et faux — la flexibilité capital cache un risque de mauvaise gestion.", "Simpliste et faux — la rente est sûre mais perd contre inflation et disparaît au décès pour le solde non versé."]$QK$::jsonb,
$QK$Erreur = conseil standardisé "toujours capital / toujours rente" → client mal servi. Le vrai savoir-faire du courtier retraite est de sortir un TABLEAU CHIFFRÉ personnalisé avec les 2 scénarios sur 20 ans. Différence pouvant atteindre 100-200k CHF selon le choix.$QK$,
TRUE),

-- ───────── LPP — FISCALITÉ ─────────

('lpp','L013','LPP — Fiscalité rachats','single',
$QK$Le rachat volontaire dans sa caisse LPP (rachat rétroactif) permet-il de réduire l'impôt sur le revenu de l'année du rachat ?$QK$,
$QK$["Non, aucun effet fiscal", "Oui — le montant du rachat est intégralement déductible du revenu imposable de l'année, économie fiscale marginale = son taux marginal", "Uniquement 50 % déductible", "Uniquement au niveau fédéral"]$QK$::jsonb,
1,
$QK$Le rachat rétroactif est intégralement déductible du revenu imposable de l'année (fédéral + cantonal + communal). Économie fiscale = taux marginal du contribuable, souvent 25-40 %. Rachat de 20 000 CHF pour un contribuable à 35 % de marginal = 7 000 CHF d'économie immédiate + capitalisation LPP.$QK$,
$QK$["FAUX — c'est l'un des mécanismes fiscaux les plus puissants en Suisse.", null, "FAUX — 100 % déductible, pas 50 %.", "FAUX — déductible fédéral + cantonal + communal."]$QK$::jsonb,
$QK$Erreur = ne pas proposer les rachats à un client aisé avec potentiel de rachat non utilisé = laisser des milliers de CHF sur la table chaque année. Client compare avec un ami mieux conseillé = plainte défaut de conseil.$QK$,
TRUE),

('lpp','L014','LPP — Fiscalité rachats','single',
$QK$Un client effectue un rachat LPP de 40 000 CHF le 15 mars, et prévoit de partir à la retraite le 30 septembre de la MÊME année pour retirer son capital. Est-ce fiscalement optimal ?$QK$,
$QK$["Oui, doublement gagnant : déduction + capital", "Non — art. 79b al. 3 LPP : période de blocage de 3 ans entre le rachat et le retrait en capital, sinon la déduction fiscale est ANNULÉE rétroactivement", "Oui mais uniquement à 50 % de la déduction", "Non, le rachat est simplement remboursé"]$QK$::jsonb,
1,
$QK$Art. 79b al. 3 LPP : blocage de 3 ans. Si retrait en capital dans les 3 ans suivant un rachat, l'administration fiscale ANNULE rétroactivement la déduction et rétablit le revenu imposable de l'année du rachat + intérêts. Piège classique en fin de carrière. Anti-abus contre l'optimisation "rachat-puis-retrait".$QK$,
$QK$["FAUX — piège fiscal classique et sanctionné.", null, "FAUX — annulation totale, pas partielle.", "FAUX — le rachat n'est pas remboursé, mais la déduction est reprise fiscalement."]$QK$::jsonb,
$QK$Erreur = client conseillé à racheter juste avant la retraite pour "économiser l'impôt" → 2 ans plus tard il retire, l'administration réclame 10-15k CHF de rectification + intérêts. Colère + poursuite courtier. Devoir de conseil = vérifier la fenêtre 3 ans.$QK$,
TRUE),

-- ───────── ÉTUDES DE CAS ─────────

('lpp','L015','LPP — Étude de cas','case_study',
$QK$CAS : Marc, 45 ans, ingénieur, salaire 130k CHF/an, marié 2 enfants. Il vous consulte car il a eu 4 employeurs sur 20 ans et ne sait pas où sont ses avoirs LPP. Il envisage l'achat d'une maison familiale à 800k dans 2 ans. Quelle est la PRIORITÉ ABSOLUE lors de votre 1er entretien ?$QK$,
$QK$["Vendre immédiatement un plan de prévoyance 3a", "Lancer la reconstitution des 4 avoirs LPP via Fonds de garantie + demander à Marc les certificats de sortie/prévoyance des anciens employeurs", "Diriger Marc vers un courtier hypothécaire", "Proposer un rachat de 100 000 CHF immédiat"]$QK$::jsonb,
1,
$QK$Avant TOUT autre conseil (3a, hypothèque, rachats), il faut cartographier ses avoirs LPP existants. Sans cette vision consolidée, on ne peut pas dimensionner : (1) le retrait EPL possible pour la maison, (2) le potentiel de rachat, (3) la stratégie retraite globale. La reconstitution est la fondation.$QK$,
$QK$["Vendre du 3a sans cartographier le 2e pilier = mauvais séquencement stratégique.", null, "Aiguiller vers hypothèque sans connaître l'apport LPP possible = perdre le levier EPL.", "Proposer un rachat sans connaître le potentiel de rachat exact (calculé par la caisse actuelle) = risque de sur/sous-racheter."]$QK$::jsonb,
$QK$Erreur = zapper la reconstitution → conseils ultérieurs bancals → client mal servi. À l'inverse, un courtier qui commence PROPREMENT par la reconstitution démontre expertise + gagne la confiance → toute la relation client est facilitée pour les upsells futurs.$QK$,
TRUE),

('lpp','L016','LPP — Étude de cas','single',
$QK$SUITE CAS Marc : la reconstitution révèle 4 comptes pour un total de 285k CHF. Il envisage un retrait EPL pour la maison (apport 200k). Quelle est la limite légale de RETRAIT EPL à son âge (45 ans, donc AVANT 50 ans) ?$QK$,
$QK$["50 000 CHF maximum par vie", "100 % de son avoir de vieillesse total (avoir obligatoire + surobligatoire) est retirable en EPL avant 50 ans, plafond réel = son avoir total", "Uniquement la partie obligatoire", "Aucune limite, il peut retirer plus que son avoir"]$QK$::jsonb,
1,
$QK$Avant 50 ans, aucun plafonnement légal — le retrait EPL est possible jusqu'à 100 % de l'avoir de vieillesse total (obligatoire + surobligatoire). Après 50 ans, la règle de plafonnement s'applique (max entre avoir actuel/2 et avoir à 50 ans). Point important à connaître pour bien conseiller sur le TIMING du retrait.$QK$,
$QK$["FAUX — pas de plafond forfaitaire.", null, "FAUX — la partie surobligatoire est aussi retirable en EPL.", "FAUX — évidemment pas plus que ce qu'on possède."]$QK$::jsonb,
$QK$Erreur = mal informer sur le plafonnement âge = client vend son projet immo sur des chiffres incorrects. La différence "avant/après 50 ans" est capitale et souvent mal maîtrisée.$QK$,
TRUE),

-- ───────── RÈGLEMENT KLARY LPP-SPÉCIFIQUE ─────────

('lpp','KL01','Règlement Klary — LPP sensible','single',
$QK$Un ancien client Klary (à la retraite) vous demande de gérer son capital LPP retiré (2,4 millions CHF). Vous êtes agent en assurance, pas en placement financier. Que faites-vous ?$QK$,
$QK$["J'accepte, je place chez ma banque partenaire, on partage la commission", "Je REFUSE catégoriquement — l'agent LPP Klary a mandat courtage en assurance (LSA), PAS en gestion de fortune (LSFin/LEFin). Je redirige vers un gérant agréé et documente le refus par écrit", "J'accepte si le client signe une décharge", "J'accepte sans en parler à Klary"]$QK$::jsonb,
1,
$QK$Séparation stricte des activités réglementées : LSA (assurance) ≠ LSFin/LEFin (services financiers/gestion de fortune). Un intermédiaire d'assurance FINMA ne peut PAS conseiller le placement d'un capital retraite retiré. Faire du placement sans agrément = infraction pénale (art. 44 LFINMA) + retrait immédiat de l'agrément Klary. Refuser + documenter est la seule voie propre.$QK$,
$QK$["Faute grave PÉNALE — activité de service financier sans agrément.", null, "Décharge ne couvre PAS l'absence d'agrément réglementaire. Signature client ≠ conformité FINMA.", "Cacher à Klary aggrave — implication direction dans un cas de mixage d'activités = risque de perte de mandat courtier."]$QK$::jsonb,
$QK$CONSÉQUENCE : plainte FINMA d'un client ou d'un concurrent → sanction pénale personnelle (peines pécuniaires jusqu'à 500k CHF art. 44 LFINMA) + radiation intermédiaire + poursuite civile Klary vs agent pour préjudice réputationnel. Un capital retraite mal placé = drame patrimonial.$QK$,
TRUE),

('lpp','KL02','Règlement Klary — LPP confidentialité','single',
$QK$Vous avez accès aux avoirs LPP consolidés d'un client (via la reconstitution) : total 850k CHF. Un membre de sa famille vous contacte "juste pour savoir combien il a environ pour l'héritage". Vous :$QK$,
$QK$["Je donne un ordre de grandeur, c'est de la famille", "Je REFUSE toute divulgation, même partielle, et rappelle que les données patrimoniales sont couvertes par le secret professionnel LSA + secret des affaires + nLPD", "Je confirme uniquement s'il a un LPP", "J'accepte contre demande écrite du membre de famille"]$QK$::jsonb,
1,
$QK$Les données patrimoniales d'un client (avoirs LPP, 3a, hypothèque…) sont particulièrement sensibles. Secret professionnel LSA + nLPD + secret des affaires. Aucune divulgation à un tiers, même conjoint ou héritier présumé, sans consentement écrit signé du client lui-même. Refuser courtoisement + orienter vers le client.$QK$,
$QK$["Faute grave — divulgation même approximative = violation du secret. Cas fréquent de conflit familial autour de l'héritage.", null, "Confirmer l'existence est déjà une divulgation.", "Demande écrite d'un tiers ≠ consentement du client. Sans le client, pas d'accès."]$QK$::jsonb,
$QK$CONSÉQUENCE : divulgation à un membre de famille en conflit avec le client → plainte pénale du client (art. 47 LB + art. 35 nLPD) + poursuite civile massive (préjudice moral 20-50k CHF) + licenciement immédiat Klary. Un des 3 cas les plus fréquents de fautes agent en Suisse.$QK$,
TRUE),

('lpp','KL03','Règlement Klary — LPP non-sollicitation','single',
$QK$Vous quittez Klary. Vous avez travaillé pendant 2 ans sur les dossiers LPP de plusieurs clients avec des avoirs importants (500k-2M CHF). Votre nouveau courtier vous propose une prime de 50k CHF si vous "amenez" ces clients avec vous. Que faites-vous ?$QK$,
$QK$["J'accepte, c'est une opportunité", "Je REFUSE — c'est violation directe de la clause de non-sollicitation Klary (art. 340 CO) + détournement de portefeuille (art. 6 LCD). Les fonds LPP consolidés par Klary appartiennent au portefeuille Klary, pas à moi", "J'accepte discrètement en changeant le nom des clients", "J'accepte si la prime est en cash non déclaré"]$QK$::jsonb,
1,
$QK$LPP + fonds sensibles = poursuite renforcée en cas de sollicitation. La consolidation LPP réalisée sous mandat Klary a créé une VALEUR AJOUTÉE PATRIMONIALE dont Klary est légitime propriétaire commercial. Amener ces clients = double faute (non-sollicitation + concurrence déloyale). Dommages-intérêts calculés sur pourcentage des avoirs sous mandat = potentiellement 50-100k CHF PAR client.$QK$,
$QK$["Faute grave + pénale (art. 158 CP gestion déloyale possible).", null, "Aggravant — dissimulation intentionnelle = fraude, augmente la peine.", "Aggravant — prime non déclarée = fraude fiscale personnelle en plus."]$QK$::jsonb,
$QK$CONSÉQUENCE : Klary constate le départ des clients → poursuite art. 340b CO + concurrence déloyale + pénal (art. 158 CP). Cas récent Vaud : 380 000 CHF de condamnation + interdiction professionnelle 24 mois sur ces clients. Pour 50k de prime, on risque 500k de préjudice.$QK$,
TRUE),

('lpp','KL04','Règlement Klary — LPP traçabilité','single',
$QK$Un client vous demande de faire une demande de reconstitution LPP au Fonds de garantie SANS le documenter dans le CRM Klary "pour garder ça discret entre nous". Vous :$QK$,
$QK$["J'accepte, c'est son affaire", "Je REFUSE — chaque acte de courtage LPP DOIT être tracé au CRM (obligation FINMA VBI + protection client + protection agent). Une demande sans trace = risque de non-recevabilité fiscale + impossibilité de prouver le devoir de conseil en cas de litige", "J'accepte mais je note sur un fichier perso", "J'accepte si le client signe une décharge"]$QK$::jsonb,
1,
$QK$La traçabilité CRM du courtage LPP est renforcée : ce sont des fonds retraite avec effets fiscaux + juridiques. Sans trace, en cas de litige (client mécontent, contrôle fiscal, procédure de succession), le courtier n'a AUCUNE preuve de son conseil. Le CRM est le bouclier légal. Refus catégorique + explication au client.$QK$,
$QK$["Faute grave et sanctionnable FINMA.", null, "Fichier perso = données patrimoniales hors système sécurisé = infraction nLPD + inutilisable comme preuve légale.", "Décharge ne dispense pas de l'obligation de traçabilité imposée par la LSA."]$QK$::jsonb,
$QK$CONSÉQUENCE : 3 ans plus tard le client conteste "vous ne m'aviez pas dit XX", agent sans trace = culpabilité présumée. Perte du procès + condamnation civile 30-80k CHF + fin de carrière Klary. La rigueur CRM est la seule protection.$QK$,
TRUE),

('lpp','KL05','Règlement Klary — LPP commissions','single',
$QK$Un client hésite entre un rachat LPP (rétroactif dans sa caisse) ou un versement 3ᵉ pilier A. Vous savez que la commission Klary sur le 3a est PLUS ÉLEVÉE que sur le rachat LPP. L'analyse fiscale personnalisée montre que le rachat LPP serait plus avantageux pour le client. Vous :$QK$,
$QK$["Je pousse le 3a — mes commissions comptent", "Je recommande le RACHAT LPP par écrit (au bénéfice client), même si la commission est plus faible. Devoir de conseil FINMA + obligation d'informer du meilleur produit peu importe la commission", "Je propose les 2 en laissant le client choisir sans analyse", "Je pousse le 3a en cachant l'analyse défavorable"]$QK$::jsonb,
1,
$QK$Le devoir de conseil (LSA + directive FINMA VBI) impose de recommander la meilleure solution POUR LE CLIENT, indépendamment de la commission courtier. La transparence sur les commissions est aussi une obligation (art. 45 LSA). Le rachat LPP peut économiser au client 5-15k CHF d'impôt vs 3a — priorité absolue sur la commission courtier.$QK$,
$QK$["Faute déontologique majeure + potentiel PÉNAL (gestion déloyale art. 158 CP).", null, "Laisser choisir sans analyse = manquement au devoir de conseil (attendu = argumenter, chiffrer).", "Cacher l'analyse = fraude intellectuelle. Aggravant."]$QK$::jsonb,
$QK$CONSÉQUENCE : audit FINMA découvre des placements systématiquement biaisés vers produits à haute commission → sanction Klary + radiation intermédiaire de l'agent + procédure civile massive des clients lésés. Cas très surveillé depuis 2024 avec la nouvelle jurisprudence sur les incitations.$QK$,
TRUE)

ON CONFLICT DO NOTHING;
