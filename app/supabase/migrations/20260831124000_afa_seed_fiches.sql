-- ═════════════════════════════════════════════════════════
-- Klary — Fiches mémoire AFA (filière maladie complémentaire)
--
-- Les montants ci-dessous sont ceux fixés par la loi ou l'ordonnance.
-- Les ordres de grandeur COMMERCIAUX des complémentaires LCA varient
-- d'un assureur et d'un produit à l'autre : ils ne sont pas inventés ici,
-- la fiche correspondante est un canevas à compléter depuis les
-- conditions produits réelles des caisses.
-- ═════════════════════════════════════════════════════════

INSERT INTO afa_fiches (filiere_key, theme_id, key, title, summary, content_md, sort_order)
SELECT 'maladie_complementaire', NULL, 'chiffres_cles',
  'Chiffres clés du cadre légal',
  'Les montants fixés par la loi. Ce sont ceux qui tombent le plus souvent.',
$MD$
## LAMal — participation aux coûts

- Franchise adulte : **300 CHF minimum**, **2 500 CHF maximum**
- Franchise enfant : **0 CHF minimum**, **600 CHF maximum**
- Quote-part : **10 %** des frais après franchise
- Plafond de quote-part : **700 CHF par an** (adulte), **350 CHF par an** (enfant). Une fois atteint, plus aucune quote-part.
- Quote-part portée à **40 %** sur les médicaments lorsqu'un générique existe et n'est pas choisi
- Contribution aux frais de séjour hospitalier : **15 CHF par jour**
- Prestations de maternité : **exemptes de franchise et de quote-part**

## LAMal — délais

- Affiliation : **3 mois** dès la naissance ou la prise de domicile en Suisse
- Annonce du nouveau-né : **3 mois** (et non 30 jours)
- Changement de caisse au 1er janvier : préavis au **30 novembre**
- Suspension pendant le service militaire : dès **plus de 60 jours**
- À l'étranger : urgence médicale uniquement, au maximum **le double du tarif suisse**

## Indemnités journalières maladie

- IJM LAMal (facultative) : **720 jours** d'indemnités sur une période de **900 jours**, art. **67 à 77 LAMal**
- L'IJM collective conclue par un employeur relève en pratique de la **LCA**

## LAA — montants

- Gain annuel assuré maximum : **148 200 CHF**
- Indemnité journalière : **80 %** du gain assuré, dès le **3e jour**
- Rente d'invalidité : **80 %** du gain assuré
- Rente complémentaire : **90 %** du gain assuré, sous déduction de la rente AI
- IAI : **capital**, maximum **148 200 CHF**, barème à l'annexe 3 OLAA
- Rente de veuve ou veuf : **40 %** · orphelin : **15 %** · orphelin de père et mère : **25 %** · plafond de l'ensemble des rentes de survivants : **70 %**
- Accidents non professionnels couverts dès **8 heures** de travail par semaine

## APG — maternité

- **80 %** du revenu, pendant **14 semaines**, maximum **220 CHF par jour**
- Versée par les **APG (LAPG)**, jamais par la LAMal

## LCA — délais

- Révocation de la proposition : **14 jours**
- Réticence (fausses déclarations) : art. **6 LCA**
- Devoir d'information : art. **3 LCA**, il ne cesse pas à la signature
- Fiche d'information client : art. **45 LSA**, remise au premier entretien

### À vérifier avant l'épreuve

Le régime exact de résiliation LAMal en cours d'année (fin de semestre avec franchise ordinaire et modèle standard, contre fin d'année pour les franchises à option) comporte des nuances selon l'art. 7 LAMal. Reprendre la formulation exacte du manuel VBV plutôt que de se fier à une reformulation.
$MD$, 1
WHERE NOT EXISTS (SELECT 1 FROM afa_fiches WHERE key = 'chiffres_cles');

INSERT INTO afa_fiches (filiere_key, theme_id, key, title, summary, content_md, sort_order)
SELECT 'maladie_complementaire', NULL, 'pieges',
  'Les pièges qui coûtent des points',
  'Formulations construites pour faire cocher une réponse fausse.',
$MD$
## Les cinq pièges principaux

### 1. APG contre LAMal
L'allocation de maternité (80 %, 14 semaines, max 220 CHF/jour) relève des **APG**. La LAMal ne paie que les **prestations médicales** de maternité. Toute option qui fait verser une allocation par l'assurance-maladie est fausse.

### 2. Le plafond de quote-part
La quote-part est de 10 %, mais **plafonnée à 700 CHF par an** pour un adulte et 350 CHF pour un enfant. Le plafond est la moitié de la réponse : l'énoncer sans lui est incomplet.

### 3. Maladie contre accident
La LAA ne s'applique **pas** en cas de maladie ordinaire. Une crise cardiaque survenue à domicile est une maladie : les survivants relèvent de l'AVS/AI, pas de la LAA. Toujours lire la **cause** de l'atteinte avant de choisir le régime.

### 4. L'IAI
C'est un **capital**, pas une rente. Maximum **148 200 CHF**. Elle est **indépendante de l'incapacité de gain** et ne sert **pas** à la réintégration professionnelle. Barème à l'annexe 3 OLAA.

### 5. Le rapatriement
Couvert par la **LCA voyage** uniquement. **Jamais** par la LAMal. La LAMal à l'étranger se limite à l'urgence médicale, au maximum au double du tarif suisse.

## Pièges de formulation relevés dans la présérie

- « Les prestations **et les primes** de l'AOS sont identiques pour chaque caisse » : les **prestations** le sont par la loi, les **primes** non.
- « Changement d'AOS possible au 1er juillet » : seulement en cas de **hausse de prime**, avec préavis au 31 mars.
- « Le devoir d'information prend fin après signature » : faux, art. 3 LCA, il est continu.
- « Délai de révocation de deux mois » : faux, **14 jours**.
- « Résilier l'ancienne complémentaire avant l'acceptation de la nouvelle » : **jamais**, sous peine de trou de couverture.
- « Forfait allaitement de 200 CHF » et « acceptation garantie contre 250 CHF » : montants **inventés**, ils n'existent pas.
- Toute option proposant un **conseil médical** au client est hors compétence, donc fausse.
- Toute option proposant de transmettre des **données de santé à des tiers** est contraire à la nLPD, donc fausse.

## Chômeurs et LAA

Point d'erreur récurrent : les personnes au chômage sont assurées **d'office auprès de la SUVA** (art. 22a LACI), **indépendamment** de toute condition d'heures de travail, de contrat ou d'assurance privée. La règle des 8 heures ne s'applique pas ici.

## Survivants LAA

La rente de veuve ou veuf suppose **l'une** des trois conditions : avoir des **enfants**, avoir **plus de 45 ans**, ou être **invalide aux deux tiers**. À défaut, c'est une **allocation en capital** — c'est le cas régulièrement oublié.
$MD$, 2
WHERE NOT EXISTS (SELECT 1 FROM afa_fiches WHERE key = 'pieges');

INSERT INTO afa_fiches (filiere_key, theme_id, key, title, summary, content_md, sort_order)
SELECT 'maladie_complementaire', NULL, 'produits_lca',
  'Produits LCA — canevas à compléter',
  'Structure de la fiche. Les montants doivent être relevés sur les conditions produits réelles.',
$MD$
## Pourquoi cette fiche est vide

Les tentatives précédentes ont buté sur des questions portant sur les **prestations commerciales concrètes** des complémentaires : montants remboursés, plafonds, pourcentages. Ces montants **ne sont pas fixés par la loi** : ils varient d'un assureur et d'un produit à l'autre.

Les inventer serait la pire chose à faire dans un outil de préparation d'examen. Cette fiche est donc un **canevas** : les valeurs doivent être relevées sur les conditions générales et fiches produits réelles des principales caisses (Helsana, CSS, Groupe Mutuel, SWICA, Sanitas, Concordia), puis saisies ici.

## Postes à documenter

- **Chirurgie oculaire au laser** : part remboursée et plafond
- **Médecine alternative** (homéopathie, ostéopathie, acupuncture) : pourcentage et plafond annuel
- **Dentaire** : part remboursée, plafond, délai de carence
- **Lunettes et lentilles** : forfait, périodicité
- **Prestations à l'étranger** : part remboursée hors urgence
- **Assurance voyage et rapatriement** : couverture typique
- **Cures thermales et convalescence** : forfait journalier, durée
- **Fitness et prévention** : contribution annuelle
- **Transport et sauvetage** : plafond
- **Division hospitalière** (commune, demi-privée, privée) : ce que chaque niveau ouvre

## Méthode de relevé

Pour chaque poste, noter l'**ordre de grandeur** et la **fourchette** entre caisses plutôt qu'un montant unique. Les questions d'examen portent en général sur le niveau de couverture typique du marché, pas sur le tarif exact d'un assureur donné.

## Ce qui est en revanche fixé par la loi

Tout ce qui relève de l'AOS figure dans la fiche **Chiffres clés du cadre légal**. La frontière entre les deux est elle-même un sujet d'examen : savoir dire ce qui est légal et ce qui est contractuel.
$MD$, 3
WHERE NOT EXISTS (SELECT 1 FROM afa_fiches WHERE key = 'produits_lca');
