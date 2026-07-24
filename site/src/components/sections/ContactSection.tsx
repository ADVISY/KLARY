import { useEffect, useRef, useState } from "react";
import { Input } from "@/components/ui/input";
import { Textarea } from "@/components/ui/textarea";
import { Mail, Phone, ArrowLeft, Check, User, AtSign, PhoneCall, Briefcase, Tag, MessageSquare } from "lucide-react";
import { useToast } from "@/hooks/use-toast";

type StepKey = "name" | "email" | "phone" | "profile" | "subject" | "message";

type StepDef = {
  key: StepKey;
  label: string;
  question: string;
  icon: typeof User;
  type: "text" | "email" | "tel" | "choice" | "textarea";
  required?: boolean;
  placeholder?: string;
  options?: { value: string; label: string }[];
};

const steps: StepDef[] = [
  { key: "name", label: "Nom", question: "Comment vous appelez-vous ?", icon: User, type: "text", required: true, placeholder: "Jean Dupont" },
  { key: "email", label: "Email", question: "Quelle est votre adresse email ?", icon: AtSign, type: "email", required: true, placeholder: "jean@email.ch" },
  { key: "phone", label: "Téléphone", question: "Quel est votre numéro ?", icon: PhoneCall, type: "tel", placeholder: "+41 78 123 45 67" },
  {
    key: "profile",
    label: "Profil",
    question: "Quel est votre profil ?",
    icon: Briefcase,
    type: "choice",
    options: [
      { value: "particulier", label: "Particulier" },
      { value: "independant", label: "Indépendant" },
      { value: "pme", label: "PME" },
    ],
  },
  {
    key: "subject",
    label: "Sujet",
    question: "Quel est le sujet principal ?",
    icon: Tag,
    type: "choice",
    options: [
      { value: "maladie", label: "Assurance maladie" },
      { value: "prevoyance", label: "Prévoyance" },
      { value: "entreprise", label: "Entreprise" },
      { value: "autre", label: "Autre" },
    ],
  },
  { key: "message", label: "Message", question: "Décrivez votre situation (facultatif)", icon: MessageSquare, type: "textarea", placeholder: "Quelques mots sur votre besoin..." },
];

const isValidEmail = (v: string) => /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(v.trim());

export const ContactSection = () => {
  const { toast } = useToast();
  const [stepIdx, setStepIdx] = useState(0);
  const [data, setData] = useState<Record<StepKey, string>>({
    name: "", email: "", phone: "", profile: "", subject: "", message: "",
  });
  const [submitted, setSubmitted] = useState(false);
  const inputRef = useRef<HTMLInputElement | HTMLTextAreaElement | null>(null);
  const advanceTimerRef = useRef<number | null>(null);
  const hasMountedRef = useRef(false);

  const current = steps[stepIdx];
  const value = data[current.key];
  const isLast = stepIdx === steps.length - 1;

  useEffect(() => {
    if (hasMountedRef.current) {
      inputRef.current?.focus();
    } else {
      hasMountedRef.current = true;
    }

    return () => {
      if (advanceTimerRef.current) window.clearTimeout(advanceTimerRef.current);
    };
  }, [stepIdx]);

  const canAdvance = (): boolean => {
    if (current.required) {
      if (!value.trim()) return false;
      if (current.type === "email" && !isValidEmail(value)) return false;
    }
    return true;
  };

  const goNext = () => {
    if (!canAdvance()) return;
    if (isLast) {
      submit();
    } else {
      setStepIdx((i) => Math.min(i + 1, steps.length - 1));
    }
  };

  const goPrev = () => setStepIdx((i) => Math.max(i - 1, 0));

  const submit = () => {
    if (!data.name.trim() || !isValidEmail(data.email)) {
      toast({ title: "Erreur", description: "Vérifiez votre nom et votre email.", variant: "destructive" });
      return;
    }
    setSubmitted(true);
    toast({ title: "Message envoyé !", description: "Nous vous recontacterons rapidement." });
  };

  const handleChoice = (val: string) => {
    setData((d) => ({ ...d, [current.key]: val }));
    // Auto-advance après choix
    if (advanceTimerRef.current) window.clearTimeout(advanceTimerRef.current);
    advanceTimerRef.current = window.setTimeout(() => {
      setStepIdx((i) => Math.min(i + 1, steps.length - 1));
    }, 350);
  };

  const handleKeyDown = (e: React.KeyboardEvent) => {
    if (e.key === "Enter" && current.type !== "textarea") {
      e.preventDefault();
      goNext();
    }
    if (e.key === "Enter" && (e.metaKey || e.ctrlKey) && current.type === "textarea") {
      e.preventDefault();
      goNext();
    }
  };

  const progress = ((stepIdx + (submitted ? 1 : 0)) / steps.length) * 100;
  const inputCls =
    "h-14 text-lg bg-white/[0.04] border-white/[0.08] text-foreground placeholder:text-muted-foreground/60 focus:border-primary/40 focus:ring-primary/20 rounded-2xl";

  const Icon = current.icon;

  return (
    <section id="contact" className="relative py-section lg:py-section-lg overflow-hidden">
      <div className="absolute top-0 left-1/2 -translate-x-1/2 w-[800px] h-[500px] bg-primary/[0.08] rounded-full blur-[220px] pointer-events-none" />

      <div className="container relative z-10 mx-auto px-4 lg:px-8">
        <div className="text-center mb-10">
          <h2 className="text-display-sm md:text-display-md lg:text-display affirm-display mb-6">
            Parlons de votre{" "}
            <span
              className="bg-clip-text text-transparent"
              style={{
                backgroundImage:
                  "linear-gradient(100deg, hsl(220 100% 70%) 0%, hsl(245 100% 75%) 35%, hsl(265 100% 75%) 65%, hsl(300 95% 72%) 100%)",
                WebkitBackgroundClip: "text",
              }}
            >
              situation
            </span>
          </h2>
          <p className="text-body-lg text-muted-foreground max-w-2xl mx-auto font-light">
            Quelques informations suffisent pour que nous puissions revenir vers vous.
          </p>
        </div>

        <div className="grid lg:grid-cols-3 gap-10 max-w-6xl mx-auto">
          <div className="lg:col-span-2">
            <div className="pole-card !min-h-0">
              <div aria-hidden className="pole-card-border" />
              <div className="pole-card-inner">
                <div className="p-8 lg:p-12">
                  {/* Progress */}
                  <div className="mb-8">
                    <div className="flex items-center justify-between mb-3">
                      <span className="text-xs uppercase tracking-[0.16em] text-muted-foreground font-semibold">
                        {submitted ? "Terminé" : `Étape ${stepIdx + 1} / ${steps.length}`}
                      </span>
                      <span className="text-xs text-muted-foreground tabular-nums">
                        {Math.round(progress)} %
                      </span>
                    </div>
                    <div className="h-1.5 rounded-full bg-white/[0.05] overflow-hidden">
                      <div
                        className="h-full rounded-full bg-gradient-to-r from-primary to-primary-light transition-all duration-500 ease-out"
                        style={{ width: `${progress}%` }}
                      />
                    </div>
                  </div>

                  {submitted ? (
                    <div className="text-center py-12 animate-fade-in">
                      <div className="mx-auto mb-6 flex h-16 w-16 items-center justify-center rounded-2xl bg-emerald-500/15 ring-1 ring-emerald-500/30">
                        <Check className="h-8 w-8 text-emerald-300" />
                      </div>
                      <h3 className="text-2xl affirm-display mb-3">Merci {data.name.split(" ")[0]} !</h3>
                      <p className="text-muted-foreground max-w-md mx-auto">
                        Votre demande a bien été reçue. Notre équipe vous recontacte sous 24h ouvrées.
                      </p>
                    </div>
                  ) : (
                    <div key={current.key} className="animate-fade-in">
                      <div className="flex items-center gap-3 mb-6">
                        <div className="flex h-10 w-10 items-center justify-center rounded-xl bg-primary/15 text-primary ring-1 ring-primary/20">
                          <Icon className="h-5 w-5" />
                        </div>
                        <span className="section-badge">{current.label}</span>
                      </div>

                      <h3 className="text-2xl md:text-3xl affirm-display mb-8 leading-tight">
                        {current.question}
                        {current.required && <span className="text-primary ml-1">*</span>}
                      </h3>

                      {current.type === "choice" ? (
                        <div className="grid sm:grid-cols-2 gap-3">
                          {current.options!.map((opt) => {
                            const selected = value === opt.value;
                            return (
                              <button
                                key={opt.value}
                                type="button"
                                onClick={() => handleChoice(opt.value)}
                                className={`group relative rounded-2xl border p-5 text-left transition-all duration-300 hover:-translate-y-0.5 ${
                                  selected
                                    ? "border-primary/50 bg-primary/10 ring-1 ring-primary/30"
                                    : "border-white/[0.08] bg-white/[0.02] hover:border-white/20 hover:bg-white/[0.04]"
                                }`}
                              >
                                <div className="flex items-center justify-between">
                                  <span className="text-base font-medium text-foreground">{opt.label}</span>
                                  <div
                                    className={`flex h-6 w-6 items-center justify-center rounded-full transition-all ${
                                      selected ? "bg-primary text-primary-foreground" : "bg-white/[0.05] text-transparent"
                                    }`}
                                  >
                                    <Check className="h-3.5 w-3.5" />
                                  </div>
                                </div>
                              </button>
                            );
                          })}
                        </div>
                      ) : current.type === "textarea" ? (
                        <Textarea
                          ref={inputRef as React.RefObject<HTMLTextAreaElement>}
                          value={value}
                          onChange={(e) => setData({ ...data, [current.key]: e.target.value })}
                          onKeyDown={handleKeyDown}
                          placeholder={current.placeholder}
                          className="min-h-32 text-base resize-none bg-white/[0.04] border-white/[0.08] text-foreground placeholder:text-muted-foreground/60 focus:border-primary/40 rounded-2xl"
                        />
                      ) : (
                        <Input
                          ref={inputRef as React.RefObject<HTMLInputElement>}
                          type={current.type}
                          value={value}
                          onChange={(e) => setData({ ...data, [current.key]: e.target.value })}
                          onKeyDown={handleKeyDown}
                          placeholder={current.placeholder}
                          className={inputCls}
                        />
                      )}

                      <div className="flex items-center justify-between mt-8">
                        <button
                          type="button"
                          onClick={goPrev}
                          disabled={stepIdx === 0}
                          className="flex items-center gap-2 text-sm text-muted-foreground hover:text-foreground disabled:opacity-30 disabled:cursor-not-allowed transition-colors"
                        >
                          <ArrowLeft className="h-4 w-4" />
                          Retour
                        </button>

                        {current.type !== "choice" && (
                          <button
                            type="button"
                            onClick={goNext}
                            disabled={!canAdvance()}
                            className="btn-pill-white disabled:opacity-40 disabled:cursor-not-allowed"
                          >
                            {isLast ? "Envoyer ma demande" : "Continuer"}
                          </button>
                        )}
                      </div>

                      <p className="text-xs text-muted-foreground/70 mt-4">
                        Appuyez sur <kbd className="px-1.5 py-0.5 rounded bg-white/[0.06] text-foreground/80">Entrée</kbd> pour continuer
                      </p>
                    </div>
                  )}
                </div>
              </div>
            </div>
          </div>

          <div className="space-y-6">
            <div className="pole-card !min-h-0">
              <div aria-hidden className="pole-card-border" />
              <div className="pole-card-inner">
                <div className="p-8">
                  <h3 className="text-heading-4 text-foreground mb-6 font-medium">Coordonnées</h3>
                  <div className="space-y-5">
                    <div className="flex items-start gap-4">
                      <div className="w-10 h-10 rounded-xl bg-primary/15 border border-primary/20 flex items-center justify-center flex-shrink-0">
                        <Mail className="w-4 h-4 text-primary-light" />
                      </div>
                      <div>
                        <p className="text-micro text-muted-foreground uppercase mb-1">Email</p>
                        <a href="mailto:admin@klary.ch" className="text-body-sm text-foreground hover:text-primary-light transition-colors font-medium">admin@klary.ch</a>
                      </div>
                    </div>
                    <div className="flex items-start gap-4">
                      <div className="w-10 h-10 rounded-xl bg-primary/15 border border-primary/20 flex items-center justify-center flex-shrink-0">
                        <Phone className="w-4 h-4 text-primary-light" />
                      </div>
                      <div>
                        <p className="text-micro text-muted-foreground uppercase mb-1">Téléphone</p>
                        <a href="tel:+41225000000" className="text-body-sm text-foreground hover:text-primary-light transition-colors font-medium">+41 22 500 00 00</a>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>
  );
};
