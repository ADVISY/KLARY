import { ReactNode } from "react";
import { AlertCircle } from "lucide-react";
import { cn } from "@/lib/utils";

/**
 * Enveloppe d'un champ : libellé, astérisque si obligatoire, aide, erreur.
 * L'erreur n'apparaît qu'après une tentative d'avance, jamais pendant la
 * frappe : signaler « e-mail invalide » à la deuxième lettre fait fuir.
 */
const FunnelField = ({
  label,
  required,
  hint,
  error,
  children,
  className,
}: {
  label: string;
  required?: boolean;
  hint?: string;
  error?: string;
  children: ReactNode;
  className?: string;
}) => (
  <div className={cn("space-y-2", className)}>
    <div className="space-y-0.5">
      <label className="block text-sm font-bold text-foreground md:text-base">
        {label}
        {required && <span className="ml-1 text-destructive">*</span>}
      </label>
      {hint && <p className="text-xs leading-snug text-muted-foreground">{hint}</p>}
    </div>
    {children}
    {error && (
      <p role="alert" className="flex items-center gap-1.5 text-xs font-medium text-destructive">
        <AlertCircle className="h-3.5 w-3.5 shrink-0" />
        {error}
      </p>
    )}
  </div>
);

export default FunnelField;

/** Classe commune des champs de saisie du tunnel. */
export const funnelInputClass =
  "h-12 w-full rounded-xl border-2 border-border bg-background-pure px-4 text-base text-foreground placeholder:text-muted-foreground/70 transition-colors focus:border-accent focus:outline-none focus-visible:ring-2 focus-visible:ring-accent/20 md:h-14";
