import { AlertCircle, FileText, Calculator } from "lucide-react";
import { Reveal } from "../Reveal";
import { TiltCard } from "../TiltCard";
import { ScrollRevealText } from "../ScrollRevealText";

const painPoints = [
  {
    icon: FileText,
    stat: "73%",
    title: "des Suisses paient trop cher",
    desc: "Sans le savoir. Primes maladie, 3ᵉ pilier, hypothèque — on rentre dans des contrats qu'on n'a jamais comparés.",
  },
  {
    icon: Calculator,
    stat: "5h+",
    title: "pour comparer manuellement",
    desc: "Et encore, sans avoir accès aux conditions négociées entre courtiers et compagnies. Le résultat : on choisit au pif.",
  },
  {
    icon: AlertCircle,
    stat: "1 sur 3",
    title: "n'est pas correctement couvert",
    desc: "Sous-assuré sur la prévoyance, sur-assuré sur la complémentaire. Personne n'a fait le tri pour vous.",
  },
];

export const ProblemSection = () => {
  return (
    <section id="problem" className="relative py-20 md:py-28 lg:py-32 bg-background">
      <div className="mx-auto max-w-7xl px-5 lg:px-8">
        <Reveal className="max-w-3xl mb-14 md:mb-20">
          <span className="kx-eyebrow mb-5">Le constat</span>
          <ScrollRevealText as="h2" className="kx-display text-[2rem] sm:text-[2.5rem] lg:text-[3.25rem] mb-6" theme="dark">
            L'assurance en Suisse, c'est{" "}
            <span className="kx-display-gradient">une jungle.</span>
          </ScrollRevealText>
          <p className="text-lg leading-relaxed max-w-2xl" style={{ color: "hsl(var(--foreground-soft))" }}>
            Des dizaines de compagnies. Des centaines de produits. Des conditions qui changent
            chaque année. Et personne pour vous dire la vérité — parce que tout le monde y a
            un intérêt financier.
          </p>
        </Reveal>

        <div className="grid md:grid-cols-3 gap-5 md:gap-6">
          {painPoints.map((p, i) => {
            const Icon = p.icon;
            return (
              <Reveal key={p.title} delay={i * 100}>
                <TiltCard className="kx-card block h-full" max={5}>
                  <div className="w-11 h-11 rounded-xl bg-[hsl(var(--accent-light))] flex items-center justify-center mb-5">
                    <Icon className="w-5 h-5 text-[hsl(var(--accent))]" />
                  </div>
                  <p className="text-3xl md:text-[2.25rem] font-bold text-foreground leading-none tabular-nums mb-2 tracking-tight">
                    {p.stat}
                  </p>
                  <p className="text-lg font-semibold text-foreground mb-3 leading-snug">
                    {p.title}
                  </p>
                  <p className="text-sm leading-relaxed" style={{ color: "hsl(var(--muted-text))" }}>
                    {p.desc}
                  </p>
                </TiltCard>
              </Reveal>
            );
          })}
        </div>
      </div>
    </section>
  );
};
