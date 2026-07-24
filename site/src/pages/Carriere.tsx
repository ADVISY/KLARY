import { Link } from "react-router-dom";
import { ArrowRight, ArrowUpRight, Users, TrendingUp, Heart, GraduationCap, Briefcase, MapPin } from "lucide-react";
import { HeaderV2 } from "@/components/v2/HeaderV2";
import { FooterV2 } from "@/components/v2/FooterV2";
import { ScrollProgress } from "@/components/v2/ScrollProgress";
import { PageHeroV2 } from "@/components/v2/PageHeroV2";
import { PageSectionV2 } from "@/components/v2/PageSectionV2";
import { Reveal } from "@/components/v2/Reveal";
import { TiltCard } from "@/components/v2/TiltCard";

const reasons = [
  { icon: TrendingUp,    title: "Rémunération ambitieuse",      desc: "Fixe + commissions + bonus. Les meilleurs conseillers gagnent plus de 120k/an dès la 2e année." },
  { icon: GraduationCap, title: "Formation 5j tutorat",          desc: "On vous forme à fond avant de vous lâcher en autonomie. Vous repartez avec un AFA validé." },
  { icon: Heart,          title: "Conseil neutre, pas de hard sell", desc: "On vend du conseil, pas de la pression. Vous dormez bien." },
  { icon: Users,          title: "Équipe humaine",               desc: "20 personnes en Suisse romande. On se voit, on se parle, on se soutient. Pas une usine." },
];

const openPositions = [
  { title: "Conseiller en assurance — Lausanne", type: "CDI · Plein temps", location: "Lausanne", level: "1 à 5 ans d'XP" },
  { title: "Conseiller en assurance — Genève",   type: "CDI · Plein temps", location: "Genève",   level: "Débutant accepté" },
  { title: "Spécialiste prévoyance LPP",          type: "CDI · Plein temps", location: "Lausanne", level: "3+ ans d'XP" },
  { title: "Conseiller hypothèque",               type: "CDI · Plein temps", location: "Genève",   level: "2+ ans d'XP" },
];

const Carriere = () => {
  return (
    <div className="min-h-screen bg-background text-foreground">
      <ScrollProgress />
      <HeaderV2 />

      <main>
        <PageHeroV2
          eyebrow="Rejoignez l'équipe"
          title="Construisez votre"
          titleAccent="carrière chez Klary."
          subtitle="On cherche des conseillers ambitieux et honnêtes. Un environnement où le conseil prime sur la vente, où la formation est sérieuse et où la rémunération suit la performance."
          cta={
            <>
              <Link to="/recrutement/postuler" className="kx-btn kx-btn-accent">
                Postuler maintenant
                <ArrowRight className="w-4 h-4" />
              </Link>
              <a href="#postes" className="kx-btn kx-btn-outline">
                Voir les postes
              </a>
            </>
          }
        />

        <PageSectionV2
          eyebrow="Pourquoi Klary"
          title="4 raisons de"
          titleAccent="nous rejoindre."
        >
          <div className="grid sm:grid-cols-2 gap-5 md:gap-6">
            {reasons.map((r, i) => {
              const Icon = r.icon;
              return (
                <Reveal key={r.title} delay={i * 100}>
                  <TiltCard className="kx-card block h-full" max={4}>
                    <span
                      className="w-12 h-12 rounded-2xl flex items-center justify-center mb-5"
                      style={{ background: "hsl(var(--accent-light))", color: "hsl(var(--accent))" }}
                    >
                      <Icon className="w-6 h-6" />
                    </span>
                    <p className="text-xl font-bold text-foreground mb-3 tracking-tight">{r.title}</p>
                    <p className="text-sm leading-relaxed" style={{ color: "hsl(var(--muted-text))" }}>
                      {r.desc}
                    </p>
                  </TiltCard>
                </Reveal>
              );
            })}
          </div>
        </PageSectionV2>

        <PageSectionV2
          id="postes"
          eyebrow="Postes ouverts"
          title="4 postes à pourvoir"
          titleAccent="dès maintenant."
          subtitle="Tous les détails, profils recherchés et conditions sur la page de postulation."
        >
          <div className="grid md:grid-cols-2 gap-4 md:gap-5">
            {openPositions.map((p, i) => (
              <Reveal key={i} delay={i * 80}>
                <TiltCard className="kx-card block h-full" max={3}>
                  <Link to="/recrutement/postuler" className="block">
                    <div className="flex items-start justify-between mb-5">
                      <span
                        className="w-12 h-12 rounded-2xl flex items-center justify-center"
                        style={{ background: "hsl(var(--accent-light))", color: "hsl(var(--accent))" }}
                      >
                        <Briefcase className="w-6 h-6" />
                      </span>
                      <ArrowUpRight className="w-5 h-5" style={{ color: "hsl(var(--muted-text))" }} />
                    </div>
                    <p
                      className="text-[11px] uppercase tracking-[0.14em] font-semibold mb-2"
                      style={{ color: "hsl(var(--accent))" }}
                    >
                      {p.type}
                    </p>
                    <p className="text-xl font-bold text-foreground mb-3 leading-tight tracking-tight">
                      {p.title}
                    </p>
                    <div className="flex flex-wrap items-center gap-4 text-sm" style={{ color: "hsl(var(--muted-text))" }}>
                      <span className="flex items-center gap-1.5">
                        <MapPin className="w-4 h-4" />
                        {p.location}
                      </span>
                      <span>{p.level}</span>
                    </div>
                  </Link>
                </TiltCard>
              </Reveal>
            ))}
          </div>
        </PageSectionV2>

        <PageSectionV2
          variant="dark"
          title="Pas de poste qui colle ? Envoyez-nous une candidature spontanée."
          subtitle="Si votre profil nous intéresse, on vous contacte même hors campagne de recrutement."
        >
          <div className="flex flex-col sm:flex-row items-center justify-center gap-3 mt-2">
            <Link to="/recrutement/postuler" className="kx-btn kx-btn-accent text-base !py-4 !px-7">
              Envoyer ma candidature
              <ArrowRight className="w-4 h-4" />
            </Link>
            <a href="mailto:admin@klary.ch" className="kx-btn !py-4 !px-7 bg-white/10 text-white border border-white/20 hover:bg-white/15 transition-colors">
              admin@klary.ch
            </a>
          </div>
        </PageSectionV2>
      </main>

      <FooterV2 />
    </div>
  );
};

export default Carriere;
