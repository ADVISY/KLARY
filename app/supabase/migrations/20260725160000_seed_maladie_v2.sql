-- ═════════════════════════════════════════════════════════
-- Klary — Seed v2 Maladie : questions enrichies
--   • Calculs franchise 300 vs 2500 (break-even, profil client)
--   • Études de cas clients réalistes (choix + argumentation)
--   • Règlement interne Klary (confidentialité, non-sollicitation,
--     appartenance clients, sanctions démission/faute)
--   • Chaque question : why_wrong[] par option + consequence
-- ═════════════════════════════════════════════════════════

-- ───────── CALCUL FRANCHISE 300 vs 2500 ─────────

INSERT INTO training_questions
  (module_key, external_id, category, question_type, question, options, correct, explanation, why_wrong, consequence, active) VALUES
(
  'maladie', 'M041', 'Calcul décisionnel — Franchise', 'numerical',
  'Client 32 ans, célibataire, en bonne santé, aucun soin régulier hors médecine du travail. Prime mensuelle Assura HMO franchise 300 = 305 CHF ; même modèle franchise 2500 = 165 CHF. À partir de quel montant annuel de frais de santé réels la franchise 300 devient-elle plus avantageuse ?',
  '["Dès 300 CHF de frais annuels", "Dès 1 680 CHF de frais annuels", "Dès 2 200 CHF de frais annuels", "Dès 2 520 CHF de frais annuels"]'::jsonb,
  3,
  'Économie de prime annuelle (2500 vs 300) = (305 − 165) × 12 = 1 680 CHF. Différence de franchise = 2 500 − 300 = 2 200 CHF. Break-even = 2 200 + 300 (car quote-part 10 % + franchise s''ajoute) ≈ 2 520 CHF de frais réels annuels. En dessous : franchise 2500 gagne. Au dessus : franchise 300 gagne.',
  '["Non — 300 CHF ne suffit pas à absorber l''écart de prime (1 680 CHF). L''écart total à couvrir est ≈ 2 520 CHF.", "C''est l''économie de prime seule, mais on oublie que la franchise 300 se paie EN PLUS des frais. Il faut ajouter la franchise + quote-part.", "C''est la différence de franchise brute, mais il faut y ajouter la quote-part 10 %. Le vrai break-even est ≈ 2 520 CHF.", null]'::jsonb,
  'Erreur = client jeune orienté vers franchise 300 par prudence, il paie 1 680 CHF de prime en trop chaque année sans jamais consommer. Sur 10 ans = 16 800 CHF perdus. Plainte typique : "Mon conseiller ne m''a jamais expliqué le calcul."',
  TRUE
),
(
  'maladie', 'M042', 'Calcul décisionnel — Franchise', 'numerical',
  'Cliente 68 ans, hypertension traitée (médicaments 180 CHF/mois soit 2 160 CHF/an), 4 consultations généraliste + 2 spécialistes/an (≈ 900 CHF), analyses labo (≈ 400 CHF). Prime franchise 300 = 520 CHF/mois ; franchise 2500 = 380 CHF/mois. Quelle franchise conseiller ?',
  '["Franchise 2 500 CHF — la prime plus basse compense", "Franchise 300 CHF — le total coûte moins cher", "Peu importe, la différence est négligeable", "Franchise 1 500 CHF (intermédiaire)"]'::jsonb,
  1,
  'Frais annuels attendus ≈ 3 460 CHF. Avec franchise 300 : prime 6 240 + franchise 300 + quote-part 10 % × (3 460 − 300) = 316, donc 6 856 CHF/an total. Avec franchise 2500 : prime 4 560 + franchise 2 500 + quote-part max 700, soit 7 760 CHF/an. → Franchise 300 économise ≈ 900 CHF/an.',
  '["FAUX. La cliente consomme trop pour amortir le saut de franchise. Écart de prime 1 680 vs coût franchise + quote-part supplémentaire ≈ 2 580. Elle perdrait 900 CHF/an.", null, "FAUX. Écart de 900 CHF/an ≈ 9 000 CHF sur 10 ans. C''est significatif pour un retraité.", "Franchise 1500 existe mais reste sub-optimale ici. Pour un consommateur régulier, franchise minimale est presque toujours la bonne réponse."]'::jsonb,
  'Erreur = client senior consommateur pousse en franchise 2500 pour "économiser la prime" et paie 900 CHF/an de trop. En 5 ans = 4 500 CHF de perte + risque de renoncement aux soins (consulte moins pour éviter la franchise) = drame sanitaire.',
  TRUE
),
(
  'maladie', 'M043', 'Calcul décisionnel — Franchise', 'single',
  'Un jeune indépendant de 27 ans en bonne santé vous dit : "Je veux la franchise la plus basse comme mes parents, on ne sait jamais." Quelle est votre approche professionnelle ?',
  '["Je respecte son choix, c''est son argent", "Je pose des questions sur sa consommation médicale réelle des 3 dernières années et je lui montre le calcul chiffré des 2 options", "Je lui impose la franchise 2500 c''est mieux pour lui", "Je propose une franchise intermédiaire à 1000 pour temporiser"]'::jsonb,
  1,
  'Devoir de conseil : quantifier avant de recommander. Poser des questions concrètes (soins des 3 dernières années, budget mensuel, tolérance au risque financier ponctuel), calculer les 2 scénarios, présenter le break-even. Le client décide ensuite en connaissance de cause — traçable par écrit dans le PV de conseil.',
  '["Non — le devoir de conseil (LSA + directive FINMA VBI) impose d''informer sur les alternatives. Respecter sans expliquer = manquement.", null, "Non — imposer, c''est violation du libre choix client. Faute déontologique.", "Franchise intermédiaire = compromis lâche. On tranche par le calcul, pas par la moyenne."]'::jsonb,
  'Erreur = le client signe une franchise 300 sans jamais avoir vu le calcul. 5 ans plus tard il compare avec un ami : plainte FINMA "défaut de conseil". Klary risque avertissement + remboursement civil des primes surpayées.',
  TRUE
),
(
  'maladie', 'M044', 'Calcul décisionnel — Franchise', 'numerical',
  'Client accepte une franchise 2500 économique. En avril, il apprend qu''il doit se faire opérer (frais estimés 8 000 CHF). Peut-il baisser sa franchise à 300 en cours d''année pour minimiser sa quote-part ?',
  '["Oui, changement possible à tout moment sur demande motivée", "Oui, mais uniquement avec préavis 3 mois", "Non — le changement de franchise ne prend effet qu''au 1er janvier de l''année suivante, demande à faire avant le 30 novembre", "Non — la franchise est bloquée à vie une fois choisie"]'::jsonb,
  2,
  'Art. 93 OAMal : changement de franchise LAMal effet au 1er janvier N+1, demande jusqu''au 30 novembre. Aucune modification en cours d''année, quelle que soit la raison (opération, maladie, grossesse). C''est un choix stratégique annuel figé.',
  '["FAUX — la franchise est figée pour l''année en cours. Une opération ne rouvre pas le droit de changement.", "FAUX — pas de préavis 3 mois, c''est une date butoir fixe au 30 novembre.", null, "FAUX — le changement est possible chaque année (30 nov pour effet 1er janvier), mais pas en cours d''année."]'::jsonb,
  'Erreur = agent affirme au client "on peut baisser après si besoin" = fausse information manifeste. Client refuse plus tard de payer la différence, poursuite civile pour préjudice. Le conseil doit être basé sur des faits légaux vérifiables.',
  TRUE
),

-- ───────── ÉTUDES DE CAS CLIENTS ─────────

(
  'maladie', 'M045', 'Étude de cas — Famille Duvernay', 'case_study',
  'CAS : Marc (42 ans, ingénieur, 145k CHF/an, sportif marathonien), Sarah (39 ans, mi-temps 62k CHF, enceinte du 3e enfant — accouchement dans 5 mois), Léo (8 ans) et Emma (5 ans). Situation actuelle : tous chez Assura Standard + LCA hospitalier commune. Marc envisage passer en HMO pour économiser. Sarah aimerait passer en division privée avant l''accouchement. Quel est l''ordre prioritaire d''action LE PLUS CRITIQUE ?',
  '["Passer Marc en HMO immédiatement, c''est là l''économie principale", "Souscrire une LCA hospitalière privée/semi-privée pour Sarah AVANT l''accouchement (délai carence + questionnaire santé si tardif)", "Ouvrir un compte tiers-payant familial pour simplifier", "Résilier toutes les LCA pour épurer le budget"]'::jsonb,
  1,
  'Sarah est enceinte : dès la déclaration de grossesse, les compagnies LCA activent des délais de carence de 270 jours ou refusent la couverture accouchement. Chaque semaine perdue = risque de perdre la couverture privée sur l''accouchement (5-8k CHF de dépassement médecin-cadre). C''est l''urgence absolue. Marc en HMO peut attendre 30 novembre.',
  '["Non — passer Marc en HMO peut attendre le 30 novembre. Le risque Sarah est PLUS urgent et non rattrapable.", null, "Tiers-payant familial est utile mais pas critique. Pas de contrainte temporelle.", "Résilier des LCA sans remplacement = famille à découvert. Faute grave de conseil."]'::jsonb,
  'Erreur = si l''agent traite d''abord l''économie Marc, Sarah rate le délai carence LCA hospitalier. Facture privée à l''accouchement 8 000 CHF non prise en charge. Le mari demande justification : "Pourquoi vous ne nous avez pas prévenus ?" → plainte + demande remboursement + réputation.',
  TRUE
),
(
  'maladie', 'M046', 'Étude de cas — Famille Duvernay', 'single',
  'SUITE CAS Duvernay : Sarah demande "Si le bébé naît avec un problème de santé, quelle assurance couvre ?" Que répondez-vous ?',
  '["Le bébé n''est couvert qu''à partir de son inscription (3 mois post-naissance)", "Le nouveau-né est couvert automatiquement rétroactivement à la LAMal de la mère, mais uniquement si affilié à une caisse dans les 3 mois. Pour la LCA, il faut souscrire avant la naissance (couverture néonatale sans questionnaire santé) — sinon questionnaire médical exigé après.", "Le père doit obligatoirement affilier le bébé sur son propre contrat", "Aucune couverture avant le 1er anniversaire"]'::jsonb,
  1,
  'Point critique en pratique : LCA néonatale doit être souscrite PENDANT la grossesse (souvent avant fin 6e mois) pour bénéficier de l''affiliation SANS questionnaire santé du nouveau-né. Si vous attendez la naissance et l''enfant a un souci de santé, la LCA privée peut refuser ou surtarifer. La LAMal, elle, est acquise si affilié dans les 3 mois post-naissance.',
  '["FAUX — la LAMal est rétroactive si affilié dans les 3 mois. Pas d''attente.", null, "FAUX — les parents choisissent librement la caisse et le contrat, indépendamment.", "FAUX — couverture LAMal dès la naissance si affiliation ≤3 mois."]'::jsonb,
  'Erreur = famille attend l''accouchement pour souscrire LCA enfant. Bébé né avec malformation congénitale → refus LCA privée = famille assume dépassements toute la vie. C''est LE défaut de conseil pédiatrique le plus fréquent en Suisse.',
  TRUE
),

-- ───────── RÈGLEMENT INTERNE KLARY ─────────

(
  'maladie', 'K001', 'Règlement Klary — Accès compagnies', 'single',
  'Un collègue arrive à 17h en panique : "Il faut absolument saisir ce dossier Groupe Mutuel avant demain matin, mes accès sont bloqués. Prête-moi les tiens 5 minutes." Que faites-vous ?',
  '["Je lui prête mes accès, on est une équipe", "Je refuse catégoriquement — le partage d''accès est interdit et je saisis moi-même son dossier sous ma responsabilité si je peux, sinon on remonte à la direction", "Je note ses identifiants sur un post-it à côté de son écran", "Je lui donne mes accès en lui demandant de tout effacer après"]'::jsonb,
  1,
  'Le partage d''accès compagnie viole : (1) les CGU des compagnies (Groupe Mutuel, Helsana, Swica...) — révocation immédiate du mandat de Klary, (2) la nLPD (traçabilité individuelle des accès aux données santé), (3) le règlement interne Klary. Chaque action doit être imputable à UN agent identifié pour l''audit FINMA.',
  '["Non — c''est une faute grave. Solidarité ne dispense pas des règles de traçabilité et de sécurité.", null, "Post-it = pire encore. Diffusion visible d''un mot de passe à toute personne passant à ce bureau.", "Effacer ne compte pas — c''est le fait de partager qui constitue la faute, pas ce qui est fait ensuite."]'::jsonb,
  'CONSÉQUENCE POUR TOI : partage d''accès compagnie = motif de LICENCIEMENT IMMÉDIAT pour faute grave (art. 337 CO). Zéro indemnité, zéro préavis. Klary peut EN PLUS te réclamer des dommages-intérêts si la compagnie révoque le mandat (perte de portefeuille estimée à des dizaines de milliers de CHF). C''est écrit noir sur blanc dans ton contrat.',
  TRUE
),
(
  'maladie', 'K002', 'Règlement Klary — Confidentialité', 'single',
  'Un ami de longue date vous demande au restaurant : "Dis-moi juste si Monsieur X est bien assuré chez Groupe Mutuel." Il précise que c''est "juste pour vérifier une info". Vous :',
  '["Vous répondez oui/non, c''est banal", "Vous refusez toute confirmation ou infirmation, y compris implicite, et rappelez que c''est protégé par le secret professionnel", "Vous répondez évasivement pour ne pas vexer", "Vous confirmez uniquement s''il est bien lui-même client de Klary"]'::jsonb,
  1,
  'Secret professionnel LSA art. 46 + nLPD art. 61-62. Toute information sur un client — y compris son statut de client — est confidentielle. Confirmer ou infirmer, même par un silence gêné, constitue une divulgation. La bonne réponse est un refus courtois mais ferme.',
  '["FAUX — révéler qu''un tiers est client = violation du secret. Même sans détail sur le contrat.", null, "Une réponse évasive laisse deviner. C''est une divulgation par omission d''un refus clair.", "Le lien d''amitié ne crée aucun droit à l''information. Aucun contexte social ne prime le secret."]'::jsonb,
  'CONSÉQUENCE : dénonciation possible par le client à la FINMA + poursuite civile pour préjudice moral (≈ 5-15k CHF de dommages-intérêts). Chez Klary : avertissement écrit à la 1re fois, licenciement à la 2e. Un avertissement bloque toute promotion et suspend les commissions bonus.',
  TRUE
),
(
  'maladie', 'K003', 'Règlement Klary — Non-sollicitation', 'single',
  'Vous quittez Klary après 3 ans pour un poste chez un concurrent. Vous avez signé une clause de non-sollicitation client 24 mois. Un ancien client vous contacte spontanément sur votre portable perso pour vous demander vos nouveaux tarifs. Vous :',
  '["Vous répondez et lui envoyez une offre — c''est LUI qui a fait la démarche", "Vous refusez toute proposition commerciale, vous lui dites de repasser par Klary pour son mandat, et vous notez la sollicitation par écrit avec date pour votre protection", "Vous répondez à titre amical sans envoyer d''offre écrite", "Vous acceptez car la clause ne concerne que VOS démarches actives"]'::jsonb,
  1,
  'La clause de non-sollicitation en droit suisse (art. 340 CO + jurisprudence) couvre AUSSI la réception de sollicitations : accepter de traiter un ancien client, même s''il vient de lui-même, constitue une violation. La seule protection : refus écrit + trace datée. Le client peut revenir vers vous UNIQUEMENT après expiration de la clause (24 mois).',
  '["FAUX — la clause vise à protéger le portefeuille Klary. Répondre = capter, peu importe l''initiative.", null, "Amical ou pas, l''échange commercial est proscrit. Un conseil oral peut être qualifié de démarchage.", "Interprétation erronée. La clause couvre l''acceptation autant que l''initiative."]'::jsonb,
  'CONSÉQUENCE : Klary constate la reprise du client (les compagnies notifient les changements de mandat). Poursuite civile art. 340b CO = peine conventionnelle (souvent 6-12 mois de commissions du client) + dommages-intérêts. Cas récent : 24 000 CHF de peine + interdiction professionnelle sur ce client pour 24 mois de plus.',
  TRUE
),
(
  'maladie', 'K004', 'Règlement Klary — Appartenance clients', 'single',
  'À qui appartient un lead entrant reçu par le standard téléphonique Klary et que vous convertissez en client ?',
  '["À vous — vous avez fait la vente", "À Klary Sàrl exclusivement — vous êtes mandaté par Klary pour convertir et suivre le client, la commission vous est versée en contrepartie de votre travail, mais le portefeuille est propriété de Klary", "50/50 entre vous et Klary", "À vous après 12 mois de suivi"]'::jsonb,
  1,
  'Modèle courtier classique : le client est LE PORTEFEUILLE de Klary. L''agent est rémunéré pour son travail de conversion + suivi via commission (variable ou fixe), mais n''a AUCUN droit de propriété sur le client. À votre départ, le client reste chez Klary, un autre agent le reprend. C''est écrit dans le contrat et matérialisé par le mandat compagnie qui est au nom de Klary Sàrl, pas au vôtre.',
  '["FAUX — la vente déclenche la commission, elle ne transfère pas la propriété du client. Vous êtes salarié/mandataire de Klary.", null, "FAUX — pas de co-propriété. Klary est seul titulaire du mandat compagnie.", "FAUX — aucun mécanisme de transfert de propriété par ancienneté."]'::jsonb,
  'CONSÉQUENCE si un agent croit à tort que le client lui appartient : à son départ il essaie de "reprendre" ses clients → violation directe non-sollicitation → peine conventionnelle + procédure judiciaire. Beaucoup d''agents en Suisse ont fini avec 40-80k CHF de condamnation en croyant faire "leur droit".',
  TRUE
),
(
  'maladie', 'K005', 'Règlement Klary — Rendez-vous & prospects', 'single',
  'Vous rencontrez un prospect envoyé par le service leads Klary. Le RDV se passe mal, aucune signature. 3 mois plus tard, ce même prospect vous appelle sur votre portable perso (retrouvé sur LinkedIn). Il veut souscrire. Vous :',
  '["Vous signez le contrat au nom de votre société perso ou d''un autre courtier", "Vous ramenez le dossier à Klary — le prospect a été acquis via le canal Klary et reste attaché au portefeuille de leads Klary", "Vous partagez la commission avec Klary discrètement", "C''est un contact perso maintenant, vous êtes libre"]'::jsonb,
  1,
  'Un prospect issu du canal Klary (lead, référence, salon, publicité) est propriété du portefeuille lead Klary — même si aucun contrat n''a été signé lors du 1er RDV, même s''il vous recontacte via votre canal privé. La règle : quel est le canal INITIAL d''entrée ? Klary → Klary conserve. Le contourner via son perso = détournement de portefeuille = faute grave.',
  '["Faute grave — détournement de portefeuille prospect. Motif de rupture immédiate + poursuite pénale possible (art. 158 CP gestion déloyale).", null, "Le partage clandestin ne régularise rien, il aggrave (dissimulation intentionnelle).", "FAUX — le canal initial fait foi. Le fait que vous ayez retrouvé son numéro sur LinkedIn ne rouvre pas le canal privé."]'::jsonb,
  'CONSÉQUENCE : chez Klary, cas documenté = licenciement immédiat + dépôt de plainte pénale pour gestion déloyale (art. 158 CP, jusqu''à 3 ans de prison). Sanction lourde car atteinte directe à l''activité commerciale de l''entreprise.',
  TRUE
),
(
  'maladie', 'K006', 'Règlement Klary — Démission volontaire', 'single',
  'Vous démissionnez de Klary avec préavis normal. Sur vos affaires en cours (dossiers signés dans les 3 derniers mois), les commissions à venir sont :',
  '["Payées intégralement — droit acquis à la commission", "Payées seulement si vous restez jusqu''à la date effective du départ, ensuite Klary conserve les commissions récurrentes qui financent le suivi client par un autre agent", "Perdues immédiatement à la démission", "Payées à 50 %"]'::jsonb,
  1,
  'Modèle standard courtage : commission initiale = payée si toujours en poste à la date d''échéance mensuelle. Commissions récurrentes (renouvellements annuels, taux LPP...) = restent chez Klary après votre départ car elles rémunèrent le SUIVI du client, pas la vente initiale. Un autre agent reprend le portefeuille et perçoit les récurrentes futures.',
  '["FAUX — la commission n''est pas un droit acquis, elle rémunère un travail contractuel en cours (le suivi). Sans travail, pas de récurrent.", null, "FAUX — les commissions déjà échues avant le départ sont payées normalement. Ce qui n''est pas payé, ce sont les futures.", "Aucun mécanisme 50 % dans le contrat Klary. Soit due, soit pas due."]'::jsonb,
  'CONSÉQUENCE d''une mauvaise compréhension : agent qui démissionne pensant emporter ses commissions récurrentes → conflit financier + procédure prud''homale (perdue) + relations personnelles détruites. Lire son contrat AVANT de démissionner, pas après.',
  TRUE
),
(
  'maladie', 'K007', 'Règlement Klary — Licenciement pour faute grave', 'single',
  'Vous êtes licencié·e pour faute grave (partage d''accès compagnie confirmé par audit). Vos commissions non encore versées sur affaires signées le mois précédent :',
  '["Sont payées intégralement, protégées par le CO", "Peuvent être retenues à titre de compensation avec les dommages-intérêts que Klary est en droit de réclamer (perte de mandat compagnie, préjudice réputationnel)", "Sont payées après recours prud''homal obligatoire", "Sont automatiquement doublées à titre de solde de tout compte"]'::jsonb,
  1,
  'Art. 337c CO + jurisprudence : licenciement pour faute grave = pas d''indemnité de préavis, pas de délai. Klary peut opposer par compensation ses créances contre vous (art. 120 CO) si dommages-intérêts fondés. Perte d''un mandat compagnie = préjudice chiffrable en dizaines de milliers de CHF. Vos commissions en attente peuvent être retenues jusqu''à concurrence.',
  '["FAUX — les commissions ne sont pas un salaire ordinaire protégé absolument. Elles peuvent être compensées avec des créances valides.", null, "FAUX — pas d''obligation de recours prud''homal préalable pour compenser.", "Aucun mécanisme légal ne double des commissions en cas de faute grave. C''est l''inverse."]'::jsonb,
  'CONSÉQUENCE réelle : partage d''un mot de passe = perte de 3-6 mois de commissions retenues + potentielle condamnation civile à 10-50k CHF de dommages-intérêts + fiche mauvaise foi qui suit sur le marché suisse du courtage. Un seul acte de faute grave peut détruire une carrière.',
  TRUE
),
(
  'maladie', 'K008', 'Règlement Klary — Écrans & poste de travail', 'single',
  'Vous quittez votre poste 5 minutes pour aller aux toilettes. Votre écran affiche le dossier LAMal d''un client. Vous devez :',
  '["Rien de spécial, la porte du bureau est fermée", "Verrouiller votre session (Win+L / Ctrl+Cmd+Q sur Mac) systématiquement, quelle que soit la durée d''absence", "Éteindre l''écran uniquement", "Retourner votre écran vers le mur"]'::jsonb,
  1,
  'Directive nLPD et règlement Klary : verrouillage session obligatoire dès qu''on quitte la vue directe de son écran, même pour 30 secondes. Un collègue, un livreur, un candidat en attente entrant dans le bureau ne doit jamais voir un dossier client à l''écran. C''est un réflexe non négociable.',
  '["Faux — la porte peut s''ouvrir à tout moment. Le verrouillage est la seule protection réelle.", null, "Éteindre l''écran n''éteint pas la session : quelqu''un peut le rallumer sans mot de passe.", "Retourner l''écran ne cache pas les données du système. Verrouillage = seule mesure conforme nLPD."]'::jsonb,
  'CONSÉQUENCE : un audit ou une simple visite client qui voit des données d''un tiers à l''écran = incident nLPD à déclarer au PFPDT + avertissement Klary. Récidive = licenciement. Réflexe à installer dès le 1er jour.',
  TRUE
),
(
  'maladie', 'K009', 'Règlement Klary — Phishing', 'single',
  'Vous recevez un email urgent semblant venir de la direction : "Envoie-moi la liste des clients actifs avec numéros AVS, on a un audit fiscal ce matin — répondre en direct à mon adresse mobile" (avec un nom d''expéditeur légitime mais une adresse email inhabituelle). Vous :',
  '["Vous répondez immédiatement, c''est urgent", "Vous appelez la direction sur le numéro connu pour vérifier avant tout envoi, et vous ne cliquez sur aucun lien de l''email", "Vous transférez à un collègue qui saura répondre", "Vous répondez en demandant plus de contexte par email"]'::jsonb,
  1,
  'Classique phishing ciblé (spear-phishing) : urgence + autorité + demande de données sensibles + adresse expéditeur discrètement différente. La règle immuable : validation OUT-OF-BAND (téléphone connu, en présentiel) avant toute action. L''urgence est un levier de pression standard des attaquants.',
  '["Faute nLPD grave. Fuite massive de données AVS = déclaration obligatoire PFPDT + amende jusqu''à 250k CHF pour l''entreprise.", null, "Transférer propage l''attaque à un collègue. Aggrave le risque au lieu de le contenir.", "Répondre par email valide indirectement la relation avec l''attaquant. Il enchaînera avec plus de pression."]'::jsonb,
  'CONSÉQUENCE si fuite : (1) Klary doit déclarer au PFPDT sous 72h — amende jusqu''à 250 000 CHF. (2) Sanction interne agent : avertissement écrit minimum, licenciement possible si négligence grossière. (3) Les clients touchés peuvent poursuivre en dommages-intérêts individuellement.',
  TRUE
),
(
  'maladie', 'K010', 'Règlement Klary — Enregistrement RDV', 'single',
  'Un client vous demande de ne PAS enregistrer votre entretien conseil dans le CRM Klary "parce qu''il préfère un contact direct avec vous personnellement". Vous :',
  '["Vous acceptez, c''est son choix", "Vous refusez et expliquez que chaque conseil DOIT être tracé au CRM (obligation FINMA + protection agent + protection client). Si le client insiste, vous cessez le conseil et informez la direction.", "Vous enregistrez à moitié pour compromis", "Vous notez à part sur un fichier perso"]'::jsonb,
  1,
  'Directive FINMA VBI + règlement interne Klary : toute interaction conseil doit être tracée (PV de conseil ou note CRM datée). Objectif : audit compagnie, protection du client, protection de l''agent en cas de litige. Un client qui refuse la traçabilité est un signal d''alerte (blanchiment, fraude, ou piège juridique).',
  '["Faute grave. La non-traçabilité expose Klary à sanction FINMA et vous prive de preuve en cas de litige.", null, "Traçage partiel = piège. En cas d''audit, la trace incomplète est PIRE que l''absence de trace (mauvaise foi manifeste).", "Fichier perso = données clients hors du système sécurisé Klary = faute nLPD. Effet inverse du but recherché."]'::jsonb,
  'CONSÉQUENCE si un client sans trace vous poursuit plus tard pour défaut de conseil : vous n''avez AUCUNE preuve de ce qui a été dit. Le client gagne quasi automatiquement. Le CRM est votre bouclier. Sans lui, vous êtes exposé personnellement.',
  TRUE
),
(
  'maladie', 'K011', 'Règlement Klary — Cadeaux clients', 'single',
  'Un client, satisfait, vous offre un chèque personnel de 500 CHF en remerciement d''un bon conseil. Vous :',
  '["Vous acceptez, c''est de bon cœur", "Vous refusez poliment, expliquez que la commission est déjà votre rémunération et que tout autre versement direct est proscrit par le règlement Klary et la directive FINMA sur les avantages", "Vous acceptez et le déclarez à Klary", "Vous acceptez et redistribuez à un collègue"]'::jsonb,
  1,
  'Directive FINMA sur les avantages + règlement interne Klary : interdiction d''accepter tout avantage financier direct de la part d''un client. Objectifs : (1) éviter le conflit d''intérêt, (2) préserver l''image professionnelle, (3) protéger l''agent contre l''accusation de captation. Refuser courtoisement est la seule voie propre.',
  '["Faute grave — création d''un conflit d''intérêt et rupture du principe de rémunération unique par commission.", null, "Déclarer ne régularise pas. Un cadeau accepté puis déclaré reste un cadeau accepté. C''est le principe qui est en cause.", "Redistribuer répand la faute au lieu de la corriger. Aggravant."]'::jsonb,
  'CONSÉQUENCE : audit FINMA découvre paiement direct client → sanction Klary + potentielle radiation temporaire de l''agent du registre des intermédiaires. Pour 500 CHF de gain immédiat, on risque sa carrière entière.',
  TRUE
),
(
  'maladie', 'K012', 'Règlement Klary — Réseaux sociaux', 'single',
  'Vous êtes agent Klary. Sur votre profil LinkedIn perso, vous postez : "Encore un contrat 3e pilier signé aujourd''hui chez Zurich, super produit ! #assurance #Suisse" avec une capture d''écran floutée du CRM. Cette pratique est :',
  '["Autorisée si vous floutez les données", "Interdite — divulgation implicite (statut client, compagnie choisie) + usage d''un visuel CRM externe à Klary + risque nLPD même flouté (métadonnées, contexte)", "Autorisée si vous prévenez le client", "Autorisée sur Instagram mais pas LinkedIn"]'::jsonb,
  1,
  'Le partage d''une capture d''écran CRM sur réseau social — même flouté — viole simultanément : secret professionnel (existence d''une transaction avec cette compagnie), règlement Klary (usage matériel interne à l''externe), nLPD (métadonnées d''image contiennent souvent l''URL et l''ID de session). Le "flou" ne suffit jamais légalement.',
  '["Le floutage est facilement contournable et ne supprime pas la trace de transaction. Pas une défense valide.", null, "Le client ne peut pas consentir à une pratique qui viole aussi le règlement interne et le secret vis-à-vis des tiers.", "Le réseau ne change rien à la nature de la fuite d''information."]'::jsonb,
  'CONSÉQUENCE : signalement possible par un concurrent ou un client sensible = sanction interne Klary (avertissement écrit) + retrait du contenu + risque compagnie (Zurich peut se plaindre de la mention non autorisée de son nom). Communication commerciale = passe par la direction, jamais en solo.',
  TRUE
),

-- ───────── CAS TRANSVERSAUX MIXTES ─────────

(
  'maladie', 'M047', 'Étude de cas — Renoncement soins', 'single',
  'Client 58 ans, franchise 2500 depuis 5 ans. Il vous confie : "J''ai des douleurs thoraciques depuis 2 semaines mais j''attends janvier pour consulter, ça évitera la franchise." Votre réaction professionnelle immédiate ?',
  '["Vous validez son raisonnement économique", "Vous rappelez fermement qu''une douleur thoracique persistante peut être un signe cardiaque grave (infarctus) et qu''AUCUNE économie ne justifie de reporter — c''est une urgence vitale, la franchise n''est pas un critère médical", "Vous lui conseillez d''appeler d''abord son médecin par téléphone gratuitement", "Vous lui dites que c''est son choix personnel"]'::jsonb,
  1,
  'Devoir moral et légal d''alerte du conseiller. Une douleur thoracique persistante = urgence cardiaque potentielle. Reporter pour économie financière = mise en danger de sa vie. L''agent qui valide un tel report peut être poursuivi civilement pour manquement au devoir d''information et d''alerte en cas de drame.',
  '["Faute morale grave — validation d''un renoncement aux soins pour raison purement financière face à une urgence vitale.", null, "Le téléphone médical peut être une étape, mais l''alerte doit être IMMÉDIATE : consultez, allez aux urgences, ne partez pas d''ici sans en avoir parlé.", "Le libre choix ne s''applique pas face à une urgence vitale manifeste. Il faut alerter."]'::jsonb,
  'CONSÉQUENCE si infarctus dans les jours suivants et famille apprend que le conseiller n''a rien dit : poursuite civile pour manquement au devoir de conseil et d''alerte + mise en cause pénale possible (art. 128 CP omission de prêter secours). Cas rare mais existant. Une bonne assurance, c''est aussi rappeler que la santé prime sur l''argent.',
  TRUE
)

ON CONFLICT DO NOTHING;

-- Ajuste retry_cooldown_hours = 24 pour Maladie
UPDATE training_modules
SET retry_cooldown_hours = 24
WHERE key = 'maladie';
