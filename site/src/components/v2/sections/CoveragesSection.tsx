import { Link } from "react-router-dom";
import { ArrowUpRight, Heart, Wallet, Shield, Car, Home, Building2, Scale } from "lucide-react";
import { Reveal } from "../Reveal";
import { TiltCard } from "../TiltCard";
import { ScrollRevealText } from "../ScrollRevealText";

const coverages = [
  {
    icon: Heart,
    label: "Assurance maladie",
    tagline: "LAMal + complémentaires",
    desc: "Franchise, modèle, complémentaires hospi & ambulatoire — on optimise sans rogner les soins.",
    href: "/assurances/sante",
    accent: "hsl(0 75% 60%)",
  },
  {
    icon: Wallet,
    label: "3ᵉ pilier",
    tagline: "Prévoyance privée",
    desc: "Banque vs assurance, rendement, déduction fiscale — votre prévoyance, expliquée enfin clairement.",
    href: "/assurances/3e-pilier",
    accent: "hsl(160 70% 42%)",
  },
  {
    icon: Shield,
    label: "RC & ménage",
    tagline: "Le combo de base",
    desc: "Responsabilité civile, vol, dégâts d'eau, valeurs — couverture étendue à prix juste.",
    href: "/assurances/rc-menage",
    accent: "hsl(244 65% 42%)",
  },
  {
    icon: Car,
    label: "Automobile",
    tagline: "RC, casco, occupants",
    desc: "Renouvelez ou changez : on compare 12+ compagnies en moins de 4 minutes.",
    href: "/assurances/auto",
    accent: "hsl(220 70% 55%)",
  },
  {
    icon: Home,
    label: "Hypothèque",
    tagline: "Financement immobilier",
    desc: "Taux fixe, SARON, mix — on négocie avec 30+ établissements en parallèle.",
    href: "/assurances/hypotheque",
    accent: "hsl(28 90% 50%)",
  },
  {
    icon: Building2,
    label: "LPP — 2ᵉ pilier",
    tagline: "Pour les entreprises",
    desc: "Mise en concurrence des caisses de pension. Économies moyennes : 12-18 % sur les primes.",
    href: "/entreprises/lpp",
    accent: "hsl(280 60% 50%)",
  },
  {
    icon: Scale,
    label: "Protection juridique",
    tagline: "Privée & circulation",
    desc: "Conseils, frais d'avocat, médiation — pour ne plus jamais reculer devant un litige.",
    href: "/assurances/protection-juridique",
    accent: "hsl(195 75% 45%)",
  },
];

export const CoveragesSection = () => {
  return (
    <section id="couvertures" className="relative py-24 md:py-32 bg-background">
      <div className="mx-auto max-w-7xl px-5 lg:px-8">
        <Reveal className="flex flex-col md:flex-row md:items-end md:justify-between gap-6 mb-12 md:mb-16">
          <div className="max-w-2xl">
            <span className="kx-eyebrow mb-5">Couvertures</span>
            <ScrollRevealText as="h2" className="kx-display text-[2rem] sm:text-[2.5rem] lg:text-[3rem] mb-5" theme="dark">
              Une équipe. <span className="kx-display-gradient">Tous vos contrats.</span>
            </ScrollRevealText>
            <p className="text-lg leading-relaxed" style={{ color: "hsl(var(--foreground-soft))" }}>
              Particulier ou entreprise, on prend en charge l'ensemble de votre couverture.
              Un seul interlocuteur, un suivi sur la durée.
            </p>
          </div>
        </Reveal>

        <div className="grid sm:grid-cols-2 lg:grid-cols-3 gap-4 md:gap-5">
          {coverages.map((c, i) => {
            const Icon = c.icon;
            return (
              <Reveal key={c.label} delay={i * 70}>
                <TiltCard className="kx-card group block h-full" max={4} glowColor="240, 101, 31">
                  <Link to={c.href} className="block">
                    <div className="flex items-start justify-between mb-5">
                      <div
                        className="w-12 h-12 rounded-2xl flex items-center justify-center transition-transform duration-300 group-hover:scale-105"
                        style={{ background: `${c.accent}14`, color: c.accent }}
                      >
                        <Icon className="w-6 h-6" />
                      </div>
                      <ArrowUpRight className="w-5 h-5 text-muted-text group-hover:text-foreground transition-colors" />
                    </div>
                    <p className="text-[11px] uppercase tracking-[0.14em] font-semibold mb-1.5" style={{ color: "hsl(var(--muted-text))" }}>
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
      </div>
    </section>
  );
};
