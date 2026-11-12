import { Check, Loader2 } from "lucide-react";
import { cn } from "@/lib/utils";

export type LoadingPhase = "analyse" | "preparation" | "transmission";

const PHASES: { key: LoadingPhase; label: string }[] = [
  { key: "analyse", label: "Analyse de votre situation" },
  { key: "preparation", label: "Préparation de votre dossier" },
  { key: "transmission", label: "Transmission à votre conseiller" },
];

/**
 * Écran d'attente entre le dernier champ et la confirmation.
 * Il dure le temps réel de l'enregistrement : on ne met pas en scène un faux
 * calcul, on nomme ce qui se passe vraiment, étape par étape.
 */
const FunnelLoading = ({ phase }: { phase: LoadingPhase }) => {
  const activeIndex = PHASES.findIndex((p) => p.key === phase);

  return (
    <div className="flex min-h-0 flex-1 items-center justify-center py-8">
      <div className="w-full max-w-md rounded-2xl border border-border bg-background-pure p-6 md:p-8">
        <h2 className="font-display mb-6 text-center text-lg font-black text-foreground md:text-xl">
          Un instant, nous enregistrons votre demande
        </h2>

        <ul className="space-y-4">
          {PHASES.map((p, index) => {
            const done = index < activeIndex;
            const current = index === activeIndex;
            return (
              <li key={p.key} className="flex items-center gap-3">
                <span
                  className={cn(
                    "flex h-7 w-7 shrink-0 items-center justify-center rounded-full border-2 transition-colors",
                    done && "border-accent bg-accent text-accent-foreground",
                    current && "border-accent text-accent",
                    !done && !current && "border-border text-muted-foreground"
                  )}
                >
                  {done ? (
                    <Check className="h-4 w-4" />
                  ) : current ? (
                    <Loader2 className="h-4 w-4 animate-spin" />
                  ) : (
                    <span className="text-xs font-bold">{index + 1}</span>
                  )}
                </span>
                <span
                  className={cn(
                    "text-sm md:text-base",
                    done || current ? "font-semibold text-foreground" : "text-muted-foreground"
                  )}
                >
                  {p.label}
                </span>
              </li>
            );
          })}
        </ul>
      </div>
    </div>
  );
};

export default FunnelLoading;
