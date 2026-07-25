"use client";

import { useState } from "react";
import { useRouter } from "next/navigation";

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
  const [submitting, setSubmitting] = useState(false);
  const [error, setError] = useState<string | null>(null);

  // Sections conditionnelles
  const [maritalStatus, setMaritalStatus] = useState<string>("");
  const [unemploymentStatus, setUnemploymentStatus] = useState<"non" | "oui">(
    "non"
  );
  const [drivingLicense, setDrivingLicense] = useState<"non" | "oui">("non");
  const [drivingTypes, setDrivingTypes] = useState<string[]>([]);
  const [children, setChildren] = useState<Child[]>([]);

  const isMarried = ["marie", "pacs"].includes(maritalStatus);
  const isDivorced = maritalStatus === "divorce";

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

  const handleSubmit = async (e: React.FormEvent<HTMLFormElement>) => {
    e.preventDefault();
    setError(null);
    setSubmitting(true);
    try {
      const fd = new FormData(e.currentTarget);
      fd.append("token", token);
      // Enfants → JSON stringifié
      fd.append(
        "children_json",
        JSON.stringify(children.filter((c) => c.first_name || c.last_name))
      );
      // Types permis → comma-separated
      fd.append("driving_license_types", drivingTypes.join(","));
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
    <form onSubmit={handleSubmit} className="space-y-8">
      <div className="p-4 bg-klary-cream rounded-xl text-sm text-klary-ink">
        <div className="font-semibold text-klary-navy">
          {candidateFirstName} {candidateLastName}
        </div>
        {positionApplied && (
          <div className="text-klary-grey text-xs">
            Poste : {positionApplied}
          </div>
        )}
      </div>

      {/* ─── 1. IDENTITÉ ─── */}
      <Section title="Identité" step={1}>
        <Field label="Date de naissance" required>
          <input type="date" name="date_of_birth" required className="input" />
        </Field>
        <Field label="Genre" required>
          <select name="gender" required className="input">
            <option value="">— Sélectionnez —</option>
            <option value="M">Masculin</option>
            <option value="F">Féminin</option>
            <option value="autre">Autre / ne souhaite pas préciser</option>
          </select>
        </Field>
        <Field label="Nationalité" required>
          <input
            type="text"
            name="nationality"
            required
            placeholder="Suisse, Française, Portugaise…"
            className="input"
          />
        </Field>
        <Field label="Ville de naissance" required>
          <input type="text" name="birth_city" required className="input" />
        </Field>
        <Field label="Pays de naissance" required>
          <input type="text" name="birth_country" required className="input" />
        </Field>
        <Field label="Lieu d'origine (commune, si Suisse)">
          <input
            type="text"
            name="place_of_origin"
            placeholder="Lausanne, Sion, Fribourg…"
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
            <option value="pacs">Partenariat enregistré / Concubinage</option>
            <option value="divorce">Divorcé·e</option>
            <option value="veuf">Veuf·ve</option>
          </select>
        </Field>
        <Field label="N° AVS (756.xxxx.xxxx.xx)" required>
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

      {/* ─── 2. FILIATION ─── */}
      <Section title="Filiation (état civil complet)" step={2}>
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

      {/* ─── 3. CONTACT ─── */}
      <Section title="Contact & téléphone" step={3}>
        <Field label="Téléphone mobile" required>
          <input
            type="tel"
            name="phone_mobile"
            required
            placeholder="+41 79 xxx xx xx"
            className="input"
          />
        </Field>
        <Field label="Téléphone fixe (si applicable)">
          <input
            type="tel"
            name="phone_landline"
            placeholder="+41 21 xxx xx xx"
            className="input"
          />
        </Field>
        <Field label="Email personnel (si différent de celui de candidature)">
          <input
            type="email"
            name="personal_email"
            className="input"
          />
        </Field>
        <div />
      </Section>

      {/* ─── 4. ADRESSE SUISSE ─── */}
      <Section title="Adresse actuelle en Suisse" step={4}>
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
          <input type="text" name="postal_city" required className="input" />
        </Field>
        <Field label="Canton (2 lettres)" required>
          <select name="postal_canton" required className="input">
            <option value="">— Canton —</option>
            {[
              "VD","GE","VS","FR","NE","JU","BE","ZH","BS","BL","SG","AG",
              "TI","LU","SO","SH","AR","AI","GL","GR","NW","OW","SZ","TG","UR","ZG",
            ].map((c) => (
              <option key={c} value={c}>{c}</option>
            ))}
          </select>
        </Field>
      </Section>

      {/* ─── 5. ADRESSE ÉTRANGER ─── */}
      <Section title="Adresse à l'étranger (optionnel, pour frontaliers/étrangers)" step={5}>
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
            placeholder="France, Portugal, Maroc, Italie…"
            className="input"
          />
        </Field>
        <div />
      </Section>

      {/* ─── 6. PERMIS DE CONDUIRE ─── */}
      <Section title="Permis de conduire" step={6}>
        <Field label="Avez-vous le permis ?" required>
          <select
            name="driving_license"
            required
            className="input"
            value={drivingLicense}
            onChange={(e) => setDrivingLicense(e.target.value as any)}
          >
            <option value="non">Non</option>
            <option value="oui">Oui</option>
          </select>
        </Field>
        {drivingLicense === "oui" && (
          <div className="md:col-span-2">
            <div className="text-xs font-semibold text-klary-ink mb-2">
              Types de permis
            </div>
            <div className="flex flex-wrap gap-3">
              {["Auto", "Moto", "Poids lourd", "Bateau"].map((t) => (
                <label
                  key={t}
                  className="flex items-center gap-2 px-3 py-2 border border-klary-light-grey rounded-lg cursor-pointer hover:border-klary-orange text-sm"
                >
                  <input
                    type="checkbox"
                    className="accent-klary-orange"
                    checked={drivingTypes.includes(t)}
                    onChange={() => toggleDrivingType(t)}
                  />
                  {t}
                </label>
              ))}
            </div>
          </div>
        )}
      </Section>

      {/* ─── 7. CHÔMAGE ─── */}
      <Section title="Statut chômage" step={7}>
        <Field label="Êtes-vous actuellement au chômage ?" required>
          <select
            name="unemployment_status"
            required
            className="input"
            value={unemploymentStatus}
            onChange={(e) => setUnemploymentStatus(e.target.value as any)}
          >
            <option value="non">Non</option>
            <option value="oui">Oui</option>
          </select>
        </Field>
        {unemploymentStatus === "oui" && (
          <>
            <Field label="Nom de la caisse de chômage">
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

      {/* ─── 8. CONJOINT (si marié / PACS) ─── */}
      {(isMarried || maritalStatus === "veuf") && (
        <Section
          title={isMarried ? "Conjoint / partenaire" : "Ancien conjoint"}
          step={8}
        >
          <Field label="Date de mariage / partenariat">
            <input type="date" name="marriage_date" className="input" />
          </Field>
          <Field label="Prénom du conjoint">
            <input type="text" name="spouse_first_name" className="input" />
          </Field>
          <Field label="Nom du conjoint">
            <input type="text" name="spouse_last_name" className="input" />
          </Field>
          <Field label="Date de naissance conjoint">
            <input type="date" name="spouse_dob" className="input" />
          </Field>
          <Field label="Nationalité conjoint">
            <input type="text" name="spouse_nationality" className="input" />
          </Field>
          <Field label="Permis conjoint (si étranger)">
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
                Perçoit des indemnités d'assurance
              </option>
              <option value="independant">Indépendant·e</option>
              <option value="sans_activite">Sans activité lucrative</option>
              <option value="sans_objet">Sans objet</option>
            </select>
          </Field>
          <Field label="Depuis quelle date">
            <input type="date" name="spouse_situation_since" className="input" />
          </Field>
          <Field label="Taux d'activité conjoint (%)">
            <input
              type="text"
              name="spouse_activity_rate"
              placeholder="80"
              className="input"
            />
          </Field>
          <Field label="Lieu / pays d'activité conjoint">
            <input
              type="text"
              name="spouse_activity_location"
              className="input"
            />
          </Field>
          <Field label="Touche des allocations familiales en Suisse ?">
            <select name="spouse_alloc_ch" className="input">
              <option value="sans_objet">Sans objet</option>
              <option value="oui">Oui</option>
              <option value="non">Non</option>
            </select>
          </Field>
          <Field label="Touche des allocations familiales à l'étranger ?">
            <select name="spouse_alloc_foreign" className="input">
              <option value="sans_objet">Sans objet</option>
              <option value="oui">Oui</option>
              <option value="non">Non</option>
            </select>
          </Field>
        </Section>
      )}

      {/* ─── 9. ENFANTS À CHARGE ─── */}
      <div>
        <div className="flex items-center gap-3 mb-4">
          <span className="w-7 h-7 rounded-full bg-klary-orange text-white text-xs font-bold flex items-center justify-center shrink-0">
            9
          </span>
          <h2 className="text-lg font-bold text-klary-navy">
            Enfants à charge (âge max 25 ans)
          </h2>
        </div>

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

        <div className="mt-4 space-y-3">
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
                  placeholder="Date de naissance"
                  value={child.dob}
                  onChange={(e) => updateChild(idx, "dob", e.target.value)}
                  className="input"
                />
                <input
                  type="text"
                  placeholder="Parenté (enfant, adopté, recueilli, conjoint…)"
                  value={child.relation}
                  onChange={(e) => updateChild(idx, "relation", e.target.value)}
                  className="input"
                />
                <input
                  type="text"
                  placeholder="Domicile (si différent — laisser vide sinon)"
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
            className="w-full py-2 px-4 border-2 border-dashed border-klary-light-grey rounded-lg text-sm text-klary-grey hover:border-klary-orange hover:text-klary-orange transition"
          >
            + Ajouter un enfant
          </button>
        </div>

        <div className="grid grid-cols-1 md:grid-cols-2 gap-4 mt-4">
          <Field label="Demandez-vous les allocations familiales ?">
            <select name="requests_family_allowances" className="input">
              <option value="">— Sélectionnez —</option>
              <option value="oui">Oui</option>
              <option value="non">Non</option>
            </select>
          </Field>
          <Field label="Exercez-vous une 2ᵉ activité lucrative ?">
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
          <div />
        </div>
      </div>

      {/* ─── 10. BANQUE ─── */}
      <Section title="Coordonnées bancaires (virement salaire)" step={10}>
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
          <label className="flex items-start gap-2 text-sm text-klary-ink cursor-pointer">
            <input
              type="checkbox"
              name="authorize_email_payslip"
              value="on"
              defaultChecked
              className="mt-1 accent-klary-orange w-4 h-4 shrink-0"
            />
            <span>
              J'autorise Klary Sàrl à me transmettre mes bulletins de salaire
              par voie électronique (email personnel).
            </span>
          </label>
        </div>
      </Section>

      {/* ─── 11. FISCALITÉ ─── */}
      <Section title="Fiscalité" step={11}>
        <Field label="Confession (impact impôt ecclésiastique)">
          <select name="religion" className="input">
            <option value="">— Sans confession —</option>
            <option value="protestante">Protestante réformée</option>
            <option value="catholique_romaine">Catholique romaine</option>
            <option value="catholique_chretienne">Catholique chrétienne</option>
            <option value="autre">Autre</option>
            <option value="sans">Sans confession</option>
          </select>
        </Field>
        <Field label="Votre conjoint travaille-t-il ?">
          <select name="spouse_working" className="input">
            <option value="sans_objet">Sans objet (célibataire)</option>
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
        <div />
      </Section>

      {/* ─── 12. PRÉVOYANCE ─── */}
      <Section title="Prévoyance (2ᵉ pilier)" step={12}>
        <Field label="Caisse LPP précédente (nom)">
          <input
            type="text"
            name="prev_lpp_fund"
            placeholder="AXA, Swiss Life, Vita, Publica…"
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
            placeholder="Nom institution + n° compte — ou 'aucun'"
            className="input"
          />
        </Field>
        <div />
      </Section>

      {/* ─── 13. CONTACT URGENCE ─── */}
      <Section title="Contact d'urgence" step={13}>
        <Field label="Nom complet" required>
          <input type="text" name="emergency_name" required className="input" />
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
            placeholder="+41 79 xxx xx xx"
            className="input"
          />
        </Field>
        <div />
      </Section>

      {/* ─── 14. DOCUMENTS ─── */}
      <Section
        title="Documents à téléverser (PDF, JPG, PNG — max 5 Mo chacun)"
        step={14}
      >
        <div className="md:col-span-2 p-3 bg-yellow-50 border-l-4 border-yellow-400 rounded text-xs text-yellow-900">
          ⚠ Tous les documents doivent être <strong>en cours de validité</strong>.
          Un document expiré sera automatiquement refusé. Indiquez la date
          d'expiration à côté de chaque document à durée limitée.
        </div>

        <FileField
          label="Carte d'identité (recto + verso)"
          name="doc_id_document"
          required
        />
        <Field label="Carte d'identité — valable jusqu'au">
          <input type="date" name="id_valid_until" className="input" />
        </Field>

        <FileField label="Passeport (optionnel)" name="doc_passport" />
        <Field label="Passeport — valable jusqu'au">
          <input type="date" name="passport_valid_until" className="input" />
        </Field>

        <FileField label="Carte AVS" name="doc_avs_card" required />
        <FileField label="RIB / relevé bancaire" name="doc_rib" required />

        <FileField
          label="Permis de séjour (si étranger)"
          name="doc_permis_sejour"
        />
        <Field label="Permis de séjour — valable jusqu'au">
          <input type="date" name="permis_valid_until" className="input" />
        </Field>

        <FileField
          label="Permis de conduire (si vous en avez)"
          name="doc_permis_conduire"
        />
        <FileField
          label="Photo d'identité (badge & trombinoscope)"
          name="doc_photo_badge"
          required
        />
        <FileField
          label="Extrait de casier judiciaire (obligatoire FINMA)"
          name="doc_casier_judiciaire"
          required
        />
        <FileField
          label="Extrait de l'office des poursuites (obligatoire FINMA)"
          name="doc_poursuites"
          required
        />

        {isMarried && (
          <FileField label="Acte de mariage" name="doc_acte_mariage" required />
        )}
        {isDivorced && (
          <FileField
            label="Jugement de divorce"
            name="doc_jugement_divorce"
            required
          />
        )}

        <FileField
          label="Certificat de sortie LPP (précédent employeur)"
          name="doc_lpp_exit"
        />
      </Section>

      {/* ─── CONSENTEMENT ─── */}
      <div className="p-4 bg-klary-cream rounded-xl border-l-4 border-klary-orange">
        <label className="flex items-start gap-3 text-sm text-klary-ink cursor-pointer">
          <input
            type="checkbox"
            name="consent"
            value="on"
            required
            className="mt-1 accent-klary-orange w-4 h-4 shrink-0"
          />
          <span>
            J'atteste que les informations ci-dessus sont exactes. Je consens
            au traitement de mes données personnelles par Klary Sàrl aux fins
            de mon contrat de travail, conformément à la nLPD. Les documents
            transmis sont conservés sur des serveurs sécurisés en Suisse.
          </span>
        </label>
      </div>

      {error && (
        <div className="p-4 bg-red-50 border-l-4 border-red-400 rounded text-sm text-red-800">
          {error}
        </div>
      )}

      <button
        type="submit"
        disabled={submitting}
        className={`w-full py-4 rounded-xl font-bold text-white transition text-lg ${
          submitting
            ? "bg-klary-grey/40 cursor-not-allowed"
            : "bg-klary-orange hover:bg-klary-orange/90"
        }`}
      >
        {submitting
          ? "Envoi en cours…"
          : "Envoyer mon dossier d'onboarding →"}
      </button>

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
        }
      `}</style>
    </form>
  );
}

function Section({
  title,
  step,
  children,
}: {
  title: string;
  step: number;
  children: React.ReactNode;
}) {
  return (
    <div>
      <div className="flex items-center gap-3 mb-4">
        <span className="w-7 h-7 rounded-full bg-klary-orange text-white text-xs font-bold flex items-center justify-center shrink-0">
          {step}
        </span>
        <h2 className="text-lg font-bold text-klary-navy">{title}</h2>
      </div>
      <div className="grid grid-cols-1 md:grid-cols-2 gap-4">{children}</div>
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

function FileField({
  label,
  name,
  required,
}: {
  label: string;
  name: string;
  required?: boolean;
}) {
  return (
    <div className="md:col-span-2">
      <label className="block text-xs font-semibold text-klary-ink mb-1.5">
        {label} {required && <span className="text-klary-orange">*</span>}
      </label>
      <input
        type="file"
        name={name}
        required={required}
        accept=".pdf,.jpg,.jpeg,.png,.doc,.docx"
        className="block w-full text-sm text-klary-grey file:mr-3 file:py-2 file:px-4 file:rounded-lg file:border-0 file:text-sm file:font-semibold file:bg-klary-navy file:text-white hover:file:bg-klary-navy/90 file:cursor-pointer cursor-pointer"
      />
    </div>
  );
}
