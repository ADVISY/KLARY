import { cn } from "@/lib/utils";

/**
 * Progression du tunnel. Volontairement sobre : un libellé et une barre navy,
 * le pourcentage rassure sans détourner l'attention de la question.
 */
const FunnelProgress = ({
  currentStep,
  totalSteps,
  className,
}: {
  currentStep: number;
  totalSteps: number;
  className?: string;
}) => {
  const progress = Math.round((currentStep / totalSteps) * 100);

  return (
    <div className={cn("w-full space-y-1.5", className)}>
      <div className="flex items-center justify-between text-[11px] md:text-xs">
        <span className="font-semibold text-foreground">
          Étape {currentStep} sur {totalSteps}
        </span>
        <span className="font-bold text-accent">{progress} %</span>
      </div>
      <div
        className="h-1.5 w-full overflow-hidden rounded-full bg-muted"
        role="progressbar"
        aria-valuenow={progress}
        aria-valuemin={0}
        aria-valuemax={100}
        aria-label="Progression du formulaire"
      >
        <div
          className="h-full rounded-full transition-[width] duration-500 ease-out"
          style={{
            width: `${progress}%`,
            backgroundImage: "linear-gradient(90deg, #1A1660 0%, #F0651F 100%)",
          }}
        />
      </div>
    </div>
  );
};

export default FunnelProgress;
