/**
 * Transition entre sections — volontairement invisible.
 * Un simple espace neutre. Pas de halo violet (causait des bandes/rectangles
 * visibles sur Safari à cause du rendu CPU des blurs).
 */
export const SectionGlow = () => (
  <div className="h-3 sm:h-6 lg:h-12 w-full" aria-hidden="true" />
);
