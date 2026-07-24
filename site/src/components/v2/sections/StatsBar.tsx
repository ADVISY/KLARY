import { useCountUp } from "../hooks/useCountUp";

const stats = [
  { to: 1247, decimals: 0, prefix: "+ ", suffix: " CHF", label: "Économies moyennes / an", pulse: "accent" as const },
  { to: 2500, decimals: 0, prefix: "", suffix: "+",     label: "Clients accompagnés",     pulse: "navy" as const },
  { to: 4.8,  decimals: 1, prefix: "", suffix: "/5",    label: "Note moyenne",             pulse: "violet" as const },
  { to: 15,   decimals: 0, prefix: "", suffix: " min",  label: "Pour une analyse complète", pulse: "accent" as const },
  { to: 100,  decimals: 0, prefix: "", suffix: "%",     label: "Indépendant & gratuit",    pulse: "navy" as const },
];

const StatValue = ({ to, decimals, prefix, suffix }: { to: number; decimals: number; prefix: string; suffix: string }) => {
  const formatter = (n: number) => {
    const fixed = n.toFixed(decimals);
    const [intPart, decPart] = fixed.split(".");
    const formattedInt = intPart.replace(/\B(?=(\d{3})+(?!\d))/g, "'");
    return decPart ? `${prefix}${formattedInt},${decPart}${suffix}` : `${prefix}${formattedInt}${suffix}`;
  };

  const { ref, formatted } = useCountUp({ end: to, decimals, formatter, duration: 1800 });

  return (
    <span
      ref={ref}
      className="tabular-nums"
      style={{
        background: "linear-gradient(135deg, hsl(19 90% 54%) 0%, hsl(28 95% 65%) 100%)",
        WebkitBackgroundClip: "text",
        backgroundClip: "text",
        WebkitTextFillColor: "transparent",
      }}
    >
      {formatted}
    </span>
  );
};

export const StatsBar = () => {
  return (
    <section id="stats" className="relative py-20 md:py-28 bg-background">
      <div className="mx-auto max-w-7xl px-5 lg:px-8">
        <div className="grid grid-cols-2 md:grid-cols-5 gap-y-10 gap-x-4">
          {stats.map((s) => (
            <div
              key={s.label}
              className="text-center md:text-left md:border-r md:border-neutral-light md:last:border-r-0 md:px-6 md:first:pl-0"
            >
              <p
                className="font-extrabold leading-none tracking-tight"
                style={{ fontSize: "clamp(1.75rem, 3.2vw, 2.75rem)", letterSpacing: "-0.03em" }}
              >
                <StatValue to={s.to} decimals={s.decimals} prefix={s.prefix} suffix={s.suffix} />
              </p>
              <p className="text-xs md:text-sm font-medium mt-3 flex items-center md:items-baseline gap-2 justify-center md:justify-start" style={{ color: "hsl(var(--muted-text))" }}>
                <span
                  aria-hidden
                  className={`kx-pulse-dot ${s.pulse === "navy" ? "kx-pulse-dot-navy" : s.pulse === "violet" ? "kx-pulse-dot-violet" : ""}`}
                />
                {s.label}
              </p>
            </div>
          ))}
        </div>
      </div>
    </section>
  );
};
