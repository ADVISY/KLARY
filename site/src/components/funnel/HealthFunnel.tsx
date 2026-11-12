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
  AVAILABILITY,
  CANTONS,
  FAMILY_SITUATIONS,
  FRANCHISES_ADULT,
  LAMAL_MODELS,
} from "@/data/funnelOptions";

/**
 * HealthFunnel — tunnel assurance maladie de base et complémentaire.
 *
 * Klary est intermédiaire LIÉ au Groupe Mutuel, avec exclusivité signée. Ce
 * tunnel en tire trois conséquences, qui ne sont pas négociables :
 *   • aucune prime ni aucun prix affiché, donc aucune promesse de tarif ;
 *   • aucune mise en concurrence annoncée, aucune liste de « meilleures
 *     offres » : on prépare un dossier, un conseiller rappelle ;
 *   • le statut lié est écrit avant l'envoi et doit être accepté, ce qui
 *     matérialise l'information due au client.
 * La question « chez quel assureur êtes-vous » sert à comprendre la situation
 * actuelle du prospect, pas à la comparer à un marché.
 */

const TOTAL_STEPS = 11;
const EMAIL_RE = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

interface HealthData {
  hasCurrentInsurance: boolean | null;
  currentInsurer: string;
  familySituation: string;
  birthDate: Date | null;
  canton: string;
  postalCode: string;
  lamalModel: string;
  franchise: number;
  accidentCoverage: boolean;
  interests: {
    dental: boolean;
    hospital: boolean;
    glasses: boolean;
    alternative: boolean;
    abroad: boolean;
  };
  firstName: string;
  lastName: string;
  email: string;
  phone: string;
  availability: string;
  consentTied: boolean;
}

const initialData: HealthData = {
  hasCurrentInsurance: null,
  currentInsurer: "",
  familySituation: "",
  birthDate: null,
  canton: "",
  postalCode: "",
  lamalModel: "",
  franchise: 300,
  accidentCoverage: true,
  interests: {
    dental: false,
    hospital: false,
    glasses: false,
    alternative: false,
    abroad: false,
  },
  firstName: "",
  lastName: "",
  email: "",
  phone: "",
  availability: "",
  consentTied: false,
};

const INTEREST_LABELS: { key: keyof HealthData["interests"]; label: string; hint: string }[] = [
  { key: "dental", label: "Dentaire", hint: "Soins, orthodontie" },
  { key: "hospital", label: "Hospitalisation", hint: "Chambre semi-privée ou privée" },
  { key: "glasses", label: "Lunettes et lentilles", hint: "Correction de la vue" },
  { key: "alternative", label: "Médecine alternative", hint: "Ostéopathie, acupuncture" },
  { key: "abroad", label: "Couverture à l'étranger", hint: "Voyages et urgences" },
];

const HealthFunnel = () => {
  const [attempted, setAttempted] = useState(false);
  const [phase, setPhase] = useState<LoadingPhase>("analyse");
  const [screen, setScreen] = useState<"form" | "loading" | "done">("form");
  const [failed, setFailed] = useState(false);

  const onSubmit = useCallback(async (data: HealthData) => {
    setScreen("loading");
    setPhase("analyse");
    await new Promise((r) => setTimeout(r, 700));
    setPhase("preparation");

    const result = await submitLead({
      source: "maladie",
      campaign: "GM-MALADIE",
      firstName: data.firstName,
      lastName: data.lastName,
      email: data.email,
      phone: data.phone,
      canton: data.canton,
      postalCode: data.postalCode,
      birthDate: data.birthDate,
      consentTied: data.consentTied,
      answers: {
        hasCurrentInsurance: data.hasCurrentInsurance,
        currentInsurer: data.currentInsurer || null,
        familySituation: data.familySituation,
        lamalModel: data.lamalModel,
        franchise: data.franchise,
        accidentCoverage: data.accidentCoverage,
        interests: Object.entries(data.interests)
          .filter(([, v]) => v)
          .map(([k]) => k),
        availability: data.availability,
      },
    });

    setPhase("transmission");
    await new Promise((r) => setTimeout(r, 500));
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
  } = useMultiStepForm<HealthData>({ initialData, totalSteps: TOTAL_STEPS, onSubmit });

  const validateStep = (step: number): boolean => {
    switch (step) {
      case 1:
        return formData.hasCurrentInsurance !== null;
      case 2:
        return formData.currentInsurer !== "";
      case 3:
        return formData.familySituation !== "";
      case 4:
        return formData.birthDate !== null;
      case 5:
        return formData.canton !== "";
      case 6:
        return /^[0-9]{4}$/.test(formData.postalCode);
      case 7:
        return formData.lamalModel !== "";
      case 8:
        return true;
      case 9:
        return true;
      case 10:
        return formData.firstName.trim() !== "" && formData.lastName.trim() !== "";
      case 11:
        return (
          EMAIL_RE.test(formData.email.trim()) &&
          isValidSwissPhone(formData.phone) &&
          formData.availability !== "" &&
          formData.consentTied
        );
      default:
        return true;
    }
  };

  const canProceed = validateStep(currentStep);

  // Les messages d'erreur n'apparaissent qu'apres une tentative d'avance,
  // et le compteur repart a zero a chaque etape. Sans ce reset, on arrive
  // sur l'etape suivante avec tous ses champs deja signales en rouge.
  useEffect(() => {
    setAttempted(false);
  }, [currentStep]);

  // L'étape « assureur actuel » n'a de sens que pour qui est déjà assuré.
  const handleAdvance = useCallback(() => {
    if (currentStep === 1 && formData.hasCurrentInsurance === false) {
      goToStep(3);
    } else {
      nextStep();
    }
  }, [currentStep, formData.hasCurrentInsurance, goToStep, nextStep]);

  const handlePrevious = useCallback(() => {
    if (currentStep === 3 && formData.hasCurrentInsurance === false) {
      goToStep(1);
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
        nextSteps={[
          "Un conseiller Klary vous appelle pour vérifier votre situation et vos besoins réels.",
          "Nous préparons votre proposition Groupe Mutuel, base LAMal et complémentaires.",
          "Vous décidez librement. Aucune signature n'est demandée pendant l'appel.",
        ]}
      />
    );
  }

  return (
    <FunnelContainer
      title="Votre dossier assurance maladie"
      description="Huit questions sur votre situation, puis un conseiller vous rappelle."
      currentStep={currentStep}
      totalSteps={TOTAL_STEPS}
      clientName={formData.firstName}
      reassurance={[
        "Aucun engagement, vous gardez la main",
        "Un seul interlocuteur, pas de plateforme",
        "Vos données restent chez Klary",
      ]}
      stepMessages={[
        "On commence par votre situation actuelle : êtes-vous déjà assuré en Suisse ?",
        "Chez quel assureur êtes-vous aujourd'hui ? Cela nous dit d'où vous partez.",
        "Votre foyer détermine la structure de votre dossier.",
        "Votre âge conditionne la prime de base, qui est fixée par la loi.",
        "Les primes LAMal sont fixées par canton : dites-nous où vous habitez.",
        "Le code postal affine la région de prime à l'intérieur du canton.",
        "Le modèle d'assurance est le premier vrai levier sur votre prime.",
        "Franchise et couverture accident : deux réglages à ajuster ensemble.",
        "Et au-delà du minimum légal, qu'aimeriez-vous voir couvert ?",
        "Presque terminé. Votre prénom et votre nom.",
        "Dernière étape : comment vous joindre, et quand.",
      ]}
      navigation={
        <FunnelNav
          currentStep={currentStep}
          onPrevious={handlePrevious}
          onNext={handleNext}
          isSubmitting={isSubmitting}
          isLastStep={isLastStep}
          canProceed={canProceed}
        />
      }
    >
      {/* Étape 1 : déjà assuré */}
      <FunnelStep isActive={currentStep === 1}>
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
              { value: "no", label: "Non, j'arrive en Suisse" },
            ]}
          />
        </FunnelField>
      </FunnelStep>

      {/* Étape 2 : assureur actuel */}
      <FunnelStep isActive={currentStep === 2}>
        <FunnelField
          label="Chez quel assureur êtes-vous actuellement ?"
          required
          hint="Cliquez sur son logo. C'est votre situation de départ, rien d'autre."
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

      {/* Étape 3 : situation familiale */}
      <FunnelStep isActive={currentStep === 3}>
        <FunnelField
          label="Quelle est votre situation familiale ?"
          required
          error={err(formData.familySituation === "", "Choisissez une situation.")}
        >
          <OptionButtons
            ariaLabel="Situation familiale"
            value={formData.familySituation}
            onValueChange={(v) => {
              updateFormData({ familySituation: v });
              notify();
            }}
            options={FAMILY_SITUATIONS.map((f) => ({ value: f.value, label: f.label }))}
          />
        </FunnelField>
      </FunnelStep>

      {/* Étape 4 : date de naissance */}
      <FunnelStep isActive={currentStep === 4}>
        <FunnelField
          label="Quelle est votre date de naissance ?"
          required
          hint="Jour, mois, année."
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

      {/* Étape 5 : canton */}
      <FunnelStep isActive={currentStep === 5}>
        <FunnelField
          label="Dans quel canton habitez-vous ?"
          required
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

      {/* Étape 6 : code postal */}
      <FunnelStep isActive={currentStep === 6}>
        <FunnelField
          label="Quel est votre code postal ?"
          required
          hint="Quatre chiffres. La région de prime se joue à ce niveau."
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

      {/* Étape 7 : modèle LAMal */}
      <FunnelStep isActive={currentStep === 7}>
        <FunnelField
          label="Quel modèle d'assurance souhaitez-vous ?"
          required
          hint="Le modèle décide de votre liberté de choix du médecin, et du niveau de prime."
          error={err(formData.lamalModel === "", "Choisissez un modèle, ou Je ne sais pas.")}
        >
          <OptionButtons
            ariaLabel="Modèle d'assurance"
            columns={1}
            value={formData.lamalModel}
            onValueChange={(v) => {
              updateFormData({ lamalModel: v });
              notify();
            }}
            options={LAMAL_MODELS.map((m) => ({ value: m.value, label: m.label }))}
          />
        </FunnelField>
      </FunnelStep>

      {/* Étape 8 : franchise et accident */}
      <FunnelStep isActive={currentStep === 8}>
        <div className="space-y-6">
          <FunnelField
            label="Quelle franchise annuelle souhaitez-vous ?"
            hint="Plus la franchise est haute, plus la prime baisse, et plus vous payez vos soins vous-même."
          >
            <OptionButtons
              ariaLabel="Franchise annuelle"
              columns={3}
              value={String(formData.franchise)}
              onValueChange={(v) => updateFormData({ franchise: Number(v) })}
              options={FRANCHISES_ADULT.map((f) => ({
                value: String(f),
                label: `${f.toLocaleString("fr-CH")} CHF`,
              }))}
            />
          </FunnelField>

          <FunnelField
            label="Couverture accident"
            hint="Si vous êtes salarié, votre employeur couvre déjà les accidents selon la LAA."
          >
            <OptionButtons
              ariaLabel="Couverture accident"
              value={formData.accidentCoverage ? "yes" : "no"}
              onValueChange={(v) => updateFormData({ accidentCoverage: v === "yes" })}
              options={[
                { value: "yes", label: "À inclure" },
                { value: "no", label: "Déjà couvert par l'employeur" },
              ]}
            />
          </FunnelField>
        </div>
      </FunnelStep>

      {/* Étape 9 : complémentaires souhaitées */}
      <FunnelStep isActive={currentStep === 9}>
        <FunnelField
          label="Que souhaitez-vous couvrir au-delà du minimum légal ?"
          hint="Plusieurs réponses possibles, ou aucune. Rien n'est obligatoire ici."
        >
          <div className="space-y-2.5">
            {INTEREST_LABELS.map(({ key, label, hint }) => (
              <label
                key={key}
                className={cn(
                  "flex cursor-pointer items-start gap-3 rounded-xl border-2 bg-background-pure p-3 transition-colors hover:border-accent/50",
                  formData.interests[key] ? "border-accent bg-accent/5" : "border-border"
                )}
              >
                <Checkbox
                  checked={formData.interests[key]}
                  onCheckedChange={(checked) =>
                    updateFormData({
                      interests: { ...formData.interests, [key]: checked === true },
                    })
                  }
                  className="mt-0.5"
                />
                <span>
                  <span className="block text-sm font-semibold text-foreground">{label}</span>
                  <span className="block text-xs text-muted-foreground">{hint}</span>
                </span>
              </label>
            ))}
          </div>
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
            hint="C'est le numéro que votre conseiller appellera."
            error={err(!isValidSwissPhone(formData.phone), "Entrez un numéro suisse valide.")}
          >
            <PhoneInputCH
              value={formData.phone}
              onChange={(v) => updateFormData({ phone: v })}
            />
          </FunnelField>

          <FunnelField
            label="Quand pouvons-nous vous appeler ?"
            required
            error={err(formData.availability === "", "Choisissez un créneau.")}
          >
            <OptionButtons
              ariaLabel="Créneau de rappel"
              value={formData.availability}
              onValueChange={(v) => updateFormData({ availability: v })}
              options={AVAILABILITY.map((a) => ({ value: a.value, label: a.label }))}
            />
          </FunnelField>

          {/* Information due au client avant toute prise de contact */}
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
              Je comprends que Klary Sàrl est un <strong>intermédiaire d'assurance lié</strong> au
              Groupe Mutuel, qu'elle propose les produits de cet assureur et non une comparaison du
              marché, et qu'elle est rémunérée par lui. J'accepte d'être contacté à ce sujet.
            </span>
          </label>
          {attempted && !formData.consentTied && (
            <p role="alert" className="text-xs font-medium text-destructive">
              Cette confirmation est nécessaire avant que nous puissions vous appeler.
            </p>
          )}
        </div>
      </FunnelStep>
    </FunnelContainer>
  );
};

export default HealthFunnel;
