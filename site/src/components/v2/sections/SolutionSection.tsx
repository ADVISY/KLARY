import { CSSProperties } from "react";
import { Scale, Search, TrendingDown, ArrowRight, Check } from "lucide-react";
import { Reveal } from "../Reveal";
import { TiltCard } from "../TiltCard";
import { ScrollRevealText } from "../ScrollRevealText";
import { useReveal } from "../hooks/useReveal";

type EntryVariant = "left" | "scale" | "right";

interface Pillar {
  icon: typeof Scale;
  number: string;
  title: string;
  headline: string;
  desc: string;
  bullets: string[];
  accent: string;
  iconColor: string;
  variant: EntryVariant;
}

const pillars: Pillar[] = [
  {
    icon: Scale,
    number: "01",
    title: "Conseil neutre",
    headline: "Indépendants, aucune compagnie derrière nous.",
    desc: "On ne pousse pas un produit pour toucher une commission. On vous dit ce qui est vraiment le mieux — même si ce n'est pas chez nous.",
    bullets: ["Inscription FINMA", "Aucun lien capitalistique", "Conseil écrit signé"],
    accent: "hsl(244 65% 50%)",
    iconColor: "hsl(244 80% 78%)",
    variant: "left",
  },
  {
    icon: Search,
    number: "02",
    title: "Comparaison honnête",
    headline: "Toutes les compagnies suisses, comparées en parallèle.",
    desc: "LAMal, complémentaires, 3ᵉ pilier, hypothèque, RC, auto, LPP. On regarde tout, on chiffre tout, on montre les écarts en clair.",
    bullets: ["50+ compagnies analysées", "Tableau comparatif détaillé", "Critères pondérés"],
    accent: "hsl(19 90% 54%)",
    iconColor: "hsl(19 95% 72%)",
    variant: "scale",
  },
  {
    icon: TrendingDown,
    number: "03",
    title: "Économies réelles",
    headline: "Vos primes baissent ou votre couverture monte. Souvent les deux.",
    desc: "On reprend vos contrats ligne par ligne. La moyenne ? +1'247 CHF économisés par an, sans perdre en garanties.",
    bullets: ["+1'247 CHF/an moyen", "0 perte de garantie", "Suivi annuel inclus"],
    accent: "hsl(160 70% 42%)",
    iconColor: "hsl(160 75% 65%)",
    variant: "right",
  },
];

const variantInitialTransform = (v: EntryVariant): string => {
  switch (v) {
    case "left":
      return "translateX(-80px) rotate(-2deg) scale(0.95)";
    case "right":
      return "translateX(80px) rotate(2deg) scale(0.95)";
    case "scale":
      return "translateY(20px) scale(0.85)";
  }
};

const PillarCard = ({ pillar, delay }: { pillar: Pillar; delay: number }) => {
  const { ref, visible } = useReveal<HTMLDivElement>({ threshold: 0.2 });
  const Icon = pillar.icon;

  const style: CSSProperties = {
    opacity: visible ? 1 : 0,
    transform: visible ? "translateX(0) translateY(0) rotate(0) scale(1)" : variantInitialTransform(pillar.variant),
    filter: visible ? "blur(0)" : "blur(6px)",
    transition: `opacity 900ms cubic-bezier(0.16,1,0.3,1) ${delay}ms,
                  transform 1100ms cubic-bezier(0.16,1,0.3,1) ${delay}ms,
                  filter 700ms ease-out ${delay}ms`,
    willChange: "transform, opacity, filter",
  };

  return (
    <div ref={ref} style={style}>
      <TiltCard
        className="block h-full rounded-2xl p-7 md:p-8"
        max={5}
        glowColor="240, 101, 31"
        style={{
          background: "linear-gradient(180deg, rgba(255,255,255,0.06) 0%, rgba(255,255,255,0.02) 100%)",
          backdropFilter: "blur(8px)",
          WebkitBackdropFilter: "blur(8px)",
          border: "1px solid rgba(255,255,255,0.10)",
        }}
      >
        <div className="flex items-start justify-between mb-7">
          <div
            className="w-12 h-12 rounded-xl flex items-center justify-center"
            style={{
              background: `${pillar.accent}22`,
              color: pillar.iconColor,
              border: `1px solid ${pillar.accent}40`,
            }}
          >
            <Icon className="w-6 h-6" strokeWidth={1.75} />
          </div>
          <span
            className="text-[11px] uppercase font-bold tracking-[0.18em]"
            style={{ color: "rgba(255,255,255,0.30)" }}
          >
            {pillar.number}
          </span>
        </div>
        <p className="text-2xl font-bold text-white mb-3 tracking-tight">{pillar.title}</p>
        <p className="text-[15px] font-medium text-white/80 mb-5 leading-snug">
          {pillar.headline}
        </p>
        <p className="text-sm text-white/55 leading-relaxed mb-6">
          {pillar.desc}
        </p>
        <ul className="space-y-2 pt-5" style={{ borderTop: "1px solid rgba(255,255,255,0.08)" }}>
          {pillar.bullets.map((b) => (
            <li key={b} className="flex items-center gap-2.5 text-sm text-white/70">
              <Check className="w-3.5 h-3.5 shrink-0" style={{ color: pillar.iconColor }} strokeWidth={2.5} />
              {b}
            </li>
          ))}
        </ul>
      </TiltCard>
    </div>
  );
};

export const SolutionSection = () => {
  return (
    <section
      id="solution"
      className="relative py-28 md:py-36 lg:py-44 overflow-hidden"
      style={{
        background: `
          radial-gradient(900px 600px at 85% -10%, rgba(240, 101, 31, 0.10) 0%, transparent 60%),
          linear-gradient(180deg, #14123F 0%, #0D0B40 60%, #0A0830 100%)
        `,
        color: "white",
      }}
    >
      <div
        aria-hidden
        className="absolute inset-x-0 bottom-0 pointer-events-none"
        style={{
          height: "60%",
          background: `radial-gradient(80% 60% at 50% 100%, rgba(58, 45, 136, 0.18) 0%, transparent 70%)`,
        }}
      />

      <div className="mx-auto max-w-7xl px-5 lg:px-8 relative z-[5]">
        <Reveal className="max-w-3xl mb-16 md:mb-20">
          <span className="kx-eyebrow mb-5" style={{ color: "hsl(var(--accent-soft))" }}>Notre approche</span>
          <ScrollRevealText as="h2" className="kx-display text-[2rem] sm:text-[2.5rem] lg:text-[3.5rem] mb-6 text-white" theme="light">
            Conseil neutre. Comparaison honnête.{" "}
            <span style={{ background: "linear-gradient(120deg, hsl(19 90% 60%) 0%, hsl(28 95% 70%) 100%)", WebkitBackgroundClip: "text", backgroundClip: "text", WebkitTextFillColor: "transparent" }}>
              Économies réelles.
            </span>
          </ScrollRevealText>
          <p className="text-lg leading-relaxed max-w-2xl text-white/70">
            Trois principes qui guident chaque dossier qu'on traite. Sans exception.
          </p>
        </Reveal>

        <div className="grid lg:grid-cols-3 gap-5 md:gap-6">
          {pillars.map((p, i) => (
            <PillarCard key={p.title} pillar={p} delay={i * 140} />
          ))}
        </div>

        <Reveal delay={400} className="mt-14 flex flex-col sm:flex-row items-start sm:items-center gap-4">
          <a href="#contact" onClick={(e) => { e.preventDefault(); document.querySelector("#contact")?.scrollIntoView({ behavior: "smooth" }); }}
             className="kx-btn kx-btn-accent">
            Démarrer mon analyse
            <ArrowRight className="w-4 h-4" />
          </a>
          <p className="text-sm text-white/55">Sans engagement, sans CB, sans piège.</p>
        </Reveal>
      </div>
    </section>
  );
};
