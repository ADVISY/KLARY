import { ReactNode } from "react";
import { Sparkles } from "lucide-react";

interface PageHeroV2Props {
  eyebrow?: string;
  title: string;
  titleAccent?: string;
  subtitle?: string;
  image?: string;
  imageAlt?: string;
  cta?: ReactNode;
  /** "warm" = orange-violet (default), "cool" = navy-violet */
  variant?: "warm" | "cool";
}

/**
 * Reusable page hero for internal pages — matches the home v2 design language :
 *   gradient bg (cream top → orange/violet bottom) + big bold title + optional image
 *   + animated bg overlays.
 */
export const PageHeroV2 = ({
  eyebrow = "Klary",
  title,
  titleAccent,
  subtitle,
  image,
  imageAlt,
  cta,
  variant = "warm",
}: PageHeroV2Props) => {
  // Hero épuré pages internes : crème pure type Stripe/Alan, sans gradient sale.
  // Une seule touche d'accent : un orb soft en haut-droite, très diffus.
  return (
    <section
      className="relative overflow-hidden pt-28 md:pt-36 pb-20 md:pb-28"
      style={{ backgroundColor: "#FAF7EE" }}
    >
      {/* Orb accent unique en haut-droite — très diffus, ne sature jamais */}
      <div
        aria-hidden
        className="absolute pointer-events-none"
        style={{
          top: "-30%",
          right: "-20%",
          width: "70vw",
          height: "80vh",
          background:
            variant === "warm"
              ? "radial-gradient(circle at 50% 50%, rgba(240, 101, 31, 0.12) 0%, rgba(240, 101, 31, 0.04) 35%, transparent 70%)"
              : "radial-gradient(circle at 50% 50%, rgba(122, 91, 196, 0.10) 0%, rgba(122, 91, 196, 0.04) 35%, transparent 70%)",
          filter: "blur(20px)",
        }}
      />

      {/* Séparation fine en bas du hero — démarque visuellement de la section suivante */}
      <div
        aria-hidden
        className="absolute bottom-0 left-0 right-0 h-px"
        style={{
          background:
            "linear-gradient(90deg, transparent 0%, rgba(26, 22, 96, 0.08) 30%, rgba(26, 22, 96, 0.08) 70%, transparent 100%)",
        }}
      />

      <div className="relative z-[2] mx-auto max-w-7xl px-5 lg:px-8">
        <div className={`grid ${image ? "lg:grid-cols-[1.1fr_1fr]" : ""} gap-12 lg:gap-16 items-center`}>
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
              {eyebrow}
            </span>

            <h1
              className="font-extrabold tracking-tight leading-[0.98] mb-6"
              style={{
                fontSize: "clamp(2.5rem, 6vw, 4.5rem)",
                letterSpacing: "-0.035em",
                color: "#100D32",
              }}
            >
              {title}
              {titleAccent && (
                <>
                  {" "}
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
                    {titleAccent}
                  </span>
                </>
              )}
            </h1>

            {subtitle && (
              <p
                className="text-lg lg:text-xl leading-relaxed mb-8 max-w-xl"
                style={{ color: "hsl(244 40% 22%)" }}
              >
                {subtitle}
              </p>
            )}

            {cta && <div className="flex flex-col sm:flex-row gap-3 items-start">{cta}</div>}
          </div>

          {image && (
            <div className="relative kx-scale-in">
              <div className="absolute inset-0 rounded-[2rem] pointer-events-none"
                   style={{ background: "radial-gradient(circle at center, hsl(19 90% 54% / 0.40), transparent 70%)", filter: "blur(40px)" }} />
              <img
                src={image}
                alt={imageAlt || ""}
                className="relative rounded-[2rem] w-full h-auto object-cover shadow-strong border border-white/20"
                style={{ maxHeight: "520px" }}
              />
            </div>
          )}
        </div>
      </div>
    </section>
  );
};
