import { useState, useCallback } from "react";

interface UseMultiStepFormOptions<T extends object> {
  initialData: T;
  totalSteps: number;
  onSubmit: (data: T) => Promise<void>;
}

/**
 * Moteur de tunnel multi-étapes : une question par écran.
 * Ne connaît ni le produit ni la validation, qui restent dans le formulaire.
 */
export function useMultiStepForm<T extends object>({
  initialData,
  totalSteps,
  onSubmit,
}: UseMultiStepFormOptions<T>) {
  const [currentStep, setCurrentStep] = useState(1);
  const [formData, setFormData] = useState<T>(initialData);
  const [isSubmitting, setIsSubmitting] = useState(false);
  const [errors, setErrors] = useState<Record<string, string>>({});

  const updateFormData = useCallback((updates: Partial<T>) => {
    setFormData((prev) => ({ ...prev, ...updates }));
    // Un champ que l'on vient de corriger ne doit plus afficher son erreur
    const updatedKeys = Object.keys(updates);
    setErrors((prev) => {
      const next = { ...prev };
      updatedKeys.forEach((key) => delete next[key]);
      return next;
    });
  }, []);

  const goToStep = useCallback(
    (step: number) => {
      if (step >= 1 && step <= totalSteps) setCurrentStep(step);
    },
    [totalSteps]
  );

  const nextStep = useCallback(() => {
    setCurrentStep((prev) => (prev < totalSteps ? prev + 1 : prev));
  }, [totalSteps]);

  const previousStep = useCallback(() => {
    setCurrentStep((prev) => (prev > 1 ? prev - 1 : prev));
  }, []);

  const handleSubmit = useCallback(async () => {
    setIsSubmitting(true);
    try {
      await onSubmit(formData);
    } finally {
      setIsSubmitting(false);
    }
  }, [formData, onSubmit]);

  const setFieldError = useCallback((field: string, error: string) => {
    setErrors((prev) => ({ ...prev, [field]: error }));
  }, []);

  const clearErrors = useCallback(() => setErrors({}), []);

  return {
    currentStep,
    formData,
    isSubmitting,
    errors,
    isFirstStep: currentStep === 1,
    isLastStep: currentStep === totalSteps,
    updateFormData,
    goToStep,
    nextStep,
    previousStep,
    handleSubmit,
    setFieldError,
    clearErrors,
  };
}
