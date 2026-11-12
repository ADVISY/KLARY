import { cn } from "@/lib/utils";
import { HEALTH_INSURERS } from "@/data/funnelOptions";

/**
 * Grille des assureurs maladie pour la question « chez qui êtes-vous ».
 * On clique un logo plutôt que de chercher un nom dans une liste : c'est la
 * réponse la plus rapide, et la reconnaissance visuelle évite les fautes de
 * saisie. « Autre » reste toujours disponible comme porte de sortie.
 */
const InsurerGrid = ({
  value,
  onValueChange,
}: {
  value: string;
  onValueChange: (value: string) => void;
}) => (
  <div role="radiogroup" aria-label="Votre assureur actuel" className="grid grid-cols-3 gap-2.5 sm:grid-cols-4">
    {HEALTH_INSURERS.map((insurer) => {
      const selected = value === insurer.value;
      return (
        <button
          key={insurer.value}
          type="button"
          role="radio"
          aria-checked={selected}
          aria-label={insurer.label}
          onClick={() => onValueChange(insurer.value)}
          className={cn(
            "flex h-16 items-center justify-center rounded-xl border-2 bg-background-pure p-2 transition-all duration-200 md:h-20",
            "hover:border-accent/60 hover:shadow-sm focus:outline-none focus-visible:ring-2 focus-visible:ring-accent focus-visible:ring-offset-1",
            selected ? "border-accent bg-accent/5 shadow-sm" : "border-border"
          )}
        >
          <img
            src={insurer.logo}
            alt={insurer.label}
            loading="lazy"
            className="max-h-9 w-auto max-w-full object-contain md:max-h-11"
          />
        </button>
      );
    })}

    <button
      type="button"
      role="radio"
      aria-checked={value === "other"}
      onClick={() => onValueChange("other")}
      className={cn(
        "flex h-16 items-center justify-center rounded-xl border-2 bg-background-pure p-2 text-sm font-semibold transition-all duration-200 md:h-20",
        "hover:border-accent/60 focus:outline-none focus-visible:ring-2 focus-visible:ring-accent focus-visible:ring-offset-1",
        value === "other" ? "border-accent bg-accent/5 text-foreground" : "border-border text-foreground-soft"
      )}
    >
      Autre
    </button>
  </div>
);

export default InsurerGrid;
