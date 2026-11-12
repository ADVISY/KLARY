import { cn } from "@/lib/utils";

export interface OptionItem {
  value: string;
  label: string;
  /** Précision facultative affichée en plus petit sous le libellé. */
  hint?: string;
}

/**
 * Groupe de boutons à choix unique, en remplacement d'un menu déroulant.
 * Un menu déroulant coûte deux gestes et cache les options : sur un tunnel
 * payant, chaque geste perdu est un prospect perdu.
 */
export function OptionButtons({
  value,
  onValueChange,
  options,
  columns = 2,
  ariaLabel,
}: {
  value: string;
  onValueChange: (value: string) => void;
  options: OptionItem[];
  columns?: 1 | 2 | 3 | 4;
  ariaLabel?: string;
}) {
  const colClass: Record<number, string> = {
    1: "grid-cols-1",
    2: "grid-cols-2",
    3: "grid-cols-2 sm:grid-cols-3",
    4: "grid-cols-2 sm:grid-cols-4",
  };

  return (
    <div role="radiogroup" aria-label={ariaLabel} className={cn("grid gap-2.5", colClass[columns])}>
      {options.map((opt) => {
        const selected = value === opt.value;
        return (
          <button
            key={opt.value}
            type="button"
            role="radio"
            aria-checked={selected}
            onClick={() => onValueChange(opt.value)}
            className={cn(
              "flex min-h-[52px] flex-col items-center justify-center rounded-xl border-2 bg-background-pure px-3 py-2 text-center text-sm font-semibold leading-tight transition-all duration-200 md:min-h-[60px] md:text-base",
              "hover:border-accent/60 hover:shadow-sm focus:outline-none focus-visible:ring-2 focus-visible:ring-accent focus-visible:ring-offset-1",
              selected
                ? "border-accent bg-accent/5 text-foreground shadow-sm"
                : "border-border text-foreground-soft"
            )}
          >
            <span>{opt.label}</span>
            {opt.hint && (
              <span className="mt-0.5 text-[11px] font-normal text-muted-foreground">{opt.hint}</span>
            )}
          </button>
        );
      })}
    </div>
  );
}

export default OptionButtons;
