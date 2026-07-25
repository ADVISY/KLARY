import { useState, ChangeEvent } from "react";
import { Link, useSearchParams } from "react-router-dom";
import {
  ArrowRight, ArrowLeft, Send, Mail, Phone, User, FileText, Briefcase,
  CheckCircle2, Upload, Award, Scale, FileCheck, X, AlertCircle, Paperclip,
} from "lucide-react";
import { HeaderV2 } from "@/components/v2/HeaderV2";
import { FooterV2 } from "@/components/v2/FooterV2";
import { ScrollProgress } from "@/components/v2/ScrollProgress";
import { PageHeroV2 } from "@/components/v2/PageHeroV2";
import { PageSectionV2 } from "@/components/v2/PageSectionV2";
import { Reveal } from "@/components/v2/Reveal";

const POSTES_LIST = [
  "Conseiller en assurances",
  "Conseiller en prévoyance",
  "Conseiller en financement hypothécaire",
  "Conseiller téléphonique / Service client",
  "Candidature spontanée",
];

const WEB3FORMS_ACCESS_KEY = import.meta.env.VITE_WEB3FORMS_KEY || "";
const RECIPIENT_EMAIL = "admin@klary.ch";
const MAX_FILE_SIZE = 5 * 1024 * 1024; // 5 MB par fichier
const ACCEPTED_TYPES = ".pdf,.jpg,.jpeg,.png,.doc,.docx";

interface DocumentField {
  key: "cv" | "diplomes" | "casier" | "poursuites";
  label: string;
  description: string;
  icon: typeof FileText;
  required: boolean;
}

const DOCUMENTS: DocumentField[] = [
  {
    key: "cv",
    label: "CV",
    description: "Votre curriculum vitae à jour (PDF de préférence)",
    icon: FileText,
    required: true,
  },
  {
    key: "diplomes",
    label: "Diplômes & certifications",
    description: "Diplômes obtenus, brevet fédéral, formations IAF, etc.",
    icon: Award,
    required: false,
  },
  {
    key: "casier",
    label: "Extrait de casier judiciaire",
    description: "Délivré par le canton, daté de moins de 3 mois",
    icon: Scale,
    required: false,
  },
  {
    key: "poursuites",
    label: "Extrait du registre des poursuites",
    description: "Délivré par l'office des poursuites, daté de moins de 3 mois",
    icon: FileCheck,
    required: false,
  },
];

interface FormFiles {
  cv: File | null;
  diplomes: File | null;
  casier: File | null;
  poursuites: File | null;
}

const Recrutement = () => {
  const [searchParams] = useSearchParams();
  const presetPoste = searchParams.get("poste") || "Candidature spontanée";

  const [form, setForm] = useState({
    poste: presetPoste,
    firstName: "",
    lastName: "",
    email: "",
    phone: "",
    why_klary: "",
    message: "",
  });

  const [files, setFiles] = useState<FormFiles>({
    cv: null,
    diplomes: null,
    casier: null,
    poursuites: null,
  });

  const [isSubmitting, setIsSubmitting] = useState(false);
  const [success, setSuccess] = useState(false);
  const [error, setError] = useState<string | null>(null);

  const update = (key: keyof typeof form, value: string) =>
    setForm({ ...form, [key]: value });

  const handleFileChange = (key: keyof FormFiles) => (e: ChangeEvent<HTMLInputElement>) => {
    const file = e.target.files?.[0] || null;
    if (file && file.size > MAX_FILE_SIZE) {
      setError(`${file.name} dépasse 5 MB (max autorisé par fichier).`);
      return;
    }
    setError(null);
    setFiles({ ...files, [key]: file });
  };

  const removeFile = (key: keyof FormFiles) => {
    setFiles({ ...files, [key]: null });
  };

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setIsSubmitting(true);
    setError(null);

    const subject = `Candidature — ${form.poste} — ${form.firstName} ${form.lastName}`;

    try {
      // ─── Envoi vers Klary Admin (Next.js API → Supabase Storage + DB + Resend) ───
      const KLARY_API_URL =
        (import.meta.env.VITE_KLARY_API_URL as string) ||
        "https://app.klary.ch/api/candidature";

      const formData = new FormData();
      formData.append("first_name", form.firstName);
      formData.append("last_name", form.lastName);
      formData.append("email", form.email);
      formData.append("phone", form.phone);
      formData.append("position_applied", form.poste);
      formData.append("why_klary", form.why_klary);
      formData.append("cover_letter", form.message);
      formData.append("consent", "true");

      // CV (obligatoire)
      const cvFile = files.cv;
      if (cvFile) {
        formData.append("cv", cvFile, cvFile.name);
      }

      // Documents additionnels
      const additionalKeys: Array<"diplomes" | "casier" | "poursuites"> = [
        "diplomes",
        "casier",
        "poursuites",
      ];
      additionalKeys.forEach((key) => {
        const file = files[key];
        if (file) {
          formData.append(`document_${key}`, file, file.name);
        }
      });

      const res = await fetch(KLARY_API_URL, {
        method: "POST",
        body: formData,
      });
      const data = await res.json();
      if (!res.ok) {
        throw new Error(data?.error || "Erreur d'envoi");
      }
      setSuccess(true);
    } catch (err: any) {
      setError(err?.message || "Une erreur s'est produite. Vous pouvez nous appeler directement.");
    } finally {
      setIsSubmitting(false);
    }
  };

  const inputCls =
    "w-full px-4 py-3 rounded-xl border border-neutral-light bg-white text-foreground placeholder:text-muted-text focus:outline-none focus:border-[hsl(var(--accent))] focus:ring-2 focus:ring-[hsl(var(--accent)/0.15)] transition-all";

  if (success) {
    return (
      <div className="min-h-screen bg-background text-foreground">
        <ScrollProgress />
        <HeaderV2 />
        <main className="pt-32 pb-24">
          <div className="mx-auto max-w-2xl px-5 lg:px-8 text-center">
            <div
              className="rounded-2xl p-10 md:p-14"
              style={{
                background: "linear-gradient(180deg, hsl(160 60% 96%) 0%, white 100%)",
                border: "1px solid hsl(160 60% 80%)",
              }}
            >
              <div className="w-16 h-16 rounded-full bg-[hsl(160_70%_42%)] mx-auto flex items-center justify-center mb-6">
                <CheckCircle2 className="w-9 h-9 text-white" />
              </div>
              <h1 className="text-3xl md:text-4xl font-bold text-foreground mb-3 tracking-tight">
                Candidature reçue !
              </h1>
              <p className="text-base mb-8" style={{ color: "hsl(var(--foreground-soft))" }}>
                Merci pour votre candidature. Notre équipe RH étudie votre dossier et vous
                recontacte sous <strong>5 jours ouvrés</strong>.
              </p>
              <div className="flex flex-col sm:flex-row gap-3 justify-center">
                <Link to="/recrutement" className="kx-btn kx-btn-outline">
                  <ArrowLeft className="w-4 h-4" />
                  Retour aux offres
                </Link>
                <Link to="/" className="kx-btn kx-btn-ghost">
                  Accueil Klary
                </Link>
              </div>
            </div>
          </div>
        </main>
        <FooterV2 />
      </div>
    );
  }

  return (
    <div className="min-h-screen bg-background text-foreground">
      <ScrollProgress />
      <HeaderV2 />

      <main>
        <PageHeroV2
          eyebrow="Postuler chez Klary"
          title="Envoyez votre"
          titleAccent="candidature."
          subtitle="Formulaire complet : 5 minutes, plus vos documents. Tout part directement à notre équipe RH. Réponse sous 5 jours ouvrés."
          cta={
            <>
              <Link to="/recrutement" className="kx-btn kx-btn-outline">
                <ArrowLeft className="w-4 h-4" />
                Voir les postes
              </Link>
              <a href="#form" className="kx-btn kx-btn-accent">
                Aller au formulaire
                <ArrowRight className="w-4 h-4" />
              </a>
            </>
          }
        />

        <PageSectionV2
          id="form"
          eyebrow="Formulaire"
          title="Vos informations"
          titleAccent="et vos documents."
          subtitle="Plus votre dossier est complet, plus vite on peut vous répondre. Le CV est requis. Les autres documents peuvent être envoyés plus tard si besoin."
        >
          <div className="max-w-3xl mx-auto">
            <Reveal>
              <form onSubmit={handleSubmit} className="kx-card !p-8 md:!p-10 space-y-7">
                {/* Section 1 — Poste */}
                <div>
                  <label className="text-sm font-semibold text-foreground mb-2 flex items-center gap-2">
                    <Briefcase className="w-4 h-4" style={{ color: "hsl(var(--accent))" }} />
                    Poste visé
                  </label>
                  <select
                    value={form.poste}
                    onChange={(e) => update("poste", e.target.value)}
                    className={inputCls}
                    required
                  >
                    {POSTES_LIST.map((p) => (
                      <option key={p} value={p}>
                        {p}
                      </option>
                    ))}
                  </select>
                </div>

                {/* Section 2 — Identité */}
                <div className="grid md:grid-cols-2 gap-5">
                  <div>
                    <label className="text-sm font-semibold text-foreground mb-2 flex items-center gap-2">
                      <User className="w-4 h-4" style={{ color: "hsl(var(--accent))" }} />
                      Prénom
                    </label>
                    <input
                      type="text"
                      value={form.firstName}
                      onChange={(e) => update("firstName", e.target.value)}
                      placeholder="Jean"
                      className={inputCls}
                      required
                    />
                  </div>
                  <div>
                    <label className="text-sm font-semibold text-foreground mb-2 flex items-center gap-2">
                      <User className="w-4 h-4" style={{ color: "hsl(var(--accent))" }} />
                      Nom
                    </label>
                    <input
                      type="text"
                      value={form.lastName}
                      onChange={(e) => update("lastName", e.target.value)}
                      placeholder="Dupont"
                      className={inputCls}
                      required
                    />
                  </div>
                </div>

                {/* Section 3 — Contact */}
                <div className="grid md:grid-cols-2 gap-5">
                  <div>
                    <label className="text-sm font-semibold text-foreground mb-2 flex items-center gap-2">
                      <Mail className="w-4 h-4" style={{ color: "hsl(var(--accent))" }} />
                      Email
                    </label>
                    <input
                      type="email"
                      value={form.email}
                      onChange={(e) => update("email", e.target.value)}
                      placeholder="jean@email.ch"
                      className={inputCls}
                      required
                    />
                  </div>
                  <div>
                    <label className="text-sm font-semibold text-foreground mb-2 flex items-center gap-2">
                      <Phone className="w-4 h-4" style={{ color: "hsl(var(--accent))" }} />
                      Téléphone
                    </label>
                    <input
                      type="tel"
                      value={form.phone}
                      onChange={(e) => update("phone", e.target.value)}
                      placeholder="+41 79 123 45 67"
                      className={inputCls}
                      required
                    />
                  </div>
                </div>

                {/* Section 4 — Motivations */}
                <div>
                  <label className="text-sm font-semibold text-foreground mb-2 flex items-center gap-2">
                    <FileText className="w-4 h-4" style={{ color: "hsl(var(--accent))" }} />
                    Pourquoi Klary ?
                  </label>
                  <textarea
                    rows={4}
                    value={form.why_klary}
                    onChange={(e) => update("why_klary", e.target.value)}
                    placeholder="Vos motivations, ce qui vous attire chez nous…"
                    className={inputCls}
                    required
                  />
                </div>

                <div>
                  <label className="text-sm font-semibold text-foreground mb-2 flex items-center gap-2">
                    <FileText className="w-4 h-4" style={{ color: "hsl(var(--accent))" }} />
                    Message complémentaire (optionnel)
                  </label>
                  <textarea
                    rows={3}
                    value={form.message}
                    onChange={(e) => update("message", e.target.value)}
                    placeholder="Disponibilités, expérience clé, lien LinkedIn…"
                    className={inputCls}
                  />
                </div>

                {/* Section 5 — Documents */}
                <div className="pt-4 border-t border-neutral-light/60">
                  <div className="mb-5">
                    <div className="flex items-center gap-2 mb-1.5">
                      <Paperclip className="w-4 h-4" style={{ color: "hsl(var(--accent))" }} />
                      <h3 className="text-base font-bold text-foreground">Vos documents</h3>
                    </div>
                    <p className="text-sm" style={{ color: "hsl(var(--foreground-soft))" }}>
                      PDF, JPG, PNG ou Word — max 5 MB par fichier. Le CV est requis. Les autres
                      sont optionnels pour cette première étape mais accélèrent le processus.
                    </p>
                  </div>

                  <div className="space-y-3">
                    {DOCUMENTS.map((doc) => {
                      const Icon = doc.icon;
                      const file = files[doc.key];
                      return (
                        <div
                          key={doc.key}
                          className="relative rounded-xl border-2 border-dashed transition-all"
                          style={{
                            borderColor: file
                              ? "hsl(160 60% 65%)"
                              : "hsl(var(--neutral-light))",
                            background: file ? "hsl(160 50% 97%)" : "white",
                          }}
                        >
                          <label className="flex items-center gap-4 p-4 cursor-pointer">
                            <span
                              className="w-11 h-11 rounded-lg flex items-center justify-center shrink-0"
                              style={{
                                background: file
                                  ? "hsl(160 60% 90%)"
                                  : "hsl(var(--accent-light))",
                                color: file
                                  ? "hsl(160 70% 35%)"
                                  : "hsl(var(--accent))",
                              }}
                            >
                              {file ? <CheckCircle2 className="w-5 h-5" /> : <Icon className="w-5 h-5" />}
                            </span>

                            <div className="flex-1 min-w-0">
                              <p className="text-sm font-semibold text-foreground flex items-center gap-2 flex-wrap">
                                {doc.label}
                                {doc.required && (
                                  <span
                                    className="text-[10px] font-bold uppercase tracking-wider px-1.5 py-0.5 rounded"
                                    style={{
                                      background: "hsl(var(--accent-light))",
                                      color: "hsl(var(--accent))",
                                    }}
                                  >
                                    Requis
                                  </span>
                                )}
                              </p>
                              {file ? (
                                <p
                                  className="text-xs mt-0.5 truncate"
                                  style={{ color: "hsl(160 70% 35%)" }}
                                >
                                  {file.name} · {(file.size / 1024 / 1024).toFixed(2)} MB
                                </p>
                              ) : (
                                <p
                                  className="text-xs mt-0.5"
                                  style={{ color: "hsl(var(--muted-text))" }}
                                >
                                  {doc.description}
                                </p>
                              )}
                            </div>

                            {file ? (
                              <button
                                type="button"
                                onClick={(e) => {
                                  e.preventDefault();
                                  removeFile(doc.key);
                                }}
                                className="shrink-0 w-8 h-8 rounded-lg flex items-center justify-center hover:bg-red-50 transition-colors"
                                aria-label="Retirer le fichier"
                              >
                                <X className="w-4 h-4 text-red-500" />
                              </button>
                            ) : (
                              <span
                                className="shrink-0 flex items-center gap-1.5 text-xs font-semibold px-3 py-1.5 rounded-lg"
                                style={{
                                  background: "hsl(var(--accent-light))",
                                  color: "hsl(var(--accent))",
                                }}
                              >
                                <Upload className="w-3.5 h-3.5" />
                                Choisir
                              </span>
                            )}

                            <input
                              type="file"
                              accept={ACCEPTED_TYPES}
                              onChange={handleFileChange(doc.key)}
                              className="sr-only"
                              required={doc.required}
                            />
                          </label>
                        </div>
                      );
                    })}
                  </div>

                  {!WEB3FORMS_ACCESS_KEY && (
                    <div
                      className="mt-4 p-3 rounded-lg flex items-start gap-2.5 text-sm"
                      style={{
                        background: "hsl(45 100% 96%)",
                        border: "1px solid hsl(45 80% 80%)",
                        color: "hsl(35 70% 30%)",
                      }}
                    >
                      <AlertCircle className="w-4 h-4 shrink-0 mt-0.5" />
                      <p>
                        <strong>Note :</strong> Votre client mail s'ouvrira avec votre dossier
                        pré-rempli. <strong>Joignez manuellement</strong> les fichiers sélectionnés
                        ci-dessus avant d'envoyer.
                      </p>
                    </div>
                  )}
                </div>

                {/* Erreur globale */}
                {error && (
                  <div
                    className="p-3 rounded-lg flex items-start gap-2.5 text-sm"
                    style={{
                      background: "hsl(0 75% 96%)",
                      border: "1px solid hsl(0 70% 88%)",
                      color: "hsl(0 70% 35%)",
                    }}
                  >
                    <AlertCircle className="w-4 h-4 shrink-0 mt-0.5" />
                    <p>{error}</p>
                  </div>
                )}

                {/* Submit */}
                <div className="pt-4 flex flex-col sm:flex-row items-start sm:items-center gap-4">
                  <button
                    type="submit"
                    className="kx-btn kx-btn-accent !text-base !py-4 !px-7"
                    disabled={isSubmitting}
                  >
                    {isSubmitting ? (
                      <>
                        <span className="inline-block w-4 h-4 border-2 border-current border-r-transparent rounded-full animate-spin" />
                        Envoi en cours...
                      </>
                    ) : (
                      <>
                        <Send className="w-4 h-4" />
                        Envoyer ma candidature
                      </>
                    )}
                  </button>
                  <p className="text-xs" style={{ color: "hsl(var(--muted-text))" }}>
                    Vos données sont confidentielles et destinées uniquement à l'équipe RH Klary
                    (<strong className="text-foreground">admin@klary.ch</strong>).
                  </p>
                </div>
              </form>
            </Reveal>

            <Reveal delay={150}>
              <div className="mt-8">
                <a
                  href="mailto:admin@klary.ch?subject=Candidature%20—%20CV"
                  className="kx-card !p-6 flex items-center gap-4 hover:!shadow-medium transition-all"
                >
                  <span
                    className="w-12 h-12 rounded-xl flex items-center justify-center shrink-0"
                    style={{
                      background: "hsl(var(--accent-light))",
                      color: "hsl(var(--accent))",
                    }}
                  >
                    <Mail className="w-6 h-6" />
                  </span>
                  <div>
                    <p className="text-sm font-semibold text-foreground">
                      Envoyer le CV directement
                    </p>
                    <p className="text-xs mt-0.5" style={{ color: "hsl(var(--muted-text))" }}>
                      admin@klary.ch
                    </p>
                  </div>
                </a>
              </div>
            </Reveal>
          </div>
        </PageSectionV2>

        <PageSectionV2 eyebrow="Notre processus" title="4 étapes," titleAccent="2 semaines max.">
          <div className="grid sm:grid-cols-2 lg:grid-cols-4 gap-5">
            {[
              {
                n: "01",
                title: "Réception de votre candidature",
                desc: "On lit chaque dossier. Vous recevez un accusé de réception sous 24h.",
              },
              {
                n: "02",
                title: "Premier appel découverte",
                desc: "15-30 min en visio ou téléphone, avec une de nos RH ou un manager.",
              },
              {
                n: "03",
                title: "Entretien terrain",
                desc: "1h en physique avec le futur manager + un conseiller en poste.",
              },
              {
                n: "04",
                title: "Décision & onboarding",
                desc: "Réponse claire (oui/non) sous 5 jours. Démarrage rapide avec formation 5j.",
              },
            ].map((s, i) => (
              <Reveal key={s.n} delay={i * 100}>
                <div className="kx-card !p-7 h-full">
                  <p
                    className="text-[11px] uppercase tracking-[0.16em] font-semibold mb-5 tabular-nums"
                    style={{ color: "hsl(var(--accent))" }}
                  >
                    Étape {s.n}
                  </p>
                  <CheckCircle2
                    className="w-7 h-7 mb-5"
                    style={{ color: "hsl(var(--accent))" }}
                  />
                  <p className="text-lg font-bold text-foreground mb-3 leading-snug tracking-tight">
                    {s.title}
                  </p>
                  <p className="text-sm leading-relaxed" style={{ color: "hsl(var(--muted-text))" }}>
                    {s.desc}
                  </p>
                </div>
              </Reveal>
            ))}
          </div>
        </PageSectionV2>
      </main>

      <FooterV2 />
    </div>
  );
};

export default Recrutement;
