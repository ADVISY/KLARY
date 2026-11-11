"use client";

import { useRouter } from "next/navigation";
import { useState } from "react";
import type { ReportField } from "@/lib/reports/fields";

type Initial = {
  metrics: Record<string, number>;
  summary: string;
  problem: string;
  solution: string;
} | null;

const inputClass =
  "w-full rounded-lg border border-klary-light-grey bg-white px-3 py-2.5 text-klary-navy focus:outline-none focus:border-klary-orange focus:ring-2 focus:ring-klary-orange/20 transition";

export function ReportForm({
  fields,
  initial,
}: {
  fields: ReportField[];
  initial: Initial;
}) {
  const router = useRouter();
  const [values, setValues] = useState<Record<string, string>>(() =>
    Object.fromEntries(
      fields.map((f) => [f.key, initial?.metrics[f.key]?.toString() ?? ""])
    )
  );
  const [summary, setSummary] = useState(initial?.summary ?? "");
  const [problem, setProblem] = useState(initial?.problem ?? "");
  const [solution, setSolution] = useState(initial?.solution ?? "");
  const [saving, setSaving] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const [saved, setSaved] = useState(false);

  async function submit(e: React.FormEvent) {
    e.preventDefault();
    setSaving(true);
    setError(null);
    setSaved(false);
    try {
      const metrics = Object.fromEntries(
        fields.map((f) => {
          const raw = (values[f.key] ?? "").replace(",", ".").trim();
          return [f.key, raw === "" ? null : Number(raw)];
        })
      );
      const res = await fetch("/api/rapport", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ metrics, summary, problem, solution }),
      });
      const body = await res.json().catch(() => ({}));
      if (!res.ok) {
        setError(body.error || "Enregistrement impossible, réessayez.");
        return;
      }
      setSaved(true);
      router.refresh();
    } catch {
      setError("Enregistrement impossible, vérifiez votre connexion.");
    } finally {
      setSaving(false);
    }
  }

  return (
    <form
      onSubmit={submit}
      className="bg-white rounded-2xl border border-klary-light-grey p-5 md:p-6 space-y-5"
    >
      {initial && !saved && (
        <p className="text-sm font-medium text-green-700 bg-green-50 rounded-lg px-3 py-2">
          Rapport envoyé. Vous pouvez le corriger jusqu&apos;à minuit.
        </p>
      )}

      {fields.length > 0 && (
        <div className="grid sm:grid-cols-2 gap-4">
          {fields.map((f) => (
            <label key={f.key} className="block">
              <span className="block text-sm font-semibold text-klary-navy mb-1">
                {f.question ?? f.label}
                {f.optional && (
                  <span className="font-normal text-klary-grey">
                    {" "}
                    (si concerné)
                  </span>
                )}
              </span>
              <input
                type="text"
                inputMode={f.decimal ? "decimal" : "numeric"}
                required={!f.optional}
                value={values[f.key] ?? ""}
                onChange={(e) =>
                  setValues((v) => ({ ...v, [f.key]: e.target.value }))
                }
                className={inputClass}
              />
            </label>
          ))}
        </div>
      )}

      <label className="block">
        <span className="block text-sm font-semibold text-klary-navy mb-1">
          Ma journée en quelques lignes
        </span>
        <textarea
          required
          rows={3}
          maxLength={2000}
          value={summary}
          onChange={(e) => setSummary(e.target.value)}
          className={inputClass}
        />
      </label>

      <label className="block">
        <span className="block text-sm font-semibold text-klary-navy mb-1">
          Un problème rencontré{" "}
          <span className="font-normal text-klary-grey">(si besoin)</span>
        </span>
        <textarea
          rows={2}
          maxLength={2000}
          value={problem}
          onChange={(e) => setProblem(e.target.value)}
          className={inputClass}
        />
      </label>

      <label className="block">
        <span className="block text-sm font-semibold text-klary-navy mb-1">
          Une solution ou une idée{" "}
          <span className="font-normal text-klary-grey">(si besoin)</span>
        </span>
        <textarea
          rows={2}
          maxLength={2000}
          value={solution}
          onChange={(e) => setSolution(e.target.value)}
          className={inputClass}
        />
      </label>

      {error && (
        <p role="alert" className="text-sm font-medium text-red-700">
          {error}
        </p>
      )}
      {saved && (
        <p role="status" className="text-sm font-medium text-green-700">
          Merci, votre rapport est bien enregistré.
        </p>
      )}

      <button
        type="submit"
        disabled={saving}
        className="w-full sm:w-auto min-h-[44px] rounded-lg bg-klary-orange px-6 py-2.5 font-semibold text-white hover:bg-klary-orange/90 transition-colors disabled:opacity-60"
      >
        {saving
          ? "Envoi…"
          : initial
            ? "Mettre à jour mon rapport"
            : "Envoyer mon rapport"}
      </button>
    </form>
  );
}
