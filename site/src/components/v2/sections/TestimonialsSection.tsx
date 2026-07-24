import { useEffect, useRef, useState } from "react";
import { Reveal } from "../Reveal";
import { ChevronLeft, ChevronRight } from "lucide-react";
import { ScrollRevealText } from "../ScrollRevealText";

const testimonials = [
  {
    quote: "On payait 4'200 CHF/an d'assurance maladie sans savoir qu'on était en double sur la complémentaire. Klary a tout remis à plat. On économise 850 CHF/an et on est mieux couverts.",
    name: "Hugo L.",
    role: "Employé, Lausanne",
    saving: "850 CHF/an",
  },
  {
    quote: "J'ai monté ma boîte sans rien comprendre à la LPP. Le conseiller m'a expliqué clairement, comparé 8 caisses, et on a signé avec celle qui correspondait. Aucun blabla commercial.",
    name: "Karim A.",
    role: "Entrepreneur, Valais",
    saving: "12 % sur LPP",
  },
  {
    quote: "Ma 3e pilier était dans une assurance vie depuis 2014. On l'a transférée sur du fonds, j'ai récupéré la maîtrise du capital et la déduction fiscale est la même. J'aurais dû le faire bien avant.",
    name: "Sophie M.",
    role: "Indépendante, Genève",
    saving: "Rendement x2.4",
  },
  {
    quote: "Je suis passé chez Klary après 10 ans chez le même courtier. Première fois qu'on me dit honnêtement où je peux économiser ET où je suis sous-couvert. Du conseil, pas de la vente.",
    name: "Marc D.",
    role: "Cadre, Fribourg",
    saving: "1'120 CHF/an",
  },
  {
    quote: "L'analyse en visio a duré 20 minutes. Trois jours après, un PDF clair avec 4 scénarios chiffrés. J'ai choisi, ils ont géré toutes les résiliations. Zéro stress.",
    name: "Aïcha B.",
    role: "Médecin, Lausanne",
    saving: "640 CHF/an",
  },
];

const AUTO_ROTATE_MS = 6500;

export const TestimonialsSection = () => {
  const [idx, setIdx] = useState(0);
  const [paused, setPaused] = useState(false);
  const containerRef = useRef<HTMLDivElement | null>(null);

  // Auto-rotate
  useEffect(() => {
    if (paused) return;
    const t = setInterval(() => setIdx((i) => (i + 1) % testimonials.length), AUTO_ROTATE_MS);
    return () => clearInterval(t);
  }, [paused]);

  const go = (n: number) => setIdx(((n % testimonials.length) + testimonials.length) % testimonials.length);

  return (
    <section id="testimonials" className="relative py-24 md:py-32 bg-background">
      <div className="mx-auto max-w-7xl px-5 lg:px-8">
        <Reveal className="max-w-3xl mb-14 md:mb-16">
          <span className="kx-eyebrow mb-5">Ce que disent nos clients</span>
          <ScrollRevealText as="h2" className="kx-display text-[2rem] sm:text-[2.5rem] lg:text-[3rem] mb-5" theme="dark">
            <span className="kx-display-gradient">2'500 clients</span> nous font confiance.
          </ScrollRevealText>
          <p className="text-lg leading-relaxed max-w-2xl" style={{ color: "hsl(var(--foreground-soft))" }}>
            Note moyenne 4,8/5 sur les avis vérifiés. Voilà pourquoi.
          </p>
        </Reveal>

        {/* SBS-style horizontal swiper */}
        <div
          ref={containerRef}
          className="relative overflow-hidden"
          onMouseEnter={() => setPaused(true)}
          onMouseLeave={() => setPaused(false)}
        >
          <div
            className="flex"
            style={{
              transform: `translateX(-${idx * 100}%)`,
              transition: "transform 700ms cubic-bezier(0.32, 0.72, 0, 1)",
              willChange: "transform",
            }}
          >
            {testimonials.map((t) => (
              <div key={t.name} className="shrink-0 w-full px-2">
                <figure className="mx-auto max-w-3xl bg-background-pure border border-neutral-light rounded-[2rem] p-8 md:p-12 lg:p-16 shadow-soft">
                  <div className="flex items-center justify-between mb-6 md:mb-8">
                    <div className="flex gap-0.5">
                      {[...Array(5)].map((_, j) => (
                        <svg key={j} viewBox="0 0 20 20" className="w-5 h-5 fill-[hsl(45_100%_55%)]">
                          <path d="M10 1.5l2.6 5.4 5.9.85-4.3 4.2 1 5.9L10 15l-5.3 2.8 1-5.9-4.3-4.2 5.9-.85L10 1.5z" />
                        </svg>
                      ))}
                    </div>
                    <span className="kx-stat-chip text-sm">{t.saving}</span>
                  </div>
                  <blockquote className="text-xl md:text-2xl leading-relaxed text-foreground mb-8 md:mb-10 font-medium tracking-tight">
                    "{t.quote}"
                  </blockquote>
                  <figcaption className="pt-6 border-t border-neutral-light flex items-center justify-between">
                    <div>
                      <p className="text-base font-semibold text-foreground">{t.name}</p>
                      <p className="text-sm mt-0.5" style={{ color: "hsl(var(--muted-text))" }}>{t.role}</p>
                    </div>
                    <span className="text-[11px] font-bold uppercase tracking-[0.18em]" style={{ color: "hsl(var(--accent))" }}>
                      Cas réel
                    </span>
                  </figcaption>
                </figure>
              </div>
            ))}
          </div>
        </div>

        {/* Controls + pagination dots */}
        <div className="mt-10 flex items-center justify-center gap-5">
          <button
            type="button"
            onClick={() => go(idx - 1)}
            aria-label="Témoignage précédent"
            className="w-10 h-10 rounded-full border border-neutral-light bg-background-pure flex items-center justify-center hover:bg-foreground hover:text-background transition-colors"
          >
            <ChevronLeft className="w-5 h-5" />
          </button>

          <div className="flex items-center gap-2">
            {testimonials.map((_, i) => (
              <button
                key={i}
                type="button"
                onClick={() => go(i)}
                aria-label={`Aller au témoignage ${i + 1}`}
                className="h-2 rounded-full transition-all duration-500"
                style={{
                  width: i === idx ? 32 : 10,
                  background: i === idx ? "hsl(var(--accent))" : "hsl(var(--neutral-light))",
                }}
              />
            ))}
          </div>

          <button
            type="button"
            onClick={() => go(idx + 1)}
            aria-label="Témoignage suivant"
            className="w-10 h-10 rounded-full border border-neutral-light bg-background-pure flex items-center justify-center hover:bg-foreground hover:text-background transition-colors"
          >
            <ChevronRight className="w-5 h-5" />
          </button>
        </div>
      </div>
    </section>
  );
};
