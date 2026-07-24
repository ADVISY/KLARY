import { Scale, Search, TrendingDown, Users, ShieldCheck, Heart, ArrowRight } from "lucide-react";
import { HeaderV2 } from "@/components/v2/HeaderV2";
import { FooterV2 } from "@/components/v2/FooterV2";
import { ScrollProgress } from "@/components/v2/ScrollProgress";
import { PageHeroV2 } from "@/components/v2/PageHeroV2";
import { PageSectionV2 } from "@/components/v2/PageSectionV2";
import { Reveal } from "@/components/v2/Reveal";
import { TiltCard } from "@/components/v2/TiltCard";
import { ContactCtaSection } from "@/components/v2/sections/ContactCtaSection";

const values = [
  { icon: Scale,        title: "Conseil neutre",       desc: "Aucune compagnie derrière nous. La même commission peu importe le produit retenu. On vous conseille ce qui est vraiment le mieux." },
  { icon: Search,       title: "Transparence totale", desc: "On vous montre les chiffres bruts, les écarts, les commissions. Pas de petits caractères, pas de coût caché." },
  { icon: TrendingDown, title: "Économies réelles",    desc: "+1'247 CHF/an en moyenne, sans rogner sur les garanties. Souvent même en améliorant la couverture." },
  { icon: Users,        title: "Suivi humain",        desc: "Un conseiller dédié. Pas de hotline anonyme. On vous connaît, vous nous connaissez." },
  { icon: ShieldCheck,  title: "FINMA conforme",      desc: "Cabinet enregistré auprès de la FINMA, surveillé, audité. Vos données sont protégées par la nLPD suisse." },
  { icon: Heart,        title: "Engagement long terme", desc: "Une fois client, on reste là. Renouvellements, sinistres, changements de vie — on accompagne tout." },
];

const stats = [
  { value: "2'500+", label: "Clients accompagnés" },
  { value: "+1'247 CHF", label: "Économies moyennes / an" },
  { value: "4,8/5",   label: "Note clients" },
  { value: "100%",    label: "Indépendant" },
];

const APropos = () => {
  return (
    <div className="min-h-screen bg-background text-foreground">
      <ScrollProgress />
      <HeaderV2 />

      <main>
        <PageHeroV2
          eyebrow="Notre mission"
          title="L'assurance suisse,"
          titleAccent="enfin claire."
          subtitle="Klary est né d'un constat simple : les Suisses paient en moyenne trop pour des contrats qu'ils ne comprennent pas. On a décidé d'arrêter ça."
          cta={
            <>
              <a href="mailto:admin@klary.ch" className="kx-btn kx-btn-accent">
                Parler à un conseiller
                <ArrowRight className="w-4 h-4" />
              </a>
              <a href="#valeurs" className="kx-btn kx-btn-outline">
                Nos valeurs
              </a>
            </>
          }
        />

        <PageSectionV2 eyebrow="Notre histoire" title="On simplifie ce que les autres compliquent.">
          <div className="grid lg:grid-cols-[1.4fr_1fr] gap-12 lg:gap-16">
            <Reveal>
              <div className="space-y-5 text-lg leading-relaxed" style={{ color: "hsl(var(--foreground-soft))" }}>
                <p>
                  En Suisse, le marché de l'assurance compte plus de 25 compagnies, des centaines de produits,
                  et des conditions qui changent chaque année. Le résultat : <strong className="text-foreground">73% des gens
                  paient trop cher sans le savoir</strong>, et 1 personne sur 3 est mal couverte.
                </p>
                <p>
                  Klary, c'est un cabinet de courtage <strong className="text-foreground">indépendant</strong> qui agit comme
                  votre interface unique avec toutes les compagnies du marché. On n'appartient à aucune marque,
                  on touche la même commission partout — donc on n'a aucun intérêt à pousser un produit plutôt qu'un autre.
                </p>
                <p>
                  Notre métier : <strong className="text-foreground">comprendre votre situation</strong>, comparer 25+
                  acteurs en parallèle, négocier les conditions, et vous expliquer en français clair ce qui change pour vous.
                  Aux frais des compagnies, jamais aux vôtres.
                </p>
              </div>
            </Reveal>

            <Reveal delay={150}>
              <div className="grid grid-cols-2 gap-4">
                {stats.map((s) => (
                  <TiltCard key={s.label} className="kx-card !p-6 text-center" max={4}>
                    <p
                      className="text-3xl md:text-4xl font-bold leading-none tracking-tight mb-2 tabular-nums"
                      style={{
                        background: "linear-gradient(135deg, hsl(19 90% 54%) 0%, hsl(28 95% 65%) 100%)",
                        WebkitBackgroundClip: "text",
                        backgroundClip: "text",
                        WebkitTextFillColor: "transparent",
                      }}
                    >
                      {s.value}
                    </p>
                    <p className="text-xs font-medium" style={{ color: "hsl(var(--muted-text))" }}>
                      {s.label}
                    </p>
                  </TiltCard>
                ))}
              </div>
            </Reveal>
          </div>
        </PageSectionV2>

        <PageSectionV2
          id="valeurs"
          eyebrow="Nos valeurs"
          title="6 principes qui guident"
          titleAccent="chaque dossier."
          subtitle="Pas des slogans marketing — des règles concrètes qu'on applique à chacun de nos clients, sans exception."
        >
          <div className="grid sm:grid-cols-2 lg:grid-cols-3 gap-5 md:gap-6">
            {values.map((v, i) => {
              const Icon = v.icon;
              return (
                <Reveal key={v.title} delay={i * 80}>
                  <TiltCard className="kx-card block h-full" max={4}>
                    <span
                      className="w-12 h-12 rounded-2xl flex items-center justify-center mb-5"
                      style={{ background: "hsl(var(--accent-light))", color: "hsl(var(--accent))" }}
                    >
                      <Icon className="w-6 h-6" />
                    </span>
                    <p className="text-xl font-bold text-foreground mb-3 tracking-tight">{v.title}</p>
                    <p className="text-sm leading-relaxed" style={{ color: "hsl(var(--muted-text))" }}>
                      {v.desc}
                    </p>
                  </TiltCard>
                </Reveal>
              );
            })}
          </div>
        </PageSectionV2>

        <ContactCtaSection
          eyebrow="Envie d'en savoir plus ?"
          title="Parlons ensemble."
          subtitle="Réservez 15 minutes avec un de nos conseillers — c'est gratuit et sans engagement."
          formType="Découverte"
          formTitle="Prendre contact"
          formSubtitle="On vous rappelle pour comprendre votre situation et voir comment on peut aider."
        />
      </main>

      <FooterV2 />
    </div>
  );
};

export default APropos;
