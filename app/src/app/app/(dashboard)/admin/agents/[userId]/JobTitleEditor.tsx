"use client";

import { useState } from "react";
import { useRouter } from "next/navigation";

const JOB_TITLES = [
  { value: "", label: "— Non défini —" },
  { value: "conseiller", label: "Conseiller" },
  { value: "telephoniste", label: "Téléphoniste" },
];

export function JobTitleEditor({
  userId,
  currentJobTitle,
}: {
  userId: string;
  currentJobTitle: string | null;
}) {
  const router = useRouter();
  const [value, setValue] = useState<string>(currentJobTitle || "");
  const [saving, setSaving] = useState(false);
  const [saved, setSaved] = useState(false);
  const [error, setError] = useState<string | null>(null);

  const changed = value !== (currentJobTitle || "");

  const save = async () => {
    setSaving(true);
    setSaved(false);
    setError(null);
    try {
      const res = await fetch(`/api/admin/agents/${userId}/update-job`, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
          job_title: value || null,
        }),
      });
      const data = await res.json();
      if (!res.ok) {
        setError(data?.error || "Erreur");
        setSaving(false);
        return;
      }
      setSaved(true);
      router.refresh();
      setTimeout(() => setSaved(false), 2000);
    } catch {
      setError("Erreur réseau");
    } finally {
      setSaving(false);
    }
  };

  return (
    <div className="p-4 bg-klary-cream/60 rounded-xl">
      <div className="flex items-center justify-between gap-3">
        <div className="flex-1">
          <label className="block text-[10px] uppercase tracking-widest text-klary-grey font-bold mb-1.5">
            Poste occupé
          </label>
          <select
            value={value}
            onChange={(e) => setValue(e.target.value)}
            className="w-full px-3 py-2 border border-klary-light-grey rounded-lg text-sm bg-white focus:outline-none focus:border-klary-orange"
          >
            {JOB_TITLES.map((j) => (
              <option key={j.value} value={j.value}>
                {j.label}
              </option>
            ))}
          </select>
        </div>
        <div className="pt-6">
          <button
            onClick={save}
            disabled={!changed || saving}
            className={`px-4 py-2 rounded-lg text-sm font-semibold transition ${
              !changed || saving
                ? "bg-klary-grey/20 text-klary-grey cursor-not-allowed"
                : saved
                ? "bg-green-600 text-white"
                : "bg-klary-orange text-white hover:bg-klary-orange/90"
            }`}
          >
            {saving ? "…" : saved ? "✓ Enregistré" : "Enregistrer"}
          </button>
        </div>
      </div>
      {error && (
        <div className="mt-2 text-xs text-red-600">{error}</div>
      )}
      <div className="mt-2 text-[11px] text-klary-grey">
        Le poste détermine quels documents de la bibliothèque cet agent peut consulter.
      </div>
    </div>
  );
}
