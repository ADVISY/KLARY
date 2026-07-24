import { Users, Shield, HeartPulse, Sparkles, Check } from "lucide-react";
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
    icon: Shield,
    title: "Assurance accidents LAA",
    description: "Couverture obligatoire des accidents professionnels et non professionnels.",
    items: [
      "Accidents professionnels",
      "Accidents non professionnels",
      "Maladies professionnelles",
      "Indemnités journalières",
    ],
    accent: "hsl(244 65% 50%)",
  },
  {
    icon: HeartPulse,
    title: "Maladie collective",
    description: "Conditions avantageuses pour vos employés et simplification administrative.",
    items: [
      "Primes préférentielles",
      "Gestion centralisée",
      "Couverture complète",
      "Complémentaires incluses",
    ],
    accent: "hsl(19 90% 54%)",
  },
  {
    icon: Sparkles,
    title: "Prestations surobligatoires",
    description: "Renforcez l'attractivité de votre entreprise avec des couvertures supérieures.",
    items: [
      "Salaire à 100%",
      "Prolongation couverture",
      "Prestations étendues",
      "Avantages compétitifs",
    ],
    accent: "hsl(160 70% 42%)",
  },
];

const AssurancePersonnel = () => {
  return (
    <div className="min-h-screen bg-background text-foreground">
      <ScrollProgress />
      <HeaderV2 />
      <main>
        <PageHeroV2
          eyebrow="Entreprises"
          title="Assurance du"
          titleAccent="personnel."
          subtitle="Protégez vos employés et renforcez l'attractivité de votre entreprise. Conseil dédié pour PME suisses."
          cta={
            <>
              <a href="#contact" className="kx-btn kx-btn-accent">
                Demander une offre
              </a>
              <a href="#solutions" className="kx-btn kx-btn-outline">
                Nos solutions
              </a>
            </>
          }
        />

        <PageSectionV2
          id="solutions"
          eyebrow="Solutions PME"
          title="Trois couvertures clés"
          titleAccent="pour vos équipes."
          subtitle="Des assurances adaptées à la protection de vos collaborateurs."
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

        <PageSectionV2 eyebrow="Pourquoi Klary" title="Le partenaire" titleAccent="prévoyance des PME.">
          <div className="grid md:grid-cols-2 gap-6">
            {[
              {
                icon: Users,
                title: "Conseiller dédié",
                desc: "Un interlocuteur unique pour votre entreprise et vos collaborateurs.",
              },
              {
                icon: Shield,
                title: "Couverture optimisée",
                desc: "Comparaison de toutes les compagnies suisses pour le meilleur rapport coût/garanties.",
              },
              {
                icon: Sparkles,
                title: "Onboarding fluide",
                desc: "Mise en place sans paperasse pour vos RH, déclarations gérées de A à Z.",
              },
              {
                icon: HeartPulse,
                title: "Suivi annuel",
                desc: "Revue contractuelle automatique chaque année, alertes sur les optimisations.",
              },
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
          eyebrow="Devis entreprise"
          title="Demandez votre"
          titleAccent="comparatif gratuit."
          subtitle="On reprend votre situation actuelle, on identifie les économies possibles et on propose une couverture optimisée."
          formType="Entreprise — Personnel"
          formTitle="Recevez votre offre PME"
          formSubtitle="Indiquez vos coordonnées et nombre d'employés, on revient sous 48h."
          reassurances={[
            "Devis personnalisé sous 48h",
            "Comparaison de toutes compagnies",
            "Onboarding RH simplifié",
            "Conseiller dédié à votre entreprise",
          ]}
        />
      </main>
      <FooterV2 />
    </div>
  );
};

export default AssurancePersonnel;
