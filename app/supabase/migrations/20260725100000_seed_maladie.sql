-- ═════════════════════════════════════════════════════════

-- Klary — Seed questions Module Maladie (40 questions)

-- ═════════════════════════════════════════════════════════



INSERT INTO training_questions (module_key, external_id, category, question_type, question, options, correct, explanation, active) VALUES
  ('maladie', 'M001', 'LAMal — Bases', 'single', 'L''assurance-maladie de base (LAMal) est obligatoire pour :', '["Uniquement les résidents suisses de plus de 25 ans", "Toute personne domiciliée en Suisse, quel que soit son âge", "Uniquement les personnes salariées", "Uniquement les résidents suisses de nationalité suisse"]'::jsonb, 1, 'La LAMal impose l''affiliation à une caisse maladie pour toute personne domiciliée en Suisse, dans les 3 mois suivant l''établissement.', TRUE)
ON CONFLICT DO NOTHING;

INSERT INTO training_questions (module_key, external_id, category, question_type, question, options, correct, explanation, active) VALUES
  ('maladie', 'M002', 'LAMal — Franchises', 'single', 'En 2026, quelle est la franchise annuelle minimum pour un adulte en LAMal ?', '["0 CHF", "300 CHF", "500 CHF", "2''500 CHF"]'::jsonb, 1, 'La franchise annuelle minimum LAMal adulte est de 300 CHF (avec la prime la plus élevée). Max 2''500 CHF avec prime la plus basse.', TRUE)
ON CONFLICT DO NOTHING;

INSERT INTO training_questions (module_key, external_id, category, question_type, question, options, correct, explanation, active) VALUES
  ('maladie', 'M003', 'LAMal — Modèles alternatifs', 'single', 'Un modèle ''Médecin de famille'' impose au client de :', '["Consulter d''abord son médecin de famille désigné avant tout spécialiste (sauf urgences)", "Payer 100% de ses médicaments", "Renoncer à toute couverture accidents", "Consulter uniquement à l''hôpital public"]'::jsonb, 0, 'Le modèle médecin de famille exige de passer par le généraliste désigné avant tout spécialiste — en échange, réduction de prime de 10-20%.', TRUE)
ON CONFLICT DO NOTHING;

INSERT INTO training_questions (module_key, external_id, category, question_type, question, options, correct, explanation, active) VALUES
  ('maladie', 'M004', 'LAMal — Quote-part', 'single', 'Quel est le montant maximum annuel de la quote-part LAMal pour un adulte ?', '["500 CHF", "700 CHF", "1''000 CHF", "1''500 CHF"]'::jsonb, 1, 'Quote-part : 10% des frais après franchise, plafonnée à 700 CHF/an pour un adulte (350 CHF/an pour un enfant).', TRUE)
ON CONFLICT DO NOTHING;

INSERT INTO training_questions (module_key, external_id, category, question_type, question, options, correct, explanation, active) VALUES
  ('maladie', 'M005', 'LAMal — Résiliation', 'single', 'Un client veut changer de caisse LAMal pour le 1er janvier. Quelle est la date limite de dépôt de la résiliation ?', '["30 septembre", "31 octobre", "30 novembre", "15 décembre"]'::jsonb, 2, 'Résiliation LAMal : dépôt avant le 30 novembre pour effet au 31 décembre — la résiliation doit ÊTRE REÇUE par la caisse (pas juste postée) à cette date.', TRUE)
ON CONFLICT DO NOTHING;

INSERT INTO training_questions (module_key, external_id, category, question_type, question, options, correct, explanation, active) VALUES
  ('maladie', 'M006', 'LCA — Nature du contrat', 'single', 'Quelle est la différence fondamentale entre LAMal et LCA ?', '["LAMal est obligatoire, LCA est facultative et privée", "LAMal est privée, LCA est publique", "Il n''y a pas de différence, c''est le même contrat", "LCA est uniquement pour les enfants"]'::jsonb, 0, 'LAMal = assurance de base OBLIGATOIRE (mêmes prestations partout). LCA = complémentaires FACULTATIVES, régies par contrat privé (art. 3+ LCA).', TRUE)
ON CONFLICT DO NOTHING;

INSERT INTO training_questions (module_key, external_id, category, question_type, question, options, correct, explanation, active) VALUES
  ('maladie', 'M007', 'LCA — Ambulatoire', 'single', 'Quelle prestation N''EST PAS typiquement couverte par une LCA ambulatoire standard ?', '["Médicaments hors liste des spécialités", "Séjour hospitalier en division privée", "Lunettes et lentilles de contact", "Médecines complémentaires (acupuncture, homéopathie)"]'::jsonb, 1, 'Le séjour hospitalier en division privée nécessite une LCA HOSPITALIÈRE distincte, pas ambulatoire.', TRUE)
ON CONFLICT DO NOTHING;

INSERT INTO training_questions (module_key, external_id, category, question_type, question, options, correct, explanation, active) VALUES
  ('maladie', 'M008', 'LCA — Hospitalier', 'single', 'La LCA ''chambre semi-privée'' (2 lits) permet typiquement :', '["Un séjour dans une chambre à 4 lits mais avec télévision", "Un séjour dans une chambre à 2 lits avec libre choix du médecin", "Uniquement des séjours à l''étranger", "Un remboursement de 50% des frais d''hôpital"]'::jsonb, 1, 'LCA semi-privé = chambre à 2 lits + libre choix du médecin dans les hôpitaux répertoriés — c''est le confort intermédiaire entre commune et privé.', TRUE)
ON CONFLICT DO NOTHING;

INSERT INTO training_questions (module_key, external_id, category, question_type, question, options, correct, explanation, active) VALUES
  ('maladie', 'M009', 'LCA — Résiliation', 'single', 'La résiliation LCA doit être envoyée avant :', '["30 juin pour effet 31 décembre", "30 septembre pour effet 31 décembre", "30 novembre pour effet 31 décembre", "31 décembre pour effet immédiat"]'::jsonb, 1, 'LCA : résiliation à envoyer avant le 30 septembre pour effet au 31 décembre (délai de préavis 3 mois pour un contrat à échéance annuelle).', TRUE)
ON CONFLICT DO NOTHING;

INSERT INTO training_questions (module_key, external_id, category, question_type, question, options, correct, explanation, active) VALUES
  ('maladie', 'M010', 'Compagnies — Groupe Mutuel', 'single', 'Chez Groupe Mutuel, la gamme ''Global'' correspond à :', '["Une gamme hospitalière semi-privée", "Une gamme ambulatoire à 3 niveaux (Classic, Flex, Smart)", "Une couverture dentaire enfants", "Une assurance protection juridique"]'::jsonb, 1, 'Groupe Mutuel Global : gamme ambulatoire principale, 3 niveaux — Classic (économique) / Flex (confort) / Smart (haut de gamme).', TRUE)
ON CONFLICT DO NOTHING;

INSERT INTO training_questions (module_key, external_id, category, question_type, question, options, correct, explanation, active) VALUES
  ('maladie', 'M011', 'Compagnies — Helsana', 'single', 'Quel est le produit phare (Topseller) d''Helsana en ambulatoire ?', '["TOP", "SANA", "COMPLETA", "PRIMEO"]'::jsonb, 2, 'COMPLETA est le produit phare Helsana en ambulatoire — couverture intermédiaire-haute, présente dans la plupart des packages recommandés.', TRUE)
ON CONFLICT DO NOTHING;

INSERT INTO training_questions (module_key, external_id, category, question_type, question, options, correct, explanation, active) VALUES
  ('maladie', 'M012', 'Compagnies — CSS', 'single', 'La gamme ''myFlex'' de CSS propose combien de niveaux d''ambulatoire ?', '["2 (Balance et Premium)", "3 (Economy, Balance, Premium)", "4 (Basic, Economy, Balance, Premium)", "5 niveaux progressifs"]'::jsonb, 1, 'myFlex CSS : 3 niveaux (Economy / Balance / Premium) — pour l''ambulatoire ET l''hospitalier.', TRUE)
ON CONFLICT DO NOTHING;

INSERT INTO training_questions (module_key, external_id, category, question_type, question, options, correct, explanation, active) VALUES
  ('maladie', 'M013', 'Compagnies — Assura', 'single', 'Chez Assura, quel produit couvre les médecines alternatives par des THÉRAPEUTES (pas médecins) ?', '["Complementa Extra", "Denta Plus", "Natura", "Mondia"]'::jsonb, 2, 'Natura = médecines alternatives chez thérapeutes reconnus (ostéo, acupuncture, MTC…). Medna = même chose mais chez médecins FMH.', TRUE)
ON CONFLICT DO NOTHING;

INSERT INTO training_questions (module_key, external_id, category, question_type, question, options, correct, explanation, active) VALUES
  ('maladie', 'M014', 'Compagnies — SWICA', 'single', 'SWICA propose 3 gammes ambulatoires. Laquelle est la plus haut de gamme ?', '["Completa Praevita", "Supplementa", "Completa Forte", "Optima"]'::jsonb, 2, 'Completa Forte est la gamme la plus haut de gamme SWICA. Completa Top vient juste en dessous. Praevita = focus prévention.', TRUE)
ON CONFLICT DO NOTHING;

INSERT INTO training_questions (module_key, external_id, category, question_type, question, options, correct, explanation, active) VALUES
  ('maladie', 'M015', 'Subsides RIP', 'single', 'En Vaud, la Réduction Individuelle de Primes (RIP) est accordée :', '["À tous les résidents automatiquement", "Selon le revenu déterminant du ménage (seuils cantonaux)", "Uniquement aux frontaliers", "Uniquement pendant les 3 premières années en Suisse"]'::jsonb, 1, 'La RIP est calculée selon le revenu déterminant du ménage (revenu net + fortune + parts familiales). Chaque canton fixe ses seuils. Environ 30% des Vaudois y ont droit.', TRUE)
ON CONFLICT DO NOTHING;

INSERT INTO training_questions (module_key, external_id, category, question_type, question, options, correct, explanation, active) VALUES
  ('maladie', 'M016', 'LSA — Devoir d''information (art. 45)', 'single', 'Avant toute signature de contrat LCA, l''agent Klary doit obligatoirement remettre au client :', '["Une brochure marketing de la compagnie", "Une fiche d''information LSA art. 45 (identité, rémunération, nature du courtage)", "Un contrat de mandat signé notarié", "Rien de particulier, l''oral suffit"]'::jsonb, 1, 'Art. 45 LSA : devoir d''information client OBLIGATOIRE. Fiche écrite avec identité, statut FINMA, rémunération, mode de traitement des données. Sans elle, contrat annulable.', TRUE)
ON CONFLICT DO NOTHING;

INSERT INTO training_questions (module_key, external_id, category, question_type, question, options, correct, explanation, active) VALUES
  ('maladie', 'M017', 'LSA — Protocole de conseil', 'single', 'Le protocole de conseil pour chaque affaire signée est :', '["Optionnel selon le client", "Fourni par la compagnie et doit être rempli + signé par le client", "Rédigé par l''agent lui-même sur papier libre", "Uniquement requis pour les contrats > 5''000 CHF"]'::jsonb, 1, 'Chaque compagnie fournit son propre protocole de conseil (PV). L''agent le remplit avec le client, tous deux le signent. Protection juridique pour agent + client.', TRUE)
ON CONFLICT DO NOTHING;

INSERT INTO training_questions (module_key, external_id, category, question_type, question, options, correct, explanation, active) VALUES
  ('maladie', 'M018', 'ABI — Formation continue', 'single', 'L''ABI (Accord de branche des intermédiaires) impose combien d''heures de formation continue par an à partir de la 2e année d''activité ?', '["5 heures", "15 heures", "30 heures", "50 heures"]'::jsonb, 1, 'ABI : 30h la 1re année, 15h/an ensuite. Klary prend tout en charge. Sans certification ABI valide, l''agent ne peut plus légalement exercer.', TRUE)
ON CONFLICT DO NOTHING;

INSERT INTO training_questions (module_key, external_id, category, question_type, question, options, correct, explanation, active) VALUES
  ('maladie', 'M019', 'nLPD — Protection des données', 'single', 'Un agent Klary peut-il envoyer les données santé d''un client par WhatsApp à un collègue ?', '["Oui, si les 2 sont salariés Klary", "Non, jamais — utilisation du CRM Klary uniquement", "Oui, uniquement pour un cas urgent", "Oui, si le message est effacé après lecture"]'::jsonb, 1, 'Données santé = catégorie sensible nLPD art. 5 al. c. WhatsApp non conforme (serveurs hors CH, chiffrement E2E mais pas contrôlé par Klary). CRM Klary + emails chiffrés uniquement.', TRUE)
ON CONFLICT DO NOTHING;

INSERT INTO training_questions (module_key, external_id, category, question_type, question, options, correct, explanation, active) VALUES
  ('maladie', 'M020', 'Méthode Klary — Étapes RDV', 'single', 'Combien d''étapes comporte la méthode Klary pour un RDV client ?', '["3 étapes", "5 étapes", "7 étapes", "10 étapes"]'::jsonb, 1, 'Méthode Klary en 5 étapes : ① Prise de contact · ② Découverte · ③ Analyse & comparaison · ④ Recommandation & signature · ⑤ Suivi post-signature.', TRUE)
ON CONFLICT DO NOTHING;

INSERT INTO training_questions (module_key, external_id, category, question_type, question, options, correct, explanation, active) VALUES
  ('maladie', 'M021', 'Méthode Klary — Timing appel', 'single', 'Après réception d''un lead dans le CRM, quel est le délai maximum d''appel selon la méthode Klary ?', '["Dans la journée", "Dans les 30 minutes", "Dans les 4 heures", "Dans les 24 heures"]'::jsonb, 1, 'Engagement qualité Klary : appel dans les 30 minutes. Un lead ''chaud'' se refroidit vite — après 1h, taux de RDV divisé par 3.', TRUE)
ON CONFLICT DO NOTHING;

INSERT INTO training_questions (module_key, external_id, category, question_type, question, options, correct, explanation, active) VALUES
  ('maladie', 'M022', 'Résiliation — Stratégie Klary', 'single', 'Pourquoi Klary privilégie-t-elle le DÉPÔT PHYSIQUE en agence plutôt que l''envoi postal des résiliations ?', '["C''est plus rapide et moins cher", "Preuve légale par tampon + zéro appel de rétention par la compagnie", "C''est obligatoire selon la loi", "Les compagnies n''acceptent pas les résiliations postales"]'::jsonb, 1, 'Dépôt physique = tampon compagnie sur la feuille = preuve incontestable + la compagnie ne peut plus appeler le client pour rétention (contrat déjà résilié).', TRUE)
ON CONFLICT DO NOTHING;

INSERT INTO training_questions (module_key, external_id, category, question_type, question, options, correct, explanation, active) VALUES
  ('maladie', 'M023', 'Résiliation — Calendrier', 'single', 'Klary organise deux tournées annuelles de dépôt physique. Quelles sont ces dates ?', '["1er septembre pour LCA · 1er novembre pour LAMal", "24-25 septembre pour LCA · 24-25 novembre pour LAMal", "15 septembre pour LCA · 15 novembre pour LAMal", "Dernier vendredi de chaque mois"]'::jsonb, 1, 'Calendrier officiel Klary : tournée LCA les 24-25 septembre (avant échéance 30 sept), tournée LAMal les 24-25 novembre (avant échéance 30 nov).', TRUE)
ON CONFLICT DO NOTHING;

INSERT INTO training_questions (module_key, external_id, category, question_type, question, options, correct, explanation, active) VALUES
  ('maladie', 'M024', 'Rémunération', 'single', 'Sur une commission LCA maladie, quel pourcentage est rétrocédé à l''agent Klary ?', '["20 %", "25 %", "31 %", "50 %"]'::jsonb, 2, 'Rétrocession agent LCA maladie : 31% de la commission Klary. Le compte de caution retient 10% supplémentaires sur cette rétrocession.', TRUE)
ON CONFLICT DO NOTHING;

INSERT INTO training_questions (module_key, external_id, category, question_type, question, options, correct, explanation, active) VALUES
  ('maladie', 'M025', 'Compte de caution', 'single', 'Le compte de caution de 10 % sert à :', '["Financer les formations continues", "Couvrir les éventuelles décommissions si un client résilie tôt", "Payer les charges sociales de l''agent", "Rembourser Klary si l''agent démissionne"]'::jsonb, 1, 'Compte de caution 10% : réserve pour absorber les chargebacks (résiliations client dans les mois suivant la signature). Restituable au terme du contrat si aucun problème.', TRUE)
ON CONFLICT DO NOTHING;

INSERT INTO training_questions (module_key, external_id, category, question_type, question, options, correct, explanation, active) VALUES
  ('maladie', 'M026', 'Éthique — Situation client', 'single', 'Un client vous demande de lui vendre le produit LCA qui vous rapporte LE PLUS de commission. Vous devez :', '["Accepter et lui vendre ce produit", "Lui expliquer que vous vendez ce qui lui convient LE MIEUX, pas ce qui vous rapporte le plus", "Refuser catégoriquement et mettre fin au RDV", "Lui proposer un pourcentage sur votre commission"]'::jsonb, 1, 'Neutralité = valeur fondamentale Klary. Un client qui pose cette question est méfiant — la bonne réponse est de rappeler notre positionnement : conseil neutre, meilleur produit POUR LUI.', TRUE)
ON CONFLICT DO NOTHING;

INSERT INTO training_questions (module_key, external_id, category, question_type, question, options, correct, explanation, active) VALUES
  ('maladie', 'M027', 'Éthique — Cas de conscience', 'single', 'Vous constatez qu''un client a déjà une couverture LCA optimale pour sa situation. Il veut néanmoins signer chez Klary pour changer de compagnie. Que faites-vous ?', '["Faites signer immédiatement pour toucher la commission", "Lui expliquez honnêtement qu''il n''a rien à gagner à changer, sauf s''il souhaite un autre motif (service, image, etc.)", "Refusez catégoriquement de le prendre comme client", "Le renvoyez à son ancien agent"]'::jsonb, 1, 'Honnêteté avant commission. Si aucun gain client, on le dit. Le client peut avoir des raisons non financières (mauvais service ancien courtier, envie de neutralité), mais il doit décider en connaissance de cause.', TRUE)
ON CONFLICT DO NOTHING;

INSERT INTO training_questions (module_key, external_id, category, question_type, question, options, correct, explanation, active) VALUES
  ('maladie', 'M028', 'Rétractation LCA art. 40a', 'single', 'Combien de jours a le client pour se rétracter après signature d''un contrat LCA ?', '["7 jours", "14 jours", "30 jours", "3 mois"]'::jsonb, 1, 'LCA art. 40a : droit de rétractation de 14 jours après signature, sans pénalité ni justification. À mentionner au client au moment de la signature.', TRUE)
ON CONFLICT DO NOTHING;

INSERT INTO training_questions (module_key, external_id, category, question_type, question, options, correct, explanation, active) VALUES
  ('maladie', 'M029', 'Cas pratique — Famille', 'single', 'Une famille (2 adultes + 2 enfants, revenu 110''000 CHF/an) actuellement à 720 CHF/mois LAMal+LCA vous demande une comparaison. Quel produit LCA hospitalier lui conseiller en premier examen ?', '["Chambre privée dans toute la Suisse (top gamme)", "Chambre semi-privée avec libre choix médecin", "Aucune LCA hospitalière, juste LAMal", "Ils doivent d''abord se marier ailleurs"]'::jsonb, 1, 'Semi-privé est le meilleur rapport qualité/prix pour cette famille : confort chambre 2 lits + libre choix médecin, à environ 60-70% du coût d''un privé complet.', TRUE)
ON CONFLICT DO NOTHING;

INSERT INTO training_questions (module_key, external_id, category, question_type, question, options, correct, explanation, active) VALUES
  ('maladie', 'M030', 'Cas pratique — Étudiant', 'single', 'Un étudiant de 22 ans, revenu très bas, sans problème de santé, quelle stratégie LAMal lui conseiller ?', '["Franchise 2''500 CHF + modèle télémédecine + vérifier son droit au subside RIP", "Franchise minimum 300 CHF + LCA privée hospitalier", "Ne rien conseiller, il est trop jeune", "Uniquement LCA sans LAMal"]'::jsonb, 0, 'Profil bas risque + petit revenu → franchise 2''500 CHF (prime la plus basse) + télémédecine (économie 15-20%) + vérification RIP obligatoire (souvent éligible). Économie potentielle : 30-40% vs standard.', TRUE)
ON CONFLICT DO NOTHING;

INSERT INTO training_questions (module_key, external_id, category, question_type, question, options, correct, explanation, active) VALUES
  ('maladie', 'M031', 'Assiette commission', 'single', 'Comment se calcule typiquement la commission LCA reçue par Klary d''une compagnie ?', '["Forfait de 500 CHF par contrat", "Environ 16 primes mensuelles du contrat signé", "10% de la prime annuelle sur 30 ans", "Aucune commission, seulement rétrocession"]'::jsonb, 1, 'Commission LCA typique : ~16 primes mensuelles. Sur une prime de 90 CHF/mois → commission Klary ~1''440 CHF. Rétrocession agent 31% = 446 CHF.', TRUE)
ON CONFLICT DO NOTHING;

INSERT INTO training_questions (module_key, external_id, category, question_type, question, options, correct, explanation, active) VALUES
  ('maladie', 'M032', 'Communication client', 'vrai_faux', 'Vrai ou Faux : Klary peut promettre à un client qu''il économisera un montant précis grâce au changement de contrat.', '["Vrai", "Faux"]'::jsonb, 1, 'FAUX. Klary présente des SIMULATIONS et des estimations, jamais de promesses fermes. Interdit par la LSA et sanctionné par la FINMA en cas de plainte.', TRUE)
ON CONFLICT DO NOTHING;

INSERT INTO training_questions (module_key, external_id, category, question_type, question, options, correct, explanation, active) VALUES
  ('maladie', 'M033', 'Suivi client', 'vrai_faux', 'Vrai ou Faux : Après la signature, l''agent n''a plus aucune obligation envers le client jusqu''à l''échéance annuelle.', '["Vrai", "Faux"]'::jsonb, 1, 'FAUX. Klary assure un suivi actif : SMS de confirmation, appel J+30, RDV anniversaire N+12. Le client Klary n''est pas laissé seul.', TRUE)
ON CONFLICT DO NOTHING;

INSERT INTO training_questions (module_key, external_id, category, question_type, question, options, correct, explanation, active) VALUES
  ('maladie', 'M034', 'Conflit d''intérêt', 'vrai_faux', 'Vrai ou Faux : Un agent Klary peut vendre à un membre de sa famille en priorité.', '["Vrai", "Faux"]'::jsonb, 0, 'VRAI, mais avec la même exigence de neutralité et de qualité de conseil qu''avec tout autre client. Attention aux conflits d''intérêt : ne jamais forcer un proche à changer si sa couverture actuelle est bonne.', TRUE)
ON CONFLICT DO NOTHING;

INSERT INTO training_questions (module_key, external_id, category, question_type, question, options, correct, explanation, active) VALUES
  ('maladie', 'M035', 'Situation particulière', 'single', 'Un client vous dit : ''Je vais réfléchir'' à la fin du RDV. La bonne réaction est :', '["Accepter et le rappeler dans un mois", "Insister lourdement pour signer maintenant", "Isoler l''objection réelle : ''Concrètement, à quoi voulez-vous réfléchir ?''", "Baisser le prix immédiatement"]'::jsonb, 2, '''Je vais réfléchir'' cache souvent une objection non exprimée (peur, conjoint, prix). Méthode CRAC : Creuser en isolant la vraie raison.', TRUE)
ON CONFLICT DO NOTHING;

INSERT INTO training_questions (module_key, external_id, category, question_type, question, options, correct, explanation, active) VALUES
  ('maladie', 'M036', 'Documents obligatoires', 'single', 'Sur un dossier client signé, quel document DOIT figurer en plus du contrat lui-même ?', '["Un scan de la pièce d''identité uniquement", "Le protocole de conseil signé + la fiche art. 45 LSA + les résiliations si applicable", "Rien d''autre, le contrat suffit", "Une lettre manuscrite de motivation du client"]'::jsonb, 1, 'Dossier complet Klary : contrat signé + protocole de conseil (fourni par la compagnie) + fiche d''information LSA art. 45 + feuilles de résiliation de l''ancien contrat si changement.', TRUE)
ON CONFLICT DO NOTHING;

INSERT INTO training_questions (module_key, external_id, category, question_type, question, options, correct, explanation, active) VALUES
  ('maladie', 'M037', 'Personnes assurées', 'single', 'Pour un enfant de 15 ans dans un ménage LAMal, quelle particularité fiscale s''applique ?', '["Il n''est pas obligatoire de l''assurer avant 18 ans", "Rabais enfant automatique de 80% sur la prime + quote-part max 350 CHF/an", "Prime identique à celle d''un adulte", "L''enfant est assuré via l''école obligatoirement"]'::jsonb, 1, 'Enfants LAMal (jusqu''à 18 ans) : primes fortement réduites (rabais légal), quote-part plafonnée à 350 CHF/an, pas de franchise obligatoire.', TRUE)
ON CONFLICT DO NOTHING;

INSERT INTO training_questions (module_key, external_id, category, question_type, question, options, correct, explanation, active) VALUES
  ('maladie', 'M038', 'Frontaliers', 'single', 'Un frontalier français salarié en Suisse doit :', '["Obligatoirement s''affilier à une LAMal suisse", "Choisir entre LAMal suisse ou CMU française (droit d''option 3 mois après début activité)", "Rester obligatoirement à la CMU française", "Ne cotiser à rien du tout"]'::jsonb, 1, 'Droit d''option frontalier : dans les 3 mois du début d''activité en Suisse, choix entre LAMal CH ou CMU FR. Choix définitif. Impact énorme sur les cotisations et le niveau de soins.', TRUE)
ON CONFLICT DO NOTHING;

INSERT INTO training_questions (module_key, external_id, category, question_type, question, options, correct, explanation, active) VALUES
  ('maladie', 'M039', 'Étranger', 'single', 'Une LAMal couvre les soins d''urgence à l''étranger :', '["Jusqu''à concurrence de 200 CHF par an", "Jusqu''au double du tarif suisse du canton de domicile", "Pas du tout — il faut une LCA voyage", "Uniquement dans les pays de l''UE"]'::jsonb, 1, 'LAMal étranger urgence : max le double du tarif suisse du canton de domicile. Pour partir tranquille en voyage lointain, LCA voyage recommandée (Mondia, WORLD, etc.).', TRUE)
ON CONFLICT DO NOTHING;

INSERT INTO training_questions (module_key, external_id, category, question_type, question, options, correct, explanation, active) VALUES
  ('maladie', 'M040', 'Éthique — Confidentialité', 'single', 'Un ami commun d''un client vous demande combien celui-ci paie de primes. Vous répondez :', '["Vous donnez le montant, c''est un ami commun", "Vous répondez qu''il faut poser la question directement à votre client", "Vous donnez une estimation approximative", "Vous demandez à votre client par SMS s''il autorise"]'::jsonb, 1, 'Secret professionnel absolu (art. 45 LSA + nLPD). Aucune information sur un client à un tiers, même proche, même sans intention malveillante. Renvoyer la question au client lui-même.', TRUE)
ON CONFLICT DO NOTHING;



-- 40 questions insérées pour module 'maladie'