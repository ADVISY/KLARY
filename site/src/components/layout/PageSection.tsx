import { ReactNode } from "react";
import { LucideIcon } from "lucide-react";
import { SectionGlow } from "@/components/sections/SectionGlow";

interface PageSectionProps {
  /** Ancre de section pour les liens internes */
  id?: string;
  /** Badge facultatif au-dessus du titre */
  eyebrow?: string;
  eyebrowIcon?: LucideIcon;
  /** Titre de section */
  title?: ReactNode;
  /** Sous-titre */
  subtitle?: ReactNode;
  children: ReactNode;
  /** Affiche un SectionGlow au-dessus pour la transition (par défaut true) */
  withGlow?: boolean;
  /** Largeur max du contenu */
  maxWidth?: "4xl" | "5xl" | "6xl" | "7xl";
  className?: string;
}

const maxWidthMap = {
  "4xl": "max-w-4xl",
  "5xl": "max-w-5xl",
  "6xl": "max-w-6xl",
  "7xl": "max-w-7xl",
};

/**
 * Section unifiée — fond background, padding constant, header centré optionnel.
 * Inclut un SectionGlow par défaut pour transition douce sans coupure de couleur.
 */
export const PageSection = ({
  id,
  eyebrow,
  eyebrowIcon: EyebrowIcon,
  title,
  subtitle,
  children,
  withGlow = true,
  maxWidth = "6xl",
  className = "",
}: PageSectionProps) => {
  return (
    <>
      {withGlow && <SectionGlow />}
      <section id={id} className={`relative py-20 lg:py-28 ${className}`}>
        <div className="container mx-auto px-4 lg:px-8">
          <div className={`${maxWidthMap[maxWidth]} mx-auto`}>
            {(eyebrow || title || subtitle) && (
              <div className="text-center mb-14 space-y-5">
                {eyebrow && (
                  <div className="section-badge mx-auto">
                    {EyebrowIcon && <EyebrowIcon className="w-3.5 h-3.5" />}
                    {eyebrow}
                  </div>
                )}
                {title && (
                  <h2 className="text-3xl md:text-4xl lg:text-5xl affirm-display">
                    {title}
                  </h2>
                )}
                {subtitle && (
                  <p className="text-base md:text-lg text-muted-foreground max-w-2xl mx-auto font-light leading-relaxed">
                    {subtitle}
                  </p>
                )}
              </div>
            )}
            {children}
          </div>
        </div>
      </section>
    </>
  );
};
