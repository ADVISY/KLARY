import { useState, useEffect, useCallback, useRef } from "react";

/**
 * Avance automatiquement à l'étape suivante dès que l'étape courante est valide.
 *
 *  - `notify()`            : choix instantané (bouton, carte, radio). Avance après 400 ms.
 *  - `notifyDelayed()`     : champ texte court (prénom, nom). Avance après 1,5 s d'inactivité.
 *  - `notifyDelayedLong()` : champ long ou sensible (téléphone). Avance après 5 s.
 *
 * Ne jamais appeler depuis une case à cocher ni un curseur : l'utilisateur doit
 * pouvoir cocher plusieurs options sans que l'écran lui échappe.
 */
export function useAutoAdvance(
  currentStep: number,
  nextStep: () => void,
  isStepValid: boolean,
  isLastStep: boolean,
  onLastStepComplete?: () => void
) {
  const [trigger, setTrigger] = useState(0);
  const [delayMs, setDelayMs] = useState(400);
  const textTimerRef = useRef<ReturnType<typeof setTimeout> | null>(null);
  const longTimerRef = useRef<ReturnType<typeof setTimeout> | null>(null);
  const lastStepFiredRef = useRef(false);

  // Remise à zéro au changement d'étape, sinon un retour en arrière
  // relancerait aussitôt l'avance automatique.
  useEffect(() => {
    setTrigger(0);
    lastStepFiredRef.current = false;
  }, [currentStep]);

  useEffect(() => {
    if (trigger === 0 || !isStepValid) return;
    if (isLastStep) {
      if (onLastStepComplete && !lastStepFiredRef.current) {
        lastStepFiredRef.current = true;
        const timer = setTimeout(() => onLastStepComplete(), delayMs);
        return () => clearTimeout(timer);
      }
      return;
    }
    const timer = setTimeout(() => nextStep(), delayMs);
    return () => clearTimeout(timer);
  }, [trigger, isStepValid, isLastStep, nextStep, delayMs, onLastStepComplete]);

  const notify = useCallback(() => {
    setDelayMs(400);
    setTrigger((prev) => prev + 1);
  }, []);

  const notifyDelayed = useCallback(() => {
    if (textTimerRef.current) clearTimeout(textTimerRef.current);
    textTimerRef.current = setTimeout(() => {
      setDelayMs(300);
      setTrigger((prev) => prev + 1);
    }, 1500);
  }, []);

  const notifyDelayedLong = useCallback(() => {
    if (longTimerRef.current) clearTimeout(longTimerRef.current);
    longTimerRef.current = setTimeout(() => {
      setDelayMs(300);
      setTrigger((prev) => prev + 1);
    }, 5000);
  }, []);

  useEffect(
    () => () => {
      if (textTimerRef.current) clearTimeout(textTimerRef.current);
      if (longTimerRef.current) clearTimeout(longTimerRef.current);
    },
    []
  );

  return { notify, notifyDelayed, notifyDelayedLong };
}
