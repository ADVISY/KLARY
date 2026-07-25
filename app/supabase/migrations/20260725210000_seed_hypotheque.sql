-- ═════════════════════════════════════════════════════════
-- Klary — Seed Module Hypothèque
--   • Fondamentaux financement immobilier Suisse
--   • Taux fixe vs SARON, arbitrages
--   • Amortissement direct vs indirect
--   • Interaction hypothèque + LPP + 3a (EPL)
--   • Cas études clients
--   • Règlement Klary spécifique hypothèque
-- Cooldown : 24h après échec.
-- ═════════════════════════════════════════════════════════

UPDATE training_modules SET retry_cooldown_hours = 24 WHERE key = 'hypotheque';

INSERT INTO training_questions
  (module_key, external_id, category, question_type, question, options, correct, explanation, why_wrong, consequence, active) VALUES

('hypotheque','H001','Hypothèque — Bases','single',
$QK$Règle FINMA pour l'octroi d'une hypothèque en Suisse sur résidence principale : quel apport minimum du client (fonds propres) ?$QK$,
$QK$["10 % du prix d'achat", "20 % du prix d'achat, dont AU MOINS 10 % en fonds propres 'durs' (épargne, 3a, cash) hors LPP", "30 % du prix d'achat", "Aucun apport si bon score"]$QK$::jsonb,
1,
$QK$Directives d'autoréglementation ASB approuvées FINMA : 20 % du prix d'achat en fonds propres minimum, dont MINIMUM 10 % en fonds propres "durs" (hors LPP). Le retrait LPP peut compléter mais ne peut PAS constituer les 10 % durs. Objectif : protéger le système bancaire d'un emprunt sans peau dans le jeu.$QK$,
$QK$["FAUX — 10% total est insuffisant.", null, "FAUX — 30% n'est pas le minimum, c'est parfois exigé sur logements de vacances.", "FAUX — apport OBLIGATOIRE, pas optionnel."]$QK$::jsonb,
$QK$Erreur = client mal informé prépare un dossier avec 15% d'apport → refus banque → projet immo effondré à la dernière minute + perte confiance. Le courtier doit vérifier la structure de l'apport TÔT dans le processus.$QK$,
TRUE),

('hypotheque','H002','Hypothèque — Charges','single',
$QK$Règle des CHARGES THÉORIQUES en Suisse (calcul de faisabilité banque) ?$QK$,
$QK$["Les charges mensuelles réelles ne doivent pas dépasser 33 % du revenu", "Les charges THÉORIQUES annuelles (taux 5 % + amortissement + entretien 1 %) ne doivent pas dépasser 33 % du revenu brut annuel — même si les charges réelles sont bien plus basses avec taux SARON actuel", "Les charges réelles ne doivent pas dépasser 50 % du revenu", "Aucune règle de charge"]$QK$::jsonb,
1,
$QK$Règle des 33 % : la banque calcule les charges avec un taux THÉORIQUE de 5 % (pas le taux réel actuel) + 1 % de frais d'entretien du bien + amortissement (si obligatoire pour ramener le prêt à 2/3 du prix). Ces charges théoriques doivent être ≤ 33 % du revenu BRUT annuel. C'est un stress-test : le client doit tenir même si les taux remontent.$QK$,
$QK$["FAUX — c'est le calcul THÉORIQUE qui compte, pas le réel.", null, "FAUX — seuil de 33 %, pas 50 %.", "FAUX — règle FINMA/ASB stricte."]$QK$::jsonb,
$QK$Erreur = client à 70 000 CHF de revenu qui vise 1 M CHF d'immobilier avec SARON 1,5% actuel → il tient le réel mais les 33% théoriques explosent → refus. Devoir de conseil = SIMULER les charges théoriques AVANT d'aller voir la banque.$QK$,
TRUE),

('hypotheque','H003','Hypothèque — Taux fixe vs SARON','single',
$QK$Différence FONDAMENTALE entre hypothèque taux fixe et hypothèque SARON ?$QK$,
$QK$["Aucune différence", "Taux FIXE : bloqué pour une durée choisie (3-15 ans typiquement), prévisibilité totale mais pénalité de sortie anticipée lourde. SARON : indexé mensuellement sur SARON + marge banque, variable donc risque de hausse, mais sortie flexible sans pénalité.", "Taux fixe est toujours moins cher", "SARON est toujours moins cher"]$QK$::jsonb,
1,
$QK$Choix fondamental. FIXE : tranquillité, visibilité budget, mais coincé si on veut sortir tôt (pénalité = manque à gagner banque × années restantes). SARON : varie chaque mois selon le taux directeur BNS + marge banque, économique en période de taux bas, dangereux si taux montent (les charges réelles peuvent doubler en 12 mois).$QK$,
$QK$["FAUX — 2 mécaniques totalement différentes.", null, "FAUX — dépend du cycle des taux.", "FAUX — SARON était plus cher que le fixe pendant certaines périodes (2010-2020)."]$QK$::jsonb,
$QK$Erreur = pousser un client averse au risque en SARON pour "économiser" → taux montent → charges +30% en 12 mois → drame budgétaire. Devoir = analyser tolérance risque + capacité budgétaire à absorber hausses AVANT recommandation.$QK$,
TRUE),

('hypotheque','H004','Hypothèque — 1er/2e rang','single',
$QK$Comment fonctionne la division 1er rang / 2e rang de l'hypothèque en Suisse ?$QK$,
$QK$["Aucune division", "1er RANG = jusqu'à 65% du prix (financement stable, pas d'amortissement obligatoire) ; 2e RANG = de 65% à 80% du prix (amortissement OBLIGATOIRE sur 15 ans max ou jusqu'à 65 ans du client)", "1er rang c'est la banque principale, 2e rang c'est une 2e banque", "1er/2e rang concerne uniquement l'assurance"]$QK$::jsonb,
1,
$QK$Directives ASB : hypothèque au-delà de 65% du prix doit être AMORTIE dans les 15 ans (ou avant 65 ans). Cette partie 65-80% = "2e rang", à taux souvent supérieur. Objectif : réduire le risque bancaire. Amortissement possible DIRECT (mensualités qui remboursent le capital) ou INDIRECT (versements 3a nantissement qui remboursent à l'échéance).$QK$,
$QK$["FAUX — division standard et importante à comprendre.", null, "FAUX — c'est la structure du prêt, pas 2 banques différentes.", "FAUX — c'est bancaire, pas assurance."]$QK$::jsonb,
$QK$Erreur = ne pas expliquer l'amortissement obligatoire du 2e rang → client mal préparé aux charges d'amortissement → conflit banque. Point CRITIQUE dans toute simulation de charges.$QK$,
TRUE),

('hypotheque','H005','Hypothèque — Amortissement direct vs indirect','single',
$QK$Différence entre AMORTISSEMENT DIRECT et INDIRECT du 2e rang ?$QK$,
$QK$["Aucune différence", "DIRECT : remboursement mensuel du capital → dette diminue chaque mois → intérêts baissent progressivement, mais fiscalité moins avantageuse (moins de déduction d'intérêts). INDIRECT : versement mensuel sur 3a nanti à la banque → dette reste stable pendant 15 ans, dette remboursée à l'échéance par le 3a, MAIS déduction fiscale MAXIMISÉE + capital 3a fructifie", "Direct est moins cher fiscalement", "Indirect est réservé aux jeunes"]$QK$::jsonb,
1,
$QK$Choix fiscal MAJEUR. Amortissement INDIRECT (3a nantissement) est presque toujours plus avantageux fiscalement pour un contribuable ayant un taux marginal élevé (>25%) : (1) intérêts hypothécaires déductibles sur la dette totale non amortie, (2) versements 3a déductibles à 100% du revenu, (3) capital 3a génère des intérêts. Direct = simplicité mais perte fiscale.$QK$,
$QK$["FAUX — mécaniques et impacts fiscaux totalement différents.", null, "FAUX — c'est l'inverse : indirect gagne fiscalement.", "FAUX — indirect ouvert à tous."]$QK$::jsonb,
$QK$Erreur = laisser un client haut revenu sur amortissement direct → il perd 2-4k CHF/an d'impôt vs amortissement indirect. Sur 15 ans = 30-60k CHF de perte fiscale évitable. Défaut de conseil identifiable a posteriori.$QK$,
TRUE),

('hypotheque','H006','Hypothèque — Retrait EPL','single',
$QK$Combiner retrait EPL 2e pilier (LPP) + 3a EPL + fonds propres épargne, quelle est la limite ?$QK$,
$QK$["Aucune limite globale", "Le retrait LPP EPL ne peut PAS constituer les 10 % de fonds propres 'durs' obligatoires (règles FINMA/ASB) — le 3a lui peut le faire", "Uniquement 100 000 CHF max", "Les 3 sources sont totalement interchangeables"]$QK$::jsonb,
1,
$QK$Point crucial FINMA : les 10% de fonds propres "durs" doivent provenir de sources HORS 2ᵉ pilier (LPP). Ils peuvent venir de : épargne cash, titres, donations, héritages, retrait 3a. Le retrait LPP EPL peut compléter les 10% supplémentaires (pour atteindre 20% total) mais NE PEUT PAS constituer les 10% "durs". Souvent mal compris par les clients.$QK$,
$QK$["FAUX — règle stricte des fonds propres durs.", null, "FAUX — pas de plafond fixe global.", "FAUX — les 3 sources ne sont pas fongibles."]$QK$::jsonb,
$QK$Erreur = laisser un client faire 100% de son apport en LPP EPL → refus banque à la dernière minute → drame immobilier. Le courtier hypothèque doit vérifier la STRUCTURE de l'apport DÈS le premier RDV client.$QK$,
TRUE),

('hypotheque','H007','Hypothèque — Renouvellement','single',
$QK$Un client Klary a une hypothèque taux fixe 10 ans arrivant à échéance dans 6 mois. Quand doit-il commencer à négocier son renouvellement ?$QK$,
$QK$["1 mois avant échéance suffit", "12-18 mois avant échéance idéalement — pour comparer plusieurs banques + potentiellement bloquer un taux à terme (forward rate) si les taux montent", "Le jour de l'échéance uniquement", "Après l'échéance seulement"]$QK$::jsonb,
1,
$QK$Négociation renouvellement = 12-18 mois avant échéance idéal. Permet : (1) démarcher plusieurs banques (concurrence = économie 20-50 pb sur le taux), (2) souscrire un "forward" bloquant le taux futur si les marchés montent, (3) réviser la structure globale (LPP amortissement, 3a nantissement…). C'est LE moment de la VRAIE valeur ajoutée du courtier hypothèque.$QK$,
$QK$["Faux — 1 mois = pas de temps pour concurrence.", null, "Trop tard — client se fait imposer le renouvellement chez la banque actuelle sans négociation.", "Absurde — laisserait le client en taux variable non-négocié."]$QK$::jsonb,
$QK$Erreur = négliger le renouvellement à temps → client renouvelle par défaut chez sa banque à un taux non-négocié 30-50 pb au-dessus du marché → perte annuelle 500-1500 CHF selon montant. Sur 10 ans = 5-15k CHF de perte évitable.$QK$,
TRUE),

('hypotheque','H008','Hypothèque — Résiliation','single',
$QK$Un client vend son bien 3 ans avant l'échéance de son hypothèque taux fixe 10 ans (7 ans restants). La banque exige une pénalité de sortie anticipée. Sur quelle base est-elle calculée ?$QK$,
$QK$["Aucune pénalité", "Manque à gagner banque = (taux hypothèque − taux placement de la banque à durée résiduelle) × capital restant × années restantes. Facilement 30-80 000 CHF sur un prêt 500k restant.", "Uniquement 1 % du capital", "1 mois d'intérêts"]$QK$::jsonb,
1,
$QK$Pénalité de résiliation anticipée = compensation du manque à gagner banque. Formule : (taux contrat − taux marché résiduel) × capital × années restantes. Sur un prêt 500 000 CHF avec écart 1,5 % et 7 ans restants ≈ 52 500 CHF de pénalité. Point CRITIQUE à connaître : le client vendeur DOIT être averti AVANT de signer un compromis de vente.$QK$,
$QK$["FAUX — pénalité importante.", null, "FAUX — pas 1% forfaitaire, calcul économique complexe.", "FAUX — bien supérieur à 1 mois."]$QK$::jsonb,
$QK$Erreur = ne pas alerter le client vendeur sur cette pénalité → il signe le compromis de vente → découvre la pénalité → conflit majeur avec banque + vendeur. Cas fréquent de plaintes conseil courtier hypothèque.$QK$,
TRUE),

('hypotheque','H009','Hypothèque — Étude de cas','case_study',
$QK$CAS : Sophie et Marc (35 et 33 ans, couple, revenus combinés 220k CHF/an) achètent une villa 1,2 M CHF à Prangins. Apport disponible : 80k cash + 45k 3a + 180k LPP + un héritage 60k à venir. Est-ce que le dossier passe FINMA/ASB ?$QK$,
$QK$["Oui, largement", "PIÈGE — l'apport TOTAL est 365k (30% du prix) mais le calcul des fonds propres DURS exclut la LPP. Fonds durs = 80+45+60 = 185k = 15,4% du prix — SUPÉRIEUR aux 10% requis ✓ + apport total 30% > 20% requis ✓ = OUI ça passe. Confirmer les charges 33% aussi.", "Non, apport insuffisant", "Oui si SARON uniquement"]$QK$::jsonb,
1,
$QK$Analyse pas à pas : (1) Prix 1,2M → apport minimum 20% = 240k. (2) Fonds durs minimum 10% = 120k. (3) Apport réel = 365k > 240k ✓. (4) Fonds durs (épargne + 3a + héritage) = 185k > 120k ✓. (5) Charges théoriques à vérifier : hypothèque 835k × 5% + entretien 12k + amortissement (2e rang 55k / 15 ans ≈ 3,7k) ≈ 57k/an → sur 220k revenu = 26% ✓ (< 33%). Dossier VALIDE. Point subtil : sans LPP, les fonds durs seuls (185k) suffisent → on peut GARDER la LPP intacte pour la retraite, choix stratégique intéressant.$QK$,
$QK$["Faux — le client aurait pu accepter sans validation FINMA, refus tardif.", null, "Faux — apport suffisant avec bonne structure.", "Faux — le SARON ne change pas la question de l'apport."]$QK$::jsonb,
$QK$Erreur = ne pas SIMULER précisément avant de valider oralement au client → il compromet la vente → banque refuse in fine → drame. Le courtier hypothèque doit faire la simulation FINMA/ASB PROPRE dès le 1er RDV.$QK$,
TRUE),

('hypotheque','H010','Hypothèque — Étude de cas','single',
$QK$SUITE CAS Sophie & Marc : ils veulent optimiser fiscalement. Amortissement direct ou indirect (via 3a nanti) sur le 2e rang de 55k CHF ?$QK$,
$QK$["Direct — plus simple", "INDIRECT (via 3a nanti) — leurs revenus combinés 220k CHF les placent à un taux marginal élevé (35-40%). Le 3a versement 7 056 × 2 = 14 112 CHF/an déductible génère ≈ 5 000 CHF d'économie fiscale annuelle. Sur 15 ans amortissement = 75 000 CHF d'économie fiscale + intérêts capitalisés 3a", "Aucune importance", "Direct pour lui, indirect pour elle"]$QK$::jsonb,
1,
$QK$Cas idéal pour amortissement INDIRECT via 3a nantissement : couple double revenu haut, marginal élevé, capacité à discipliner l'épargne 3a. Le calcul montre 75k CHF d'économie fiscale sur la durée de l'amortissement + le capital 3a génère 15 ans d'intérêts vs 0 avec direct. Sans compter que la dette hypothécaire reste intégralement déductible.$QK$,
$QK$["Simplification qui coûte cher — perte fiscale identifiable.", null, "Faux — impact fiscal massif.", "Complication inutile — les 2 conjoints peuvent chacun avoir un 3a nanti."]$QK$::jsonb,
$QK$Erreur = laisser un couple haut revenu sur amortissement direct = 75k CHF perdus sur 15 ans. Le courtier hypothèque compétent PROPOSE systématiquement l'analyse fiscale amortissement direct/indirect.$QK$,
TRUE),

-- ───────── RÈGLEMENT KLARY HYPOTHÈQUE ─────────

('hypotheque','KH01','Règlement Klary — Hypothèque devoir renforcé','single',
$QK$L'hypothèque est un engagement 15-25 ans du client, en jeu 500k-2M+ CHF. Devoirs SPÉCIFIQUES du courtier hypothèque Klary ?$QK$,
$QK$["Aucun devoir spécifique", "Analyse budget + fiscalité + risque taux ; simulation stress test à 5% de taux ; comparaison MULTI-BANQUES obligatoire (au moins 3 offres) ; explication écrite des risques ; PV de conseil détaillé + tableau charges 30 ans", "Uniquement obtenir la meilleure offre", "Uniquement la simulation"]$QK$::jsonb,
1,
$QK$Devoirs cumulatifs. Le point CRITIQUE : la comparaison MULTI-BANQUES est une valeur ajoutée majeure du courtier — un client qui négocie seul obtient rarement le meilleur taux. Le courtier obtient 30-60 pb d'écart favorable en moyenne. Sur 1M CHF sur 10 ans = 30-60k CHF d'économie CHIFFRABLE pour le client.$QK$,
$QK$["Faute — l'hypothèque est le produit avec le PLUS lourd devoir de conseil.", null, "Insuffisant — devoir de conseil > obtention du meilleur taux.", "Insuffisant — la simulation seule ne remplace pas l'analyse complète."]$QK$::jsonb,
$QK$CONSÉQUENCE si simulation stress test 5% pas faite : client accepte un prêt qu'il ne peut pas tenir en cas de hausse taux → défaut de paiement 3-5 ans plus tard → vente forcée + poursuite contre courtier pour manquement au devoir d'avertissement. Cas grave.$QK$,
TRUE),

('hypotheque','KH02','Règlement Klary — Rétrocessions','single',
$QK$Une banque X propose à Klary une rétrocession de 0,5 % du montant du prêt pour chaque hypothèque placée. Sur un prêt 800k, Klary touche 4 000 CHF. Ce mécanisme est-il conforme ?$QK$,
$QK$["Oui, personne n'en parle", "Conforme UNIQUEMENT si transparence totale : (1) le client est informé PAR ÉCRIT AVANT signature du montant et de la nature de la rétrocession, (2) il donne son consentement écrit, (3) la rétrocession figure au PV de conseil. Sinon = rétrocessions cachées, interdites (Arrêt TF 2006 + jurisprudence).", "Interdit dans tous les cas", "Autorisé sans conditions"]$QK$::jsonb,
1,
$QK$Arrêt Tribunal fédéral 2006 (BGE 132 III 460) sur les rétrocessions cachées : depuis 20 ans, toute rétrocession bancaire/assurance versée au courtier doit être TRANSPARENTE et objet d'un consentement éclairé du client. Sans transparence + consentement écrit → le client peut RÉCLAMER la restitution de la rétrocession + intérêts. Application stricte à toutes les hypothèques et 3a assurance.$QK$,
$QK$["Faute majeure + risque de restitution.", null, "Faux — autorisé si transparence.", "Faux — encadrement légal strict."]$QK$::jsonb,
$QK$CONSÉQUENCE : audit 5 ans plus tard, le client apprend l'existence de rétrocessions cachées → poursuite civile → Klary condamnée à restituer TOUTES les rétrocessions perçues (parfois plusieurs 10 000 CHF) + dommages-intérêts. Cas très surveillé.$QK$,
TRUE),

('hypotheque','KH03','Règlement Klary — Coordination banque/client','single',
$QK$En cours de dossier hypothèque, la banque appelle le courtier pour "arranger le taux à la hausse à cause d'un point technique". Client pas au courant. Que faites-vous ?$QK$,
$QK$["J'accepte pour boucler le dossier", "REFUSE catégoriquement toute modification unilatérale — j'informe immédiatement le client par écrit, on discute ensemble de la contre-proposition, puis on décide en connaissance de cause d'accepter, négocier ou aller voir la concurrence", "J'accepte et j'informe le client après signature", "Je transmets au client sans commentaire"]$QK$::jsonb,
1,
$QK$Devoir de LOYAUTÉ du courtier envers son client (art. 400 CO — mandat). Toute modification défavorable au client doit être portée à sa connaissance IMMÉDIATEMENT avec analyse (justifiée ? négociable ? concurrence disponible ?). Accepter derrière son dos = trahir le mandat. Le courtier est le représentant du client, pas de la banque.$QK$,
$QK$["Faute grave — trahison de mandat.", null, "Faute grave — la temporalité de l'information est essentielle. Après signature = trop tard.", "Passivité qui ne remplit pas le devoir de conseil — le courtier doit ANALYSER + RECOMMANDER."]$QK$::jsonb,
$QK$CONSÉQUENCE : client mécontent découvre la modification acceptée par le courtier sans son accord → plainte pour trahison de mandat + réclame l'écart de taux sur 10 ans. Cas très perdant pour le courtier au civil.$QK$,
TRUE),

('hypotheque','KH04','Règlement Klary — Confidentialité financière','single',
$QK$Un client transmet ses relevés bancaires, avis d'imposition, décomptes salaires, contrat de travail pour son dossier hypothèque. Combien de temps Klary a le droit de les conserver ?$QK$,
$QK$["Indéfiniment", "Durée du mandat + 10 ans (obligation légale de conservation art. 962 CO + LSA) — après quoi destruction sécurisée obligatoire (nLPD). Pas de partage avec tiers hors banques traitantes du dossier.", "1 an maximum", "Aucune limite si consentement du client"]$QK$::jsonb,
1,
$QK$Documents financiers sensibles = catégorie renforcée nLPD. Conservation légale 10 ans (art. 962 CO + comptable) puis destruction sécurisée obligatoire. Partage limité aux banques traitant réellement le dossier + jamais à des tiers. Le CRM doit avoir des règles de purge automatiques.$QK$,
$QK$["Faux — nLPD limite la conservation à ce qui est nécessaire + délai légal max.", null, "Trop court — délai légal 10 ans.", "Faux — le consentement client ne peut pas contourner la nLPD."]$QK$::jsonb,
$QK$CONSÉQUENCE : audit PFPDT découvre des dossiers financiers de clients Klary conservés 15+ ans → sanction nLPD (amende jusqu'à 250k CHF par ETP responsable). Purge périodique = obligation Klary.$QK$,
TRUE),

('hypotheque','KH05','Règlement Klary — Post-vente hypothèque','single',
$QK$Un client Klary hypothèque signe son prêt et emménage. 3 ans plus tard, il vous appelle pour un conseil sur son 3a. Bonne pratique ?$QK$,
$QK$["Refuser — c'est une autre matière", "Répondre — le mandat courtage Klary est GLOBAL sur la vie financière du client. Analyser son besoin 3a, proposer une séance dédiée avec analyse besoin complète, PV signé. La rétention client se construit sur ces suivis long terme.", "Facturer une consultation supplémentaire", "Le rediriger vers une autre agence"]$QK$::jsonb,
1,
$QK$Modèle courtier Klary : le mandat n'est pas mono-produit. Le client hypothèque acquis est un client 3a/prévoyance/LPP potentiel. La bonne pratique = maintenir la relation ACTIVE post-signature avec des points annuels + réagir positivement aux sollicitations. C'est la clé de la rétention et de la valeur portefeuille long terme.$QK$,
$QK$["Faute commerciale + relationnelle — le client se sent abandonné.", null, "Aggravant — les conseils entre mandats devraient être gratuits.", "Perte de portefeuille — le concurrent capte le mandat."]$QK$::jsonb,
$QK$CONSÉQUENCE d'un refus : le client sent que Klary ne le considère plus, va voir la concurrence pour son 3a, puis son renouvellement hypothèque → portefeuille perdu. À l'inverse, un client bien suivi = mandats croisés durables + recommandations bouche à oreille.$QK$,
TRUE)

ON CONFLICT DO NOTHING;
