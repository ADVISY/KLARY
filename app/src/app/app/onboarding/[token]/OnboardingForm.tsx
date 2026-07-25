"use client";

import { useState, useEffect, useRef } from "react";
import { useRouter } from "next/navigation";

/* ═══════════════════════════════════════════════════════════
   TYPES
═══════════════════════════════════════════════════════════ */

type Child = {
  first_name: string;
  last_name: string;
  dob: string;
  relation: string;
  address: string;
};

const EMPTY_CHILD: Child = {
  first_name: "",
  last_name: "",
  dob: "",
  relation: "",
  address: "",
};

const DOC_DEFS = [
  {
    key: "id_document",
    label: "Carte d'identité (recto + verso)",
    required: true,
  },
  { key: "passport", label: "Passeport", required: false },
  { key: "avs_card", label: "Carte AVS", required: true },
  { key: "rib", label: "RIB / relevé bancaire", required: true },
  {
    key: "permis_sejour",
    label: "Permis de séjour (si étranger)",
    required: false,
  },
  {
    key: "permis_conduire",
    label: "Permis de conduire (si vous en avez)",
    required: false,
  },
  {
    key: "photo_badge",
    label: "Photo d'identité (badge & trombinoscope)",
    required: true,
  },
  {
    key: "casier_judiciaire",
    label: "Extrait de casier judiciaire",
    required: true,
  },
  {
    key: "poursuites",
    label: "Extrait de l'office des poursuites",
    required: true,
  },
  { key: "lpp_exit", label: "Certificat de sortie LPP", required: false },
] as const;

const CONDITIONAL_DOCS = [
  { key: "acte_mariage", label: "Acte de mariage", requiredWhen: "marie" },
  {
    key: "jugement_divorce",
    label: "Jugement de divorce",
    requiredWhen: "divorce",
  },
] as const;

const CANTONS = [
  "VD","GE","VS","FR","NE","JU","BE","ZH","BS","BL","SG","AG","TI",
  "LU","SO","SH","AR","AI","GL","GR","NW","OW","SZ","TG","UR","ZG",
];

const STEP_LABELS = [
  "Bienvenue",
  "Vous",
  "Adresses",
  "Situation",
  "Famille",
  "Finances",
  "Documents",
  "Envoi",
];

/* ═══════════════════════════════════════════════════════════
   COMPOSANT PRINCIPAL
═══════════════════════════════════════════════════════════ */

export function OnboardingForm({
  token,
  candidateFirstName,
  candidateLastName,
  positionApplied,
}: {
  token: string;
  candidateFirstName: string;
  candidateLastName: string;
  positionApplied: string;
}) {
  const router = useRouter();
  const [step, setStep] = useState(0);
  const [submitting, setSubmitting] = useState(false);
  const [error, setError] = useState<string | null>(null);

  // État conditionnel visible dans plusieurs steps
  const [maritalStatus, setMaritalStatus] = useState<string>("");
  const [unemploymentStatus, setUnemploymentStatus] =
    useState<"non" | "oui">("non");
  const [drivingLicense, setDrivingLicense] = useState<"non" | "oui">("non");
  const [drivingTypes, setDrivingTypes] = useState<string[]>([]);
  const [children, setChildren] = useState<Child[]>([]);
  const [files, setFiles] = useState<Record<string, File>>({});

  const isMarried = ["marie", "pacs"].includes(maritalStatus);
  const isDivorced = maritalStatus === "divorce";

  const formRef = useRef<HTMLFormElement>(null);
  const totalSteps = STEP_LABELS.length;

  // Auto-scroll top à chaque changement de step
  useEffect(() => {
    window.scrollTo({ top: 0, behavior: "smooth" });
  }, [step]);

  const goNext = () => {
    // Validation basique navigateur sur les inputs required visibles
    if (formRef.current) {
      const invalidVisible = Array.from(
        formRef.current.querySelectorAll<HTMLInputElement | HTMLSelectElement>(
          `[data-step="${step}"] [required]`
        )
      ).find((el) => !el.checkValidity());
      if (invalidVisible) {
        invalidVisible.reportValidity();
        return;
      }
    }
    setStep((s) => Math.min(totalSteps - 1, s + 1));
  };
  const goPrev = () => setStep((s) => Math.max(0, s - 1));

  const updateChild = (idx: number, field: keyof Child, value: string) => {
    setChildren((prev) =>
      prev.map((c, i) => (i === idx ? { ...c, [field]: value } : c))
    );
  };
  const addChild = () => setChildren((prev) => [...prev, { ...EMPTY_CHILD }]);
  const removeChild = (idx: number) =>
    setChildren((prev) => prev.filter((_, i) => i !== idx));

  const toggleDrivingType = (type: string) => {
    setDrivingTypes((prev) =>
      prev.includes(type) ? prev.filter((t) => t !== type) : [...prev, type]
    );
  };

  const handleFile = (key: string, file: File | null) => {
    setFiles((prev) => {
      const next = { ...prev };
      if (file) next[key] = file;
      else delete next[key];
      return next;
    });
  };

  const handleSubmit = async (e: React.FormEvent<HTMLFormElement>) => {
    e.preventDefault();
    setError(null);
    setSubmitting(true);
    try {
      const fd = new FormData(e.currentTarget);
      fd.append("token", token);
      fd.append(
        "children_json",
        JSON.stringify(children.filter((c) => c.first_name || c.last_name))
      );
      fd.append("driving_license_types", drivingTypes.join(","));

      // Injecter les fichiers gérés en state (drag-and-drop)
      for (const [key, file] of Object.entries(files)) {
        fd.set(`doc_${key}`, file);
      }

      const res = await fetch("/api/onboarding/submit", {
        method: "POST",
        body: fd,
      });
      const data = await res.json();
      if (!res.ok) {
        setError(
          data?.error ||
            "Erreur d'enregistrement. Réessayez ou contactez rh@klary.ch."
        );
        setSubmitting(false);
        return;
      }
      router.refresh();
    } catch (err) {
      setError("Erreur réseau. Réessayez.");
      setSubmitting(false);
    }
  };

  return (
    <div>
      {/* PROGRESS BAR */}
      <div className="mb-8">
        <div className="flex items-center justify-between mb-2 text-xs">
          <span className="font-semibold text-klary-navy">
            Étape {step + 1} / {totalSteps}
            <span className="ml-2 text-klary-orange">
              {STEP_LABELS[step]}
            </span>
          </span>
          <span className="text-klary-grey">
            {Math.round(((step + 1) / totalSteps) * 100)} %
          </span>
        </div>
        <div className="h-2 bg-klary-light-grey rounded-full overflow-hidden">
          <div
            className="h-full bg-klary-orange transition-all duration-500 ease-out"
            style={{ width: `${((step + 1) / totalSteps) * 100}%` }}
          />
        </div>
        <div className="flex items-center justify-between mt-3">
          {STEP_LABELS.map((label, i) => (
            <button
              key={i}
              type="button"
              onClick={() => i < step && setStep(i)}
              className={`text-[10px] uppercase tracking-widest font-bold transition ${
                i === step
                  ? "text-klary-orange"
                  : i < step
                  ? "text-klary-navy hover:text-klary-orange cursor-pointer"
                  : "text-klary-grey/40 cursor-default"
              }`}
              disabled={i > step}
            >
              {i < step ? "✓ " : ""}
              {i + 1}
            </button>
          ))}
        </div>
      </div>

      <form ref={formRef} onSubmit={handleSubmit}>
        {/* STEP 0 — BIENVENUE */}
        <StepPanel active={step === 0} step={0}>
          <div className="text-center py-6">
            <div className="text-5xl mb-4">👋</div>
            <h2 className="text-2xl font-bold text-klary-navy mb-3">
              Bienvenue {candidateFirstName} !
            </h2>
            <p className="text-klary-grey leading-relaxed max-w-lg mx-auto">
              Ce formulaire nous permet de préparer votre contrat et votre
              premier salaire. Ça prend environ <strong>10 minutes</strong>.
              Vous pouvez naviguer entre les étapes librement.
            </p>
          </div>

          <div className="p-5 bg-klary-cream rounded-2xl">
            <div className="text-xs font-bold uppercase tracking-widest text-klary-orange mb-3">
              📋 À préparer avant de commencer
            </div>
            <ul className="text-sm text-klary-ink space-y-2">
              <li className="flex gap-2"><span>✓</span>Carte d'identité (recto + verso)</li>
              <li className="flex gap-2"><span>✓</span>Carte AVS ou carte d'assuré LAMal</li>
              <li className="flex gap-2"><span>✓</span>RIB ou relevé bancaire avec IBAN</li>
              <li className="flex gap-2"><span>✓</span>Permis de séjour (si étranger)</li>
              <li className="flex gap-2"><span>✓</span>Photo d'identité (JPG ou PNG)</li>
              <li className="flex gap-2"><span>✓</span>Extrait de casier judiciaire</li>
              <li className="flex gap-2"><span>✓</span>Extrait de l'office des poursuites</li>
              <li className="flex gap-2"><span>✓</span>Certificat de sortie LPP (précédent employeur, si applicable)</li>
            </ul>
          </div>

          <div className="mt-6 p-4 bg-blue-50 border-l-4 border-blue-400 rounded text-sm text-blue-900">
            💡 <strong>Astuce :</strong> Vous pouvez glisser-déposer vos
            documents directement sur les zones prévues, ou cliquer dessus
            pour les sélectionner.
          </div>
        </StepPanel>

        {/* STEP 1 — VOUS (identité + filiation) */}
        <StepPanel active={step === 1} step={1}>
          <Section title="Qui êtes-vous ?" icon="👤">
            <Field label="Date de naissance" required>
              <input
                type="date"
                name="date_of_birth"
                required
                className="input"
              />
            </Field>
            <Field label="Genre" required>
              <select name="gender" required className="input">
                <option value="">— Sélectionnez —</option>
                <option value="M">Masculin</option>
                <option value="F">Féminin</option>
                <option value="autre">Autre</option>
              </select>
            </Field>
            <Field label="Nationalité" required>
              <input
                type="text"
                name="nationality"
                required
                placeholder="Suisse, Française…"
                className="input"
              />
            </Field>
            <Field label="État civil" required>
              <select
                name="marital_status"
                required
                className="input"
                value={maritalStatus}
                onChange={(e) => setMaritalStatus(e.target.value)}
              >
                <option value="">— Sélectionnez —</option>
                <option value="celibataire">Célibataire</option>
                <option value="marie">Marié·e</option>
                <option value="pacs">PACS / Concubinage</option>
                <option value="divorce">Divorcé·e</option>
                <option value="veuf">Veuf·ve</option>
              </select>
            </Field>
            <Field label="Ville de naissance" required>
              <input
                type="text"
                name="birth_city"
                required
                className="input"
              />
            </Field>
            <Field label="Pays de naissance" required>
              <input
                type="text"
                name="birth_country"
                required
                className="input"
              />
            </Field>
            <Field label="Lieu d'origine (si Suisse)">
              <input
                type="text"
                name="place_of_origin"
                placeholder="Commune d'origine"
                className="input"
              />
            </Field>
            <Field label="N° AVS" required>
              <input
                type="text"
                name="avs_number"
                required
                placeholder="756.1234.5678.90"
                className="input"
              />
            </Field>
            <Field label="Permis de séjour (si étranger)">
              <input
                type="text"
                name="residence_permit"
                placeholder="B, C, L, G, Ci… ou 'sans objet'"
                className="input"
              />
            </Field>
          </Section>

          <Section title="Vos parents" icon="🌳">
            <Field label="Prénom du père">
              <input type="text" name="father_first_name" className="input" />
            </Field>
            <Field label="Nom du père">
              <input type="text" name="father_last_name" className="input" />
            </Field>
            <Field label="Prénom de la mère">
              <input type="text" name="mother_first_name" className="input" />
            </Field>
            <Field label="Nom de jeune fille de la mère">
              <input
                type="text"
                name="mother_last_name"
                placeholder="Nom de naissance"
                className="input"
              />
            </Field>
          </Section>

          <Section title="Vos coordonnées" icon="📞">
            <Field label="Téléphone mobile" required>
              <input
                type="tel"
                name="phone_mobile"
                required
                placeholder="+41 79 xxx xx xx"
                className="input"
              />
            </Field>
            <Field label="Téléphone fixe">
              <input
                type="tel"
                name="phone_landline"
                placeholder="+41 21 xxx xx xx"
                className="input"
              />
            </Field>
            <Field label="Email personnel (si différent)">
              <input type="email" name="personal_email" className="input" />
            </Field>
          </Section>
        </StepPanel>

        {/* STEP 2 — ADRESSES */}
        <StepPanel active={step === 2} step={2}>
          <Section title="Adresse en Suisse" icon="🏠">
            <Field label="Rue + numéro" required>
              <input
                type="text"
                name="postal_street"
                required
                className="input"
              />
            </Field>
            <Field label="Code postal" required>
              <input
                type="text"
                name="postal_zip"
                required
                placeholder="1052"
                className="input"
              />
            </Field>
            <Field label="Ville" required>
              <input
                type="text"
                name="postal_city"
                required
                className="input"
              />
            </Field>
            <Field label="Canton" required>
              <select name="postal_canton" required className="input">
                <option value="">— Canton —</option>
                {CANTONS.map((c) => (
                  <option key={c} value={c}>{c}</option>
                ))}
              </select>
            </Field>
          </Section>

          <Section
            title="Adresse à l'étranger (optionnel)"
            icon="🌍"
            subtitle="Si vous êtes frontalier ou avez une adresse familiale hors Suisse"
          >
            <Field label="Rue + numéro">
              <input type="text" name="foreign_street" className="input" />
            </Field>
            <Field label="Ville / région">
              <input type="text" name="foreign_city" className="input" />
            </Field>
            <Field label="Pays">
              <input
                type="text"
                name="foreign_country"
                placeholder="France, Portugal, Maroc…"
                className="input"
              />
            </Field>
          </Section>
        </StepPanel>

        {/* STEP 3 — SITUATION (permis + chômage) */}
        <StepPanel active={step === 3} step={3}>
          <Section title="Permis de conduire" icon="🚗">
            <Field label="Avez-vous le permis ?" required>
              <ButtonToggle
                name="driving_license"
                value={drivingLicense}
                onChange={(v) => setDrivingLicense(v as any)}
                options={[
                  { value: "non", label: "Non" },
                  { value: "oui", label: "Oui" },
                ]}
              />
            </Field>
            {drivingLicense === "oui" && (
              <div className="md:col-span-2">
                <div className="text-xs font-semibold text-klary-ink mb-2">
                  Types de permis (cochez tous ceux que vous avez)
                </div>
                <div className="flex flex-wrap gap-2">
                  {["Auto", "Moto", "Poids lourd", "Bateau"].map((t) => {
                    const active = drivingTypes.includes(t);
                    return (
                      <button
                        key={t}
                        type="button"
                        onClick={() => toggleDrivingType(t)}
                        className={`px-4 py-2 rounded-lg border-2 text-sm font-semibold transition ${
                          active
                            ? "border-klary-orange bg-klary-orange text-white"
                            : "border-klary-light-grey text-klary-navy hover:border-klary-orange"
                        }`}
                      >
                        {active ? "✓ " : ""}{t}
                      </button>
                    );
                  })}
                </div>
              </div>
            )}
          </Section>

          <Section title="Statut chômage" icon="💼">
            <Field label="Êtes-vous actuellement au chômage ?" required>
              <ButtonToggle
                name="unemployment_status"
                value={unemploymentStatus}
                onChange={(v) => setUnemploymentStatus(v as any)}
                options={[
                  { value: "non", label: "Non" },
                  { value: "oui", label: "Oui" },
                ]}
              />
            </Field>
            {unemploymentStatus === "oui" && (
              <>
                <Field label="Nom de la caisse">
                  <input
                    type="text"
                    name="unemployment_fund_name"
                    className="input"
                  />
                </Field>
                <Field label="Adresse de la caisse">
                  <input
                    type="text"
                    name="unemployment_fund_address"
                    className="input"
                  />
                </Field>
              </>
            )}
          </Section>
        </StepPanel>

        {/* STEP 4 — FAMILLE (conjoint + enfants) */}
        <StepPanel active={step === 4} step={4}>
          {(isMarried || maritalStatus === "veuf") && (
            <Section
              title={isMarried ? "Conjoint / partenaire" : "Ancien conjoint"}
              icon="💍"
            >
              <Field label="Date de mariage / PACS">
                <input type="date" name="marriage_date" className="input" />
              </Field>
              <Field label="Prénom conjoint">
                <input type="text" name="spouse_first_name" className="input" />
              </Field>
              <Field label="Nom conjoint">
                <input type="text" name="spouse_last_name" className="input" />
              </Field>
              <Field label="Date de naissance conjoint">
                <input type="date" name="spouse_dob" className="input" />
              </Field>
              <Field label="Nationalité conjoint">
                <input
                  type="text"
                  name="spouse_nationality"
                  className="input"
                />
              </Field>
              <Field label="Permis conjoint">
                <input
                  type="text"
                  name="spouse_permit"
                  placeholder="B, C, G, Ci…"
                  className="input"
                />
              </Field>
              <Field label="Situation professionnelle conjoint">
                <select name="spouse_situation" className="input">
                  <option value="">— Sélectionnez —</option>
                  <option value="salarie">Salarié·e</option>
                  <option value="indemnites">
                    Perçoit indemnités d'assurance
                  </option>
                  <option value="independant">Indépendant·e</option>
                  <option value="sans_activite">Sans activité lucrative</option>
                  <option value="sans_objet">Sans objet</option>
                </select>
              </Field>
              <Field label="Depuis quand">
                <input
                  type="date"
                  name="spouse_situation_since"
                  className="input"
                />
              </Field>
              <Field label="Taux d'activité (%)">
                <input
                  type="text"
                  name="spouse_activity_rate"
                  placeholder="80"
                  className="input"
                />
              </Field>
              <Field label="Lieu d'activité">
                <input
                  type="text"
                  name="spouse_activity_location"
                  className="input"
                />
              </Field>
              <Field label="Alloc familiales CH ?">
                <select name="spouse_alloc_ch" className="input">
                  <option value="sans_objet">Sans objet</option>
                  <option value="oui">Oui</option>
                  <option value="non">Non</option>
                </select>
              </Field>
              <Field label="Alloc familiales étranger ?">
                <select name="spouse_alloc_foreign" className="input">
                  <option value="sans_objet">Sans objet</option>
                  <option value="oui">Oui</option>
                  <option value="non">Non</option>
                </select>
              </Field>
            </Section>
          )}

          <Section title="Enfants à charge" icon="👶" subtitle="Âge maximum 25 ans">
            <Field label="Nombre d'enfants à charge">
              <input
                type="number"
                name="children_count"
                min={0}
                max={20}
                placeholder="0"
                className="input"
              />
            </Field>
            <div />
            <div className="md:col-span-2 space-y-3">
              {children.map((child, idx) => (
                <div
                  key={idx}
                  className="p-4 border border-klary-light-grey rounded-xl bg-klary-cream/40"
                >
                  <div className="flex items-center justify-between mb-3">
                    <div className="text-xs font-bold uppercase tracking-widest text-klary-orange">
                      Enfant #{idx + 1}
                    </div>
                    <button
                      type="button"
                      onClick={() => removeChild(idx)}
                      className="text-xs text-red-600 hover:underline"
                    >
                      Retirer
                    </button>
                  </div>
                  <div className="grid grid-cols-1 md:grid-cols-2 gap-3">
                    <input
                      type="text"
                      placeholder="Prénom"
                      value={child.first_name}
                      onChange={(e) => updateChild(idx, "first_name", e.target.value)}
                      className="input"
                    />
                    <input
                      type="text"
                      placeholder="Nom"
                      value={child.last_name}
                      onChange={(e) => updateChild(idx, "last_name", e.target.value)}
                      className="input"
                    />
                    <input
                      type="date"
                      value={child.dob}
                      onChange={(e) => updateChild(idx, "dob", e.target.value)}
                      className="input"
                    />
                    <input
                      type="text"
                      placeholder="Parenté (enfant, adopté, conjoint…)"
                      value={child.relation}
                      onChange={(e) => updateChild(idx, "relation", e.target.value)}
                      className="input"
                    />
                    <input
                      type="text"
                      placeholder="Domicile (si différent — sinon laisser vide)"
                      value={child.address}
                      onChange={(e) => updateChild(idx, "address", e.target.value)}
                      className="input md:col-span-2"
                    />
                  </div>
                </div>
              ))}
              <button
                type="button"
                onClick={addChild}
                className="w-full py-3 border-2 border-dashed border-klary-light-grey rounded-xl text-sm text-klary-grey hover:border-klary-orange hover:text-klary-orange hover:bg-klary-orange/5 transition font-semibold"
              >
                + Ajouter un enfant
              </button>
            </div>

            <Field label="Demandez-vous les allocations familiales ?">
              <select name="requests_family_allowances" className="input">
                <option value="">— Sélectionnez —</option>
                <option value="oui">Oui</option>
                <option value="non">Non</option>
              </select>
            </Field>
            <Field label="Exercez-vous une 2ᵉ activité ?">
              <select name="secondary_activity" className="input">
                <option value="">— Sélectionnez —</option>
                <option value="oui">Oui</option>
                <option value="non">Non</option>
              </select>
            </Field>
            <Field label="Si oui, à quel taux (%)">
              <input
                type="text"
                name="secondary_activity_rate"
                placeholder="20"
                className="input"
              />
            </Field>
          </Section>

          <Section title="Contact d'urgence" icon="🚨">
            <Field label="Nom complet" required>
              <input
                type="text"
                name="emergency_name"
                required
                className="input"
              />
            </Field>
            <Field label="Lien de parenté" required>
              <input
                type="text"
                name="emergency_relation"
                required
                placeholder="Conjoint, parent, ami…"
                className="input"
              />
            </Field>
            <Field label="Téléphone" required>
              <input
                type="tel"
                name="emergency_phone"
                required
                className="input"
              />
            </Field>
          </Section>
        </StepPanel>

        {/* STEP 5 — FINANCES (banque + fiscalité + prévoyance) */}
        <StepPanel active={step === 5} step={5}>
          <Section title="Banque (virement du salaire)" icon="🏦">
            <Field label="IBAN" required>
              <input
                type="text"
                name="bank_iban"
                required
                placeholder="CH93 0076 2011 6238 5295 7"
                className="input font-mono"
              />
            </Field>
            <Field label="Nom de la banque" required>
              <input
                type="text"
                name="bank_name"
                required
                placeholder="UBS, Raiffeisen, PostFinance…"
                className="input"
              />
            </Field>
            <Field label="Titulaire du compte" required>
              <input
                type="text"
                name="bank_holder"
                required
                defaultValue={`${candidateFirstName} ${candidateLastName}`}
                className="input"
              />
            </Field>
            <Field label="Localité de la banque">
              <input type="text" name="bank_locality" className="input" />
            </Field>
            <div className="md:col-span-2">
              <label className="flex items-start gap-3 p-3 bg-klary-cream/60 rounded-lg text-sm cursor-pointer">
                <input
                  type="checkbox"
                  name="authorize_email_payslip"
                  value="on"
                  defaultChecked
                  className="mt-0.5 accent-klary-orange w-4 h-4 shrink-0"
                />
                <span>
                  J'autorise Klary à me transmettre mes bulletins de salaire
                  par email (mon email personnel).
                </span>
              </label>
            </div>
          </Section>

          <Section title="Fiscalité" icon="📋">
            <Field label="Confession">
              <select name="religion" className="input">
                <option value="">— Sans confession —</option>
                <option value="protestante">Protestante réformée</option>
                <option value="catholique_romaine">Catholique romaine</option>
                <option value="catholique_chretienne">
                  Catholique chrétienne
                </option>
                <option value="autre">Autre</option>
                <option value="sans">Sans confession</option>
              </select>
            </Field>
            <Field label="Votre conjoint travaille ?">
              <select name="spouse_working" className="input">
                <option value="sans_objet">Sans objet</option>
                <option value="oui">Oui</option>
                <option value="non">Non</option>
              </select>
            </Field>
            <Field label="Salaire brut annuel conjoint (si applicable)">
              <input
                type="text"
                name="spouse_income"
                placeholder="CHF 70'000 — ou laisser vide"
                className="input"
              />
            </Field>
          </Section>

          <Section title="Prévoyance (2ᵉ pilier)" icon="🏦">
            <Field label="Caisse LPP précédente">
              <input
                type="text"
                name="prev_lpp_fund"
                placeholder="AXA, Swiss Life, Vita…"
                className="input"
              />
            </Field>
            <Field label="N° affiliation de sortie">
              <input type="text" name="prev_lpp_id" className="input" />
            </Field>
            <Field label="Compte de libre passage (si existant)">
              <input
                type="text"
                name="libre_passage"
                placeholder="Institution + n° compte — ou 'aucun'"
                className="input"
              />
            </Field>
          </Section>
        </StepPanel>

        {/* STEP 6 — DOCUMENTS (drag & drop) */}
        <StepPanel active={step === 6} step={6}>
          <div className="mb-6">
            <h2 className="text-xl font-bold text-klary-navy mb-2">
              📎 Vos documents
            </h2>
            <p className="text-sm text-klary-grey">
              Glissez-déposez vos fichiers dans les zones ci-dessous, ou cliquez
              pour les sélectionner. <strong>PDF, JPG, PNG</strong> — max 5 Mo
              par fichier. Les documents doivent être <strong>en cours de validité</strong>.
            </p>
          </div>

          <div className="space-y-4">
            {DOC_DEFS.map((doc) => (
              <DropZone
                key={doc.key}
                docKey={doc.key}
                label={doc.label}
                required={doc.required}
                file={files[doc.key] || null}
                onFileChange={(f) => handleFile(doc.key, f)}
                dateField={
                  doc.key === "id_document"
                    ? "id_valid_until"
                    : doc.key === "passport"
                    ? "passport_valid_until"
                    : doc.key === "permis_sejour"
                    ? "permis_valid_until"
                    : undefined
                }
              />
            ))}

            {/* Docs conditionnels selon état civil */}
            {isMarried && (
              <DropZone
                docKey="acte_mariage"
                label="Acte de mariage"
                required
                file={files["acte_mariage"] || null}
                onFileChange={(f) => handleFile("acte_mariage", f)}
              />
            )}
            {isDivorced && (
              <DropZone
                docKey="jugement_divorce"
                label="Jugement de divorce"
                required
                file={files["jugement_divorce"] || null}
                onFileChange={(f) => handleFile("jugement_divorce", f)}
              />
            )}
          </div>
        </StepPanel>

        {/* STEP 7 — ENVOI (récap + consentement) */}
        <StepPanel active={step === 7} step={7}>
          <div className="text-center py-4">
            <div className="text-5xl mb-3">✓</div>
            <h2 className="text-2xl font-bold text-klary-navy mb-3">
              Presque terminé !
            </h2>
            <p className="text-klary-grey">
              Vérifiez rapidement les informations puis validez l'envoi.
            </p>
          </div>

          <div className="p-5 bg-klary-cream rounded-2xl mb-6">
            <div className="text-xs font-bold uppercase tracking-widest text-klary-orange mb-3">
              Récapitulatif rapide
            </div>
            <ul className="text-sm text-klary-ink space-y-2">
              <li className="flex justify-between">
                <span className="text-klary-grey">Candidat</span>
                <strong>{candidateFirstName} {candidateLastName}</strong>
              </li>
              {positionApplied && (
                <li className="flex justify-between">
                  <span className="text-klary-grey">Poste</span>
                  <strong>{positionApplied}</strong>
                </li>
              )}
              <li className="flex justify-between">
                <span className="text-klary-grey">État civil</span>
                <strong>{maritalStatus || "—"}</strong>
              </li>
              <li className="flex justify-between">
                <span className="text-klary-grey">Enfants à charge</span>
                <strong>{children.filter(c => c.first_name).length}</strong>
              </li>
              <li className="flex justify-between">
                <span className="text-klary-grey">Documents téléversés</span>
                <strong>{Object.keys(files).length}</strong>
              </li>
            </ul>
          </div>

          <label className="flex items-start gap-3 p-4 bg-klary-cream rounded-xl border-l-4 border-klary-orange cursor-pointer">
            <input
              type="checkbox"
              name="consent"
              value="on"
              required
              className="mt-1 accent-klary-orange w-4 h-4 shrink-0"
            />
            <span className="text-sm text-klary-ink leading-relaxed">
              J'atteste que les informations transmises sont exactes. Je consens
              au traitement de mes données personnelles par Klary Sàrl aux
              fins de mon contrat de travail, conformément à la nLPD. Les
              documents sont conservés sur serveurs sécurisés en Suisse.
            </span>
          </label>

          {error && (
            <div className="mt-4 p-4 bg-red-50 border-l-4 border-red-400 rounded text-sm text-red-800">
              {error}
            </div>
          )}
        </StepPanel>

        {/* NAV BUTTONS */}
        <div className="flex items-center justify-between mt-8 pt-6 border-t border-klary-light-grey">
          <button
            type="button"
            onClick={goPrev}
            disabled={step === 0 || submitting}
            className="px-5 py-3 rounded-xl font-semibold text-sm text-klary-navy border border-klary-light-grey hover:border-klary-navy disabled:opacity-30 disabled:cursor-not-allowed transition"
          >
            ← Précédent
          </button>

          {step < totalSteps - 1 ? (
            <button
              type="button"
              onClick={goNext}
              className="px-6 py-3 rounded-xl font-bold text-white bg-klary-orange hover:bg-klary-orange/90 transition text-sm"
            >
              Suivant →
            </button>
          ) : (
            <button
              type="submit"
              disabled={submitting}
              className={`px-8 py-3 rounded-xl font-bold text-white transition text-sm ${
                submitting
                  ? "bg-klary-grey/40 cursor-not-allowed"
                  : "bg-klary-orange hover:bg-klary-orange/90"
              }`}
            >
              {submitting ? "Envoi en cours…" : "Envoyer mon dossier ✓"}
            </button>
          )}
        </div>
      </form>

      <style jsx>{`
        .input {
          width: 100%;
          padding: 10px 14px;
          border: 1px solid #ddd9e8;
          border-radius: 8px;
          background: white;
          font-size: 14px;
          color: #1f1b4b;
          transition: border-color 0.15s;
        }
        .input:focus {
          outline: none;
          border-color: #f0651f;
          box-shadow: 0 0 0 3px rgba(240, 101, 31, 0.1);
        }
      `}</style>
    </div>
  );
}

/* ═══════════════════════════════════════════════════════════
   COMPOSANTS RÉUTILISABLES
═══════════════════════════════════════════════════════════ */

function StepPanel({
  active,
  step,
  children,
}: {
  active: boolean;
  step: number;
  children: React.ReactNode;
}) {
  return (
    <div
      data-step={step}
      className={active ? "space-y-6" : "hidden"}
      aria-hidden={!active}
    >
      {children}
    </div>
  );
}

function Section({
  title,
  icon,
  subtitle,
  children,
}: {
  title: string;
  icon?: string;
  subtitle?: string;
  children: React.ReactNode;
}) {
  return (
    <div className="bg-white rounded-2xl border border-klary-light-grey p-6">
      <div className="flex items-baseline gap-2 mb-1">
        {icon && <span className="text-xl">{icon}</span>}
        <h3 className="text-lg font-bold text-klary-navy">{title}</h3>
      </div>
      {subtitle && (
        <p className="text-xs text-klary-grey mb-4">{subtitle}</p>
      )}
      <div className="grid grid-cols-1 md:grid-cols-2 gap-4 mt-4">
        {children}
      </div>
    </div>
  );
}

function Field({
  label,
  required,
  children,
}: {
  label: string;
  required?: boolean;
  children: React.ReactNode;
}) {
  return (
    <div>
      <label className="block text-xs font-semibold text-klary-ink mb-1.5">
        {label} {required && <span className="text-klary-orange">*</span>}
      </label>
      {children}
    </div>
  );
}

function ButtonToggle({
  name,
  value,
  onChange,
  options,
}: {
  name: string;
  value: string;
  onChange: (v: string) => void;
  options: { value: string; label: string }[];
}) {
  return (
    <div className="flex gap-2">
      {options.map((o) => (
        <button
          key={o.value}
          type="button"
          onClick={() => onChange(o.value)}
          className={`flex-1 px-4 py-2.5 rounded-lg border-2 text-sm font-semibold transition ${
            value === o.value
              ? "border-klary-orange bg-klary-orange text-white"
              : "border-klary-light-grey text-klary-navy hover:border-klary-orange"
          }`}
        >
          {o.label}
        </button>
      ))}
      <input type="hidden" name={name} value={value} />
    </div>
  );
}

/* ═══════════════════════════════════════════════════════════
   DROPZONE — Drag & drop de document
═══════════════════════════════════════════════════════════ */

function DropZone({
  docKey,
  label,
  required,
  file,
  onFileChange,
  dateField,
}: {
  docKey: string;
  label: string;
  required?: boolean;
  file: File | null;
  onFileChange: (file: File | null) => void;
  dateField?: string;
}) {
  const [drag, setDrag] = useState(false);
  const [err, setErr] = useState<string | null>(null);
  const inputRef = useRef<HTMLInputElement>(null);

  const MAX = 5 * 1024 * 1024;
  const ACCEPT = [
    "application/pdf",
    "image/jpeg",
    "image/jpg",
    "image/png",
    "application/msword",
    "application/vnd.openxmlformats-officedocument.wordprocessingml.document",
  ];

  const validate = (f: File): string | null => {
    if (f.size > MAX) return `Fichier trop lourd (${(f.size / 1024 / 1024).toFixed(1)} Mo — max 5 Mo)`;
    if (!ACCEPT.includes(f.type)) return "Format non accepté (PDF, JPG, PNG, DOC uniquement)";
    return null;
  };

  const setFile = (f: File | null) => {
    setErr(null);
    if (!f) {
      onFileChange(null);
      return;
    }
    const error = validate(f);
    if (error) {
      setErr(error);
      return;
    }
    onFileChange(f);
  };

  const onDragOver = (e: React.DragEvent) => {
    e.preventDefault();
    setDrag(true);
  };
  const onDragLeave = () => setDrag(false);
  const onDrop = (e: React.DragEvent) => {
    e.preventDefault();
    setDrag(false);
    const f = e.dataTransfer.files?.[0];
    if (f) setFile(f);
  };

  const openPicker = () => inputRef.current?.click();

  const sizeLabel = (bytes: number) =>
    bytes < 1024 * 1024
      ? `${(bytes / 1024).toFixed(0)} Ko`
      : `${(bytes / 1024 / 1024).toFixed(1)} Mo`;

  const icon = (type: string) => {
    if (type === "application/pdf") return "📄";
    if (type.startsWith("image/")) return "🖼";
    return "📎";
  };

  return (
    <div>
      <div className="flex items-baseline justify-between mb-2">
        <label className="text-sm font-semibold text-klary-ink">
          {label} {required && <span className="text-klary-orange">*</span>}
        </label>
        {file && (
          <button
            type="button"
            onClick={() => setFile(null)}
            className="text-xs text-red-600 hover:underline"
          >
            Retirer
          </button>
        )}
      </div>

      {file ? (
        <div className="p-4 bg-green-50 border-2 border-green-300 rounded-xl flex items-center gap-3">
          <div className="text-3xl">{icon(file.type)}</div>
          <div className="flex-1 min-w-0">
            <div className="font-semibold text-green-900 truncate text-sm">
              {file.name}
            </div>
            <div className="text-xs text-green-700">
              ✓ Ajouté · {sizeLabel(file.size)}
            </div>
          </div>
        </div>
      ) : (
        <div
          onDragOver={onDragOver}
          onDragLeave={onDragLeave}
          onDrop={onDrop}
          onClick={openPicker}
          className={`cursor-pointer p-6 border-2 border-dashed rounded-xl text-center transition ${
            drag
              ? "border-klary-orange bg-klary-orange/10"
              : "border-klary-light-grey hover:border-klary-orange hover:bg-klary-cream/40"
          }`}
        >
          <div className="text-3xl mb-2">📤</div>
          <div className="text-sm font-semibold text-klary-navy">
            Glissez votre fichier ici
          </div>
          <div className="text-xs text-klary-grey mt-1">
            ou <span className="text-klary-orange underline">cliquez pour parcourir</span>
          </div>
          <div className="text-[10px] text-klary-grey/70 mt-2 uppercase tracking-widest">
            PDF, JPG, PNG — max 5 Mo
          </div>
        </div>
      )}

      <input
        ref={inputRef}
        type="file"
        name={`doc_${docKey}`}
        accept=".pdf,.jpg,.jpeg,.png,.doc,.docx"
        onChange={(e) => setFile(e.target.files?.[0] || null)}
        className="hidden"
      />

      {err && (
        <div className="mt-2 text-xs text-red-600 font-semibold">
          ⚠ {err}
        </div>
      )}

      {dateField && (
        <div className="mt-2">
          <label className="text-xs text-klary-grey">
            Valable jusqu'au (obligatoire si document renseigné)
          </label>
          <input
            type="date"
            name={dateField}
            className="mt-1 w-full px-3 py-2 border border-klary-light-grey rounded-lg text-sm text-klary-navy focus:outline-none focus:border-klary-orange"
          />
        </div>
      )}
    </div>
  );
}
