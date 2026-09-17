-- ═════════════════════════════════════════════════════════
-- Klary — Seed fiches AFA (cas d'oral prévoyance)
-- FICHIER GÉNÉRÉ — ne pas éditer à la main.
-- Source : src/content/afa/fiches/*.json
-- Régénérer : node scripts/afa/generate-fiches.mjs
-- ═════════════════════════════════════════════════════════

-- ───────── cas_oraux_lot1.json — 6 fiche(s) ─────────
INSERT INTO afa_fiches
  (filiere_key, theme_id, key, title, summary, content_md, sort_order, active)
SELECT 'vie', t.id, 'cas_deces_couple_2enfants', 'Cas d''oral : Décès prématuré (couple + 2 enfants)',
       'Cas d''examen oral VIE. Père de famille 42 ans, salaire brut 120 000 CHF, épouse 40 ans à 50 %, deux enfants 5 et 8 ans, hypothèque 700 000 CHF. Analyser la lacune décès et proposer une couverture complète.', '## Contexte client

### Profil
- Mathieu Rossier, 42 ans, cadre chez Swisscom (Bern), engagé depuis 12 ans.
- Marié à Sophie, 40 ans, infirmière au CHUV à 50 %, revenu brut 42 000 CHF.
- Deux enfants communs : Léa 8 ans (2e primaire), Nicolas 5 ans (école enfantine).
- Revenu brut de Mathieu : 120 000 CHF/an (13e mois compris), bonus moyen 8 000 CHF.
- Propriétaires depuis 2019 d''une maison individuelle à Prilly, valeur vénale 1 100 000 CHF, hypothèque cumulée 700 000 CHF (700 000 CHF en 1er rang chez Raiffeisen, dont 220 000 CHF amortis directement).
- Avoir LPP de Mathieu (Comm. Publica) : 285 000 CHF ; avoir LPP de Sophie : 68 000 CHF.
- 3a Mathieu : 42 000 CHF chez UBS ; 3a Sophie : 11 000 CHF chez PostFinance.
- Épargne libre commune : 55 000 CHF sur compte courant.
- Charges annuelles fixes du ménage : environ 96 000 CHF (intérêts hypothécaires, amortissement indirect, écolage, primes assurance, alimentation, loisirs).

### Question posée par le client
« Si je décède demain, ma famille peut-elle garder la maison et vivre normalement jusqu''à ce que les enfants soient indépendants ? Quel montant faut-il prévoir en assurance vie et comment structurer tout ça ? »

## Trame de présentation (20 min)

### 1. Introduction (2 min)
Bonjour Monsieur Rossier, merci pour votre confiance. Je me présente : intermédiaire d''assurance non lié, inscrit au registre FINMA, soumis à l''art. 45 LSA. Voici ma fiche d''information client, elle précise mon statut, les assureurs avec lesquels je collabore et le mode de rémunération. Je vous propose la structure suivante en quatre étapes : d''abord je récapitule votre situation familiale et patrimoniale, ensuite j''analyse les prestations légales AVS et LPP qui interviendraient en cas de décès, puis je chiffre la lacune de couverture et enfin je vous propose une solution concrète en assurance privée. J''aurai besoin d''environ vingt minutes, gardez vos questions pour la fin si possible, je note vos remarques au fur et à mesure.

### 2. Analyse (7 min)
Je vais maintenant chiffrer les prestations que Sophie et les enfants toucheraient en cas de décès de Mathieu aujourd''hui.

**1er pilier (AVS/AI) : art. 23 à 25 LAVS**
- Rente de veuve : Sophie a 40 ans, elle a deux enfants mineurs, donc les conditions de l''art. 23 LAVS sont remplies (enfants OU mariage supérieur à 5 ans et âge supérieur à 45 ans). Sur la base du revenu de Mathieu, la rente de veuve est plafonnée à 80 % de la rente maximale simple, soit environ 2 016 CHF/mois (24 192 CHF/an).
- Rente d''orphelin : 40 % de la rente simple par enfant, environ 1 008 CHF/mois par enfant, soit 12 096 CHF/an chacun.
- Plafonnement famille : le total des rentes est plafonné à 150 % de la rente vieillesse maximale (art. 35 LAVS), soit environ 3 780 CHF/mois au total.

**2e pilier (LPP) : art. 18 à 22 LPP**
- Rente de conjoint : 60 % de la rente d''invalidité projetée. Compte tenu d''un salaire assuré autour de 65 000 CHF et d''un taux de conversion à 6,8 %, la rente de conjoint LPP est estimée à 22 000 CHF/an.
- Rente d''orphelin LPP : 20 % de la rente d''invalidité projetée par enfant, soit environ 7 300 CHF/an chacun.
- Capital-décès complémentaire selon règlement Publica : le règlement prévoit un capital supplémentaire égal à 100 % de l''avoir de vieillesse projeté (à vérifier au règlement de caisse, art. 20a LPP).

**Lacune décès chiffrée (année civile complète, prestations brutes) :**

| Poste | Montant CHF |
|---|---|
| Besoin annuel du ménage (charges de vie + hypothèque) | 96 000 |
| Rente AVS de veuve (plafonnée) | 24 192 |
| Rentes AVS d''orphelin (2 × 12 096) | 24 192 |
| Rente LPP de conjoint | 22 000 |
| Rentes LPP d''orphelin (2 × 7 300) | 14 600 |
| Salaire net résiduel de Sophie | 32 000 |
| Total prestations disponibles | 116 984 |
| Excédent apparent (avant hypothèque) | +20 984 |

Attention : ce bilan apparent est trompeur. Il ne tient pas compte de trois éléments :
- le remboursement partiel de l''hypothèque exigé par la banque en cas de perte du revenu principal (règle du 33 % de charge maximale) ;
- la disparition des rentes d''orphelin à 18 ans (25 ans si études) et des rentes de veuve dès que le cadet a 18 ans ;
- la fiscalité (les rentes AVS et LPP sont imposables à 100 % comme revenu, art. 22 LIFD).

La vraie lacune concerne le capital nécessaire à l''amortissement de l''hypothèque (viser un LTV de 65 % pour rester dans les critères de tenue) : environ 350 000 CHF à rembourser d''un coup.

### 3. Solutions (8 min)
Passons aux solutions. Je propose une architecture en trois briques.

**Brique 1 : Temporaire décès pure (risque, capital constant)**
- Capital : 500 000 CHF sur la tête de Mathieu.
- Durée : 20 ans (jusqu''aux 62 ans de Mathieu, quand Nicolas aura 25 ans).
- Bénéficiaire : Sophie, avec ordre subsidiaire enfants par parts égales (clause bénéficiaire nominative art. 76 à 78 LCA, insaisissable art. 79 LCA).
- Prime indicative : environ 780 CHF/an pour un non-fumeur en bonne santé, tarif classique chez Helvetia ou Swiss Life.
- Justification : couvre le remboursement partiel de l''hypothèque (350 000 CHF) et laisse une marge de 150 000 CHF pour absorber la baisse progressive des rentes d''orphelin.

**Brique 2 : Temporaire décès sur la tête de Sophie**
- Capital : 200 000 CHF sur 20 ans.
- Justification : si Sophie décède, Mathieu doit financer la garde et la logistique (frais d''accueil, femme de ménage, baisse de son propre taux) et l''AVS ne prévoit pas de rente de veuf tant que les enfants ne sont pas majeurs si les autres conditions ne sont pas remplies. Prime indicative environ 320 CHF/an.

**Brique 3 : Optimisation prévoyance 3a**
- Ouvrir un 3a bancaire chez PostFinance ou Frankly pour Mathieu, verser le plafond de 7 258 CHF/an (art. 7 al. 1 let. a OPP3).
- Sophie peut aussi verser jusqu''à 7 258 CHF/an puisqu''elle est affiliée LPP.
- Économie fiscale annuelle du couple : environ 3 500 CHF (taux marginal cumulé autour de 24 %).
- Bénéficiaires imposés art. 2 OPP3 : conjoint, puis descendants directs, puis parents à charge, etc. L''ordre est impératif, on ne peut modifier qu''à l''intérieur d''un rang.

Je recommande contre une assurance vie mixte pour cette famille : les primes seraient trop élevées, la souplesse est insuffisante et le TIR net est faible comparé à un 3a bancaire investi en fonds.

### 4. Conclusion (3 min)
En résumé, je vous propose une couverture décès de 700 000 CHF au total pour 1 100 CHF/an, l''ouverture de deux 3a plafonnés et un examen du règlement Publica pour vérifier le capital-décès additionnel. Je vous remets : la fiche d''information client art. 45 LSA, un comparatif chiffré Helvetia/Swiss Life/Bâloise, un questionnaire de santé à remplir avec soin (attention à la réticence art. 6 LCA), et le récapitulatif fiscal des primes déductibles. Prochaine étape : je reviens vers vous dans 10 jours avec les propositions fermes et les délais de couverture provisoire.

## Questions d''experts type (jury) + réponses modèles

### 1. Question : Sophie touche-t-elle la rente de veuve AVS si elle n''a pas d''enfant à charge ?
**Réponse modèle** : Non, sans enfant elle devrait remplir cumulativement deux conditions : avoir plus de 45 ans révolus au moment du décès et avoir été mariée pendant au moins 5 ans. Ici elle a 40 ans, donc sans les deux enfants elle n''aurait droit qu''à une indemnité unique équivalent à 3 rentes annuelles.
**Ref légale** : art. 24 LAVS.

### 2. Question : Que se passe-t-il si Mathieu décède d''un accident et non d''une maladie ?
**Réponse modèle** : L''accident déclenche la couverture LAA. Sophie toucherait une rente de veuve LAA de 40 % du gain assuré et chaque enfant une rente d''orphelin de 15 %, plafonné à 70 % du gain assuré cumulé. Ces prestations sont coordonnées avec les rentes AVS et LPP : le total ne peut excéder 90 % du gain assuré présumé perdu.
**Ref légale** : art. 28 à 32 LAA, art. 20 al. 2 LAA pour la coordination.

### 3. Question : Le capital de la temporaire décès entre-t-il dans la succession ?
**Réponse modèle** : Non, dès lors que Sophie est désignée comme bénéficiaire nominative, le capital lui est versé directement hors succession en vertu de l''art. 78 LCA. Il est insaisissable pour les créanciers de la succession. Attention toutefois : les héritiers réservataires peuvent demander la réduction si le capital porte atteinte à leur réserve.
**Ref légale** : art. 76 à 79 LCA, art. 476 CC (droit successoral révisé 2023).

### 4. Question : Quelle est la part réservataire des enfants depuis la révision 2023 du droit successoral ?
**Réponse modèle** : Depuis le 1er janvier 2023, la réserve des descendants est passée de 3/4 à 1/2 de leur part légale. Le conjoint garde une réserve de 1/2 de sa part légale. La quotité disponible est donc plus large, ce qui permet mieux d''avantager le conjoint par testament.
**Ref légale** : art. 471 CC.

### 5. Question : L''hypothèque doit-elle être obligatoirement remboursée en cas de décès ?
**Réponse modèle** : Non, il n''y a pas d''obligation légale de remboursement. Mais la banque va réévaluer la tenue économique : les charges théoriques (intérêts calculés à 4,5 %, amortissement et entretien) ne doivent pas dépasser un tiers du revenu du ménage. Si Sophie ne tient plus ce ratio, la banque peut exiger un amortissement extraordinaire, voire dénoncer le prêt.
**Ref légale** : pratique FINMA, autorégulation ASB.

### 6. Question : Pourquoi une temporaire décès plutôt qu''une mixte capitalisation ?
**Réponse modèle** : La temporaire décès offre le meilleur rapport capital assuré/prime parce qu''elle ne comporte aucune composante d''épargne. Pour Mathieu, 500 000 CHF coûtent environ 780 CHF/an, alors qu''une mixte pour le même capital dépasserait 6 000 CHF/an. La couche épargne est plus efficace via un 3a bancaire investi en fonds, séparée du risque pur.
**Ref légale** : hors norme, pratique de conseil.

### 7. Question : Le 3a de Mathieu peut-il désigner l''ex-compagne comme bénéficiaire ?
**Réponse modèle** : Non. L''ordre des bénéficiaires 3a est impératif : d''abord le conjoint, puis les descendants directs et éventuellement le concubin ayant fait ménage commun 5 ans. On ne peut modifier l''ordre qu''à l''intérieur d''un rang, pas pour évincer le conjoint.
**Ref légale** : art. 2 OPP3.

### 8. Question : Si Sophie renonce à sa quotité successorale, le capital-décès LPP est-il concerné ?
**Réponse modèle** : Non, le capital-décès LPP est versé selon l''ordre des bénéficiaires prévu à l''art. 20a LPP et par le règlement de la caisse. Il ne tombe pas dans la masse successorale et n''est donc pas affecté par une renonciation à la succession.
**Ref légale** : art. 20a LPP.

### 9. Question : Quels documents Mathieu doit-il joindre au questionnaire de santé ?
**Réponse modèle** : Le questionnaire lui-même complété et signé, la copie du passeport, et selon les capitaux demandés (au-delà de 400 000 CHF), un examen médical, un ECG au repos et une prise de sang. L''assureur peut aussi exiger le dernier rapport médecin traitant. Attention à répondre complètement et véridiquement pour éviter la réticence.
**Ref légale** : art. 4 à 6 LCA.

### 10. Question : Combien de temps Sophie a-t-elle pour annoncer le décès à l''assureur vie ?
**Réponse modèle** : Le contrat prévoit en général un délai raisonnable, souvent 30 jours. À défaut d''annonce dans les délais, l''assureur peut réduire les prestations si le retard a causé un préjudice, mais ne peut refuser purement et simplement.
**Ref légale** : art. 38 et 45 LCA.

### 11. Question : Le capital décès de la temporaire est-il imposable ?
**Réponse modèle** : S''il est versé à un tiers désigné hors succession (art. 78 LCA), il est soumis à l''impôt sur les successions cantonal selon le canton, avec une taxation privilégiée pour le conjoint (exonération dans la plupart des cantons romands). S''il tombe dans la succession, il subit l''impôt successoral ordinaire.
**Ref légale** : art. 24 let. b LIFD, législations cantonales.

### 12. Question : La rente de veuve AVS est-elle cumulable avec un salaire ?
**Réponse modèle** : Oui, la rente de veuve AVS est versée sans condition de revenu. Le cumul est intégral. Elle s''éteint en revanche au remariage (art. 23 al. 4 LAVS) et est reconstituée si le remariage est dissous.
**Ref légale** : art. 23 LAVS.

### 13. Question : Pourriez-vous expliquer la coordination des prestations en cas de décès ?
**Réponse modèle** : Les prestations sont coordonnées pour éviter la surindemnisation. Le total AVS plus LPP plus LAA ne peut dépasser 90 % du gain présumé perdu (art. 34a LPP et OPP2). Au-delà, la LPP réduit ses prestations. Les prestations 3a et vie individuelles ne rentrent pas dans le calcul.
**Ref légale** : art. 34a LPP, art. 24 OPP2.

### 14. Question : Que couvre la clause bénéficiaire modifiable ou non modifiable ?
**Réponse modèle** : Une clause modifiable permet au preneur de changer le bénéficiaire jusqu''à sa mort. Une clause non modifiable exige l''accord écrit du bénéficiaire pour tout changement, elle garantit ainsi une véritable protection au bénéficiaire (typique pour les crédits hypothécaires en garantie).
**Ref légale** : art. 77 LCA.

### 15. Question : Sophie pourrait-elle bénéficier d''une pension alimentaire orphelin en plus si Mathieu décède ?
**Réponse modèle** : Non, il n''existe pas de pension alimentaire cumulable. Les prestations d''orphelin AVS, LPP et éventuellement LAA sont les seules dues aux enfants. En revanche, si le couple s''était séparé avant le décès et qu''une pension avait été fixée, elle prendrait fin au décès du débirentier.
**Ref légale** : art. 25 LAVS, art. 20 LPP.

## Chiffres-clés à retenir

- Rente AVS simple 2026 : minimum 1 260 CHF/mois, maximum 2 520 CHF/mois.
- Rente de veuve AVS : 80 % de la rente vieillesse simple.
- Rente d''orphelin AVS : 40 % de la rente vieillesse simple (60 % double orphelin).
- Plafond famille AVS : 150 % de la rente maximale simple.
- LPP seuil d''entrée : 22 680 CHF.
- LPP déduction de coordination : 25 725 CHF.
- LPP salaire coordonné maximum : 90 720 CHF.
- Rente de conjoint LPP : 60 % de la rente d''invalidité.
- Rente d''orphelin LPP : 20 % de la rente d''invalidité.
- 3a petit pilier salarié LPP : 7 258 CHF/an.
- 3a grand pilier indépendant sans LPP : 36 288 CHF/an (max 20 % du revenu).
- Coordination LPP surindemnisation : plafond 90 % du gain présumé perdu.
- Réserve descendants depuis 2023 : 1/2 de la part légale.
- Délai de révocation LCA : 14 jours.
- Prescription en LCA : 5 ans dès l''exigibilité.

## Références légales

- art. 23 à 25 LAVS (rente de veuve, rente d''orphelin).
- art. 35 LAVS (plafond famille).
- art. 18 à 22 LPP (prestations pour survivants).
- art. 20a LPP (bénéficiaires étendus).
- art. 34a LPP et art. 24 OPP2 (coordination et surindemnisation).
- art. 28 à 32 LAA (rentes de survivants LAA).
- art. 76 à 79 LCA (clause bénéficiaire, insaisissabilité).
- art. 4 à 6 LCA (réticence, questionnaire de santé).
- art. 45 LSA (fiche d''information client).
- art. 471, 476 CC (réserves et action en réduction, révisé 2023).
- art. 2 OPP3 (ordre des bénéficiaires 3a).', 10, TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'garantie_revenus'
ON CONFLICT (key) DO UPDATE SET
  title = EXCLUDED.title,
  summary = EXCLUDED.summary,
  content_md = EXCLUDED.content_md,
  sort_order = EXCLUDED.sort_order,
  updated_at = NOW();

INSERT INTO afa_fiches
  (filiere_key, theme_id, key, title, summary, content_md, sort_order, active)
SELECT 'vie', t.id, 'cas_invalidite_salarie_45ans', 'Cas d''oral : Invalidité 100 % (cadre 45 ans)',
       'Cas d''examen oral VIE. Cadre 45 ans, salaire brut 145 000 CHF, marié, deux enfants, invalidité 100 % suite à maladie chronique. Analyser la lacune revenus et proposer les couvertures manquantes.', '## Contexte client

### Profil
- Julien Perret, 45 ans, cadre supérieur chez Nestlé (Vevey), directeur de production.
- Salaire brut annuel : 145 000 CHF (13e mois inclus), bonus annuel moyen 15 000 CHF non assuré LPP.
- Marié depuis 18 ans à Carole Perret, 43 ans, enseignante primaire à 60 %, revenu brut 55 000 CHF.
- Deux enfants : Maxime 14 ans (cycle d''orientation), Emma 11 ans (primaire).
- Domicile : appartement en PPE à Vevey, valeur 950 000 CHF, hypothèque 600 000 CHF.
- Avoir LPP au 31.12.2025 : 420 000 CHF (Fondation collective Nestlé, primauté cotisations).
- Rachats LPP possibles selon certificat : 180 000 CHF.
- 3a : 78 000 CHF sur trois comptes (UBS, BCV, Frankly).
- Épargne libre : 130 000 CHF sur un compte de placement diversifié.
- Contexte médical : diagnostic récent de sclérose en plaques évolutive (avril 2026), en incapacité de travail à 100 % depuis 5 mois. L''assurance perte de gain collective de l''employeur verse le salaire à 90 % (couverture LCA), l''AI a été annoncée en juillet.
- Une invalidité définitive à 100 % est probable dans les 12 à 18 mois selon les médecins.

### Question posée par le client
« Si je suis reconnu invalide à 100 %, combien vais-je vraiment toucher ? Est-ce que ma famille peut continuer à vivre normalement, garder l''appartement et payer les études des enfants ? Que dois-je faire aujourd''hui pour éviter les mauvaises surprises ? »

## Trame de présentation (20 min)

### 1. Introduction (2 min)
Monsieur Perret, merci pour votre confiance dans une période clairement difficile. Je me présente : intermédiaire d''assurance non lié, inscrit au registre FINMA. Voici la fiche d''information client art. 45 LSA qui précise mon statut, mes obligations et ma rémunération. Je vais aborder votre situation en quatre temps : rappel du contexte, chiffrage phase par phase des prestations sociales AVS, LPP, LAA et perte de gain collective, identification des lacunes, puis solutions concrètes de couverture privée et actions immédiates à mener. Comptez vingt minutes environ, vos questions à la fin.

### 2. Analyse (7 min)
Je vais analyser trois phases distinctes : la phase 1 est celle de l''incapacité de travail avant l''AI, la phase 2 est celle de l''invalidité reconnue jusqu''à la retraite, la phase 3 est la retraite.

**Phase 1 : indemnités journalières perte de gain (jours 1 à 720 environ)**
- La police collective Nestlé prévoit 90 % du salaire pendant 730 jours (LCA), après un délai d''attente de 30 jours pris en charge par l''employeur au titre de l''art. 324a CO.
- Indemnité journalière : environ 358 CHF brut/jour.
- Cotisations LPP maintenues par l''employeur pendant la couverture PGM (à vérifier au règlement).

**Phase 2 : rente AI et rente d''invalidité LPP**
- Rente AI complète (100 %) : basée sur le revenu AVS moyen sur toute la carrière, environ 2 450 CHF/mois soit 29 400 CHF/an.
- Rente d''enfant AI : 40 % de la rente principale, 980 CHF/mois par enfant.
- Plafond famille AI : 150 % de la rente principale.
- Rente d''invalidité LPP obligatoire : basée sur l''avoir de vieillesse projeté à 65 ans plus les bonifications futures jusqu''à cet âge. Avec un salaire coordonné plafonné à 65 000 CHF, la rente projetée est estimée à 34 000 CHF/an.
- Rente d''enfant LPP : 20 % par enfant, environ 6 800 CHF/an chacun.
- La LPP peut être plafonnée par la règle de surindemnisation : total AVS/AI plus LPP ne dépasse pas 90 % du gain présumé perdu (art. 34a LPP, art. 24 OPP2).

**Phase 3 : rente vieillesse à 65 ans**
- La rente AI est remplacée à 65 ans par la rente AVS.
- La rente d''invalidité LPP est remplacée par la rente vieillesse LPP (art. 26 LPP). Le taux de conversion 2026 est 6,8 % sur la part obligatoire.

**Lacune chiffrée phase 2 (situation cible) :**

| Poste | Montant CHF/an |
|---|---|
| Besoin annuel du ménage (charges + train de vie) | 130 000 |
| Rente AI principale | 29 400 |
| Rentes d''enfant AI (2 × 11 760) | 23 520 |
| Rente LPP invalidité | 34 000 |
| Rentes LPP enfant (2 × 6 800) | 13 600 |
| Salaire net résiduel de Carole | 45 000 |
| Total prestations disponibles | 145 520 |
| Solde avant surindemnisation | +15 520 |
| Réduction LPP surindemnisation (estimée) | 18 000 |
| Lacune nette phase 2 | 2 480 |

Attention : cette lacune apparaît faible parce que Julien est proche du salaire coordonné maximum LPP. La vraie lacune apparaît sur son bonus de 15 000 CHF (non assuré LPP), sur la perte du 3e pilier après la fin de la couverture PGM, et sur la chute des rentes d''enfant AI et LPP quand Maxime aura 18 ans (25 en cas d''études) puis Emma.

### 3. Solutions (8 min)
Passons aux solutions. Trois axes.

**Axe 1 : rente incapacité de gain privée (temporaire jusqu''à 65 ans)**
- Souscrire une temporaire invalidité de 30 000 CHF/an, versée après un délai d''attente de 24 mois (coordination avec la couverture PGM et l''AI).
- Coût prévisible : problème majeur, Julien est déjà en incapacité, la souscription sera refusée ou subordonnée à une exclusion de la SEP. À défaut, viser une couverture pour Carole (30 % de son revenu perdu si elle devait s''arrêter pour s''occuper de Julien), 20 000 CHF/an de couverture pour environ 750 CHF/an de prime.

**Axe 2 : optimisation immédiate du 2e pilier**
- Effectuer un rachat LPP de 180 000 CHF avant l''attribution définitive de l''AI (les rachats sont possibles tant que la personne est active). Effet fiscal immédiat : économie de plus de 50 000 CHF au taux marginal 2026.
- Bloqué 3 ans avant tout retrait en capital : art. 79b al. 3 LPP.
- Vérifier au règlement Nestlé la possibilité d''un rachat pour anticiper la retraite (Vorbezug/rachat AVS).
- Vérifier la libération du service des cotisations : la plupart des règlements l''accordent après une incapacité prolongée.

**Axe 3 : structuration décès et prévoyance liée**
- Souscrire dès que possible une temporaire décès pour couvrir le solde hypothécaire, 300 000 CHF sur 20 ans, capital constant. Bénéficiaire nominatif Carole art. 76 à 78 LCA.
- Maintenir le versement 3a plafond 7 258 CHF/an tant que Julien perçoit un revenu AVS (y compris via les indemnités journalières PGM qui sont soumises à l''AVS). Attention : dès que la rente AI est versée, Julien ne peut plus verser en 3a puisqu''il n''a plus de revenu d''activité (art. 82 LPP, art. 7 OPP3).
- Envisager une assurance couvrant l''exonération du service des primes (Prämienbefreiung) sur son 3a et sur la temporaire décès de Carole.

Je déconseille formellement de retirer le capital LPP à 55 ans pour EPL (encouragement à la propriété du logement) : cela entamerait la rente de vieillesse et la rente d''invalidité LPP.

### 4. Conclusion (3 min)
En synthèse, Monsieur Perret, votre priorité absolue est d''effectuer le rachat LPP de 180 000 CHF avant l''attribution AI, d''ouvrir la temporaire décès à hauteur de 300 000 CHF et de sécuriser Carole via une temporaire invalidité 20 000 CHF/an. Prochaine étape : je réunis le certificat LPP à jour, le règlement de la caisse Nestlé, la décision médicale et l''avis d''incapacité, et je vous soumets sous 8 jours les propositions Helvetia, Bâloise et Swiss Life avec le comparatif de tenue économique. Je vous remets aujourd''hui la fiche art. 45 LSA, le questionnaire de santé, la simulation de rachat LPP et le récapitulatif fiscal.

## Questions d''experts type (jury) + réponses modèles

### 1. Question : Comment le degré d''invalidité est-il déterminé par l''AI ?
**Réponse modèle** : L''AI applique la méthode générale de comparaison des revenus : elle compare le revenu qu''aurait Julien sans invalidité au revenu qu''il pourrait raisonnablement obtenir malgré son atteinte. La quotité de rente est modulée : 40 % à 100 % d''invalidité donnent une rente linéaire de 25 % à 100 % de la rente entière depuis la réforme AI 2022.
**Ref légale** : art. 28 à 28b LAI.

### 2. Question : Quel est le délai d''attente avant que l''AI verse une rente ?
**Réponse modèle** : Le droit à la rente naît au plus tôt six mois après l''annonce, et à condition d''une incapacité de travail d''au moins 40 % durant une année sans interruption notable. En pratique, la première rente est versée après 12 à 18 mois. C''est ce qui rend la couverture PGM LCA absolument critique.
**Ref légale** : art. 28 al. 1 et 29 LAI.

### 3. Question : Comment se calcule la rente d''invalidité LPP obligatoire ?
**Réponse modèle** : Elle est calculée sur l''avoir de vieillesse acquis au moment de l''incapacité, augmenté des bonifications futures projetées jusqu''à la retraite (sans intérêts). Le résultat est converti au taux de conversion en vigueur (6,8 % sur la part obligatoire en 2026).
**Ref légale** : art. 24 LPP.

### 4. Question : Peut-il y avoir surindemnisation et si oui à quel plafond ?
**Réponse modèle** : Oui, la LPP peut réduire ses prestations quand le total des rentes de tous les régimes dépasse 90 % du gain présumé perdu. Sont pris en compte : rente AI, rente LPP, rente LAA le cas échéant. Ne sont pas pris en compte : la LAA-C conclue à titre facultatif, les rentes d''assurances de sommes privées, le 3a en capital.
**Ref légale** : art. 34a LPP, art. 24 OPP2.

### 5. Question : Quelle différence entre assurance de sommes et assurance de dommages en LCA ?
**Réponse modèle** : L''assurance de sommes verse le montant convenu au contrat indépendamment du préjudice réel : c''est le cas des temporaires décès et des rentes d''invalidité individuelles. L''assurance de dommages est indemnitaire : elle ne couvre que la perte effective. Les IJM d''employeur sont en principe des assurances de dommages.
**Ref légale** : principe indemnitaire LCA, art. 96 LCA pour l''assurance de dommages.

### 6. Question : Julien peut-il continuer à verser en 3a une fois qu''il perçoit la rente AI ?
**Réponse modèle** : Non, à moins qu''il ne conserve un revenu d''activité (par exemple un temps très partiel adapté). Le 3a suppose un revenu soumis à l''AVS provenant d''une activité lucrative. La rente AI ne compte pas comme revenu d''activité.
**Ref légale** : art. 82 LPP, art. 7 OPP3.

### 7. Question : Que se passe-t-il avec le rachat LPP de 180 000 CHF ?
**Réponse modèle** : Le rachat augmente l''avoir de vieillesse et donc la rente projetée en cas d''invalidité si la caisse le prend en compte pour le calcul de la prestation d''invalidité (à vérifier au règlement). Il permet une déduction fiscale de 180 000 CHF à l''année du versement. Il est bloqué 3 ans pour un retrait en capital.
**Ref légale** : art. 79b LPP.

### 8. Question : La rente d''enfant AI est-elle versée jusqu''à quel âge ?
**Réponse modèle** : Jusqu''à 18 ans, prolongée jusqu''à 25 ans en cas d''études, apprentissage ou formation reconnue. Elle est indépendante de la situation professionnelle des parents.
**Ref légale** : art. 35 LAI.

### 9. Question : L''incapacité de gain due à une maladie chronique est-elle couverte par la LAA ?
**Réponse modèle** : Non, la LAA ne couvre que les accidents et les maladies professionnelles listées (art. 9 LAA). La sclérose en plaques est une maladie ordinaire, elle relève exclusivement de l''AI et de la LPP.
**Ref légale** : art. 6 et 9 LAA.

### 10. Question : Que couvre l''obligation de l''employeur de verser le salaire selon l''art. 324a CO ?
**Réponse modèle** : L''employeur doit verser le salaire pendant un temps limité si le salarié est empêché de travailler sans faute (maladie, service militaire, obligations légales). Les échelles bernoise, bâloise et zurichoise fixent le nombre de semaines selon l''ancienneté. En pratique, une assurance perte de gain collective LCA remplace cette obligation.
**Ref légale** : art. 324a CO.

### 11. Question : Quel plafond de gain assuré s''applique en LAA ?
**Réponse modèle** : Le gain assuré maximum LAA 2026 est de 148 200 CHF/an. Au-delà, la couverture doit être complétée par une LAA-C (Zusatzversicherung) souscrite par l''employeur, sinon la partie excédentaire n''est pas assurée.
**Ref légale** : art. 15 LAA, ordonnance sur le gain assuré.

### 12. Question : Carole peut-elle verser en 3a même à temps partiel ?
**Réponse modèle** : Oui, dès qu''elle a un revenu soumis à l''AVS provenant d''une activité lucrative. Comme elle est affiliée LPP (revenu supérieur au seuil d''entrée 22 680 CHF), elle peut verser le petit pilier 3a, soit 7 258 CHF/an en 2026.
**Ref légale** : art. 7 al. 1 let. a OPP3.

### 13. Question : Le capital-invalidité versé en 3a serait-il coordonné ?
**Réponse modèle** : Non, les prestations 3a versées sous forme de capital ne rentrent pas dans le calcul de surindemnisation LPP. C''est un avantage important pour combler la lacune sans risque de réduction.
**Ref légale** : art. 34a LPP a contrario, art. 24 OPP2.

### 14. Question : Que faire si l''assureur privé refuse la couverture invalidité au vu du diagnostic ?
**Réponse modèle** : Documenter le refus par écrit, tenter la couverture avec exclusion (Ausschluss) pour l''affection concernée seule, et à défaut concentrer la protection sur Carole et sur la couverture décès de Julien. Le devoir d''information continue de l''assureur art. 3 LCA impose qu''il justifie sa décision.
**Ref légale** : art. 3, 6 LCA.

### 15. Question : Que couvre exactement le principe de la libération du service des primes ?
**Réponse modèle** : Il permet, en cas d''incapacité de gain durable, que l''assureur continue de verser lui-même la prime à sa place pour maintenir la couverture ou l''épargne. Sur un 3b épargne, cela évite que l''assurance tombe faute de paiement. Souvent liée à une couverture invalidité complémentaire.
**Ref légale** : conditions contractuelles LCA, jurisprudence.

## Chiffres-clés à retenir

- Rente AI complète 2026 : minimum 1 260 CHF/mois, maximum 2 520 CHF/mois.
- Rente d''enfant AI : 40 % de la rente principale.
- Plafond famille AI : 150 % de la rente principale.
- Rente d''invalidité LPP obligatoire : conversion 6,8 % de l''avoir projeté.
- Rente d''enfant LPP invalidité : 20 % de la rente d''invalidité.
- LPP salaire coordonné maximum : 90 720 CHF.
- LPP seuil d''entrée : 22 680 CHF.
- LPP déduction de coordination : 25 725 CHF.
- Coordination surindemnisation : 90 % du gain présumé perdu.
- LAA gain assuré maximum : 148 200 CHF/an.
- Rachat LPP bloqué 3 ans avant retrait en capital.
- Réforme AI 2022 : rente linéaire de 25 à 100 % pour un degré de 40 à 100 %.
- Délai d''attente AI : au plus tôt 6 mois après annonce.
- 3a petit pilier 2026 : 7 258 CHF/an.
- 3a grand pilier indépendant : 36 288 CHF/an (max 20 % revenu).

## Références légales

- art. 28 à 28b LAI (échelle des rentes, méthode générale).
- art. 29 LAI (naissance du droit).
- art. 35 LAI (rente d''enfant).
- art. 24 LPP (rente d''invalidité).
- art. 25 LPP (rente d''enfant d''invalide).
- art. 34a LPP et art. 24 OPP2 (surindemnisation).
- art. 79b LPP (rachats, blocage 3 ans).
- art. 6, 9 LAA (exclusion des maladies ordinaires).
- art. 15 LAA (gain assuré, plafond).
- art. 324a CO (maintien du salaire).
- art. 96 LCA (assurance de dommages).
- art. 3, 6 LCA (devoir d''information, réticence).
- art. 76 à 78 LCA (bénéficiaire nominatif).
- art. 82 LPP, art. 7 OPP3 (conditions du 3a).
- art. 45 LSA (fiche d''information client).', 20, TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'garantie_revenus'
ON CONFLICT (key) DO UPDATE SET
  title = EXCLUDED.title,
  summary = EXCLUDED.summary,
  content_md = EXCLUDED.content_md,
  sort_order = EXCLUDED.sort_order,
  updated_at = NOW();

INSERT INTO afa_fiches
  (filiere_key, theme_id, key, title, summary, content_md, sort_order, active)
SELECT 'vie', t.id, 'cas_retraite_choix_rente_capital', 'Cas d''oral : Départ retraite (choix rente vs capital LPP)',
       'Cas d''examen oral VIE. Homme 64 ans, salaire brut 135 000 CHF, avoir LPP 780 000 CHF, épouse 61 ans à 60 %. Choix entre rente LPP, capital, mix. Optimiser la fiscalité et sécuriser le conjoint.', '## Contexte client

### Profil
- Pierre Delaloye, 64 ans, ingénieur chef de projet chez Alstom (Baden), départ retraite au 30 juin 2026 (64 ans révolus, retraite anticipée d''une année).
- Salaire brut annuel : 135 000 CHF (13e mois inclus).
- Marié depuis 32 ans à Marie-Claire, 61 ans, comptable indépendante à 60 %, revenu net environ 55 000 CHF.
- Deux enfants adultes indépendants : Céline 29 ans (mariée, deux enfants), Adrien 26 ans (célibataire, aux études doctorales).
- Villa individuelle à Villars-sur-Glâne, valeur vénale 1 400 000 CHF, hypothèque résiduelle 380 000 CHF (34 % LTV).
- Avoir LPP au 30.06.2026 : 780 000 CHF (dont 620 000 CHF de part obligatoire et 160 000 CHF de part surobligatoire).
- Rente LPP prévue selon règlement : taux de conversion pondéré 5,6 % (mélange obligatoire 6,8 % et surobligatoire 4,8 %). Rente annuelle 43 680 CHF.
- 3a : deux comptes chez BCV totalisant 195 000 CHF.
- 3b épargne libre : 240 000 CHF sur portefeuille équilibré chez Vontobel.
- Rente AVS attendue à 65 ans : 2 400 CHF/mois (28 800 CHF/an), soit près de la rente maximale.
- Rente AVS attendue pour Marie-Claire à 64 ans révolus (âge de référence 2026) : 2 100 CHF/mois (25 200 CHF/an).
- Charges annuelles à la retraite estimées à 92 000 CHF (train de vie stable, projets voyage réguliers).

### Question posée par le client
« Je pars à la retraite dans six mois. Le règlement me propose la rente à vie ou un capital de 780 000 CHF. Que dois-je choisir ? J''aimerais protéger Marie-Claire mais aussi garder de la souplesse fiscale pour mes enfants. Et je pense anticiper l''AVS d''une année, est-ce judicieux ? »

## Trame de présentation (20 min)

### 1. Introduction (2 min)
Bonjour Monsieur Delaloye, félicitations pour cette étape importante. Je me présente : intermédiaire d''assurance non lié, inscrit au registre FINMA, soumis à l''art. 45 LSA. Voici ma fiche d''information client, elle précise mon statut, mes obligations et ma rémunération. Nous avons vingt minutes ensemble : je vais d''abord rappeler votre situation, puis analyser les prestations dues, ensuite comparer les trois options rente pure, capital pur, mix rente et capital, avec les impacts fiscaux et successoraux. Je terminerai par mes recommandations et les prochaines étapes.

### 2. Analyse (7 min)
Je vais analyser vos revenus à la retraite avant même de parler du choix rente/capital.

**Revenus AVS (art. 40 LAVS pour anticipation)**
- Anticipation d''une année : rente AVS réduite de 6,8 % à vie, soit 2 236 CHF/mois au lieu de 2 400 CHF, une perte annuelle définitive d''environ 1 968 CHF.
- Report d''un an : bonification de 5,2 %, soit 2 525 CHF/mois. Effet financier positif dès 12 à 13 ans de vie post-retraite.
- Ajournement des rentes possible entre 1 et 5 ans (art. 39 LAVS).
- Marie-Claire garde son droit AVS séparé selon son propre parcours cotisations.

**Prestations LPP au départ (art. 37 LPP)**
- Rente annuelle proposée : 43 680 CHF (taux pondéré 5,6 %).
- Réversion 60 % pour Marie-Claire : 26 208 CHF/an à vie en cas de décès de Pierre.
- Capital en totalité : 780 000 CHF versé une fois, imposé séparément art. 38 LIFD au taux réduit d''environ 6 à 7 % (barème cantonal Fribourg).

**Bilan de trésorerie post-retraite (rente pure et anticipation AVS d''un an)**

| Poste | Montant CHF/an |
|---|---|
| Rente AVS (anticipée 1 an) | 26 832 |
| Rente AVS Marie-Claire (dès 65) | 25 200 |
| Rente LPP Pierre | 43 680 |
| Revenu Marie-Claire indépendante | 55 000 |
| Total revenu brut ménage | 150 712 |
| Charges annuelles | 92 000 |
| Solde annuel disponible | 58 712 |

La lacune n''est donc pas dans le budget. La question réelle est double : optimisation fiscale et protection successorale de Marie-Claire et des enfants.

**Simulation fiscale des trois options**

| Option | Impact année 1 | Impact récurrent |
|---|---|---|
| Rente 100 % | Aucun impôt ponctuel | +43 680 CHF revenu imposable/an à 100 % (art. 22 LIFD) |
| Capital 100 % | Impôt séparé environ 55 000 CHF (Fribourg) | Revenu placement seulement (imposable) |
| Mix 50 % rente + 50 % capital | Impôt séparé environ 22 000 CHF | +21 840 CHF revenu imposable/an |

### 3. Solutions (8 min)
Passons aux solutions concrètes.

**Solution recommandée : mix 60 % rente + 40 % capital**
- Rente LPP conservée : 468 000 CHF, rente annuelle environ 26 200 CHF.
- Capital retiré : 312 000 CHF, imposé une fois à taux réduit (art. 38 LIFD).
- Justification : la rente couvre les besoins fixes récurrents et protège Marie-Claire via la réversion 60 %. Le capital sert à amortir 200 000 CHF d''hypothèque (nouveau LTV 51 %), à constituer une réserve d''imprévus et à financer des transmissions anticipées aux petits-enfants.

**Effet sur la réversion**
- Rente de conjoint : 60 % de la rente maintenue, soit environ 15 720 CHF/an.
- La part convertie en capital ne génère plus de réversion. C''est pourquoi j''ai choisi 60 % en rente et non 40 %.

**Prévoyance liée 3a**
- Retirer les 3a échelonné sur les 5 années précédant la retraite pour lisser la charge fiscale : art. 3 al. 1 OPP3 permet le retrait dès 60 ans (5 ans avant l''âge de référence). Ici, la fenêtre est déjà entamée.
- Deux comptes 3a de 100 000 CHF et 95 000 CHF : retirer un compte en 2026 et un en 2027 pour bénéficier deux fois du taux séparé.

**Assurance vie mixte 3b existante ou à constituer**
- Pas d''urgence à souscrire, votre 3b libre couvre déjà bien. Vérifier la clause bénéficiaire des polices vie existantes.

**Successoral (droit révisé 2023)**
- Depuis la révision, la réserve des descendants est de 1/2 de leur part légale (avant 3/4). La quotité disponible s''agrandit et permet de mieux protéger Marie-Claire par testament.
- Recommandation : contrat de mariage participation aux acquêts avec attribution intégrale des acquêts à Marie-Claire au décès (art. 216 CC), doublé d''un testament olographe attribuant la quotité disponible à Marie-Claire.
- Effet : Marie-Claire reçoit environ 75 à 80 % de la fortune, les enfants héritent essentiellement au second décès.

**Anticipation AVS**
- Anticiper d''un an coûte 6,8 % à vie et se rentabilise mal (point mort au-delà de 12 ans). Je conseille de ne pas anticiper : Pierre gardera un salaire ou vivra sur le capital LPP la 1ère année.

**Attention à l''article 79b al. 3 LPP**
- Vérifier qu''aucun rachat LPP n''a été fait dans les 3 ans précédant le retrait en capital. Sinon, l''AFC refuse la déduction fiscale du rachat et réclame l''impôt (jurisprudence TF).

### 4. Conclusion (3 min)
Monsieur Delaloye, je vous recommande un mix 60 % rente et 40 % capital LPP, l''étalement du retrait 3a sur 2026 et 2027, le maintien du départ AVS à 65 ans sans anticipation, et un contrat de mariage complété d''un testament pour protéger Marie-Claire. Prochaines étapes : je vous remets le simulateur fiscal détaillé, la fiche art. 45 LSA, le comparatif des scénarios rente/capital chez Alstom, et je vous accompagne pour la lettre de choix à envoyer à la caisse (délai formel généralement 3 mois avant la retraite). Je reste à disposition pour un point avec Marie-Claire lors de la prochaine séance.

## Questions d''experts type (jury) + réponses modèles

### 1. Question : Quelle est la part de capital minimum qu''un règlement doit accorder ?
**Réponse modèle** : La loi impose que 25 % de l''avoir de vieillesse obligatoire puisse être perçu en capital (art. 37 al. 2 LPP). De nombreux règlements prévoient une part plus importante, voire 100 %.
**Ref légale** : art. 37 al. 2 LPP.

### 2. Question : Dans quel délai le choix rente ou capital doit-il être communiqué ?
**Réponse modèle** : Le règlement fixe le délai, généralement de 1 à 3 mois avant la retraite, parfois jusqu''à 3 ans (art. 37 al. 4 let. a LPP impose un préavis d''au moins 1 an pour l''ensemble du capital). Passé ce délai, le choix devient définitif et la rente est versée automatiquement.
**Ref légale** : art. 37 al. 4 LPP.

### 3. Question : Comment le capital LPP est-il imposé au moment du retrait ?
**Réponse modèle** : Il est imposé séparément du reste des revenus, à un taux réduit correspondant au 1/5 du taux ordinaire (art. 38 LIFD, taux cantonal variable). L''impôt est prélevé une fois, à la source dans certains cantons.
**Ref légale** : art. 38 LIFD, art. 11 al. 3 LHID.

### 4. Question : Peut-on retirer le 3a plusieurs fois pour lisser l''impôt ?
**Réponse modèle** : Oui, à condition d''avoir plusieurs comptes 3a auprès d''assureurs ou fondations bancaires différents. On peut retirer un compte par année civile durant les 5 ans précédant l''âge de référence AVS. Chaque retrait bénéficie du taux séparé.
**Ref légale** : art. 3 OPP3, jurisprudence fédérale.

### 5. Question : Quelle est la conséquence de l''art. 79b al. 3 LPP ?
**Réponse modèle** : Tout rachat LPP effectué dans les 3 ans précédant un retrait en capital est refusé fiscalement : l''AFC reprend la déduction et le versement en capital est imposé sans possibilité de compensation. La règle vaut aussi si les rachats et retraits sont dans deux caisses différentes.
**Ref légale** : art. 79b al. 3 LPP.

### 6. Question : Quelle rente Marie-Claire toucherait-elle si Pierre décède après avoir choisi 100 % capital ?
**Réponse modèle** : Aucune rente LPP de conjoint. Le capital n''est plus dans la caisse de pension, il fait partie de la fortune du couple. Marie-Claire hérite selon les règles CC (art. 462 : 1/2 en présence de descendants, 3/4 en présence d''ascendants uniquement).
**Ref légale** : art. 462 CC, art. 37 al. 4 LPP.

### 7. Question : Marie-Claire, indépendante, peut-elle verser en 3a ?
**Réponse modèle** : Oui, en tant qu''indépendante sans LPP, elle peut verser le grand pilier 3a, plafonné à 20 % de son revenu net d''activité, dans la limite de 36 288 CHF/an en 2026.
**Ref légale** : art. 7 al. 1 let. b OPP3.

### 8. Question : Quels sont les effets d''un ajournement AVS ?
**Réponse modèle** : L''ajournement de 1 à 5 ans procure un supplément à vie : 5,2 % après 1 an, jusqu''à 31,5 % après 5 ans. Point mort autour de 82 ans. Utile pour les rentiers qui continuent une activité rémunérée.
**Ref légale** : art. 39 LAVS.

### 9. Question : Le rachat LPP est-il encore possible à 64 ans ?
**Réponse modèle** : Oui, tant que la personne est active et que le règlement le permet. Attention au blocage 3 ans (art. 79b al. 3 LPP) : à 64 ans, un rachat serait inutile fiscalement si le retrait en capital est envisagé dans moins de 3 ans.
**Ref légale** : art. 79b LPP.

### 10. Question : Le versement en capital LPP tombe-t-il dans la succession ?
**Réponse modèle** : Oui, une fois versé, le capital LPP intègre le patrimoine du bénéficiaire et suit les règles successorales ordinaires. C''est la différence majeure avec la rente, qui s''éteint au décès (avec réversion partielle) et n''est pas transmissible.
**Ref légale** : art. 462 CC.

### 11. Question : Quelle est la rente maximale AVS 2026 pour un couple ?
**Réponse modèle** : La rente maximale pour un couple est plafonnée à 150 % de la rente maximale simple d''un individu (art. 35 LAVS), soit environ 3 780 CHF/mois soit 45 360 CHF/an. Le plafonnement se fait uniquement si les deux conjoints touchent chacun leur rente vieillesse.
**Ref légale** : art. 35 LAVS.

### 12. Question : Peut-on continuer à cotiser à l''AVS après 65 ans ?
**Réponse modèle** : Oui, si l''on continue une activité lucrative, avec une franchise mensuelle de 1 400 CHF. Les cotisations versées après l''âge de référence peuvent améliorer la rente si des lacunes de cotisations existaient (nouveauté AVS 21).
**Ref légale** : art. 4, 5 LAVS, réforme AVS 21.

### 13. Question : Que couvre la réversion LPP en cas de concubinage ?
**Réponse modèle** : Le règlement peut prévoir une rente de partenaire pour le concubin si les conditions cumulatives sont remplies : ménage commun d''au moins 5 ans, non parenté, désignation écrite préalable à la caisse. En l''absence de mention au règlement, aucun droit.
**Ref légale** : art. 20a LPP.

### 14. Question : Le 3b n''a pas d''ordre de bénéficiaires imposé, est-ce exact ?
**Réponse modèle** : Correct. Contrairement au 3a régi strictement par l''art. 2 OPP3, le 3b est libre : le preneur désigne les bénéficiaires qu''il souhaite via la clause bénéficiaire art. 76 LCA. Attention néanmoins aux réserves héréditaires art. 476 CC : action en réduction possible.
**Ref légale** : art. 76 LCA, art. 476 CC.

### 15. Question : Pierre peut-il transférer son capital LPP sur un compte de libre passage ?
**Réponse modèle** : Non, sauf s''il quitte la Suisse ou s''il devient indépendant. À la retraite, le libre passage n''est pas une sortie ordinaire : le capital est soit rentifié, soit versé en capital selon les termes du règlement. Une exception existe si Pierre poursuit une activité chez un autre employeur et le règlement le permet.
**Ref légale** : art. 5 LFLP, art. 37 LPP.

## Chiffres-clés à retenir

- Rente AVS simple 2026 : min 1 260 CHF, max 2 520 CHF/mois.
- Anticipation AVS : réduction 6,8 % par année d''anticipation, max 2 ans.
- Ajournement AVS : bonification de 5,2 % à 31,5 % selon durée.
- Rente couple plafonnée à 150 % rente max simple.
- LPP part obligatoire minimum 25 % en capital exigible.
- Taux de conversion LPP obligatoire 2026 : 6,8 %.
- Retrait 3a : dès 5 ans avant l''âge de référence AVS.
- 3a petit pilier 2026 : 7 258 CHF/an.
- 3a grand pilier indépendant : 36 288 CHF/an (20 % revenu max).
- Rachat LPP bloqué 3 ans avant retrait en capital.
- Franchise AVS après 65 : 1 400 CHF/mois si activité poursuivie.
- Impôt séparé sur capital : art. 38 LIFD, taux 1/5.
- Réserve descendants depuis 2023 : 1/2.
- Réserve conjoint depuis 2023 : 1/2.
- Rente de partenaire LPP : conditions 5 ans ménage commun + désignation écrite.

## Références légales

- art. 37 LPP (choix rente/capital, préavis).
- art. 20a LPP (rente de partenaire, concubinage).
- art. 79b LPP (rachats, blocage 3 ans).
- art. 5 LFLP (libre passage, sortie ordinaire).
- art. 3 OPP3 (retrait 3a, 5 ans avant AVS).
- art. 7 OPP3 (limites 3a).
- art. 2 OPP3 (ordre bénéficiaires 3a).
- art. 39, 40 LAVS (ajournement, anticipation).
- art. 35 LAVS (plafond couple).
- art. 38 LIFD (imposition séparée capital).
- art. 11 al. 3 LHID (harmonisation cantonale).
- art. 22 LIFD (imposition rentes).
- art. 216 CC (attribution acquêts).
- art. 462, 471, 476 CC (droit successoral révisé 2023).
- art. 45 LSA (fiche d''information client).', 30, TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'retraite'
ON CONFLICT (key) DO UPDATE SET
  title = EXCLUDED.title,
  summary = EXCLUDED.summary,
  content_md = EXCLUDED.content_md,
  sort_order = EXCLUDED.sort_order,
  updated_at = NOW();

INSERT INTO afa_fiches
  (filiere_key, theme_id, key, title, summary, content_md, sort_order, active)
SELECT 'vie', t.id, 'cas_concubinage_sans_enfant', 'Cas d''oral : Concubinage sans enfant (couple 40 ans)',
       'Cas d''examen oral VIE. Concubins 40 et 38 ans, sans enfant, salaires 95 000 et 78 000 CHF, patrimoine mixte, achat immobilier récent. Sécuriser le survivant, comprendre les pièges concubinage.', '## Contexte client

### Profil
- Lucas Bertholet, 40 ans, chef comptable chez Firmenich (Meyrin), salaire brut 95 000 CHF/an.
- Vanessa Kolly, 38 ans, cheffe de projet marketing indépendante (raison individuelle), revenu net 78 000 CHF/an environ.
- En couple depuis 11 ans, en concubinage stable, mêmes domicile et compte commun, mais non mariés et sans PACS (le PACS n''existe pas en droit fédéral suisse).
- Sans enfant, pas de projet d''enfant à court terme, parents respectifs vivants.
- Achat en octobre 2025 d''un appartement PPE à Nyon, valeur 850 000 CHF, hypothèque 590 000 CHF au taux SARON (Raiffeisen), copropriété 50/50.
- Avoir LPP Lucas (Caisse Firmenich) : 165 000 CHF, dont 30 000 CHF versés en EPL pour l''achat immobilier.
- Vanessa : pas de LPP obligatoire (indépendante).
- 3a Lucas : 45 000 CHF chez UBS (bénéficiaire Vanessa désignée).
- 3a Vanessa : 62 000 CHF chez Zurich (petit et grand pilier confondus).
- Épargne libre : 40 000 CHF sur compte commun.
- Testaments respectifs : aucun. Pacte successoral : aucun. Assurances vie : aucune.

### Question posée par le client
« Nous avons acheté cet appartement ensemble, mais si l''un de nous meurt demain, que se passe-t-il pour l''autre ? Est-ce qu''on peut vraiment continuer à vivre là ? Est-ce que Vanessa touche mon 2e pilier ? »

## Trame de présentation (20 min)

### 1. Introduction (2 min)
Bonjour Monsieur Bertholet, Madame Kolly. Je me présente : intermédiaire d''assurance non lié, inscrit au registre FINMA. Voici la fiche d''information client art. 45 LSA. Votre situation soulève un point spécifique du droit suisse que je vais éclaircir : la protection du survivant en concubinage. Je vais structurer en quatre temps : rappel de votre situation civile et patrimoniale, analyse des prestations sociales réellement dues au concubin, identification des pièges classiques, puis solutions concrètes (successorales et assurantielles). Comptez vingt minutes, gardez les questions pour la fin.

### 2. Analyse (7 min)
Je vais analyser ce qui se passe si Lucas décède aujourd''hui, puis ce qui se passe si Vanessa décède aujourd''hui.

**Prestations sociales au concubin survivant : ce que dit la loi**

**1er pilier (AVS)** : art. 23 LAVS, aucun droit à la rente de veuf ou de veuve pour un concubin, quelle que soit la durée de vie commune ou l''existence d''enfants communs. Piège classique : les gens pensent qu''un concubin est traité comme un conjoint.

**2e pilier (LPP)** : art. 20a LPP. Le règlement de la caisse Firmenich peut prévoir une rente de partenaire, à condition cumulative :
- Vie commune non interrompue de 5 ans au moins immédiatement avant le décès, OU obligation d''entretien pour un enfant commun.
- Absence de lien de parenté.
- Désignation écrite préalable envoyée à la caisse.
- Pas d''autre bénéficiaire prioritaire (conjoint, enfant à charge).
Lucas doit vérifier au règlement Firmenich et déposer une déclaration de partenariat écrite. Sans cette démarche : rien pour Vanessa.

**LAA (accident)** : art. 29 LAA, aucun droit à une rente de conjoint pour le concubin, quelle que soit la durée de vie commune. C''est un piège aggravé si Lucas décède d''un accident.

**3e pilier lié (3a) : art. 2 OPP3**
- Ordre impératif des bénéficiaires : 1° conjoint survivant ; 2° descendants directs, personne à l''entretien du preneur, concubin ayant fait ménage commun 5 ans ; 3° parents ; 4° frères et sœurs ; 5° autres héritiers.
- Lucas et Vanessa vivent ensemble depuis 11 ans, donc Vanessa entre dans le rang 2 comme concubine qualifiée. Lucas doit encore la désigner nominativement par écrit auprès d''UBS.

**3e pilier libre (3b)** : liberté totale de désignation via clause bénéficiaire art. 76 LCA.

**Situation successorale**
- Le concubin n''est PAS héritier légal. Pas de part réservataire, pas d''usufruit. Si Lucas décède sans testament, ses parents héritent (art. 458 CC, hoirie parentale).
- Vanessa devrait alors racheter la moitié de l''appartement aux parents de Lucas ou vendre.

**Chiffrage de la lacune (décès de Lucas)**

| Poste | Montant CHF/an |
|---|---|
| Besoin annuel de Vanessa (charges + hypothèque) | 76 000 |
| Rente AVS de veuve | 0 |
| Rente LPP de partenaire (si règlement + désignation) | environ 12 000 |
| Capital 3a versé au titre du rang 2 (si désignée) | 45 000 (unique) |
| Revenu Vanessa | 78 000 |
| Solde annuel après rentes | +14 000 |

Mais Vanessa doit également financer le rachat de la part successorale des parents de Lucas : environ 130 000 CHF (moitié de l''appartement net des dettes), un choc financier majeur.

### 3. Solutions (8 min)
Passons aux solutions. Cinq mesures immédiates.

**1. Testament olographe croisé**
- Chacun rédige un testament attribuant toute la quotité disponible à l''autre.
- En absence de descendants, les parents ont une réserve : depuis 2023, cette réserve a été supprimée pour les parents (art. 471 CC révisé), la quotité disponible est donc totale s''il n''y a pas de descendants ni de conjoint.
- Vanessa peut donc hériter de la totalité de la part de Lucas si Lucas la désigne par testament, et inversement.
- Forme : entièrement manuscrit, daté, signé (art. 505 CC). Alternative : acte authentique chez notaire (art. 499 CC).

**2. Pacte successoral (option renforcée)**
- Acte authentique devant notaire (art. 512 CC), engagement mutuel qui ne peut être révoqué unilatéralement. Utile si les parents sont susceptibles de contester.

**3. Déclaration de partenariat auprès de la caisse LPP Firmenich**
- Lucas dépose immédiatement le formulaire de partenariat écrit auprès de la caisse Firmenich pour activer l''art. 20a LPP.
- Vanessa équivalent : pas de LPP puisqu''indépendante, mais peut souscrire une LPP facultative auprès de sa fondation professionnelle.

**4. Temporaire décès croisée**
- Sur la tête de Lucas : capital 400 000 CHF, durée 25 ans, bénéficiaire nominatif Vanessa (art. 76 LCA). Prime indicative 610 CHF/an non-fumeur.
- Sur la tête de Vanessa : capital 300 000 CHF, durée 25 ans, bénéficiaire nominatif Lucas. Prime indicative 380 CHF/an non-fumeuse.
- Objectif : permettre au survivant de racheter la part successorale et de rembourser une partie de l''hypothèque pour rester dans les critères de tenue économique.
- Attention art. 476 CC : les capitaux d''assurance versés hors succession sont sujets à réunion pour le calcul des réserves. Ici, comme les parents n''ont plus de réserve (art. 471 CC révisé), le risque est faible.

**5. Prévoyance liée 3a maximale**
- Vanessa peut verser le grand pilier 3a jusqu''à 36 288 CHF/an (20 % du revenu net), puisqu''indépendante sans LPP.
- Lucas conserve le petit pilier 7 258 CHF/an.
- Économie fiscale du couple : environ 8 500 CHF/an.
- Vérifier la désignation Vanessa nominative sur le 3a de Lucas et Lucas nominatif sur le 3a de Vanessa.

**Point banque : hypothèque et concubinage**
- Attention : en cas de décès d''un concubin, la banque peut réévaluer la tenue économique. Un capital-décès rapide permet d''éviter la dénonciation du prêt.
- Vérifier également la clause de dévolution dans le contrat hypothécaire : certaines banques exigent la solidarité, d''autres pas.

### 4. Conclusion (3 min)
Monsieur Bertholet, Madame Kolly, votre priorité est de rédiger dès cette semaine deux testaments olographes croisés, de déposer la déclaration de partenariat à la caisse Firmenich, et de souscrire les deux temporaires décès pour 990 CHF cumulés par an. Je vous remets aujourd''hui la fiche art. 45 LSA, un modèle de testament olographe conforme à l''art. 505 CC, le formulaire de partenariat LPP à remplir, et le questionnaire de santé Helvetia et Bâloise. Prochaine étape : sous 10 jours, propositions fermes, mise en couverture provisoire dès la signature. Un rendez-vous chez le notaire dans 4 semaines est également conseillé pour un pacte successoral.

## Questions d''experts type (jury) + réponses modèles

### 1. Question : Vanessa a-t-elle droit à une rente de veuve AVS ?
**Réponse modèle** : Non, absolument pas. L''art. 23 LAVS n''accorde la rente de conjoint survivant qu''aux personnes mariées (ou en partenariat enregistré au sens de la LPart, mais celui-ci ne s''applique plus qu''aux couples de même sexe déjà partenaires enregistrés). Un concubin n''a jamais droit à une rente AVS de survivant.
**Ref légale** : art. 23 LAVS, art. 13a LPGA.

### 2. Question : Le concubinage stable est-il reconnu quelque part en droit fédéral suisse ?
**Réponse modèle** : Marginalement. Il est reconnu en LPP facultative (art. 20a LPP si le règlement le prévoit), en 3a (art. 2 OPP3 comme bénéficiaire de rang 2), et pour certains impôts cantonaux. Sur la succession et la LAA, aucune reconnaissance. Le mariage reste la seule protection complète.
**Ref légale** : art. 20a LPP, art. 2 OPP3, art. 23 LAVS, art. 29 LAA.

### 3. Question : Que se passe-t-il pour l''appartement en copropriété si Lucas meurt sans testament ?
**Réponse modèle** : Sa moitié entre dans sa succession. Comme il n''a ni conjoint ni descendants, ce sont ses parents qui héritent (art. 458 CC). Vanessa devient copropriétaire avec ses beaux-parents. Elle doit soit racheter leur part, soit vendre le bien.
**Ref légale** : art. 458, 462 CC.

### 4. Question : Quelle est la réserve des parents dans le droit successoral révisé 2023 ?
**Réponse modèle** : Depuis le 1er janvier 2023, les parents n''ont plus de réserve héréditaire (art. 471 CC révisé). Si le défunt n''a ni conjoint ni descendants, la quotité disponible est totale : il peut léguer 100 % à qui il veut par testament.
**Ref légale** : art. 471 CC.

### 5. Question : Les capitaux d''assurance sont-ils rapportables à la succession ?
**Réponse modèle** : Les capitaux versés hors succession à un tiers bénéficiaire (art. 78 LCA) ne tombent pas dans la masse successorale, mais ils peuvent être réunis pour le calcul des réserves héréditaires (art. 476 CC). L''action en réduction peut être exercée par un héritier réservataire lésé.
**Ref légale** : art. 78 LCA, art. 476 CC.

### 6. Question : L''ordre des bénéficiaires 3a peut-il être modifié ?
**Réponse modèle** : L''ordre général est impératif (art. 2 OPP3), mais à l''intérieur d''un rang, le preneur peut préciser les quotes-parts par écrit. Au rang 2, il peut aussi choisir entre les concurrents (descendants directs, personne à l''entretien, concubin qualifié). Il ne peut pas passer avant le conjoint survivant sauf en son absence.
**Ref légale** : art. 2 OPP3.

### 7. Question : Le versement de l''EPL de Lucas est-il remboursable en cas de séparation ?
**Réponse modèle** : En cas de séparation d''un couple non marié, le versement EPL suit le sort du bien : Lucas est propriétaire à 50 %, il conserve sa quote-part. Si le bien est vendu, il doit rembourser à la caisse LPP le montant EPL au prorata du prix. Cette obligation est inscrite au registre foncier (art. 30e LPP).
**Ref légale** : art. 30e LPP, art. 331e CO.

### 8. Question : Vanessa peut-elle verser en 3a en tant qu''indépendante sans LPP ?
**Réponse modèle** : Oui, et elle bénéficie du grand pilier : 20 % du revenu net d''activité, plafonné à 36 288 CHF/an en 2026. Elle doit tenir à disposition la preuve du revenu par sa comptabilité de raison individuelle.
**Ref légale** : art. 7 al. 1 let. b OPP3.

### 9. Question : Peut-on rédiger un pacte successoral avec un concubin ?
**Réponse modèle** : Oui, sans restriction. Le pacte successoral est un contrat solennel (acte authentique en présence de deux témoins, art. 512 CC), possible entre toutes personnes capables. Il permet un engagement réciproque plus fort qu''un testament, qui peut être révoqué unilatéralement.
**Ref légale** : art. 512 à 516 CC.

### 10. Question : Quelle est la conséquence fiscale d''un legs à un concubin ?
**Réponse modèle** : L''impôt sur les successions est cantonal. La plupart des cantons romands taxent lourdement le concubin (Genève 24 à 26 %, Vaud 25 %, Fribourg 22 %). Les cantons de Suisse alémanique varient. Le mariage reste très avantageux fiscalement, sauf au Tessin.
**Ref légale** : législations cantonales, art. 24 let. a LIFD (exonération partielle des donations et successions à titre gratuit).

### 11. Question : Que se passe-t-il pour l''hypothèque si Lucas décède ?
**Réponse modèle** : La banque réévalue la tenue économique. Si Vanessa hérite via testament, elle assume la totalité de l''hypothèque. Sans capital-décès, sa charge théorique (intérêts calculés à 4,5 %, amortissement, entretien) peut dépasser un tiers de son revenu, ce qui autorise la banque à dénoncer le prêt.
**Ref légale** : autorégulation ASB, art. 819 CC.

### 12. Question : La temporaire décès sur Lucas peut-elle être mise en gage auprès de la banque ?
**Réponse modèle** : Oui, l''assureur peut accepter la mise en gage au profit de la banque hypothécaire (art. 73 LCA). Cela sécurise directement le remboursement de l''hypothèque en cas de décès. La banque devient bénéficiaire prioritaire à hauteur de la dette.
**Ref légale** : art. 73 LCA.

### 13. Question : Un partenariat enregistré est-il encore possible en 2026 ?
**Réponse modèle** : Non pour de nouveaux partenariats. Depuis le mariage pour tous entré en vigueur le 1er juillet 2022, la conclusion d''un partenariat enregistré n''est plus possible. Les partenariats existants continuent à produire leurs effets ou peuvent être convertis en mariage.
**Ref légale** : LPart, loi mariage pour tous.

### 14. Question : Comment protéger Vanessa contre un enfant qui apparaîtrait ?
**Réponse modèle** : Si Lucas venait à reconnaître ou avoir un enfant, cet enfant deviendrait héritier réservataire (1/2 de sa part légale depuis 2023). Le testament ne peut réduire cette réserve. Une temporaire décès à bénéficiaire nominatif Vanessa reste la meilleure protection concrète, sous réserve de la réunion art. 476 CC.
**Ref légale** : art. 471, 476 CC.

### 15. Question : Le devoir d''information continue de l''art. 3 LCA s''applique-t-il aux temporaires décès ?
**Réponse modèle** : Oui, l''assureur reste tenu d''informer le preneur sur les modifications essentielles du contrat (changement de tarif à échéance, adaptation des conditions). Le devoir d''information ne cesse pas à la signature, contrairement à ce que l''on entend parfois.
**Ref légale** : art. 3 LCA.

## Chiffres-clés à retenir

- Concubin PAS héritier légal (art. 458, 462 CC).
- Concubin PAS bénéficiaire AVS (art. 23 LAVS).
- Concubin PAS bénéficiaire LAA (art. 29 LAA).
- Concubin bénéficiaire LPP possible sous conditions (art. 20a LPP, ménage commun 5 ans + désignation écrite).
- Concubin qualifié = rang 2 du 3a (art. 2 OPP3, 5 ans ménage commun).
- Réserve parents supprimée depuis 2023 (art. 471 CC).
- Réserve descendants 2023 : 1/2 de la part légale.
- Réserve conjoint 2023 : 1/2 de la part légale.
- 3a petit pilier salarié 2026 : 7 258 CHF/an.
- 3a grand pilier indépendant sans LPP : 36 288 CHF/an (max 20 % revenu).
- Partenariat enregistré : plus possible depuis 01.07.2022 (mariage pour tous).
- EPL LPP : art. 30e LPP, obligation de remboursement inscrite au registre foncier.
- Testament olographe : entièrement manuscrit, daté, signé (art. 505 CC).
- Pacte successoral : acte authentique + deux témoins (art. 512 CC).
- Impôt succession concubin canton Vaud : 25 % environ.

## Références légales

- art. 23, 24 LAVS (rente de survivant, exclusion concubin).
- art. 20a LPP (rente de partenaire).
- art. 29 LAA (exclusion du concubin).
- art. 30e LPP (EPL, remboursement).
- art. 2 OPP3 (ordre bénéficiaires 3a).
- art. 7 OPP3 (limites 3a).
- art. 458, 462, 471 CC (droit successoral révisé 2023).
- art. 476 CC (réunion des libéralités).
- art. 499, 505, 512 CC (formes testament, pacte).
- art. 76 à 79 LCA (clause bénéficiaire, insaisissabilité).
- art. 78 LCA (versement hors succession).
- art. 3 LCA (devoir d''information continue).
- art. 73 LCA (mise en gage).
- art. 45 LSA (fiche d''information client).
- LPart, mariage pour tous (juillet 2022).', 40, TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'heriter_leguer'
ON CONFLICT (key) DO UPDATE SET
  title = EXCLUDED.title,
  summary = EXCLUDED.summary,
  content_md = EXCLUDED.content_md,
  sort_order = EXCLUDED.sort_order,
  updated_at = NOW();

INSERT INTO afa_fiches
  (filiere_key, theme_id, key, title, summary, content_md, sort_order, active)
SELECT 'vie', t.id, 'cas_divorce_partage_lpp', 'Cas d''oral : Divorce avec partage LPP (couple 15 ans)',
       'Cas d''examen oral VIE. Couple marié 15 ans, deux enfants, monsieur cadre 130 000 CHF, madame femme au foyer, séparation actée. Analyser partage LPP, prévoyance individuelle post-divorce.', '## Contexte client

### Profil
- Alexandre Studer, 46 ans, ingénieur cadre chez SBB (Berne), salaire brut 130 000 CHF/an.
- Marion Studer née Favre, 43 ans, femme au foyer depuis 12 ans (a arrêté sa carrière d''assistante juridique à la naissance du premier enfant).
- Mariés depuis 15 ans, régime légal de la participation aux acquêts, pas de contrat de mariage.
- Deux enfants : Antoine 12 ans, Sarah 9 ans (garde alternée envisagée).
- Domicile conjugal : maison à Muri (BE), propriété commune 50/50, valeur 1 100 000 CHF, hypothèque 620 000 CHF chez BEKB.
- Avoir LPP Alexandre au 01.01.2011 (mariage) : 45 000 CHF.
- Avoir LPP Alexandre au 01.06.2026 (dépôt requête divorce) : 340 000 CHF.
- Marion : aucune LPP durant le mariage.
- Marion : compte de libre passage de sa carrière antérieure 2001 à 2011 chez Zurich, 68 000 CHF, non touché durant le mariage.
- 3a Alexandre : 82 000 CHF ; 3a Marion : 15 000 CHF non alimenté depuis 12 ans.
- Épargne : compte joint 42 000 CHF, portefeuille placement Alexandre 96 000 CHF, PEE 3b Marion 18 000 CHF.
- Divorce sur requête commune, convention en négociation, contribution d''entretien envisagée 3 800 CHF/mois pour Marion et les enfants.

### Question posée par le client
« Comment se passe le partage de mon 2e pilier avec Marion ? Quelle prévoyance elle aura après le divorce, elle qui n''a rien cotisé ? Et moi, est-ce que ma retraite est fichue ? »

## Trame de présentation (20 min)

### 1. Introduction (2 min)
Bonjour Monsieur Studer. Je me présente : intermédiaire d''assurance non lié, inscrit au registre FINMA, soumis à l''art. 45 LSA. Voici la fiche d''information client. Je vais structurer votre situation en quatre étapes : rappel de la situation matrimoniale et patrimoniale, analyse du mécanisme légal de partage de la prévoyance (art. 122 à 124e CC), impact sur votre propre retraite et celle de Marion, puis solutions concrètes pour reconstruire une prévoyance équilibrée pour vous et pour elle. Comptez vingt minutes, je réserve les questions pour la fin.

### 2. Analyse (7 min)
Je vais d''abord expliquer le mécanisme du partage LPP, puis chiffrer votre situation.

**Principe du partage de la prévoyance professionnelle (art. 122 CC)**
- Depuis la révision du 1er janvier 2017, la date déterminante du partage est celle de l''introduction de la procédure de divorce (le dépôt de la requête), et non plus la date du prononcé du divorce.
- Sont partagées : les prestations de sortie acquises pendant le mariage plus les avoirs sur les comptes de libre passage constitués pendant le mariage.
- La règle : partage par moitié des prestations de sortie acquises pendant le mariage.

**Calcul concret pour Alexandre**
- Avoir LPP au mariage (01.01.2011) : 45 000 CHF.
- Avoir LPP à l''introduction du divorce (01.06.2026) : 340 000 CHF.
- Avoir acquis pendant le mariage : 340 000 CHF moins 45 000 CHF revalorisés avec intérêts LPP (compter environ 55 000 CHF), soit 285 000 CHF.
- Moitié à transférer à Marion : environ 142 500 CHF.

**Calcul concret pour Marion**
- Compte libre passage constitué avant mariage (2001 à 2011) : 68 000 CHF au mariage, non alimenté depuis.
- Cet avoir a été constitué avant le mariage, il n''est pas partagé (revient exclusivement à Marion).

**Solde net du partage**
- Alexandre transfère à Marion : 142 500 CHF vers sa fondation de libre passage ou vers la caisse LPP de son futur employeur si elle reprend une activité.
- Marion conserve : 68 000 CHF (LP pré-mariage) + 142 500 CHF (partage) = 210 500 CHF.
- Alexandre conserve : 340 000 CHF moins 142 500 CHF = 197 500 CHF.

**Effets fiscaux du transfert : art. 22 al. 2 LIFD**
- Le transfert LPP entre ex-conjoints est exonéré d''impôt.
- Il ne peut être versé en cash à Marion, il doit rester dans le circuit de la prévoyance (LPP employeur, compte de libre passage, police de libre passage).

**Régime matrimonial (participation aux acquêts, art. 196 à 220 CC)**
- Les biens propres restent à chacun (héritages, biens amenés au mariage, effets personnels).
- Les acquêts (constitués pendant le mariage) se partagent par moitié.
- La maison : les 220 000 CHF apportés par Alexandre au moment de l''achat sont un bien propre (à retracer). Le solde est acquêt.
- La contribution d''entretien post-divorce (art. 125 CC) tient compte de la répartition traditionnelle des rôles et de l''écart de revenu.

**Situation prévoyance de Marion post-divorce**

| Poste | Situation actuelle | Post-divorce |
|---|---|---|
| LPP obligatoire | 0 (pas d''activité) | 142 500 CHF (LP) |
| LP pré-mariage | 68 000 | 68 000 |
| 3a | 15 000 | 15 000 |
| Rente AVS projetée (65 ans) | Environ 1 800 CHF/mois | Idem, avec bonifications éducatives partagées |

### 3. Solutions (8 min)
Passons aux solutions concrètes.

**Pour Alexandre : reconstruire son 2e pilier**
- Rachats LPP volontaires : le certificat LPP indique désormais une capacité de rachat rouverte par le partage (le partage rouvre la lacune de prévoyance).
- Recommandation : verser 50 000 CHF de rachat en 2026 puis 40 000 CHF en 2027 pour lisser l''économie fiscale sur deux ans (économie estimée à 24 000 CHF au taux marginal cumulé 27 %).
- Attention art. 79b al. 3 LPP : les rachats sont bloqués 3 ans avant tout retrait en capital (ne pas prévoir un retrait EPL ou un retrait capital retraite dans ce délai).

**Pour Alexandre : maintenir le 3a**
- Continuer à verser le plafond 7 258 CHF/an. En cas de contribution d''entretien à Marion, celle-ci sera déductible de son revenu imposable (art. 33 al. 1 let. c LIFD), ce qui compense partiellement la charge fiscale.

**Pour Alexandre : temporaire décès garantie contributions**
- Alexandre paie une contribution d''entretien à Marion et aux enfants. S''il décède, la contribution disparaît.
- Recommandation : temporaire décès de 400 000 CHF, durée 15 ans (jusqu''à la majorité de Sarah à 25 ans si études). Bénéficiaires nominatifs : Antoine et Sarah, par parts égales. Coût indicatif 950 CHF/an.
- Alternative : bénéficiaire Marion à titre fiduciaire, si le juge le prévoit dans la convention.

**Pour Marion : reconstruire une prévoyance**
- Encourager la reprise d''une activité à temps partiel dès que la garde le permet (40 à 60 %). Cela ouvrira les cotisations LPP dès le seuil de 22 680 CHF.
- Verser le petit pilier 3a de 7 258 CHF/an sur les revenus d''activité (compléter le compte existant).
- Sur la part de LPP transférée (142 500 CHF) : maintenir sur un compte de libre passage jusqu''à la reprise d''activité, puis transférer dans la caisse du nouvel employeur.
- Constituer un pilier 3b épargne pour compléter, notamment si l''activité reste à temps très partiel.

**Point AVS : bonifications pour tâches éducatives (art. 29sexies LAVS)**
- Le mariage étant en cours de dissolution, les bonifications éducatives (rente projetée par les enfants de moins de 16 ans) sont attribuées à parts égales entre les conjoints jusqu''au divorce, puis attribuées entièrement au parent qui a la garde.
- Un accord peut aussi être passé pour attribuer les bonifications selon la garde effective en cas de garde alternée.

**Splitting AVS pour Marion (art. 29quinquies LAVS)**
- À la retraite, les revenus AVS des ex-conjoints acquis pendant le mariage sont partagés par moitié.
- Cela évite qu''une femme au foyer soit pénalisée à la retraite pour ne pas avoir cotisé sur revenu.

### 4. Conclusion (3 min)
Monsieur Studer, votre priorité est de finaliser la convention de divorce avec un partage clair de la LPP et une contribution d''entretien réaliste, puis de racheter votre lacune LPP sur deux ans, souscrire la temporaire décès de 400 000 CHF au bénéfice des enfants, et accompagner Marion dans la reconstruction de sa prévoyance. Je vous remets aujourd''hui la fiche art. 45 LSA, le calcul détaillé du partage LPP avec les intérêts, la simulation fiscale des rachats, et le formulaire de désignation des bénéficiaires 3a mis à jour post-divorce (ne pas oublier de retirer Marion). Prochaine étape sous 15 jours : propositions fermes chez Helvetia, Bâloise et Zurich, et coordination avec votre avocat.

## Questions d''experts type (jury) + réponses modèles

### 1. Question : Quelle est la date déterminante pour le partage LPP en cas de divorce ?
**Réponse modèle** : Depuis la révision du 1er janvier 2017, la date déterminante est celle de l''introduction de la procédure de divorce, c''est-à-dire le dépôt de la requête auprès du tribunal. Avant 2017, c''était la date du jugement, ce qui pouvait allonger considérablement la période de calcul.
**Ref légale** : art. 122 CC.

### 2. Question : Le partage est-il toujours par moitié ?
**Réponse modèle** : En principe oui (art. 123 CC). Le juge peut refuser ou réduire le partage si un ou plusieurs motifs importants existent (art. 124b CC), notamment si le partage crée une inéquité manifeste (par exemple si l''autre ex-conjoint est déjà largement pourvu). Une renonciation totale au partage est possible sous conditions strictes (art. 124b al. 1 CC).
**Ref légale** : art. 123, 124b CC.

### 3. Question : Le partage LPP est-il imposé fiscalement ?
**Réponse modèle** : Non. Le transfert de la moitié de la prestation de sortie de l''un vers la LPP ou vers la fondation de libre passage de l''autre est fiscalement neutre, puisque l''avoir reste dans le circuit de la prévoyance. Aucune imposition ni chez le débiteur ni chez le bénéficiaire tant que l''avoir n''est pas retiré.
**Ref légale** : art. 22 al. 2 LIFD.

### 4. Question : Que se passe-t-il si Alexandre a déjà touché sa LPP en capital pour EPL ?
**Réponse modèle** : Les montants versés au titre de l''EPL pendant le mariage sont considérés comme prestation de sortie et sont pris en compte dans le calcul du partage (art. 30c LPP + jurisprudence). Alexandre doit donc restituer sa quote-part correspondante au partage. Le montant peut être bloqué en garantie sur l''immeuble.
**Ref légale** : art. 30c LPP, art. 124a CC.

### 5. Question : Comment sont partagées les rentes d''invalidité LPP en cas de divorce ?
**Réponse modèle** : Depuis 2017, les rentes d''invalidité en cours sont converties en une prestation de sortie hypothétique pour la partie du mariage, puis partagées. Après l''âge de la retraite, les rentes ne sont plus partagées en tant que telles, mais compensées par une indemnité équitable (art. 124a CC).
**Ref légale** : art. 124 et 124a CC.

### 6. Question : Marion peut-elle demander la conversion de sa part LPP en rente immédiate ?
**Réponse modèle** : Non. La part transférée doit rester dans le circuit de la prévoyance jusqu''à la retraite ou un cas prévu (EPL, activité indépendante, départ définitif de Suisse). Elle ne peut être perçue immédiatement en cash.
**Ref légale** : art. 3, 5 LFLP.

### 7. Question : Le splitting AVS s''applique-t-il automatiquement ?
**Réponse modèle** : Oui, à la demande d''un des ex-conjoints au moment de la retraite. Les revenus AVS acquis pendant le mariage sont partagés par moitié entre les deux ex-conjoints, ce qui améliore la rente du conjoint qui a moins cotisé (typiquement la mère au foyer).
**Ref légale** : art. 29quinquies LAVS.

### 8. Question : Que couvrent les bonifications pour tâches éducatives ?
**Réponse modèle** : Elles ajoutent au revenu AVS annuel moyen un montant fictif équivalent à trois fois la rente minimale annuelle, tant que l''enfant a moins de 16 ans. Elles augmentent donc la rente future même si le parent n''a pas ou peu cotisé sur revenu.
**Ref légale** : art. 29sexies LAVS.

### 9. Question : Que se passe-t-il pour le 3a d''Alexandre en cas de divorce ?
**Réponse modèle** : Le 3a n''entre pas dans le partage LPP au sens strict des art. 122 à 124e CC. Il est traité dans le régime matrimonial : la valeur du 3a constituée pendant le mariage est un acquêt et se partage par moitié (art. 197 CC). Le partage se fait alors en cash ou en compensation dans la liquidation.
**Ref légale** : art. 197 CC (acquêts), pas de mécanisme spécifique art. 122 CC.

### 10. Question : Le rachat LPP est-il fiscalement déductible dans l''année du divorce ?
**Réponse modèle** : Oui, sans restriction, à condition de respecter le blocage 3 ans avant retrait en capital (art. 79b al. 3 LPP). Le partage rouvre la capacité de rachat, ce qui est un mécanisme prévu par la loi pour compenser la perte de prévoyance.
**Ref légale** : art. 79b LPP, art. 33 LIFD.

### 11. Question : Marion doit-elle mettre à jour ses désignations de bénéficiaires ?
**Réponse modèle** : Impérativement. Le divorce ne modifie pas automatiquement les clauses bénéficiaires 3a, 3b et vie individuelle. Il faut retirer explicitement l''ex-conjoint et désigner les enfants ou d''autres bénéficiaires. Faute de quoi, en cas de décès, l''ex-conjoint pourrait recevoir la prestation.
**Ref légale** : art. 2 OPP3, art. 76 LCA.

### 12. Question : Le juge peut-il ordonner une indemnité équitable au lieu du partage LPP ?
**Réponse modèle** : Oui, lorsque le partage est impossible ou disproportionné (avoir déjà retiré, rente d''invalidité en cours après la retraite, personne domiciliée à l''étranger). Le juge fixe alors une indemnité équitable versée en capital ou en rente (art. 124e CC).
**Ref légale** : art. 124a, 124e CC.

### 13. Question : Un pacte successoral entre ex-conjoints reste-t-il valable ?
**Réponse modèle** : Non, un pacte successoral entre époux devient caduc par le divorce, sauf disposition contraire expresse dans le pacte lui-même (art. 120 al. 2 CC). Les testaments unilatéraux ne deviennent pas automatiquement caducs, il faut les révoquer expressément.
**Ref légale** : art. 120 al. 2 CC.

### 14. Question : La contribution d''entretien post-divorce est-elle déductible fiscalement pour Alexandre ?
**Réponse modèle** : Oui, entièrement déductible du revenu imposable pour le débirentier (art. 33 al. 1 let. c LIFD). Corrélativement, elle est imposable à 100 % pour Marion (art. 23 let. f LIFD). Les contributions pour les enfants mineurs sont également concernées par cette symétrie.
**Ref légale** : art. 33 al. 1 let. c LIFD, art. 23 let. f LIFD.

### 15. Question : Quelle est la conséquence si Marion se remarie ?
**Réponse modèle** : La contribution d''entretien à Marion s''éteint en cas de remariage (art. 130 al. 2 CC), sauf si la convention prévoit le contraire. La contribution pour les enfants continue d''être due. La rente AVS de veuve, ici sans objet, se serait également éteinte.
**Ref légale** : art. 130 CC, art. 23 al. 4 LAVS.

## Chiffres-clés à retenir

- Date déterminante partage LPP : introduction de la requête de divorce (depuis 2017).
- Partage par moitié des prestations de sortie acquises pendant le mariage.
- Transfert LPP entre ex-conjoints : exonéré d''impôt (art. 22 al. 2 LIFD).
- Splitting AVS : automatique sur demande à la retraite.
- Bonifications éducatives AVS : équivalent à 3 fois la rente minimale annuelle tant que enfant moins 16 ans.
- Rachats LPP après partage : capacité rouverte.
- Blocage 3 ans avant retrait en capital : art. 79b al. 3 LPP.
- Contribution entretien déductible débirentier / imposable crédirentier.
- Contribution s''éteint au remariage du crédirentier.
- EPL LPP peut être bloqué au registre foncier pour garantir le partage.
- 3a n''entre pas dans le partage LPP mais dans les acquêts.
- Réserve descendants 2023 : 1/2.
- Testament unilatéral : à révoquer expressément après divorce.
- Pacte successoral entre époux : caduc au divorce sauf disposition contraire.
- Prestations d''invalidité en cours : partagées jusqu''à l''âge de retraite, puis indemnité équitable.

## Références légales

- art. 122, 123, 124, 124a, 124b, 124e CC (partage prévoyance).
- art. 120 CC (caducité pacte successoral).
- art. 125, 130 CC (contribution d''entretien).
- art. 196 à 220 CC (participation aux acquêts).
- art. 29quinquies, 29sexies LAVS (splitting, bonifications éducatives).
- art. 30c, 30e LPP (EPL et divorce).
- art. 79b LPP (rachats, blocage 3 ans).
- art. 3, 5 LFLP (libre passage, cas de retrait).
- art. 22, 33 LIFD (imposition rentes, déductions).
- art. 23 let. f LIFD (imposition contribution d''entretien).
- art. 2 OPP3 (désignation bénéficiaires 3a).
- art. 76 LCA (clause bénéficiaire).
- art. 45 LSA (fiche d''information client).', 50, TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'retraite'
ON CONFLICT (key) DO UPDATE SET
  title = EXCLUDED.title,
  summary = EXCLUDED.summary,
  content_md = EXCLUDED.content_md,
  sort_order = EXCLUDED.sort_order,
  updated_at = NOW();

INSERT INTO afa_fiches
  (filiere_key, theme_id, key, title, summary, content_md, sort_order, active)
SELECT 'vie', t.id, 'cas_passage_salarie_independant', 'Cas d''oral : Passage salarié à indépendant (freelance IT)',
       'Cas d''examen oral VIE. Cadre 35 ans, salaire 140 000 CHF, quitte pour devenir freelance IT (raison individuelle). Analyser lacunes de prévoyance et proposer une architecture complète.', '## Contexte client

### Profil
- Nicolas Amsler, 35 ans, ingénieur logiciel senior chez UBS (Zurich), salaire brut 140 000 CHF/an (bonus 20 000 CHF non assuré LPP).
- Compagne : Elena, 33 ans, salariée chez Google Suisse, revenu brut 155 000 CHF/an. Non mariés (concubinage stable depuis 6 ans).
- Sans enfant à ce jour, projet dans les 2 à 3 ans.
- Locataires d''un appartement à Zurich Wollishofen, loyer 3 400 CHF/mois.
- Avoir LPP Nicolas : 195 000 CHF chez la caisse UBS.
- 3a Nicolas : 68 000 CHF (deux comptes, UBS et VIAC).
- Épargne disponible : 140 000 CHF sur portefeuille placement diversifié.
- Projet : quitter UBS au 30 septembre 2026 pour ouvrir une raison individuelle IT (conseil et développement logiciel pour clients bancaires). Prévisionnel : 250 000 CHF de facturation la 1ère année, 60 % de marge, soit revenu net prévisible 150 000 CHF (comptable Bruno Grob à Zurich, LOB Sammelstiftung ASGA envisagée).

### Question posée par le client
« Je passe indépendant dans 4 mois. Que se passe-t-il avec mon 2e pilier, mon AVS, ma couverture accident et perte de gain ? Est-ce que je peux garder la même sécurité qu''aujourd''hui, et sinon combien ça coûte ? »

## Trame de présentation (20 min)

### 1. Introduction (2 min)
Bonjour Monsieur Amsler, félicitations pour cette étape entrepreneuriale. Je me présente : intermédiaire d''assurance non lié, inscrit au registre FINMA. Voici la fiche d''information client art. 45 LSA. Le passage salarié à indépendant est un changement de statut majeur en matière de prévoyance : plusieurs couvertures automatiques disparaissent et doivent être reconstruites. Je vous propose la structure suivante : rappel de votre situation, analyse des couvertures perdues et à conserver, chiffrage des lacunes, puis solution complète en trois briques (obligatoire, professionnelle, privée). Comptez vingt minutes, questions à la fin.

### 2. Analyse (7 min)
Je vais analyser ce qui change à trois niveaux : cotisations obligatoires, prévoyance professionnelle, garantie des revenus.

**Statut d''indépendant : reconnaissance par la caisse de compensation**
- La qualité d''indépendant est reconnue par la caisse de compensation cantonale sur la base d''un dossier (locaux, plusieurs clients, autonomie, risque économique).
- L''annonce doit être faite avant le démarrage d''activité (délai formel dans les 30 jours).
- Nicolas devient débiteur direct de ses cotisations AVS, AI, APG.

**Cotisations sociales obligatoires (indépendant)**
- AVS/AI/APG : 10,00 % du revenu déterminant (contre 5,3 % employé + 5,3 % employeur).
- Cotisations dégressives entre le revenu minimum de cotisation (514 CHF/an minimum) et 58 800 CHF/an.
- Assurance chômage : aucune couverture LACI pour l''indépendant (art. 2 LACI a contrario). Point clé : Nicolas perd tout droit au chômage.
- Allocations familiales : facultative selon canton, obligatoire dans certains cantons.

**Prévoyance professionnelle (LPP) : art. 44 LPP**
- L''indépendant n''est pas soumis à la LPP obligatoire.
- Trois options : rester à titre facultatif dans la caisse LPP de l''ancien employeur pendant 2 ans max (art. 47 LPP) ; s''affilier à une fondation professionnelle (par exemple ASGA, Copré, Symova) ou à la caisse de son association professionnelle ; s''affilier à la Fondation institution supplétive (art. 60 LPP).
- À défaut, l''avoir LPP est transféré sur un compte de libre passage.

**LAA : art. 4 LAA**
- L''indépendant n''est pas assuré à la LAA obligatoire.
- Il peut s''assurer à titre facultatif LAA à la SUVA ou auprès d''un assureur privé.
- À défaut, sa couverture accident dépend de son assurance maladie LAMal (couverture accident LAMal art. 8 LAMal).

**Perte de gain maladie et accident**
- Aucune couverture perte de gain collective automatique.
- IJM à souscrire à titre individuel via LCA (assureurs SWICA, Helsana, Visana).
- CO 324a ne s''applique plus (Nicolas n''est plus salarié).

**Prévoyance liée 3a : art. 7 al. 1 OPP3**
- Si Nicolas s''affilie à une LPP facultative : petit pilier 3a à 7 258 CHF/an.
- Si Nicolas ne s''affilie pas à la LPP : grand pilier 3a à 20 % du revenu net, plafonné à 36 288 CHF/an en 2026.

**Chiffrage de la perte de couverture (salarié versus indépendant, hors 3a)**

| Couverture | Salarié UBS | Indépendant sans souscription |
|---|---|---|
| Cotisations AVS/AI/APG salarié + employeur | 14 840 CHF/an | 15 000 CHF/an à sa charge |
| Chômage (LACI) | Oui (100 %) | Perte totale |
| LAA accident | Oui, gain assuré 148 200 CHF | Perte totale |
| Perte de gain maladie | 90 % du salaire pendant 730 j | Perte totale |
| LPP (part employeur) | Environ 12 000 CHF/an | Perte totale, à assumer seul |
| Rente d''invalidité LPP | Oui, projetée | Perte totale sauf souscription |

### 3. Solutions (8 min)
Passons aux solutions. Architecture recommandée en trois briques.

**Brique 1 : socle obligatoire**
- Annonce à la caisse de compensation dans les 30 jours du démarrage.
- Affiliation à la caisse-maladie LAMal avec couverture accident intégrée (art. 8 LAMal).

**Brique 2 : prévoyance professionnelle facultative (recommandé)**
- Affiliation à ASGA ou Copré via fondation collective, avec choix d''un plan LPP :
  - Plan de base LPP obligatoire minimum.
  - Plan surobligatoire cadre : salaire assuré 140 000 CHF, cotisation 20 % (deux tiers Nicolas, un tiers ex-employeur, mais ici tout à sa charge).
- Avantage : accès aux rachats LPP déductibles, à la rente d''invalidité LPP, à la couverture décès.
- Effet fiscal : environ 28 000 CHF/an de cotisation, déductible intégralement du revenu (économie 8 400 CHF).

**Brique 3 : LAA facultative + IJM privée**
- LAA facultative SUVA (art. 4 LAA) : couvre les accidents professionnels et non professionnels, prestations identiques à la LAA obligatoire. Prime environ 1,4 % du revenu assuré, soit 1 400 CHF pour 100 000 CHF de gain assuré.
- IJM LCA privée : 80 % du revenu, délai d''attente 60 jours, durée 730 jours, couvre maladie. Prime environ 3 500 CHF/an pour 100 000 CHF de revenu couvert.
- Alternative : LAA facultative + LAA-C (surassurance salaire au-delà de 148 200 CHF).

**Brique 4 : décès et invalidité complémentaires**
- Souscrire une temporaire décès pour protéger Elena (concubine, non héritière) : capital 400 000 CHF sur 25 ans, prime environ 480 CHF/an.
- Souscrire une rente invalidité complémentaire : 24 000 CHF/an, délai d''attente 24 mois, coordonnée avec la LPP facultative.
- Attention : Elena étant concubine sans enfant commun, elle n''a droit à rien en LAA (art. 29 LAA) et ne bénéficie qu''à titre conditionnel de la LPP (art. 20a LPP, si règlement ASGA le prévoit et désignation écrite).

**Brique 5 : prévoyance liée 3a maximisée**
- Si Nicolas s''affilie à une LPP facultative : petit pilier 7 258 CHF/an.
- Si Nicolas ne s''affilie pas à la LPP : grand pilier 36 288 CHF/an (20 % du revenu net, soit 30 000 CHF sur un revenu de 150 000 CHF).
- Recommandation : combiner LPP facultative pour la couverture invalidité/décès + petit pilier 3a. C''est plus complet qu''un grand pilier 3a seul.

**Traitement de l''avoir LPP existant (195 000 CHF)**
- Option A : maintien facultatif dans la caisse UBS pendant 2 ans max (art. 47 LPP). Utile si transition.
- Option B : transfert vers la nouvelle fondation LPP (ASGA) : recommandée.
- Option C : versement en capital pour financement du démarrage d''activité (art. 5 al. 1 let. b LFLP). Attention à la fiscalité (impôt séparé) et à la coordination avec le blocage 3 ans art. 79b LPP.

### 4. Conclusion (3 min)
Monsieur Amsler, l''architecture recommandée coûte environ 42 000 CHF/an de couvertures (LPP facultative 28 000 + LAA facultative 2 000 + IJM 3 500 + temporaire décès 500 + rente invalidité 2 500 + 3a 7 258). Rapporté à votre revenu net de 150 000 CHF, c''est environ 28 % de charge sociale et prévoyance, avec économie fiscale d''environ 12 000 CHF/an. Prochaines étapes : je vous remets aujourd''hui la fiche art. 45 LSA, le comparatif ASGA/Copré/Symova, la simulation LAA facultative SUVA, et le questionnaire de santé. Je vous propose un rendez-vous conjoint avec votre comptable Bruno Grob dans 2 semaines pour aligner comptabilité et prévoyance.

## Questions d''experts type (jury) + réponses modèles

### 1. Question : Quelle est la principale différence de statut social entre salarié et indépendant ?
**Réponse modèle** : L''indépendant assume seul toutes les cotisations sociales (AVS 10 %, LPP 100 %) alors qu''un salarié partage avec l''employeur. Il perd la LAA obligatoire, la LACI (aucun chômage) et la protection CO 324a. Il gagne en flexibilité fiscale (déduction des rachats LPP, grand pilier 3a possible) mais assume la totalité du risque économique.
**Ref légale** : art. 4 LAA, art. 2 LACI a contrario, art. 44 LPP, art. 7 OPP3.

### 2. Question : Comment la qualité d''indépendant est-elle reconnue ?
**Réponse modèle** : Par la caisse de compensation cantonale, sur la base de critères cumulatifs : action pour son propre compte, autonomie économique, risque économique, plusieurs clients, locaux propres, facturation en son nom. La reconnaissance n''est pas automatique et peut être refusée.
**Ref légale** : art. 9 LAVS, art. 6 RAVS.

### 3. Question : Nicolas doit-il obligatoirement s''affilier à la LPP en tant qu''indépendant ?
**Réponse modèle** : Non, la LPP n''est pas obligatoire pour l''indépendant (art. 44 LPP). Il peut choisir de s''affilier à titre facultatif à la caisse de son ex-employeur (art. 47 LPP, max 2 ans), à une fondation professionnelle, ou à l''institution supplétive (art. 60 LPP).
**Ref légale** : art. 44, 47, 60 LPP.

### 4. Question : Que devient l''avoir LPP existant en cas de passage à l''indépendance ?
**Réponse modèle** : Il peut être : transféré vers la nouvelle caisse (obligatoire s''il s''affilie facultativement) ; maintenu sur un compte de libre passage ; ou versé en capital en tant que cas de sortie ordinaire prévu à l''art. 5 al. 1 let. b LFLP (départ à l''indépendance). Le versement en capital est imposé séparément art. 38 LIFD.
**Ref légale** : art. 5 LFLP, art. 38 LIFD.

### 5. Question : Qu''est-ce que le grand pilier 3a ?
**Réponse modèle** : C''est la limite de versement 3a réservée aux indépendants non affiliés à la LPP : 20 % du revenu net d''activité, plafonné à 36 288 CHF/an en 2026. C''est un mécanisme compensatoire pour la lacune de LPP obligatoire.
**Ref légale** : art. 7 al. 1 let. b OPP3.

### 6. Question : Peut-on cumuler LPP facultative et grand pilier 3a ?
**Réponse modèle** : Non. Dès que Nicolas s''affilie à une LPP (obligatoire ou facultative), il retombe dans le petit pilier 3a plafonné à 7 258 CHF/an. Le grand pilier est exclusif à l''absence totale de LPP.
**Ref légale** : art. 7 al. 1 OPP3.

### 7. Question : L''indépendant peut-il souscrire une IJ LAMal ?
**Réponse modèle** : Oui, l''indemnité journalière LAMal (art. 67 à 77 LAMal) est facultative et ouverte à toute personne assurée en LAMal, y compris indépendants. En pratique, elle est peu utilisée car les couvertures LCA sont plus généreuses et souples. Durée maximale 720 jours dans une période de 900.
**Ref légale** : art. 67 à 77 LAMal.

### 8. Question : Que couvre la LAA facultative pour un indépendant ?
**Réponse modèle** : Les mêmes prestations que la LAA obligatoire : soins, indemnités journalières (80 % dès le 3e jour), rente d''invalidité (jusqu''à 80 % du gain assuré), rente survivants, IAI en capital. Le gain assuré maximum est de 148 200 CHF en 2026, sauf souscription d''une LAA-C complémentaire.
**Ref légale** : art. 4, 15 LAA.

### 9. Question : Elena, concubine, a-t-elle des droits en cas de décès de Nicolas ?
**Réponse modèle** : Rien en LAVS (pas de rente veuve concubin). Rien en LAA (art. 29 LAA). En LPP facultative, uniquement si le règlement ASGA prévoit la rente de partenaire (art. 20a LPP) et si Nicolas la désigne par écrit et vit ménage commun 5 ans. En 3a, rang 2 comme concubine qualifiée avec 5 ans de ménage commun (art. 2 OPP3) : ils y sont, elle est éligible. Elena peut également être désignée nominativement sur une temporaire décès (art. 76 LCA).
**Ref légale** : art. 23 LAVS, 29 LAA, 20a LPP, 2 OPP3, 76 LCA.

### 10. Question : Nicolas peut-il conserver l''ancienne perte de gain UBS ?
**Réponse modèle** : Non, la couverture PGM collective d''UBS s''éteint au terme du contrat de travail. Nicolas doit souscrire une IJM privée LCA à titre individuel. Certains contrats collectifs prévoient une clause de free-cover ou de continuation individuelle sans questionnaire de santé si demandée dans les 3 mois.
**Ref légale** : conditions du contrat collectif LCA UBS, art. 100 LCA (renvoi CO).

### 11. Question : Que se passe-t-il si Nicolas décède accidentellement dans le mois suivant son départ d''UBS ?
**Réponse modèle** : L''ancienne LAA UBS couvre encore les accidents non professionnels pendant 31 jours après la fin du rapport de travail (art. 3 al. 2 LAA). Passé ce délai, plus aucune couverture LAA sauf souscription. L''indépendant peut également prolonger la couverture par une convention d''assurance individuelle pendant 6 mois maximum.
**Ref légale** : art. 3 al. 2 LAA.

### 12. Question : Comment est calculée la cotisation AVS de l''indépendant ?
**Réponse modèle** : Sur le revenu déterminant net de l''activité indépendante, à un taux de base de 10,00 % (AVS 8,10 %, AI 1,40 %, APG 0,50 %). Le taux est dégressif pour les revenus modestes (barème dégressif entre 9 800 et 58 800 CHF/an).
**Ref légale** : art. 8 LAVS, art. 21 RAVS.

### 13. Question : Nicolas peut-il racheter des années de LPP dans la nouvelle caisse ?
**Réponse modèle** : Oui, si le règlement de la nouvelle caisse le prévoit. Le calcul de la lacune de rachat est effectué par la caisse sur la base des cotisations théoriques manquantes. Blocage 3 ans avant retrait en capital (art. 79b al. 3 LPP). Attention aux règles spécifiques de rachat pour les personnes venant de l''étranger (5 ans limité à 20 % du salaire assuré).
**Ref légale** : art. 79b LPP, art. 60b OPP2.

### 14. Question : Que se passe-t-il si Nicolas cesse son activité indépendante et redevient salarié ?
**Réponse modèle** : Il retombe automatiquement sous le régime obligatoire LAA, LPP, LACI dès son nouveau contrat. L''avoir LPP privé qu''il a constitué est transféré vers la caisse du nouvel employeur. Il perd les avantages du grand pilier 3a. La couverture LAA facultative peut être résiliée.
**Ref légale** : art. 44, 47 LPP, art. 4 LAA.

### 15. Question : Quels sont les impacts fiscaux d''un rachat LPP pour un indépendant ?
**Réponse modèle** : Le rachat est intégralement déductible du revenu imposable (art. 33 al. 1 let. d LIFD). Économie fiscale immédiate. Bloqué 3 ans avant tout retrait en capital (art. 79b al. 3 LPP). C''est un des principaux avantages d''être affilié à une LPP, même à titre facultatif, pour un indépendant à haut revenu.
**Ref légale** : art. 33 LIFD, art. 79b LPP.

## Chiffres-clés à retenir

- AVS indépendant : 10,00 % du revenu, dégressif jusqu''à 58 800 CHF.
- LACI : aucune couverture pour l''indépendant (art. 2 LACI a contrario).
- LAA obligatoire : ne s''applique pas à l''indépendant (art. 4 LAA).
- LAA facultative : prime ~1,4 % du revenu assuré à la SUVA.
- Gain assuré maximum LAA : 148 200 CHF/an.
- LPP obligatoire : ne s''applique pas à l''indépendant (art. 44 LPP).
- LPP facultative : ex-caisse 2 ans max (art. 47), fondation, institution supplétive (art. 60).
- 3a petit pilier avec LPP : 7 258 CHF/an.
- 3a grand pilier sans LPP : 36 288 CHF/an (max 20 % revenu).
- Prolongation LAA post-emploi : 31 jours automatique + 6 mois convention.
- Retrait LPP en capital : cas d''indépendance art. 5 al. 1 let. b LFLP.
- Blocage rachats LPP : 3 ans avant retrait capital.
- CO 324a : ne s''applique pas à l''indépendant.
- IJM LAMal facultative : durée max 720 jours dans 900.
- Reconnaissance qualité indépendant : caisse de compensation cantonale.

## Références légales

- art. 4, 15 LAA (indépendant, gain assuré).
- art. 3 al. 2 LAA (prolongation couverture 31 jours).
- art. 44, 47, 60 LPP (indépendant, ex-caisse, institution supplétive).
- art. 79b LPP (blocage rachats).
- art. 20a LPP (rente de partenaire, concubinage).
- art. 5 LFLP (cas de retrait en capital).
- art. 7, 2 OPP3 (limites 3a, ordre bénéficiaires).
- art. 8, 9 LAVS, art. 6, 21 RAVS (cotisations, statut indépendant).
- art. 2 LACI a contrario (exclusion indépendant).
- art. 67 à 77 LAMal (IJ LAMal facultative).
- art. 8 LAMal (couverture accident LAMal).
- art. 33, 38 LIFD (déductions rachats, imposition capital).
- art. 324a CO (non applicable indépendant).
- art. 60b OPP2 (rachats personnes venant de l''étranger).
- art. 45 LSA (fiche d''information client).', 60, TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'activite_independante'
ON CONFLICT (key) DO UPDATE SET
  title = EXCLUDED.title,
  summary = EXCLUDED.summary,
  content_md = EXCLUDED.content_md,
  sort_order = EXCLUDED.sort_order,
  updated_at = NOW();

-- ───────── cas_oraux_lot2.json — 6 fiche(s) ─────────
INSERT INTO afa_fiches
  (filiere_key, theme_id, key, title, summary, content_md, sort_order, active)
SELECT 'vie', t.id, 'cas_achat_immobilier_retrait_3a_lpp', 'Cas d''oral : Achat immobilier (retrait 3a + LPP EPL)',
       'Cas d''examen oral VIE. Couple Bernard, 38 et 36 ans, 2 enfants, achat maison Bulle 950 000 CHF, fonds propres 190 000 CHF. Analyser la stratégie de financement prévoyance (3a, LPP, mise en gage) et ses impacts sur retraite, décès, invalidité.', '## Contexte client

### Profil
- Couple Marc et Sophie Bernard, mariés sous le régime de la participation aux acquêts.
- Marc, 38 ans, ingénieur logiciel à Bulle (FR), CDI chez Liebherr, salaire brut 115 000 CHF/an plus bonus variable 8 000 CHF, LPP obligatoire pleine.
- Sophie, 36 ans, physiothérapeute indépendante à 60 % (cabinet propre à Bulle), revenu net imposable 45 000 CHF/an, non affiliée LPP obligatoire, cotise 3a pilier grand (36 288 CHF plafond 2026 mais elle verse 12 000 CHF/an).
- Deux enfants : Léa 8 ans et Nathan 5 ans, scolarité publique.
- Projet : achat maison individuelle à Bulle, prix 950 000 CHF (zone à bâtir, hors LDFR).
- Fonds propres disponibles : 95 000 CHF cash (livret d''épargne du couple plus héritage de la grand-mère de Sophie), 3a Marc 55 000 CHF (police 3a UBS Vitainvest), 3a Sophie 40 000 CHF (compte 3a fondation BCF).
- Avoirs LPP de Marc : 185 000 CHF certifiés par la caisse de pension patronale.
- Aucune dette autre que carte de crédit soldée mensuellement.

### Question posée par le client
« Nous voulons acheter cette maison et nos parents nous poussent à retirer notre 3a et une partie de la LPP pour boucler les fonds propres. On nous dit que c''est fiscalement intelligent, mais qu''en est-il de notre retraite dans 30 ans ? Que faudrait-il faire concrètement, et quels documents devez-vous nous remettre avant que nous signions quoi que ce soit ? »

## Trame de présentation (20 min)

### 1. Introduction (2 min)

Je vous présente aujourd''hui la situation de la famille Bernard, un couple de 38 et 36 ans avec deux enfants en bas âge, qui souhaite acheter sa résidence principale à Bulle pour 950 000 CHF. Le sujet du jour est le financement immobilier au moyen des avoirs de prévoyance (2e et 3e piliers), et surtout l''impact que cette mobilisation aura sur la couverture retraite, décès et invalidité du couple. Je vais d''abord exposer le cadre légal (encouragement à la propriété du logement selon la LPP et l''OEPL), puis je chiffrerai les besoins en fonds propres, ensuite je proposerai une stratégie mixte 3a plus cash plus mise en gage LPP, et je terminerai par les documents que je remettrai au couple (fiche d''information client au sens de l''art. 45 LSA, questionnaire des besoins, comparatif hypothécaire).

### 2. Analyse (7 min)

Le premier calcul est celui des fonds propres exigés. La règle bancaire suisse impose 20 % de la valeur du bien, soit 190 000 CHF, dont 10 % au minimum doivent provenir de fonds hors 2e pilier (art. 4 al. 2 OEPL), ce qui représente 95 000 CHF. Le couple dispose exactement de 95 000 CHF cash, donc la condition « 10 % hors LPP » est satisfaite sans avoir à toucher au 2e pilier.

Restent 95 000 CHF à trouver, soit les 10 % supplémentaires. Trois pistes : retrait de la totalité des 3a du couple (55 000 plus 40 000 = 95 000 CHF, ce qui couvre pile), retrait partiel LPP de Marc, ou mise en gage LPP.

Le retrait 3a est autorisé pour l''acquisition du logement principal (art. 5 al. 1 OEPL et art. 3 al. 3 OPP3). Il n''y a pas de minimum pour le 3a (le plancher de 20 000 CHF ne concerne que le 2e pilier). Il est imposé séparément du reste du revenu, à un taux réduit spécifique (canton de Fribourg : entre 4,5 % et 6 % environ pour ce niveau de capital, soit un impôt total estimé de l''ordre de 5 000 à 5 500 CHF pour 95 000 CHF de retrait combiné).

Le retrait LPP de Marc est possible à tout âge jusqu''à 3 ans avant l''âge ordinaire de la retraite (art. 30c al. 1 LPP), avec un minimum de 20 000 CHF (art. 5 al. 1 OEPL) et pas plus d''un retrait tous les 5 ans. Il réduira toutefois proportionnellement : la prestation de vieillesse future, la prestation en cas de décès (rente veuve et rente d''orphelin) et la prestation en cas d''invalidité. Le certificat LPP indique que Marc perdrait environ 8 400 CHF/an de rente vieillesse s''il retire 90 000 CHF, plus une réduction proportionnelle de la rente d''invalidité.

La mise en gage (art. 30b LPP) est l''alternative moins connue : la banque nantit l''avoir LPP en garantie, sans que Marc n''ait à le retirer. Aucune fiscalité immédiate, aucune réduction des prestations de prévoyance, mais l''avoir devient saisissable par la banque en cas de défaut de paiement.

Tableau récapitulatif de la charge financière :

| Poste | Montant CHF | Commentaire |
|---|---|---|
| Prix d''achat | 950 000 | Bulle, maison individuelle |
| Fonds propres 20 % | 190 000 | dont 95 000 hors 2e pilier |
| Hypothèque 1er rang (65 %) | 617 500 | Amortissement libre |
| Hypothèque 2e rang (15 %) | 142 500 | Amortissement obligatoire 15 ans jusqu''à 2/3 |
| Charge théorique 5 % plus entretien 1 % plus amort | env. 53 000/an | À comparer au tiers du revenu brut (env. 53 300) |

La charge théorique passe tout juste (règle du tiers). Sophie étant indépendante, la banque décote généralement son revenu à 80 % : la faisabilité est à confirmer en négociation.

### 3. Solutions (8 min)

Ma recommandation principale : mix 3a partiel plus mise en gage LPP.

Solution proposée :
- Cash : 95 000 CHF (couvre les 10 % hors 2e pilier).
- Retrait 3a de Sophie : 40 000 CHF (elle a 30 ans devant elle pour reconstituer).
- Retrait 3a de Marc : 30 000 CHF (garde 25 000 CHF actifs sur son 3a pour maintenir le levier fiscal annuel).
- Mise en gage LPP de Marc : 25 000 CHF (sécurise la prévoyance sans la réduire).

Argumentaire :
- On préserve 25 000 CHF de 3a Marc, ce qui maintient le cycle de déductions fiscales annuelles (Marc peut continuer à verser 7 258 CHF/an, plafond 2026 pilier lié avec LPP, déductible directement du revenu imposable).
- On évite le retrait LPP sec : la prestation vieillesse future n''est pas amputée. La mise en gage n''a d''effet ni fiscal ni sur les prestations, elle n''est activée qu''en cas de défaut.
- La fiscalité globale du retrait 3a partiel (70 000 CHF cumulés à répartir sur deux personnes deux années civiles distinctes) est estimée à environ 3 500 CHF, économie de 1 500 à 2 000 CHF versus retrait total.

Amortissement obligatoire : 142 500 CHF sur 15 ans (art. 6 OEPL par la banque, jusqu''à 2/3 de la valeur de nantissement), soit environ 9 500 CHF/an. Le couple peut choisir amortissement direct (remboursement effectif du capital, réduction annuelle de la dette et des intérêts déductibles) ou amortissement indirect via un 3a de Marc nanti au profit de la banque (versement de 9 500 CHF/an sur son 3a, dette hypothécaire constante et intérêts pleinement déductibles chaque année). Pour Marc, taux marginal élevé, l''amortissement indirect est fiscalement plus avantageux (économie annuelle estimée 1 500 à 2 000 CHF).

Couverture décès et invalidité : on ajoutera une assurance de risque pur (3b) sur la tête de Marc, capital décès 500 000 CHF pour couvrir le solde hypothécaire résiduel en cas de disparition prématurée (prime annuelle estimée entre 900 et 1 100 CHF pour un non-fumeur en bonne santé). Alternative : assurance-vie mixte 3a en pilier lié combinant épargne pour amortissement indirect et protection décès sur la même police.

Documents à recueillir avant offre : certificat LPP Marc, attestations 3a des deux fondations, dernières taxations fiscales, justificatifs de fonds propres (extrait bancaire, acte de succession), extrait registre des poursuites, projet d''acte de vente notarié, questionnaire de santé pour la 3b.

### 4. Conclusion (3 min)

En synthèse, le couple Bernard peut acheter sereinement grâce à un mix intelligent : 95 000 CHF cash, 70 000 CHF de 3a (partiels), 25 000 CHF de LPP en mise en gage. La prévoyance vieillesse de Marc est préservée à 87 %, le levier fiscal 3a est maintenu, la protection décès de la famille est renforcée par une assurance-vie 3b de 500 000 CHF. Je remettrai au couple, avant tout début de conseil approfondi, la fiche d''information client au sens de l''art. 45 LSA (identité, statut d''intermédiaire non lié, partenaires assurances et fondations 3a, rémunération par commission et non honoraires, procédure de médiation ombudsman), le questionnaire d''analyse des besoins signé par les deux conjoints, la fiche d''information EPL détaillée avec impact chiffré sur la prévoyance, la simulation d''imposition sur retrait, et un comparatif de trois assurances-vie 3b. Un rendez-vous de signature est fixé sous 15 jours.

## Questions d''experts type + réponses modèles

### 1. Question : Quel est le montant minimum de retrait autorisé pour l''encouragement à la propriété du logement en 2e pilier ?
**Réponse modèle** : Le minimum légal est de 20 000 CHF pour un retrait LPP (art. 5 al. 1 OEPL). Ce plancher ne s''applique pas au 3e pilier lié (3a), qui peut être retiré sans montant minimum. Le retrait LPP n''est possible qu''une fois tous les 5 ans.
**Ref légale** : art. 5 al. 1 OEPL, art. 30c LPP.

### 2. Question : Après 50 ans, quelle est la règle particulière pour le retrait EPL ?
**Réponse modèle** : L''assuré ne peut retirer que le plus élevé des deux montants suivants : soit la moitié de son avoir actuel, soit le montant qu''il avait à disposition à 50 ans. Cela protège une part significative de la prévoyance vieillesse à l''approche de la retraite.
**Ref légale** : art. 30c al. 2 LPP.

### 3. Question : Peut-on toujours racheter les avoirs LPP retirés dans le cadre de l''EPL ?
**Réponse modèle** : Oui, le remboursement volontaire est possible jusqu''à 3 ans avant l''âge de la retraite. Le montant remboursé n''est pas déductible du revenu imposable (contrairement à un rachat classique), mais l''impôt payé lors du retrait peut être remboursé au prorata sur demande dans les 3 ans qui suivent le remboursement, sans intérêt.
**Ref légale** : art. 30d LPP, art. 83a LPP.

### 4. Question : Quelle est la différence pratique entre retrait et mise en gage ?
**Réponse modèle** : Le retrait sort l''argent définitivement de la prévoyance et réduit les prestations futures (vieillesse, décès, invalidité). Il est imposé à un taux réduit séparé au moment du retrait. La mise en gage laisse les avoirs dans la caisse de pension : aucune fiscalité immédiate, aucune réduction des prestations, mais la banque peut saisir l''avoir gagé en cas de défaut. La caisse est informée par écrit et bloque l''avoir.
**Ref légale** : art. 30b LPP, art. 8 OEPL.

### 5. Question : Rappelez le calendrier d''amortissement obligatoire.
**Réponse modèle** : La dette hypothécaire doit être ramenée aux 2/3 de la valeur de nantissement dans un délai de 15 ans, et au plus tard jusqu''à l''âge de la retraite ordinaire. Cela concerne l''hypothèque de 2e rang. L''amortissement peut être direct (remboursement effectif du capital) ou indirect (versement 3a nanti au profit de la banque).
**Ref légale** : art. 6 OEPL, directives ASB sur les affaires hypothécaires.

### 6. Question : Fiscalement, comment est imposé un retrait 3a pour EPL ?
**Réponse modèle** : Le retrait est imposé séparément du reste du revenu, à un barème réduit spécifique (impôts fédéral, cantonal et communal). L''impôt est prélevé à la source par la fondation 3a, sur la base d''un formulaire remis à l''administration cantonale du domicile. Le taux effectif tourne autour de 4 à 6 % selon le canton et le montant.
**Ref légale** : art. 38 LIFD, art. 11 al. 3 LHID.

### 7. Question : Un couple achète ensemble. Doivent-ils tous les deux effectuer un retrait ?
**Réponse modèle** : Non, chaque conjoint est libre de retirer ou non ses propres avoirs. Le retrait EPL suppose toutefois l''accord écrit du conjoint (signature légalisée obligatoire) car il touche à la prévoyance familiale. Le bien acquis doit être utilisé personnellement par le preneur (résidence principale).
**Ref légale** : art. 30c al. 5 LPP.

### 8. Question : Est-ce que le retrait EPL affecte les prestations en cas d''invalidité ?
**Réponse modèle** : Oui. La prestation d''invalidité de la LPP est calculée sur l''avoir vieillesse projeté ; le retrait réduit ce socle et donc la rente d''invalidité, ainsi que les rentes d''enfant d''invalide. Il convient de proposer une couverture complémentaire 3b (assurance de risque pur invalidité) pour combler la lacune.
**Ref légale** : art. 24 LPP, règlement propre à la caisse de pension.

### 9. Question : Quelles conséquences en cas de vente ultérieure du bien acquis avec un retrait EPL ?
**Réponse modèle** : Le montant retiré doit être remboursé à l''institution de prévoyance dans la mesure où le produit de la vente le permet, sauf remploi dans un nouveau logement principal dans un délai de 2 ans. Cette obligation est garantie par une restriction du droit d''aliéner mentionnée au registre foncier.
**Ref légale** : art. 30d al. 1 lit. a LPP, art. 30e LPP.

### 10. Question : Peut-on retirer le 3a avant 60 ans hors EPL ?
**Réponse modèle** : Oui, dans cinq cas : encouragement à la propriété du logement (résidence principale), départ définitif de Suisse, début d''activité indépendante, rente d''invalidité entière AI, ou pour effectuer un rachat LPP. Sinon, le retrait n''est possible qu''à partir de 5 ans avant l''âge ordinaire de la retraite (60 ans pour un homme).
**Ref légale** : art. 3 al. 2 et 3 OPP3.

### 11. Question : Qu''est-ce que l''amortissement indirect présente comme avantage fiscal ?
**Réponse modèle** : L''amortissement indirect consiste à verser l''annuité d''amortissement sur un 3a nanti au profit de la banque. La dette hypothécaire reste constante (intérêts pleinement déductibles chaque année), l''assuré bénéficie de la déduction annuelle du 3a, et le capital constitué à l''échéance rembourse la dette. Fiscalement, l''économie cumulée sur 15 ans peut représenter 20 000 à 30 000 CHF pour un revenu moyen.
**Ref légale** : art. 82 LPP, art. 33 al. 1 lit. e LIFD.

### 12. Question : Quelle est la règle du tiers appliquée par les banques ?
**Réponse modèle** : La charge théorique (intérêts calculés à 4,5 à 5 % selon la banque, plus entretien 1 % de la valeur du bien, plus amortissement) ne doit pas excéder le tiers du revenu brut du ménage. C''est un critère prudentiel de la FINMA et de l''ASB pour prévenir les défauts en cas de hausse des taux.
**Ref légale** : circulaire FINMA 2017/2, directives ASB affaires hypothécaires.

### 13. Question : Fiscalité de la propriété : valeur locative ?
**Réponse modèle** : Le propriétaire déclare la valeur locative comme revenu imposable, en contrepartie il peut déduire les intérêts hypothécaires ainsi que les frais d''entretien (effectifs ou forfaitaires). Une réforme fédérale de suppression est en discussion mais la valeur locative reste en vigueur en 2026.
**Ref légale** : art. 21 al. 1 lit. b LIFD, art. 7 al. 1 LHID.

### 14. Question : Un couple divorce, l''EPL a été fait avant le mariage. Comment est-il traité au partage ?
**Réponse modèle** : Les avoirs 2e pilier accumulés pendant le mariage se partagent en cas de divorce, y compris la valeur du retrait EPL non remboursé, qui est réintégrée fictivement au moment du calcul de la prestation de sortie. Cela peut réserver des surprises désagréables.
**Ref légale** : art. 122 CC, art. 22a LFLP.

### 15. Question : L''assurance-vie 3b est-elle déductible ?
**Réponse modèle** : Les primes 3b sont partiellement déductibles au titre de la déduction générale des primes d''assurance et d''intérêts sur les capitaux d''épargne (plafond modeste : environ 1 700 CHF pour une personne seule, 3 500 CHF pour un couple avec enfants, variable selon les cantons). L''imposition à la sortie dépend du produit : assurance-vie mixte à prime unique = imposition partielle des rendements ; assurance-risque pur = pas d''imposition à la sortie car pas de rendement.
**Ref légale** : art. 33 al. 1 lit. g LIFD, art. 20 al. 1 lit. a LIFD.

## Chiffres-clés à retenir

- Prix d''achat : 950 000 CHF ; fonds propres 20 % = 190 000 CHF.
- Part hors 2e pilier : 10 % au minimum = 95 000 CHF (art. 4 al. 2 OEPL).
- Retrait EPL LPP : minimum 20 000 CHF ; pas de minimum pour le 3a.
- Après 50 ans : max = plus élevé de (avoir actuel/2) ou (avoir à 50 ans).
- Amortissement 15 ans jusqu''à 2/3 de la valeur de nantissement (art. 6 OEPL).
- Retrait LPP possible jusqu''à 3 ans avant l''âge ordinaire de la retraite.
- 3a plafond 2026 : 7 258 CHF (avec LPP), 36 288 CHF (sans LPP, 20 % du revenu net max).
- Impôt retrait 3a canton Fribourg : taux effectif ~4 à 6 %.
- Charge théorique bancaire : 4,5 à 5 % plus 1 % entretien plus amortissement, max 1/3 revenu brut.
- Amortissement indirect via 3a : économie fiscale cumulée 20 000 à 30 000 CHF sur 15 ans.
- Consentement conjoint obligatoire (signature légalisée) pour retrait ou gage.
- Restriction du droit d''aliéner mentionnée au registre foncier après retrait EPL.
- Assurance 3b risque pur décès : prime env. 900 à 1 100 CHF/an pour 500 000 CHF capital, homme 38 ans non-fumeur.

## Références légales

- Art. 30b LPP : mise en gage.
- Art. 30c LPP : versement anticipé pour propriété du logement.
- Art. 30d LPP : remboursement.
- Art. 30e LPP : mention au registre foncier (restriction du droit d''aliéner).
- Art. 24 LPP : prestations d''invalidité.
- Art. 82 LPP : pilier 3a lié.
- Art. 83a LPP : remboursement d''impôt sur restitution EPL.
- Art. 4 al. 2 OEPL : 10 % de fonds propres hors 2e pilier.
- Art. 5 al. 1 OEPL : montant minimum de retrait 20 000 CHF.
- Art. 6 OEPL : amortissement obligatoire.
- Art. 8 OEPL : mise en gage.
- Art. 3 OPP3 : circonstances de retrait 3a.
- Art. 33 al. 1 lit. e LIFD : déduction 3a.
- Art. 33 al. 1 lit. g LIFD : déduction primes d''assurance 3b.
- Art. 38 LIFD : imposition séparée des prestations en capital.
- Art. 122 CC : partage LPP en cas de divorce.
- Art. 22a LFLP : détermination de la prestation partageable.
- Art. 45 LSA : fiche d''information client.
- Circulaire FINMA 2017/2 : affaires hypothécaires.', 70, TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'retraite'
ON CONFLICT (key) DO UPDATE SET
  title = EXCLUDED.title,
  summary = EXCLUDED.summary,
  content_md = EXCLUDED.content_md,
  sort_order = EXCLUDED.sort_order,
  updated_at = NOW();

INSERT INTO afa_fiches
  (filiere_key, theme_id, key, title, summary, content_md, sort_order, active)
SELECT 'vie', t.id, 'cas_rachat_lpp_optimisation_fiscale', 'Cas d''oral : Rachat LPP (optimisation fiscale, cadre 55 ans)',
       'Cas d''examen oral VIE. Isabelle Roux, 55 ans, célibataire, cadre horlogère Neuchâtel, salaire 165 000 CHF, lacune LPP 210 000 CHF après congé sabbatique. Analyser la stratégie de rachat échelonné et l''articulation avec retraite anticipée à 63 ans.', '## Contexte client

### Profil
- Isabelle Roux, 55 ans, célibataire sans enfants, domicile Neuchâtel.
- Fonction : cadre supérieure (responsable finance) dans une entreprise horlogère de la Vallée de Joux, salaire brut 165 000 CHF/an plus bonus moyen 15 000 CHF.
- Parcours : 2 ans de congé sabbatique non rémunéré 2020 à 2022 (voyage, formation continue), reprise du poste actuel en 2022 sans transfert de LPP durant l''interruption.
- Avoirs LPP actuels : 480 000 CHF (dont 320 000 CHF part obligatoire, 160 000 CHF part surobligatoire).
- Lacune de rachat calculée par la caisse de pension : 210 000 CHF (attestation officielle sur demande).
- 3a en cours : compte 3a à la BCN, avoir 65 000 CHF, verse 7 258 CHF/an depuis 2023.
- Fortune privée : 320 000 CHF portefeuille titres (mandat de gestion Julius Bär), pas d''immobilier.
- Fiscalité 2025 : revenu imposable 148 000 CHF, taux marginal cumulé (IFD, cantonal, communal Neuchâtel) autour de 34 %.
- Projet : retraite anticipée envisagée à 63 ans (dans 8 ans), avec départ possible en capital.

### Question posée par le client
« Je viens d''apprendre que je peux racheter 210 000 CHF dans ma caisse de pension. Combien d''impôts est-ce que je peux économiser ? Puis-je racheter en une fois ou dois-je étaler ? Et surtout, est-ce compatible avec mon projet de partir à 63 ans et de toucher une partie en capital ? »

## Trame de présentation (20 min)

### 1. Introduction (2 min)

Je vous présente aujourd''hui Isabelle Roux, cadre financière de 55 ans, célibataire, avec un revenu imposable élevé et une lacune de rachat LPP significative de 210 000 CHF liée à ses années sabbatiques. Le sujet du jour est l''optimisation fiscale via le rachat LPP dans la fenêtre stratégique de 55 à 63 ans, avec un piège majeur à éviter : le blocage de 3 ans avant tout retrait en capital (art. 79b al. 3 LPP). Je vais d''abord poser le cadre du rachat volontaire, ensuite chiffrer l''économie fiscale attendue, puis proposer un échelonnement précis, et enfin articuler cette stratégie avec le départ à la retraite anticipée en capital ou en rente.

### 2. Analyse (7 min)

Le droit au rachat volontaire est prévu à l''art. 79b LPP : chaque assuré peut combler les lacunes de prestations calculées par sa caisse de pension jusqu''à concurrence de la prestation maximale réglementaire. La lacune de 210 000 CHF a été confirmée par l''attestation officielle de la caisse (validité 12 mois).

Économie fiscale attendue : à un taux marginal cumulé de 34 %, chaque franc racheté génère 34 centimes d''impôt économisés. Un rachat de 210 000 CHF étalé sur 3 ans (70 000 par an) génère donc environ 71 400 CHF d''économie fiscale cumulée. C''est un levier majeur, sans risque de marché.

Piège central du cas : l''art. 79b al. 3 LPP interdit tout retrait en capital dans les 3 ans qui suivent un rachat. Cela signifie que si Isabelle rachète en 2026 et souhaite prendre son capital LPP à 63 ans (2034), il n''y a aucun conflit calendaire ; le blocage de 3 ans est largement écoulé. En revanche, si elle décide en 2032 (à 61 ans) de racheter encore et de partir en capital à 63 ans, le blocage se déclencherait et priverait Isabelle de l''exonération du rachat (rappel d''impôt possible).

Plafonnement de la déduction : le rachat LPP est intégralement déductible du revenu imposable, sans plafond spécifique autre que le montant de la lacune calculée par la caisse (art. 33 al. 1 lit. d LIFD). Pas de plafond en CHF, contrairement au 3a.

Taux de conversion à 63 ans : la caisse applique un taux réduit pour retraite anticipée (typiquement 5,4 % au lieu de 6,0 % à 65 ans), soit une perte de rente d''environ 10 %. Si l''avoir final atteint 900 000 CHF (rachats inclus), la rente annuelle à 63 ans serait de l''ordre de 48 600 CHF/an, contre 54 000 CHF si départ à 65 ans.

Tableau du plan de rachat proposé :

| Année civile | Âge | Rachat CHF | Économie fiscale (34 %) | Cumul avoir LPP |
|---|---|---|---|---|
| 2026 | 55 | 70 000 | 23 800 | 550 000 |
| 2027 | 56 | 70 000 | 23 800 | 620 000 |
| 2028 | 57 | 70 000 | 23 800 | 690 000 |
| Total | | 210 000 | 71 400 | |

Si retraite à 63 ans (2034), dernier rachat en 2028 : blocage 3 ans écoulé depuis 2031, aucun risque.

### 3. Solutions (8 min)

Stratégie recommandée en 3 volets.

Volet 1 : rachat LPP échelonné 3 x 70 000 CHF sur 2026 à 2028. L''échelonnement optimise le taux d''imposition marginal (en concentrant, on écrase le revenu net mais on plafonne l''effet marginal), lisse la trésorerie (70 000 CHF/an sont finançables sans toucher au portefeuille titres) et respecte le blocage 3 ans avec marge.

Volet 2 : maintenir le 3a plein à 7 258 CHF/an. Cette combinaison est autorisée : rachat LPP et versement 3a la même année sont cumulables (art. 82 LPP), avec déduction complète des deux. Isabelle bénéficie donc d''un double levier.

Volet 3 : décision rente ou capital à 63 ans. Compte tenu d''Isabelle célibataire sans enfants, l''argument principal pour le capital est la transmission (le capital entre dans la succession, contrairement à la rente qui s''éteint au décès), mais aussi le contrôle patrimonial (gestion propre du capital, choix des rendements). Argument pour la rente : sécurité viagère, protection contre le risque de longévité (Isabelle a une espérance de vie femme non-fumeuse de 89 ans, soit 26 ans de rente). Proposition : mixte 50/50, soit 450 000 CHF en capital à 63 ans (imposé séparément taux réduit, env. 45 000 CHF d''impôt à Neuchâtel) et rente réduite d''environ 24 300 CHF/an à vie.

Produits complémentaires :
- Assurance-vie 3a en pilier lié pour compléter les 7 258 CHF/an, format compte 3a bancaire (rendement 3 % moyen sur fonds indexés) plutôt qu''assurance-vie mixte 3a (moins liquide et frais élevés).
- Assurance-vie 3b à prime unique pour placer une partie du portefeuille titres avec avantage successoral (clause bénéficiaire libre hors succession).
- Assurance décès pure : sans conjoint ni enfant, la protection décès est faible ; on propose plutôt une police pour un légataire (nièce ou fondation).

Documents à établir : attestation de rachat de la caisse (renouvelée chaque année), simulation fiscale échelonnée signée, planification retraite avec projection rente vs capital, fiche d''information client au sens de l''art. 45 LSA, proposition 3b.

### 4. Conclusion (3 min)

Isabelle bénéficie d''une fenêtre fiscale exceptionnelle : 210 000 CHF de rachat LPP à étaler sur 2026-2028, pour une économie fiscale cumulée de 71 400 CHF. Le blocage de 3 ans de l''art. 79b al. 3 LPP est respecté puisque la retraite est projetée à 63 ans (2034). Je remettrai à Isabelle : la fiche d''information client au sens de l''art. 45 LSA (identité, statut d''intermédiaire non lié, rémunération, ombudsman), le questionnaire des besoins et objectifs signé, l''attestation de rachat de sa caisse de pension, un simulateur fiscal détaillé sur les 3 années, une projection retraite à 63 et 65 ans (rente vs capital), et un comparatif de trois solutions 3b pour la partie transmission. Rendez-vous de suivi annuel pour ajuster le montant selon l''évolution salariale.

## Questions d''experts type + réponses modèles

### 1. Question : Qui calcule la lacune de rachat LPP ?
**Réponse modèle** : C''est la caisse de pension de l''assuré, sur la base des dispositions réglementaires (âge, salaire coordonné actuel, années manquantes). Elle établit une attestation officielle valable en général 12 mois, à joindre à la déclaration fiscale de l''année du rachat. L''assuré peut la demander gratuitement.
**Ref légale** : art. 79b LPP, art. 60a OPP2.

### 2. Question : Combien de temps le rachat est-il bloqué avant tout retrait en capital ?
**Réponse modèle** : 3 ans. Aucun retrait en capital (retraite, EPL, départ à l''étranger) ne peut intervenir dans les 3 ans qui suivent un rachat, sous peine de rappel de l''exonération fiscale (imposition rétroactive du rachat). Le Tribunal fédéral applique ce délai de manière stricte, calendrier civil.
**Ref légale** : art. 79b al. 3 LPP ; ATF 142 II 399.

### 3. Question : Le rachat LPP est-il plafonné ?
**Réponse modèle** : Non, il n''y a pas de plafond en CHF. La seule limite est le montant de la lacune calculée par la caisse selon son règlement. Contrairement au 3a (7 258 ou 36 288 CHF en 2026), le rachat LPP peut atteindre plusieurs centaines de milliers de CHF sur une seule année si la lacune le permet.
**Ref légale** : art. 79b LPP, art. 33 al. 1 lit. d LIFD.

### 4. Question : Peut-on faire un rachat après un retrait EPL ?
**Réponse modèle** : Oui, mais uniquement après le remboursement intégral du montant retiré au titre de l''EPL. Tant que le retrait EPL n''a pas été remboursé, aucun rachat volontaire n''est admis fiscalement. C''est un piège classique quand un rachat est envisagé après une acquisition immobilière.
**Ref légale** : art. 79b al. 2 LPP.

### 5. Question : L''employeur peut-il augmenter sa cotisation LPP pour Isabelle ?
**Réponse modèle** : Oui, le règlement de la caisse peut prévoir des cotisations d''épargne majorées pour les cadres (bel étage ou plan 1e pour les revenus supérieurs à 132 300 CHF). Cela améliore l''avoir vieillesse futur mais n''ouvre pas de nouvelle lacune de rachat rétroactive.
**Ref légale** : art. 1e OPP2, art. 15 LPP.

### 6. Question : Quel est le taux de conversion en cas de retraite anticipée à 63 ans ?
**Réponse modèle** : Le taux légal minimal LPP à 65 ans est de 6,0 % pour la part obligatoire. En cas de retraite anticipée, la caisse applique un taux réduit selon son règlement (souvent 0,15 à 0,20 point de moins par année d''anticipation), soit environ 5,4 % à 63 ans. La rente est donc réduite d''environ 10 %.
**Ref légale** : art. 14 LPP, règlement caisse.

### 7. Question : Rachat LPP et 3a la même année : possible ?
**Réponse modèle** : Oui, les deux sont pleinement cumulables et déductibles. Le 3a maximum reste 7 258 CHF (avec LPP) en 2026, et le rachat LPP s''ajoute sans limite au-delà. Aucune règle d''exclusion.
**Ref légale** : art. 33 al. 1 lit. d et e LIFD, art. 82 LPP.

### 8. Question : Retraite partielle échelonnée : intérêt fiscal ?
**Réponse modèle** : Certaines caisses permettent une retraite partielle en plusieurs étapes (par exemple 30 % à 62 ans, 40 % à 64 ans, 30 % à 65 ans). Chaque tranche de capital est imposée séparément à un taux réduit ; le fractionnement réduit la progressivité et donc l''impôt total. Économie possible de 15 à 25 % sur l''impôt total du capital.
**Ref légale** : art. 33b OPP2, ATF 143 II 553.

### 9. Question : Isabelle décide en 2032 de partir en capital à 63 ans en 2034. Peut-elle racheter en 2032 ?
**Réponse modèle** : Techniquement oui, mais fiscalement NON à recommander : le rachat effectué en 2032, suivi d''un retrait en capital en 2034, tombe dans le blocage 3 ans. L''administration fiscale procéderait à un rappel d''impôt sur le rachat (perte de l''exonération). Le rachat doit être fait au plus tard en 2030 pour respecter le délai.
**Ref légale** : art. 79b al. 3 LPP.

### 10. Question : Isabelle célibataire sans enfants : prestations survivants au décès ?
**Réponse modèle** : Aucune rente de veuf ou de conjoint puisqu''elle n''est pas mariée. Aucune rente d''orphelin puisqu''elle n''a pas d''enfants. Le règlement peut prévoir un capital-décès pour concubin déclaré ou frère et sœur à charge, avec bénéficiaires selon l''ordre légal (art. 20a OPP2). En l''absence de bénéficiaires désignés, le capital reste dans la caisse.
**Ref légale** : art. 20a OPP2.

### 11. Question : Le rachat est-il exportable si Isabelle part vivre à l''étranger ?
**Réponse modèle** : En cas de départ définitif hors UE/AELE, l''avoir LPP obligatoire peut être retiré en cash (impôt à la source cantonal, dans les 3 ans après un rachat = blocage art. 79b al. 3 LPP applicable). En cas de départ dans un pays UE/AELE, la part obligatoire reste bloquée sur un compte de libre passage suisse jusqu''à la retraite ; seule la part surobligatoire peut être retirée.
**Ref légale** : art. 5 al. 1 LFLP, accord ALCP Annexe II.

### 12. Question : Domicile fiscal au moment du rachat : quel canton impose ?
**Réponse modèle** : Le rachat est déductible dans le canton de domicile fiscal au 31 décembre de l''année du rachat. Un changement de canton en cours d''année peut avoir un impact si le nouveau canton a un taux plus favorable ou plus défavorable. Le rachat n''est pas soumis à impôt en tant que tel (c''est une déduction, pas un revenu).
**Ref légale** : art. 3 LHID, art. 4a LHID.

### 13. Question : Impôt anticipé sur le rachat ?
**Réponse modèle** : Il n''y a pas d''impôt anticipé sur un versement de rachat volontaire : c''est un flux entrant, non un rendement. En revanche, la prestation en capital de retraite versée par la caisse est soumise à l''impôt anticipé sur le rendement épargne, mais ce point ne concerne pas le rachat.
**Ref légale** : art. 4 LIA.

### 14. Question : Quelle preuve du rachat conserver pour le fisc ?
**Réponse modèle** : L''attestation officielle de la caisse de pension (montant du rachat, date de versement, motif), plus l''avis de débit bancaire. Ces pièces sont à joindre à la déclaration d''impôt. La caisse envoie également chaque année un certificat récapitulatif à la fin de l''exercice.
**Ref légale** : art. 33 al. 1 lit. d LIFD, directives cantonales.

### 15. Question : Isabelle change d''avis et souhaite partir en rente à 65 ans plutôt qu''en capital à 63. Impact sur le rachat ?
**Réponse modèle** : Aucun impact fiscal négatif. Le blocage de 3 ans ne concerne que les retraits en capital (art. 79b al. 3 LPP). La perception d''une rente n''est pas concernée : le rachat reste pleinement déductible et n''entraîne aucun rappel. Le report à 65 ans améliore même le taux de conversion (6,0 % au lieu de 5,4 %).
**Ref légale** : art. 79b al. 3 LPP a contrario.

## Chiffres-clés à retenir

- Lacune de rachat : 210 000 CHF (attestation caisse).
- Rachat étalé : 3 x 70 000 CHF sur 2026-2028.
- Taux marginal Isabelle : ~34 % (IFD + cantonal + communal Neuchâtel).
- Économie fiscale cumulée : env. 71 400 CHF sur 3 ans.
- Blocage art. 79b al. 3 LPP : 3 ans avant tout retrait en capital.
- 3a plafond 2026 avec LPP : 7 258 CHF/an.
- Taux de conversion LPP obligatoire à 65 ans : 6,0 %.
- Taux réduit anticipation 63 ans : env. 5,4 % (-10 % rente).
- Retraite partielle échelonnée : économie fiscale 15 à 25 % sur capital.
- Espérance de vie femme 63 ans : env. 26 ans en rente.
- Impôt retrait capital 450 000 CHF Neuchâtel : env. 45 000 CHF.
- Attestation caisse valable 12 mois.
- 1e plan cadre : seuil 132 300 CHF (2026).
- Salaire max LPP obligatoire 2026 : 90 720 CHF.

## Références légales

- Art. 79b LPP : rachats volontaires.
- Art. 79b al. 3 LPP : blocage 3 ans avant retrait capital.
- Art. 79b al. 2 LPP : rachat interdit tant que EPL non remboursé.
- Art. 14 LPP : taux de conversion.
- Art. 15 LPP : bonifications de vieillesse.
- Art. 82 LPP : 3a lié.
- Art. 33 al. 1 lit. d LIFD : déduction rachat LPP.
- Art. 33 al. 1 lit. e LIFD : déduction 3a.
- Art. 3 LHID, art. 4a LHID : rattachement personnel et changement.
- Art. 60a OPP2 : calcul de la lacune.
- Art. 1e OPP2 : plans 1e cadres.
- Art. 20a OPP2 : ordre des bénéficiaires en cas de décès.
- Art. 33b OPP2 : retraite partielle.
- Art. 4 LIA : impôt anticipé.
- Art. 5 al. 1 LFLP : paiement en espèces en cas de départ.
- ATF 142 II 399 : blocage 3 ans strict.
- ATF 143 II 553 : retraite partielle échelonnée.
- Art. 45 LSA : fiche d''information client.
- Accord ALCP Annexe II : coordination sécurité sociale UE/AELE.', 80, TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'retraite'
ON CONFLICT (key) DO UPDATE SET
  title = EXCLUDED.title,
  summary = EXCLUDED.summary,
  content_md = EXCLUDED.content_md,
  sort_order = EXCLUDED.sort_order,
  updated_at = NOW();

INSERT INTO afa_fiches
  (filiere_key, theme_id, key, title, summary, content_md, sort_order, active)
SELECT 'vie', t.id, 'cas_retour_expatriation', 'Cas d''oral : Retour d''expatriation (Suisse après 8 ans à Dubaï)',
       'Cas d''examen oral VIE. Karim Benali, 42 ans, retour de Dubaï après 8 ans, nouveau poste Genève 175 000 CHF, épouse et 3 enfants. Reconstituer la prévoyance : LPP, AVS années manquées, 3a, LAMal, remboursement EPL antérieur.', '## Contexte client

### Profil
- Karim Benali, 42 ans, marié à Leïla (39 ans, femme au foyer durant l''expatriation), 3 enfants (Yasmine 10 ans, Adam 8 ans, Sami 5 ans).
- Nationalité suisse et marocaine (double), passeport suisse principal.
- Retour en Suisse septembre 2026 après 8 ans à Dubaï (2018 à 2026). Domicile à Genève, quartier Champel, loyer 4 800 CHF/mois.
- Nouveau poste : directeur commercial d''une multinationale technologique à Genève, salaire brut 175 000 CHF/an plus bonus cible 25 000 CHF, LPP obligatoire pleine.
- Fortune accumulée à Dubaï : 850 000 CHF sur compte offshore (HSBC Jersey), 3a préservé dans fondation bancaire suisse 45 000 CHF (verse durant l''expat sans revenu AVS = irrégulier mais toléré par certaines fondations).
- LPP transféré vers institution de libre passage 2018 lors du départ : 165 000 CHF à l''époque, avoir actuel env. 180 000 CHF (intérêts moyens 1 % sur 8 ans).
- Retrait EPL en 2016 (avant le départ) : 120 000 CHF pour une résidence secondaire aux Diablerets (bien vendu en 2020 sans remboursement à la caisse, EPL éteint après vente).
- Aucune cotisation AVS entre 2018 et 2026 : 8 années potentiellement manquantes (impact rente future).
- Leïla : aucune activité lucrative durant l''expat, pas d''AVS ni de LPP suisse.
- Assurance maladie internationale (Cigna) en cours, à résilier au retour.
- Fiscalité prévue Genève 2026 : revenu imposable estimé 175 000 CHF, taux marginal cumulé ~34 %.

### Question posée par le client
« Nous revenons en Suisse après 8 ans à Dubaï. Comment reconstituer ma prévoyance vieillesse ? Combien puis-je racheter dans la LPP ? Que dois-je faire pour l''AVS manquée ? Faut-il rembourser mon ancien retrait EPL de 2016 ? Et pour ma femme et mes enfants côté LAMal, quel est le délai ? »

## Trame de présentation (20 min)

### 1. Introduction (2 min)

Je vous présente aujourd''hui la famille Benali, un couple de 42 et 39 ans avec trois enfants en âge scolaire, qui rentre en Suisse après 8 ans à Dubaï pour prendre un poste de direction à Genève. Le sujet du jour est la reconstitution complète de leur prévoyance suisse (AVS, LPP, 3a) et l''affiliation obligatoire à la LAMal. Le cas comporte plusieurs pièges : les 8 années AVS manquantes qui réduiront la rente future, la question du remboursement de l''ancien retrait EPL, la réintégration LPP obligatoire dès la reprise d''emploi, et le délai d''affiliation LAMal de 3 mois. Je vais d''abord analyser les lacunes (AVS, LPP, LAMal), puis proposer un plan de reconstitution priorisé, et terminer par les documents à remettre.

### 2. Analyse (7 min)

Réaffiliation AVS. Dès le retour en Suisse, Karim est de nouveau soumis à l''AVS/AI/APG (art. 1a LAVS) : cotisation employeur plus employé de 8,7 % sur le salaire brut (part employé 5,3 %). Pour les 8 années manquantes 2018-2026, un rachat AVS rétroactif est possible dans un délai maximum de 5 ans après la fin de l''année manquante (art. 39a LAVS et directives OFAS) : concrètement, Karim ne peut plus racheter que les années 2021 à 2026 (2018 à 2020 sont perdues). Impact : rente AVS potentiellement réduite de 1/44 par année manquante, soit une perte estimée de 2 à 3 % par année, cumulée jusqu''à ~15 % de la rente maximale (2 520 CHF/mois pour une personne seule en 2026).

Réaffiliation LPP. Elle est automatique dès la prise de poste à Genève : l''employeur affilie Karim à sa caisse de pension dès le premier jour (salaire supérieur au seuil 22 680 CHF en 2026, art. 2 LPP). L''avoir de libre passage de 180 000 CHF doit être transféré vers la nouvelle caisse (art. 3 LFLP), sauf si l''assuré demande à laisser tout ou partie sur un compte de libre passage (possible mais rare, la fusion optimise la lisibilité).

Lacune LPP à racheter : sur 8 ans à un salaire théorique de 175 000 CHF, la lacune calculée par la nouvelle caisse pourrait atteindre 350 000 à 400 000 CHF selon le règlement. Attestation officielle à demander sous 30 jours après l''affiliation.

Ancien retrait EPL de 2016. Le bien acquis en 2016 a été vendu en 2020 sans remboursement à la caisse. Deux scénarios : soit le produit de la vente a été utilisé pour racheter volontairement l''EPL (dans un délai de 2 ans par remploi dans un nouveau logement principal), soit Karim était censé rembourser à la caisse à l''époque (obligation de restitution art. 30d al. 1 lit. a LPP). En 2026, l''ancien EPL est considéré comme éteint (compte définitivement fermé lors du départ à Dubaï, transfert libre passage). Il n''est plus possible de récupérer l''impôt payé en 2016 (délai 3 ans, art. 83a LPP). Karim peut néanmoins racheter de manière ordinaire la lacune actuelle (art. 79b LPP), qui inclut implicitement l''effet du retrait passé.

Réaffiliation LAMal. Obligatoire pour toute personne domiciliée en Suisse, avec un délai de 3 mois après la prise de domicile pour s''affilier (art. 3 al. 1 LAMal). Karim, Leïla et les 3 enfants doivent chacun avoir un contrat LAMal individuel dans les 3 mois. L''affiliation est rétroactive à la date de domicile (paiement de la prime dès le 1er jour). L''assurance internationale Cigna est à résilier à effet immédiat après affiliation LAMal.

3a. Karim a maintenu un 3a durant l''expat (45 000 CHF), même sans revenu AVS suisse. La règle générale exige un revenu soumis AVS pour verser en 3a (art. 82 LPP, art. 7 al. 1 OPP3). Les versements passés sans revenu AVS sont techniquement irréguliers mais rarement contestés par le fisc. Pour l''avenir : à la reprise du salaire suisse, Karim peut verser 7 258 CHF/an (plafond 2026 avec LPP). Leïla, sans revenu, ne peut pas verser en 3a (art. 82 LPP).

LAA. Dès le premier jour d''emploi, Karim est assuré LAA obligatoirement (accidents professionnels et non-professionnels si taux d''activité supérieur à 8 h/semaine, art. 13 OLAA). Leïla et les enfants ne sont pas couverts LAA : leur risque accident est couvert par la LAMal (option inclusion du risque accident, art. 8 LAMal, ou intégration si assuré séparément par un employeur).

Tableau récapitulatif des lacunes :

| Domaine | Lacune | Action | Coût / Bénéfice |
|---|---|---|---|
| AVS 2021-2026 | 6 ans | Rachat rétroactif | ~28 000 CHF cotisations, récupère 6/44 rente |
| AVS 2018-2020 | 3 ans | Non rattrapables | Perte définitive ~7 % rente |
| LPP | ~380 000 CHF | Rachat volontaire étalé | Économie fiscale ~34 % |
| LAMal | 3 mois délai | Affiliation famille de 5 | Prime famille ~1 500 CHF/mois |
| 3a | Reprendre 7 258 CHF/an | Compte 3a bancaire | Déduction annuelle |

### 3. Solutions (8 min)

Plan de reconstitution en 4 volets sur 10 ans.

Volet 1 : régularisation AVS immédiate. Rachat des cotisations 2021-2026 dès le retour, environ 28 000 CHF (calcul CCC Genève), payable en une fois ou étalé sur 3 ans. Bénéfice : récupération de 6 années de cotisations sur les 8 manquantes, réduction de la lacune de rente à environ 4,5 %. Décision : à faire dès l''affiliation à la caisse cantonale de compensation.

Volet 2 : rachat LPP échelonné sur 6 ans (2027-2032). Attestation caisse : 380 000 CHF. Étalement : 6 x 63 000 CHF/an. Économie fiscale annuelle : 63 000 x 34 % = env. 21 400 CHF. Cumulée sur 6 ans : ~128 500 CHF. Respect du blocage 3 ans avant tout retrait en capital (art. 79b al. 3 LPP) : Karim doit s''engager à ne pas retirer en capital ni pour EPL avant 2035 (soit à 51 ans). Aucune contrainte problématique.

Volet 3 : reprise 3a plein, plus assurance-vie 3b pour Leïla. Karim verse 7 258 CHF/an dès 2026 (7 258 CHF x 34 % = 2 468 CHF d''économie fiscale annuelle). Leïla ne peut pas verser 3a (pas de revenu AVS), mais peut ouvrir une assurance-vie 3b à prime unique (par exemple 50 000 CHF placés) pour constituer une épargne à long terme, avec clause bénéficiaire libre.

Volet 4 : affiliation LAMal dans les 3 mois, sélection famille. Recommandation : caisse maladie avec franchise 2 500 CHF adultes (Karim et Leïla, bonne santé), franchise 300 CHF enfants (nombreux consultations pédiatriques), modèle médecin de famille pour réduire les primes de 15 à 20 %. Coût estimé famille de 5 à Genève : env. 1 500 CHF/mois soit 18 000 CHF/an. Souscription complémentaires LCA : hospitalisation semi-privé (2 adultes 250 CHF/mois env.), ambulatoire médecine complémentaire, dentaire enfants.

Prévoyance survivants : compte tenu du salaire élevé et de la famille nombreuse, on propose une assurance décès pure 3b de 1 000 000 CHF sur la tête de Karim, prime annuelle env. 1 800 CHF (42 ans, non-fumeur), pour couvrir 5 ans de train de vie plus scolarité universitaire des enfants. Complément invalidité 3b : rente 60 000 CHF/an à vie en cas d''invalidité, prime env. 3 500 CHF/an.

Documents à recueillir : passeport suisse Karim, permis de séjour retour, attestation domicile Genève, contrat de travail nouveau poste, attestation libre passage (fondation), attestation 3a existante, historique AVS (extrait CI à demander), certificat LPP après affiliation, questionnaire santé pour 3b.

### 4. Conclusion (3 min)

En synthèse, la famille Benali doit agir sur quatre chantiers simultanés : régulariser 6 années AVS rachetables, s''affilier LAMal dans les 3 mois, transférer le libre passage LPP vers la nouvelle caisse et lancer un rachat LPP échelonné de 380 000 CHF sur 6 ans, et ouvrir une protection prévoyance décès/invalidité 3b pour Karim. Deux années AVS sont malheureusement perdues. Je remettrai à la famille : la fiche d''information client au sens de l''art. 45 LSA, le questionnaire d''analyse des besoins signé par les deux conjoints, une checklist « retour d''expatriation » avec les 12 démarches à effectuer sous 3 mois, une projection retraite AVS/LPP avant et après rachats, un comparatif LAMal de trois caisses avec complémentaires, et une proposition 3b décès et invalidité. Rendez-vous de suivi trimestriel la première année.

## Questions d''experts type + réponses modèles

### 1. Question : Quel est le délai d''affiliation LAMal après le retour ?
**Réponse modèle** : 3 mois à compter de la prise de domicile en Suisse (art. 3 al. 1 LAMal). L''affiliation prend effet rétroactivement à la date de domiciliation, donc les primes sont dues dès le premier jour. Passé le délai, une amende peut être imposée par le canton.
**Ref légale** : art. 3 al. 1 LAMal, art. 7 al. 3 OAMal.

### 2. Question : Peut-on cotiser rétroactivement à l''AVS pour les années passées à l''étranger ?
**Réponse modèle** : Oui, dans un délai de 5 ans après la fin de l''année de cotisation manquante (art. 39a LAVS et directives OFAS). Karim, rentré en 2026, peut donc encore régulariser les années 2021 à 2026. Les années 2018 à 2020 sont définitivement perdues.
**Ref légale** : art. 39a LAVS, directives OFAS.

### 3. Question : Quand l''affiliation LPP obligatoire prend-elle effet ?
**Réponse modèle** : Dès le premier jour de travail chez l''employeur suisse, à condition que le salaire annuel dépasse le seuil d''entrée LPP de 22 680 CHF en 2026 (art. 2 al. 1 LPP). L''affiliation est automatique, l''employeur ne peut pas y renoncer.
**Ref légale** : art. 2 al. 1 LPP, art. 5 OPP2.

### 4. Question : L''avoir de libre passage doit-il obligatoirement être transféré vers la nouvelle caisse ?
**Réponse modèle** : Oui, l''assuré doit demander le transfert intégral de l''avoir de libre passage vers la nouvelle institution de prévoyance dès qu''il est réaffilié (art. 3 al. 1 LFLP). L''assuré peut néanmoins laisser sur un compte de libre passage l''éventuelle part surobligatoire non reprise par le règlement de la nouvelle caisse (rare en pratique).
**Ref légale** : art. 3 LFLP.

### 5. Question : Peut-on racheter les années LPP manquées à l''étranger ?
**Réponse modèle** : Oui, via le rachat volontaire ordinaire de l''art. 79b LPP. La caisse de pension calcule la lacune sur la base du salaire actuel et des années d''affiliation manquantes. Le blocage 3 ans avant tout retrait en capital (art. 79b al. 3 LPP) reste applicable.
**Ref légale** : art. 79b LPP.

### 6. Question : Un retrait EPL fait il y a 10 ans doit-il être remboursé au retour ?
**Réponse modèle** : Non, si le bien a été vendu et le retrait éteint dans les règles à l''époque (transfert libre passage). L''ancien EPL est clos. En revanche, un remboursement volontaire pourrait rouvrir un droit à récupération d''impôt, mais uniquement dans les 3 ans après le remboursement (art. 83a LPP), donc trop tard ici pour l''impôt 2016.
**Ref légale** : art. 30d LPP, art. 83a LPP.

### 7. Question : Une épouse sans activité peut-elle verser en 3a ?
**Réponse modèle** : Non. Le versement 3a exige un revenu soumis à l''AVS (art. 82 LPP et art. 7 al. 1 OPP3). Leïla, sans activité lucrative en Suisse, ne peut pas verser en 3a. Alternative : assurance-vie 3b, épargne libre, ou versements complémentaires en son nom sur des placements privés.
**Ref légale** : art. 82 LPP, art. 7 al. 1 OPP3.

### 8. Question : Fiscalité du rapatriement de fortune de Dubaï ?
**Réponse modèle** : La fortune privée n''est pas imposée à l''entrée en Suisse (pas d''impôt sur le patrimoine importé). Elle sera soumise à l''impôt sur la fortune cantonal dès la première déclaration (Genève : taux progressif jusqu''à 1 % environ pour ce niveau). Aucune obligation particulière de déclaration à l''entrée, mais elle apparaîtra en déclaration annuelle.
**Ref légale** : art. 13 LHID, LIPP GE.

### 9. Question : Karim est frontalier de fait durant 3 mois (attente logement) : impact LAMal ?
**Réponse modèle** : Non pertinent : le domicile fiscal et social est déterminé par le centre des intérêts vitaux (art. 23 CC). Dès que Karim s''installe en Suisse (même en meublé) avec sa famille et son emploi, il est domicilié en Suisse et soumis à la LAMal. Le domicile marocain ou dubaïote antérieur cesse.
**Ref légale** : art. 23 CC, art. 3 LAMal.

### 10. Question : Le rachat LPP est-il déductible en une seule fois ou faut-il étaler ?
**Réponse modèle** : Le rachat est déductible intégralement dans l''année du versement, sans plafond (au-delà de la lacune calculée). Pour optimiser fiscalement, on étale sur plusieurs années afin de maintenir le revenu imposable dans les tranches marginales élevées : chaque tranche efface un peu du taux marginal, éviter que la déduction ne dépasse le revenu.
**Ref légale** : art. 33 al. 1 lit. d LIFD, art. 79b LPP.

### 11. Question : Prestations survivants LPP en cas de décès de Karim durant la première année d''affiliation ?
**Réponse modèle** : Les prestations survivants (rente veuve, rente enfants) sont acquises dès le premier jour d''affiliation, calculées sur l''avoir vieillesse projeté (théorique jusqu''à 65 ans), pas sur l''avoir accumulé. La rente veuve LPP est de 60 % de la rente d''invalidité théorique, la rente enfant 20 % (art. 21 LPP).
**Ref légale** : art. 21 LPP.

### 12. Question : Leïla peut-elle bénéficier d''une couverture LPP indépendante ?
**Réponse modèle** : Non, tant qu''elle n''a pas de revenu suisse supérieur au seuil LPP de 22 680 CHF (2026). Elle est cependant couverte comme conjointe survivante en cas de décès de Karim (rente veuve LPP et 3e pilier de Karim). Elle peut se constituer une prévoyance privée indépendante via assurance-vie 3b à son nom.
**Ref légale** : art. 2 LPP, art. 19 LPP.

### 13. Question : Les enfants nés à l''étranger sont-ils assurables LAMal sans problème ?
**Réponse modèle** : Oui, dès la prise de domicile en Suisse (art. 3 LAMal). Aucune sélection médicale n''est possible pour l''assurance de base : les enfants doivent être acceptés dans la caisse sans réserve. Les complémentaires LCA peuvent en revanche imposer un questionnaire de santé et des réserves.
**Ref légale** : art. 3 LAMal, art. 5 al. 1 LAMal.

### 14. Question : Karim a maintenu un 3a durant l''expatriation. Ces versements sont-ils réguliers ?
**Réponse modèle** : Techniquement non : le 3a exige un revenu soumis à l''AVS suisse (art. 82 LPP, art. 7 OPP3). En l''absence de revenu AVS, les versements auraient dû être refusés par la fondation. Beaucoup de fondations ne vérifient pas et acceptent ces versements. Le risque est un rappel d''impôt à la sortie, mais rare en pratique.
**Ref légale** : art. 82 LPP, art. 7 al. 1 OPP3.

### 15. Question : La LAA est-elle activée dès le premier jour d''emploi ?
**Réponse modèle** : Oui, la LAA est obligatoire dès le premier jour de travail. Accidents professionnels dès la première heure, accidents non professionnels dès 8 h/semaine d''activité (art. 13 OLAA). Karim, cadre supérieur à temps plein, sera pleinement couvert.
**Ref légale** : art. 1a LAA, art. 13 OLAA.

## Chiffres-clés à retenir

- Retour définitif : réaffiliation AVS/LPP/LAMal obligatoire.
- Délai affiliation LAMal : 3 mois après domicile (art. 3 al. 1 LAMal).
- Rachat AVS rétroactif : max 5 ans (art. 39a LAVS).
- Seuil d''entrée LPP 2026 : 22 680 CHF salaire annuel.
- Salaire max LPP 2026 : 90 720 CHF ; déduction coordination 25 725 CHF.
- 3a plafond 2026 avec LPP : 7 258 CHF ; sans LPP : 36 288 CHF.
- Blocage rachat LPP : 3 ans avant tout retrait capital (art. 79b al. 3 LPP).
- Rente AVS max 2026 personne seule : 2 520 CHF/mois (30 240 CHF/an).
- 1/44 de rente perdue par année AVS manquante.
- Rente veuve LPP : 60 % rente invalidité théorique (art. 21 LPP).
- Rente enfant LPP : 20 %.
- LAA obligatoire dès 1er jour, non-professionnels dès 8 h/sem.
- Cotisation AVS/AI/APG employé : 5,3 % (2026) sans plafond.
- Prime LAMal famille de 5 Genève : ~1 500 CHF/mois estimation.
- Assurance internationale Cigna : à résilier après affiliation LAMal.

## Références légales

- Art. 1a LAVS : personnes assurées.
- Art. 39a LAVS : régularisation cotisations manquantes.
- Art. 2 LPP : affiliation obligatoire.
- Art. 3 LFLP : transfert libre passage.
- Art. 5 al. 1 LFLP : paiement en espèces en cas de départ.
- Art. 21 LPP : prestations survivants.
- Art. 79b LPP : rachat volontaire.
- Art. 79b al. 3 LPP : blocage 3 ans.
- Art. 30d LPP : remboursement EPL.
- Art. 82 LPP : 3a lié, revenu AVS.
- Art. 83a LPP : remboursement d''impôt sur restitution EPL.
- Art. 7 al. 1 OPP3 : revenu AVS pour 3a.
- Art. 5 OPP2 : affiliation LPP.
- Art. 3 LAMal : affiliation obligatoire.
- Art. 5 al. 1 LAMal : effet rétroactif de l''affiliation.
- Art. 7 al. 3 OAMal : délai 3 mois.
- Art. 1a LAA : assurés obligatoires.
- Art. 13 OLAA : accidents non professionnels 8 h/sem.
- Art. 8 LAMal : couverture accident dans LAMal.
- Accord ALCP Annexe II : coordination sécurité sociale UE/AELE.
- Art. 45 LSA : fiche d''information client.', 90, TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'retraite'
ON CONFLICT (key) DO UPDATE SET
  title = EXCLUDED.title,
  summary = EXCLUDED.summary,
  content_md = EXCLUDED.content_md,
  sort_order = EXCLUDED.sort_order,
  updated_at = NOW();

INSERT INTO afa_fiches
  (filiere_key, theme_id, key, title, summary, content_md, sort_order, active)
SELECT 'vie', t.id, 'cas_enfants_majeurs_heritage', 'Cas d''oral : Enfants majeurs et planification successorale (couple 60 ans)',
       'Cas d''examen oral VIE. Couple Rossier, Pierre 62 ans et Michèle 60 ans, 2 enfants majeurs, patrimoine 2,15 M CHF. Organiser la succession avec le nouveau droit 2023 (quotité disponible élargie), protéger le concubin de la fille, avantager le conjoint survivant.', '## Contexte client

### Profil
- Pierre Rossier, 62 ans, notaire retraité depuis 2 ans, ancien salarié étude d''avocats Fribourg. Domicile Bulle (FR).
- Michèle Rossier, 60 ans, ancienne enseignante primaire retraitée depuis 3 ans.
- Mariés depuis 35 ans, régime matrimonial ordinaire (participation aux acquêts, art. 196 ss CC), pas de contrat de mariage.
- Deux enfants majeurs : Marc, 32 ans, marié à Anne, 2 enfants (les petits-enfants Julie 4 ans et Théo 2 ans), architecte à Zurich. Julie, 28 ans, célibataire, vit en concubinage avec Théo depuis 10 ans, journaliste à Lausanne.
- Patrimoine :
  - Résidence principale à Bulle : valeur 1 200 000 CHF, hypothèque soldée.
  - Résidence secondaire à Verbier : valeur 450 000 CHF, hypothèque soldée.
  - Portefeuille titres commun (compte Julius Bär) : 380 000 CHF.
  - Rente LPP Pierre : 68 000 CHF/an (retraite anticipée capital partiel déjà pris).
  - Michèle : LPP en capital 320 000 CHF (retirée à 60 ans) placée sur compte 3a et titres, plus rente AVS anticipée 22 000 CHF/an.
  - Assurance-vie 3b Pierre : 120 000 CHF valeur de rachat, clause bénéficiaire actuelle : Michèle 100 %.
- Aucune dette, patrimoine total env. 2 150 000 CHF plus valeurs assurance-vie.
- Souhait exprimé : transmettre équitablement aux deux enfants, protéger le concubin de Julie (10 ans de vie commune, sans mariage), avantager le maximum le conjoint survivant en cas de décès de Pierre (Michèle plus jeune, espérance de vie plus longue).

### Question posée par le client
« Nous avons entendu parler du nouveau droit successoral 2023. Que devons-nous prévoir concrètement pour organiser notre succession ? Peut-on avantager le concubin de notre fille, qui n''est pas encore marié ? Comment protéger le conjoint survivant sans léser les enfants ? »

## Trame de présentation (20 min)

### 1. Introduction (2 min)

Je vous présente aujourd''hui le couple Rossier, deux jeunes retraités de 62 et 60 ans, avec deux enfants majeurs, dont une fille en concubinage stable de 10 ans, et un patrimoine consolidé d''environ 2,15 millions CHF. Le sujet du jour est la planification successorale à la lumière du nouveau droit entré en vigueur le 1er janvier 2023 : réduction de la réserve des descendants de 3/4 à 1/2, élargissement de la quotité disponible, meilleure marge de manœuvre pour avantager le conjoint survivant ou un concubin. Je vais d''abord poser le cadre légal (dévolution successorale, régime matrimonial, réserves), puis chiffrer la quotité librement attribuable, ensuite proposer une combinaison contrat de mariage plus testament plus assurance-vie 3b, et enfin lister les documents à établir.

### 2. Analyse (7 min)

Dévolution légale sans testament ni contrat de mariage. En cas de décès de Pierre, on liquide d''abord le régime matrimonial (art. 204 CC) : Michèle reprend ses biens propres, chacun des époux (ou ses héritiers) reçoit la moitié du bénéfice de l''union. Sur les acquêts communs présumés de 2 150 000 CHF, Michèle reçoit d''office 1 075 000 CHF (moitié). Restent 1 075 000 CHF pour la succession de Pierre. Selon la dévolution légale (art. 462 CC), Michèle reçoit la moitié (537 500 CHF) et les descendants (Marc et Julie) l''autre moitié (537 500 CHF, soit 268 750 CHF chacun).

Réserves héréditaires depuis le 1er janvier 2023. Le nouveau droit (art. 470 et 471 CC révisé) fixe la réserve des descendants à 1/2 de leur part successorale légale (contre 3/4 auparavant). La réserve du conjoint survivant reste à 1/2 de sa part légale. Aucune réserve pour les ascendants (supprimée en 2023).

Calcul de la quotité librement disponible pour Pierre. Sur la succession de 1 075 000 CHF :
- Part légale conjoint 1/2 = 537 500 CHF, réserve 1/2 de cette part = 268 750 CHF.
- Part légale descendants 1/2 = 537 500 CHF, réserve 1/2 = 268 750 CHF.
- Total des réserves protégées : 537 500 CHF.
- Quotité disponible librement : 537 500 CHF (soit exactement 1/2 de la succession).

Avant 2023, cette même quotité disponible n''aurait été que de 3/8 de la succession (3 x 3/4 des descendants plus 1/2 conjoint). Le nouveau droit libère donc environ 15 % de patrimoine supplémentaire à disposer librement.

Problème du concubin de Julie. Le concubin (Théo, prénom identique au petit-fils) n''est PAS héritier légal des parents Rossier (art. 457 ss CC ne connaît ni le concubin ni le partenaire enregistré non conjoint). Il ne peut recevoir quoi que ce soit par succession qu''à titre de legs ou d''attribution testamentaire, sur la quotité disponible uniquement. Le concubinage stable de 10 ans n''ouvre aucun droit légal.

Avantage du conjoint survivant. Trois leviers cumulables :
- Contrat de mariage attribuant la totalité des acquêts au survivant (art. 216 al. 1 CC) : Michèle recevrait la totalité des 2 150 000 CHF au décès de Pierre, sans passer par la succession.
- Testament attribuant à Michèle la quotité disponible (537 500 CHF) plus l''usufruit sur la part réservataire des enfants (art. 473 CC).
- Assurance-vie 3b avec clause bénéficiaire Michèle : hors succession (art. 76 al. 1 LCA), donc hors calcul des réserves (sauf action en réduction pour la valeur de rachat au moment du décès, art. 476 CC).

Tableau récapitulatif nouveau vs ancien droit :

| Élément | Ancien droit | Nouveau droit 2023 |
|---|---|---|
| Réserve descendants | 3/4 de la part légale | 1/2 |
| Réserve conjoint | 1/2 | 1/2 (inchangé) |
| Réserve parents | 1/2 si vivants | Supprimée |
| Quotité disponible (couple + enfants) | 3/8 | 1/2 |
| Interdiction avantager pendant divorce | Non | Oui (art. 472 CC) |

### 3. Solutions (8 min)

Stratégie proposée en 4 volets.

Volet 1 : contrat de mariage attribuant la totalité des acquêts au survivant (art. 216 al. 1 CC). Effet : au décès de Pierre, Michèle reçoit la totalité du bénéfice de l''union (2 150 000 CHF), la succession ordinaire de Pierre ne porte plus que sur ses biens propres (ici quasi nuls). Les enfants Marc et Julie sont désavantagés temporairement, mais ils hériteront de Michèle plus tard. Attention : cette attribution est limitée à la part réservataire des descendants pour les enfants d''un précédent lit (art. 216 al. 2 CC), mais ici les enfants sont communs, aucune limite n''est applicable pour la part disponible. Forme : acte authentique devant notaire (art. 184 CC).

Volet 2 : testament conjoint (deux testaments individuels) attribuant la quotité disponible et l''usufruit sur les réserves. Pierre attribue à Michèle : la quotité disponible en propriété (537 500 CHF) plus l''usufruit sur la réserve des enfants (art. 473 CC : possible sur la totalité de la réserve, mais en contrepartie la quotité disponible est réduite à 1/4 dans ce cas particulier de l''art. 473 al. 2 CC révisé, à recalculer). Effet combiné : Michèle vit en pleine propriété d''une partie et en usufruit du reste sa vie durant. Les enfants perçoivent la nue-propriété, réalisée au décès de Michèle. Forme : testament public par-devant notaire (art. 499-502 CC) ou olographe (art. 505 CC).

Volet 3 : pacte successoral avec les enfants (art. 494 CC). Un pacte signé entre Pierre, Michèle, Marc et Julie devant notaire (forme authentique art. 512 CC) permet aux enfants de renoncer à leur réserve au profit du conjoint survivant, avec compensation (par exemple donations anticipées ou partage inégal futur). C''est une option puissante mais requiert le consentement de tous.

Volet 4 : assurance-vie 3b pour transmettre au concubin Théo et hors succession. Pierre souscrit une assurance-vie 3b avec clause bénéficiaire libre en faveur de Julie (100 000 CHF), ou de Théo (concubin) si expressément désiré. Effet : le capital-décès est versé directement au bénéficiaire, hors succession (art. 76 al. 1 LCA), donc échappe à la réserve des descendants pour la valeur excédant la valeur de rachat au décès (art. 476 CC prévoit un rappel de la valeur de rachat dans les biens successoraux). L''assurance-vie 3b est également fiscalement avantageuse : imposition à taux réduit distinct du revenu (art. 22 al. 3 LIFD) et pas d''impôt cantonal sur succession pour les descendants directs à Fribourg.

Patrimoine immobilier. Pour la résidence secondaire de Verbier, on peut envisager une donation partagée anticipée aux enfants avec réserve d''usufruit pour Pierre et Michèle (art. 745 CC). Effet : les enfants deviennent propriétaires en nue-propriété, les parents gardent l''usage viager. Fiscalement, l''usufruit reste imposable chez les parents (valeur locative), la donation en nue-propriété est soumise à l''impôt cantonal sur donations (Valais : 0 % en ligne directe). Rapport à la succession futur au titre de l''art. 626 al. 2 CC.

Produits à combiner : compte 3a Pierre (déjà retraité, plus de versement possible), assurance-vie 3b à prime unique 250 000 CHF placés dans un contrat multi-support, révision des clauses bénéficiaires existantes.

Documents à établir : projet de contrat de mariage (rendez-vous notaire), projet de deux testaments publics (Pierre et Michèle), extrait cadastral Verbier pour donation, questionnaire santé Pierre pour 3b, révision clause bénéficiaire de la 3b existante.

### 4. Conclusion (3 min)

En synthèse, le couple Rossier bénéficie du nouveau droit successoral 2023 qui libère environ 15 % de patrimoine supplémentaire à distribuer librement. Ma recommandation : contrat de mariage attribuant la totalité des acquêts au survivant (rendez-vous notaire dans les 30 jours), deux testaments publics attribuant la quotité disponible et l''usufruit sur la réserve enfants, une assurance-vie 3b de 250 000 CHF avec clauses bénéficiaires diversifiées (100 000 pour Michèle, 100 000 pour Julie et 50 000 pour Marc), et éventuellement une donation partagée de la résidence Verbier aux enfants avec réserve d''usufruit. Je remettrai : la fiche d''information client au sens de l''art. 45 LSA, le questionnaire des besoins signé par les deux conjoints, un tableau comparatif ancien vs nouveau droit successoral, une simulation successorale chiffrée dans trois scénarios (statu quo, contrat de mariage seul, contrat de mariage plus testaments), et une proposition 3b détaillée. Rendez-vous chez le notaire à fixer dans les 30 jours.

## Questions d''experts type + réponses modèles

### 1. Question : Quelle est la réserve des descendants depuis le 1er janvier 2023 ?
**Réponse modèle** : La réserve est de 1/2 de la part successorale légale des descendants (contre 3/4 auparavant). Concrètement, si les descendants ont légalement 1/2 de la succession (en présence du conjoint), leur réserve n''est que de 1/4 de la succession totale.
**Ref légale** : art. 471 CC révisé, en vigueur depuis le 01.01.2023.

### 2. Question : Le concubin de Julie est-il héritier légal des parents ?
**Réponse modèle** : Non, le concubin (ou partenaire de fait) n''est jamais héritier légal en droit suisse, quelle que soit la durée du concubinage. Il ne peut recevoir qu''à titre de legs ou d''attribution testamentaire, imputable sur la quotité disponible. Le partenariat enregistré (LPart, dissous depuis 2022, non applicable aux nouveaux couples) et le mariage sont les deux seules formes reconnues.
**Ref légale** : art. 457 à 462 CC.

### 3. Question : L''assurance-vie 3b entre-t-elle dans la succession ?
**Réponse modèle** : Non, le capital-décès est versé directement au bénéficiaire hors succession (art. 76 al. 1 LCA). En revanche, la valeur de rachat au moment du décès peut être rapportée à la masse successorale pour calculer les réserves (action en réduction, art. 476 CC). L''imposition est à taux réduit séparé du revenu (art. 22 al. 3 LIFD).
**Ref légale** : art. 76 al. 1 LCA, art. 476 CC, art. 22 al. 3 LIFD.

### 4. Question : Quelle est la forme obligatoire d''un pacte successoral ?
**Réponse modèle** : Forme authentique devant notaire, avec la présence de deux témoins et la signature de toutes les parties. C''est un contrat, donc il exige l''accord de tous les signataires pour être modifié ou révoqué (art. 513 CC).
**Ref légale** : art. 512 CC, art. 513 CC.

### 5. Question : Le régime matrimonial ordinaire prévoit quoi au décès ?
**Réponse modèle** : Au décès, on liquide d''abord le régime matrimonial : chaque conjoint (ou ses héritiers) reprend ses biens propres, puis le bénéfice de l''union (acquêts nets des deux époux réunis) est partagé par moitié entre le conjoint survivant et la succession du défunt. Seule la part successorale du défunt entre ensuite dans la succession pour dévolution aux héritiers.
**Ref légale** : art. 204 CC, art. 215 CC.

### 6. Question : Peut-on attribuer par contrat de mariage la totalité des acquêts au survivant ?
**Réponse modèle** : Oui, l''art. 216 al. 1 CC permet une attribution jusqu''à la totalité du bénéfice de l''union au conjoint survivant. Limite : les enfants d''un précédent lit gardent leur réserve (art. 216 al. 2 CC). Pour des enfants communs, aucune limite. Forme : contrat de mariage par acte authentique (art. 184 CC).
**Ref légale** : art. 216 CC, art. 184 CC.

### 7. Question : La réserve du conjoint survivant a-t-elle changé en 2023 ?
**Réponse modèle** : Non, la réserve du conjoint reste à 1/2 de sa part successorale légale, inchangée depuis 1988. Seules la réserve des descendants (réduite de 3/4 à 1/2) et celle des parents (supprimée) ont été modifiées en 2023.
**Ref légale** : art. 471 CC révisé.

### 8. Question : Impôt successoral pour les descendants en ligne directe ?
**Réponse modèle** : L''impôt sur les successions est cantonal et communal. Aucun impôt fédéral. Pour les descendants en ligne directe, la plupart des cantons exonèrent totalement (Fribourg, Vaud, Genève, Valais). Les concubins et non-parents sont taxés à des taux pouvant atteindre 40 à 50 % dans certains cantons.
**Ref légale** : lois cantonales sur successions et donations (LDSU FR, LMSD VD, etc.).

### 9. Question : Quelles sont les exigences d''un testament olographe ?
**Réponse modèle** : Il doit être entièrement écrit à la main par le testateur (aucune partie dactylographiée), daté (jour, mois, année) et signé par le testateur. Toute modification postérieure exige les mêmes formes. Un testament écrit à l''ordinateur n''est pas valable même signé.
**Ref légale** : art. 505 CC.

### 10. Question : Rente LPP survivant : conditions pour le conjoint ?
**Réponse modèle** : Le conjoint survivant a droit à la rente veuf ou veuve LPP si le mariage a duré au moins 5 ans (art. 19 al. 1 LPP), s''il a des enfants à charge, ou s''il a atteint 45 ans révolus. Sinon : allocation en capital équivalant à 3 rentes annuelles. En cas de retraite en capital du défunt, aucune rente puisque la caisse n''est plus débitrice.
**Ref légale** : art. 19 LPP.

### 11. Question : Retour de rachat LPP au décès ?
**Réponse modèle** : En cas de décès avant la retraite, si l''assuré avait effectué des rachats volontaires, la caisse verse aux survivants les prestations réglementaires (rente veuve, rente enfants). Certains règlements prévoient un capital-décès supplémentaire correspondant aux rachats non consommés. À vérifier au cas par cas.
**Ref légale** : art. 20a OPP2, règlement de la caisse.

### 12. Question : Donation de son vivant : rapport à la succession ?
**Réponse modèle** : Les donations faites aux descendants pendant la vie du de cujus sont rapportées à la masse successorale (art. 626 al. 2 CC), sauf dispense expresse. Cela signifie que la valeur donnée est ajoutée au patrimoine du de cujus au moment du calcul, puis déduite de la part de l''héritier bénéficiaire. Objectif : maintenir l''équité entre héritiers.
**Ref légale** : art. 626 CC.

### 13. Question : Usufruit sur la maison au conjoint survivant : forme ?
**Réponse modèle** : L''usufruit peut être constitué par testament ou pacte successoral en faveur du conjoint survivant (art. 473 CC). Il permet au conjoint d''utiliser le bien à vie tout en préservant la propriété future des enfants. Il doit être inscrit au registre foncier après le décès (art. 731 CC).
**Ref légale** : art. 473 CC, art. 745 CC, art. 731 CC.

### 14. Question : Renonciation à succession : quelle forme ?
**Réponse modèle** : L''héritier peut renoncer à la succession dans les 3 mois après avoir eu connaissance du décès, par déclaration écrite auprès de l''autorité compétente (justice de paix ou greffe cantonal, art. 570 CC). Une renonciation anticipée (avant le décès) exige un pacte successoral en la forme authentique (art. 495 CC).
**Ref légale** : art. 566 à 579 CC, art. 495 CC.

### 15. Question : Legs à une fondation charitable : possible ?
**Réponse modèle** : Oui, sur la quotité disponible. Un legs à une œuvre caritative ou une fondation d''utilité publique est valable même s''il réduit la part des héritiers, tant que les réserves protégées ne sont pas atteintes. Certains cantons exonèrent totalement les legs aux fondations reconnues d''utilité publique (art. 56 lit. g LIFD au fédéral).
**Ref légale** : art. 481 CC, art. 56 lit. g LIFD.

## Chiffres-clés à retenir

- Réserve descendants depuis 2023 : 1/2 de leur part légale (art. 471 CC).
- Réserve conjoint : 1/2 de sa part légale (inchangée).
- Réserve parents : supprimée depuis 2023.
- Quotité disponible couple + enfants : 1/2 (contre 3/8 avant 2023).
- Régime ordinaire = participation aux acquêts (art. 196 CC).
- Contrat de mariage totalité acquêts au survivant : art. 216 al. 1 CC.
- Testament olographe : entièrement manuscrit, daté, signé (art. 505 CC).
- Testament public : notaire plus 2 témoins (art. 499 CC).
- Pacte successoral : forme authentique art. 512 CC.
- Rente veuve LPP : conditions cumulatives (5 ans mariage OU enfants OU 45 ans).
- Assurance-vie 3b : hors succession art. 76 LCA, rapport valeur rachat art. 476 CC.
- Impôt succession descendants directs : exonéré FR/VD/GE/VS.
- Rapport donations aux descendants : art. 626 al. 2 CC.
- Renonciation succession : 3 mois dès connaissance décès (art. 566 CC).
- Concubin jamais héritier légal, quelle que soit durée.

## Références légales

- Art. 457 à 462 CC : dévolution légale.
- Art. 471 CC révisé : réserves héréditaires 2023.
- Art. 470 CC : quotité disponible.
- Art. 472 CC : divorce en cours et suppression avantages.
- Art. 473 CC : usufruit sur la réserve enfants au conjoint.
- Art. 476 CC : rapport valeur assurance-vie.
- Art. 481 CC : legs à œuvre charitable.
- Art. 495 CC : renonciation anticipée par pacte successoral.
- Art. 499 à 505 CC : formes du testament.
- Art. 512 CC : forme du pacte successoral.
- Art. 566 à 579 CC : répudiation.
- Art. 626 CC : rapport des libéralités entre vifs.
- Art. 731 CC : inscription registre foncier usufruit.
- Art. 745 CC : usufruit.
- Art. 184 CC : forme contrat de mariage.
- Art. 196 CC et suivants : régime de la participation aux acquêts.
- Art. 204 CC : liquidation régime.
- Art. 215 CC : partage bénéfice union.
- Art. 216 CC : attribution acquêts au survivant.
- Art. 19 LPP : rente conjoint survivant.
- Art. 20a OPP2 : ordre des bénéficiaires.
- Art. 76 al. 1 LCA : assurance-vie hors succession.
- Art. 22 al. 3 LIFD : imposition prestations en capital assurance.
- Art. 56 lit. g LIFD : exonération fondations d''utilité publique.
- Art. 45 LSA : fiche d''information client.', 100, TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'heriter_leguer'
ON CONFLICT (key) DO UPDATE SET
  title = EXCLUDED.title,
  summary = EXCLUDED.summary,
  content_md = EXCLUDED.content_md,
  sort_order = EXCLUDED.sort_order,
  updated_at = NOW();

INSERT INTO afa_fiches
  (filiere_key, theme_id, key, title, summary, content_md, sort_order, active)
SELECT 'vie', t.id, 'cas_reprise_entreprise_familiale', 'Cas d''oral : Reprise entreprise familiale (fils reprend PME du père)',
       'Cas d''examen oral VIE. Antoine Fumeaux, 34 ans, marié 1 enfant, reprend la menuiserie familiale (SA valorisée 850 000 CHF) à son père Marcel, 62 ans. Organiser la prévoyance du repreneur, la retraite du cédant, la protection famille.', '## Contexte client

### Profil
- Antoine Fumeaux, 34 ans, marié à Cécile (32 ans), 1 enfant Léa (2 ans), deuxième attendu dans 4 mois.
- Domicile Sion (VS), maison familiale en propriété (hypothèque 380 000 CHF).
- Actuellement salarié dans la menuiserie familiale Fumeaux Sàrl transformée en SA en 2022, salaire brut 95 000 CHF/an, fonction directeur adjoint.
- Marcel Fumeaux, 62 ans, père d''Antoine, fondateur de la menuiserie en 1985, actionnaire à 100 %.
- Structure : SA Fumeaux Menuiserie SA, capital 250 000 CHF, siège Sion, 12 employés, chiffre d''affaires 3,2 millions CHF/an, EBITDA 380 000 CHF, valorisation estimée 850 000 CHF (multiple 2,2 x EBITDA après ajustements).
- Projet : Marcel souhaite se retirer progressivement (retraite complète à 65 ans en 2029). Antoine reprend 100 % des actions via une holding personnelle (Fumeaux Holding SA à créer) avec :
  - Vendor loan Marcel : 400 000 CHF (remboursement 8 ans, 3 % d''intérêt).
  - Prêt bancaire cautionné : 350 000 CHF (BCVs).
  - Apport personnel Antoine : 100 000 CHF (épargne).
- Cécile : enseignante primaire 60 %, salaire brut 55 000 CHF/an, LPP obligatoire.
- Marcel : LPP accumulée 780 000 CHF, souhaite retrait en capital total à 65 ans. Rente AVS anticipée non demandée. Assurance-vie 3b 180 000 CHF (bénéficiaire Josette, épouse).
- Fortune personnelle Antoine et Cécile hors reprise : maison (valeur 780 000 CHF), 3a Antoine 42 000 CHF, 3a Cécile 28 000 CHF, portefeuille titres 65 000 CHF.

### Question posée par le client
« Je reprends l''entreprise de mon père dans les 6 prochains mois. Comment organiser ma prévoyance en tant que nouveau patron actionnaire, salarié de ma propre SA ? Comment mon père doit-il gérer sa retraite ? Quelle protection pour ma famille en cas de coup dur, sachant que j''aurai 750 000 CHF de dettes personnelles à cause de la reprise ? »

## Trame de présentation (20 min)

### 1. Introduction (2 min)

Je vous présente aujourd''hui la situation d''Antoine Fumeaux, 34 ans, marié avec un enfant et un second en route, qui reprend la menuiserie familiale valorisée 850 000 CHF. C''est un dossier riche qui combine trois personnes assurées : Antoine le repreneur, Cécile son épouse, et Marcel son père cédant. Les enjeux sont : structurer la prévoyance d''Antoine actionnaire salarié (LPP obligatoire, plan bel étage cadres, 3a), protéger la famille contre le décès ou l''invalidité du repreneur (vendor loan de 400 000 CHF à couvrir absolument), et optimiser la sortie fiscale de Marcel (retrait capital à 65 ans après vente des actions). Je vais d''abord analyser chaque situation, puis proposer une architecture globale, et terminer par les documents à préparer.

### 2. Analyse (7 min)

Statut LPP d''Antoine. Une fois actionnaire majoritaire de sa SA, Antoine reste salarié de sa société (dirigeant salarié). Il est donc affilié à la LPP obligatoire comme n''importe quel salarié dès son entrée en fonction (art. 2 LPP, salaire supérieur au seuil 22 680 CHF en 2026). Son épargne LPP actuelle (env. 120 000 CHF chez la caisse existante) suit son parcours dans la nouvelle organisation.

Optimisation LPP dirigeant : Antoine, actionnaire à 100 %, peut faire adhérer sa SA à une caisse de pension plus généreuse (fondation collective avec plan 1e pour les revenus supérieurs à 132 300 CHF, art. 1e OPP2). Toutefois, avec un salaire de 95 000 CHF, il est en dessous du seuil 1e. Alternative : plan bel étage classique avec cotisations d''épargne majorées pour les cadres (12 à 18 % au lieu du minimum LPP). Justification : forte lacune de rachat future (années junior à faible salaire), levier fiscal.

Retraite Marcel. Il souhaite retirer son avoir LPP en capital total (780 000 CHF) à 65 ans en 2029. Points d''attention :
- Blocage 3 ans avant retrait capital si un rachat volontaire est effectué (art. 79b al. 3 LPP). Marcel n''a pas prévu de rachat, donc le blocage ne s''applique pas.
- Imposition à taux réduit distinct du revenu (art. 38 LIFD), calcul cantonal Valais : env. 6 à 7 % soit 50 000 CHF d''impôt sur 780 000 CHF.
- Fractionnement possible : Marcel peut prendre la retraite partielle en 2 tranches (par exemple 50 % à 64 ans, 50 % à 65 ans, selon le règlement de la caisse), ce qui casserait la progressivité et pourrait économiser 15 à 20 % d''impôt (env. 8 000 CHF).
- Prestations survivants : après retrait total en capital, la caisse n''est plus débitrice ; Josette (épouse) n''aura aucune rente veuve LPP. Compenser par une assurance-vie 3b ou un placement structuré.

Vendor loan de 400 000 CHF. C''est la dette d''Antoine envers Marcel personnellement. En cas de décès d''Antoine, cette dette entre dans sa succession et pèse sur Cécile et les enfants (héritiers). En cas de décès de Marcel, la créance entre dans sa succession et est héritée par Josette et Antoine (le patrimoine se confond partiellement). Protection : assurance décès pure 3b sur la tête d''Antoine, capital décès 400 000 CHF cédé en garantie à Marcel, permettant de rembourser instantanément le vendor loan en cas de disparition du fils.

Protection invalidité Antoine. En cas d''invalidité, la LPP verse une rente calculée sur l''avoir projeté (env. 40 000 CHF/an pour Antoine avec plan bel étage). Il faut compléter par une assurance perte de gain 3b (rente 40 000 CHF/an complémentaire à vie) pour maintenir le niveau de vie et honorer le vendor loan.

Statut de Cécile. Enseignante salariée à 60 %, elle est affiliée LPP obligatoire par son employeur. Elle peut verser en 3a le plafond avec LPP (7 258 CHF en 2026). Aucun impact direct de la reprise sur son statut personnel, mais son couple porte désormais 750 000 CHF de dettes reprise plus 380 000 CHF d''hypothèque, soit 1 130 000 CHF de dette totale.

Assurance homme-clé (keyman). En tant qu''unique dirigeant de la SA, la disparition d''Antoine paralyserait l''entreprise. Une assurance keyman souscrite par la SA (bénéficiaire = SA) de 500 000 CHF permettrait à l''entreprise de tenir 12 à 18 mois pendant la recherche d''un remplaçant ou la vente. Primes déductibles chez la SA (art. 59 al. 1 lit. a LIFD).

Tableau récapitulatif des besoins :

| Personne | Risque | Solution | Ordre de grandeur |
|---|---|---|---|
| Antoine | Décès (vendor loan) | 3b temporaire décès | 400 000 CHF |
| Antoine | Décès (train de vie famille) | 3b décès complémentaire | 600 000 CHF |
| Antoine | Invalidité | 3b rente | 40 000 CHF/an |
| Antoine | Prévoyance vieillesse | LPP bel étage + 3a max | 7 258 CHF/an 3a |
| SA | Keyman | Assurance homme-clé | 500 000 CHF |
| Marcel | Optimisation retrait | Fractionnement retraite | Économie 8 000 CHF |
| Marcel | Décès Josette | 3b prime unique | 200 000 CHF |
| Cécile | Prévoyance | 3a max + LPP existante | 7 258 CHF/an |

### 3. Solutions (8 min)

Architecture globale en 5 volets.

Volet 1 : nouvelle affiliation LPP de la SA Fumeaux Menuiserie SA à une fondation collective avec plan bel étage (cotisations d''épargne 12 à 18 % selon tranche d''âge). Effet : accélération de l''épargne LPP d''Antoine, création d''une lacune de rachat future (potentiel 200 000 CHF de rachats déductibles sur 15 ans). Cotisation employeur 60 % / employé 40 % (généreux pour attirer les cadres). Cécile n''est pas concernée (autre employeur).

Volet 2 : assurance-vie 3b décès sur Antoine, structure double :
- Capital décès 400 000 CHF avec cession en garantie du vendor loan à Marcel. Prime annuelle env. 850 CHF (Antoine 34 ans, non-fumeur, durée 20 ans temporaire).
- Capital décès 600 000 CHF avec clause bénéficiaire Cécile. Prime annuelle env. 1 250 CHF (durée 30 ans temporaire, couvre scolarité enfants et train de vie).
- Total prime décès : env. 2 100 CHF/an, déductible partiellement au titre général des primes d''assurance (art. 33 al. 1 lit. g LIFD).

Volet 3 : assurance perte de gain invalidité 3b sur Antoine :
- Rente 40 000 CHF/an complémentaire dès 2 ans d''incapacité, à vie jusqu''à 65 ans.
- Prime annuelle env. 2 800 CHF (34 ans, activité artisanale hors risques élevés).

Volet 4 : optimisation retraite Marcel :
- Retraite partielle 50 % à 64 ans (2028), 50 % à 65 ans (2029). Vérifier compatibilité avec le règlement de la caisse actuelle. Économie d''impôt estimée 8 000 CHF sur les 780 000 CHF retirés.
- Assurance-vie 3b prime unique 200 000 CHF pour Josette (clause bénéficiaire), dans le but de compenser l''absence de rente veuve LPP après retrait total.

Volet 5 : assurance keyman pour la SA :
- Souscripteur et bénéficiaire : Fumeaux Menuiserie SA.
- Assuré : Antoine (personne clé).
- Capital décès 500 000 CHF, durée 15 ans.
- Prime env. 1 050 CHF/an, déductible en charges de la SA (art. 59 al. 1 LIFD).

Autres points à traiter : convention d''actionnaire entre Antoine et Marcel (pour les 3 années de transition où Marcel garde un rôle consultatif) ; testament d''Antoine (protection Cécile et enfants, y compris cession des actions holding) ; contrat de mariage éventuel entre Antoine et Cécile pour protéger le patrimoine familial (participation aux acquêts avec attribution au survivant).

Documents à recueillir : projet de reprise (business plan, valorisation, offre bancaire), acte de vente actions, projet vendor loan (contrat de prêt), statuts SA, certificats LPP actuels Antoine et Cécile, extrait CI Marcel, projet règlement nouvelle caisse LPP, questionnaires santé Antoine et Marcel, dernières taxations fiscales, contrat de mariage éventuel.

### 4. Conclusion (3 min)

En synthèse, la reprise de la menuiserie familiale par Antoine nécessite une architecture prévoyance complète en 5 volets : nouvelle affiliation LPP avec plan bel étage (renforce l''épargne vieillesse), 1 million CHF d''assurance décès 3b sur Antoine (400 000 pour le vendor loan cédé à Marcel, 600 000 pour la famille), 40 000 CHF/an de rente invalidité 3b, retraite fractionnée pour Marcel (économie fiscale 8 000 CHF plus 3b 200 000 CHF pour Josette), et assurance keyman de 500 000 CHF pour la SA. Prime totale annuelle estimée : env. 6 000 CHF Antoine plus 1 050 CHF pour la SA. Je remettrai : la fiche d''information client au sens de l''art. 45 LSA pour chacune des trois personnes assurées (Antoine, Cécile, Marcel), le questionnaire d''analyse des besoins signé, un tableau récapitulatif des couvertures et primes, un projet d''assurance keyman pour la SA (avec convention entre l''employeur et l''assuré), et une proposition détaillée de retraite partielle pour Marcel. Rendez-vous de signature dans 4 semaines.

## Questions d''experts type + réponses modèles

### 1. Question : Antoine est actionnaire à 100 % de sa SA. Est-il soumis à la LPP obligatoire ?
**Réponse modèle** : Oui, en tant que salarié dirigeant de sa SA (qui est une personne morale distincte de lui-même), Antoine est soumis à la LPP obligatoire dès que son salaire annuel dépasse 22 680 CHF en 2026 (art. 2 LPP). L''actionnariat à 100 % ne change rien à sa qualité de salarié LPP.
**Ref légale** : art. 2 LPP, art. 5 OPP2.

### 2. Question : Qu''est-ce qu''un plan bel étage ?
**Réponse modèle** : Un plan bel étage est un plan de prévoyance surobligatoire qui augmente les cotisations d''épargne LPP au-delà du minimum légal (7 à 18 % selon l''âge dans le régime obligatoire). Il peut porter les cotisations à 20 à 25 % du salaire coordonné, financé par l''employeur et l''employé, ce qui accélère la constitution de l''avoir vieillesse et ouvre des lacunes de rachat déductibles.
**Ref légale** : art. 1 LPP, art. 6 LPP, règlement de la caisse.

### 3. Question : Un plan 1e est-il envisageable pour Antoine ?
**Réponse modèle** : Non, pas avec son salaire actuel. Le plan 1e n''est possible que pour la part de salaire supérieure à 132 300 CHF en 2026 (soit 1,5 fois le salaire assuré maximum LPP). Antoine étant à 95 000 CHF, il ne franchit pas le seuil. Il pourrait envisager un plan 1e s''il se verse à l''avenir un salaire supérieur.
**Ref légale** : art. 1e OPP2, art. 79c LPP.

### 4. Question : Retrait LPP en capital par Marcel : fiscalité ?
**Réponse modèle** : Imposition à un barème séparé du revenu ordinaire, à taux réduit spécifique (art. 38 LIFD au niveau fédéral, taux progressif cantonal). Pour un capital de 780 000 CHF en Valais, l''impôt total (IFD, cantonal, communal) est de l''ordre de 6 à 7 % soit 50 000 CHF. Prélevé à la source par la caisse.
**Ref légale** : art. 38 LIFD, art. 11 al. 3 LHID, loi fiscale cantonale VS.

### 5. Question : Assurance-vie 3b cédée en garantie du vendor loan : mécanisme ?
**Réponse modèle** : Antoine souscrit une assurance décès pure sur sa tête, capital 400 000 CHF, avec clause bénéficiaire Marcel Fumeaux (ou sa succession) jusqu''à concurrence de la créance vendor loan restante. En cas de décès d''Antoine, le capital est versé directement à Marcel qui apure la créance, la succession d''Antoine étant libérée d''autant. La police est nantie en garantie du prêt par convention entre Antoine, Marcel et l''assureur.
**Ref légale** : art. 76 LCA, art. 84 LCA (cession de droits).

### 6. Question : L''assurance keyman est-elle déductible pour la SA ?
**Réponse modèle** : Oui, les primes d''assurance keyman souscrites par la SA sur la tête d''une personne clé (dirigeant, technicien irremplaçable) sont déductibles en charges de la société (art. 59 al. 1 LIFD), sous réserve que la SA soit bien la souscriptrice et la bénéficiaire (pas les héritiers de l''assuré). Le capital-décès versé est un produit imposable de la SA au moment du sinistre.
**Ref légale** : art. 59 al. 1 lit. a LIFD, art. 25 LHID.

### 7. Question : Cécile inactive pourrait-elle verser en 3a ?
**Réponse modèle** : Cécile n''est pas inactive : elle est enseignante à 60 % avec un salaire de 55 000 CHF. Elle est donc affiliée LPP par son employeur et peut verser en 3a le plafond « avec LPP » de 7 258 CHF en 2026. Si elle était totalement inactive, elle ne pourrait rien verser en 3a (art. 82 LPP, art. 7 al. 1 OPP3).
**Ref légale** : art. 82 LPP, art. 7 al. 1 OPP3.

### 8. Question : Retraite partielle échelonnée : combien de tranches et à quel intervalle ?
**Réponse modèle** : Le Tribunal fédéral a admis jusqu''à 3 tranches (ATF 143 II 553), avec un intervalle d''au moins 12 mois entre chacune. Chaque tranche est imposée séparément à taux réduit, ce qui fractionne la progressivité et permet une économie fiscale significative (15 à 25 %). L''AFC a codifié cette pratique dans sa circulaire.
**Ref légale** : art. 33b OPP2, ATF 143 II 553, circulaire AFC 1/2018.

### 9. Question : Antoine pourrait-il s''établir comme indépendant (raison individuelle) au lieu d''être salarié SA ?
**Réponse modèle** : Théoriquement oui, mais dans le cas d''une reprise de SA, l''activité passe par la personne morale : Antoine achète les actions, reste salarié de la SA. Une raison individuelle serait pertinente pour une reprise en actifs (asset deal) et non en parts sociales (share deal). Antoine choisit ici le share deal donc reste salarié.
**Ref légale** : art. 620 CO ss (SA), art. 934 CO (raison individuelle).

### 10. Question : Rachat LPP possible pour Antoine après la reprise ?
**Réponse modèle** : Oui, dès son affiliation à la nouvelle caisse (plan bel étage), Antoine génère une lacune de rachat volontaire (art. 79b LPP). La caisse calcule la lacune sur le salaire coordonné actuel et les années d''affiliation manquantes. Blocage 3 ans avant tout retrait capital (art. 79b al. 3 LPP). Recommandation : attendre 12 à 24 mois avant premier rachat pour lisser la trésorerie post-reprise.
**Ref légale** : art. 79b LPP.

### 11. Question : Marcel après vente et retraite : LPP continue-t-elle ?
**Réponse modèle** : Non, dès la fin du contrat de travail avec la SA (retraite ou vente), l''affiliation LPP cesse. Marcel reçoit sa prestation de sortie ou sa rente de vieillesse selon son choix. S''il conserve un mandat d''administrateur rémunéré, la LPP peut continuer sur ce revenu s''il dépasse le seuil.
**Ref légale** : art. 10 LPP.

### 12. Question : Cotisations AVS de la SA sur le salaire d''Antoine ?
**Réponse modèle** : Cotisations paritaires AVS/AI/APG de 10,6 % du salaire brut en 2026, dont 5,3 % à charge de l''employeur (SA) et 5,3 % à charge de l''employé (Antoine). LACI 2,2 % jusqu''à 148 200 CHF. LAA obligatoire (SUVA ou assureur privé selon la branche, menuiserie = SUVA classe 41A obligatoire).
**Ref légale** : art. 5 LAVS, art. 3 LACI, art. 66 LAA.

### 13. Question : Prévoyance survivants entrepreneur : quelles rentes ?
**Réponse modèle** : Antoine étant salarié LPP, sa famille bénéficierait des rentes survivants LPP (rente veuve 60 % de la rente d''invalidité théorique, rente d''orphelin 20 %, art. 21 LPP), plus les rentes AVS survivants (art. 23 LAVS rente veuve 80 % rente vieillesse simple, art. 25 LAVS orphelin 40 %). À compléter par le 3b décès pour couvrir le vendor loan et le train de vie.
**Ref légale** : art. 21 LPP, art. 23 et 25 LAVS.

### 14. Question : Convention entre Marcel et Antoine sur le vendor loan : forme ?
**Réponse modèle** : Le vendor loan est un contrat de prêt (art. 312 CO) : forme écrite recommandée mais non obligatoire pour la validité. Doit préciser montant, taux d''intérêt (3 % en l''espèce, taux marché), échéance de remboursement (8 ans), garanties (assurance-vie cédée), clauses de défaut. En cas de décès de Marcel, la créance entre dans sa succession.
**Ref légale** : art. 312 CO, art. 313 CO (intérêts).

### 15. Question : Impact fiscal de la vente des actions par Marcel ?
**Réponse modèle** : La vente d''actions détenues à titre privé (Marcel personne physique) génère un gain en capital privé exonéré d''impôt (art. 16 al. 3 LIFD), sous réserve du critère du « commerçant professionnel de titres » (peu probable ici pour un fondateur qui vend son entreprise). Le prix de vente échappe donc à l''IFD et à l''impôt cantonal sur le revenu, gros avantage patrimonial.
**Ref légale** : art. 16 al. 3 LIFD, circulaire AFC 36/2012.

## Chiffres-clés à retenir

- Reprise SA : 850 000 CHF valorisation.
- Financement : 100 000 apport, 350 000 prêt bancaire, 400 000 vendor loan.
- Seuil LPP obligatoire 2026 : 22 680 CHF.
- Salaire max LPP 2026 : 90 720 CHF ; déduction coordination 25 725 CHF.
- Seuil plan 1e : 132 300 CHF (1,5 x salaire assuré max).
- Cotisations LPP obligatoire : 7 à 18 % du coordonné selon âge.
- Plan bel étage : jusqu''à 20-25 % cotisation cadres.
- Retrait capital LPP taux effectif Valais : ~6-7 %.
- Fractionnement 2-3 tranches : économie 15-25 % impôt capital.
- 3a plafond 2026 avec LPP : 7 258 CHF.
- Gain en capital privé actions : exonéré (art. 16 al. 3 LIFD).
- Assurance keyman : prime déductible SA, capital imposable SA.
- Rente veuve LPP : 60 % rente invalidité théorique.
- Rente orphelin LPP : 20 %.
- Cotisation AVS employeur+employé : 10,6 % en 2026.

## Références légales

- Art. 2 LPP : affiliation.
- Art. 6 LPP : régime surobligatoire.
- Art. 10 LPP : fin de l''assurance.
- Art. 21 LPP : prestations survivants.
- Art. 79b LPP : rachats volontaires.
- Art. 79c LPP : montant maximum assurable.
- Art. 1e OPP2 : plans 1e cadres.
- Art. 33b OPP2 : retraite partielle.
- Art. 5 OPP2 : salaire déterminant.
- Art. 82 LPP : 3a lié.
- Art. 7 al. 1 OPP3 : revenu AVS pour 3a.
- Art. 16 al. 3 LIFD : exonération gains en capital privés.
- Art. 38 LIFD : imposition prestations en capital.
- Art. 33 al. 1 lit. d LIFD : déduction rachat LPP.
- Art. 33 al. 1 lit. e LIFD : déduction 3a.
- Art. 33 al. 1 lit. g LIFD : déduction primes d''assurance.
- Art. 59 al. 1 LIFD : déduction charges SA (keyman).
- Art. 5 LAVS : personnes assurées.
- Art. 23 LAVS : rente veuve.
- Art. 25 LAVS : rente orphelin.
- Art. 3 LACI : cotisations chômage.
- Art. 66 LAA : assurance obligatoire SUVA.
- Art. 76 LCA : bénéficiaire assurance-vie.
- Art. 84 LCA : cession de droits.
- Art. 312 CO : contrat de prêt.
- Art. 620 CO : SA.
- ATF 143 II 553 : retraite partielle échelonnée.
- Art. 45 LSA : fiche d''information client.', 110, TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'activite_independante'
ON CONFLICT (key) DO UPDATE SET
  title = EXCLUDED.title,
  summary = EXCLUDED.summary,
  content_md = EXCLUDED.content_md,
  sort_order = EXCLUDED.sort_order,
  updated_at = NOW();

INSERT INTO afa_fiches
  (filiere_key, theme_id, key, title, summary, content_md, sort_order, active)
SELECT 'vie', t.id, 'cas_frontalier_france_suisse', 'Cas d''oral : Frontalier (résidence France, travail Suisse, 45 ans marié)',
       'Cas d''examen oral VIE. Julien Moreau, 45 ans, marié 3 enfants, permis G, résidence Divonne-les-Bains (FR), nouveau poste Rolex Genève 140 000 CHF. Analyser la prévoyance frontalier : LPP, 3a, AVS, LAMal/CMU, imposition source, coordination CH-FR.', '## Contexte client

### Profil
- Julien Moreau, 45 ans, nationalité française, marié à Sylvie (43 ans, femme au foyer depuis 3 ans), 3 enfants (Louis 16 ans, Emma 14 ans, Théo 11 ans).
- Domicile familial : Divonne-les-Bains (Ain, France), maison en propriété (crédit immobilier 320 000 EUR restant, mensualité 1 850 EUR).
- Statut : permis G frontalier (délivré par l''OCPM Genève après embauche).
- Nouveau poste : chef de projet R&D chez Rolex Genève, CDI, salaire brut 140 000 CHF/an plus 13ème mois inclus, bonus cible 12 000 CHF, LPP obligatoire.
- Ancien poste : cadre SNCF (Paris puis Bourg-en-Bresse), démission après 20 ans, quitte la France pour rejoindre l''industrie horlogère suisse.
- Sylvie : ancienne infirmière hospitalière (arrêt d''activité 2023 pour élever les enfants), au foyer, aucun revenu, aucune activité en Suisse.
- Épargne actuelle : 65 000 EUR sur PEL, 45 000 EUR sur assurance-vie française (contrat Boursorama), pas encore d''épargne prévoyance suisse.
- Aucun autre patrimoine hors résidence principale.
- Régime matrimonial : communauté réduite aux acquêts (droit français, comparable à la participation aux acquêts CH).
- Choix à faire : conserver la CMU-frontalier française ou opter pour la LAMal suisse (droit d''option 3 mois après embauche).
- Souhait : optimiser sa situation prévoyance et fiscale, comprendre les règles frontalier, préparer une retraite mixte CH-FR.

### Question posée par le client
« Je viens d''être embauché à Genève mais je vis à Divonne. Comment fonctionne ma prévoyance en Suisse ? Puis-je faire du 3a en tant que frontalier ? Quelle caisse maladie choisir : LAMal ou CMU ? Que se passe-t-il si je perds mon emploi ? Et comment vais-je être imposé, ici en France ou là-bas à Genève ? »

## Trame de présentation (20 min)

### 1. Introduction (2 min)

Je vous présente aujourd''hui la situation de Julien Moreau, 45 ans, cadre franco-français marié avec trois enfants, qui vient d''être embauché chez Rolex à Genève tout en conservant son domicile à Divonne-les-Bains. C''est un cas frontalier classique régi par l''accord bilatéral Suisse-Union européenne sur la libre circulation des personnes (ALCP) et par la convention fiscale franco-suisse. Trois axes structurent le dossier : la sécurité sociale (LPP obligatoire, LAMal ou CMU par droit d''option, LAA), la fiscalité (imposition à la source Genève avec accord franco-genevois de rétrocession), et la préparation retraite dans un régime hybride. Je vais d''abord poser le cadre juridique frontalier, ensuite analyser chaque volet, puis proposer une architecture prévoyance et enfin lister les documents.

### 2. Analyse (7 min)

Cadre juridique frontalier. Le permis G est délivré aux ressortissants UE/AELE domiciliés dans une zone frontalière (jusqu''à environ 30 km ou toute la France pour les Français) et travaillant en Suisse. Julien retourne à son domicile français au moins une fois par semaine (règle de l''ALCP). Il reste résident fiscal français (domicile familial, foyer stable, art. 4 B CGI) mais assujetti à la sécurité sociale suisse (règle du lieu de travail, règlement UE 883/2004 et ALCP annexe II).

Sécurité sociale suisse.
- AVS/AI/APG obligatoire : cotisation employeur plus employé 10,6 % en 2026 sur le salaire brut, sans plafond. Julien cotise à la CCC Genève via Rolex.
- LPP obligatoire dès affiliation (salaire supérieur au seuil 22 680 CHF en 2026, art. 2 LPP). Rolex a une caisse propre performante avec plan cadres, cotisations env. 12 à 18 % du salaire coordonné selon âge.
- LAA obligatoire (professionnels et non professionnels dès 8 h/semaine, art. 13 OLAA), assurance à la SUVA classe horlogère ou assureur privé.
- Assurance chômage LACI obligatoire (2,2 % jusqu''à 148 200 CHF).

Droit d''option LAMal / CMU-frontalier. Point délicat spécifique aux frontaliers UE. Julien a 3 mois après sa prise d''emploi pour opter (art. 3 al. 2 LAMal et accord bilatéral) :
- Option LAMal suisse : prime individuelle par membre de la famille (Julien plus Sylvie plus 3 enfants), estimation 1 800 CHF/mois pour la famille (Genève avec franchises optimisées). Choix de la caisse suisse et des complémentaires LCA. Fiscalement, primes déductibles côté français comme dépenses de santé étrangères (peu efficient).
- Option CMU-frontalier : cotisation forfaitaire à 8 % du revenu au-dessus d''un abattement (env. 20 000 EUR abattement pour une famille), soit pour Julien environ 850 EUR/mois (10 200 EUR/an), toute la famille couverte par la CMU. Prestations : soins remboursés selon barèmes français (généralement inférieurs à ceux de la LAMal, mais avec ticket modérateur classique et mutuelle complémentaire française possible).

Comparaison en pratique : CMU-frontalier est généralement plus économique pour les familles nombreuses (jusqu''à 40 % moins cher qu''une LAMal famille). Recommandation courante pour Julien : opter pour la CMU.

Cette option est unique et irrévocable pendant toute la durée du statut frontalier (sauf changement de situation majeur : perte d''emploi, retour en Suisse). À exercer par formulaire URSSAF dans les 3 mois.

3a pour frontalier. Question fréquente. Le 3a est ouvert au frontalier qui a un revenu soumis à l''AVS suisse (art. 82 LPP, art. 7 al. 1 OPP3). Julien peut donc verser jusqu''à 7 258 CHF/an en 2026 (plafond avec LPP). Attention fiscalité française : les cotisations ne sont pas déductibles du revenu imposable en France (le 3a n''est pas reconnu comme dispositif d''épargne retraite éligible), mais elles restent déductibles du revenu imposable suisse (utile pour l''impôt à la source cantonal Genève, art. 33 al. 1 lit. e LIFD). Au moment de la sortie, le capital retiré sera imposé en Suisse (retenue à la source cantonale) et potentiellement en France (imposition à la sortie du contrat, à négocier avec la convention fiscale).

Assurance-vie 3b. Souscrite en Suisse par un frontalier, elle relève du droit suisse (LCA). Fiscalité : primes non déductibles côté FR, capital versé imposé côté FR selon les règles françaises (assurance-vie française préférable pour Julien s''il vise la transmission successorale).

Imposition. Accord franco-suisse spécifique à Genève : Julien est imposé à la source à Genève (retenue par Rolex), taux barémé cantonal genevois (env. 18 à 22 % pour son niveau de salaire avec 3 enfants). Genève verse ensuite 3,5 % du salaire brut à la France (rétrocession) au profit des communes frontalières. Julien doit également déclarer ses revenus suisses en France (déclaration 2047, formulaire 2042) qui applique la méthode d''élimination de la double imposition : crédit d''impôt égal à l''impôt français qui aurait été dû sur ces revenus (Convention CH-FR du 9 septembre 1966 modifiée, art. 17 pour les salaires frontaliers Genève).

En pratique, pour la plupart des frontaliers Genève, l''imposition suisse à la source est libératoire : aucun impôt français supplémentaire sur le salaire suisse. Autres revenus français (assurance-vie, immobilier locatif) restent imposables normalement en France.

Chômage. En cas de perte d''emploi, un frontalier UE bénéficie des prestations chômage du pays de résidence (art. 65 règlement UE 883/2004) : Julien serait pris en charge par Pôle emploi France, sur la base de son dernier salaire suisse converti. Il ne bénéficierait pas directement de la LACI suisse mais aurait droit à un rapatriement de ses cotisations LACI sous certaines conditions.

Tableau récapitulatif frontalier :

| Régime | Applicable | Base | Coût |
|---|---|---|---|
| AVS/AI/APG CH | Oui obligatoire | Salaire brut | 5,3 % employé |
| LPP CH | Oui obligatoire | Coordonné | 7-18 % (âge) |
| LAA CH | Oui obligatoire | Salaire | 0,8-3 % |
| LACI CH | Oui obligatoire | Salaire | 1,1 % |
| LAMal ou CMU | Droit d''option 3 mois | Famille ou revenu | 850 vs 1 800/mois |
| 3a CH | Possible | Volontaire | 7 258 CHF/an |
| Sécurité sociale FR | Suspendue | Aucune | 0 (couvert par CH) |
| Impôt FR | Crédit d''impôt Genève | Selon convention | Néant en pratique |

### 3. Solutions (8 min)

Architecture prévoyance et fiscale en 5 volets.

Volet 1 : optimisation LPP. Rolex propose déjà un excellent plan LPP cadres (bel étage, cotisations élevées). Recommandation : ne rien changer, laisser la caisse Rolex faire son travail. À vérifier le règlement pour identifier une éventuelle lacune de rachat (années passées en France non couvertes) et envisager un rachat volontaire sur 5 à 8 ans (art. 79b LPP), avec le blocage 3 ans avant tout retrait en capital (art. 79b al. 3 LPP) à respecter en vue d''une retraite à 65 ans.

Volet 2 : ouverture 3a. Compte 3a à la BCGE ou fondation bancaire suisse, versement annuel 7 258 CHF/an en 2026 (plafond avec LPP). Déductibilité côté fiscalité source Genève. Attention à ne pas dépasser : contrôle par la fondation via numéro AVS. À l''échéance (5 ans avant retraite ou EPL), imposition suisse au barème réduit (env. 5 % à Genève).

Volet 3 : droit d''option CMU. Recommandation : opter pour la CMU-frontalier via formulaire URSSAF Alsace (traite tous les frontaliers) dans les 3 mois. Économie annuelle estimée pour la famille : env. 11 000 CHF (900 CHF/mois vs 1 800 CHF/mois LAMal). Souscrire une mutuelle complémentaire française (Mutuelle Générale ou similaire) pour couvrir les remboursements incomplets français (env. 200 EUR/mois famille).

Volet 4 : protection décès et invalidité 3b. Julien porte encore un prêt immobilier de 320 000 EUR en France. Souscription d''une assurance décès pure temporaire française ou suisse, capital 350 000 EUR, durée jusqu''à 65 ans (durée résiduelle du prêt : 15 ans). Prime env. 700 EUR/an. Alternative : recours à l''assurance emprunteur du prêt immobilier (souvent déjà obligatoire, à vérifier).

Protection invalidité : couverture LPP (rente invalidité env. 65 % du salaire coordonné en cas d''incapacité totale, art. 24 LPP), plus rente AI suisse (max env. 30 240 CHF/an personne seule en 2026). Total env. 78 000 CHF/an, à comparer au salaire net actuel (env. 95 000 CHF net). Lacune estimée : 15 000 CHF/an. Combler par une assurance perte de gain 3b (rente 15 000 CHF/an à vie), prime env. 1 000 CHF/an.

Volet 5 : gestion épargne existante en France. Conserver le PEL (rendement contractuel garanti) et l''assurance-vie française (avantage successoral art. 990 I CGI, abattement 152 500 EUR par bénéficiaire). Ne pas transférer en Suisse : perte des avantages successoraux français. Éventuellement diversifier avec une assurance-vie luxembourgeoise (portable).

Retraite à 65 ans. Julien percevra une rente AVS suisse (calculée sur ses 20 ans de cotisation suisse, plus complément AVS pour périodes UE au titre de la coordination sécurité sociale) et une rente française SNCF (pour ses années SNCF avant 45 ans) et générale française (art. 40 règlement UE 883/2004 : totalisation des périodes). Prestation LPP soit en rente (versement mensuel à vie, imposé en Suisse) soit en capital (imposition unique CH au barème réduit, puis transfert en France).

Documents à recueillir : passeport et carte d''identité française, contrat de travail Rolex, permis G, dernier avis d''imposition français, justificatif de domicile Divonne (facture), attestation de démission SNCF, historique carrière SNCF (relevé de carrière retraite), livret de famille, questionnaire santé pour 3b, RIB français.

### 4. Conclusion (3 min)

En synthèse, Julien Moreau, frontalier franco-suisse, doit gérer six chantiers simultanés : régularisation permis G et affiliation LPP automatique (fait par Rolex), exercice du droit d''option en faveur de la CMU-frontalier (économie familiale ~11 000 CHF/an), ouverture 3a plafonné à 7 258 CHF/an (économie fiscale à la source Genève), rachat LPP échelonné sur les années françaises (économie fiscale à évaluer avec attestation caisse Rolex), protection 3b décès pour couvrir le prêt immobilier français (350 000 EUR / 15 ans), et complément invalidité 3b pour combler la lacune. Je remettrai à Julien : la fiche d''information client au sens de l''art. 45 LSA (avec précision sur le cadre transfrontalier et la responsabilité de l''intermédiaire suisse), le questionnaire des besoins signé par lui et Sylvie (pour la clause bénéficiaire), un comparatif chiffré LAMal vs CMU, une checklist des 8 démarches administratives à faire dans les 3 mois, la simulation de l''imposition à la source Genève, et une projection retraite mixte CH-FR à 65 ans. Rendez-vous de signature dans 2 semaines pour respecter le délai droit d''option.

## Questions d''experts type + réponses modèles

### 1. Question : Quel est le taux d''imposition à la source d''un frontalier à Genève ?
**Réponse modèle** : Le taux barémé cantonal genevois (barème A pour célibataire, B pour couple, C pour marié avec enfants). Pour un salaire de 140 000 CHF, avec Sylvie inactive et 3 enfants, le taux effectif se situe autour de 18 à 22 %. La retenue est prélevée par l''employeur suisse et versée à l''administration fiscale genevoise (AFC).
**Ref légale** : art. 32 LIFD, LIS Genève, art. 83 LIFD.

### 2. Question : Comment fonctionne la rétrocession d''impôt entre Genève et la France ?
**Réponse modèle** : Genève reverse 3,5 % de la masse salariale des frontaliers résidant en France aux communes frontalières françaises (Ain et Haute-Savoie), au titre d''une compensation pour les services publics utilisés par les frontaliers. Le mécanisme est prévu par l''accord franco-genevois du 29 janvier 1973 modifié.
**Ref légale** : accord franco-genevois du 29 janvier 1973 sur la compensation financière.

### 3. Question : Quel est le délai du droit d''option LAMal / CMU-frontalier ?
**Réponse modèle** : 3 mois à compter de la prise d''emploi en Suisse (ou du début de l''activité frontalière). Le choix se fait par formulaire URSSAF (traitement centralisé à l''URSSAF Alsace pour tous les frontaliers). Le choix est en principe unique et irrévocable pendant toute la durée du statut frontalier, sauf changement majeur de situation.
**Ref légale** : art. 3 al. 2 LAMal, accord bilatéral CH-UE Annexe II section A al. 1 lit. l.

### 4. Question : Un frontalier est-il soumis à la LAA ?
**Réponse modèle** : Oui, la LAA est obligatoire pour tous les salariés en Suisse, y compris les frontaliers (art. 1a LAA). Julien est couvert pour les accidents professionnels dès le premier jour et pour les accidents non professionnels dès 8 h/semaine d''activité (art. 13 OLAA).
**Ref légale** : art. 1a LAA, art. 13 OLAA.

### 5. Question : Le 3a est-il déductible du revenu imposable français ?
**Réponse modèle** : Non. Le 3a n''est pas reconnu par le fisc français comme un dispositif d''épargne retraite éligible (contrairement au PER français). Les versements ne sont donc pas déductibles côté France, mais restent déductibles côté suisse (utile pour la retenue à la source cantonale). L''imposition à la sortie sera à négocier selon la convention fiscale CH-FR de 1966.
**Ref légale** : art. 33 al. 1 lit. e LIFD, convention CH-FR 09.09.1966 art. 17-20.

### 6. Question : Que devient la LPP en cas de retour définitif en France ?
**Réponse modèle** : En cas de départ définitif dans un pays UE/AELE, la part obligatoire LPP reste bloquée sur un compte de libre passage suisse jusqu''à la retraite (art. 25f LFLP), car la France dispose d''un régime de sécurité sociale équivalent. Seule la part surobligatoire peut être retirée en cash à la sortie. Le retrait de la part obligatoire n''est possible qu''à l''âge de la retraite (60-65 ans selon caisse).
**Ref légale** : art. 25f LFLP, art. 5 al. 1 LFLP, ALCP annexe II.

### 7. Question : Chômage : à qui s''adresse un frontalier ?
**Réponse modèle** : En vertu de l''art. 65 du règlement UE 883/2004, un frontalier au chômage total s''adresse au service public de l''emploi de son pays de résidence (Pôle emploi France) qui verse les allocations sur la base du dernier salaire suisse converti en euros. Le principe est celui du pays de résidence.
**Ref légale** : art. 65 règlement UE 883/2004, ALCP annexe II.

### 8. Question : Perte d''emploi : que devient le libre passage LPP ?
**Réponse modèle** : En cas de perte d''emploi sans nouvel emploi immédiat, l''avoir LPP est transféré sur un compte ou une police de libre passage (art. 4 LFLP), en attente d''un nouvel emploi soumis à la LPP. Si Julien retourne définitivement en France sans reprise d''emploi suisse, s''applique la règle de l''art. 25f LFLP (blocage part obligatoire, libération part surobligatoire).
**Ref légale** : art. 4 LFLP, art. 25f LFLP.

### 9. Question : LPP : rachats possibles pour un frontalier ?
**Réponse modèle** : Oui, exactement comme un résident suisse. Julien peut racheter volontairement les lacunes de prévoyance calculées par sa caisse (art. 79b LPP), déductibles à la source Genève. Le blocage 3 ans avant retrait capital (art. 79b al. 3 LPP) s''applique aussi. Attention : ces rachats ne sont pas déductibles côté fiscalité française.
**Ref légale** : art. 79b LPP.

### 10. Question : Fiscalité du retrait capital LPP à la retraite pour un frontalier ?
**Réponse modèle** : Le retrait en capital est imposé à la source en Suisse au barème réduit spécifique du canton d''implantation de la caisse (art. 96 LIFD pour les non-résidents). Genève : env. 5 à 7 %. La France, selon la convention fiscale CH-FR de 1966 (art. 20 pour les pensions), impose également mais accorde un crédit d''impôt égal à l''impôt suisse : imposition effective résiduelle française selon barème progressif IR, souvent modeste (le capital est étalé fiscalement sur plusieurs années par option).
**Ref légale** : art. 96 LIFD, convention CH-FR 09.09.1966 art. 20.

### 11. Question : Sortie totale du système suisse après un départ définitif : quelle prestation minimale ?
**Réponse modèle** : Départ vers un pays UE/AELE : part obligatoire LPP bloquée sur libre passage jusqu''à l''âge de retraite CH (60 ans hommes). Part surobligatoire retirable en cash. Rente AVS conservée et exportable dans l''UE (versement annuel à l''adresse française à la retraite). 3a : retirable en totalité au départ définitif, imposé à la source cantonale.
**Ref légale** : art. 25f LFLP, art. 5 al. 1 LFLP, art. 3 al. 2 OPP3.

### 12. Question : Sylvie non active en France : a-t-elle des droits sociaux ?
**Réponse modèle** : Sylvie est couverte par la CMU-frontalier si Julien opte pour cette option (elle est ayant droit). Elle n''a aucun droit AVS ou LPP suisse en son nom propre. Sa protection prévoyance repose sur celle de Julien (rente veuve LPP art. 19 LPP en cas de décès, rente veuve AVS art. 23 LAVS avec conditions cumulatives 5 ans mariage OU enfants OU 45 ans). Recommandation : assurance-vie 3b sur la tête de Julien avec Sylvie bénéficiaire.
**Ref légale** : art. 3 al. 2 LAMal, art. 19 LPP, art. 23 LAVS.

### 13. Question : Prestations familiales : Suisse ou France ?
**Réponse modèle** : Selon le règlement UE 883/2004, les prestations familiales sont dues par le pays d''activité (Suisse) pour le parent qui travaille, avec un mécanisme de différentiel si le pays de résidence (France) verse des allocations supérieures. En pratique, Julien reçoit les allocations familiales suisses (env. 300 CHF/mois par enfant à Genève, soit 900 CHF/mois pour 3 enfants) et si la France verse plus, un complément différentiel est payé par la CAF.
**Ref légale** : art. 68 règlement UE 883/2004, LAFam.

### 14. Question : Rente AVS/AI est-elle exportable en France ?
**Réponse modèle** : Oui, l''ALCP et le règlement UE 883/2004 permettent l''exportation intégrale des rentes AVS, AI et LPP dans tous les États UE/AELE. La rente est versée mensuellement sur un compte bancaire français, sans réduction. Une convention CH-FR spécifique évite la double imposition (rente imposée en principe en France selon convention 1966 art. 20).
**Ref légale** : art. 7 règlement UE 883/2004, convention CH-FR 09.09.1966 art. 20.

### 15. Question : Julien peut-il racheter à l''AVS des années françaises passées ?
**Réponse modèle** : Non, les périodes travaillées en France ne sont pas rachetables dans l''AVS suisse. En revanche, la coordination sécurité sociale UE prévoit la totalisation des périodes : à la retraite, Julien percevra une rente AVS suisse calculée sur ses années suisses (au prorata des 44 années théoriques) et une rente française calculée sur ses années françaises. Aucun rachat croisé nécessaire.
**Ref légale** : art. 45 règlement UE 883/2004, ALCP annexe II.

## Chiffres-clés à retenir

- Permis G : frontalier UE/AELE, retour hebdomadaire domicile FR.
- Salaire brut nouveau poste : 140 000 CHF + bonus 12 000 CHF.
- Rétrocession Genève vers communes FR : 3,5 % de la masse salariale frontaliers.
- Impôt source Genève marié 3 enfants ~18-22 % barème C.
- Droit d''option LAMal/CMU : 3 mois, irrévocable en principe.
- Coût LAMal famille 5 pers Genève : ~1 800 CHF/mois.
- Coût CMU frontalier famille : ~850 CHF/mois (8 % revenu au-delà abattement).
- Économie CMU vs LAMal : ~11 000 CHF/an pour cette famille.
- Seuil LPP 2026 : 22 680 CHF ; max coord. 65 010 CHF ; déduction 25 725 CHF.
- 3a plafond 2026 avec LPP : 7 258 CHF (non déductible côté FR).
- Rente AVS max personne seule 2026 : 2 520 CHF/mois.
- Rente veuve LPP : 60 % rente invalidité théorique.
- Départ définitif UE : part obligatoire LPP bloquée libre passage (art. 25f LFLP).
- Chômage frontalier : Pôle emploi France (art. 65 R. UE 883/2004).
- Convention fiscale CH-FR : 09.09.1966 modifiée, art. 17 (salaires), art. 20 (pensions).

## Références légales

- ALCP (accord Suisse-UE libre circulation) annexe II : coordination sécurité sociale.
- Règlement UE 883/2004 : coordination systèmes sécurité sociale.
- Art. 65 R. UE 883/2004 : chômage frontalier.
- Art. 68 R. UE 883/2004 : prestations familiales.
- Art. 45 R. UE 883/2004 : totalisation périodes retraite.
- Convention CH-FR 09.09.1966 modifiée : double imposition.
- Art. 17 convention CH-FR : salaires frontaliers.
- Art. 20 convention CH-FR : pensions et rentes.
- Accord franco-genevois du 29 janvier 1973 : rétrocession 3,5 %.
- Art. 3 al. 2 LAMal : droit d''option.
- Art. 2 LPP : affiliation obligatoire.
- Art. 19 LPP : rente conjoint survivant.
- Art. 24 LPP : rente d''invalidité.
- Art. 79b LPP : rachats volontaires.
- Art. 79b al. 3 LPP : blocage 3 ans.
- Art. 4 LFLP : institution de libre passage.
- Art. 5 al. 1 LFLP : paiement en espèces.
- Art. 25f LFLP : blocage part obligatoire départ UE.
- Art. 82 LPP : 3a lié.
- Art. 7 al. 1 OPP3 : revenu AVS pour 3a.
- Art. 3 al. 2 OPP3 : retrait 3a en cas de départ.
- Art. 5 LAVS : personnes assurées.
- Art. 23 LAVS : rente veuve.
- Art. 1a LAA : assurés obligatoires.
- Art. 13 OLAA : accidents non professionnels 8 h/sem.
- Art. 32 LIFD, art. 83 LIFD, art. 96 LIFD : impôt à la source, non-résidents.
- Art. 45 LSA : fiche d''information client.
- LAFam : allocations familiales.', 120, TRUE
FROM afa_themes t
WHERE t.filiere_key = 'vie' AND t.key = 'retraite'
ON CONFLICT (key) DO UPDATE SET
  title = EXCLUDED.title,
  summary = EXCLUDED.summary,
  content_md = EXCLUDED.content_md,
  sort_order = EXCLUDED.sort_order,
  updated_at = NOW();

-- 12 fiche(s) traitée(s).
