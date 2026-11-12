import { CheckCircle2, Clock, Phone, AlertTriangle } from "lucide-react";
import { FALLBACK_EMAIL } from "@/lib/funnel/submitLead";

/**
 * Écran de fin. Deux cas, jamais confondus :
 *  - la demande est enregistrée : on dit quoi attendre et quand.
 *  - l'enregistrement a échoué : on le dit franchement et on donne l'adresse
 *    de repli, plutôt que d'afficher un faux merci sur un prospect perdu.
 */
const FunnelSuccess = ({
  firstName,
  failed,
  nextSteps,
}: {
  firstName?: string;
  failed?: boolean;
  nextSteps: string[];
}) => {
  if (failed) {
    return (
      <div className="flex min-h-0 flex-1 items-center justify-center py-8">
        <div className="w-full max-w-lg rounded-2xl border border-destructive/30 bg-background-pure p-6 text-center md:p-8">
          <AlertTriangle className="mx-auto mb-4 h-12 w-12 text-destructive" />
          <h2 className="font-display mb-2 text-xl font-black text-foreground md:text-2xl">
            Votre demande n'a pas pu être enregistrée
          </h2>
          <p className="mb-5 text-sm leading-relaxed text-foreground-soft md:text-base">
            Nous préférons vous le dire plutôt que de vous laisser attendre un appel qui
            n'arriverait pas. Écrivez-nous et nous reprenons votre dossier à la main.
          </p>
          <a
            href={`mailto:${FALLBACK_EMAIL}?subject=Ma%20demande%20en%20ligne`}
            className="kx-btn kx-btn-accent inline-flex"
          >
            Écrire à {FALLBACK_EMAIL}
          </a>
        </div>
      </div>
    );
  }

  return (
    <div className="flex min-h-0 flex-1 items-center justify-center py-8">
      <div className="w-full max-w-lg rounded-2xl border border-border bg-background-pure p-6 text-center md:p-8">
        <CheckCircle2 className="mx-auto mb-4 h-12 w-12 text-accent" />
        <h2 className="font-display mb-2 text-xl font-black text-foreground md:text-2xl">
          {firstName ? `Merci ${firstName}, c'est enregistré` : "Merci, c'est enregistré"}
        </h2>
        <p className="mb-6 text-sm leading-relaxed text-foreground-soft md:text-base">
          Votre demande est arrivée chez nous. Voici ce qui se passe maintenant.
        </p>

        <ul className="mb-6 space-y-3 text-left">
          {nextSteps.map((step, index) => (
            <li key={step} className="flex items-start gap-3">
              <span className="mt-0.5 flex h-6 w-6 shrink-0 items-center justify-center rounded-full bg-accent/10 text-xs font-bold text-accent">
                {index + 1}
              </span>
              <span className="text-sm leading-snug text-foreground-soft">{step}</span>
            </li>
          ))}
        </ul>

        <div className="flex flex-col items-center gap-2 border-t border-border pt-5 text-xs text-muted-foreground md:flex-row md:justify-center md:gap-6">
          <span className="flex items-center gap-1.5">
            <Clock className="h-3.5 w-3.5" />
            Appel sous 24 heures ouvrables
          </span>
          <span className="flex items-center gap-1.5">
            <Phone className="h-3.5 w-3.5" />
            Depuis un numéro suisse
          </span>
        </div>
      </div>
    </div>
  );
};

export default FunnelSuccess;
