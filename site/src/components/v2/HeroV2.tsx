import { ArrowRight, Sparkles, Check } from "lucide-react";
import { PhoneMockup3D } from "./phone/PhoneMockup3D";
import { ScrollIndicator } from "./ScrollIndicator";

export const HeroV2 = () => {
  const handleCta = (href: string) => {
    const el = document.querySelector(href);
    if (el) el.scrollIntoView({ behavior: "smooth" });
  };

  return (
    <section
      id="accueil"
      className="relative overflow-hidden pt-28 md:pt-36 pb-20 md:pb-32"
      style={{
        // Fond premium fintech : crème en haut → très subtil warm peach → navy profond en bas
        // Beaucoup moins de saturation, transitions douces, deux couleurs dominantes
        background: `
          radial-gradient(60% 40% at 85% 5%, rgba(240, 101, 31, 0.08) 0%, transparent 70%),
          linear-gradient(180deg,
            #FAF7EE 0%,
            #F6F1E4 35%,
            #E8DFD0 55%,
            #4A3E6A 80%,
            #1A1660 95%,
            #0D0B40 100%
          )
        `,
      }}
    >
      <div className="mx-auto max-w-7xl px-5 lg:px-8 relative z-[2]">
        <div className="grid lg:grid-cols-[1.1fr_1fr] gap-12 lg:gap-16 items-center">
          {/* LEFT — copy */}
          <div className="kx-fade-in-up max-w-2xl">
            <span
              className="inline-flex items-center gap-2 px-3 py-1.5 rounded-full text-[11px] font-semibold uppercase tracking-[0.16em] mb-6"
              style={{
                background: "rgba(255,255,255,0.70)",
                color: "hsl(var(--accent))",
                border: "1px solid rgba(26, 22, 96, 0.10)",
              }}
            >
              <Sparkles className="w-3 h-3" />
              Courtier indépendant en Suisse
            </span>

            <h1
              className="font-extrabold tracking-tight leading-[0.95] mb-7"
              style={{
                fontSize: "clamp(3rem, 7.5vw, 5.5rem)",
                letterSpacing: "-0.04em",
                color: "#100D32",
              }}
            >
              L'assurance,{" "}
              <span
                style={{
                  background:
                    "linear-gradient(135deg, #100D32 0%, #1A1660 35%, hsl(19 90% 45%) 100%)",
                  WebkitBackgroundClip: "text",
                  backgroundClip: "text",
                  WebkitTextFillColor: "transparent",
                  fontWeight: 900,
                }}
              >
                enfin claire.
              </span>
            </h1>

            <p
              className="text-lg lg:text-xl leading-relaxed mb-9 max-w-xl"
              style={{ color: "hsl(244 40% 22%)" }}
            >
              On compare, on négocie, on optimise vos contrats — santé, prévoyance, hypothèque.{" "}
              <strong className="font-semibold" style={{ color: "#100D32" }}>
                Gratuit, neutre, sans engagement.
              </strong>
            </p>

            <div className="flex flex-col sm:flex-row gap-3 mb-10">
              <button
                onClick={() => handleCta("#contact")}
                className="kx-btn kx-btn-accent !text-base !py-3.5 !px-7"
              >
                Mon analyse gratuite en 15 min
                <ArrowRight className="w-4 h-4" />
              </button>
              <button
                onClick={() => handleCta("#process")}
                className="inline-flex items-center justify-center gap-2 font-semibold text-base py-3.5 px-7 rounded-full transition-all"
                style={{
                  background: "rgba(255,255,255,0.80)",
                  color: "hsl(244 65% 22%)",
                  border: "1px solid rgba(26, 22, 96, 0.15)",
                }}
              >
                Comment ça marche
              </button>
            </div>

            <div className="flex flex-wrap items-center gap-x-6 gap-y-3 text-sm" style={{ color: "hsl(244 50% 18%)" }}>
              <div className="flex items-center gap-2">
                <div className="flex">
                  {[...Array(5)].map((_, i) => (
                    <svg key={i} viewBox="0 0 20 20" className="w-4 h-4 fill-[hsl(45_100%_55%)]">
                      <path d="M10 1.5l2.6 5.4 5.9.85-4.3 4.2 1 5.9L10 15l-5.3 2.8 1-5.9-4.3-4.2 5.9-.85L10 1.5z" />
                    </svg>
                  ))}
                </div>
                <span><strong className="font-bold" style={{ color: "#100D32" }}>4,8/5</strong> · 2'500+ clients</span>
              </div>
              <div className="flex items-center gap-2">
                <Check className="w-4 h-4" style={{ color: "hsl(var(--accent))" }} />
                <span>Toutes compagnies suisses</span>
              </div>
              <div className="flex items-center gap-2">
                <Check className="w-4 h-4" style={{ color: "hsl(var(--accent))" }} />
                <span>FINMA conforme</span>
              </div>
            </div>
          </div>

          {/* RIGHT — Phone with gentle float */}
          <div
            className="relative kx-scale-in"
            style={{ animation: "kx-float-y 6s ease-in-out infinite", willChange: "transform" }}
          >
            <PhoneMockup3D />
          </div>
        </div>

        <div className="hidden md:flex justify-center mt-16 lg:mt-20" style={{ color: "rgba(255,255,255,0.80)" }}>
          <ScrollIndicator label="Faites défiler pour explorer" />
        </div>
      </div>
    </section>
  );
};
