"use client";

import { useState } from "react";

const CHARGE_OPTIONS = [
  { value: "tres_faible", label: "😴 Beaucoup trop faible (je m'ennuie)" },
  { value: "faible", label: "🙂 Un peu trop faible" },
  { value: "equilibree", label: "✅ Équilibrée" },
  { value: "lourde", label: "😅 Un peu trop lourde" },
  { value: "tres_lourde", label: "🔥 Beaucoup trop lourde (débordé)" },
];

export function BarometerForm({ token }: { token: string }) {
  const [q1, setQ1] = useState<number>(7);
  const [q2, setQ2] = useState<string>("");
  const [q3, setQ3] = useState<number>(7);
  const [q4, setQ4] = useState<number>(7);
  const [q6, setQ6] = useState<number>(7);
  const [q5, setQ5] = useState<string>("");
  const [q7, setQ7] = useState<string>("");
  const [submitting, setSubmitting] = useState(false);
  const [done, setDone] = useState(false);
  const [error, setError] = useState<string | null>(null);

  const submit = async (e: React.FormEvent) => {
    e.preventDefault();
    setError(null);
    if (!q2) {
      setError("Merci de répondre à la question sur la charge de travail.");
      return;
    }
    setSubmitting(true);
    try {
      const res = await fetch("/api/barometre/submit", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
          token,
          q1_enps: q1,
          q2_charge: q2,
          q3_ambiance: q3,
          q4_manager: q4,
          q6_motivation: q6,
          q5_improve: q5.trim(),
          q7_continue: q7.trim(),
        }),
      });
      const data = await res.json();
      if (!res.ok) {
        setError(data?.error || "Erreur — réessaye.");
        setSubmitting(false);
        return;
      }
      setDone(true);
    } catch (err: any) {
      setError("Erreur réseau — réessaye.");
      setSubmitting(false);
    }
  };

  if (done) {
    return (
      <div className="bg-white rounded-2xl border-2 border-green-300 p-8 text-center shadow-sm">
        <div className="w-16 h-16 mx-auto mb-4 rounded-full bg-green-100 flex items-center justify-center text-3xl">
          ✅
        </div>
        <h2 className="text-2xl font-bold text-klary-navy mb-2">Merci !</h2>
        <p className="text-klary-grey">
          Ta réponse a bien été enregistrée. Elle est 100% anonyme.
        </p>
        <p className="text-klary-grey text-sm mt-4">
          Tu peux fermer cette page.
        </p>
      </div>
    );
  }

  return (
    <form onSubmit={submit} className="space-y-6">
      {/* Q1 eNPS */}
      <QuestionCard
        num="1"
        title="À quel point recommanderais-tu Klary comme employeur ?"
        subtitle="1 = jamais · 10 = les yeux fermés"
      >
        <SliderInput value={q1} onChange={setQ1} />
      </QuestionCard>

      {/* Q2 Charge */}
      <QuestionCard
        num="2"
        title="Ta charge de travail ce mois-ci"
        subtitle="Sois honnête — c'est le seul moyen qu'on ajuste."
      >
        <div className="space-y-2">
          {CHARGE_OPTIONS.map((opt) => (
            <label
              key={opt.value}
              className={`flex items-center gap-3 p-3 rounded-lg border-2 cursor-pointer transition ${
                q2 === opt.value
                  ? "border-klary-orange bg-klary-orange/5"
                  : "border-klary-light-grey hover:border-klary-orange/40"
              }`}
            >
              <input
                type="radio"
                name="q2"
                value={opt.value}
                checked={q2 === opt.value}
                onChange={() => setQ2(opt.value)}
                className="accent-klary-orange"
              />
              <span className="text-sm">{opt.label}</span>
            </label>
          ))}
        </div>
      </QuestionCard>

      {/* Q3 Ambiance */}
      <QuestionCard
        num="3"
        title="L'ambiance dans l'équipe ce mois-ci"
        subtitle="1 = tendu · 10 = super"
      >
        <SliderInput value={q3} onChange={setQ3} />
      </QuestionCard>

      {/* Q4 Manager */}
      <QuestionCard
        num="4"
        title="Le soutien reçu de ton manager ce mois-ci"
        subtitle="1 = jamais dispo · 10 = toujours à l'écoute"
      >
        <SliderInput value={q4} onChange={setQ4} />
      </QuestionCard>

      {/* Q6 Motivation */}
      <QuestionCard
        num="5"
        title="Ta motivation globale ce mois-ci"
        subtitle="1 = au fond du trou · 10 = à fond"
      >
        <SliderInput value={q6} onChange={setQ6} />
      </QuestionCard>

      {/* Q5 À améliorer */}
      <QuestionCard
        num="6"
        title="Une chose que Klary pourrait améliorer ?"
        subtitle="Facultatif — 300 caractères max"
      >
        <textarea
          value={q5}
          onChange={(e) => setQ5(e.target.value.slice(0, 300))}
          rows={3}
          placeholder="Ex : plus de flexibilité horaires · meilleure biblio · outil X qui manque · ..."
          className="w-full px-4 py-3 border border-klary-light-grey rounded-lg text-sm focus:outline-none focus:border-klary-orange"
        />
        <div className="text-[10px] text-klary-grey text-right mt-1">
          {q5.length}/300
        </div>
      </QuestionCard>

      {/* Q7 À continuer */}
      <QuestionCard
        num="7"
        title="Une chose que Klary fait bien à continuer ?"
        subtitle="Facultatif — 300 caractères max"
      >
        <textarea
          value={q7}
          onChange={(e) => setQ7(e.target.value.slice(0, 300))}
          rows={3}
          placeholder="Ex : ambiance top · commissions justes · outils formation · ..."
          className="w-full px-4 py-3 border border-klary-light-grey rounded-lg text-sm focus:outline-none focus:border-klary-orange"
        />
        <div className="text-[10px] text-klary-grey text-right mt-1">
          {q7.length}/300
        </div>
      </QuestionCard>

      {error && (
        <div className="p-3 bg-red-50 border border-red-300 rounded-lg text-sm text-red-800">
          {error}
        </div>
      )}

      <button
        type="submit"
        disabled={submitting}
        className={`w-full py-4 rounded-xl font-bold text-white text-lg transition ${
          submitting
            ? "bg-klary-grey/40 cursor-wait"
            : "bg-klary-orange hover:bg-klary-orange/90 shadow-lg"
        }`}
      >
        {submitting ? "Envoi en cours…" : "🖊 Envoyer mes réponses"}
      </button>

      <p className="text-center text-[11px] text-klary-grey">
        En cliquant, tu envoies tes réponses de façon <strong>100% anonyme</strong> — aucun
        identifiant n'est associé à tes réponses.
      </p>
    </form>
  );
}

function QuestionCard({
  num,
  title,
  subtitle,
  children,
}: {
  num: string;
  title: string;
  subtitle?: string;
  children: React.ReactNode;
}) {
  return (
    <div className="bg-white rounded-2xl border border-klary-light-grey p-5 md:p-6 shadow-sm">
      <div className="flex items-start gap-3 mb-4">
        <div className="w-8 h-8 shrink-0 rounded-full bg-klary-orange text-white font-bold flex items-center justify-center text-sm">
          {num}
        </div>
        <div className="flex-1">
          <h3 className="font-bold text-klary-navy text-base leading-tight">{title}</h3>
          {subtitle && (
            <p className="text-xs text-klary-grey mt-0.5">{subtitle}</p>
          )}
        </div>
      </div>
      {children}
    </div>
  );
}

function SliderInput({
  value,
  onChange,
}: {
  value: number;
  onChange: (n: number) => void;
}) {
  return (
    <div>
      <div className="flex justify-between text-[10px] text-klary-grey uppercase tracking-widest mb-2">
        <span>1</span>
        <span>5</span>
        <span>10</span>
      </div>
      <input
        type="range"
        min={1}
        max={10}
        step={1}
        value={value}
        onChange={(e) => onChange(Number(e.target.value))}
        className="w-full accent-klary-orange h-2"
      />
      <div className="text-center mt-3">
        <span className="inline-block px-4 py-1.5 rounded-full bg-klary-navy text-white font-bold text-lg">
          {value}
        </span>
      </div>
    </div>
  );
}
