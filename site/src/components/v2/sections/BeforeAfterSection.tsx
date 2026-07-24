import { useEffect, useRef, useState } from "react";
import { ArrowRight, X, Check, TrendingDown } from "lucide-react";
import { Reveal } from "../Reveal";
import { ScrollRevealText } from "../ScrollRevealText";

const beforeData = {
  label: "Avant Klary",
  prime: "4'248",
  franchise: "300.-",
  modele: "Libre choix",
  flags: [
    { ok: false, text: "Doublons sur la complémentaire hospitalisation" },
    { ok: false, text: "Franchise basse alors que vous consultez 2× / an" },
    { ok: false, text: "Compagnie B+ avec sinistralité élevée" },
  ],
  bgFrom: "hsl(0 60% 96%)",
  bgTo: "hsl(0 50% 92%)",
  border: "hsl(0 60% 85%)",
  accent: "hsl(0 75% 55%)",
};

const afterData = {
  label: "Avec Klary",
  prime: "3'064",
  franchise: "2'500.-",
  modele: "Médecin de famille",
  flags: [
    { ok: true, text: "Complémentaire hospitalisation chez Helvetia (A+)" },
    { ok: true, text: "Franchise optimisée pour votre profil santé" },
    { ok: true, text: "Modèle médecin = -18% sur la prime de base" },
  ],
  bgFrom: "hsl(160 50% 96%)",
  bgTo: "hsl(160 40% 92%)",
  border: "hsl(160 50% 80%)",
  accent: "hsl(160 70% 38%)",
};

export const BeforeAfterSection = () => {
  const [pos, setPos] = useState(50); // % position of the drag handle (0=all before, 100=all after)
  const containerRef = useRef<HTMLDivElement | null>(null);
  const dragging = useRef(false);

  useEffect(() => {
    const onMove = (e: MouseEvent | TouchEvent) => {
      if (!dragging.current || !containerRef.current) return;
      const rect = containerRef.current.getBoundingClientRect();
      const clientX = "touches" in e ? e.touches[0].clientX : (e as MouseEvent).clientX;
      const x = clientX - rect.left;
      setPos(Math.max(0, Math.min(100, (x / rect.width) * 100)));
    };
    const stop = () => { dragging.current = false; };
    window.addEventListener("mousemove", onMove);
    window.addEventListener("mouseup", stop);
    window.addEventListener("touchmove", onMove, { passive: true });
    window.addEventListener("touchend", stop);
    return () => {
      window.removeEventListener("mousemove", onMove);
      window.removeEventListener("mouseup", stop);
      window.removeEventListener("touchmove", onMove);
      window.removeEventListener("touchend", stop);
    };
  }, []);

  const start = () => { dragging.current = true; };

  // Compute the savings amount
  const savedYear = 4248 - 3064;

  return (
    <section id="comparaison" className="relative py-24 md:py-32 bg-background">
      <div className="mx-auto max-w-7xl px-5 lg:px-8">
        <Reveal className="max-w-3xl mb-12 md:mb-16">
          <span className="kx-eyebrow mb-5">Glissez pour comparer</span>
          <ScrollRevealText as="h2" className="kx-display text-[2rem] sm:text-[2.5rem] lg:text-[3rem] mb-5" theme="dark">
            Voici ce que <span className="kx-display-gradient">Klary change</span>.
          </ScrollRevealText>
          <p className="text-lg leading-relaxed max-w-2xl" style={{ color: "hsl(var(--foreground-soft))" }}>
            Cas réel anonymisé d'un client de 34 ans, Lausanne, en bonne santé. Faites glisser le curseur
            pour voir ce que nous avons changé sur son contrat d'assurance maladie.
          </p>
        </Reveal>

        <Reveal>
          <div
            ref={containerRef}
            className="relative w-full rounded-[2rem] overflow-hidden border border-neutral-light bg-white select-none"
            style={{ minHeight: 460 }}
          >
            {/* AFTER layer (full) */}
            <BeforeAfterCard data={afterData} />

            {/* BEFORE layer (clipped from right by pos) */}
            <div
              className="absolute inset-0"
              style={{ clipPath: `inset(0 ${100 - pos}% 0 0)` }}
            >
              <BeforeAfterCard data={beforeData} />
            </div>

            {/* Drag handle */}
            <div
              className="absolute top-0 bottom-0 cursor-ew-resize z-20"
              style={{ left: `${pos}%`, transform: "translateX(-50%)" }}
              onMouseDown={start}
              onTouchStart={start}
            >
              <div className="absolute top-0 bottom-0 left-1/2 -translate-x-1/2 w-[2px] bg-foreground" />
              <div className="absolute top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2 w-12 h-12 rounded-full bg-foreground text-background shadow-strong flex items-center justify-center"
                   style={{ boxShadow: "0 8px 24px -8px rgba(0,0,0,0.4), 0 0 0 6px rgba(255,255,255,0.6)" }}>
                <div className="flex items-center gap-0.5">
                  <svg width="10" height="14" viewBox="0 0 10 14" fill="none">
                    <path d="M6 1 L1 7 L6 13" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round" fill="none" />
                  </svg>
                  <svg width="10" height="14" viewBox="0 0 10 14" fill="none">
                    <path d="M4 1 L9 7 L4 13" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round" fill="none" />
                  </svg>
                </div>
              </div>

              {/* Side labels */}
              <div
                className="absolute top-5 right-3 text-[10px] uppercase tracking-[0.18em] font-bold whitespace-nowrap"
                style={{ color: afterData.accent }}
              >
                APRÈS →
              </div>
              <div
                className="absolute top-5 left-3 text-[10px] uppercase tracking-[0.18em] font-bold whitespace-nowrap"
                style={{ color: beforeData.accent, transform: "translateX(-100%)" }}
              >
                ← AVANT
              </div>
            </div>

            {/* Savings badge */}
            <div className="absolute bottom-5 right-5 z-30 px-5 py-3 rounded-2xl bg-white shadow-medium border border-neutral-light flex items-center gap-3">
              <div className="w-10 h-10 rounded-xl bg-[hsl(160_70%_42%/0.12)] flex items-center justify-center">
                <TrendingDown className="w-5 h-5" style={{ color: "hsl(160 70% 42%)" }} />
              </div>
              <div>
                <p className="text-[10px] uppercase tracking-wider font-bold" style={{ color: "hsl(var(--muted-text))" }}>
                  Économie réelle / an
                </p>
                <p className="text-xl font-bold text-foreground tabular-nums leading-none mt-0.5">
                  - {savedYear.toLocaleString("fr-CH").replace(/,/g, "'")} CHF
                </p>
              </div>
            </div>
          </div>
        </Reveal>

        <Reveal delay={200} className="mt-10 flex flex-col sm:flex-row items-start sm:items-center gap-4">
          <a
            href="#contact"
            onClick={(e) => { e.preventDefault(); document.querySelector("#contact")?.scrollIntoView({ behavior: "smooth" }); }}
            className="kx-btn kx-btn-accent"
          >
            Voir mon économie estimée
            <ArrowRight className="w-4 h-4" />
          </a>
          <p className="text-sm" style={{ color: "hsl(var(--muted-text))" }}>
            Analyse gratuite · résultat sous 72h
          </p>
        </Reveal>
      </div>
    </section>
  );
};

const BeforeAfterCard = ({
  data,
}: {
  data: typeof beforeData | typeof afterData;
}) => {
  return (
    <div
      className="w-full p-7 md:p-10"
      style={{
        background: `linear-gradient(135deg, ${data.bgFrom} 0%, ${data.bgTo} 100%)`,
        minHeight: 460,
      }}
    >
      <div className="flex items-center gap-3 mb-6">
        <span
          className="text-[10px] uppercase tracking-[0.18em] font-bold px-3 py-1 rounded-full"
          style={{ background: `${data.accent}1A`, color: data.accent }}
        >
          {data.label}
        </span>
      </div>

      <div className="grid sm:grid-cols-3 gap-4 mb-8">
        <div>
          <p className="text-[10px] uppercase tracking-wider font-bold mb-1.5" style={{ color: "hsl(var(--muted-text))" }}>
            Prime annuelle
          </p>
          <p className="text-3xl md:text-4xl font-bold text-foreground tabular-nums tracking-tight">
            {data.prime} <span className="text-base font-medium" style={{ color: "hsl(var(--muted-text))" }}>CHF</span>
          </p>
        </div>
        <div>
          <p className="text-[10px] uppercase tracking-wider font-bold mb-1.5" style={{ color: "hsl(var(--muted-text))" }}>
            Franchise
          </p>
          <p className="text-3xl md:text-4xl font-bold text-foreground tabular-nums tracking-tight">
            {data.franchise}
          </p>
        </div>
        <div>
          <p className="text-[10px] uppercase tracking-wider font-bold mb-1.5" style={{ color: "hsl(var(--muted-text))" }}>
            Modèle
          </p>
          <p className="text-xl md:text-2xl font-bold text-foreground tracking-tight">
            {data.modele}
          </p>
        </div>
      </div>

      <div className="space-y-3">
        {data.flags.map((f, i) => (
          <div key={i} className="flex items-start gap-3">
            <span
              className="w-6 h-6 rounded-full flex items-center justify-center shrink-0 mt-0.5"
              style={{ background: f.ok ? "hsl(160 70% 42% / 0.15)" : "hsl(0 75% 55% / 0.15)" }}
            >
              {f.ok ? (
                <Check className="w-3.5 h-3.5" style={{ color: "hsl(160 70% 38%)" }} />
              ) : (
                <X className="w-3.5 h-3.5" style={{ color: "hsl(0 75% 55%)" }} />
              )}
            </span>
            <p className="text-sm md:text-base text-foreground/85 leading-relaxed">{f.text}</p>
          </div>
        ))}
      </div>
    </div>
  );
};
