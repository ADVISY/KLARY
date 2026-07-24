import { CSSProperties } from "react";
import { PhoneCall, ListChecks, FileBarChart, BadgeCheck, ArrowRight } from "lucide-react";
import { Reveal } from "../Reveal";
import { useReveal } from "../hooks/useReveal";
import { ScrollRevealText } from "../ScrollRevealText";

interface Step {
  n: string;
  icon: typeof PhoneCall;
  title: string;
  desc: string;
  duration: string;
  bullets: string[];
  accentHue: number;
}

const steps: Step[] = [
  {
    n: "01",
    icon: PhoneCall,
    title: "Vous prenez 15 minutes.",
    desc: "Un appel ou un café (Lausanne, Genève, Fribourg, ou en visio). On comprend votre situation, vos contrats actuels, vos objectifs.",
    duration: "15 min",
    bullets: ["Sans engagement", "Conseiller dédié", "Café offert si présentiel"],
    accentHue: 244,
  },
  {
    n: "02",
    icon: ListChecks,
    title: "On analyse tout.",
    desc: "Vos contrats sont scannés ligne par ligne, comparés à l'offre actuelle des 50+ compagnies suisses. On chiffre chaque écart.",
    duration: "48-72h",
    bullets: ["50+ compagnies comparées", "Critères pondérés santé/finance", "Tableau Excel partagé"],
    accentHue: 19,
  },
  {
    n: "03",
    icon: FileBarChart,
    title: "On vous montre les options.",
    desc: "Pas de jargon. Un PDF clair : ce que vous payez aujourd'hui, ce que vous pourriez payer, les écarts en CHF, les choix.",
    duration: "30 min",
    bullets: ["Rapport PDF signé", "Économies chiffrées", "Plusieurs scénarios"],
    accentHue: 28,
  },
  {
    n: "04",
    icon: BadgeCheck,
    title: "Vous décidez. On exécute.",
    desc: "Vous gardez la main. Si vous changez, on gère 100% des résiliations et souscriptions. Vous n'envoyez aucun courrier.",
    duration: "0 paperasse",
    bullets: ["Résiliations gérées", "Suivi annuel inclus", "Aucun courrier de votre part"],
    accentHue: 160,
  },
];

const StepRow = ({ step, index, total }: { step: Step; index: number; total: number }) => {
  const { ref, visible } = useReveal<HTMLDivElement>({ threshold: 0.25, rootMargin: "0px 0px -10% 0px" });
  const Icon = step.icon;
  const isEven = index % 2 === 0;

  const enterStyle: CSSProperties = {
    opacity: visible ? 1 : 0,
    transform: visible
      ? "translateX(0) scale(1)"
      : `translateX(${isEven ? -60 : 60}px) scale(0.96)`,
    filter: visible ? "blur(0)" : "blur(6px)",
    transition:
      "opacity 800ms cubic-bezier(0.16,1,0.3,1), transform 900ms cubic-bezier(0.16,1,0.3,1), filter 600ms ease-out",
    willChange: "transform, opacity, filter",
  };

  const numberStyle: CSSProperties = {
    background: `linear-gradient(135deg, hsl(${step.accentHue} 90% 55%) 0%, hsl(${step.accentHue} 70% 45%) 100%)`,
    WebkitBackgroundClip: "text",
    backgroundClip: "text",
    WebkitTextFillColor: "transparent",
  };

  return (
    <div ref={ref} className="relative" style={enterStyle}>
      {/* Vertical connector line — sauf sur le dernier */}
      {index < total - 1 && (
        <div
          aria-hidden
          className="absolute left-[28px] md:left-[40px] top-[88px] md:top-[112px] w-[2px]"
          style={{
            height: "calc(100% + 1.5rem)",
            background: `linear-gradient(180deg, hsl(${step.accentHue} 70% 60%) 0%, hsl(${steps[index + 1].accentHue} 70% 60%) 100%)`,
            opacity: visible ? 0.35 : 0,
            transition: "opacity 1.2s ease-out 300ms",
          }}
        />
      )}

      <div className="relative flex gap-5 md:gap-8">
        {/* Icon + number column */}
        <div className="shrink-0 relative">
          <div
            className="w-14 h-14 md:w-20 md:h-20 rounded-2xl flex items-center justify-center shadow-sm"
            style={{
              background: `linear-gradient(135deg, hsl(${step.accentHue} 80% 96%) 0%, hsl(${step.accentHue} 80% 92%) 100%)`,
              border: `1px solid hsl(${step.accentHue} 60% 85%)`,
              color: `hsl(${step.accentHue} 75% 42%)`,
            }}
          >
            <Icon className="w-6 h-6 md:w-9 md:h-9" strokeWidth={1.75} />
          </div>
          {/* Small ping dot */}
          <span
            aria-hidden
            className="absolute -top-1 -right-1 flex"
            style={{ opacity: visible ? 1 : 0, transition: "opacity 600ms ease 800ms" }}
          >
            <span
              className="absolute inset-0 rounded-full animate-ping"
              style={{ background: `hsl(${step.accentHue} 80% 60% / 0.6)` }}
            />
            <span
              className="relative w-3 h-3 rounded-full"
              style={{ background: `hsl(${step.accentHue} 80% 55%)` }}
            />
          </span>
        </div>

        {/* Content card */}
        <div
          className="flex-1 rounded-2xl bg-white border border-neutral-light/60 p-6 md:p-8 transition-shadow hover:shadow-lg"
          style={{ boxShadow: visible ? "0 1px 3px rgba(16,14,47,0.04)" : "none" }}
        >
          <div className="flex items-baseline justify-between gap-4 mb-3 flex-wrap">
            <span
              className="text-[10px] md:text-xs uppercase font-bold tracking-[0.20em]"
              style={{ color: `hsl(${step.accentHue} 75% 42%)` }}
            >
              Étape {step.n}
            </span>
            <span
              className="text-[10px] md:text-xs font-semibold uppercase tracking-[0.16em] px-2.5 py-1 rounded-full"
              style={{
                background: `hsl(${step.accentHue} 70% 95%)`,
                color: `hsl(${step.accentHue} 70% 35%)`,
                border: `1px solid hsl(${step.accentHue} 60% 85%)`,
              }}
            >
              {step.duration}
            </span>
          </div>
          <h3 className="text-xl md:text-2xl font-bold text-foreground mb-3 leading-tight tracking-tight">
            <span className="mr-2 align-baseline text-3xl md:text-5xl font-extrabold opacity-90" style={numberStyle}>
              {step.n}
            </span>
            {step.title}
          </h3>
          <p className="text-[15px] md:text-base leading-relaxed mb-5" style={{ color: "hsl(var(--foreground-soft))" }}>
            {step.desc}
          </p>
          <ul className="flex flex-wrap gap-2">
            {step.bullets.map((b) => (
              <li
                key={b}
                className="text-[12px] md:text-[13px] font-medium px-3 py-1.5 rounded-full inline-flex items-center gap-1.5"
                style={{
                  background: `hsl(${step.accentHue} 70% 97%)`,
                  color: `hsl(${step.accentHue} 80% 28%)`,
                  border: `1px solid hsl(${step.accentHue} 70% 90%)`,
                }}
              >
                <span
                  aria-hidden
                  className="w-1.5 h-1.5 rounded-full"
                  style={{ background: `hsl(${step.accentHue} 75% 50%)` }}
                />
                {b}
              </li>
            ))}
          </ul>
        </div>
      </div>
    </div>
  );
};

export const ProcessSection = () => {
  return (
    <section id="process" className="relative py-24 md:py-32 overflow-hidden bg-background">
      <div className="mx-auto max-w-7xl px-5 lg:px-8 relative">
        <Reveal className="max-w-3xl mb-14 md:mb-20">
          <span className="kx-eyebrow mb-5">Comment ça marche</span>
          <ScrollRevealText as="h2" className="kx-display text-[2rem] sm:text-[2.5rem] lg:text-[3rem] mb-5" theme="dark">
            4 étapes. <span className="kx-display-gradient">Zéro paperasse.</span>
          </ScrollRevealText>
          <p className="text-lg leading-relaxed max-w-2xl" style={{ color: "hsl(var(--foreground-soft))" }}>
            De l'appel découverte à la mise en place des nouveaux contrats. Vous ne touchez à rien.
          </p>
        </Reveal>

        {/* Vertical timeline */}
        <div className="max-w-4xl mx-auto space-y-8 md:space-y-12">
          {steps.map((s, i) => (
            <StepRow key={s.n} step={s} index={i} total={steps.length} />
          ))}
        </div>

        <Reveal delay={300} className="mt-16 md:mt-20 max-w-4xl mx-auto flex flex-col sm:flex-row items-start sm:items-center gap-4">
          <a
            href="#contact"
            onClick={(e) => { e.preventDefault(); document.querySelector("#contact")?.scrollIntoView({ behavior: "smooth" }); }}
            className="kx-btn kx-btn-accent"
          >
            Commencer maintenant
            <ArrowRight className="w-4 h-4" />
          </a>
          <p className="text-sm" style={{ color: "hsl(var(--foreground-soft))" }}>
            Premier appel offert, sans engagement.
          </p>
        </Reveal>
      </div>
    </section>
  );
};
