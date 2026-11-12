import { ReactNode, useCallback, useEffect, useRef } from "react";
import { Check } from "lucide-react";
import FunnelProgress from "./FunnelProgress";

/**
 * FunnelContainer — scène des questions.
 *
 * Deux colonnes sur desktop : à gauche un panneau qui explique l'étape en cours
 * et rappelle les trois raisons de continuer, à droite les questions. Klary n'a
 * pas de mascotte, c'est donc la voix écrite qui accompagne.
 *
 * Seule la zone des questions défile. L'en-tête et la barre de navigation
 * restent fixes, pour qu'on ne perde jamais le bouton de vue sur mobile.
 */
interface FunnelContainerProps {
  title: string;
  description?: string;
  currentStep: number;
  totalSteps: number;
  children: ReactNode;
  navigation?: ReactNode;
  /** Message par étape (index 0 = étape 1). Une case vide reprend le titre. */
  stepMessages?: (string | null | undefined)[];
  /** Prénom du prospect, dès qu'il est connu : on personnalise le panneau. */
  clientName?: string;
  /** Trois arguments courts affichés sous le message. */
  reassurance?: string[];
}

const FunnelContainer = ({
  title,
  description,
  currentStep,
  totalSteps,
  children,
  navigation,
  stepMessages,
  clientName,
  reassurance,
}: FunnelContainerProps) => {
  const scopeRef = useRef<HTMLDivElement>(null);

  // Chaque étape repart du haut. Sans cela, une étape longue laisse la
  // suivante affichée en son milieu : on arrive sur un champ sans son
  // intitulé, ce qui donne l'impression d'un formulaire cassé.
  useEffect(() => {
    scopeRef.current?.scrollTo({ top: 0 });
  }, [currentStep]);

  // Mobile : on recentre le champ qui prend le focus pour que le clavier
  // virtuel ne le recouvre pas.
  const handleFocusIn = useCallback((e: React.FocusEvent<HTMLDivElement>) => {
    const target = e.target as HTMLElement | null;
    if (!target) return;
    if (!["INPUT", "SELECT", "TEXTAREA"].includes(target.tagName)) return;
    window.setTimeout(() => {
      try {
        target.scrollIntoView({ block: "center", behavior: "smooth" });
      } catch {
        target.scrollIntoView();
      }
    }, 250);
  }, []);

  const message = stepMessages?.[currentStep - 1];

  return (
    <div className="mx-auto flex min-h-0 w-full max-w-5xl flex-1 flex-col">
      {/* Message d'accompagnement compact (mobile) */}
      {message && (
        <p className="mb-2 shrink-0 rounded-xl border border-border bg-background-pure/80 px-3 py-2 text-xs leading-snug text-foreground-soft md:hidden">
          {message}
        </p>
      )}

      <div className="grid min-h-0 flex-1 gap-5 md:grid-cols-[230px_minmax(0,1fr)] md:gap-9">
        {/* Panneau d'accompagnement (desktop) */}
        <aside className="hidden md:block md:self-start">
          <div className="rounded-2xl border border-border bg-background-pure p-5">
            <p className="kx-eyebrow mb-2 text-[10px]">
              {clientName ? `Dossier de ${clientName}` : "Votre dossier"}
            </p>
            <p className="text-sm leading-snug text-foreground-soft">{message ?? description ?? title}</p>
            {reassurance && reassurance.length > 0 && (
              <ul className="mt-4 space-y-2 border-t border-border pt-4">
                {reassurance.map((item) => (
                  <li key={item} className="flex items-start gap-2 text-xs text-muted-foreground">
                    <Check className="mt-0.5 h-3.5 w-3.5 shrink-0 text-accent" />
                    <span className="leading-snug">{item}</span>
                  </li>
                ))}
              </ul>
            )}
          </div>
        </aside>

        {/* Colonne des questions */}
        <div className="flex min-h-0 flex-col">
          <FunnelProgress currentStep={currentStep} totalSteps={totalSteps} className="mb-3 shrink-0" />

          <div className="mb-3 shrink-0 space-y-1 md:mb-4">
            <h2 className="font-display text-lg font-black leading-tight text-foreground md:text-2xl">
              {title}
            </h2>
            {description && (
              <p className="text-xs leading-snug text-muted-foreground md:text-sm">{description}</p>
            )}
          </div>

          <div
            ref={scopeRef}
            data-funnel-scroll
            onFocus={handleFocusIn}
            className="kx-fade-in min-h-0 flex-1 overflow-y-auto overflow-x-hidden pb-2"
          >
            {children}
          </div>

          {navigation && (
            <div className="shrink-0 border-t border-border pt-3">{navigation}</div>
          )}
        </div>
      </div>
    </div>
  );
};

export default FunnelContainer;
