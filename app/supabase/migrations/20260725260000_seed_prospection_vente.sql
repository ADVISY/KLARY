-- ═════════════════════════════════════════════════════════
-- Klary — Nouveau module « Prospection & Vente »
--   • Techniques prospection téléphonique + terrain
--   • Qualification prospect
--   • Structure d'un entretien conseil (5 étapes)
--   • Traitement des objections classiques
--   • Closing
--   • Suivi + fidélisation
--   • Éthique Klary en situation commerciale
-- Passing 80% · Cooldown 24h après échec
-- ═════════════════════════════════════════════════════════

INSERT INTO training_modules (key, title, description, duration_min, passing_score)
VALUES
  ('prospection_vente',
   'Prospection & Vente',
   'Certification agent Klary sur les techniques de prospection, entretien conseil, traitement des objections, closing et fidélisation. Cœur du métier de courtier.',
   45,
   80)
ON CONFLICT (key) DO NOTHING;

UPDATE training_modules SET retry_cooldown_hours = 24 WHERE key = 'prospection_vente';

INSERT INTO training_questions
  (module_key, external_id, category, question_type, question, options, correct, explanation, why_wrong, consequence, active) VALUES

-- ───────── PROSPECTION TÉLÉPHONIQUE ─────────

('prospection_vente','V001','Prospection téléphonique','single',
$QK$Vous appelez un prospect à froid (lead reçu du service commercial). Quel est l'OBJECTIF principal de ce 1er appel ?$QK$,
$QK$["Vendre directement une police d'assurance", "Obtenir un rendez-vous (visio ou présentiel) pour un entretien conseil", "Faire une simulation de prime au téléphone", "Envoyer un devis par email immédiatement"]$QK$::jsonb,
1,
$QK$Règle d'or de la prospection téléphonique : le téléphone ne vend pas, il PRÉPARE la vente. L'objectif d'un 1er appel est UNIQUEMENT d'obtenir un RDV (30-45 min) pendant lequel vous pourrez faire une vraie analyse de besoin. Tenter de vendre au téléphone = passer à côté des vrais besoins + rater la vente.$QK$,
$QK$["Faute technique — le téléphone n'est pas fait pour vendre un produit financier complexe.", null, "Une simulation téléphonique est superficielle et engage sans conseil réel. Le devoir de conseil FINMA n'est pas rempli.", "Envoyer un devis sans analyse = manquement au devoir de conseil + le prospect zappe l'email."]$QK$::jsonb,
$QK$Erreur = agent qui pitche pendant 10 min au téléphone → prospect raccroche → aucun RDV obtenu → taux de conversion effondré. À 15 CHF le lead, chaque appel raté = perte sèche.$QK$,
TRUE),

('prospection_vente','V002','Prospection téléphonique','single',
$QK$Structure recommandée d'un pitch de prospection de 30 secondes ?$QK$,
$QK$["Détails techniques du produit + prix + questions", "1) Se présenter (nom + Klary), 2) Rappeler le contexte (lead, référence), 3) Annoncer le POURQUOI de l'appel (bilan gratuit, économies possibles), 4) Proposer 2 créneaux au choix pour un RDV", "Question ouverte : Vous avez besoin d'une assurance ?", "Historique complet de Klary depuis sa création"]$QK$::jsonb,
1,
$QK$Structure PABC : Présentation + Ancrage contexte + Bénéfice pour lui + Choix de créneau. En 30 secondes max. Le prospect doit comprendre en 3 secondes qui appelle et POURQUOI (bénéfice pour lui, pas pour Klary). La proposition de 2 créneaux ("mardi 14h ou jeudi 10h ?") force une décision plutôt que "êtes-vous dispo ?".$QK$,
$QK$["Trop technique + trop long — 90% des prospects raccrochent dans les 15 premières secondes de détails techniques.", null, "Question fermée à réponse quasi-toujours 'non merci'. Approche amateur.", "Personne ne veut entendre l'historique de Klary — ça n'apporte AUCUNE valeur au prospect."]$QK$::jsonb,
$QK$Erreur = pitch décousu → prospect confus → refus. Un bon pitch prospection téléphonique se répète comme un mantra jusqu'à ce que le taux de RDV monte à 25-35%.$QK$,
TRUE),

('prospection_vente','V003','Prospection téléphonique','single',
$QK$Combien d'appels de prospection réalistes un agent Klary doit-il passer par jour minimum ?$QK$,
$QK$["5 à 10 appels", "60 à 100 tentatives d'appels (dont ~30-40 conversations réelles, ~8-12 RDV obtenus)", "500 appels", "Zéro — les leads viennent tout seuls"]$QK$::jsonb,
1,
$QK$Standard courtage suisse en phase de démarrage : 60-100 numérotations/jour → 30-40 conversations vraies (répondeurs, pas là…) → 8-12 RDV/jour. Taux conversion appel→RDV = 15-25%. Sur 20 jours ouvrés = 160-240 RDV/mois. Sur ce volume, taux de signature 15-25% = 30-60 ventes/mois. C'est la mécanique commerciale de base.$QK$,
$QK$["Trop faible pour atteindre un objectif commercial sérieux.", null, "Non réaliste physiquement — max 100-120 numérotations/jour par un humain.", "Fausse conception — même les leads chauds nécessitent un rappel actif."]$QK$::jsonb,
$QK$Erreur = agent qui fait 15 appels/jour et attend miracle → 0-1 vente/mois → non-atteinte objectifs → décrochage → sortie de Klary sous 3 mois. La discipline volume est le moteur du métier.$QK$,
TRUE),

('prospection_vente','V004','Prospection téléphonique','single',
$QK$Quel est le MEILLEUR créneau horaire pour joindre des particuliers actifs au téléphone ?$QK$,
$QK$["8h-10h du lundi matin", "18h-20h en semaine + samedi 10h-12h", "12h-14h heure du déjeuner", "23h-1h nuit"]$QK$::jsonb,
1,
$QK$Fenêtres à haut taux de réponse : 18h-20h (sortie travail, disponible avant repas) + samedi matin 10h-12h. À l'inverse : 8h-10h lundi = personne veut être dérangé, 12h-14h = personne mange, journée en semaine = personne au travail. Optimiser son planning appel selon ce timing multiplie le taux de contact par 3-4.$QK$,
$QK$["Terrible timing — les gens sont au travail ou n'ont pas encore commencé leur journée.", null, "Personne ne veut être dérangé pendant le déjeuner. Manque de respect.", "Illégal (article 3 LCD sur les pratiques déloyales) — appels après 21h interdits pour prospection."]$QK$::jsonb,
$QK$Erreur = appeler pendant les heures de travail → 10% de contact → journée gâchée. Un agent qui structure sa journée avec fenêtres 18h-20h aura 30-40% de contacts, soit 3x plus de RDV.$QK$,
TRUE),

('prospection_vente','V005','Prospection réseau','single',
$QK$Meilleure source de leads pour un agent Klary sur le long terme ?$QK$,
$QK$["Achat de leads froids en masse", "RECOMMANDATIONS de clients existants satisfaits (parrainage) + réseau personnel + prospection ciblée", "Publicité Google en volume", "Prospection porte-à-porte"]$QK$::jsonb,
1,
$QK$Un lead recommandé a un taux de signature 3-4x supérieur à un lead froid (60% vs 15%) car la confiance est pré-établie. Le coût d'acquisition est aussi bien plus bas. Un agent expérimenté vise 30-50% de son business en recommandations. Systématiquement demander une recommandation à chaque client satisfait après signature = mécanique clé.$QK$,
$QK$["Coûteux + faible qualité — dépendance à un canal cher.", null, "Publicité massive = coût CAC élevé + leads moyennement qualifiés.", "Peu efficace en Suisse (culture privée) + réglementation stricte."]$QK$::jsonb,
$QK$Erreur = ne jamais demander de recommandation → dépendance totale au canal Klary → coût acquisition élevé → agent moins rentable. Chaque client signé DOIT être sollicité pour 2-3 recommandations.$QK$,
TRUE),

-- ───────── QUALIFICATION PROSPECT ─────────

('prospection_vente','V006','Qualification prospect','single',
$QK$Un prospect au téléphone dit "envoyez-moi juste un devis par email, je regarderai". Bonne réaction ?$QK$,
$QK$["Envoyer le devis immédiatement", "Refuser courtoisement : 'Sans une analyse de vos besoins, tout devis serait imprécis et pourrait vous coûter cher. 15 minutes en visio suffisent — mardi 18h ou jeudi 19h ?'", "Envoyer 3 devis pour choix", "Raccrocher"]$QK$::jsonb,
1,
$QK$Envoyer un devis sans analyse besoin = (1) violation devoir de conseil FINMA, (2) devis à côté de la plaque car mal calibré, (3) prospect qui ne rappelle jamais après réception (95% des cas). Refuser POLIMENT et REPROPOSER un RDV court est la seule voie pro. Argument : "sans analyse, le devis est inutile ET vous coûte cher".$QK$,
$QK$["Faute pro — devoir de conseil non rempli + prospect perdu.", null, "Empile les erreurs — 3 devis sans analyse = 3 fois plus faux.", "Manque de courtoisie et perte du lead qui pourrait signer plus tard."]$QK$::jsonb,
$QK$Erreur = agent qui envoie 20 devis/semaine sans RDV → 0-1 signature. À l'inverse, agent qui refuse et pousse pour RDV → 8-10 RDV → 2-3 signatures. Écart massif de productivité.$QK$,
TRUE),

('prospection_vente','V007','Qualification prospect','single',
$QK$Question de qualification LA PLUS IMPORTANTE à poser en début d'entretien ?$QK$,
$QK$["Quel est votre budget ?", "Qu'est-ce qui vous a poussé à accepter ce RDV aujourd'hui ? (ou : quel est votre objectif principal ?)", "Vous êtes chez qui actuellement ?", "Vous avez combien d'enfants ?"]$QK$::jsonb,
1,
$QK$Question ouverte sur la MOTIVATION du prospect = permet de comprendre son problème réel + son urgence. Sans cette info, vous vendez à l'aveugle. Les questions techniques (budget, actuel assureur, famille) viennent APRÈS. Le "pourquoi maintenant" est la clé du closing ultérieur.$QK$,
$QK$["Question directe budget = met le prospect en défense. À poser plus tard, en douceur.", null, "Question OK mais trop tactique — sans le POURQUOI, ne vous mène nulle part.", "Trop précoce — questions personnelles après avoir établi confiance."]$QK$::jsonb,
$QK$Erreur = commencer par des questions techniques → prospect se sent interviewé → il se ferme → RDV improductif. Ouvrir par la motivation = créer un dialogue naturel.$QK$,
TRUE),

('prospection_vente','V008','Qualification prospect','single',
$QK$Un prospect vous demande "Vous êtes indépendant ou salarié Klary ?" Que répondre ?$QK$,
$QK$["Ça ne vous regarde pas", "'Je suis conseiller Klary Sàrl, courtier indépendant multi-compagnies enregistré à la FINMA. Je représente 20+ compagnies suisses, ce qui me permet de vous proposer la meilleure solution parmi elles, pas juste une gamme.'", "Je suis indépendant sans lien avec Klary", "Compagnie unique X"]$QK$::jsonb,
1,
$QK$Question critique de confiance. Réponse à structurer clairement : (1) statut = agent Klary, (2) Klary = courtier indépendant multi-compagnies FINMA, (3) bénéfice pour lui = accès à 20+ compagnies au lieu d'être limité à 1. Cette réponse PROFESSIONNELLE différencie de suite un courtier d'un vendeur mono-compagnie.$QK$,
$QK$["Défensif et impoli — vous perdez le prospect immédiatement.", null, "Mensonge = faute déontologique grave + violation LSA (identification obligatoire).", "Mensonge encore pire — vous détournez le mandat Klary."]$QK$::jsonb,
$QK$Erreur = mal expliquer son statut → prospect confus → doute → refus. La transparence sur le statut est la fondation de la confiance client.$QK$,
TRUE),

-- ───────── STRUCTURE ENTRETIEN CONSEIL (5 ÉTAPES) ─────────

('prospection_vente','V009','Entretien conseil','single',
$QK$Les 5 étapes classiques d'un entretien conseil courtier réussi ?$QK$,
$QK$["Salutation, vente, closing, paiement, sortie", "1) Prise de contact (5 min) — briser la glace, 2) Découverte des besoins (15-20 min) — questions ouvertes, écoute active, 3) Analyse chiffrée (10 min) — présenter le diagnostic, 4) Proposition (10 min) — 2-3 solutions comparées, 5) Closing (5 min) — demander la signature", "Toujours parler produit sans écouter", "Toujours parler prix immédiatement"]$QK$::jsonb,
1,
$QK$Méthode structurée en 5 étapes, durée totale 45-60 min. Le point CRUCIAL : la découverte représente 1/3 du temps. Beaucoup d'agents inversent en parlant 80% du temps de leurs produits. Le bon courtier écoute 70% du temps, parle 30%. Le closing devient facile quand la découverte + analyse ont été bien faites.$QK$,
$QK$["Approche vendeur amateur — pas de découverte, pas d'analyse, pas de conseil.", null, "Défaut fatal — le client se sent instrumentalisé et ne signe pas.", "Le prix vient à la fin, après avoir démontré la valeur. Avant, chaque prix est jugé 'trop cher'."]$QK$::jsonb,
$QK$Erreur = brûler les étapes → prospect se sent poussé → refus. Le respect du timing des 5 étapes est ce qui différencie un pro d'un vendeur classique.$QK$,
TRUE),

('prospection_vente','V010','Entretien conseil','single',
$QK$Pendant la découverte, quel RATIO d'écoute vs de parole devez-vous respecter ?$QK$,
$QK$["50/50", "30% parole (questions ouvertes) / 70% écoute (le prospect s'exprime)", "80% parole (l'agent explique)", "100% écoute (aucune question)"]$QK$::jsonb,
1,
$QK$Règle des 30/70 : l'agent pose des questions et écoute activement. Beaucoup d'agents parlent 80% du temps de leurs produits — c'est l'inverse de ce qu'il faut faire. Les questions doivent être OUVERTES ("qu'est-ce qui vous préoccupe le plus dans votre situation actuelle ?", "comment voyez-vous votre retraite dans 20 ans ?"). Prise de notes obligatoire pour montrer qu'on écoute.$QK$,
$QK$["Encore trop d'agent qui parle — vous ne découvrez pas assez.", null, "Défaut classique du vendeur amateur — vous ne captez aucun besoin réel.", "Impossible en pratique — vous devez guider avec des questions."]$QK$::jsonb,
$QK$Erreur = agent qui parle plus que le prospect → prospect ne se sent pas écouté → il ne signera pas. Un agent qui écoute vraiment récolte 3-4x plus d'informations pour construire la bonne proposition.$QK$,
TRUE),

('prospection_vente','V011','Entretien conseil','single',
$QK$Un prospect vous confie une info personnelle sensible (dette, divorce, maladie…). Quelle attitude ?$QK$,
$QK$["Passer rapidement, ce n'est pas important", "Marquer un temps d'écoute, reconnaître : 'Je comprends, c'est une situation difficile. Merci de me faire confiance.' Puis intégrer discrètement cette info dans le conseil (protection famille, budget serré…).", "Prendre des notes détaillées visibles", "Rediriger vers un autre conseiller"]$QK$::jsonb,
1,
$QK$Empathie professionnelle. Les infos sensibles sont un signal de CONFIANCE — c'est un moment CRUCIAL de la relation. Reconnaître brièvement, remercier de la confiance, puis intégrer intelligemment dans la solution proposée. L'inverse (froid ou trop insistant) casse la confiance.$QK$,
$QK$["Faute humaine et commerciale — le prospect ferme définitivement.", null, "Intrusif — prendre des notes ostentatoires met mal à l'aise.", "Fuite déontologique — vous êtes le mandataire, assumez."]$QK$::jsonb,
$QK$Erreur = maladresse émotionnelle → confiance rompue → refus. L'empathie professionnelle est ce qui transforme un vendeur en conseiller de confiance.$QK$,
TRUE),

('prospection_vente','V012','Entretien conseil','single',
$QK$Combien de solutions proposer à la fin de l'entretien pour maximiser les chances de signature ?$QK$,
$QK$["Une seule (la meilleure)", "3 solutions (Économique / Équilibrée / Premium) avec la médiane recommandée — technique du triple choix", "Toutes celles que je connais", "Aucune, laisser le prospect décider"]$QK$::jsonb,
1,
$QK$Psychologie décisionnelle : présenter 3 options crée un ANCRAGE (l'économique semble ridicule vs équilibrée, la premium chère → le prospect choisit équilibrée = celle que vous aviez ciblée). Une seule option = "prendre ou laisser", pousse au refus. 5+ options = paralysie décisionnelle. 3 = sweet spot.$QK$,
$QK$["Vous forcez le choix binaire prendre/laisser — 40% de refus.", null, "Paralysie décisionnelle — le prospect reporte la décision et ne signe jamais.", "Défaut de conseil grave — vous êtes payé pour recommander."]$QK$::jsonb,
$QK$Erreur = proposer 1 seule solution → prospect refuse ou négocie → taux signature 20%. À l'inverse triple choix → 40-50% signature immédiate.$QK$,
TRUE),

-- ───────── TRAITEMENT OBJECTIONS ─────────

('prospection_vente','V013','Objections','single',
$QK$Objection "J'ai DÉJÀ une assurance". Meilleure réponse ?$QK$,
$QK$["OK, au revoir", "'Justement — c'est le bon moment pour vérifier que vous êtes optimalement couvert et au meilleur prix. Je ne vous propose PAS de changer si votre solution actuelle est la meilleure. En 20 minutes, je peux vous confirmer ça.'", "Insister : votre assurance est nulle", "Envoyer un email"]$QK$::jsonb,
1,
$QK$Technique du "OUI ET" au lieu du "OUI MAIS". Reconnaître la couverture existante + reformuler comme opportunité de vérification bénéfique. Poser la promesse "je ne vous forcerai pas à changer si votre solution est la meilleure" désamorce la crainte de la vente forcée. 60% des prospects acceptent ce reframe.$QK$,
$QK$["Fuite — vous perdez un prospect qui aurait pu signer après 3 rappels.", null, "Attaque de la concurrence = interdit + met le prospect en défense.", "Solution flemmarde qui ne fonctionne pas."]$QK$::jsonb,
$QK$Erreur = accepter le "j'ai déjà" comme un non final. En réalité 90% des Suisses ont "déjà" une assurance — la vraie question est "sont-ils bien couverts au bon prix". Votre valeur = leur montrer l'écart.$QK$,
TRUE),

('prospection_vente','V014','Objections','single',
$QK$Objection "C'est TROP CHER". Meilleure réponse ?$QK$,
$QK$["Baisse le prix immédiatement", "'Trop cher par rapport à quoi ? Regardons ensemble le rapport prix/couverture. Je peux aussi vous montrer 2 options moins chères, mais je préfère être transparent sur ce qu'on gagne ou perd en fonction.'", "OK on arrête", "Attaquer avec un discount 50%"]$QK$::jsonb,
1,
$QK$Ne JAMAIS baisser le prix en réaction directe à cette objection — vous détruisez la valeur perçue. La bonne technique : (1) requalifier "trop cher par rapport à quoi ?", (2) recentrer sur valeur/couverture, (3) proposer une alternative moins chère avec transparence sur ce qu'on perd. Souvent le prospect choisit alors la solution médiane qu'il jugeait "chère" au départ.$QK$,
$QK$["Fatal — vous détruisez marge + crédibilité. Le prospect suspectera un prix gonflé au départ.", null, "Trop tôt pour renoncer — 80% des objections prix se traitent par requalification.", "Cheap tactics — le prospect sent la manipulation et refuse."]$QK$::jsonb,
$QK$Erreur = baisser le prix en réflexe → marge Klary érodée + prospect qui croit avoir arraché une remise (donc rechutera à chaque année). Traiter l'objection par la valeur = client fidélisé long terme.$QK$,
TRUE),

('prospection_vente','V015','Objections','single',
$QK$Objection "Je dois RÉFLÉCHIR". Meilleure réponse ?$QK$,
$QK$["OK, au revoir, on se recontacte", "'Bien sûr. Pour vous aider à réfléchir efficacement, qu'est-ce qui vous fait hésiter précisément ? Le prix ? La compagnie ? Un point du contrat ? On peut clarifier maintenant, ça vous évitera de reporter une décision utile.'", "Insister pour signer immédiatement", "Menacer d'augmentation de prix"]$QK$::jsonb,
1,
$QK$"Je dois réfléchir" = rarement vraie réflexion, souvent OBJECTION CACHÉE non-exprimée. La bonne technique : demander CE QUI PRÉCISÉMENT fait hésiter. 70% des cas révèlent une objection concrète (prix, franchise, compagnie…) qu'on peut traiter immédiatement. Sans creuser, le prospect part et ne signe jamais (perte 70-80%).$QK$,
$QK$["Perte assurée — statistiquement, 70-80% de ceux qui 'réfléchissent' ne signent jamais.", null, "Push agressif = casse la confiance, prospect fuit définitivement.", "Manipulation contraire à l'éthique + faute déontologique."]$QK$::jsonb,
$QK$Erreur = laisser partir sans creuser → 3 tentatives de relance ratée → prospect définitivement perdu. Creuser l'objection cachée sur le moment = transformer 40-50% des "je réfléchis" en signature immédiate.$QK$,
TRUE),

('prospection_vente','V016','Objections','single',
$QK$Objection "Je ne veux PAS CHANGER de compagnie, j'y suis depuis 20 ans". Meilleure réponse ?$QK$,
$QK$["Insister sur le fait qu'elle est mauvaise", "'Je respecte totalement cette fidélité. Ma question : votre compagnie s'est-elle adaptée à vos changements de vie sur 20 ans ? Enfants, mariage, achat immobilier ? Un rapide check-up gratuit permet juste de vérifier que vous êtes toujours bien couvert.' — angle audit gratuit, pas changement forcé", "OK on arrête", "Discount immédiat"]$QK$::jsonb,
1,
$QK$Ne JAMAIS attaquer la fidélité (valeur profonde du client). Reformuler la conversation en AUDIT bienveillant : "êtes-vous toujours bien couvert par rapport à VOTRE situation actuelle ?" Sur 20 ans, la vie change (enfants, mariage, immo) mais les contrats souvent pas. 50% des clients fidèles longue durée sont SOUS-ASSURÉS ou SUR-ÉQUIPÉS.$QK$,
$QK$["Faute humaine — vous insultez son choix, il devient hostile.", null, "Défaite prématurée — un audit bienveillant peut vraiment lui rendre service.", "Manque de finesse — pas de sens pour un client stable."]$QK$::jsonb,
$QK$Erreur = accepter la fidélité comme un non. À l'inverse, respecter la fidélité + proposer un audit = 40% acceptent, 20% découvrent une lacune et signent une couverture complémentaire (pas un remplacement).$QK$,
TRUE),

('prospection_vente','V017','Objections','single',
$QK$Un prospect vous dit "J'aime bien votre offre mais je vais comparer avec 2 autres courtiers avant de décider". Réaction pro ?$QK$,
$QK$["Interdire la comparaison", "'C'est totalement légitime. Voulez-vous que je vous liste 3 critères CLÉS qui rendront votre comparaison efficace ? Comme ça, vous comparez sur des critères pertinents et je vous garantis mes conditions pendant 15 jours.' — encadrer la comparaison", "Baisser le prix pour empêcher la comparaison", "Attaquer les concurrents"]$QK$::jsonb,
1,
$QK$Attitude professionnelle transparente. La comparaison est LÉGITIME et fréquente en Suisse. La bonne technique : (1) accepter avec confiance, (2) donner 3 critères objectifs qui vous avantagent (transparence commission, multi-compagnies, service…), (3) verrouiller vos conditions X jours pour éviter que le prospect traîne. Un pro sûr de sa proposition ne craint pas la comparaison.$QK$,
$QK$["Manipulation — un prospect qui sent qu'on l'empêche de comparer prend la fuite.", null, "Perte de marge + doute — pourquoi baissez-vous si c'était le bon prix au départ ?", "Attaque concurrent interdite + fait fuir."]$QK$::jsonb,
$QK$Erreur = tenter d'empêcher la comparaison → le prospect vous fuit. Un pro qui encadre la comparaison avec confiance a un taux de retour de 60-70%.$QK$,
TRUE),

-- ───────── CLOSING ─────────

('prospection_vente','V018','Closing','single',
$QK$Meilleure question de closing après avoir présenté 3 options ?$QK$,
$QK$["Voulez-vous acheter ?", "'Entre la solution Équilibrée et la Premium, laquelle correspond le mieux à votre situation ? On peut signer maintenant si vous êtes prêt·e.' — technique du choix alternatif (pas oui/non)", "Réfléchissez à la maison", "Payez immédiatement"]$QK$::jsonb,
1,
$QK$Technique du CHOIX ALTERNATIF (Alternative Close) : évite la question fermée oui/non qui invite au refus. Force à choisir entre 2 options positives. "Laquelle" est plus efficace que "voulez-vous". Ajouter "on peut signer maintenant si vous êtes prêt·e" donne l'invitation claire sans être forceur.$QK$,
$QK$["Question fermée = 50% de non. Perte massive de closing.", null, "Vous laissez le prospect partir sans engagement = 70% de perte.", "Question intrusive — ne parle même pas de payer, parle de SIGNER."]$QK$::jsonb,
$QK$Erreur = ne pas oser demander le closing. Un pro demande TOUJOURS la signature. Sinon vous êtes juste un conseiller gratuit — c'est le closing qui transforme votre travail en revenu.$QK$,
TRUE),

('prospection_vente','V019','Closing','single',
$QK$Le prospect accepte oralement mais dit "Je signe demain, je repasserai". Bonne réaction ?$QK$,
$QK$["OK à demain", "'Parfait ! Pour bloquer nos conditions et éviter que quelque chose change, on peut signer aujourd'hui — je vous laisse 14 jours de rétractation légale (LCA art. 89). Signer aujourd'hui ne vous engage pas définitivement, mais garantit vos conditions.' — le safety net de la rétractation", "Insister avec agressivité", "Baisser le prix"]$QK$::jsonb,
1,
$QK$Statistique brutale : 30-40% des "je signe demain" ne signent jamais. Vie professionnelle du prospect + doutes + concurrent qui rappelle. Rappeler le droit de RÉTRACTATION LCA 14 jours (article 89) est la meilleure technique : le prospect signe sans risque, et gardera son engagement à 90%. Cette technique DOUBLE le taux de closing.$QK$,
$QK$["Fatal — 30-40% ne reviendront jamais malgré leur bonne foi initiale.", null, "Faute déontologique — brûle la confiance et fait fuir.", "Perte de marge sans raison."]$QK$::jsonb,
$QK$Erreur = laisser filer pour signer demain → 30-40% perte pure. Utiliser le droit de rétractation LCA 14 jours comme filet de sécurité = closing éthique et efficace.$QK$,
TRUE),

('prospection_vente','V020','Closing','single',
$QK$Vous signez un contrat aujourd'hui. Que devez-vous OBLIGATOIREMENT remettre par écrit au client selon la LSA ?$QK$,
$QK$["Rien, l'oral suffit", "Contrat + CGA compagnie + PV de conseil signé Klary + note transparence commission + tableau valeurs rachat sur 30 ans (produits épargne) + rappel droit rétractation 14 jours", "Uniquement le contrat", "Uniquement la note fiscale"]$QK$::jsonb,
1,
$QK$Devoirs documentaires cumulatifs LSA + règlement Klary. Chaque document manquant = manquement légal + risque contentieux ultérieur. Le PV de conseil + note commission sont particulièrement scrutés en cas de litige. Le dossier complet PROTÈGE l'agent en cas de contestation future du client.$QK$,
$QK$["Faute majeure — l'oral n'a AUCUNE valeur juridique en cas de contentieux.", null, "Insuffisant — 4 autres documents obligatoires.", "Incomplet — la partie contractuelle et conseil sont manquantes."]$QK$::jsonb,
$QK$CONSÉQUENCE : audit FINMA ou plainte client 3 ans plus tard → dossier incomplet = culpabilité présumée. Les 6 documents doivent être remis à chaque signature, sans exception.$QK$,
TRUE),

-- ───────── SUIVI + FIDÉLISATION ─────────

('prospection_vente','V021','Suivi','single',
$QK$Combien de fois relancer un prospect qui n'a pas donné suite après un RDV positif ?$QK$,
$QK$["Une seule fois puis abandon", "3-5 relances espacées (J+3, J+10, J+30, J+90, J+180) avec des angles différents (rappel offre, actualité, nouvelle année, changement fiscal…) puis clôture propre du dossier", "20 appels par semaine", "Aucune relance, laisser venir"]$QK$::jsonb,
1,
$QK$Statistiques marketing : 80% des ventes se font entre le 5e et 12e contact. Une seule relance = 90% perte. Trop de relances = harcèlement + LCD art. 3. Le sweet spot = 3-5 relances espacées avec des angles VARIÉS (pas répétition mécanique). Après, clôture propre et retour en pipeline froid à recontacter dans 12 mois.$QK$,
$QK$["Sous-utilisation massive — 80% des ventes se perdent au 1er non-retour.", null, "Harcèlement illégal (LCD art. 3) + destruction de la relation.", "Attitude passive — 95% de non-conversion."]$QK$::jsonb,
$QK$Erreur = ne pas relancer → 80% du pipeline perdu. Un CRM discipliné avec relances programmées = clé du chiffre d'affaires long terme.$QK$,
TRUE),

('prospection_vente','V022','Fidélisation','single',
$QK$Rendez-vous BILAN annuel avec un client existant : quelle est la vraie valeur pour Klary ?$QK$,
$QK$["Aucune, le contrat tourne tout seul", "1) Fidélisation (client vu = client resigné), 2) Détection nouveaux besoins (mariage, enfant, immo, retraite proche…) → upsell naturel, 3) Génération de recommandations (le client satisfait recommande), 4) Anticipation problèmes (couverture inadaptée à sa nouvelle situation)", "Uniquement rassurer", "Perte de temps"]$QK$::jsonb,
1,
$QK$Le RDV bilan annuel est LE moment stratégique du courtier long terme. Un client vu 1x/an a un taux de résiliation 5x inférieur. Sur les 4 leviers, l'upsell naturel + les recommandations représentent 30-40% du CA récurrent de l'agent. Ne pas faire de RDV annuel = attrition annuelle 15-25% + zéro upsell.$QK$,
$QK$["Attitude fatale — perte massive de portefeuille.", null, "Sous-utilisation — 3 autres leviers stratégiques ignorés.", "Fausse conception — le RDV annuel est le meilleur ROI temps du courtier."]$QK$::jsonb,
$QK$Erreur = ne pas revoir ses clients → attrition + concurrence qui les récupère + zéro recommandations. Un agent avec discipline RDV annuel a un portefeuille qui DOUBLE en 3-4 ans par capitalisation.$QK$,
TRUE),

('prospection_vente','V023','Recommandations','single',
$QK$Meilleur moment pour demander une recommandation à un client ?$QK$,
$QK$["Jamais, c'est gênant", "Au moment PIC de satisfaction : juste après une signature réussie, un remboursement rapide, un service exceptionnel. Question : 'Vous êtes satisfait ? Connaissez-vous 2 ou 3 personnes qui gagneraient à avoir la même qualité de conseil ?'", "Uniquement à Noël", "Uniquement quand il se plaint"]$QK$::jsonb,
1,
$QK$Timing psychologique = pic émotionnel POSITIF. Un client qui vient de vivre quelque chose de bien (signature, remboursement, résolution) est le plus enclin à recommander. La question doit être SPÉCIFIQUE ("2 ou 3 personnes") plutôt que vague ("des amis"). Concret = 3x plus efficace.$QK$,
$QK$["Manque à gagner massif — 50-70% des clients sont prêts à recommander mais on ne leur demande jamais.", null, "Timing raté — vous manquez le pic émotionnel.", "Contre-productif — un client mécontent recommande NÉGATIVEMENT."]$QK$::jsonb,
$QK$Erreur = ne jamais demander → 0 recommandation → dépendance aux leads froids. Systématiser la demande au pic de satisfaction = 30-40% de son business en recommandation en 2-3 ans.$QK$,
TRUE),

-- ───────── ÉTHIQUE KLARY EN SITUATION ─────────

('prospection_vente','V024','Éthique Klary','single',
$QK$Vous pouvez signer un contrat à un client qui vous inspire des doutes sur sa capacité à comprendre l'engagement (âge avancé, confusion visible). Que faites-vous ?$QK$,
$QK$["Je signe rapidement avant qu'il change d'avis", "Je STOPPE la vente. Je propose de reporter le RDV en présence d'un tiers de confiance (enfant, ami…) qui l'aidera à décider en connaissance de cause. La déontologie prime sur la commission.", "Je fais signer sans expliquer", "Je maquille les infos"]$QK$::jsonb,
1,
$QK$Vulnérabilité du client = obligation renforcée du courtier. Signer un contrat à un client qui ne comprend pas = (1) violation devoir de conseil, (2) potentiel abus de faiblesse (art. 157 CP), (3) contrat annulable par la suite avec dommages-intérêts. Un pro STOPPE et fait revenir avec accompagnant. La commission n'a AUCUNE priorité sur la protection du client.$QK$,
$QK$["Faute grave + potentiel PÉNAL (abus de faiblesse art. 157 CP, jusqu'à 5 ans prison).", null, "Manipulation intentionnelle = fraude aggravée.", "Falsification = faux dans les titres art. 251 CP."]$QK$::jsonb,
$QK$CONSÉQUENCE : famille du client découvre → plainte pénale + civil → agent condamné + Klary sanctionnée + interdiction professionnelle. Cas récent VD : 8 mois de sursis + 40k CHF dommages-intérêts pour un agent qui a fait signer un senior confus.$QK$,
TRUE),

('prospection_vente','V025','Éthique Klary','single',
$QK$Un prospect vous demande de "trafiquer" légèrement les infos de son questionnaire santé pour obtenir une meilleure prime. Vous :$QK$,
$QK$["OK, je l'aide un peu", "Je REFUSE catégoriquement. Je lui explique : (1) la déclaration inexacte = nullité rétroactive du contrat en cas de sinistre + refus prestations, (2) fraude assurance = pénal (art. 146 CP escroquerie), (3) ma responsabilité personnelle si je complice", "Je fais un compromis en cachant 1 info", "Je le laisse mentir seul"]$QK$::jsonb,
1,
$QK$Trafic de questionnaire santé = escroquerie à l'assurance (art. 146 CP). L'agent qui aide/laisse faire devient complice. Sanctions cumulées : (1) contrat annulable = client sans couverture au moment critique, (2) pénal jusqu'à 5 ans prison, (3) radiation FINMA de l'agent, (4) Klary perd son mandat compagnie. Refus catégorique + explication claire au client = seule voie propre.$QK$,
$QK$["COMPLICITÉ pénale + civile. Le pire choix possible.", null, "Complicité par dissimulation.", "Complicité par abstention volontaire — l'agent est aussi responsable s'il savait."]$QK$::jsonb,
$QK$CONSÉQUENCE : sinistre survient → compagnie découvre la fraude au questionnaire → refus indemnité + poursuite pénale du client ET de l'agent. Radiation FINMA de l'agent + retrait du mandat Klary. Un cas suffit à finir une carrière.$QK$,
TRUE),

('prospection_vente','V026','Éthique Klary','single',
$QK$Vous êtes en RDV client et vous vous rendez compte à mi-parcours que le produit que vous alliez proposer n'est PAS le plus adapté (une compagnie concurrente ferait mieux dans ce cas précis). Que faites-vous ?$QK$,
$QK$["Je continue avec mon produit initial", "Je REDIRIGE vers la meilleure solution. Je dis honnêtement : 'Après analyse plus poussée, je pense que la Compagnie X serait plus adaptée à votre profil pour telle raison. Voulez-vous que je vous fasse également une comparaison avec elle ?' — devoir de conseil primaire sur la commission", "Je vends le moins bon pour la commission", "Je stop l'entretien"]$QK$::jsonb,
1,
$QK$Devoir de conseil FINMA = recommander la MEILLEURE solution POUR LE CLIENT, indépendamment de la commission. C'est le fondement du courtage multi-compagnies (contrairement à un vendeur mono-compagnie qui est structurellement biaisé). Un agent qui pivote en séance = démontre son professionnalisme, gagne la confiance long terme et fidélise.$QK$,
$QK$["Faute déontologique majeure — biais commercial sanctionnable.", null, "Pire encore — intentionnalité de nuire au client.", "Fuite non professionnelle."]$QK$::jsonb,
$QK$CONSÉQUENCE : client découvre 2 ans plus tard qu'il paie 30% de trop → plainte défaut de conseil → Klary condamnée à indemniser + audit FINMA sur pratiques de placement biaisées. À l'inverse, un agent honnête qui pivote gagne un client à vie + des recommandations.$QK$,
TRUE)

ON CONFLICT DO NOTHING;
