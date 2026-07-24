import { Link } from "react-router-dom";
import {
  ArrowRight, ArrowUpRight, Shield, PiggyBank, Home, Headphones,
  MapPin, Briefcase, CheckCircle2,
} from "lucide-react";
import { HeaderV2 } from "@/components/v2/HeaderV2";
import { FooterV2 } from "@/components/v2/FooterV2";
import { ScrollProgress } from "@/components/v2/ScrollProgress";
import { PageHeroV2 } from "@/components/v2/PageHeroV2";
import { PageSectionV2 } from "@/components/v2/PageSectionV2";
import { Reveal } from "@/components/v2/Reveal";
import { TiltCard } from "@/components/v2/TiltCard";

type Poste = {
  slug: string;
  title: string;
  icon: any;
  short: string;
  location: string;
  contract: string;
  missions: string[];
  profile: string[];
  accent: string;
};

const POSTES: Poste[] = [
  {
    slug: "Conseiller en assurances",
    title: "Conseiller(ère) en assurances",
    icon: Shield,
    short:
      "Accompagnez nos clients dans l'analyse et l'optimisation de leurs couvertures (santé, vie, RC, ménage, auto).",
    location: "Suisse romande",
    contract: "CDI · Temps plein",
    missions: [
      "Analyser les besoins des clients particuliers et professionnels",
      "Présenter et vendre des solutions d'assurance adaptées",
      "Développer et fidéliser un portefeuille clients",
      "Assurer le suivi administratif des contrats",
      "Représenter Klary avec professionnalisme et éthique",
    ],
    profile: [
      "Inscription FINMA (ou en cours / volonté de l'obtenir)",
      "Expérience en vente ou conseil souhaitée",
      "Excellent relationnel et sens de l'écoute",
      "Permis de conduire + véhicule personnel",
      "Français courant (allemand/anglais un atout)",
    ],
    accent: "hsl(0 75% 60%)",
  },
  {
    slug: "Conseiller en prévoyance",
    title: "Conseiller(ère) en prévoyance",
    icon: PiggyBank,
    short:
      "Spécialiste 2e et 3e pilier, vous aidez nos clients à structurer leur prévoyance et optimiser leur fiscalité.",
    location: "Suisse romande",
    contract: "CDI · Temps plein",
    missions: [
      "Réaliser des analyses prévoyance complètes (LPP, 3a, 3b)",
      "Conseiller sur les rachats, retraits anticipés et planification retraite",
      "Optimiser la fiscalité des clients privés et indépendants",
      "Travailler en synergie avec les conseillers assurances et hypothèque",
      "Assurer une veille réglementaire constante",
    ],
    profile: [
      "Solide connaissance du système des 3 piliers suisse",
      "Formation IAF, brevet fédéral ou équivalent (un plus)",
      "Inscription FINMA appréciée",
      "Rigueur, discrétion et orientation client",
      "Permis de conduire + véhicule",
    ],
    accent: "hsl(160 70% 42%)",
  },
  {
    slug: "Conseiller en financement hypothécaire",
    title: "Conseiller(ère) en financement hypothécaire",
    icon: Home,
    short:
      "Accompagnez les acquéreurs et propriétaires dans le financement et le renouvellement de leur bien immobilier.",
    location: "Suisse romande",
    contract: "CDI · Temps plein",
    missions: [
      "Analyser la capacité financière et la faisabilité des dossiers",
      "Négocier les meilleures conditions auprès de nos partenaires bancaires",
      "Conseiller sur les stratégies d'amortissement et de renouvellement",
      "Coordonner avec notaires, courtiers et banques",
      "Développer un réseau de prescripteurs (régies, agents immobiliers)",
    ],
    profile: [
      "Expérience bancaire ou en courtage hypothécaire (atout majeur)",
      "Maîtrise des règles ASB et des produits hypothécaires suisses",
      "Capacité de négociation et sens du business",
      "Excellente présentation",
      "Permis de conduire + véhicule",
    ],
    accent: "hsl(28 95% 55%)",
  },
  {
    slug: "Conseiller téléphonique / Service client",
    title: "Conseiller(ère) téléphonique / Service client",
    icon: Headphones,
    short:
      "Premier point de contact des clients Klary, vous qualifiez les demandes, prenez les rendez-vous et offrez un service irréprochable.",
    location: "Lausanne / Genève",
    contract: "CDI · Temps plein ou partiel",
    missions: [
      "Accueillir et qualifier les demandes entrantes (téléphone, email, chat)",
      "Planifier les rendez-vous des conseillers terrain",
      "Effectuer des appels sortants de prise de contact",
      "Mettre à jour le CRM et assurer un suivi rigoureux",
      "Contribuer à la satisfaction et fidélisation client",
    ],
    profile: [
      "Excellente élocution en français (allemand/anglais bienvenus)",
      "À l'aise avec les outils informatiques et CRM",
      "Sens du service, patience et empathie",
      "Première expérience en call-center ou service client appréciée",
      "Esprit d'équipe et envie d'évoluer",
    ],
    accent: "hsl(244 65% 42%)",
  },
];

const RecrutementPostes = () => {
  return (
    <div className="min-h-screen bg-background text-foreground">
      <ScrollProgress />
      <HeaderV2 />

      <main>
        <PageHeroV2
          eyebrow="Postes ouverts"
          title="Rejoignez une équipe"
          titleAccent="ambitieuse."
          subtitle="Quatre métiers à pourvoir partout en Suisse romande. Formation à la clé, rémunération attractive, et une vraie culture du conseil neutre."
          cta={
            <>
              <a href="#postes" className="kx-btn kx-btn-accent">
                Voir les postes
                <ArrowRight className="w-4 h-4" />
              </a>
              <Link to="/recrutement/postuler" className="kx-btn kx-btn-outline">
                Candidature spontanée
              </Link>
            </>
          }
        />

        <PageSectionV2
          id="postes"
          eyebrow="Détail des postes"
          title="4 métiers,"
          titleAccent="1 équipe."
        >
          <div className="space-y-6">
            {POSTES.map((p, idx) => {
              const Icon = p.icon;
              return (
                <Reveal key={p.slug} delay={idx * 100}>
                  <TiltCard className="kx-card !p-0 overflow-hidden block" max={2}>
                    <article className="p-7 md:p-10">
                      <div className="flex flex-col md:flex-row md:items-start gap-6 md:gap-8">
                        <div
                          className="flex h-14 w-14 shrink-0 items-center justify-center rounded-2xl"
                          style={{ background: `${p.accent}14`, color: p.accent }}
                        >
                          <Icon className="h-7 w-7" />
                        </div>

                        <div className="flex-1 space-y-5">
                          <div>
                            <p className="text-[11px] uppercase tracking-[0.14em] font-bold mb-2" style={{ color: p.accent }}>
                              {p.contract}
                            </p>
                            <h2 className="text-2xl md:text-3xl font-bold tracking-tight text-foreground mb-3">
                              {p.title}
                            </h2>
                            <div className="flex flex-wrap gap-3 text-sm" style={{ color: "hsl(var(--muted-text))" }}>
                              <span className="flex items-center gap-1.5">
                                <MapPin className="h-4 w-4" /> {p.location}
                              </span>
                              <span className="flex items-center gap-1.5">
                                <Briefcase className="h-4 w-4" /> {p.contract}
                              </span>
                            </div>
                            <p className="text-base mt-4 leading-relaxed" style={{ color: "hsl(var(--foreground-soft))" }}>
                              {p.short}
                            </p>
                          </div>

                          <div className="grid md:grid-cols-2 gap-6 pt-2">
                            <div>
                              <h3
                                className="text-[11px] uppercase tracking-[0.14em] font-bold mb-3"
                                style={{ color: "hsl(var(--accent))" }}
                              >
                                Vos missions
                              </h3>
                              <ul className="space-y-2">
                                {p.missions.map((m, i) => (
                                  <li key={i} className="flex gap-2 text-sm" style={{ color: "hsl(var(--foreground-soft))" }}>
                                    <CheckCircle2 className="h-4 w-4 shrink-0 mt-0.5" style={{ color: p.accent }} />
                                    <span>{m}</span>
                                  </li>
                                ))}
                              </ul>
                            </div>
                            <div>
                              <h3
                                className="text-[11px] uppercase tracking-[0.14em] font-bold mb-3"
                                style={{ color: "hsl(var(--accent))" }}
                              >
                                Profil recherché
                              </h3>
                              <ul className="space-y-2">
                                {p.profile.map((m, i) => (
                                  <li key={i} className="flex gap-2 text-sm" style={{ color: "hsl(var(--foreground-soft))" }}>
                                    <CheckCircle2 className="h-4 w-4 shrink-0 mt-0.5" style={{ color: p.accent }} />
                                    <span>{m}</span>
                                  </li>
                                ))}
                              </ul>
                            </div>
                          </div>

                          <div className="pt-3">
                            <Link
                              to={`/recrutement/postuler?poste=${encodeURIComponent(p.slug)}`}
                              className="kx-btn kx-btn-accent"
                            >
                              Postuler à ce poste
                              <ArrowUpRight className="w-4 h-4" />
                            </Link>
                          </div>
                        </div>
                      </div>
                    </article>
                  </TiltCard>
                </Reveal>
              );
            })}
          </div>
        </PageSectionV2>

        <PageSectionV2
          variant="dark"
          title="Pas de poste qui colle ?"
          subtitle="Envoyez-nous une candidature spontanée. Si votre profil nous intéresse, on vous contacte même hors campagne."
        >
          <div className="flex flex-col sm:flex-row items-center justify-center gap-3 mt-2">
            <Link to="/recrutement/postuler" className="kx-btn kx-btn-accent text-base !py-4 !px-7">
              Envoyer ma candidature
              <ArrowRight className="w-4 h-4" />
            </Link>
            <a
              href="mailto:admin@klary.ch"
              className="kx-btn !py-4 !px-7 bg-white/10 text-white border border-white/20 hover:bg-white/15 transition-colors"
            >
              admin@klary.ch
            </a>
          </div>
        </PageSectionV2>
      </main>

      <FooterV2 />
    </div>
  );
};

export default RecrutementPostes;
