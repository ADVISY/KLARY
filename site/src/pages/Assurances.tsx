import { Link } from "react-router-dom";
import { ArrowRight, ArrowUpRight, Heart, Wallet, Shield, Car, Home, Building2, Scale, Users, FileText } from "lucide-react";
import { HeaderV2 } from "@/components/v2/HeaderV2";
import { FooterV2 } from "@/components/v2/FooterV2";
import { ScrollProgress } from "@/components/v2/ScrollProgress";
import { PageHeroV2 } from "@/components/v2/PageHeroV2";
import { PageSectionV2 } from "@/components/v2/PageSectionV2";
import { Reveal } from "@/components/v2/Reveal";
import { TiltCard } from "@/components/v2/TiltCard";
import { ContactCtaSection } from "@/components/v2/sections/ContactCtaSection";

const coverages = [
  { icon: Heart,      label: "Assurance maladie",     tagline: "LAMal + complémentaires",  desc: "Franchise, modèle, complémentaires hospi & ambulatoire — on optimise sans rogner les soins.", href: "/assurances/sante",                accent: "hsl(0 75% 60%)" },
  { icon: Wallet,     label: "3ᵉ pilier",              tagline: "Prévoyance privée",        desc: "Banque vs assurance, rendement, déduction fiscale — votre prévoyance, expliquée enfin clairement.", href: "/assurances/3e-pilier",            accent: "hsl(160 70% 42%)" },
  { icon: Shield,     label: "RC & ménage",            tagline: "Le combo de base",         desc: "Responsabilité civile, vol, dégâts d'eau, valeurs — couverture étendue à prix juste.", href: "/assurances/rc-menage",            accent: "hsl(244 65% 42%)" },
  { icon: Car,        label: "Automobile",             tagline: "RC, casco, occupants",     desc: "Renouvelez ou changez : on compare 12+ compagnies en moins de 4 minutes.", href: "/assurances/auto",                 accent: "hsl(220 70% 55%)" },
  { icon: Home,       label: "Hypothèque",             tagline: "Financement immobilier",   desc: "Taux fixe, SARON, mix — on négocie avec 30+ établissements en parallèle.", href: "/assurances/hypotheque",           accent: "hsl(28 90% 50%)" },
  { icon: Scale,      label: "Protection juridique",   tagline: "Privée & circulation",     desc: "Conseils, frais d'avocat, médiation — pour ne plus jamais reculer devant un litige.", href: "/assurances/protection-juridique", accent: "hsl(195 75% 45%)" },
  { icon: Building2,  label: "LPP — 2ᵉ pilier",        tagline: "Pour les entreprises",     desc: "Mise en concurrence des caisses de pension. Économies moyennes : 12-18 % sur les primes.", href: "/entreprises/lpp",                 accent: "hsl(280 60% 50%)" },
  { icon: Users,      label: "Personnel d'entreprise", tagline: "Indemnités journalières", desc: "Couverture maladie/accident des salariés, optimisée avec les LAA, IJ et compléments.", href: "/entreprises/personnel",           accent: "hsl(244 65% 42%)" },
  { icon: FileText,   label: "RC professionnelle",     tagline: "Pour indépendants & PME",  desc: "Couverture responsabilité civile pro adaptée à votre activité et votre taille.", href: "/entreprises/personnel",           accent: "hsl(160 70% 42%)" },
];

const Assurances = () => {
  return (
    <div className="min-h-screen bg-background text-foreground">
      <ScrollProgress />
      <HeaderV2 />

      <main>
        <PageHeroV2
          eyebrow="Toutes nos couvertures"
          title="Vos contrats, tous"
          titleAccent="entre les mêmes mains."
          subtitle="Particuliers ou entreprises : on prend en charge l'ensemble de votre couverture, on compare les compagnies, on négocie. Un seul interlocuteur, un suivi sur la durée."
          cta={
            <>
              <a href="mailto:admin@klary.ch" className="kx-btn kx-btn-accent">
                Mon analyse gratuite en 15 min
                <ArrowRight className="w-4 h-4" />
              </a>
              <a href="#couvertures" className="kx-btn kx-btn-outline">
                Voir les couvertures
              </a>
            </>
          }
        />

        <PageSectionV2
          id="couvertures"
          eyebrow="Couvertures"
          title="9 produits, 1 interlocuteur,"
          titleAccent="zéro paperasse."
          subtitle="Sélectionnez le contrat à optimiser. Pour chaque produit, on vous explique sans jargon, on compare les compagnies et on chiffre vos économies."
        >
          <div className="grid sm:grid-cols-2 lg:grid-cols-3 gap-4 md:gap-5">
            {coverages.map((c, i) => {
              const Icon = c.icon;
              return (
                <Reveal key={c.label} delay={i * 60}>
                  <TiltCard className="kx-card group block h-full" max={4} glowColor="240, 101, 31">
                    <Link to={c.href} className="block">
                      <div className="flex items-start justify-between mb-5">
                        <span
                          className="w-12 h-12 rounded-2xl flex items-center justify-center transition-transform duration-300 group-hover:scale-105"
                          style={{ background: `${c.accent}14`, color: c.accent }}
                        >
                          <Icon className="w-6 h-6" />
                        </span>
                        <ArrowUpRight
                          className="w-5 h-5 transition-colors"
                          style={{ color: "hsl(var(--muted-text))" }}
                        />
                      </div>
                      <p
                        className="text-[11px] uppercase tracking-[0.14em] font-semibold mb-1.5"
                        style={{ color: "hsl(var(--muted-text))" }}
                      >
                        {c.tagline}
                      </p>
                      <p className="text-xl font-bold text-foreground mb-3 leading-tight tracking-tight">
                        {c.label}
                      </p>
                      <p className="text-sm leading-relaxed" style={{ color: "hsl(var(--muted-text))" }}>
                        {c.desc}
                      </p>
                    </Link>
                  </TiltCard>
                </Reveal>
              );
            })}
          </div>
        </PageSectionV2>

        <ContactCtaSection
          eyebrow="Pas sûr de quoi commencer ?"
          title="On fait l'inventaire"
          titleAccent="ensemble, gratuitement."
          subtitle="Un conseiller Klary analyse tous vos contrats actuels et identifie là où vous pouvez économiser ou mieux vous couvrir."
          formType="Analyse globale"
          formTitle="Demandez votre comparatif"
          formSubtitle="On reprend l'ensemble de vos contrats et on vous renvoie un rapport personnalisé."
        />
      </main>

      <FooterV2 />
    </div>
  );
};

export default Assurances;
