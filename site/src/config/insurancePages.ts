import {
  HeartPulse, Shield, TrendingDown, Users, Stethoscope, Wallet,
  Home, Lock, Sofa, Droplets,
  Scale, FileText, Briefcase, MessageSquare,
  Car, ShieldCheck, Gauge, Wrench,
  PiggyBank, TrendingUp, Calculator, Building,
  Search, Combine, LineChart, Clock,
  Building2, Percent, Banknote, Key,
  type LucideIcon,
} from "lucide-react";
import { ArticleCard } from "@/components/sections/ArticleCards";
import { FAQItem } from "@/components/sections/FAQAccordion";

export interface InsurancePageContent {
  slug: string;
  category: string;
  hero: {
    title: string;
    titleAccent: string;
    subtitle: string;
    image: string;
  };
  intro: {
    eyebrow: string;
    title: string;
    paragraphs: string[];
    keyPoints: { icon: LucideIcon; label: string }[];
  };
  problematics: {
    title: string;
    subtitle: string;
    problems: string[];
  };
  process: {
    title: string;
    subtitle: string;
    steps: { title: string; description: string }[];
  };
  benefits: {
    title: string;
    subtitle: string;
    items: { icon: LucideIcon; title: string; description: string }[];
  };
  articles: ArticleCard[];
  faq: FAQItem[];
  finalCta: {
    title: string;
    subtitle: string;
  };
  formCategory: string;
}

import heroSante from "@/assets/hero-sante.jpg";
import heroRcMenage from "@/assets/hero-rcmenage.jpg";
import heroJuridique from "@/assets/hero-juridique.jpg";
import heroAuto from "@/assets/hero-auto.jpg";
import hero3ePilier from "@/assets/hero-3epilier.jpg";
import heroLpp from "@/assets/hero-lpp.jpg";
import heroHypotheque from "@/assets/hero-hypotheque.jpg";

export const insurancePages: Record<string, InsurancePageContent> = {
  sante: {
    slug: "sante",
    category: "Assurance santé",
    hero: {
      title: "Optimisez votre",
      titleAccent: "assurance santé",
      subtitle:
        "Comparez, ajustez et comprenez votre couverture pour payer le juste prix sans négliger l'essentiel.",
      image: heroSante,
    },
    intro: {
      eyebrow: "L'essentiel à savoir",
      title: "Votre santé mérite une couverture sur mesure.",
      paragraphs: [
        "L'assurance maladie en Suisse repose sur un système à deux étages : la LAMal obligatoire couvre les soins essentiels, et les complémentaires LCA permettent d'aller plus loin (chambre privée, médecines douces, dentaire).",
        "Bien la choisir, c'est trouver l'équilibre entre prime mensuelle, franchise, modèle et garanties — sans payer pour des prestations que vous n'utiliserez jamais.",
      ],
      keyPoints: [
        { icon: Stethoscope, label: "Choix du médecin et des modèles alternatifs (HMO, médecin de famille, Telmed)." },
        { icon: Wallet, label: "Franchise modulable de 300 à 2'500 CHF selon votre profil de santé." },
        { icon: Shield, label: "Complémentaires LCA pour le confort et les prestations spécifiques." },
        { icon: TrendingDown, label: "Possibilité de changement de caisse chaque année avant fin novembre." },
      ],
    },
    problematics: {
      title: "Vous reconnaissez-vous ?",
      subtitle: "Les situations les plus fréquentes que rencontrent nos clients.",
      problems: [
        "Je paie trop cher mais je ne sais pas pourquoi.",
        "Je ne comprends pas la différence entre mes complémentaires.",
        "Ma franchise actuelle n'est plus adaptée à ma situation.",
        "J'aimerais changer de caisse mais je ne sais pas par où commencer.",
        "Mes primes augmentent chaque année sans explication claire.",
        "Je crains de perdre des garanties si je change.",
      ],
    },
    process: {
      title: "Comment Klary vous accompagne",
      subtitle: "Une méthode claire, structurée, et 100 % indépendante.",
      steps: [
        { title: "Analyse de votre situation", description: "Âge, canton, état de santé, fréquence des soins, attentes." },
        { title: "Comparaison des caisses", description: "Mise en concurrence transparente des assureurs présents en Suisse." },
        { title: "Recommandation personnalisée", description: "Modèle, franchise et complémentaires alignés sur votre profil." },
        { title: "Gestion du changement", description: "Lettre de résiliation, dossier d'inscription, contrôle d'admission." },
        { title: "Suivi annuel", description: "Réévaluation chaque automne avant la deadline du 30 novembre." },
      ],
    },
    benefits: {
      title: "Vos bénéfices concrets",
      subtitle: "Une approche pensée pour votre tranquillité financière et médicale.",
      items: [
        { icon: TrendingDown, title: "Économies durables", description: "Jusqu'à 30 % d'économies annuelles sur primes et complémentaires." },
        { icon: Shield, title: "Couverture optimisée", description: "Les bonnes garanties au bon moment — ni trop, ni trop peu." },
        { icon: Users, title: "Conseil indépendant", description: "Aucune affiliation, vraie comparaison multi-assureurs." },
        { icon: HeartPulse, title: "Suivi long terme", description: "Adaptation continue au fil de votre vie (famille, carrière, santé)." },
        { icon: Calculator, title: "Lisibilité totale", description: "Vous comprenez chaque ligne de votre contrat." },
        { icon: Wallet, title: "Optimisation fiscale", description: "Primes maladie déductibles selon canton et situation." },
      ],
    },
    articles: [
      { slug: "choisir-franchise-suisse", category: "Optimisation", title: "Comment choisir sa franchise en Suisse ?", excerpt: "Le bon arbitrage entre prime mensuelle et franchise dépend de votre profil de santé et de votre canton." },
      { slug: "lamal-vs-complementaire", category: "Comprendre", title: "LAMal ou complémentaire : que faut-il regarder ?", excerpt: "Les vrais critères qui font la différence entre une bonne et une mauvaise complémentaire." },
      { slug: "pourquoi-primes-augmentent", category: "Marché", title: "Pourquoi vos primes augmentent-elles ?", excerpt: "Les coulisses des hausses annuelles et comment limiter leur impact." },
      { slug: "economiser-sans-mal-couvert", category: "Conseils", title: "Économiser sans être mal couvert", excerpt: "Les leviers qui font baisser la prime sans sacrifier la qualité des soins." },
    ],
    faq: [
      { question: "Puis-je changer d'assurance maladie chaque année ?", answer: "Oui, vous pouvez résilier votre LAMal au 31 décembre, à condition d'envoyer la lettre avant le 30 novembre par courrier recommandé. Les complémentaires LCA suivent leurs propres conditions contractuelles." },
      { question: "Quelle franchise choisir ?", answer: "En règle générale : 2'500 CHF si vous êtes en bonne santé et utilisez peu le système, 300 à 500 CHF si vous avez des soins réguliers. Notre simulateur calcule le seuil de bascule en fonction de votre canton." },
      { question: "Faut-il garder toutes ses complémentaires ?", answer: "Non. Beaucoup de garanties LCA sont redondantes ou inutiles selon l'âge et la situation. Un audit annuel permet souvent de gagner 500 à 1'500 CHF/an." },
      { question: "Comment comparer correctement les modèles HMO, Telmed, Médecin de famille ?", answer: "Les remises varient de 10 à 25 %, mais imposent un parcours de soins défini. Le choix dépend surtout de votre rapport à votre médecin actuel et de votre proximité avec les cabinets partenaires." },
      { question: "Klary est-il rémunéré par les assureurs ?", answer: "Notre modèle est transparent : nos conseils sont indépendants et nous mettons en concurrence l'ensemble du marché suisse pour défendre votre intérêt." },
    ],
    finalCta: {
      title: "Faites le point sur votre couverture santé.",
      subtitle: "Analyse gratuite, sans engagement, par un conseiller Klary.",
    },
    formCategory: "sante",
  },

  menage: {
    slug: "rc-menage",
    category: "Assurance ménage",
    hero: {
      title: "Protégez votre logement",
      titleAccent: "et vos biens",
      subtitle:
        "Une couverture ménage bien pensée évite de lourdes conséquences financières en cas de sinistre.",
      image: heroRcMenage,
    },
    intro: {
      eyebrow: "L'essentiel à savoir",
      title: "Une protection complète pour votre quotidien.",
      paragraphs: [
        "L'assurance ménage couvre vos biens mobiliers (meubles, appareils, vêtements) contre l'incendie, les dégâts d'eau, le vol et les éléments naturels. La RC privée, généralement combinée, vous protège si vous causez un dommage à autrui.",
        "Bien dimensionnée, elle évite la sous-assurance — une erreur fréquente qui peut coûter très cher en cas de sinistre.",
      ],
      keyPoints: [
        { icon: Home, label: "Couverture du mobilier, électroménager, vêtements et objets personnels." },
        { icon: Lock, label: "Vol simple à domicile et hors domicile (cambriolage, perte)." },
        { icon: Droplets, label: "Dégâts d'eau, incendie, événements naturels couverts en standard." },
        { icon: Sofa, label: "Évaluation précise pour éviter la sous-assurance." },
      ],
    },
    problematics: {
      title: "Les pièges les plus fréquents",
      subtitle: "Ce que nos clients découvrent (souvent trop tard).",
      problems: [
        "Mon contrat date de plusieurs années, je ne sais plus ce qu'il couvre.",
        "Je suis sous-assuré : la valeur réelle de mes biens dépasse le plafond.",
        "Ma RC privée est insuffisante pour couvrir un dommage important.",
        "Je ne comprends pas les exclusions de mon contrat.",
        "J'ai eu un sinistre et l'indemnisation est très inférieure à mes attentes.",
        "J'ai déménagé sans mettre à jour mon assurance.",
      ],
    },
    process: {
      title: "Comment Klary vous accompagne",
      subtitle: "De l'audit jusqu'à la mise en place, sans paperasse.",
      steps: [
        { title: "Audit du contrat existant", description: "Décryptage des garanties, plafonds et franchises." },
        { title: "Évaluation des biens", description: "Estimation réaliste de la valeur de remplacement." },
        { title: "Mise en concurrence", description: "Comparaison multi-assureurs sur le marché suisse." },
        { title: "Optimisation de la RC", description: "Plafond, défense pénale, dommages aux locataires." },
        { title: "Mise en place et résiliation", description: "Nous gérons les démarches administratives à votre place." },
      ],
    },
    benefits: {
      title: "Vos bénéfices concrets",
      subtitle: "Sérénité, lisibilité et juste prix.",
      items: [
        { icon: ShieldCheck, title: "Couverture juste", description: "Adaptée à la valeur réelle de vos biens, sans sous-assurance." },
        { icon: TrendingDown, title: "Prime optimisée", description: "Souvent 15 à 30 % d'économies par rapport à un contrat ancien." },
        { icon: Lock, title: "RC robuste", description: "Plafonds adaptés (de 5 à 10 millions CHF selon profil)." },
        { icon: FileText, title: "Lisibilité totale", description: "Vous savez exactement ce qui est couvert et ce qui ne l'est pas." },
        { icon: Users, title: "Conseil personnalisé", description: "Adaptation à votre type de logement et composition familiale." },
        { icon: Clock, title: "Suivi régulier", description: "Mise à jour à chaque déménagement ou changement de situation." },
      ],
    },
    articles: [
      { slug: "que-couvre-assurance-menage", category: "Comprendre", title: "Que couvre réellement une assurance ménage ?", excerpt: "Le détail des garanties standard, des options et des exclusions courantes." },
      { slug: "rc-privee-indispensable", category: "RC privée", title: "RC privée : pourquoi est-ce indispensable ?", excerpt: "Comment une RC bien dimensionnée peut éviter une catastrophe financière." },
      { slug: "eviter-sous-assurance", category: "Optimisation", title: "Comment éviter la sous-assurance ?", excerpt: "La méthode pour évaluer correctement la valeur de votre mobilier." },
      { slug: "que-faire-degat-eau", category: "Sinistres", title: "Que faire en cas de dégât d'eau ou de vol ?", excerpt: "Les étapes à suivre pour être indemnisé rapidement et sans stress." },
    ],
    faq: [
      { question: "L'assurance ménage est-elle obligatoire ?", answer: "Non, elle n'est pas obligatoire en Suisse, mais elle est très fortement recommandée. Certains bailleurs l'exigent contractuellement." },
      { question: "Quelle différence entre ménage et RC privée ?", answer: "Le ménage couvre vos biens. La RC privée couvre les dommages que vous causez aux autres (personnes ou biens). Les deux sont généralement combinées dans un même contrat." },
      { question: "Comment évaluer correctement la valeur de mes biens ?", answer: "Il faut estimer la valeur de remplacement à neuf de l'ensemble du mobilier, électroménager, vêtements et effets personnels. Notre conseiller utilise des grilles de référence par type de logement." },
      { question: "Que couvre un sinistre domestique ?", answer: "Selon le contrat : incendie, dégâts d'eau, vol, événements naturels, bris de glaces. Les exclusions classiques : usure, défaut d'entretien, négligence grave." },
    ],
    finalCta: {
      title: "Sécurisez votre foyer en quelques minutes.",
      subtitle: "Un audit ménage gratuit pour savoir exactement où vous en êtes.",
    },
    formCategory: "menage",
  },

  juridique: {
    slug: "protection-juridique",
    category: "Protection juridique",
    hero: {
      title: "Défendez vos droits",
      titleAccent: "en toute sérénité",
      subtitle:
        "Litiges du quotidien, conflits privés, circulation, travail ou consommation : bénéficiez d'un cadre plus serein.",
      image: heroJuridique,
    },
    intro: {
      eyebrow: "L'essentiel à savoir",
      title: "Un avocat à vos côtés, sans coût imprévu.",
      paragraphs: [
        "La protection juridique prend en charge les frais d'avocat, d'expertise et de procédure dans le cadre de litiges couverts. En Suisse, les coûts juridiques peuvent rapidement atteindre plusieurs milliers de francs — même pour un simple conflit avec un voisin ou un employeur.",
        "Bien choisie, elle vous donne accès à un soutien juridique immédiat et évite que la peur des frais ne vous empêche de défendre vos droits.",
      ],
      keyPoints: [
        { icon: Scale, label: "Prise en charge des frais d'avocat, d'huissier et d'expertise." },
        { icon: Briefcase, label: "Couverture privée, circulation, travail, immobilier ou consommation." },
        { icon: MessageSquare, label: "Hotline juridique pour conseils rapides au quotidien." },
        { icon: FileText, label: "Plafonds de couverture de 250'000 à 1'000'000 CHF selon contrat." },
      ],
    },
    problematics: {
      title: "Les situations qui tournent mal",
      subtitle: "Souvent évitables avec la bonne couverture en amont.",
      problems: [
        "Mon employeur ne respecte pas mon contrat, je ne sais pas quoi faire.",
        "Mon bailleur refuse de me rendre la garantie de loyer.",
        "J'ai un litige avec un commerçant pour une livraison défectueuse.",
        "J'ai eu un accident, mon assurance auto adverse conteste sa responsabilité.",
        "Mon voisin fait du bruit, j'aimerais agir mais sans frais excessifs.",
        "J'ai besoin d'un avis juridique rapide mais je ne connais pas d'avocat.",
      ],
    },
    process: {
      title: "Comment Klary vous accompagne",
      subtitle: "Du choix du contrat à l'activation en cas de besoin.",
      steps: [
        { title: "Analyse des risques", description: "Profession, foyer, véhicule, mode de vie." },
        { title: "Choix de la couverture", description: "Privée seule, circulation seule, ou combinée." },
        { title: "Comparaison du marché", description: "Plafonds, exclusions, qualité du service juridique." },
        { title: "Mise en place", description: "Souscription rapide, conditions claires." },
        { title: "Activation en cas de litige", description: "Nous vous orientons vers les bons interlocuteurs." },
      ],
    },
    benefits: {
      title: "Vos bénéfices concrets",
      subtitle: "L'accès au droit, sans la peur du coût.",
      items: [
        { icon: Scale, title: "Frais juridiques pris en charge", description: "Avocat, expertise, huissier, procédure : tout est couvert dans la limite du plafond." },
        { icon: MessageSquare, title: "Conseil immédiat", description: "Hotline juridique pour des questions rapides du quotidien." },
        { icon: Briefcase, title: "Couverture pro et privée", description: "Litiges du travail, locatifs, consommation, voisinage." },
        { icon: ShieldCheck, title: "Sérénité retrouvée", description: "Vous pouvez agir sans calculer chaque heure d'avocat." },
        { icon: Users, title: "Famille protégée", description: "Conjoint et enfants généralement inclus dans le contrat." },
        { icon: Clock, title: "Réactivité", description: "Prise en charge rapide dès la déclaration du litige." },
      ],
    },
    articles: [
      { slug: "que-couvre-protection-juridique", category: "Comprendre", title: "Que couvre une protection juridique ?", excerpt: "Domaines couverts, exclusions classiques et limites de prise en charge." },
      { slug: "quand-utile-protection-juridique", category: "Cas d'usage", title: "Dans quels cas est-elle vraiment utile ?", excerpt: "Les exemples concrets où la protection juridique change tout." },
      { slug: "privee-vs-circulation", category: "Comparatif", title: "Privée ou circulation : laquelle choisir ?", excerpt: "Le bon arbitrage selon votre profil et vos risques quotidiens." },
      { slug: "que-faire-conflit-contractuel", category: "Démarches", title: "Que faire lors d'un conflit contractuel ?", excerpt: "Le guide étape par étape pour réagir efficacement." },
    ],
    faq: [
      { question: "Est-ce que la protection juridique prend en charge les avocats ?", answer: "Oui, elle couvre les honoraires d'avocat, les frais d'expertise et de procédure, dans la limite du plafond de couverture défini au contrat." },
      { question: "Tous les litiges sont-ils couverts ?", answer: "Non. Les divorces, litiges fiscaux et droit pénal grave sont généralement exclus. Le détail dépend du contrat — nous vous le clarifions point par point." },
      { question: "Faut-il une couverture privée et circulation ?", answer: "Si vous conduisez régulièrement, la combinaison est presque toujours plus avantageuse. Pour un piéton ou cycliste, la couverture privée seule peut suffire." },
      { question: "Y a-t-il des délais d'attente ?", answer: "Oui, généralement 3 mois pour la plupart des litiges (sauf circulation, immédiat). Les litiges déjà existants au moment de la souscription ne sont pas couverts." },
    ],
    finalCta: {
      title: "Avancez sereinement, quoi qu'il arrive.",
      subtitle: "Trouvons la protection juridique qui correspond vraiment à votre situation.",
    },
    formCategory: "juridique",
  },

  auto: {
    slug: "auto",
    category: "Assurance auto",
    hero: {
      title: "Assurez votre véhicule",
      titleAccent: "vraiment intelligemment",
      subtitle:
        "RC, casco partielle ou complète : trouvez une solution cohérente avec votre véhicule et votre budget.",
      image: heroAuto,
    },
    intro: {
      eyebrow: "L'essentiel à savoir",
      title: "Une assurance auto qui colle à votre véhicule.",
      paragraphs: [
        "L'assurance véhicule en Suisse repose sur trois niveaux : la RC obligatoire (dommages causés à autrui), la casco partielle (vol, incendie, bris de glace, animaux, éléments naturels) et la casco complète (tous risques, y compris vos propres dommages).",
        "Le bon arbitrage dépend de l'âge du véhicule, de sa valeur, de votre kilométrage et de votre profil de conducteur.",
      ],
      keyPoints: [
        { icon: Car, label: "RC obligatoire pour circuler en Suisse." },
        { icon: ShieldCheck, label: "Casco partielle ou complète selon valeur et âge du véhicule." },
        { icon: Gauge, label: "Bonus/malus calculé sur votre historique de sinistres." },
        { icon: Wrench, label: "Options utiles : assistance dépannage, véhicule de remplacement." },
      ],
    },
    problematics: {
      title: "Les erreurs les plus fréquentes",
      subtitle: "Ce qui fait payer trop cher (ou pas assez).",
      problems: [
        "Je paie une casco complète sur un véhicule de plus de 8 ans.",
        "Ma RC est trop basse pour mon profil et mon véhicule.",
        "Je ne comprends pas la différence entre casco partielle et complète.",
        "Mes franchises sont mal calibrées pour mon usage.",
        "J'ai changé de véhicule sans réviser mon contrat.",
        "Je n'utilise pas d'options pourtant comprises dans le prix.",
      ],
    },
    process: {
      title: "Comment Klary vous accompagne",
      subtitle: "Une approche transparente, sans compromis sur les garanties.",
      steps: [
        { title: "Profil & véhicule", description: "Type, valeur, âge, kilométrage, conducteur principal." },
        { title: "Analyse des risques", description: "Stationnement, fréquence, usage privé ou pro." },
        { title: "Comparaison du marché", description: "Mise en concurrence des assureurs auto en Suisse." },
        { title: "Recommandation", description: "Niveau de couverture optimal, franchises ajustées." },
        { title: "Mise en place", description: "Résiliation de l'ancien contrat et souscription du nouveau." },
      ],
    },
    benefits: {
      title: "Vos bénéfices concrets",
      subtitle: "Le bon contrat au bon prix.",
      items: [
        { icon: TrendingDown, title: "Prime juste", description: "Souvent 20 à 35 % d'économies sur un contrat non revu depuis longtemps." },
        { icon: ShieldCheck, title: "Couverture cohérente", description: "Pas de casco inutile sur véhicule âgé, ni de RC trop basse." },
        { icon: Gauge, title: "Franchises optimisées", description: "Équilibre entre prime mensuelle et reste à charge en cas de sinistre." },
        { icon: Wrench, title: "Options utiles seulement", description: "On retire ce qui ne vous sert pas, on ajoute ce qui vous protège." },
        { icon: Users, title: "Conseil indépendant", description: "Aucun lien avec un assureur — votre intérêt prime." },
        { icon: Clock, title: "Suivi à chaque changement", description: "Nouveau véhicule, déménagement, jeune conducteur." },
      ],
    },
    articles: [
      { slug: "rc-casco-differences", category: "Comprendre", title: "RC, casco partielle, casco complète : quelles différences ?", excerpt: "Le guide pour comprendre les trois niveaux de couverture auto en Suisse." },
      { slug: "payer-moins-cher-auto", category: "Optimisation", title: "Comment payer moins cher son assurance auto ?", excerpt: "Les leviers concrets : franchise, kilométrage, modèle, garage." },
      { slug: "couverture-voiture-recente", category: "Conseils", title: "Quelle couverture pour une voiture récente ?", excerpt: "Le bon niveau de protection en fonction de la valeur résiduelle." },
      { slug: "que-faire-apres-accident", category: "Sinistres", title: "Que faire après un accident ?", excerpt: "Les bons réflexes pour être indemnisé rapidement et correctement." },
    ],
    faq: [
      { question: "L'assurance voiture est-elle obligatoire ?", answer: "Oui, la RC (responsabilité civile) est obligatoire pour circuler en Suisse. Les casco sont facultatives mais souvent indispensables pour un véhicule récent ou financé." },
      { question: "Quelle différence entre RC et casco ?", answer: "La RC couvre les dommages que vous causez aux autres. La casco couvre les dommages à votre propre véhicule (partielle pour vol/feu/bris, complète pour tous risques)." },
      { question: "Comment choisir sa franchise auto ?", answer: "Plus la franchise est élevée, moins la prime est chère. Le bon arbitrage dépend de votre capacité à absorber un reste à charge en cas de sinistre. Standard : 500 à 1'000 CHF." },
      { question: "Puis-je changer facilement d'assureur ?", answer: "Oui, à l'échéance annuelle (avec un préavis de 3 mois généralement) ou en cas de sinistre / hausse de prime. Nous gérons les démarches pour vous." },
    ],
    finalCta: {
      title: "Roulez avec la bonne couverture.",
      subtitle: "Comparons votre contrat actuel avec les meilleures offres du marché.",
    },
    formCategory: "auto",
  },

  "3e-pilier": {
    slug: "3e-pilier",
    category: "Troisième pilier",
    hero: {
      title: "Construisez votre",
      titleAccent: "avenir financier",
      subtitle:
        "Préparez votre retraite, optimisez votre fiscalité et protégez vos proches avec un 3e pilier sur mesure.",
      image: hero3ePilier,
    },
    intro: {
      eyebrow: "L'essentiel à savoir",
      title: "Un pilier qui combine épargne, fiscalité et protection.",
      paragraphs: [
        "Le 3e pilier est la prévoyance privée facultative. Il complète l'AVS (1er pilier) et la LPP (2e pilier) pour maintenir votre niveau de vie à la retraite. Il existe en deux formes : le 3a (lié, déductible fiscalement) et le 3b (libre).",
        "En 2025, vous pouvez verser jusqu'à 7'258 CHF par an au 3a (salarié) et déduire ce montant intégralement de votre revenu imposable.",
      ],
      keyPoints: [
        { icon: PiggyBank, label: "Plafond 2025 : 7'258 CHF/an pour les salariés, 36'288 CHF pour les indépendants." },
        { icon: Calculator, label: "Déduction fiscale intégrale du revenu imposable." },
        { icon: Building, label: "Retrait possible pour acheter sa résidence principale." },
        { icon: TrendingUp, label: "Choix entre 3a bancaire (sécurité) ou assurance (épargne + protection décès)." },
      ],
    },
    problematics: {
      title: "Les erreurs qui coûtent cher",
      subtitle: "À éviter pour ne pas perdre des milliers de francs sur le long terme.",
      problems: [
        "Je n'ai pas de 3e pilier, je perds chaque année des avantages fiscaux.",
        "J'ai un 3a bancaire mais aucun rendement.",
        "J'ai souscrit un 3a assurance trop tôt, sans comprendre les frais.",
        "Je ne sais pas si je dois ouvrir plusieurs 3a pour étaler le retrait.",
        "Je veux acheter un bien et je ne sais pas quoi faire de mon 3e pilier.",
        "Mon 3e pilier ne protège pas ma famille en cas de décès ou d'invalidité.",
      ],
    },
    process: {
      title: "Comment Klary vous accompagne",
      subtitle: "Une stratégie cohérente avec votre projet de vie.",
      steps: [
        { title: "Bilan global", description: "Revenu, fiscalité, projets, situation familiale, capacité d'épargne." },
        { title: "Stratégie 3a + 3b", description: "Combinaison optimale entre lié et libre selon objectifs." },
        { title: "Choix de la solution", description: "Bancaire, assurance, ou mixte — avec ou sans protection risque." },
        { title: "Mise en place", description: "Ouverture du compte ou souscription, automatisation des versements." },
        { title: "Suivi annuel", description: "Optimisation fiscale, ajustement des versements, planification du retrait." },
      ],
    },
    benefits: {
      title: "Vos bénéfices concrets",
      subtitle: "Bien plus qu'une simple épargne.",
      items: [
        { icon: Calculator, title: "Économie d'impôts", description: "Jusqu'à 2'500 CHF/an d'économie selon canton et tranche fiscale." },
        { icon: TrendingUp, title: "Capital à long terme", description: "Effet boule de neige sur 20 à 30 ans." },
        { icon: Building, title: "Levier immobilier", description: "Utilisable comme fonds propres pour l'achat de votre logement." },
        { icon: Shield, title: "Protection famille", description: "Couverture décès et invalidité incluse en formule assurance." },
        { icon: PiggyBank, title: "Liberté d'usage", description: "Versements modulables selon votre capacité chaque année." },
        { icon: Users, title: "Stratégie sur mesure", description: "Adaptée à votre âge, vos revenus et vos projets." },
      ],
    },
    articles: [
      { slug: "pourquoi-ouvrir-3e-pilier", category: "Comprendre", title: "Pourquoi ouvrir un troisième pilier ?", excerpt: "Les 4 raisons principales (fiscalité, retraite, immobilier, protection)." },
      { slug: "combien-verser-3a", category: "Optimisation", title: "Combien verser chaque année ?", excerpt: "Le bon montant selon votre revenu, votre âge et vos objectifs." },
      { slug: "3a-bancaire-vs-assurance", category: "Comparatif", title: "3a bancaire ou assurance : que choisir ?", excerpt: "Les avantages et limites de chaque formule, sans jargon." },
      { slug: "utiliser-3e-pilier-immobilier", category: "Immobilier", title: "Utiliser le 3e pilier pour son achat immobilier", excerpt: "Le mécanisme du retrait anticipé et son impact sur la prévoyance." },
    ],
    faq: [
      { question: "Le 3e pilier est-il vraiment utile ?", answer: "Oui, pour deux raisons majeures : compenser la baisse de revenu à la retraite (rente AVS+LPP couvre rarement plus de 60 % du dernier salaire) et bénéficier d'une déduction fiscale immédiate." },
      { question: "Combien puis-je verser ?", answer: "En 2025 : 7'258 CHF/an si vous êtes salarié affilié à une caisse de pension, et jusqu'à 36'288 CHF si vous êtes indépendant sans LPP (max 20 % du revenu net)." },
      { question: "Peut-on retirer son 3e pilier ?", answer: "Oui, dans plusieurs cas : retraite (5 ans avant l'âge légal au plus tôt), achat de résidence principale, départ définitif de Suisse, lancement d'une activité indépendante, invalidité." },
      { question: "Est-ce intéressant fiscalement ?", answer: "Très : chaque franc versé est déduit du revenu imposable. Selon canton et tranche, l'économie d'impôt représente 25 à 40 % du versement." },
    ],
    finalCta: {
      title: "Optimisez votre prévoyance dès aujourd'hui.",
      subtitle: "Une stratégie 3e pilier sur mesure, calculée pour vos vrais objectifs.",
    },
    formCategory: "3e-pilier",
  },

  lpp: {
    slug: "lpp",
    category: "Avoirs LPP & Libre passage",
    hero: {
      title: "Retrouvez et optimisez",
      titleAccent: "vos avoirs LPP",
      subtitle:
        "Après plusieurs employeurs, il est fréquent de perdre la trace d'anciens avoirs. Klary vous aide à les retrouver et restructurer.",
      image: heroLpp,
    },
    intro: {
      eyebrow: "L'essentiel à savoir",
      title: "Vos avoirs de prévoyance, centralisés et optimisés.",
      paragraphs: [
        "À chaque changement d'employeur en Suisse, vos avoirs LPP doivent être transférés à la nouvelle caisse de pension. À défaut, ils sont placés sur un compte de libre passage. Beaucoup d'actifs ont ainsi des comptes oubliés ou dispersés.",
        "Regrouper et optimiser ces avoirs permet souvent de gagner en rendement, en lisibilité, et de mieux préparer la retraite.",
      ],
      keyPoints: [
        { icon: Search, label: "Recherche d'avoirs oubliés via la Centrale du 2e pilier (gratuit)." },
        { icon: Combine, label: "Regroupement possible sur un ou plusieurs comptes de libre passage." },
        { icon: LineChart, label: "Choix d'une solution avec investissement en fonds (rendement potentiel supérieur)." },
        { icon: Clock, label: "Échelonnement des retraits pour optimiser la fiscalité au moment du retrait." },
      ],
    },
    problematics: {
      title: "Les pièges du libre passage",
      subtitle: "Ce que beaucoup d'actifs ignorent jusqu'au moment de la retraite.",
      problems: [
        "Je ne sais pas si j'ai des avoirs LPP oubliés.",
        "Mes anciens employeurs ne m'ont jamais transféré mes fonds.",
        "Mes comptes de libre passage rapportent presque rien.",
        "J'ai plusieurs comptes éparpillés, c'est illisible.",
        "Je ne sais pas comment optimiser le retrait à la retraite.",
        "Je veux acheter un logement avec mon 2e pilier mais j'ignore les règles.",
      ],
    },
    process: {
      title: "Comment Klary vous accompagne",
      subtitle: "Une démarche claire, du diagnostic à la stratégie long terme.",
      steps: [
        { title: "Recherche d'avoirs", description: "Identification de tous vos comptes existants en Suisse." },
        { title: "Bilan complet", description: "Vue consolidée de votre 2e pilier et libre passage." },
        { title: "Stratégie de regroupement", description: "Centralisation ou répartition selon objectifs fiscaux." },
        { title: "Choix d'investissement", description: "Solutions sécurisées ou en fonds, selon profil de risque." },
        { title: "Préparation du retrait", description: "Planification fiscale optimisée à l'horizon retraite." },
      ],
    },
    benefits: {
      title: "Vos bénéfices concrets",
      subtitle: "Plus de visibilité, plus de rendement, plus de sérénité.",
      items: [
        { icon: Search, title: "Avoirs retrouvés", description: "Identification systématique des comptes oubliés." },
        { icon: Combine, title: "Centralisation", description: "Une vision unique de votre prévoyance." },
        { icon: LineChart, title: "Meilleur rendement", description: "Solutions investies pour battre l'inflation sur le long terme." },
        { icon: Calculator, title: "Optimisation fiscale", description: "Échelonnement intelligent du retrait pour réduire l'impôt." },
        { icon: Building, title: "Levier immobilier", description: "Utilisation possible pour l'achat de la résidence principale." },
        { icon: Users, title: "Conseil indépendant", description: "Aucun lien avec une fondation — votre intérêt prime." },
      ],
    },
    articles: [
      { slug: "retrouver-anciens-avoirs-lpp", category: "Démarches", title: "Comment retrouver ses anciens avoirs LPP ?", excerpt: "Le guide pour utiliser la Centrale du 2e pilier et identifier tous vos comptes." },
      { slug: "lpp-changement-employeur", category: "Comprendre", title: "Que devient mon LPP après un changement d'employeur ?", excerpt: "Les règles de transfert et les pièges à éviter." },
      { slug: "regrouper-avoirs-libre-passage", category: "Optimisation", title: "Pourquoi regrouper ses avoirs de libre passage ?", excerpt: "Les vrais bénéfices et les rares cas où il vaut mieux les séparer." },
      { slug: "preparer-retraite-lpp", category: "Retraite", title: "Mieux préparer sa retraite avec ses fonds LPP", excerpt: "Stratégies de placement et planification du retrait." },
    ],
    faq: [
      { question: "Puis-je avoir plusieurs comptes de libre passage ?", answer: "Oui, vous pouvez en avoir jusqu'à deux en Suisse. C'est même conseillé pour échelonner les retraits sur deux années fiscales et réduire l'impôt." },
      { question: "Comment retrouver un avoir oublié ?", answer: "Via la Centrale du 2e pilier à Berne, qui centralise tous les comptes ayant perdu contact avec leur titulaire. La recherche est gratuite et nous nous en chargeons." },
      { question: "Est-ce utile de regrouper ses fonds ?", answer: "Oui, dans la majorité des cas : meilleure lisibilité, rendement souvent supérieur, gestion simplifiée. Sauf si vous voulez échelonner les retraits sur deux ans pour optimiser l'impôt." },
      { question: "Puis-je optimiser le rendement de mes avoirs ?", answer: "Oui : en passant d'une solution standard (taux faible) à une solution investie en fonds, vous pouvez viser un rendement net supérieur sur le long terme — avec une volatilité maîtrisée." },
    ],
    finalCta: {
      title: "Reprenez la main sur votre 2e pilier.",
      subtitle: "Bilan gratuit de vos avoirs LPP et plan d'action personnalisé.",
    },
    formCategory: "lpp",
  },

  hypotheque: {
    slug: "hypotheque",
    category: "Hypothèque",
    hero: {
      title: "Financez votre projet",
      titleAccent: "intelligemment",
      subtitle:
        "Acheter un bien ne se résume pas à un taux. Structurez correctement votre financement, maîtrisez la charge mensuelle et sécurisez votre projet.",
      image: heroHypotheque,
    },
    intro: {
      eyebrow: "L'essentiel à savoir",
      title: "Une hypothèque, ce n'est pas qu'un taux d'intérêt.",
      paragraphs: [
        "En Suisse, l'achat immobilier suppose au minimum 20 % de fonds propres (dont 10 % en cash hors LPP), une charge théorique inférieure à 33 % du revenu, et un amortissement direct ou indirect du second rang.",
        "Bien structurer son financement, c'est arbitrer entre taux fixe et SARON, choisir la durée, optimiser l'amortissement via le 3e pilier, et anticiper les renouvellements.",
      ],
      keyPoints: [
        { icon: Building2, label: "Minimum 20 % de fonds propres requis (dont 10 % en cash hors LPP)." },
        { icon: Percent, label: "Choix entre taux fixe (sécurité) et SARON (variable, souvent moins cher)." },
        { icon: Banknote, label: "Charge théorique : maximum 33 % du revenu brut annuel." },
        { icon: Key, label: "Amortissement obligatoire du 2e rang en 15 ans ou jusqu'à 65 ans." },
      ],
    },
    problematics: {
      title: "Les sujets qui font peur (à raison)",
      subtitle: "Et qui méritent un vrai accompagnement.",
      problems: [
        "Je ne sais pas combien je peux emprunter avec mon revenu.",
        "Je ne comprends pas la différence entre taux fixe et SARON.",
        "Mon banquier ne me propose qu'une seule solution.",
        "Je veux utiliser mon 3e pilier mais je crains l'impact fiscal.",
        "Je dois renouveler mon hypothèque, par où commencer ?",
        "Je veux comparer plusieurs banques mais c'est très chronophage.",
      ],
    },
    process: {
      title: "Comment Klary vous accompagne",
      subtitle: "Du calcul de capacité à la signature, sans stress.",
      steps: [
        { title: "Capacité financière", description: "Calcul précis de votre faisabilité (fonds propres, revenu, charge théorique)." },
        { title: "Stratégie de financement", description: "Mix taux fixe / SARON, durée, amortissement direct ou indirect." },
        { title: "Mise en concurrence", description: "Banques, assurances, caisses de pension — toutes les sources de financement." },
        { title: "Négociation", description: "Obtention des meilleures conditions du marché grâce au volume." },
        { title: "Suivi long terme", description: "Anticipation des renouvellements pour ne jamais subir un mauvais taux." },
      ],
    },
    benefits: {
      title: "Vos bénéfices concrets",
      subtitle: "Une économie qui se chiffre en dizaines de milliers de francs sur la durée.",
      items: [
        { icon: Percent, title: "Meilleurs taux", description: "Mise en concurrence d'au moins 8 partenaires bancaires." },
        { icon: Banknote, title: "Charge mensuelle maîtrisée", description: "Structuration adaptée à votre budget et votre profil." },
        { icon: Calculator, title: "Optimisation fiscale", description: "Amortissement indirect via 3e pilier pour réduire l'impôt." },
        { icon: Building2, title: "Stratégie long terme", description: "Planification des renouvellements à l'horizon 5-10 ans." },
        { icon: Users, title: "Conseil indépendant", description: "Aucun lien avec une banque — votre intérêt prime." },
        { icon: Key, title: "Accompagnement complet", description: "Du dossier à la signature, on gère tout pour vous." },
      ],
    },
    articles: [
      { slug: "comment-fonctionne-hypotheque-suisse", category: "Comprendre", title: "Comment fonctionne une hypothèque en Suisse ?", excerpt: "Premier rang, second rang, amortissement, charge théorique : le décryptage complet." },
      { slug: "taux-fixe-vs-saron", category: "Comparatif", title: "Taux fixe ou SARON : que choisir ?", excerpt: "Avantages, inconvénients et profils types pour chaque option." },
      { slug: "fonds-propres-suisse", category: "Apport", title: "Combien de fonds propres faut-il ?", excerpt: "Le minimum légal, les sources possibles (LPP, 3a, donation) et les arbitrages." },
      { slug: "optimiser-financement-immobilier", category: "Optimisation", title: "Comment optimiser son financement immobilier ?", excerpt: "Les leviers concrets : amortissement, fiscalité, durée, renouvellement." },
    ],
    faq: [
      { question: "Combien puis-je emprunter ?", answer: "En général, jusqu'à 80 % du prix du bien (1er + 2e rang). Votre charge théorique (intérêts à 5 % + amortissement + entretien à 1 %) ne doit pas dépasser 33 % de votre revenu brut annuel." },
      { question: "Quelle différence entre taux fixe et SARON ?", answer: "Le taux fixe est garanti pour la durée du contrat (5, 10 ou 15 ans typiquement). Le SARON est variable, indexé sur le marché monétaire — souvent moins cher mais sans visibilité long terme." },
      { question: "Faut-il amortir directement ou indirectement ?", answer: "L'amortissement indirect via 3e pilier est généralement plus avantageux fiscalement (déduction des intérêts maintenue + déduction des versements 3a). Nous calculons l'option optimale pour votre situation." },
      { question: "Comment préparer son dossier hypothécaire ?", answer: "Il faut rassembler : fiches de salaire, dernière taxation fiscale, état des fortunes, justificatifs de fonds propres, certificat LPP. Nous vous fournissons une checklist complète." },
    ],
    finalCta: {
      title: "Donnez vie à votre projet immobilier.",
      subtitle: "Une stratégie hypothécaire personnalisée, négociée auprès de plusieurs partenaires bancaires.",
    },
    formCategory: "hypotheque",
  },
};
