import { PoleCardsSection } from "./PoleCardsSection";
import { StickyCardsSection } from "./StickyCardsSection";

export const ServicesSection = () => {
  return (
    <section id="services" className="relative pt-2 sm:pt-8 lg:pt-16 pb-section lg:pb-section-lg">
      <div className="absolute top-0 left-1/2 -translate-x-1/2 w-[900px] h-[400px] bg-primary/[0.08] rounded-full blur-[200px] pointer-events-none" />

      <div className="container relative z-10 mx-auto px-4 lg:px-8">
        <div className="text-center mb-14 max-w-4xl mx-auto">
          <h2 className="text-display-sm md:text-display-md lg:text-display affirm-display mb-6">
            Solutions sur mesure<br />
            <span
              className="bg-clip-text text-transparent"
              style={{
                backgroundImage:
                  "linear-gradient(100deg, hsl(220 100% 70%) 0%, hsl(245 100% 75%) 35%, hsl(265 100% 75%) 65%, hsl(300 95% 72%) 100%)",
                WebkitBackgroundClip: "text",
              }}
            >
              pour vos besoins
            </span>
          </h2>
          <p className="text-body-lg text-muted-foreground max-w-2xl mx-auto font-light">
            Des recommandations concrètes pour optimiser votre protection et vos finances.
          </p>
        </div>

        {/* 3 cards pôles (Assurance / Prévoyance / Finance) */}
        <div className="mb-24 -mt-4">
          <PoleCardsSection embedded />
        </div>

      </div>

      {/* Cas clients — 4 cards qui défilent par-dessus pendant le scroll */}
      <StickyCardsSection />
    </section>
  );
};

