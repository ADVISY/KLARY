import { ArrowRight, Calculator, HeartHandshake, PiggyBank, Wallet, TrendingUp, Home } from "lucide-react";
import { HeaderV2 } from "@/components/v2/HeaderV2";
import { FooterV2 } from "@/components/v2/FooterV2";
import { ScrollProgress } from "@/components/v2/ScrollProgress";
import { PageHeroV2 } from "@/components/v2/PageHeroV2";
import { PageSectionV2 } from "@/components/v2/PageSectionV2";
import { Reveal } from "@/components/v2/Reveal";
import { TiltCard } from "@/components/v2/TiltCard";
import { ContactCtaSection } from "@/components/v2/sections/ContactCtaSection";
import { SimulateurImpot } from "@/components/simulateurs/SimulateurImpot";
import { SimulateurSalaire } from "@/components/simulateurs/SimulateurSalaire";
import { SimulateurSubsides } from "@/components/simulateurs/SimulateurSubsides";
import { SimulateurInteretsComposes } from "@/components/simulateurs/SimulateurInteretsComposes";
import { SimulateurHypothecaire } from "@/components/simulateurs/SimulateurHypothecaire";

const simulateurs = [
  { id: "impot",              label: "Impôt 3ᵉ pilier",      desc: "Calculez vos économies fiscales sur un versement 3a.",       icon: PiggyBank,     accent: "hsl(160 70% 42%)" },
  { id: "salaire",            label: "Salaire net",           desc: "De brut à net : charges, AVS, LPP, impôts à la source.",     icon: Wallet,         accent: "hsl(244 65% 42%)" },
  { id: "subsides",           label: "Subsides santé",        desc: "Estimez vos droits à la réduction LAMal cantonale.",         icon: HeartHandshake, accent: "hsl(0 75% 60%)" },
  { id: "interets-composes",  label: "Intérêts composés",    desc: "Projetez la croissance d'un capital sur 5 à 40 ans.",        icon: TrendingUp,    accent: "hsl(28 95% 55%)" },
  { id: "hypothecaire",       label: "Prêt hypothécaire",    desc: "Capacité d'emprunt + simulation taux fixe / SARON.",         icon: Home,           accent: "hsl(195 75% 45%)" },
];

const Simulateurs = () => {
  return (
    <div className="min-h-screen bg-background text-foreground">
      <ScrollProgress />
      <HeaderV2 />

      <main>
        <PageHeroV2
          eyebrow="Simulateurs gratuits"
          title="Simulez votre"
          titleAccent="situation financière."
          subtitle="Cinq outils gratuits pour estimer vos impôts, votre salaire net, vos subsides santé, la croissance de vos investissements et votre capacité hypothécaire. Sans engagement, sans inscription."
          cta={
            <>
              <a href="#liste" className="kx-btn kx-btn-accent">
                Choisir un simulateur
                <ArrowRight className="w-4 h-4" />
              </a>
              <a href="mailto:admin@klary.ch" className="kx-btn kx-btn-outline">
                Parler à un conseiller
              </a>
            </>
          }
        />

        {/* Navigation des simulateurs */}
        <PageSectionV2
          id="liste"
          eyebrow="5 outils"
          title="Choisissez votre"
          titleAccent="simulateur."
        >
          <div className="grid sm:grid-cols-2 lg:grid-cols-3 gap-5">
            {simulateurs.map((s, i) => {
              const Icon = s.icon;
              return (
                <Reveal key={s.id} delay={i * 80}>
                  <TiltCard className="kx-card block h-full" max={4}>
                    <a href={`#${s.id}`} className="block">
                      <span
                        className="w-12 h-12 rounded-2xl flex items-center justify-center mb-5"
                        style={{ background: `${s.accent}14`, color: s.accent }}
                      >
                        <Icon className="w-6 h-6" />
                      </span>
                      <p className="text-xl font-bold text-foreground mb-3 tracking-tight">{s.label}</p>
                      <p className="text-sm leading-relaxed" style={{ color: "hsl(var(--muted-text))" }}>
                        {s.desc}
                      </p>
                    </a>
                  </TiltCard>
                </Reveal>
              );
            })}
          </div>
        </PageSectionV2>

        {/* Les 5 simulateurs en sections séparées */}
        <PageSectionV2 id="impot" eyebrow="Simulateur 01" title="Impôt 3ᵉ pilier" subtitle="Estimez en quelques clics combien vous économisez en impôts grâce à un versement 3a annuel.">
          <SimulateurImpot />
        </PageSectionV2>

        <PageSectionV2 id="salaire" eyebrow="Simulateur 02" title="Salaire brut → net" subtitle="Du salaire brut au salaire net : déductions sociales, impôts, et net en poche.">
          <SimulateurSalaire />
        </PageSectionV2>

        <PageSectionV2 id="subsides" eyebrow="Simulateur 03" title="Subsides santé cantonaux" subtitle="Estimez vos droits à la réduction LAMal cantonale selon revenu et canton.">
          <SimulateurSubsides />
        </PageSectionV2>

        <PageSectionV2 id="interets-composes" eyebrow="Simulateur 04" title="Intérêts composés" subtitle="Projetez la croissance d'un capital sur la durée, avec versements et rendement.">
          <SimulateurInteretsComposes />
        </PageSectionV2>

        <PageSectionV2 id="hypothecaire" eyebrow="Simulateur 05" title="Prêt hypothécaire" subtitle="Capacité d'emprunt + simulation taux fixe / SARON sur la durée de votre choix.">
          <SimulateurHypothecaire />
        </PageSectionV2>

        <ContactCtaSection
          eyebrow="Besoin d'aide pour interpréter ?"
          title="Un conseiller Klary vous explique tout"
          titleAccent="en 15 minutes."
          subtitle="Les simulateurs donnent des ordres de grandeur. Pour une analyse précise et personnalisée, parlez à un humain."
          formType="Simulateurs"
          formTitle="Précisez votre simulation"
          formSubtitle="Indiquez vos données réelles, on vous rappelle avec un chiffrage exact."
        />
      </main>

      <FooterV2 />
    </div>
  );
};

export default Simulateurs;
