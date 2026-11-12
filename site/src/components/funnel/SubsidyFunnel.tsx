import { useCallback, useEffect, useState } from "react";
import { Checkbox } from "@/components/ui/checkbox";
import { cn } from "@/lib/utils";
import FunnelContainer from "./FunnelContainer";
import FunnelStep from "./FunnelStep";
import FunnelNav from "./FunnelNav";
import FunnelField, { funnelInputClass } from "./FunnelField";
import FunnelLoading, { type LoadingPhase } from "./FunnelLoading";
import FunnelSuccess from "./FunnelSuccess";
import OptionButtons from "./OptionButtons";
import InsurerGrid from "./InsurerGrid";
import BirthDateInput from "./BirthDateInput";
import PhoneInputCH, { isValidSwissPhone } from "./PhoneInputCH";
import { useMultiStepForm } from "@/hooks/useMultiStepForm";
import { useAutoAdvance } from "@/hooks/useAutoAdvance";
import { submitLead } from "@/lib/funnel/submitLead";
import {
  CANTONS,
  FAMILY_SITUATIONS,
  FRANCHISES_ADULT,
  HEALTH_INSURERS,
  INCOME_RANGES,
  INCOME_UNLIKELY_ELIGIBLE,
  SPECIAL_SITUATIONS,
  cantonName,
  labelOf,
  ouiNon,
} from "@/data/funnelOptions";

/**
 * SubsidyFunnel — demande de subside cantonal à l'assurance maladie.
 *
 * Le subside est une aide versée par le canton, pas un produit d'assureur :
 * accompagner cette démarche ne pose aucun problème au regard du statut
 * d'intermédiaire lié. Deux règles de prudence tout de même :
 *   • on ne promet jamais un montant ni un droit. Seul le canton décide, et
 *     les barèmes changent chaque année. Le tunnel parle de vérification.
 *   • la mention d'intermédiaire lié reste affichée, parce que l'appel qui
 *     suit portera aussi sur l'assurance elle-même.
 *
 * Les réponses partent en double : la valeur technique sous sa clé, et le
 * libellé lisible sous `_labels`, pour que la feuille de suivi du conseiller
 * affiche « Groupe Mutuel » et non « groupe-mutuel ».
 */

const TOTAL_STEPS = 11;
const EMAIL_RE = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

interface SubsidyData {
  canton: string;
  postalCode: string;
  birthDate: Date | null;
  familySituation: string;
  hasCurrentInsurance: boolean | null;
  currentInsurer: string;
  currentFranchise: string;
  incomeRange: string;
  specialSituation: string;
  firstName: string;
  lastName: string;
  email: string;
  phone: string;
  consentTied: boolean;
}

const initialData: SubsidyData = {
  canton: "",
  postalCode: "",
  birthDate: null,
  familySituation: "",
  hasCurrentInsurance: null,
  currentInsurer: "",
  currentFranchise: "",
  incomeRange: "",
  specialSituation: "",
  firstName: "",
  lastName: "",
  email: "",
  phone: "",
  consentTied: false,
};

const SubsidyFunnel = () => {
  const [attempted, setAttempted] = useState(false);
  const [phase, setPhase] = useState<LoadingPhase>("analyse");
  const [screen, setScreen] = useState<"form" | "loading" | "done">("form");
  const [failed, setFailed] = useState(false);
  const [unlikely, setUnlikely] = useState(false);

  const onSubmit = useCallback(async (data: SubsidyData) => {
    setScreen("loading");
    setPhase("analyse");
    await new Promise((r) => setTimeout(r, 700));
    setPhase("preparation");

    const result = await submitLead({
      source: "subside",
      campaign: "SUBSIDE",
      firstName: data.firstName,
      lastName: data.lastName,
      email: data.email,
      phone: data.phone,
      canton: data.canton,
      postalCode: data.postalCode,
      birthDate: data.birthDate,
      consentTied: data.consentTied,
      answers: {
        familySituation: data.familySituation,
        hasCurrentInsurance: data.hasCurrentInsurance,
        currentInsurer: data.currentInsurer || null,
        currentFranchise: data.currentFranchise || null,
        incomeRange: data.incomeRange,
        specialSituation: data.specialSituation,
        _labels: {
          canton: cantonName(data.canton),
          familySituation: labelOf(FAMILY_SITUATIONS, data.familySituation),
          hasCurrentInsurance: ouiNon(data.hasCurrentInsurance),
          currentInsurer: labelOf(HEALTH_INSURERS, data.currentInsurer),
          currentFranchise:
            data.currentFranchise && data.currentFranchise !== "unknown"
              ? `CHF ${Number(data.currentFranchise).toLocaleString("fr-CH")}`
              : data.currentFranchise === "unknown"
                ? "Ne sait pas"
                : "",
          incomeRange: labelOf(INCOME_RANGES, data.incomeRange),
          specialSituation: labelOf(SPECIAL_SITUATIONS, data.specialSituation),
        },
      },
    });

    setPhase("transmission");
    await new Promise((r) => setTimeout(r, 500));
    setUnlikely(INCOME_UNLIKELY_ELIGIBLE.includes(data.incomeRange));
    setFailed(!result.ok);
    setScreen("done");
  }, []);

  const {
    currentStep,
    formData,
    isSubmitting,
    isLastStep,
    updateFormData,
    goToStep,
    nextStep,
    previousStep,
    handleSubmit,
  } = useMultiStepForm<SubsidyData>({ initialData, totalSteps: TOTAL_STEPS, onSubmit });

  const validateStep = (step: number): boolean => {
    switch (step) {
      case 1:
        return formData.canton !== "";
      case 2:
        return /^[0-9]{4}$/.test(formData.postalCode);
      case 3:
        return formData.birthDate !== null;
      case 4:
        return formData.familySituation !== "";
      case 5:
        return formData.hasCurrentInsurance !== null;
      case 6:
        return formData.currentInsurer !== "";
      case 7:
        return formData.currentFranchise !== "";
      case 8:
        return formData.incomeRange !== "";
      case 9:
        return formData.specialSituation !== "";
      case 10:
        return formData.firstName.trim() !== "" && formData.lastName.trim() !== "";
      case 11:
        return (
          EMAIL_RE.test(formData.email.trim()) &&
          isValidSwissPhone(formData.phone) &&
          formData.consentTied
        );
      default:
        return true;
    }
  };

  const canProceed = validateStep(currentStep);

  // Les messages d'erreur n'apparaissent qu'après une tentative d'avance,
  // et le compteur repart à zéro à chaque étape. Sans ce reset, on arrive
  // sur l'étape suivante avec tous ses champs déjà signalés en rouge.
  useEffect(() => {
    setAttempted(false);
  }, [currentStep]);

  // Pas d'assurance actuelle : ni l'assureur ni la franchise n'ont de sens,
  // on saute les deux étapes d'un coup.
  const handleAdvance = useCallback(() => {
    if (currentStep === 5 && formData.hasCurrentInsurance === false) {
      goToStep(8);
    } else {
      nextStep();
    }
  }, [currentStep, formData.hasCurrentInsurance, goToStep, nextStep]);

  const handlePrevious = useCallback(() => {
    if (currentStep === 8 && formData.hasCurrentInsurance === false) {
      goToStep(5);
    } else {
      previousStep();
    }
  }, [currentStep, formData.hasCurrentInsurance, goToStep, previousStep]);

  const { notify, notifyDelayed, notifyDelayedLong } = useAutoAdvance(
    currentStep,
    handleAdvance,
    canProceed,
    isLastStep,
    handleSubmit
  );

  const handleNext = () => {
    setAttempted(true);
    if (!canProceed) return;
    if (isLastStep) {
      handleSubmit();
      return;
    }
    handleAdvance();
  };

  const err = (condition: boolean, message: string) =>
    attempted && condition ? message : undefined;

  if (screen === "loading") return <FunnelLoading phase={phase} />;

  if (screen === "done") {
    return (
      <FunnelSuccess
        firstName={formData.firstName}
        failed={failed}
        nextSteps={
          unlikely
            ? [
                "Nous vérifions votre droit auprès du barème en vigueur dans votre canton.",
                "Avec le revenu indiqué, le droit au subside est peu probable, nous vous le dirons franchement.",
                "Nous regarderons alors ce qui peut réellement alléger votre prime, modèle et franchise.",
              ]
            : [
                "Nous vérifions votre droit au subside selon le barème en vigueur dans votre canton.",
                "Un conseiller vous appelle pour réunir les pièces à joindre à la demande.",
                "Nous déposons le dossier auprès de votre caisse cantonale et suivons la réponse.",
              ]
        }
      />
    );
  }

  return (
    <FunnelContainer
      title="Votre demande de subside"
      description="Quelques questions sur votre ménage, puis nous vérifions votre droit."
      currentStep={currentStep}
      totalSteps={TOTAL_STEPS}
      clientName={formData.firstName}
      reassurance={[
        "Le subside est une aide de votre canton",
        "Nous montons le dossier avec vous",
        "Gratuit et sans engagement",
      ]}
      stepMessages={[
        "Le subside est cantonal : tout dépend d'abord de votre canton de domicile.",
        "Le code postal nous permet d'identifier votre caisse cantonale.",
        "Votre âge compte dans le calcul du barème.",
        "Le droit au subside se calcule sur le ménage entier, pas sur une personne seule.",
        "Êtes-vous déjà assuré ? Le subside se verse sur une prime existante.",
        "Chez quel assureur ? Nous saurons où le subside doit être annoncé.",
        "Votre franchise actuelle, pour situer ce que vous payez aujourd'hui.",
        "Le revenu du ménage est le critère décisif. Une tranche suffit.",
        "Certaines situations ouvrent ou élargissent le droit.",
        "Presque terminé. Votre prénom et votre nom.",
        "Dernière étape : comment vous joindre.",
      ]}
      navigation={
        <FunnelNav
          currentStep={currentStep}
          onPrevious={handlePrevious}
          onNext={handleNext}
          isSubmitting={isSubmitting}
          isLastStep={isLastStep}
          canProceed={canProceed}
          lastStepLabel="Vérifier mon droit"
        />
      }
    >
      {/* Étape 1 : canton */}
      <FunnelStep isActive={currentStep === 1}>
        <FunnelField
          label="Dans quel canton habitez-vous ?"
          required
          hint="Chaque canton fixe son propre barème et ses propres plafonds."
          error={err(formData.canton === "", "Choisissez votre canton.")}
        >
          <OptionButtons
            ariaLabel="Canton de domicile"
            columns={3}
            value={formData.canton}
            onValueChange={(v) => {
              updateFormData({ canton: v });
              notify();
            }}
            options={CANTONS.slice(0, 6).map((c) => ({ value: c.code, label: c.name }))}
          />
          <div className="mt-3">
            <select
              aria-label="Autre canton"
              value={CANTONS.slice(0, 6).some((c) => c.code === formData.canton) ? "" : formData.canton}
              onChange={(e) => {
                if (!e.target.value) return;
                updateFormData({ canton: e.target.value });
                notify();
              }}
              className={funnelInputClass}
            >
              <option value="">Un autre canton…</option>
              {CANTONS.slice(6).map((c) => (
                <option key={c.code} value={c.code}>
                  {c.name}
                </option>
              ))}
            </select>
          </div>
        </FunnelField>
      </FunnelStep>

      {/* Étape 2 : code postal */}
      <FunnelStep isActive={currentStep === 2}>
        <FunnelField
          label="Quel est votre code postal ?"
          required
          error={err(!/^[0-9]{4}$/.test(formData.postalCode), "Entrez un code postal à quatre chiffres.")}
        >
          <input
            type="text"
            inputMode="numeric"
            autoComplete="postal-code"
            placeholder="1052"
            aria-label="Code postal"
            autoFocus
            value={formData.postalCode}
            onChange={(e) => {
              const next = e.target.value.replace(/\D/g, "").slice(0, 4);
              updateFormData({ postalCode: next });
              if (next.length === 4) notifyDelayed();
            }}
            className={`${funnelInputClass} max-w-[160px] text-center text-lg tracking-widest`}
          />
        </FunnelField>
      </FunnelStep>

      {/* Étape 3 : date de naissance */}
      <FunnelStep isActive={currentStep === 3}>
        <FunnelField
          label="Quelle est votre date de naissance ?"
          required
          error={err(formData.birthDate === null, "Entrez une date de naissance valide.")}
        >
          <BirthDateInput
            autoFocus
            value={formData.birthDate}
            onChange={(date) => {
              updateFormData({ birthDate: date });
              if (date) notifyDelayed();
            }}
          />
        </FunnelField>
      </FunnelStep>

      {/* Étape 4 : composition du foyer */}
      <FunnelStep isActive={currentStep === 4}>
        <FunnelField
          label="Quelle est la composition de votre foyer ?"
          required
          hint="Le droit au subside se calcule sur le ménage entier."
          error={err(formData.familySituation === "", "Choisissez une réponse.")}
        >
          <OptionButtons
            ariaLabel="Composition du foyer"
            value={formData.familySituation}
            onValueChange={(v) => {
              updateFormData({ familySituation: v });
              notify();
            }}
            options={FAMILY_SITUATIONS.map((f) => ({ value: f.value, label: f.label }))}
          />
        </FunnelField>
      </FunnelStep>

      {/* Étape 5 : déjà assuré */}
      <FunnelStep isActive={currentStep === 5}>
        <FunnelField
          label="Avez-vous déjà une assurance maladie en Suisse ?"
          required
          error={err(formData.hasCurrentInsurance === null, "Choisissez une réponse.")}
        >
          <OptionButtons
            ariaLabel="Avez-vous déjà une assurance maladie"
            value={
              formData.hasCurrentInsurance === null ? "" : formData.hasCurrentInsurance ? "yes" : "no"
            }
            onValueChange={(v) => {
              updateFormData({ hasCurrentInsurance: v === "yes" });
              notify();
            }}
            options={[
              { value: "yes", label: "Oui" },
              { value: "no", label: "Pas encore" },
            ]}
          />
        </FunnelField>
      </FunnelStep>

      {/* Étape 6 : assureur actuel */}
      <FunnelStep isActive={currentStep === 6}>
        <FunnelField
          label="Chez quel assureur êtes-vous actuellement ?"
          required
          error={err(formData.currentInsurer === "", "Choisissez votre assureur, ou Autre.")}
        >
          <InsurerGrid
            value={formData.currentInsurer}
            onValueChange={(v) => {
              updateFormData({ currentInsurer: v });
              notify();
            }}
          />
        </FunnelField>
      </FunnelStep>

      {/* Étape 7 : franchise actuelle */}
      <FunnelStep isActive={currentStep === 7}>
        <FunnelField
          label="Quelle est votre franchise actuelle ?"
          required
          hint="Elle figure sur votre police. Choisissez Je ne sais pas si vous n'êtes pas sûr, le conseiller la retrouvera."
          error={err(formData.currentFranchise === "", "Choisissez une franchise, ou Je ne sais pas.")}
        >
          <OptionButtons
            ariaLabel="Franchise actuelle"
            columns={3}
            value={formData.currentFranchise}
            onValueChange={(v) => {
              updateFormData({ currentFranchise: v });
              notify();
            }}
            options={[
              ...FRANCHISES_ADULT.map((f) => ({
                value: String(f),
                label: `${f.toLocaleString("fr-CH")} CHF`,
              })),
              { value: "unknown", label: "Je ne sais pas" },
            ]}
          />
        </FunnelField>
      </FunnelStep>

      {/* Étape 8 : revenu */}
      <FunnelStep isActive={currentStep === 8}>
        <FunnelField
          label="Quel est le revenu brut annuel de votre ménage ?"
          required
          hint="Une tranche suffit. C'est le revenu déterminant du canton qui tranchera."
          error={err(formData.incomeRange === "", "Choisissez une tranche.")}
        >
          <OptionButtons
            ariaLabel="Revenu brut annuel du ménage"
            columns={1}
            value={formData.incomeRange}
            onValueChange={(v) => {
              updateFormData({ incomeRange: v });
              notify();
            }}
            options={INCOME_RANGES.map((r) => ({ value: r.value, label: r.label }))}
          />
        </FunnelField>
      </FunnelStep>

      {/* Étape 9 : situation particulière */}
      <FunnelStep isActive={currentStep === 9}>
        <FunnelField
          label="Êtes-vous dans une de ces situations ?"
          required
          hint="Plusieurs d'entre elles ouvrent un droit même au-delà des plafonds habituels."
          error={err(formData.specialSituation === "", "Choisissez une réponse.")}
        >
          <OptionButtons
            ariaLabel="Situation particulière"
            columns={1}
            value={formData.specialSituation}
            onValueChange={(v) => {
              updateFormData({ specialSituation: v });
              notify();
            }}
            options={SPECIAL_SITUATIONS.map((s) => ({ value: s.value, label: s.label }))}
          />
        </FunnelField>
      </FunnelStep>

      {/* Étape 10 : identité */}
      <FunnelStep isActive={currentStep === 10}>
        <div className="space-y-4">
          <FunnelField
            label="Votre prénom"
            required
            error={err(formData.firstName.trim() === "", "Entrez votre prénom.")}
          >
            <input
              type="text"
              autoComplete="given-name"
              placeholder="Camille"
              autoFocus
              value={formData.firstName}
              onChange={(e) => {
                updateFormData({ firstName: e.target.value });
                notifyDelayedLong();
              }}
              className={funnelInputClass}
            />
          </FunnelField>
          <FunnelField
            label="Votre nom"
            required
            error={err(formData.lastName.trim() === "", "Entrez votre nom.")}
          >
            <input
              type="text"
              autoComplete="family-name"
              placeholder="Dupont"
              value={formData.lastName}
              onChange={(e) => {
                updateFormData({ lastName: e.target.value });
                notifyDelayedLong();
              }}
              className={funnelInputClass}
            />
          </FunnelField>
        </div>
      </FunnelStep>

      {/* Étape 11 : contact et consentement */}
      <FunnelStep isActive={currentStep === 11}>
        <div className="space-y-4">
          <FunnelField
            label="Votre adresse e-mail"
            required
            error={err(!EMAIL_RE.test(formData.email.trim()), "Entrez une adresse e-mail valide.")}
          >
            <input
              type="email"
              autoComplete="email"
              placeholder="camille.dupont@exemple.ch"
              value={formData.email}
              onChange={(e) => updateFormData({ email: e.target.value })}
              className={funnelInputClass}
            />
          </FunnelField>

          <FunnelField
            label="Votre numéro de téléphone"
            required
            error={err(!isValidSwissPhone(formData.phone), "Entrez un numéro suisse valide.")}
          >
            <PhoneInputCH value={formData.phone} onChange={(v) => updateFormData({ phone: v })} />
          </FunnelField>

          <label
            className={cn(
              "flex cursor-pointer items-start gap-3 rounded-xl border-2 bg-background-pure p-4 transition-colors",
              formData.consentTied ? "border-accent bg-accent/5" : "border-border"
            )}
          >
            <Checkbox
              checked={formData.consentTied}
              onCheckedChange={(checked) => updateFormData({ consentTied: checked === true })}
              className="mt-0.5"
            />
            <span className="text-xs leading-relaxed text-foreground-soft">
              J'autorise Klary Sàrl à vérifier mon droit au subside et à me contacter. Je comprends
              que Klary est un <strong>intermédiaire d'assurance lié</strong> au Groupe Mutuel, et
              que le subside lui-même est versé par mon canton, pas par Klary.
            </span>
          </label>
          {attempted && !formData.consentTied && (
            <p role="alert" className="text-xs font-medium text-destructive">
              Cette autorisation est nécessaire pour que nous puissions traiter votre demande.
            </p>
          )}
        </div>
      </FunnelStep>
    </FunnelContainer>
  );
};

export default SubsidyFunnel;
