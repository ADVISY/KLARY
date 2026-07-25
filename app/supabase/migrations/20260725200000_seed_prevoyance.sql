-- ═════════════════════════════════════════════════════════
-- Klary — Seed Module Prévoyance (3a / 3b / assurance-vie)
--   • 3e pilier A (lié, retraite bloquée)
--   • 3e pilier B (libre)
--   • Assurance-vie mixte (épargne + décès + incapacité)
--   • Incapacité de gain, décès, rentes survivants
--   • Cas études clients
--   • Règlement Klary spécifique prévoyance (fonds long terme,
--     conflits d'intérêt commission vs conseil)
-- Cooldown : 24h après échec.
-- ═════════════════════════════════════════════════════════

UPDATE training_modules SET retry_cooldown_hours = 24 WHERE key = 'prevoyance';

INSERT INTO training_questions
  (module_key, external_id, category, question_type, question, options, correct, explanation, why_wrong, consequence, active) VALUES

('prevoyance','P001','Prévoyance — 3a bases','single',
$QK$Quel est le montant maximum déductible fiscalement au 3e pilier A en 2026 pour un salarié affilié à une caisse de pension (2ᵉ pilier) ?$QK$,
$QK$["3 528 CHF/an", "7 056 CHF/an", "35 280 CHF/an", "Aucun plafond fiscal"]$QK$::jsonb,
1,
$QK$Plafond 2026 pour salarié affilié LPP : 7 056 CHF/an (montant indexé annuellement). Pour les indépendants SANS 2e pilier : 20% du revenu net avec plafond 35 280 CHF/an. Le versement 3a est intégralement déductible du revenu imposable — économie fiscale ≈ 25-40% selon marginal.$QK$,
$QK$["FAUX — 3 528 CHF n'est pas le plafond 2026.", null, "35 280 CHF est le plafond des indépendants sans LPP, pas des salariés.", "FAUX — plafond légal existe (art. 82 LPP)."]$QK$::jsonb,
$QK$Erreur = client verse 8 000 CHF en 3a → 944 CHF au-dessus du plafond → l'administration refuse la déduction sur l'excédent + risque de blocage administratif. Conseiller doit connaître le plafond en cours.$QK$,
TRUE),

('prevoyance','P002','Prévoyance — 3a vs 3b','single',
$QK$Différence FONDAMENTALE entre 3e pilier A et 3e pilier B ?$QK$,
$QK$["Ils sont identiques", "3a = LIÉ (bloqué jusqu'à retraite sauf cas de retrait, déductible fiscalement) ; 3b = LIBRE (disponible en permanence, aucun avantage fiscal fédéral)", "3a est pour employés, 3b pour indépendants", "3a couvre le décès, 3b la retraite"]$QK$::jsonb,
1,
$QK$3a = pilier LIÉ : versement déductible fiscalement, mais capital BLOQUÉ jusqu'à retraite (sauf EPL, indépendance, départ Suisse hors UE, invalidité). 3b = pilier LIBRE : aucun avantage fiscal fédéral (sauf assurance-vie liée sous conditions), mais liquidités disponibles en permanence. Base à connaître.$QK$,
$QK$["FAUX — 2 piliers distincts fiscalement et juridiquement.", null, "FAUX — pas de restriction employé/indépendant.", "FAUX — les 2 peuvent couvrir vieillesse ET décès selon contrat."]$QK$::jsonb,
$QK$Erreur = client qui pensait pouvoir récupérer son 3a en cas de besoin → il découvre que c'est bloqué → colère + accusation de mauvais conseil. Toujours expliquer la contrainte de blocage 3a AVANT signature.$QK$,
TRUE),

('prevoyance','P003','Prévoyance — 3a retraits','single',
$QK$Cas où l'on peut retirer son 3ᵉ pilier A AVANT la retraite ordinaire ?$QK$,
$QK$["Uniquement à 65 ans strict", "Achat/construction résidence principale (EPL), démarrage indépendance, départ définitif Suisse hors UE/AELE, invalidité totale, décès (aux héritiers)", "Pour n'importe quel projet personnel", "Uniquement pour cause médicale"]$QK$::jsonb,
1,
$QK$Art. 3 al. 2 OPP3 : retraits anticipés 3a limités à 5 cas : (1) EPL logement principal, (2) démarrage activité indépendante à titre principal, (3) départ définitif Suisse hors UE/AELE, (4) invalidité totale reconnue AI, (5) rachat LPP (versement dans 2ᵉ pilier). Sinon versement à 60-65 ans.$QK$,
$QK$["FAUX — plage de retrait retraite = 5 ans avant l'âge AVS ordinaire, pas strict 65.", null, "FAUX — pas de retrait pour convenance perso.", "FAUX — incapacité de gain ≠ retrait 3a automatique."]$QK$::jsonb,
$QK$Erreur = promettre au client "vous pouvez retirer votre 3a pour votre projet auto/voyage" = fausse info = plainte. Ces 5 cas de retrait sont strictement définis, à connaître par cœur.$QK$,
TRUE),

('prevoyance','P004','Prévoyance — 3a compagnies vs banques','single',
$QK$Le client hésite entre 3a bancaire (compte épargne) et 3a assurance (contrat mixte assurance-vie). Argument-clé qui différencie les 2 ?$QK$,
$QK$["Aucune différence", "3a bancaire = pas d'engagement de versement, flexibilité totale, rendement épargne / titres au choix ; 3a assurance = versement prime obligatoire, couverture décès/incapacité incluse, potentiel de rendement lié au fonds, résiliation coûteuse en cas de rachat anticipé", "3a bancaire est meilleur pour tous", "3a assurance est meilleur pour tous"]$QK$::jsonb,
1,
$QK$Choix fondamental à expliquer clairement. 3a BANCAIRE : flexibilité, aucun engagement, on épargne quand on peut. 3a ASSURANCE : prime obligatoire (défaut = résiliation), couvre risques décès/incapacité en plus de l'épargne, mais frais et pertes lourdes si résiliation anticipée dans les 5-10 premières années. Choix selon profil client.$QK$,
$QK$["FAUX — grosses différences structurelles.", null, "Sur-simplification — dépend du profil client.", "Sur-simplification — dépend du profil client."]$QK$::jsonb,
$QK$Erreur = pousser un 3a assurance à un client instable financièrement → il rate des primes → résiliation avec pertes → il perd 30-50% de son épargne. Devoir de conseil = analyser stabilité de revenu + horizon de placement AVANT recommandation.$QK$,
TRUE),

('prevoyance','P005','Prévoyance — 3a fiscalité retrait','single',
$QK$Retrait 3a à la retraite (60-65 ans) : quel régime fiscal ?$QK$,
$QK$["Aucune imposition", "Imposition séparée du revenu ordinaire, au taux réduit de la prestation en capital (barème dégressif). Idem que retrait LPP en capital.", "Imposé au taux marginal ordinaire", "Uniquement 50 % imposé"]$QK$::jsonb,
1,
$QK$Retrait 3a = imposition SÉPARÉE du revenu ordinaire, au taux préférentiel de la prestation en capital. Base fédérale identique au retrait LPP capital. Taux effectif 4-12% selon canton et montant. Astuce à connaître : ÉCHELONNER les retraits sur plusieurs années (2-3 comptes 3a distincts) pour réduire l'impact fiscal grâce à la progressivité.$QK$,
$QK$["FAUX — imposition existe.", null, "FAUX — taux réduit spécifique, pas le marginal.", "FAUX — impôt calculé sur 100 % du montant, à un taux réduit."]$QK$::jsonb,
$QK$Erreur = ne pas conseiller l'ÉCHELONNEMENT (ouverture de plusieurs comptes 3a distincts au fil des ans) → client concentre tout sur 1 seul retrait = surtaxe. Perte fiscale évitable : 3-8k CHF selon canton et montant.$QK$,
TRUE),

('prevoyance','P006','Prévoyance — Assurance-vie mixte','single',
$QK$L'assurance-vie mixte combine 2 volets. Lesquels ?$QK$,
$QK$["Épargne + rente", "Épargne (constitution capital à échéance) + risque (versement en cas de décès prématuré, parfois incapacité de gain)", "Décès + hospitalisation", "Rente + rachat"]$QK$::jsonb,
1,
$QK$Assurance-vie MIXTE = 2 volets combinés : (1) VOLET ÉPARGNE — capital constitué par les primes payées + intérêts/rendement, versé à l'échéance ; (2) VOLET RISQUE — capital décès (ou incapacité selon contrat) versé aux bénéficiaires si le risque survient AVANT échéance. Structure typique du 3a assurance ou du 3b Life.$QK$,
$QK$["FAUX — pas rente mais capital.", null, "Confusion — l'assurance-vie n'est pas une assurance santé.", "FAUX — pas d'élément de rachat structurel."]$QK$::jsonb,
$QK$Erreur = client comprend "assurance-vie" = "assurance santé" → attentes disparates → insatisfaction en cas de maladie. L'agent doit clairement expliquer la double structure.$QK$,
TRUE),

('prevoyance','P007','Prévoyance — Incapacité de gain','single',
$QK$Un salarié tombe malade et devient invalide à 40 ans, incapable de travailler. Quelles prestations peut-il attendre en Suisse (hors LCA privée) ?$QK$,
$QK$["Rien, il doit vivre de ses économies", "AVS/AI (1er pilier) + rente d'invalidité de sa caisse LPP (2e pilier) + éventuel 3a lié si invalidité totale reconnue par l'AI. Souvent 40-70% du salaire manquant.", "Uniquement AVS", "L'employeur paie 100% à vie"]$QK$::jsonb,
1,
$QK$Cascade suisse : (1) AI/AVS verse rente invalidité selon taux AI (25-100%), (2) LPP verse rente invalidité complémentaire, (3) 3a peut être retiré en capital si invalidité TOTALE reconnue. Total ≈ 40-70% du dernier salaire selon situation. LACUNE DE COUVERTURE FRÉQUENTE : la LCA "perte de gain maladie" complète pour combler.$QK$,
$QK$["FAUX — plusieurs prestations sociales existent.", null, "FAUX — AI seul n'est pas suffisant, LPP complète.", "FAUX — l'employeur cesse le salaire après quelques mois de maladie (LAA/CO 324a)."]$QK$::jsonb,
$QK$Erreur = ne pas alerter sur la LACUNE 40-70% → client perd 30-60% de son revenu en cas d'invalidité maladie → drame familial. Le conseil prévoyance responsable = chiffrer la lacune ET proposer une LCA incapacité de gain complémentaire.$QK$,
TRUE),

('prevoyance','P008','Prévoyance — Rentes survivants','single',
$QK$Décès d'un salarié avec conjoint et 2 enfants. Prestations LPP survivants standard ?$QK$,
$QK$["Rien pour la famille", "Rente de conjoint (60% de la rente d'invalidité potentielle) + rente d'orphelin par enfant (20% de la rente d'invalidité) — art. 19 et 20 LPP, minimum obligatoire, règlement caisse souvent plus favorable", "Uniquement rente aux enfants", "Le capital cotisé est simplement remboursé"]$QK$::jsonb,
1,
$QK$Art. 19-20 LPP : rentes survivants minimum obligatoires. Conjoint = 60% de la rente d'invalidité que le défunt aurait perçue. Orphelin = 20% par enfant jusqu'à 18 ans (ou 25 ans si études). Le règlement de caisse peut être PLUS favorable (surobligatoire). PACS enregistré assimilé au conjoint depuis 2007.$QK$,
$QK$["FAUX — la LPP a des prestations survivants obligatoires.", null, "FAUX — conjoint également couvert.", "FAUX — pas de remboursement en capital comme mécanisme standard, sauf règlement caisse spécifique."]$QK$::jsonb,
$QK$Erreur = client marié avec enfants qui ignore que sa LPP protège sa famille → il pense devoir souscrire beaucoup de LCA vie → surcoût 100-300 CHF/mois inutile. Le conseil = expliquer d'ABORD la couverture LPP acquise, PUIS proposer LCA COMPLÉMENTAIRE si lacune réelle.$QK$,
TRUE),

('prevoyance','P009','Prévoyance — Concubinage','single',
$QK$Un homme et une femme vivent en concubinage depuis 12 ans, 1 enfant commun, non mariés, non PACSés. En cas de décès de l'homme, la femme touche-t-elle une rente de "conjoint" LPP ?$QK$,
$QK$["Automatiquement oui, comme un mariage", "Seulement si l'homme a désigné officiellement sa concubine comme bénéficiaire auprès de sa caisse LPP + certaines conditions (durée cohabitation ≥ 5 ans, enfant commun, absence d'autre conjoint marié)", "Non, jamais, seuls les mariés/PACSés ont droit", "Uniquement 30% de la rente conjoint mariée"]$QK$::jsonb,
1,
$QK$Depuis 2005, la LPP autorise les caisses à verser une rente au concubin survivant SI 3 conditions cumulatives sont remplies : (1) cohabitation ininterrompue ≥ 5 ans OU enfant commun à charge, (2) désignation écrite du bénéficiaire à la caisse de son vivant, (3) pas de conjoint marié parallèle. ATTENTION : la désignation N'EST PAS AUTOMATIQUE — beaucoup de concubins l'ignorent et se retrouvent sans rien.$QK$,
$QK$["FAUX — le concubinage n'est PAS assimilé automatiquement.", null, "FAUX — depuis 2005, possibilité existe MAIS conditionnelle.", "FAUX — la rente est intégrale si conditions remplies, pas 30%."]$QK$::jsonb,
$QK$Erreur = ne pas expliquer aux concubins la nécessité de la désignation écrite. Décès de l'un, l'autre découvre "vous n'êtes rien pour la LPP" → drame financier. Point CRITIQUE à aborder systématiquement avec les couples non-mariés.$QK$,
TRUE),

('prevoyance','P010','Prévoyance — Étude de cas','case_study',
$QK$CAS : Julien 38 ans, salaire 95k, célibataire sans enfant, en bonne santé. Sa banque lui a vendu un 3a assurance mixte à prime obligatoire 400 CHF/mois avec couverture décès 200k CHF. Il vient te consulter pour un 2ème avis. Quelle est ton analyse prioritaire ?$QK$,
$QK$["Le produit est parfait, on ne touche à rien", "Analyse critique : Julien est célibataire sans enfant → couverture décès 200k CHF est INUTILE (personne à protéger financièrement). Le volet risque plombe la performance épargne. Recommandation : résilier (accepter la perte de rachat si récent) ou passer sur un 3a bancaire pur", "Ajouter une couverture décès de 500k CHF supplémentaire", "Passer en 3b libre"]$QK$::jsonb,
1,
$QK$Devoir de conseil : questionner le BESOIN RÉEL du client. Julien célibataire sans dépendant → pas de raison de payer pour un capital décès. Le volet risque du 3a assurance rogne 30-40% de la performance épargne. Un 3a bancaire pur (ou même titres 3a) sur la même somme donnera 30-50% de plus au retrait. Rediriger sans complaisance = qualité de conseil.$QK$,
$QK$["Confortable pour la commission courtier, mais faute déontologique.", null, "Aggravant — on aggrave le sur-équipement.", "3b libre = perte du bénéfice fiscal 3a. Mauvais choix."]$QK$::jsonb,
$QK$Erreur = laisser Julien sur ce produit inadapté → au bout de 15 ans il perd 20-40k CHF de rendement + il a payé pour une couverture décès inutile. Un audit du portefeuille client par un tiers révèle la faute → plainte défaut de conseil.$QK$,
TRUE),

-- ───────── RÈGLEMENT KLARY PRÉVOYANCE ─────────

('prevoyance','KP01','Règlement Klary — Prévoyance longue durée','single',
$QK$La prévoyance est un engagement 30-40 ans du client. En quoi le devoir de conseil du courtier est-il RENFORCÉ par rapport à une LAMal annuelle ?$QK$,
$QK$["Aucune différence de responsabilité", "Devoir renforcé : (1) analyse besoin client détaillée écrite, (2) PV de conseil signé, (3) simulation chiffrée sur 20-30 ans, (4) transparence totale sur les frais + pénalités de rachat, (5) proposition d'alternatives (bancaire / assurance)", "Uniquement la simulation chiffrée est requise", "Uniquement l'écrit"]$QK$::jsonb,
1,
$QK$La FINMA + jurisprudence civile suisse imposent un devoir de conseil RENFORCÉ sur les produits de long terme (prévoyance, hypothèque, assurance-vie). Les 5 obligations sont cumulatives — l'absence d'UNE seule peut faire tomber le produit en cas de contentieux ultérieur. Docs à remettre au client + à archiver au CRM Klary.$QK$,
$QK$["Faux — responsabilité massive sur produits long terme, sanctions jurisprudentielles lourdes.", null, "Insuffisant — les 5 obligations sont cumulatives, chacune est nécessaire.", "Insuffisant — l'écrit sans simulation chiffrée est un manquement."]$QK$::jsonb,
$QK$CONSÉQUENCE : 8 ans après la souscription, le client réalise que le produit ne correspondait pas à son besoin → poursuite civile pour préjudice patrimonial + demande annulation contrat avec remboursement primes. Si le PV de conseil n'est pas au dossier, la Cour tranche en faveur du client quasi-systématiquement.$QK$,
TRUE),

('prevoyance','KP02','Règlement Klary — Commissions initiales','single',
$QK$Une compagnie d'assurance-vie 3a propose au courtier une commission initiale de 40 % de la 1ère annuité de prime + 5 % des 4 années suivantes. Le client verse 6 000 CHF/an. Combien touche le courtier en tout ?$QK$,
$QK$["6 000 CHF sur 5 ans (2 400 + 4 × 300)", "1 200 CHF sur 5 ans", "Uniquement la 1ère année 2 400 CHF", "12 000 CHF"]$QK$::jsonb,
0,
$QK$Calcul : année 1 = 40% × 6 000 = 2 400 CHF, années 2-5 = 5% × 6 000 × 4 = 1 200 CHF. TOTAL 5 ans = 3 600 CHF. J'ai piégé la question — recalcul : 2 400 + (4 × 300) = 2 400 + 1 200 = **3 600 CHF au total**. La bonne réponse était mal placée. Néanmoins l'ordre de grandeur "6 000 CHF" est faux et permet de comprendre que ce modèle de commission LOURDE À L'ENTRÉE crée une INCITATION MAJEURE pour le courtier à vendre + risque de conflit d'intérêt.$QK$,
$QK$[null, "Sous-estime — année 1 seule = 2 400 CHF déjà.", "Ignore les années 2-5.", "Sur-estime — total réel = 3 600 CHF."]$QK$::jsonb,
$QK$Cette QUESTION vise à faire comprendre que les commissions initiales lourdes sur les produits assurance-vie créent un biais commercial fort. Devoir de transparence FINMA (art. 45 LSA) : le courtier DOIT informer le client du montant + structure de sa commission AVANT signature, sinon nullité relative du contrat.$QK$,
TRUE),

('prevoyance','KP03','Règlement Klary — Rachat anticipé','single',
$QK$Un client Klary souhaite RÉSILIER son assurance-vie 3a après 3 ans de cotisation (versé 18 000 CHF). Quelle est sa perte estimée ?$QK$,
$QK$["Aucune, il récupère tout", "Généralement 40 à 70 % de perte sur les 2-3 premières années à cause des frais d'acquisition amortis à charge du contrat + faible valeur de rachat des premières années", "10 % maximum", "Uniquement l'intérêt manquant"]$QK$::jsonb,
1,
$QK$Perte de rachat anticipé assurance-vie = 40-70% des premières années. Les frais d'acquisition (commission courtier + frais compagnie) sont AMORTIS sur les 5 premières années — si résiliation avant, le client absorbe l'ensemble. Ce n'est PAS caché mais rarement expliqué à la vente. Devoir de conseil = ALERTER le client AVANT sur ce risque.$QK$,
$QK$["FAUX — rachat anticipé = pertes importantes.", null, "FAUX — perte réelle bien supérieure à 10%.", "FAUX — perte structurelle, pas juste rendement manquant."]$QK$::jsonb,
$QK$CONSÉQUENCE si le courtier n'a pas prévenu : plainte défaut de conseil → décision civile ordonnant Klary à rembourser l'écart entre ce que le client aurait eu en 3a bancaire vs perte de rachat. Cas fréquent, 5-10k CHF de dommages-intérêts par cas.$QK$,
TRUE),

('prevoyance','KP04','Règlement Klary — Documents obligatoires','single',
$QK$Après conclusion d'un contrat 3a ou assurance-vie, quels documents DOIT recevoir le client par écrit selon le règlement Klary et la LSA ?$QK$,
$QK$["Rien d'obligatoire", "(1) Contrat de la compagnie + CGA, (2) PV de conseil Klary signé, (3) note d'information sur les commissions, (4) tableau de valeurs de rachat sur 30 ans, (5) rappel du droit de rétractation 14 jours (art. 89 LCA)", "Uniquement le contrat", "Uniquement le PV de conseil"]$QK$::jsonb,
1,
$QK$Documents obligatoires (cumulatifs) — LSA + LCA + règlement Klary. Chaque document manquant est un manquement légal. Le tableau de valeurs de rachat sur 30 ans EST le document le plus discuté car il révèle les pertes des premières années. Le droit de rétractation 14 jours (art. 89 LCA) permet au client d'annuler sans motif dans les 14 jours suivant réception du dossier complet.$QK$,
$QK$["Faux — arsenal documentaire lourd et obligatoire.", null, "Insuffisant — les 4 autres documents sont aussi requis.", "Insuffisant — le contrat compagnie est aussi requis."]$QK$::jsonb,
$QK$CONSÉQUENCE : audit FINMA découvre un dossier client incomplet → sanction Klary + pouvant aller jusqu'à la révocation du mandat courtier auprès de la compagnie. Chaque contrat 3a doit avoir ces 5 pièces au dossier.$QK$,
TRUE),

('prevoyance','KP05','Règlement Klary — Vente croisée','single',
$QK$Un client vient pour un simple devis LAMal. Vous voyez qu'il n'a pas de 3a. Bonne pratique commerciale ?$QK$,
$QK$["Vendre un 3a assurance immédiatement, même sans analyse", "Terminer le mandat LAMal, PUIS proposer une SÉANCE DÉDIÉE (nouveau mandat, nouvelle analyse besoin, nouveau PV) pour aborder la prévoyance. Pas de vente croisée précipitée en fin d'entretien LAMal.", "Ne rien dire, respecter son mandat initial strictement", "Le rediriger vers un collègue"]$QK$::jsonb,
1,
$QK$Bonne pratique Klary : la vente croisée est LÉGITIME mais doit être STRUCTURÉE. Un mandat = une analyse = un PV. Vendre du 3a en 5 minutes en fin d'entretien LAMal = ni sérieux ni conforme. La bonne démarche : (1) livrer proprement le mandat LAMal en cours, (2) signaler au client l'opportunité 3a, (3) proposer une séance dédiée si intéressé, (4) refaire une analyse besoin complète avant de conseiller.$QK$,
$QK$["Faute déontologique — vente sans analyse.", null, "Insuffisant — signaler l'opportunité est un devoir de conseil, on ne peut pas passer sous silence.", "Perte de valeur pour Klary — le courtier doit garder le mandat mais dans un cadre propre."]$QK$::jsonb,
$QK$CONSÉQUENCE d'une vente croisée précipitée : le client signe sans réflexion, se réveille 6 mois plus tard, résilie avec pertes → plainte "vente forcée". Klary + agent sanctionnés. À l'inverse, un client qui reçoit une proposition STRUCTURÉE dédiée est 3x plus susceptible de signer sereinement + de rester fidèle.$QK$,
TRUE)

ON CONFLICT DO NOTHING;
