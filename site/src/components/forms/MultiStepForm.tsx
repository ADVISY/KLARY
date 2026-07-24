import { useState } from "react";
import { ChevronLeft, ChevronRight, Check, Send } from "lucide-react";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Slider } from "@/components/ui/slider";
import { Button } from "@/components/ui/button";
import { useToast } from "@/hooks/use-toast";

export type FormField =
  | { type: "radio"; name: string; label: string; options: { value: string; label: string; hint?: string }[] }
  | { type: "select"; name: string; label: string; options: { value: string; label: string }[]; placeholder?: string }
  | { type: "number"; name: string; label: string; placeholder?: string; min?: number; max?: number; suffix?: string }
  | { type: "text"; name: string; label: string; placeholder?: string }
  | { type: "email"; name: string; label: string; placeholder?: string }
  | { type: "tel"; name: string; label: string; placeholder?: string }
  | { type: "slider"; name: string; label: string; min: number; max: number; step: number; suffix?: string; defaultValue?: number };

export interface FormStep {
  id: string;
  title: string;
  description?: string;
  fields: FormField[];
}

interface MultiStepFormProps {
  steps: FormStep[];
  category: string;
  ctaLabel?: string;
}

export const MultiStepForm = ({ steps, category, ctaLabel = "Recevoir mon analyse" }: MultiStepFormProps) => {
  const { toast } = useToast();
  const [stepIndex, setStepIndex] = useState(0);
  const [data, setData] = useState<Record<string, string | number>>({});
  const [submitting, setSubmitting] = useState(false);
  const [done, setDone] = useState(false);

  // Final contact step appended automatically
  const contactStep: FormStep = {
    id: "contact",
    title: "Vos coordonnées",
    description: "Pour recevoir votre analyse personnalisée par un conseiller Klary.",
    fields: [
      { type: "text", name: "prenom", label: "Prénom", placeholder: "Jean" },
      { type: "text", name: "nom", label: "Nom", placeholder: "Dupont" },
      { type: "email", name: "email", label: "Email", placeholder: "vous@exemple.ch" },
      { type: "tel", name: "telephone", label: "Téléphone", placeholder: "+41 XX XXX XX XX" },
    ],
  };

  const allSteps = [...steps, contactStep];
  const total = allSteps.length;
  const current = allSteps[stepIndex];
  const progress = ((stepIndex + 1) / total) * 100;

  const setField = (name: string, value: string | number) => {
    setData((d) => ({ ...d, [name]: value }));
  };

  const isStepValid = () => {
    return current.fields.every((f) => {
      if (f.type === "slider") return true;
      const v = data[f.name];
      return v !== undefined && v !== "" && v !== null;
    });
  };

  const next = () => {
    if (!isStepValid()) {
      toast({ title: "Champ requis", description: "Merci de compléter cette étape." });
      return;
    }
    if (stepIndex < total - 1) {
      setStepIndex((i) => i + 1);
    } else {
      submit();
    }
  };

  const prev = () => stepIndex > 0 && setStepIndex((i) => i - 1);

  const submit = async () => {
    setSubmitting(true);
    // TODO branch backend later
    await new Promise((r) => setTimeout(r, 800));
    setSubmitting(false);
    setDone(true);
    toast({
      title: "✅ Demande envoyée",
      description: "Un conseiller Klary vous recontacte sous 24h ouvrées.",
    });
  };

  if (done) {
    return (
      <div className="premium-card p-10 md:p-14 text-center max-w-2xl mx-auto">
        <div
          className="w-16 h-16 rounded-full mx-auto mb-6 flex items-center justify-center"
          style={{
            background: "linear-gradient(135deg, hsl(150 70% 50%), hsl(170 70% 45%))",
            boxShadow: "0 8px 30px hsl(150 70% 40% / 0.4)",
          }}
        >
          <Check className="w-8 h-8 text-white" strokeWidth={2.5} />
        </div>
        <h3 className="text-2xl md:text-3xl affirm-display mb-3">Merci, c'est noté.</h3>
        <p className="text-muted-foreground font-light leading-relaxed">
          Un conseiller Klary analyse votre situation et vous recontacte personnellement sous 24h ouvrées.
          En attendant, vous pouvez nous écrire à <strong className="text-foreground">admin@klary.ch</strong>.
        </p>
      </div>
    );
  }

  return (
    <div className="premium-card p-6 md:p-10 max-w-2xl mx-auto">
      {/* Progress bar */}
      <div className="mb-8">
        <div className="flex items-center justify-between mb-3 text-xs text-muted-foreground">
          <span className="uppercase tracking-wider">{category}</span>
          <span>
            Étape {stepIndex + 1} / {total}
          </span>
        </div>
        <div className="h-1 w-full rounded-full bg-white/[0.06] overflow-hidden">
          <div
            className="h-full rounded-full transition-all duration-500 ease-out"
            style={{
              width: `${progress}%`,
              background: "linear-gradient(90deg, hsl(220 100% 65%), hsl(252 90% 70%))",
              boxShadow: "0 0 12px hsl(252 90% 65% / 0.6)",
            }}
          />
        </div>
      </div>

      {/* Step content */}
      <div className="space-y-6 animate-fade-in" key={current.id}>
        <div className="space-y-2">
          <h3 className="text-xl md:text-2xl font-light text-foreground tracking-tight">
            {current.title}
          </h3>
          {current.description && (
            <p className="text-sm text-muted-foreground font-light">{current.description}</p>
          )}
        </div>

        <div className="space-y-5">
          {current.fields.map((f) => (
            <FieldRenderer
              key={f.name}
              field={f}
              value={data[f.name]}
              onChange={(v) => {
                setField(f.name, v);
                // auto-advance on radio if it's the only field of this step
                if (f.type === "radio" && current.fields.length === 1) {
                  setTimeout(() => {
                    if (stepIndex < total - 1) setStepIndex((i) => i + 1);
                  }, 250);
                }
              }}
            />
          ))}
        </div>

        {/* Nav */}
        <div className="flex items-center justify-between pt-4">
          <Button
            type="button"
            variant="ghost"
            onClick={prev}
            disabled={stepIndex === 0}
            className="gap-2 text-muted-foreground hover:text-foreground"
          >
            <ChevronLeft className="w-4 h-4" />
            Précédent
          </Button>
          <Button
            type="button"
            onClick={next}
            disabled={submitting}
            className="gap-2 rounded-full px-6"
            style={{
              background: "linear-gradient(135deg, hsl(220 100% 65%), hsl(252 90% 65%))",
              color: "#fff",
            }}
          >
            {stepIndex === total - 1 ? (
              <>
                {submitting ? "Envoi..." : ctaLabel}
                <Send className="w-4 h-4" />
              </>
            ) : (
              <>
                Suivant
                <ChevronRight className="w-4 h-4" />
              </>
            )}
          </Button>
        </div>
      </div>
    </div>
  );
};

const FieldRenderer = ({
  field,
  value,
  onChange,
}: {
  field: FormField;
  value: string | number | undefined;
  onChange: (v: string | number) => void;
}) => {
  if (field.type === "radio") {
    return (
      <div className="space-y-2">
        <Label className="text-sm text-muted-foreground font-light">{field.label}</Label>
        <div className="grid sm:grid-cols-2 gap-3">
          {field.options.map((o) => {
            const active = value === o.value;
            return (
              <button
                type="button"
                key={o.value}
                onClick={() => onChange(o.value)}
                className="text-left p-4 rounded-2xl transition-all"
                style={{
                  background: active
                    ? "linear-gradient(135deg, hsl(220 100% 65% / 0.18), hsl(252 90% 65% / 0.10))"
                    : "rgba(255,255,255,0.03)",
                  border: active
                    ? "1px solid hsl(220 100% 70% / 0.5)"
                    : "1px solid hsl(0 0% 100% / 0.06)",
                  boxShadow: active ? "0 0 24px hsl(252 90% 65% / 0.25)" : "none",
                }}
              >
                <div className="text-sm font-medium text-foreground">{o.label}</div>
                {o.hint && (
                  <div className="text-xs text-muted-foreground font-light mt-1">{o.hint}</div>
                )}
              </button>
            );
          })}
        </div>
      </div>
    );
  }

  if (field.type === "select") {
    return (
      <div className="space-y-2">
        <Label className="text-sm text-muted-foreground font-light">{field.label}</Label>
        <select
          value={(value as string) ?? ""}
          onChange={(e) => onChange(e.target.value)}
          className="w-full h-11 rounded-xl px-4 bg-white/[0.03] border border-white/[0.08] text-foreground focus:outline-none focus:border-primary/60"
        >
          <option value="">{field.placeholder ?? "Sélectionnez..."}</option>
          {field.options.map((o) => (
            <option key={o.value} value={o.value}>
              {o.label}
            </option>
          ))}
        </select>
      </div>
    );
  }

  if (field.type === "slider") {
    const v = (value as number) ?? field.defaultValue ?? field.min;
    return (
      <div className="space-y-3">
        <div className="flex items-center justify-between">
          <Label className="text-sm text-muted-foreground font-light">{field.label}</Label>
          <span className="text-sm font-medium text-primary-light">
            {v}
            {field.suffix ? ` ${field.suffix}` : ""}
          </span>
        </div>
        <Slider
          value={[v]}
          min={field.min}
          max={field.max}
          step={field.step}
          onValueChange={([nv]) => onChange(nv)}
        />
      </div>
    );
  }

  if (field.type === "number") {
    return (
      <div className="space-y-2">
        <Label className="text-sm text-muted-foreground font-light">{field.label}</Label>
        <div className="relative">
          <Input
            type="number"
            min={field.min}
            max={field.max}
            placeholder={field.placeholder}
            value={(value as number) ?? ""}
            onChange={(e) => onChange(e.target.value === "" ? "" : Number(e.target.value))}
            className="bg-white/[0.03] border-white/[0.08] h-11"
          />
          {field.suffix && (
            <span className="absolute right-4 top-1/2 -translate-y-1/2 text-sm text-muted-foreground">
              {field.suffix}
            </span>
          )}
        </div>
      </div>
    );
  }

  return (
    <div className="space-y-2">
      <Label className="text-sm text-muted-foreground font-light">{field.label}</Label>
      <Input
        type={field.type}
        placeholder={field.placeholder}
        value={(value as string) ?? ""}
        onChange={(e) => onChange(e.target.value)}
        className="bg-white/[0.03] border-white/[0.08] h-11"
      />
    </div>
  );
};
