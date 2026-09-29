-- Seed des 2 modules de formation réservés au rôle back-office.
-- Généré depuis scratchpad/gen_backoffice_seed.py — idempotent.

INSERT INTO training_modules (key, title, description, duration_min, passing_score, target_roles, active) VALUES
  ('backoffice_assurance_maladie', 'Assurance maladie suisse — les bases', 'Le socle du métier : assurance de base et complémentaires, franchises et quote-part, modèles, délais de résiliation, questionnaire médical et réserve. À suivre avant le module métier.', 180, 80, ARRAY['backoffice']::text[], TRUE),
  ('backoffice_metier', 'Le métier d''assistante back-office', 'Le poste au quotidien : la règle des 48 heures, la checklist de complétude, la soumission, le polissage et les relances, les résiliations, les réclamations et les limites à ne pas franchir.', 120, 80, ARRAY['backoffice']::text[], TRUE)
ON CONFLICT (key) DO UPDATE SET
  title = EXCLUDED.title,
  description = EXCLUDED.description,
  duration_min = EXCLUDED.duration_min,
  passing_score = EXCLUDED.passing_score,
  target_roles = EXCLUDED.target_roles,
  active = TRUE,
  updated_at = NOW();

-- Questions : on purge puis on réinsère, pour rester idempotent.
DELETE FROM training_questions WHERE module_key IN ('backoffice_assurance_maladie', 'backoffice_metier');

INSERT INTO training_questions
  (module_key, external_id, category, question_type, question, options, correct, explanation, why_wrong, consequence, active) VALUES
(
  'backoffice_assurance_maladie', 'BO-AM-01', 'Le système suisse', 'single',
  'L''assurance de base offre-t-elle les mêmes prestations chez tous les assureurs ?',
  '["Non, chaque assureur définit librement ses prestations", "Oui, elles sont fixées par la loi. Seul le prix change", "Oui, mais uniquement pour les soins hospitaliers", "Non, cela dépend du canton de domicile"]'::jsonb,
  1,
  'Les prestations de l''assurance de base sont définies par la loi et sont identiques chez tous les assureurs. C''est pour cela que les clients changent d''assureur : pour payer moins cher la même chose.',
  '["Ce serait le cas en complémentaire, pas en assurance de base.", null, "Non, l''ensemble du catalogue est identique, pas seulement l''hospitalier.", "Le canton influence le prix de la prime, jamais les prestations."]'::jsonb,
  'Croire que les prestations diffèrent conduit à mal expliquer un changement d''assureur au client, qui s''attend alors à être mieux remboursé.',
  TRUE
),
(
  'backoffice_assurance_maladie', 'BO-AM-02', 'Le système suisse', 'single',
  'Une compagnie peut-elle refuser un client ?',
  '["Elle peut refuser aussi bien en assurance de base qu''en complémentaire", "Elle ne peut jamais refuser, ni en base ni en complémentaire", "Elle ne peut jamais refuser en base, mais elle peut refuser en complémentaire sans se justifier", "Elle peut refuser en base uniquement si le client est en contentieux"]'::jsonb,
  2,
  'L''obligation d''acceptation ne vaut que pour l''assurance de base. En complémentaire, la compagnie choisit ses clients et n''a pas à motiver un refus.',
  '["L''assurance de base impose l''acceptation de tout le monde.", "La liberté de refus existe bel et bien en complémentaire.", null, "Le contentieux bloque un changement d''assureur, il n''autorise pas un refus d''affiliation."]'::jsonb,
  'Promettre une complémentaire à un client qui sera ensuite refusé détruit la confiance et fait perdre aussi le dossier d''assurance de base.',
  TRUE
),
(
  'backoffice_assurance_maladie', 'BO-AM-03', 'Participation aux coûts', 'single',
  'En plus de sa prime mensuelle, que paie un assuré ?',
  '["Uniquement la franchise", "La franchise et la quote-part", "La franchise, la quote-part, et la contribution hospitalière de 15 francs par jour", "Uniquement la quote-part"]'::jsonb,
  2,
  'Trois éléments s''ajoutent à la prime : la franchise (la première tranche de frais), la quote-part (10 % au-delà, plafonnée), et la contribution hospitalière de 15 francs par jour en cas d''hospitalisation.',
  '["Il manque la quote-part et la contribution hospitalière.", "Il manque la contribution hospitalière de 15 francs par jour.", null, "La franchise se paie avant toute quote-part."]'::jsonb,
  'Oublier un de ces éléments fausse toute estimation du reste à charge annoncée au client.',
  TRUE
),
(
  'backoffice_assurance_maladie', 'BO-AM-04', 'Participation aux coûts', 'single',
  'Quelle est la franchise par défaut d''un adulte, et celle d''un enfant ?',
  '["300 francs pour l''adulte, 300 francs pour l''enfant", "300 francs pour l''adulte, 0 franc pour l''enfant", "500 francs pour l''adulte, 100 francs pour l''enfant", "0 franc pour l''adulte comme pour l''enfant"]'::jsonb,
  1,
  'L''adulte a une franchise ordinaire de 300 francs. L''enfant n''a aucune franchise par défaut : elle est de 0 franc, avec des options de 100 à 600 francs.',
  '["Un enfant n''a pas de franchise par défaut. Saisir 300 est l''erreur de saisie la plus fréquente.", null, "500 et 100 sont des options, pas les valeurs par défaut.", "L''adulte a bien une franchise ordinaire de 300 francs."]'::jsonb,
  'Saisir 300 francs pour un enfant crée un écart entre la proposition et la police, et un remboursement refusé que le client découvre à la première facture.',
  TRUE
),
(
  'backoffice_assurance_maladie', 'BO-AM-05', 'Participation aux coûts', 'single',
  'Quel est le plafond annuel de la quote-part pour un adulte ?',
  '["350 francs", "500 francs", "700 francs", "Il n''y a pas de plafond"]'::jsonb,
  2,
  'La quote-part est de 10 % des frais au-delà de la franchise, plafonnée à 700 francs par an pour un adulte et 350 francs pour un enfant.',
  '["350 francs est le plafond applicable aux enfants.", "Ce montant ne correspond à aucun plafond légal.", null, "Le plafond existe précisément pour protéger l''assuré des gros sinistres."]'::jsonb,
  'Annoncer un reste à charge sans plafond inquiète inutilement un client atteint d''une maladie lourde.',
  TRUE
),
(
  'backoffice_assurance_maladie', 'BO-AM-06', 'Participation aux coûts', 'single',
  'Si un client augmente sa franchise, que devient sa prime mensuelle ?',
  '["Elle augmente", "Elle diminue", "Elle reste identique", "Cela dépend du canton"]'::jsonb,
  1,
  'Plus la franchise est élevée, moins la prime est chère. C''est un pari : l''assuré accepte de payer davantage en cas de maladie, en échange d''une prime mensuelle réduite.',
  '["C''est l''inverse : une franchise haute fait baisser la prime.", null, "Le choix de la franchise a un effet direct et immédiat sur la prime.", "Le canton influence le niveau général des primes, pas ce mécanisme."]'::jsonb,
  'Inverser cette logique conduit à orienter un client jeune et en bonne santé vers une franchise basse, ce qui lui coûte plusieurs centaines de francs par an sans contrepartie.',
  TRUE
),
(
  'backoffice_assurance_maladie', 'BO-AM-07', 'Calcul', 'single',
  'Un client a une franchise de 1 000 francs et 3 000 francs de frais médicaux dans l''année. Combien paie-t-il au total, franchise et quote-part comprises ?',
  '["1 000 francs", "1 200 francs", "1 300 francs", "1 700 francs"]'::jsonb,
  1,
  'Il paie d''abord les 1 000 francs de franchise. Il reste 2 000 francs, dont il paie 10 %, soit 200 francs de quote-part. Total : 1 200 francs.',
  '["C''est la franchise seule. Il faut ajouter la quote-part sur le solde.", null, "La quote-part se calcule sur les 2 000 francs restants, pas sur les 3 000.", "Ce montant dépasserait le plafond de quote-part et ne correspond à aucun calcul."]'::jsonb,
  'Une estimation fausse du reste à charge est la première cause de réclamation client après une première facture.',
  TRUE
),
(
  'backoffice_assurance_maladie', 'BO-AM-08', 'Délais', 'single',
  'Quelle est la date limite pour résilier une assurance de base pour le 31 décembre ?',
  '["31 août", "30 septembre", "31 octobre", "30 novembre"]'::jsonb,
  1,
  'Le préavis est de trois mois pour une fin au 31 décembre, soit le 30 septembre au plus tard. Le courrier doit être reçu par la compagnie à cette date, pas seulement posté.',
  '["Le préavis est de trois mois, pas quatre.", null, "Le 31 octobre est déjà trop tard, le délai est dépassé.", "Le 30 novembre concerne le changement de franchise ou de modèle, pas la résiliation."]'::jsonb,
  'Une résiliation en retard d''un seul jour est refusée et le client reste engagé une année entière de plus, souvent avec une prime plus élevée.',
  TRUE
),
(
  'backoffice_assurance_maladie', 'BO-AM-09', 'Délais', 'single',
  'Une résiliation d''assurance de base arrive chez la compagnie le 2 octobre. Que se passe-t-il ?',
  '["Elle est acceptée avec un mois de décalage", "Elle est acceptée pour le 30 juin suivant", "Elle est refusée : le client reste chez son assureur toute l''année suivante", "Elle est acceptée si le client paie des frais de dossier"]'::jsonb,
  2,
  'Le délai du 30 septembre est impératif. Passé cette date, la résiliation est refusée et le contrat se reconduit pour une année civile complète.',
  '["Il n''existe aucun report d''un mois en assurance de base.", "L''échéance du 30 juin ne s''applique pas ici.", null, "Aucun paiement ne permet de rattraper un délai légal dépassé."]'::jsonb,
  'C''est une erreur irréparable. Le client la découvre en janvier, quand il reçoit une prime qu''il pensait avoir quittée.',
  TRUE
),
(
  'backoffice_assurance_maladie', 'BO-AM-10', 'Délais', 'single',
  'Jusqu''à quand un client peut-il changer de franchise ou de modèle chez son assureur actuel ?',
  '["30 septembre", "31 octobre", "30 novembre", "31 décembre"]'::jsonb,
  2,
  'Le changement de franchise ou de modèle chez le même assureur se fait jusqu''au 30 novembre, pour un effet au 1er janvier.',
  '["Le 30 septembre concerne la résiliation, c''est-à-dire le changement d''assureur.", "Cette date ne correspond à aucune échéance.", null, "Le 31 décembre est la fin de l''année d''assurance, pas une date limite de démarche."]'::jsonb,
  'Confondre les deux dates fait rater une optimisation simple, alors que le client était encore dans les temps.',
  TRUE
),
(
  'backoffice_assurance_maladie', 'BO-AM-11', 'Complémentaires', 'single',
  'Quelle est la durée minimale d''un contrat complémentaire et le préavis de résiliation ?',
  '["1 an, avec un préavis d''un mois", "3 ans dont 2 années civiles complètes, avec un préavis de 3 mois", "5 ans, avec un préavis de 6 mois", "Aucune durée minimale, résiliable à tout moment"]'::jsonb,
  1,
  'Le contrat est conclu pour trois années au minimum, dont deux années civiles pleines et échues, et la résiliation doit parvenir trois mois avant l''échéance contractuelle.',
  '["Ces délais correspondent à d''autres types de contrats.", null, "Aucune complémentaire n''impose cinq ans.", "Les complémentaires sont bien engageantes sur une durée minimale."]'::jsonb,
  'Annoncer à un client qu''il peut résilier librement l''expose à une reconduction qu''il n''avait pas anticipée.',
  TRUE
),
(
  'backoffice_assurance_maladie', 'BO-AM-12', 'Complémentaires', 'single',
  'Qu''est-ce qu''une réserve ?',
  '["Une somme d''argent bloquée par la compagnie", "L''exclusion d''une maladie précise dans un contrat complémentaire", "Un délai avant le début des remboursements", "Une réduction de prime accordée pour un bon dossier"]'::jsonb,
  1,
  'La réserve est l''exclusion d''une affection déterminée. La compagnie accepte le client, mais ne remboursera jamais ce qui est lié à cette affection. Elle dure en principe indéfiniment et ne peut être levée qu''après cinq ans au plus tôt, sur certificat médical.',
  '["Une réserve n''a rien d''un montant financier.", null, "Cette définition est celle du délai de carence.", "La réserve est une restriction, jamais un avantage."]'::jsonb,
  'Un client qui ignore sa réserve se croit couvert et découvre le refus au moment du sinistre, c''est-à-dire au pire moment.',
  TRUE
),
(
  'backoffice_assurance_maladie', 'BO-AM-13', 'Complémentaires', 'single',
  'Quelles sont les conséquences d''une réticence pour le client ?',
  '["Une amende administrative", "Une simple augmentation de prime", "L''annulation des complémentaires, aucun remboursement, aucune restitution des primes versées", "Un avertissement de la compagnie"]'::jsonb,
  2,
  'La réticence est le fait d''avoir caché une affection dans le questionnaire médical. La compagnie annule les contrats complémentaires, ne rembourse rien, ne restitue pas les primes, et le client risque de ne plus être assurable ailleurs.',
  '["Il ne s''agit pas d''une sanction administrative mais d''une conséquence contractuelle.", "Les conséquences sont bien plus lourdes qu''un ajustement de prime.", null, "La compagnie ne se limite jamais à un avertissement en cas de réticence."]'::jsonb,
  'C''est la situation la plus grave du métier : le client perd sa couverture au moment où il en a besoin, et le conseiller engage sa responsabilité.',
  TRUE
),
(
  'backoffice_assurance_maladie', 'BO-AM-14', 'Questionnaire médical', 'single',
  'Un client vous demande de corriger une réponse sur son questionnaire médical. Que faites-vous ?',
  '["Vous corrigez, puisque c''est lui qui le demande", "Vous corrigez et vous ajoutez une mention à côté", "Vous refusez et vous transmettez au conseiller", "Vous corrigez si l''erreur vous paraît évidente"]'::jsonb,
  2,
  'On ne touche jamais à un questionnaire médical. Toute modification doit être portée par le client lui-même et confirmée par sa signature. En cas de doute, on transmet au conseiller.',
  '["Une correction non signée par le client peut être assimilée à une falsification.", "Une mention ne remplace pas la signature du client sur la correction.", null, "Le caractère évident d''une erreur ne change rien : ce n''est pas à vous d''en juger."]'::jsonb,
  'Une correction non signée expose le dossier à une contestation, et le conseiller à l''annulation de sa convention et de ses commissions.',
  TRUE
),
(
  'backoffice_assurance_maladie', 'BO-AM-15', 'Complémentaires', 'single',
  'À partir de quel âge l''âge d''entrée est-il garanti à vie chez Assura ?',
  '["Dès 18 ans", "Dès 26 ans", "Dès 30 ans", "Cette garantie n''existe pas"]'::jsonb,
  1,
  'Dès 26 ans, l''assuré conserve définitivement le tarif correspondant à son âge d''entrée, sur les catégories qui portent cette garantie. Les produits dont le nom contient Varia en sont exclus.',
  '["La garantie ne s''acquiert pas à la majorité.", null, "L''âge de référence est 26 ans, pas 30.", "C''est au contraire l''un des principaux arguments de fidélisation."]'::jsonb,
  'Résilier une complémentaire sans mesurer cette garantie fait perdre au client un tarif figé depuis des années, définitivement.',
  TRUE
),
(
  'backoffice_assurance_maladie', 'BO-AM-16', 'Le groupe Assura', 'single',
  'Quelle société du groupe porte l''assurance de base ?',
  '["Assura SA", "Assura-Basis SA", "Assura Holding SA", "Figeas SA"]'::jsonb,
  1,
  'Assura-Basis SA porte l''assurance obligatoire des soins. Assura SA porte les complémentaires. Un même client a donc souvent deux contrats et deux numéros.',
  '["Assura SA est l''entité des assurances complémentaires.", null, "La holding ne porte aucun contrat d''assurance directement.", "Figeas SA est l''entité de services du groupe."]'::jsonb,
  'Adresser un document à la mauvaise entité retarde le traitement du dossier de plusieurs jours.',
  TRUE
),
(
  'backoffice_assurance_maladie', 'BO-AM-17', 'Vocabulaire', 'single',
  'Quelle est la différence entre le tiers payant et le tiers garant ?',
  '["Tiers payant : l''assuré paie d''abord, puis se fait rembourser", "Tiers payant : le prestataire de soins facture directement à l''assurance", "Les deux termes désignent la même chose", "Tiers garant : le canton garantit le paiement de la facture"]'::jsonb,
  1,
  'En tiers payant, le prestataire envoie la facture directement à l''assureur. En tiers garant, l''assuré reçoit la facture, la paie, puis se fait rembourser.',
  '["C''est la définition du tiers garant, pas du tiers payant.", null, "Ce sont deux systèmes opposés, avec des conséquences très différentes pour la trésorerie du client.", "Le canton n''intervient pas dans ce mécanisme."]'::jsonb,
  'Confondre les deux conduit à dire au client qu''il n''aura rien à avancer alors qu''il recevra la facture chez lui.',
  TRUE
),
(
  'backoffice_assurance_maladie', 'BO-AM-18', 'Contrôle des dossiers', 'single',
  'Vous recevez une police. Quel document devez-vous systématiquement comparer avec elle ?',
  '["Les conditions générales d''assurance", "Le décompte de prestations", "La proposition signée par le client", "L''ancienne police chez le précédent assureur"]'::jsonb,
  2,
  'La police doit être comparée à la proposition signée. En cas de divergence, c''est la proposition qui fait foi, mais encore faut-il repérer l''écart à temps pour le faire valoir.',
  '["Les conditions générales décrivent le produit, pas ce que le client a demandé.", "Le décompte concerne les remboursements, il arrive bien plus tard.", null, "L''ancienne police sert au comparatif commercial, pas au contrôle de conformité."]'::jsonb,
  'Un écart découvert deux ans plus tard, au moment d''un remboursement refusé, ne se rattrape plus et fait perdre le client.',
  TRUE
),
(
  'backoffice_assurance_maladie', 'BO-AM-19', 'Limites du poste', 'single',
  'Un client vous demande au téléphone si son assurance rembourse une paire de lunettes. Que faites-vous ?',
  '["Vous répondez que non, l''assurance de base ne couvre pas les lunettes", "Vous vérifiez dans les conditions générales et vous lui répondez", "Vous ne répondez pas, vous notez la question et le conseiller le rappelle", "Vous renvoyez le client directement vers la compagnie"]'::jsonb,
  2,
  'Répondre à une question de couverture est du conseil, qui ne fait pas partie de votre mission. Vous notez la question et vous la transmettez au conseiller.',
  '["Même une réponse exacte reste du conseil, et elle peut être fausse selon les complémentaires souscrites.", "Vérifier ne change rien : c''est la nature de la réponse qui pose problème.", null, "Renvoyer le client vers la compagnie donne l''impression que Klary ne suit pas son dossier."]'::jsonb,
  'Une réponse approximative sur une couverture engage le cabinet et se retourne contre lui au moment du remboursement.',
  TRUE
),
(
  'backoffice_assurance_maladie', 'BO-AM-20', 'Contentieux', 'single',
  'Vous préparez une résiliation et vous voyez une mention de poursuites sur le dossier. Que faites-vous ?',
  '["Vous envoyez quand même, résilier est un droit du client", "Vous envoyez et vous notez la remarque dans le dossier", "Vous n''envoyez rien et vous signalez au conseiller", "Vous demandez vous-même au client de régulariser"]'::jsonb,
  2,
  'Un assuré en contentieux de primes ne peut pas changer d''assureur. La résiliation serait refusée. On n''envoie rien et on signale.',
  '["Le droit de résilier est suspendu tant que le contentieux n''est pas réglé.", "Envoyer un document voué au refus fait perdre du temps et décrédibilise le cabinet.", null, "Aborder un impayé avec le client relève du conseiller, pas du back-office."]'::jsonb,
  'Une résiliation envoyée dans cette situation est refusée, et le client croit à tort avoir changé d''assureur au 1er janvier.',
  TRUE
),
(
  'backoffice_metier', 'BO-ME-01', 'Les délais', 'single',
  'Quel est le délai maximum entre la signature d''un dossier et son envoi à la compagnie ?',
  '["24 heures", "48 heures", "5 jours ouvrés", "2 semaines"]'::jsonb,
  1,
  'La règle du cabinet est de 48 heures maximum entre la signature et la transmission à la compagnie. C''est l''un des trois indicateurs du poste.',
  '["24 heures n''est pas tenable avec les relances de pièces manquantes.", null, "Au-delà de 48 heures, le client peut se rétracter et l''ancienne assurance continue de courir.", "Deux semaines laisserait un dossier s''endormir complètement."]'::jsonb,
  'Un dossier qui traîne perd de la valeur : la police n''est pas émise, le client peut changer d''avis et un concurrent peut passer.',
  TRUE
),
(
  'backoffice_metier', 'BO-ME-02', 'Les délais', 'single',
  'À partir de quel moment le compteur des 48 heures démarre-t-il ?',
  '["À la signature du client", "À la notification du dossier signé, ou à la validation qualité s''il y a eu un appel qualité", "À la réception des documents papier", "Au premier jour ouvré suivant la signature"]'::jsonb,
  1,
  'Le compteur part de la notification du dossier signé. Si un appel qualité a été réalisé, il part de la validation qualité.',
  '["La signature peut avoir lieu hors de vos horaires, le compteur ne part qu''à la notification.", null, "Le dossier est traité en numérique, le papier n''est pas le déclencheur.", "Il n''y a pas de report automatique au jour ouvré suivant."]'::jsonb,
  'Se tromper de point de départ fausse l''indicateur et masque des retards réels.',
  TRUE
),
(
  'backoffice_metier', 'BO-ME-03', 'Les délais', 'single',
  'Dans quel délai devez-vous au minimum ouvrir un dossier signé ?',
  '["Dans les 4 heures", "Dans les 24 heures", "Dans les 48 heures", "Quand le planning le permet"]'::jsonb,
  0,
  'Il faut ouvrir le dossier dans les 4 heures, même sans le traiter immédiatement, pour repérer tout de suite une pièce manquante et lancer la relance au plus tôt.',
  '[null, "Attendre 24 heures fait perdre la moitié du délai de 48 heures avant même d''avoir commencé.", "À 48 heures, le délai est déjà épuisé.", "Ce type de dossier ne se traite pas au fil du planning."]'::jsonb,
  'Découvrir une pièce manquante le deuxième jour rend le délai de 48 heures intenable.',
  TRUE
),
(
  'backoffice_metier', 'BO-ME-04', 'Complétude', 'single',
  'Quelle pièce rend le dossier non conforme si elle est absente ?',
  '["La copie de la carte d''assurance", "Le document d''information au sens de l''art. 45", "Un relevé bancaire", "Un certificat médical du médecin traitant"]'::jsonb,
  1,
  'Le document d''information prévu par l''art. 45 LSA est obligatoire. Sans lui, le dossier n''est pas conforme, indépendamment de la qualité du conseil donné.',
  '["Utile, mais son absence ne rend pas le dossier non conforme.", null, "Un relevé bancaire n''est pas une pièce de conformité.", "Un certificat médical n''est demandé que dans des cas précis, sur demande de la compagnie."]'::jsonb,
  'Un dossier non conforme expose le cabinet lors d''un contrôle, même si le client est satisfait.',
  TRUE
),
(
  'backoffice_metier', 'BO-ME-05', 'Complétude', 'single',
  'Il manque une pièce dans un dossier. Que notifiez-vous au conseiller ?',
  '["Un message indiquant que le dossier est incomplet", "La liste précise des pièces manquantes", "Rien, vous attendez qu''il s''en aperçoive", "Vous renvoyez directement le dossier au client"]'::jsonb,
  1,
  'On notifie la liste précise : pas « dossier incomplet », mais « il manque le procès-verbal signé et la copie de la police LAMal ». Puis on relance jusqu''à obtention.',
  '["Un message vague oblige le conseiller à tout revérifier et fait perdre une journée.", null, "Attendre garantit le dépassement du délai de 48 heures.", "Le contact client passe par le conseiller, pas par le back-office."]'::jsonb,
  'Une notification imprécise est la première cause de dépassement du délai de 48 heures.',
  TRUE
),
(
  'backoffice_metier', 'BO-ME-06', 'Soumission', 'single',
  'Pourquoi faut-il systématiquement récupérer l''accusé de réception ?',
  '["C''est une exigence comptable", "C''est la seule preuve de la date d''envoi", "Il permet de facturer la compagnie", "Il déclenche le paiement de la commission"]'::jsonb,
  1,
  'L''accusé de réception établit la date d''envoi. En cas de litige sur un délai, notamment pour une résiliation, c''est la seule pièce qui compte.',
  '["La comptabilité n''intervient pas à ce stade du dossier.", null, "La facturation ne dépend pas de l''accusé de réception.", "La commission est liée à l''émission de la police, pas à l''accusé."]'::jsonb,
  'Sans accusé, une résiliation contestée par la compagnie est perdue, et le client paie une année de prime supplémentaire.',
  TRUE
),
(
  'backoffice_metier', 'BO-ME-07', 'Polissage', 'single',
  'Quels sont les quatre types de retour possibles d''une compagnie ?',
  '["Accepté ou refusé, simplement", "Police émise, demande de pièces, contre-proposition, refus", "Validé, en attente, annulé", "Conforme ou non conforme"]'::jsonb,
  1,
  'Une compagnie renvoie soit la police émise, soit une demande de pièces, soit une contre-proposition avec réserve ou surprime, soit un refus. Chacun se saisit et se notifie.',
  '["Cette vision binaire ignore les demandes de pièces, pourtant le retour le plus fréquent.", null, "Ce vocabulaire ne correspond pas aux retours des compagnies.", "La conformité est un contrôle interne, pas un retour de compagnie."]'::jsonb,
  'Ne pas reconnaître une contre-proposition conduit à la traiter comme une acceptation, et le client découvre sa réserve trop tard.',
  TRUE
),
(
  'backoffice_metier', 'BO-ME-08', 'Polissage', 'single',
  'Une compagnie renvoie une contre-proposition avec une réserve. Que faites-vous ?',
  '["Vous acceptez si la réserve vous paraît mineure", "Vous appelez le client pour lui expliquer la réserve", "Vous saisissez, vous notifiez le conseiller, et c''est lui qui présente au client", "Vous refusez au nom du client"]'::jsonb,
  2,
  'Une contre-proposition modifie le contrat. La présenter au client relève du conseil, donc du conseiller. Votre rôle est de saisir et de notifier sans délai.',
  '["Apprécier la portée d''une réserve est une décision de conseil.", "Expliquer une réserve à un client, c''est du conseil.", null, "Refuser engage le client sur une décision qui lui appartient."]'::jsonb,
  'Accepter ou refuser à la place du client engage le cabinet sur une décision qui n''est pas la sienne.',
  TRUE
),
(
  'backoffice_metier', 'BO-ME-09', 'Polissage', 'single',
  'Quel est le calendrier de relance des compagnies ?',
  '["J+7, J+14, J+21", "J+14 relance, J+21 relance appuyée, J+30 escalade à la direction", "J+30 uniquement", "Une relance par semaine, sans limite"]'::jsonb,
  1,
  'Première relance à J+14, relance appuyée à J+21 en rappelant la date de soumission, puis escalade à la direction à J+30. Au-delà d''un mois, on ne relance plus seul.',
  '["Relancer à J+7 est prématuré, les compagnies n''ont pas encore instruit le dossier.", null, "Attendre 30 jours pour la première relance laisse le dossier s''endormir.", "Une relance hebdomadaire sans escalade ne débloque jamais un dossier vraiment bloqué."]'::jsonb,
  'Sans escalade à J+30, un dossier peut rester bloqué des mois sans que personne ne s''en aperçoive.',
  TRUE
),
(
  'backoffice_metier', 'BO-ME-10', 'Résiliations', 'single',
  'Comment une résiliation doit-elle être envoyée, et que faire de la copie ?',
  '["Courrier simple, copie scannée dans l''outil", "Courriel avec accusé de lecture", "Recommandé avec accusé de réception, et copie papier classée dans le classeur physique", "Remise en main propre au client"]'::jsonb,
  2,
  'L''envoi se fait en recommandé avec accusé de réception, et la copie papier se classe dans le classeur physique. C''est une obligation légale suisse : le numérique ne suffit pas.',
  '["Le courrier simple ne permet aucune preuve de réception.", "Le courriel n''est pas recevable pour une résiliation.", null, "La résiliation s''adresse à la compagnie, pas au client."]'::jsonb,
  'Sans preuve de réception, une résiliation contestée est perdue, et sans copie papier le cabinet est en défaut lors d''un contrôle.',
  TRUE
),
(
  'backoffice_metier', 'BO-ME-11', 'Résiliations', 'single',
  'Quand une résiliation est-elle réellement terminée ?',
  '["Dès l''envoi du recommandé", "Dès la saisie dans l''outil de gestion", "Quand la confirmation de l''ancienne compagnie est arrivée et saisie", "Au 31 décembre de l''année en cours"]'::jsonb,
  2,
  'Tant que la confirmation de l''ancienne compagnie n''est pas reçue et saisie, le dossier reste ouvert. Sans cela, le client risque de payer deux assurances.',
  '["L''envoi ne garantit pas que la compagnie l''a enregistrée.", "La saisie ne remplace pas la confirmation de la compagnie.", null, "La date du calendrier ne clôt pas le dossier administratif."]'::jsonb,
  'Une résiliation non confirmée laisse le client avec deux contrats actifs et une double prime en janvier.',
  TRUE
),
(
  'backoffice_metier', 'BO-ME-12', 'Résiliations', 'single',
  'Quelle est la date limite de résiliation de l''assurance de base, et suffit-il de poster le courrier ce jour-là ?',
  '["30 septembre, et il suffit de poster ce jour-là", "30 septembre, et le courrier doit être reçu à cette date", "31 décembre, et il suffit de poster", "30 novembre, et le courrier doit être reçu"]'::jsonb,
  1,
  'Le délai est le 30 septembre, et c''est la réception par la compagnie qui compte, pas la date d''envoi. C''est pour cela que le recommandé se prépare plusieurs jours avant.',
  '["Poster le 30 septembre est déjà trop tard : la compagnie doit l''avoir reçu.", null, "Le 31 décembre est la fin de l''année d''assurance, pas une date de démarche.", "Le 30 novembre concerne le changement de franchise ou de modèle."]'::jsonb,
  'Poster le dernier jour fait perdre une année entière au client, alors que le dossier était prêt à temps.',
  TRUE
),
(
  'backoffice_metier', 'BO-ME-13', 'Résiliations', 'single',
  'Quelles sont les deux situations qui bloquent une résiliation ?',
  '["Un client résidant à l''étranger et un client mineur", "Le contentieux de primes, et l''absence d''instruction écrite du conseiller pour une complémentaire", "Un contrat de plus de trois ans et un client âgé", "Une prime impayée et un changement d''adresse récent"]'::jsonb,
  1,
  'Un assuré en contentieux ne peut pas changer d''assureur. Et une complémentaire ne se résilie jamais sans instruction écrite, sous peine de faire perdre au client son âge d''entrée.',
  '["Ni la résidence ni l''âge ne bloquent une résiliation.", null, "Trois ans est au contraire la condition pour pouvoir résilier une complémentaire.", "Un changement d''adresse ne bloque rien."]'::jsonb,
  'Résilier une complémentaire sans instruction fait perdre au client un tarif figé depuis des années, de façon irréversible.',
  TRUE
),
(
  'backoffice_metier', 'BO-ME-14', 'Réclamations', 'single',
  'Une réclamation vous est faite oralement et elle vous paraît infondée. Que faites-vous ?',
  '["Vous ne l''enregistrez pas, puisqu''elle est infondée", "Vous répondez au client pour clarifier le malentendu", "Vous l''enregistrez dans le tracker et vous alertez : ce n''est pas à vous de juger", "Vous attendez qu''elle soit formulée par écrit"]'::jsonb,
  2,
  'Toute réclamation s''enregistre, même orale, même apparemment infondée. Le registre des réclamations répond à une obligation de surveillance et peut être demandé lors d''un contrôle.',
  '["Une réclamation non enregistrée est un manquement, même si elle a été bien traitée.", "Répondre sur le fond ne relève pas du back-office.", null, "Attendre l''écrit revient à ne pas enregistrer une réclamation pourtant exprimée."]'::jsonb,
  'Un registre incomplet est un manquement constatable lors d''un contrôle, indépendamment du bien-fondé de la réclamation.',
  TRUE
),
(
  'backoffice_metier', 'BO-ME-15', 'Limites du poste', 'single',
  'Un client vous demande au téléphone si un traitement est remboursé. Que faites-vous ?',
  '["Vous vérifiez dans son contrat et vous lui répondez", "Vous ne répondez pas, vous notez la question et le conseiller le rappelle", "Vous transférez l''appel à la compagnie", "Vous répondez que ce n''est pas remboursé, par prudence"]'::jsonb,
  1,
  'Répondre à une question de couverture est du conseil. Vous notez la question et vous la transmettez au conseiller, qui rappelle le client.',
  '["Même en vérifiant, répondre reste du conseil.", null, "Transférer donne l''impression que le cabinet ne suit pas le dossier.", "Une réponse négative par prudence est tout aussi engageante qu''une réponse positive."]'::jsonb,
  'Une réponse erronée sur une couverture engage le cabinet et se découvre au moment du remboursement, quand il est trop tard.',
  TRUE
);
