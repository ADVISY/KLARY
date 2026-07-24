import handPhone from "@/assets/optimized/hand-phone-front.webp";
import advisyLogo from "@/assets/klary-logo-horizontal.png";
import { MessageSquare, Settings, Star } from "lucide-react";
import { HeroProductSlider } from "./HeroProductSlider";

export const EnhancedHeroSection = () => {
  const scrollToSection = (href: string) => {
    const el = document.querySelector(href);
    if (el) el.scrollIntoView({ behavior: "smooth" });
  };

  return (
    <section
      id="accueil"
      className="bg-mesh-klary-light mesh-fade-bottom relative lg:min-h-screen flex flex-col items-center justify-start pt-28 sm:pt-40 pb-0 sm:pb-8 lg:pb-32 overflow-hidden"
    >
      {/* Subtle grain layer over the animated mesh */}
      <div
        aria-hidden
        className="pointer-events-none absolute inset-0 opacity-[0.06] z-0"
        style={{
          backgroundImage:
            "url(\"data:image/svg+xml;utf8,<svg xmlns='http://www.w3.org/2000/svg' width='200' height='200'><filter id='n'><feTurbulence type='fractalNoise' baseFrequency='1.4' numOctaves='2' stitchTiles='stitch'/><feColorMatrix type='matrix' values='0 0 0 0 0.1  0 0 0 0 0.1  0 0 0 0 0.2  0 0 0 0.5 0'/></filter><rect width='100%' height='100%' filter='url(%23n)'/></svg>\")",
        }}
      />

      <div className="container relative z-10 mx-auto px-4 lg:px-8">
        <div className="text-center max-w-5xl mx-auto space-y-10 animate-fade-in">
          <div className="flex items-center justify-center gap-1.5 mb-2">
            {[...Array(5)].map((_, i) => (
              <Star
                key={i}
                className="w-4 h-4 md:w-5 md:h-5"
                style={{
                  fill: "hsl(45 100% 65%)",
                  color: "hsl(45 100% 65%)",
                  filter: "drop-shadow(0 0 8px hsl(45 100% 60% / 0.5))",
                }}
              />
            ))}
          </div>
          <h1 className="text-display-sm md:text-display-md lg:text-display xl:text-display-xl affirm-display">
            Conseil. Optimisation.<br />
            <span
              className="bg-clip-text text-transparent"
              style={{
                backgroundImage:
                  "linear-gradient(100deg, hsl(244 65% 22%) 0%, hsl(244 55% 35%) 35%, hsl(19 90% 54%) 75%, hsl(24 95% 60%) 100%)",
                WebkitBackgroundClip: "text",
              }}
            >
              Sécurité.
            </span>
          </h1>

          <p className="text-body-sm md:text-body text-muted-foreground max-w-xl mx-auto leading-relaxed font-light">
            Trouvez la solution la plus avantageuse pour votre santé,
            votre retraite et vos finances. Nos conseillers indépendants
            vous accompagnent gratuitement dans toute la Suisse.
          </p>

          <div className="flex flex-col sm:flex-row gap-3 items-center justify-center pt-4">
            <button
              onClick={() => scrollToSection("#contact")}
              className="nav-pill inline-flex items-center justify-center font-medium rounded-full px-7 py-3.5 text-base text-white !bg-[hsl(240_18%_9%/0.85)] backdrop-blur-xl"
            >
              Prendre rendez-vous
            </button>
            <button onClick={() => scrollToSection("#services")} className="btn-pill-outline">
              Découvrir nos services
            </button>
          </div>
        </div>

        <div className="relative w-full max-w-6xl mx-auto mt-4 sm:mt-4 lg:-mt-36 animate-scale-in overflow-hidden">
          <div className="relative w-full mx-auto flex justify-center">
            <img
              src={handPhone}
              alt="Smartphone Klary tenu en main"
              className="w-full sm:w-[95%] md:w-full max-w-4xl h-auto select-none pointer-events-none mx-auto"
              style={{
                WebkitMaskImage:
                  "linear-gradient(to bottom, #000 0%, #000 68%, transparent 96%)",
                maskImage:
                  "linear-gradient(to bottom, #000 0%, #000 68%, transparent 96%)",
              }}
            />

            {/* Phone screen overlay — Affirm-style proportions adapted to Klary */}
            <div
              className="absolute pointer-events-none w-[30%] sm:w-[27%] md:w-[31%] md:mt-[150px]"
              style={{
                top: "14%",
                left: "50%",
                transform: "translateX(-50%)",
                maxWidth: "390px",
              }}
            >
              {/* Top bar: logo + icons */}
              <div className="flex items-center justify-between mb-6 md:mb-10 px-0 -mt-[19px]">
                <img
                  src={advisyLogo}
                  alt="Klary"
                  className="h-[24px] md:h-[39px] w-auto opacity-95 -ml-0.5"
                />
                <div className="flex items-center gap-1.5 md:gap-2.5 -mr-0.5">
                  <div
                    className="w-[30px] h-[30px] md:w-[51px] md:h-[51px] rounded-full flex items-center justify-center"
                    style={{ background: "hsl(255 30% 20% / 0.65)" }}
                  >
                    <MessageSquare className="w-[15px] h-[15px] md:w-[26px] md:h-[26px] text-white/85" />
                  </div>
                  <div
                    className="w-[30px] h-[30px] md:w-[51px] md:h-[51px] rounded-full flex items-center justify-center"
                    style={{ background: "hsl(255 30% 20% / 0.65)" }}
                  >
                    <Settings className="w-[15px] h-[15px] md:w-[26px] md:h-[26px] text-white/85" />
                  </div>
                </div>
              </div>

              <HeroProductSlider />
            </div>
          </div>
        </div>
      </div>
    </section>
  );
};
