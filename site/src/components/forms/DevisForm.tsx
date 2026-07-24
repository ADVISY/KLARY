import { useState, FormEvent } from "react";
import { Send, Mail, CheckCircle2 } from "lucide-react";

interface DevisFormProps {
  type: string;        // ex: "Assurance maladie", "3e pilier"
  title: string;       // titre du form
  subtitle?: string;
  compact?: boolean;
}

// Configuration : remplacer cette clé par celle obtenue sur https://web3forms.com (gratuit)
// Si non définie, fallback automatique sur mailto:
const WEB3FORMS_ACCESS_KEY = import.meta.env.VITE_WEB3FORMS_KEY || "";
const RECIPIENT_EMAIL = "admin@klary.ch";

interface FormState {
  nom: string;
  prenom: string;
  email: string;
  telephone: string;
  codePostal: string;
  message: string;
}

const EMPTY: FormState = {
  nom: "", prenom: "", email: "", telephone: "", codePostal: "", message: "",
};

export const DevisForm = ({ type, title, subtitle, compact = false }: DevisFormProps) => {
  const [isSubmitting, setIsSubmitting] = useState(false);
  const [success, setSuccess] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const [formData, setFormData] = useState<FormState>(EMPTY);

  const handleSubmit = async (e: FormEvent) => {
    e.preventDefault();
    setIsSubmitting(true);
    setError(null);

    const subject = `[Klary.ch] Demande de devis — ${type}`;
    const body = [
      `Type de demande : ${type}`,
      `Nom : ${formData.nom}`,
      `Prénom : ${formData.prenom}`,
      `Email : ${formData.email}`,
      `Téléphone : ${formData.telephone}`,
      `Code postal : ${formData.codePostal}`,
      `Message : ${formData.message || "(aucun)"}`,
      ``,
      `Envoyé depuis https://klary.ch`,
    ].join("\n");

    try {
      if (WEB3FORMS_ACCESS_KEY) {
        // Envoi propre via Web3Forms (pas de client email à ouvrir)
        const res = await fetch("https://api.web3forms.com/submit", {
          method: "POST",
          headers: { "Content-Type": "application/json", Accept: "application/json" },
          body: JSON.stringify({
            access_key: WEB3FORMS_ACCESS_KEY,
            subject,
            from_name: `${formData.prenom} ${formData.nom}`.trim() || "Visiteur klary.ch",
            email: formData.email,
            replyto: formData.email,
            to: RECIPIENT_EMAIL,
            // payload custom
            type,
            telephone: formData.telephone,
            code_postal: formData.codePostal,
            message: formData.message,
          }),
        });
        const data = await res.json();
        if (!res.ok || !data.success) {
          throw new Error(data.message || "Erreur d'envoi");
        }
      } else {
        // Fallback : ouvrir le client email du visiteur avec mailto pré-rempli
        const mailto = `mailto:${RECIPIENT_EMAIL}?subject=${encodeURIComponent(subject)}&body=${encodeURIComponent(body)}`;
        window.location.href = mailto;
      }
      setSuccess(true);
      setFormData(EMPTY);
    } catch (err: any) {
      setError(err?.message || "Une erreur s'est produite. Vous pouvez nous appeler directement.");
    } finally {
      setIsSubmitting(false);
    }
  };

  const inputCls =
    "w-full px-4 py-3 rounded-lg bg-white text-foreground placeholder:text-foreground/40 text-[15px] border border-neutral-light focus:outline-none focus:ring-2 transition-all";
  const inputStyle: React.CSSProperties = {
    boxShadow: "0 1px 2px rgba(16,14,47,0.04)",
  };

  if (success) {
    return (
      <div
        className={`rounded-2xl p-8 md:p-10 text-center ${compact ? "" : "kx-card"}`}
        style={{ background: "linear-gradient(180deg, hsl(160 60% 96%) 0%, white 100%)", border: "1px solid hsl(160 60% 80%)" }}
      >
        <div className="w-14 h-14 rounded-full bg-[hsl(160_70%_42%)] mx-auto flex items-center justify-center mb-5">
          <CheckCircle2 className="w-8 h-8 text-white" />
        </div>
        <h3 className="text-2xl font-bold text-foreground mb-2">Demande reçue !</h3>
        <p className="text-base mb-6" style={{ color: "hsl(var(--foreground-soft))" }}>
          Un conseiller Klary vous recontacte dans les <strong>24 heures ouvrées</strong> avec votre comparatif personnalisé.
        </p>
        <div className="flex flex-col sm:flex-row gap-3 justify-center">
          <a href={`mailto:${RECIPIENT_EMAIL}`} className="kx-btn kx-btn-outline">
            <Mail className="w-4 h-4" />
            {RECIPIENT_EMAIL}
          </a>
        </div>
      </div>
    );
  }

  return (
    <div className={`rounded-2xl p-7 md:p-8 ${compact ? "" : "bg-white border border-neutral-light/70 shadow-sm"}`}>
      <div className="mb-6">
        <span
          className="inline-block text-[10px] font-bold uppercase tracking-[0.18em] px-2.5 py-1 rounded-full mb-3"
          style={{
            background: "hsl(var(--accent-light))",
            color: "hsl(var(--accent))",
          }}
        >
          {type}
        </span>
        <h3 className="text-2xl md:text-[1.75rem] font-bold text-foreground tracking-tight leading-tight mb-2">
          {title}
        </h3>
        {subtitle && (
          <p className="text-[15px]" style={{ color: "hsl(var(--foreground-soft))" }}>
            {subtitle}
          </p>
        )}
      </div>

      <form onSubmit={handleSubmit} className="space-y-4">
        <div className="grid md:grid-cols-2 gap-4">
          <div>
            <label htmlFor={`nom-${type}`} className="block text-[13px] font-medium mb-1.5" style={{ color: "hsl(var(--foreground-soft))" }}>
              Nom *
            </label>
            <input
              id={`nom-${type}`}
              type="text"
              required
              autoComplete="family-name"
              value={formData.nom}
              onChange={(e) => setFormData({ ...formData, nom: e.target.value })}
              className={inputCls}
              style={inputStyle}
            />
          </div>
          <div>
            <label htmlFor={`prenom-${type}`} className="block text-[13px] font-medium mb-1.5" style={{ color: "hsl(var(--foreground-soft))" }}>
              Prénom *
            </label>
            <input
              id={`prenom-${type}`}
              type="text"
              required
              autoComplete="given-name"
              value={formData.prenom}
              onChange={(e) => setFormData({ ...formData, prenom: e.target.value })}
              className={inputCls}
              style={inputStyle}
            />
          </div>
        </div>

        <div className="grid md:grid-cols-2 gap-4">
          <div>
            <label htmlFor={`email-${type}`} className="block text-[13px] font-medium mb-1.5" style={{ color: "hsl(var(--foreground-soft))" }}>
              Email *
            </label>
            <input
              id={`email-${type}`}
              type="email"
              required
              autoComplete="email"
              value={formData.email}
              onChange={(e) => setFormData({ ...formData, email: e.target.value })}
              className={inputCls}
              style={inputStyle}
              placeholder="vous@email.ch"
            />
          </div>
          <div>
            <label htmlFor={`tel-${type}`} className="block text-[13px] font-medium mb-1.5" style={{ color: "hsl(var(--foreground-soft))" }}>
              Téléphone *
            </label>
            <input
              id={`tel-${type}`}
              type="tel"
              required
              autoComplete="tel"
              value={formData.telephone}
              onChange={(e) => setFormData({ ...formData, telephone: e.target.value })}
              className={inputCls}
              style={inputStyle}
              placeholder="+41 ..."
            />
          </div>
        </div>

        <div>
          <label htmlFor={`cp-${type}`} className="block text-[13px] font-medium mb-1.5" style={{ color: "hsl(var(--foreground-soft))" }}>
            Code postal *
          </label>
          <input
            id={`cp-${type}`}
            type="text"
            required
            autoComplete="postal-code"
            inputMode="numeric"
            pattern="[0-9]{4}"
            maxLength={4}
            value={formData.codePostal}
            onChange={(e) => setFormData({ ...formData, codePostal: e.target.value })}
            className={inputCls}
            style={inputStyle}
            placeholder="1262"
          />
        </div>

        <div>
          <label htmlFor={`msg-${type}`} className="block text-[13px] font-medium mb-1.5" style={{ color: "hsl(var(--foreground-soft))" }}>
            Message (optionnel)
          </label>
          <textarea
            id={`msg-${type}`}
            rows={3}
            value={formData.message}
            onChange={(e) => setFormData({ ...formData, message: e.target.value })}
            className={inputCls + " resize-y"}
            style={inputStyle}
            placeholder="Précisez votre situation ou vos questions..."
          />
        </div>

        {error && (
          <div
            role="alert"
            className="text-sm p-3 rounded-lg"
            style={{
              background: "hsl(0 75% 96%)",
              color: "hsl(0 70% 35%)",
              border: "1px solid hsl(0 70% 88%)",
            }}
          >
            {error}
          </div>
        )}

        <button type="submit" className="kx-btn kx-btn-accent w-full !justify-center" disabled={isSubmitting}>
          {isSubmitting ? (
            <>
              <span className="inline-block w-4 h-4 border-2 border-current border-r-transparent rounded-full animate-spin" />
              Envoi en cours...
            </>
          ) : (
            <>
              <Send className="w-4 h-4" />
              Recevoir mon analyse gratuite
            </>
          )}
        </button>

        <p className="text-xs text-center" style={{ color: "hsl(var(--foreground-soft))" }}>
          Réponse sous 24h ouvrées. Vos données ne sont jamais partagées.
        </p>
      </form>
    </div>
  );
};
