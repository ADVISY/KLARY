import { useEffect, useRef, useState } from "react";
import { Check, ArrowRight, TrendingUp } from "lucide-react";

/* ───────────────── Visuals per pole ───────────────── */

// FINANCE — slow animated countdown-style number tween between target values
const FinanceVisual = () => {
  const targets = [4.7, 4.3, 4.9, 5.1, 4.8, 5.3, 4.6, 5.0];
  const [value, setValue] = useState(targets[0]);
  const idxRef = useRef(0);

  useEffect(() => {
    let raf: number;
    const holdMs = 1800;
    const tweenMs = 1600;
    let phaseStart = performance.now();
    let from = targets[0];
    let to = targets[1 % targets.length];
    let phase: "hold" | "tween" = "hold";

    const easeInOut = (t: number) =>
      t < 0.5 ? 2 * t * t : 1 - Math.pow(-2 * t + 2, 2) / 2;

    const tick = (now: number) => {
      const elapsed = now - phaseStart;
      if (phase === "hold") {
        setValue(from);
        if (elapsed >= holdMs) {
          phase = "tween";
          phaseStart = now;
        }
      } else {
        const t = Math.min(1, elapsed / tweenMs);
        setValue(from + (to - from) * easeInOut(t));
        if (t >= 1) {
          phase = "hold";
          phaseStart = now;
          idxRef.current = (idxRef.current + 1) % targets.length;
          from = to;
          to = targets[(idxRef.current + 1) % targets.length];
        }
      }
      raf = requestAnimationFrame(tick);
    };
    raf = requestAnimationFrame(tick);
    return () => cancelAnimationFrame(raf);
  }, []);

  return (
    <div className="flex items-center justify-center w-full py-6">
      <div className="flex items-baseline gap-1.5">
        <TrendingUp className="w-7 h-7 text-primary-light mr-1 self-center" strokeWidth={2.5} />
        <span className="text-primary-light text-4xl md:text-5xl font-light leading-none">+</span>
        <span className="affirm-display text-5xl md:text-6xl text-foreground tabular-nums leading-none">
          {value.toFixed(1)}
        </span>
        <span className="text-foreground text-3xl md:text-4xl font-light leading-none">%</span>
      </div>
    </div>
  );
};

// PRÉVOYANCE — slide-to-confirm button
const PrevoyanceVisual = () => {
  const [pos, setPos] = useState(0); // 0 → 1
  const [confirmed, setConfirmed] = useState(false);
  const trackRef = useRef<HTMLDivElement>(null);
  const [trackW, setTrackW] = useState(0);
  const knobSize = 48; // 3rem
  const padding = 4; // 0.25rem each side

  useEffect(() => {
    if (!trackRef.current) return;
    const ro = new ResizeObserver((entries) => {
      setTrackW(entries[0].contentRect.width);
    });
    ro.observe(trackRef.current);
    return () => ro.disconnect();
  }, []);

  useEffect(() => {
    let raf: number;
    let start: number | null = null;
    const cycle = 5200;
    const easeInOut = (t: number) =>
      t < 0.5 ? 2 * t * t : 1 - Math.pow(-2 * t + 2, 2) / 2;

    const tick = (now: number) => {
      if (start === null) start = now;
      const elapsed = (now - start) % cycle;
      const phase = elapsed / cycle;
      let p = 0;
      if (phase < 0.45) p = easeInOut(phase / 0.45);
      else if (phase < 0.65) p = 1;
      else if (phase < 0.85) p = 1 - easeInOut((phase - 0.65) / 0.2);
      else p = 0;
      setPos(p);
      setConfirmed(phase >= 0.45 && phase < 0.65);
      raf = requestAnimationFrame(tick);
    };
    raf = requestAnimationFrame(tick);
    return () => cancelAnimationFrame(raf);
  }, []);

  const maxX = Math.max(0, trackW - knobSize - padding * 2);

  return (
    <div className="w-full py-4">
      <div
        ref={trackRef}
        className="relative h-14 rounded-full bg-white/[0.04] border border-white/10 overflow-hidden"
      >
        {/* progress fill */}
        <div
          className="absolute inset-y-0 left-0 bg-primary/25"
          style={{ width: `${pos * 100}%` }}
        />
        {/* label */}
        <div className="absolute inset-0 flex items-center justify-center pointer-events-none">
          <span
            className="text-body-sm text-muted-foreground font-light transition-opacity duration-300"
            style={{ opacity: confirmed ? 0.75 : 1 }}
          >
            {confirmed ? "Confirmé" : "Glisser pour protéger"}
          </span>
        </div>
        {/* knob */}
        <div
          className="absolute top-1 h-12 w-12 rounded-full bg-primary flex items-center justify-center shadow-[0_0_20px_hsl(var(--primary)/0.6)] will-change-transform"
          style={{
            left: `${padding}px`,
            transform: `translate3d(${pos * maxX}px, 0, 0)`,
          }}
        >
          {confirmed ? (
            <Check className="w-5 h-5 text-primary-foreground" strokeWidth={3} />
          ) : (
            <ArrowRight className="w-5 h-5 text-primary-foreground" strokeWidth={2.5} />
          )}
        </div>
      </div>
    </div>
  );
};

// ASSURANCE — stacked notifications, new one drops on top, older ones recede behind
const NOTIFS = [
  { title: "Remboursement reçu", body: "CHF 248.50 crédités sur votre compte" },
  { title: "Facture validée", body: "Médecin généraliste — CHF 120.00" },
  { title: "Police mise à jour", body: "Assurance ménage renouvelée" },
  { title: "Sinistre traité", body: "Dossier #4821 — résolu en 48h" },
  { title: "Devis prêt", body: "3ᵉ pilier — économie estimée CHF 1'420/an" },
];

const AssuranceVisual = () => {
  const [top, setTop] = useState(0);

  useEffect(() => {
    const t = setInterval(() => setTop((i) => (i + 1) % NOTIFS.length), 2600);
    return () => clearInterval(t);
  }, []);

  const visible = [0, 1, 2].map((offset) => {
    const i = (top + offset) % NOTIFS.length;
    return { ...NOTIFS[i], offset, key: i };
  });

  return (
    <div className="relative w-full h-[96px]">
      {visible
        .slice()
        .reverse()
        .map(({ title, body, offset, key }) => {
          const scale = 1 - offset * 0.06;
          const translateY = offset * 10;
          const opacity = offset === 0 ? 1 : offset === 1 ? 0.55 : 0.25;
          return (
            <div
              key={key}
              className="absolute inset-x-0 top-0 rounded-2xl bg-white/[0.06] border border-white/10 backdrop-blur-md p-3.5 flex items-center gap-3"
              style={{
                transform: `translateY(${translateY}px) scale(${scale})`,
                opacity,
                zIndex: 10 - offset,
                transition:
                  "transform 600ms cubic-bezier(0.22, 1, 0.36, 1), opacity 600ms ease",
                boxShadow:
                  offset === 0
                    ? "0 14px 34px -12px hsl(252 80% 30% / 0.5)"
                    : "0 6px 18px -10px hsl(252 80% 30% / 0.3)",
              }}
            >
              <div className="w-10 h-10 rounded-xl bg-primary/20 border border-primary/30 flex items-center justify-center flex-shrink-0">
                <Check className="w-5 h-5 text-primary-light" strokeWidth={2.5} />
              </div>
              <div className="flex-1 min-w-0">
                <div className="flex items-center justify-between gap-2">
                  <p className="text-xs font-medium text-foreground truncate">
                    {title}
                  </p>
                  <span className="text-[10px] text-muted-foreground/70 flex-shrink-0">
                    maintenant
                  </span>
                </div>
                <p className="text-xs text-muted-foreground font-light truncate">
                  {body}
                </p>
              </div>
            </div>
          );
        })}
    </div>
  );
};

/* ───────────────── Section ───────────────── */

const poles = [
  {
    title: "Assurance",
    description:
      "Santé, RC, ménage, auto, protection juridique — comparez et optimisez vos couvertures.",
    Visual: AssuranceVisual,
  },
  {
    title: "Prévoyance",
    description:
      "2ᵉ et 3ᵉ pilier, LPP, planification retraite — sécurisez votre avenir avec un avantage fiscal.",
    Visual: PrevoyanceVisual,
  },
  {
    title: "Finance",
    description:
      "Hypothèque, épargne, investissement — structurez votre patrimoine avec un conseil indépendant.",
    Visual: FinanceVisual,
  },
];

export const PoleCardsSection = ({ embedded = false }: { embedded?: boolean }) => {
  const grid = (
    <div className="grid grid-cols-1 md:grid-cols-3 gap-6 lg:gap-8 max-w-6xl mx-auto">
      {poles.map((pole, i) => {
        const Visual = pole.Visual;
        return (
          <article
            key={pole.title}
            className="pole-card group animate-slide-up"
            style={{ animationDelay: `${i * 120}ms` }}
          >
            <div aria-hidden className="pole-card-border" />
            <div className="pole-card-inner">
              <div className="mb-8 min-h-[110px] flex items-center">
                <Visual />
              </div>
              <h3 className="text-heading-2 md:text-heading-1 affirm-display mb-4 text-foreground">
                {pole.title}
              </h3>
              <p className="text-body text-muted-foreground font-light leading-relaxed">
                {pole.description}
              </p>
            </div>
          </article>
        );
      })}
    </div>
  );

  if (embedded) return grid;

  return (
    <section className="relative pt-section lg:pt-section-lg pb-section lg:pb-section-lg overflow-hidden">
      <div className="absolute top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2 w-[1100px] h-[500px] bg-primary/[0.07] rounded-full blur-[200px] pointer-events-none" />
      <div className="container relative z-10 mx-auto px-4 lg:px-8">
        <div className="text-center mb-16 max-w-3xl mx-auto">
          <div className="section-badge mb-6">Nos pôles d'expertise</div>
          <h2 className="text-display-sm md:text-display-md affirm-display mb-6">
            Trois piliers,<br />une vision globale
          </h2>
          <p className="text-body-lg text-muted-foreground font-light">
            Une approche intégrée pour protéger, préparer et faire fructifier votre patrimoine.
          </p>
        </div>
        {grid}
      </div>
    </section>
  );
};
