import { useEffect, useState } from "react";
import { TrendingDown } from "lucide-react";
import { useCountUp } from "../hooks/useCountUp";

const START = 3_124_500;        // CHF cumulés économisés (fictif mais réaliste)
const TICK_MS = 1800;            // toutes les 1.8s
const INC_RANGE = [12, 47];      // gain par tick

export const LiveSavingsCounter = () => {
  const [val, setVal] = useState(START);

  // Animated count-up on first reveal (from START - 20'000 to START)
  const { ref, formatted } = useCountUp({
    end: START,
    start: START - 20000,
    duration: 2200,
    decimals: 0,
    formatter: (n) => Math.round(n).toLocaleString("fr-CH").replace(/,/g, "'"),
  });

  // After reveal, keep ticking up
  useEffect(() => {
    const t = setInterval(() => {
      const inc = Math.floor(Math.random() * (INC_RANGE[1] - INC_RANGE[0]) + INC_RANGE[0]);
      setVal((v) => v + inc);
    }, TICK_MS);
    return () => clearInterval(t);
  }, []);

  return (
    <section className="relative py-12 md:py-16 overflow-hidden border-y border-neutral-light/60 bg-gradient-to-r from-[hsl(28_100%_96%)] via-white to-[hsl(28_100%_96%)]">
      <div className="mx-auto max-w-7xl px-5 lg:px-8">
        <div className="flex flex-col md:flex-row items-center justify-center gap-6 md:gap-10">
          <div className="flex items-center gap-3.5">
            <span className="relative inline-flex w-3 h-3">
              <span className="absolute inset-0 rounded-full bg-[hsl(160_70%_42%)] animate-ping opacity-75" />
              <span className="relative w-3 h-3 rounded-full bg-[hsl(160_70%_42%)]" />
            </span>
            <p className="text-[11px] md:text-xs uppercase tracking-[0.18em] font-bold" style={{ color: "hsl(var(--muted-text))" }}>
              Live · Économies cumulées clients Klary
            </p>
          </div>

          <p
            ref={ref}
            className="text-3xl md:text-4xl lg:text-5xl font-bold text-foreground tabular-nums tracking-tight flex items-baseline gap-2"
          >
            <TrendingDown className="w-6 h-6 md:w-7 md:h-7" style={{ color: "hsl(var(--accent))" }} />
            <span>{val.toLocaleString("fr-CH").replace(/,/g, "'")}</span>
            <span className="text-lg md:text-xl font-semibold" style={{ color: "hsl(var(--muted-text))" }}>CHF</span>
          </p>
        </div>
      </div>
    </section>
  );
};
