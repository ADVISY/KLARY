import { ReactNode } from "react";
import { ScrollRevealText } from "./ScrollRevealText";

interface PageSectionV2Props {
  id?: string;
  eyebrow?: string;
  title?: string;
  titleAccent?: string;
  subtitle?: string;
  children: ReactNode;
  /** Section variant: "light" = cream bg, "dark" = navy premium */
  variant?: "light" | "dark";
  className?: string;
}

/**
 * Section réutilisable pour pages internes — design premium fintech.
 * - Pas d'animation background (cream uni ou navy uni)
 * - Titres avec scroll-driven reveal (mot par mot)
 */
export const PageSectionV2 = ({
  id,
  eyebrow,
  title,
  titleAccent,
  subtitle,
  children,
  variant = "light",
  className = "",
}: PageSectionV2Props) => {
  const wrapperCls =
    variant === "dark"
      ? "relative py-24 md:py-32 overflow-hidden text-white"
      : "relative py-20 md:py-28 bg-background";

  const darkBg =
    variant === "dark"
      ? {
          background: `
            radial-gradient(900px 600px at 85% 0%, rgba(240, 101, 31, 0.10) 0%, transparent 60%),
            linear-gradient(180deg, #14123F 0%, #0D0B40 60%, #0A0830 100%)
          `,
        }
      : undefined;

  return (
    <section id={id} className={`${wrapperCls} ${className}`} style={darkBg}>
      <div className="mx-auto max-w-7xl px-5 lg:px-8 relative z-[2]">
        {(eyebrow || title || subtitle) && (
          <div className="max-w-3xl mb-12 md:mb-16">
            {eyebrow && (
              <span
                className="kx-eyebrow mb-5"
                style={variant === "dark" ? { color: "hsl(var(--accent-soft))" } : undefined}
              >
                {eyebrow}
              </span>
            )}
            {title && (
              <ScrollRevealText
                as="h2"
                theme={variant === "dark" ? "light" : "dark"}
                className={`kx-display text-[2rem] sm:text-[2.5rem] lg:text-[3rem] mb-5 tracking-tight ${
                  variant === "dark" ? "text-white" : ""
                }`}
              >
                {title}
                {titleAccent && (
                  <>
                    {" "}
                    <span className="kx-display-gradient">{titleAccent}</span>
                  </>
                )}
              </ScrollRevealText>
            )}
            {subtitle && (
              <p
                className="text-lg leading-relaxed max-w-2xl"
                style={
                  variant === "dark"
                    ? { color: "rgba(255,255,255,0.75)" }
                    : { color: "hsl(var(--foreground-soft))" }
                }
              >
                {subtitle}
              </p>
            )}
          </div>
        )}

        {children}
      </div>
    </section>
  );
};
