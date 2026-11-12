import { useState } from "react";
import { ArrowLeft, ArrowRight, Loader2 } from "lucide-react";
import { cn } from "@/lib/utils";

/**
 * Barre de navigation épinglée en bas du tunnel.
 * Le bouton avance reste cliquable même quand l'étape est incomplète : il
 * déclenche alors l'affichage des erreurs plutôt que de rester inerte, ce qui
 * évite le classique « le bouton ne marche pas ».
 */
const FunnelNav = ({
  currentStep,
  onPrevious,
  onNext,
  isSubmitting = false,
  isLastStep = false,
  canProceed = true,
  lastStepLabel = "Envoyer ma demande",
}: {
  currentStep: number;
  onPrevious: () => void;
  onNext: () => void;
  isSubmitting?: boolean;
  isLastStep?: boolean;
  canProceed?: boolean;
  lastStepLabel?: string;
}) => {
  const [shaking, setShaking] = useState(false);

  const handleNext = () => {
    onNext();
    if (!canProceed) {
      setShaking(true);
      setTimeout(() => setShaking(false), 500);
    }
  };

  return (
    <div className="flex flex-row items-center justify-between gap-3">
      <button
        type="button"
        onClick={onPrevious}
        disabled={currentStep === 1 || isSubmitting}
        className="inline-flex h-12 min-w-[96px] items-center justify-center gap-1.5 rounded-full border border-border bg-background-pure px-4 text-sm font-semibold text-foreground transition-colors hover:bg-muted disabled:cursor-not-allowed disabled:opacity-40 md:h-14 md:min-w-[130px] md:text-base"
      >
        <ArrowLeft className="h-4 w-4" />
        Retour
      </button>

      <button
        type="button"
        onClick={handleNext}
        disabled={isSubmitting}
        className={cn(
          "inline-flex h-12 min-w-[160px] items-center justify-center gap-2 rounded-full px-6 text-sm font-bold text-accent-foreground transition-all duration-200 md:h-14 md:min-w-[210px] md:text-base",
          "bg-accent shadow-[0_8px_24px_-8px_hsl(var(--accent)/0.5)] hover:-translate-y-0.5 hover:brightness-105",
          "disabled:cursor-not-allowed disabled:opacity-60 disabled:hover:translate-y-0",
          !canProceed && "opacity-70",
          shaking && "animate-[kx-shake_0.4s_ease-in-out]"
        )}
      >
        {isSubmitting ? (
          <>
            <Loader2 className="h-4 w-4 animate-spin md:h-5 md:w-5" />
            Envoi
          </>
        ) : isLastStep ? (
          lastStepLabel
        ) : (
          <>
            Continuer
            <ArrowRight className="h-4 w-4 md:h-5 md:w-5" />
          </>
        )}
      </button>
    </div>
  );
};

export default FunnelNav;
