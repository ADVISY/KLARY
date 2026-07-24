import { Building, Shield, BarChart3, Settings, Check, TrendingUp } from "lucide-react";
import { HeaderV2 } from "@/components/v2/HeaderV2";
import { FooterV2 } from "@/components/v2/FooterV2";
import { ScrollProgress } from "@/components/v2/ScrollProgress";
import { PageHeroV2 } from "@/components/v2/PageHeroV2";
import { PageSectionV2 } from "@/components/v2/PageSectionV2";
import { Reveal } from "@/components/v2/Reveal";
import { TiltCard } from "@/components/v2/TiltCard";
import { ContactCtaSection } from "@/components/v2/sections/ContactCtaSection";

const solutions = [
  {
    icon: BarChart3,
    title: "Comparaison des caisses",
    description: "Nous analysons les meilleures fondations LPP selon vos critères : prestations, coûts, flexibilité.",
    items: ["Analyse comparative", "Meilleures conditions", "Solutions flexibles", "Accompagnement complet"],
    accent: "hsl(244 65% 50%)",
  },
  {
    icon: Shield,
    title: "Plans surobligatoires",
    description: "Offrez à vos collaborateurs une prévoyance supérieure au minimum légal pour les fidéliser.",
    items: ["Prestations étendues", "Attractivité employeur", "Salaire assuré supérieur", "Options personnalisées"],
    accent: "hsl(19 90% 54%)",
  },
  {
    icon: Settings,
    title: "Gestion simplifiée",
    description: "Accompagnement dans la mise en place, l'administration et les mutations de personnel.",
    items: ["Installation complète", "Administration facilitée", "Mutations simplifiées", "Support continu"],
    accent: "hsl(160 70% 42%)",
  },
];

const PrevoyanceLPP = () => {
  return (
    <div className="min-h-screen bg-background text-foreground">
      <ScrollProgress />
      <HeaderV2 />
      <main>
        <PageHeroV2
          eyebrow="Entreprises · LPP"
          title="Prévoyance"
          titleAccent="professionnelle."
          subtitle="Choisissez la caisse de pension adaptée à votre taille et votre budget. Optimisez vos coûts sans sacrifier les prestations."
          cta={
            <>
              <a href="#contact" className="kx-btn kx-btn-accent">
                Optimiser ma LPP
              </a>
              <a href="#solutions" className="kx-btn kx-btn-outline">
                Voir les solutions
              </a>
            </>
          }
        />

        <PageSectionV2
          id="solutions"
          eyebrow="LPP sur mesure"
          title="Trois axes"
          titleAccent="pour votre prévoyance."
          subtitle="Des solutions adaptées à la taille et aux objectifs de votre entreprise."
        >
          <div className="grid md:grid-cols-3 gap-5 md:gap-6">
            {solutions.map((s, i) => {
              const Icon = s.icon;
              return (
                <Reveal key={s.title} delay={i * 120}>
                  <TiltCard
                    className="block h-full bg-white rounded-2xl p-7 border border-neutral-light/70"
                    max={5}
                    glowColor="240, 101, 31"
                  >
                    <div
                      className="w-12 h-12 rounded-xl flex items-center justify-center mb-5"
                      style={{
                        background: `${s.accent}15`,
                        color: s.accent,
                        border: `1px solid ${s.accent}30`,
                      }}
                    >
                      <Icon className="w-6 h-6" strokeWidth={1.75} />
                    </div>
                    <h3 className="text-xl font-bold text-foreground mb-2 tracking-tight">
                      {s.title}
                    </h3>
                    <p
                      className="text-[15px] mb-5 leading-relaxed"
                      style={{ color: "hsl(var(--foreground-soft))" }}
                    >
                      {s.description}
                    </p>
                    <ul className="space-y-2 pt-4 border-t border-neutral-light/60">
                      {s.items.map((it) => (
                        <li
                          key={it}
                          className="flex items-center gap-2.5 text-sm"
                          style={{ color: "hsl(var(--foreground-soft))" }}
                        >
                          <Check
                            className="w-3.5 h-3.5 shrink-0"
                            style={{ color: s.accent }}
                            strokeWidth={2.5}
                          />
                          {it}
                        </li>
                      ))}
                    </ul>
                  </TiltCard>
                </Reveal>
              );
            })}
          </div>
        </PageSectionV2>

        <PageSectionV2
          eyebrow="Pourquoi changer ?"
          title="Une LPP bien choisie"
          titleAccent="économise des dizaines de milliers."
        >
          <div className="grid md:grid-cols-2 gap-6">
            {[
              { icon: Building, title: "Coûts maîtrisés", desc: "Frais de gestion comparés pour les 30+ fondations actives en Suisse." },
              { icon: TrendingUp, title: "Performance", desc: "Rendement net analysé sur 5 et 10 ans, par classe de risque." },
              { icon: Shield, title: "Sécurité", desc: "Taux de couverture, réserves, qualité de gouvernance." },
              { icon: Settings, title: "Service RH", desc: "Mutations rapides, portail employé, gestion d'absences intégrée." },
            ].map((b, i) => {
              const Icon = b.icon;
              return (
                <Reveal key={b.title} delay={i * 80}>
                  <div className="flex gap-4 p-5 rounded-2xl bg-white border border-neutral-light/60">
                    <div
                      className="w-10 h-10 rounded-lg flex items-center justify-center shrink-0"
                      style={{ background: "hsl(var(--accent-light))", color: "hsl(var(--accent))" }}
                    >
                      <Icon className="w-5 h-5" />
                    </div>
                    <div>
                      <h4 className="font-bold text-foreground mb-1">{b.title}</h4>
                      <p className="text-sm" style={{ color: "hsl(var(--foreground-soft))" }}>
                        {b.desc}
                      </p>
                    </div>
                  </div>
                </Reveal>
              );
            })}
          </div>
        </PageSectionV2>

        <ContactCtaSection
          eyebrow="Audit LPP gratuit"
          title="Comparons votre"
          titleAccent="caisse actuelle."
          subtitle="On audit votre solution actuelle et on propose des alternatives chiffrées sous 5 jours ouvrés."
          formType="Entreprise — LPP"
          formTitle="Recevez votre audit LPP"
          formSubtitle="On reprend votre fondation actuelle et on compare avec 5 alternatives chiffrées."
          reassurances={[
            "Audit chiffré sous 5 jours",
            "30+ fondations comparées",
            "Confidentialité contractuelle",
            "Aucune obligation de changement",
          ]}
        />
      </main>
      <FooterV2 />
    </div>
  );
};

export default PrevoyanceLPP;
