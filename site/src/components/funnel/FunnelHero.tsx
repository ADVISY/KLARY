import { cn } from "@/lib/utils";

/**
 * FunnelHero — en-tête compact des pages d'offre.
 * Un seul H1, court sur mobile pour que le formulaire tienne sur un écran.
 */
interface FunnelHeroProps {
  title: string;
  /** Variante courte affichée sous 640 px. */
  titleMobile?: string;
  /** Petit intitulé au-dessus du titre, par exemple « Assurance maladie 2027 ». */
  eyebrow?: string;
  className?: string;
}

const FunnelHero = ({ title, titleMobile, eyebrow, className }: FunnelHeroProps) => (
  <div className={cn("mx-auto mb-2 max-w-3xl shrink-0 text-center md:mb-3", className)}>
    {eyebrow && <p className="kx-eyebrow justify-center text-[10px] md:text-xs">{eyebrow}</p>}
    <h1 className="font-display text-base font-black uppercase leading-tight tracking-tight text-foreground sm:text-xl md:text-2xl">
      {titleMobile ? (
        <>
          <span className="sm:hidden">{titleMobile}</span>
          <span className="hidden sm:inline">{title}</span>
        </>
      ) : (
        title
      )}
    </h1>
  </div>
);

export default FunnelHero;
