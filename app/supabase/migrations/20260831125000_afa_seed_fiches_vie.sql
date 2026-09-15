-- ═════════════════════════════════════════════════════════
-- Klary — Fiches « questions d'experts » (filière vie)
-- FICHIER GÉNÉRÉ — source : scripts/afa, cas d'examen série zéro 2022.
--
-- Ces questions viennent de l'épreuve ORALE (30 min de préparation +
-- 30 min d'oral, 100 points), qui est un format différent de l'épreuve
-- écrite de 30 minutes. Elles sont donc proposées comme fiches de
-- révision, pas comme questions de simulation.
-- ═════════════════════════════════════════════════════════

INSERT INTO afa_fiches (filiere_key, theme_id, key, title, summary, content_md, sort_order)
SELECT 'vie', t.id, 'cas_deces', 'Questions d''experts — cas Décès',
  '8 questions ouvertes avec réponse type, issues d''un cas d''examen oral.',
  '## Questions posées par les experts — cas Décès

Questions ouvertes tirées d''un cas d''examen oral. Réponds à voix haute avant de lire la solution : c''est la restitution orale qui est évaluée.

### 1. Pour quelle raison doit-on remplir ce formulaire ?
Devoir d''information / identité SE / indication des entreprises avec lesquelles il collabore / responsabilité / protection des données (1/2 point par bonne réponse) 2 (Reporter ces points) 

### 2. Quelle est la différence entre un intermédiaire lié et un intermédiaire non lié ?
L''intermédiaire lié réalise plus de 50% de son chiffre d''affaires avec 1 ou 2 assureurs ; sa responsabilité et ses obligations en termes de formation sont différentes. 2 points (Reporter ces points)  Graphique propre et compréhensible 2  Besoin : 90 000 1  Salaire de Rahel : 42 000 1  Rente AVS d''orphelin : 10 740 1  Rente d''orphelin au titre de la LAA : 13 500 (15% de 90 000) 1  Rente subsidiaire d''orphelin au titre de la LPP : 4435 max. 1  Rente AVS de veuve : aucun droit 1 Cas Nessier-Keller (décès accident, concubinage) Examens AFA p

### 3. Qu''en est-il du partage de la succession en cas de décès ?
L''héritage revient intégralement à l''enfant commun. 1 (Reporter ces points)

### 4. Comment la situation du concubin survivant peut-elle être améliorée en cas de décès ?
Souscription d''une police du risque décès 3a ou 3b / réduire par testament la part de l''enfant à la part réservataire et allouer la quotité libre au concubin survivant. 2 (Reporter ces points)

### 5. Quelles prescriptions de forme doivent être respectées dans le cas d''un testament ?
Forme manuscrite, date et signature, acte authentifié par un notaire, testament d''urgence (oral) également possible 2 (Reporter ces points)

### 6. L''assurance de l''inventaire du ménage est-elle obligatoire ?
Dans le canton de Fribourg, l''inventaire du ménage doit obligatoirement être assuré contre le risque Incendie (si le candidat mentionne uniquement l''inventaire du ménage et pas le risque incendie, attribuer uniquement 1 point) 2 points (Reporter ces points)

### 7. Le preneur d''assurance peut-il choisir lui-même l''assurance de l''inventaire du ménage ?
Oui, l''assurance en cas d''incendie est certes obligatoire, mais le preneur d''assurance peut choisir librement son assureur. 1 point (Reporter ces points) d) Les frais de vie supplémentaires sont pris en charge par l''assurance de l''inventaire du ménage (parce que logement a été temporairement inhabitable). Experts : la prise en charge des frais de vie est-elle plafonnée ?  Il s''agit en général d''un % de la SA 2 points d) La perte du revenu locatif subie par le propriétaire est généralement couverte dans le cadre de son assurance dégâts des eaux

### 8. Nous cherchons évidemment d''autres optimisations budgétaires possibles concernant le frère. Quelles économies sont-elles possibles dans le cadre de la caisse-maladie obligatoire ?
changer d''assureur / opter pour un modèle alternatif / choisir une franchise plus élevée / (exclure le risque d''accident) 3 points (Reporter ces points)
', 10
FROM afa_themes t WHERE t.filiere_key = 'vie' AND t.key = 'garantie_revenus'
  AND NOT EXISTS (SELECT 1 FROM afa_fiches WHERE key = 'cas_deces');

INSERT INTO afa_fiches (filiere_key, theme_id, key, title, summary, content_md, sort_order)
SELECT 'vie', t.id, 'cas_invalidite', 'Questions d''experts — cas Invalidité',
  '7 questions ouvertes avec réponse type, issues d''un cas d''examen oral.',
  '## Questions posées par les experts — cas Invalidité

Questions ouvertes tirées d''un cas d''examen oral. Réponds à voix haute avant de lire la solution : c''est la restitution orale qui est évaluée.

### 1. Pour quelle raison doit-on remplir ce formulaire ?
Devoir d''information / identité SE / indication des entreprises avec lesquelles il collabore / responsabilité / protection des données (1/2 point par bonne réponse) 2 points (Reporter ces points)

### 2. Quelle est la différence entre un intermédiaire lié et un intermédiaire non lié ?
L''intermédiaire lié réalise plus de 50% de son chiffre d''affaires avec 1 ou 2 assureurs ; sa responsabilité et ses obligations en termes de formation sont différentes. 2 points (Reporter ces points)  Graphique propre et compréhensible 2  Besoin : 36 000 1  Court terme, pas de couverture pendant 1 à 2 ans 1  Lacune phase 1 : 36 000 1  Mention du fait que l''AI pourrait intervenir déjà au bout d''un an 1  Rente AI d''Ajla : 19 188 1  Rente d''enfant AI : 7680 1  Lacune phase 2 : 9132 1  Suppression de la rente d''enfant AI à 18/25 ans 1  Lac

### 3a. Comment le montant de la rente AI est-il calculé ?
En se reposant sur le revenu annuel AVS moyen déterminant conformément à l''extrait du CI

### 3b. De quoi faut-il tenir compte pour le calcul ?
Des revenus de l''activité lucrative à partir de 21 ans. (Demander 3 (Reporter ces points) Cas Mujic (Invalidité Maladie Épouse)Examens AFA pour intermédiaires Série zero 2022 Page 5 de 14 l''âge) / Bonifications pour tâches éducatives ou bonifications pour tâches d''assistance

### 4. Si les revenus bruts de Madame Mujic s''élevaient « seulement » à 15 000, pourrait-elle également souscrire une prévoyance liée ?
Oui, car elle dispose d''un revenu soumis à l''AVS et qu''elle peut recourir au pilier 3a jusqu''à concurrence de 20% de ses revenus nets (ne pas pénaliser le candidat, s''il ne sait pas s''il s''agit des revenus bruts ou nets). 2 (Reporter ces points)

### 6. Que signifie la négligence grave dans la circulation routière ? Donnez deux exemples. Quelles sont les conséquences d''une négligence grave ?
Commet une négligence grave toute personne qui ne tient pas compte des mesures de précaution élémentaires. Par ex., ne pas respecter un stop ou un feu rouge, franchir une bande blanche, écrire des SMS, utiliser son téléphone portable au volant, etc. (1 point pour la bonne explication, 1/2 point pour chaque exemple, 1 point max.) Conséquences : l''assurance peut se retourner contre le responsable du dommage qui a agi par négligence et demander le remboursement d''une partie de l''indemnisation versée.  3 points (Reporter ces points)

### 6. Mais nous disposons d''une protection juridique passive dans le cadre de notre assurance de la responsabilité civile privée familiale ? Cette couverture ne sert-elle à rien ici ?
Toute assurance de la responsabilité civile privée comprend une protection juridique passive. Cela signifie que l''assurance aide la personne assurée à se prémunir contre des prétentions injustifiées, c''est-à-dire des prétentions élevées alors que la responsabilité de l''assuré n''est pas engagée. En conséquence, cela permet de repousser des prétentions, mais pas d''en élever. Pour cela, il faut une assurance de la protection juridique. 3 points (Reporter ces points) c)  Aide l''assuré à élever des prétentions en lui apportant les conseils nécessai
', 11
FROM afa_themes t WHERE t.filiere_key = 'vie' AND t.key = 'garantie_revenus'
  AND NOT EXISTS (SELECT 1 FROM afa_fiches WHERE key = 'cas_invalidite');

INSERT INTO afa_fiches (filiere_key, theme_id, key, title, summary, content_md, sort_order)
SELECT 'vie', t.id, 'cas_retraite', 'Questions d''experts — cas Retraite',
  '10 questions ouvertes avec réponse type, issues d''un cas d''examen oral.',
  '## Questions posées par les experts — cas Retraite

Questions ouvertes tirées d''un cas d''examen oral. Réponds à voix haute avant de lire la solution : c''est la restitution orale qui est évaluée.

### 01. Est-il possible de se faire verser l''avoir de vieillesse obligatoire sous forme de capital unique au lieu d''une rente de vieillesse?
La loi autorise le versement du quart de l''avoir de vieillesse sous forme d''indemnité unique en capital, le reste sous forme de rente réduite en conséquence. De nombreuses CP autorisent un retrait de capital plus élevé en fonction de leurs règlements. 2 (Transférer ces points)

### 02. Quel montant les deux pourraient-ils verser tous les ans conjointement dans la prévoyance liée?
Etant donné que les deux sont assurés au titre de la LPP, ils peuvent chacun verser un montant maximal de 6''883.- par année. Ce qui donne ensemble: 13''766.- 1 (Transférer ce point)  Etant donné qu''ils prendront leur retraite dans 20 ans, une variante liée à des fonds est envisageable pour augmenter les revenus. Pour ce faire, il faudrait cependant définir les profils de risque des deux. 2

### 03. En cas de retrait anticipé des rentes AVS, faut-il toujours verser les cotisations AVS? Comment les cotisations sont-elles calculées?
Oui, l''obligation de cotiser persiste jusqu''à l''atteinte de l''âge ordinaire de la retraite pour les personnes sans activité lucrative. La fortune et 20 fois le revenu des rentes servent de base du calcul. 2 (Transférer ces points) 

### 04a. Les avoirs 3a peuvent-ils également être perçus à l''âge de 63 ans?
Oui, jusqu''à 5 ans avant la retraite  

### 04b. Dans quelles circonstance est-il possible de bénéficier d''un versement anticipé du pilier 3a?
Activité indépendante, départ définitif de la Suisse, EPL, en cas d''AI complète, si l''AI n''est pas assurée (0,5 point chacun, 1,5 point au maximum 2 (Transférer ces points)

### 05. Quelles assurances complémentaires sont possibles dans l''assurance responsabilité civile pour particuliers?
Conduite de véhicules de tiers, négligence grave, chasseurs, drones, go-kart, chevaux loués, etc. (0,5 point chacun, max. 2 points) 2 (Transférer ces points) b)  Dommages (dommages corporels ou matériels; gains perdus)  Acte illicite  Lien de causalité adéquate  Faute 2 c) La responsabilité civile privée (couverture familiale), mais elle n''est pas obligatoire. L''assurance prend en charge les prétentions justifiées et conteste les prétentions injustifiées en responsabilité (protection juridique passive). L''assurance responsabilité civile pri

### 06a. Mon frère m''a conseillé de veiller à ce que la négligence grave soit incluse dans l''assurance. Que voulait-il dire par là?
En ajoutant "Renonciation au recours en cas de négligence grave", la compagnie d''assurance renonce au recours financier si le client a commis une négligence grave. 1 (Transférer ces points)

### 06b. Quel serait l''exemple où cette couverture en responsabilité civile privée entrerait en jeu ?
De nombreux exemples possibles. En tant qu''expert, veille à ce qu''il s''agisse d''un exemple dans le domaine privé et non dans le domaine automobile. 1 (Transférer ces points)

### 07. Dans quelle mesure les prestations de l''assurance de base diffèrent-elles d''une caisse maladie à l''autre ?
Les prestations de l''assurance de base obligatoire sont prescrites par la loi et sont les mêmes pour toutes les caisses maladie. Seules les primes sont différentes. (Le catalogue détaillé des prestations ne doit pas être mentionné). 2 (Transférer ces points) b)  Par le biais des assurances complémentaires auprès de la caisse-maladie pour les traitements.  L''assurance voyages peut être conclue également pour couvrir les frais de sauvetage et de transport. 1 1 c) Une assurance voyages est judicieuse dans tous les cas. Une couverture sur toute l

### 08. Quels sont les événements assurés en cas d''annulation de voyages?
Accident / maladie / décès de la personne assurée, d''une personne proche ou de son suppléant sur le lieu de travail / perte d''emploi après la réservation (0,5 point par bonne réponse) 2 (Transférer ces points)
', 12
FROM afa_themes t WHERE t.filiere_key = 'vie' AND t.key = 'retraite'
  AND NOT EXISTS (SELECT 1 FROM afa_fiches WHERE key = 'cas_retraite');
