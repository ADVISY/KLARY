"use client";

import { useState } from "react";
import { useRouter } from "next/navigation";

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

  const handleSubmit = async (e: React.FormEvent<HTMLFormElement>) => {
    e.preventDefault();
    setError(null);
    setSubmitting(true);
    try {
      const fd = new FormData(e.currentTarget);
      fd.append("token", token);
      const res = await fetch("/api/onboarding/submit", {
        method: "POST",
        body: fd,
      });
      const data = await res.json();
      if (!res.ok) {
        setError(
          data?.error || "Erreur d'enregistrement. Réessayez ou contactez rh@klary.ch."
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
      {/* Rappel identité candidat */}
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

      {/* ─── IDENTITÉ ─── */}
      <Section title="Identité" step={1}>
        <Field label="Date de naissance" required>
          <input
            type="date"
            name="date_of_birth"
            required
            className="input"
          />
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
        <Field label="État civil" required>
          <select name="marital_status" required className="input">
            <option value="">— Sélectionnez —</option>
            <option value="celibataire">Célibataire</option>
            <option value="marie">Marié·e</option>
            <option value="pacs">Partenariat enregistré</option>
            <option value="divorce">Divorcé·e</option>
            <option value="veuf">Veuf·ve</option>
          </select>
        </Field>
        <Field
          label="N° AVS (13 chiffres, format 756.xxxx.xxxx.xx)"
          required
        >
          <input
            type="text"
            name="avs_number"
            required
            placeholder="756.1234.5678.90"
            className="input"
          />
        </Field>
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
        <Field label="Permis de séjour (si étranger)">
          <input
            type="text"
            name="residence_permit"
            placeholder="B, C, L, G, Ci… ou 'sans objet'"
            className="input"
          />
        </Field>
      </Section>

      {/* ─── PARENTS (état civil complet) ─── */}
      <Section title="Filiation (état civil complet)" step={2}>
        <Field label="Prénom du père">
          <input
            type="text"
            name="father_first_name"
            className="input"
          />
        </Field>
        <Field label="Nom du père">
          <input
            type="text"
            name="father_last_name"
            className="input"
          />
        </Field>
        <Field label="Prénom de la mère">
          <input
            type="text"
            name="mother_first_name"
            className="input"
          />
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

      {/* ─── ADRESSE EN SUISSE ─── */}
      <Section title="Adresse actuelle en Suisse" step={3}>
        <Field label="Rue + numéro" required>
          <input
            type="text"
            name="postal_street"
            required
            placeholder="Route de Lausanne 31"
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
            placeholder="Le Mont-sur-Lausanne"
            className="input"
          />
        </Field>
        <Field label="Canton (2 lettres)" required>
          <select name="postal_canton" required className="input">
            <option value="">— Canton —</option>
            {[
              "VD",
              "GE",
              "VS",
              "FR",
              "NE",
              "JU",
              "BE",
              "ZH",
              "BS",
              "BL",
              "SG",
              "AG",
              "TI",
              "LU",
              "SO",
              "SH",
              "AR",
              "AI",
              "GL",
              "GR",
              "NW",
              "OW",
              "SZ",
              "TG",
              "UR",
              "ZG",
            ].map((c) => (
              <option key={c} value={c}>
                {c}
              </option>
            ))}
          </select>
        </Field>
      </Section>

      {/* ─── ADRESSE À L'ÉTRANGER (optionnel) ─── */}
      <Section
        title="Adresse à l'étranger (optionnel — pour employés étrangers)"
        step={4}
      >
        <Field label="Rue + numéro">
          <input
            type="text"
            name="foreign_street"
            placeholder="Adresse dans le pays d'origine ou familiale"
            className="input"
          />
        </Field>
        <Field label="Ville / région">
          <input
            type="text"
            name="foreign_city"
            className="input"
          />
        </Field>
        <Field label="Pays">
          <input
            type="text"
            name="foreign_country"
            placeholder="France, Portugal, Maroc, Italie…"
            className="input"
          />
        </Field>
      </Section>

      {/* ─── BANQUE ─── */}
      <Section title="Coordonnées bancaires (virement salaire)" step={5}>
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
      </Section>

      {/* ─── FISCALITÉ ─── */}
      <Section title="Fiscalité" step={6}>
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
      </Section>

      {/* ─── PRÉVOYANCE ─── */}
      <Section title="Prévoyance (2ᵉ pilier)" step={7}>
        <Field label="Caisse LPP précédente (nom)">
          <input
            type="text"
            name="prev_lpp_fund"
            placeholder="AXA, Swiss Life, Vita, Publica…"
            className="input"
          />
        </Field>
        <Field label="N° affiliation de sortie">
          <input
            type="text"
            name="prev_lpp_id"
            placeholder="Consultez votre certificat de sortie"
            className="input"
          />
        </Field>
        <Field label="Compte de libre passage (si existant)">
          <input
            type="text"
            name="libre_passage"
            placeholder="Nom institution + n° compte — ou 'aucun'"
            className="input"
          />
        </Field>
      </Section>

      {/* ─── CONTACT URGENCE ─── */}
      <Section title="Contact d'urgence" step={8}>
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
            placeholder="+41 79 xxx xx xx"
            className="input"
          />
        </Field>
      </Section>

      {/* ─── DOCUMENTS ─── */}
      <Section
        title="Documents à téléverser (PDF, JPG, PNG — max 5 Mo chacun)"
        step={9}
      >
        <FileField
          label="Carte d'identité / passeport"
          name="doc_id_document"
          required
        />
        <FileField label="Carte AVS" name="doc_avs_card" required />
        <FileField label="RIB / relevé bancaire" name="doc_rib" required />
        <FileField
          label="Permis de séjour (si étranger)"
          name="doc_permis_sejour"
        />
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
