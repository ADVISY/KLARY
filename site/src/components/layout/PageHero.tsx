import { LucideIcon, Star } from "lucide-react";
import { ReactNode } from "react";

interface PageHeroProps {
  /** [DEPRECATED] eyebrow ignoré désormais (look plus épuré, retirés à la demande) */
  eyebrow?: string;
  eyebrowIcon?: LucideIcon;
  /** Titre principal — la dernière partie reçoit le dégradé bleu→violet→rose */
  title: ReactNode;
  /** Mot/phrase finale en dégradé (style Sécurité de la home) */
  titleAccent?: string;
  /** Sous-titre */
  subtitle?: ReactNode;
  /** Boutons CTA */
  cta?: ReactNode;
  /** Affiche les 5 étoiles dorées comme sur la home */
  showStars?: boolean;
  /** Image à droite (URL importée) — si fournie, layout split 2 colonnes */
  image?: string;
  /** Alt de l'image */
  imageAlt?: string;
}

/**
 * Hero unifié — fond aurora violet/bleu, typo affirm-display.
 * Si `image` est fourni : layout split (texte gauche, image droite).
 * Sinon : layout centré classique.
 */
export const PageHero = ({
  title,
  titleAccent,
  subtitle,
  cta,
  showStars = false,
  image,
  imageAlt = "",
}: PageHeroProps) => {
  const hasImage = Boolean(image);

  return (
    <section className="relative min-h-[80vh] flex items-center pt-40 pb-24 overflow-hidden">
      {/* Aurora ambient */}
      <div aria-hidden className="pointer-events-none absolute inset-0 overflow-hidden">
        <div
          className="absolute left-1/2 top-1/2 -translate-x-1/2 -translate-y-1/2 w-[1600px] h-[1400px] rounded-full"
          style={{
            background:
              "radial-gradient(closest-side, hsl(258 90% 62% / 0.45), hsl(232 90% 58% / 0.25) 35%, hsl(210 85% 55% / 0.10) 60%, transparent 78%)",
            filter: "blur(110px)",
          }}
        />
        <div
          className="absolute left-[18%] top-[60%] -translate-y-1/2 w-[800px] h-[800px] rounded-full"
          style={{
            background:
              "radial-gradient(closest-side, hsl(320 100% 65% / 0.5), hsl(295 100% 62% / 0.25) 40%, transparent 75%)",
            filter: "blur(110px)",
          }}
        />
        <div
          className="absolute right-[16%] top-[45%] -translate-y-1/2 w-[800px] h-[800px] rounded-full"
          style={{
            background:
              "radial-gradient(closest-side, hsl(220 100% 65% / 0.4), hsl(245 100% 70% / 0.18) 45%, transparent 75%)",
            filter: "blur(110px)",
          }}
        />
        <div
          className="absolute inset-0 opacity-[0.08]"
          style={{
            backgroundImage:
              "url(\"data:image/svg+xml;utf8,<svg xmlns='http://www.w3.org/2000/svg' width='200' height='200'><filter id='n'><feTurbulence type='fractalNoise' baseFrequency='1.4' numOctaves='2' stitchTiles='stitch'/><feColorMatrix type='matrix' values='0 0 0 0 1  0 0 0 0 1  0 0 0 0 1  0 0 0 0.5 0'/></filter><rect width='100%' height='100%' filter='url(%23n)'/></svg>\")",
          }}
        />
        <div className="absolute inset-x-0 bottom-0 h-[55%] bg-gradient-to-b from-transparent via-background/40 to-background" />
      </div>

      <div className="container relative z-10 mx-auto px-4 lg:px-8">
        <div
          className={
            hasImage
              ? "grid lg:grid-cols-2 gap-12 lg:gap-16 items-center"
              : "max-w-4xl mx-auto"
          }
        >
          {/* Texte */}
          <div
            className={`space-y-8 animate-fade-in ${
              hasImage ? "text-left" : "text-center"
            }`}
          >
            {showStars && (
              <div
                className={`flex items-center gap-1.5 ${
                  hasImage ? "justify-start" : "justify-center"
                }`}
              >
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
            )}

            <h1 className="text-4xl md:text-5xl lg:text-6xl xl:text-7xl affirm-display">
              {title}
              {titleAccent && (
                <>
                  <br />
                  <span
                    className="bg-clip-text text-transparent"
                    style={{
                      backgroundImage:
                        "linear-gradient(100deg, hsl(220 100% 70%) 0%, hsl(245 100% 75%) 35%, hsl(265 100% 75%) 65%, hsl(300 95% 72%) 100%)",
                      WebkitBackgroundClip: "text",
                    }}
                  >
                    {titleAccent}
                  </span>
                </>
              )}
            </h1>

            {subtitle && (
              <p
                className={`text-base md:text-lg text-muted-foreground leading-relaxed font-light ${
                  hasImage ? "max-w-xl" : "max-w-2xl mx-auto"
                }`}
              >
                {subtitle}
              </p>
            )}

            {cta && (
              <div
                className={`flex flex-col sm:flex-row gap-3 items-center pt-2 ${
                  hasImage ? "justify-start" : "justify-center"
                }`}
              >
                {cta}
              </div>
            )}
          </div>

          {/* Image (droite) — fondu radial pour fusionner avec le fond, sans bordures */}
          {hasImage && (
            <div className="relative animate-fade-in order-first lg:order-last">
              <img
                src={image}
                alt={imageAlt}
                width={1024}
                height={1024}
                className="w-full h-auto object-contain aspect-square"
                style={{
                  WebkitMaskImage:
                    "radial-gradient(ellipse at center, #000 50%, transparent 78%)",
                  maskImage:
                    "radial-gradient(ellipse at center, #000 50%, transparent 78%)",
                  filter: "drop-shadow(0 30px 60px hsl(258 90% 30% / 0.5))",
                }}
              />
              <div
                aria-hidden
                className="absolute -inset-10 -z-10 rounded-full"
                style={{
                  background:
                    "radial-gradient(closest-side, hsl(265 90% 65% / 0.35), transparent 70%)",
                  filter: "blur(70px)",
                }}
              />
            </div>
          )}
        </div>
      </div>
    </section>
  );
};
