"use client";

import { useState } from "react";
import { useRouter } from "next/navigation";

const ROLES = [
  { value: "agent", label: "Agent — conseiller / téléphoniste" },
  { value: "backoffice", label: "Backoffice — bibliothèque + candidatures + contacts" },
  { value: "manager", label: "Manager — accès admin complet" },
  { value: "admin", label: "Admin — accès total" },
];

const ROLE_WARNING: Record<string, string> = {
  admin: "⚠ Accès total : gestion agents, offboarding, coffre-fort, config.",
  manager: "Accès admin complet (sans changement de rôles).",
  backoffice: "Accès limité : Bibliothèque + Candidatures + Messages contact uniquement.",
  agent: "Agent conseiller / téléphoniste — pas d'accès admin.",
};

export function RoleEditor({
  userId,
  currentRole,
  isSelf,
}: {
  userId: string;
  currentRole: string;
  isSelf: boolean;
}) {
  const router = useRouter();
  const [value, setValue] = useState<string>(currentRole);
  const [saving, setSaving] = useState(false);
  const [saved, setSaved] = useState(false);
  const [error, setError] = useState<string | null>(null);

  const changed = value !== currentRole;
  const dangerous = value !== currentRole && (currentRole === "admin" || value === "admin");

  const save = async () => {
    if (isSelf) {
      setError("Vous ne pouvez pas modifier votre propre rôle.");
      return;
    }
    if (dangerous) {
      const ok = window.confirm(
        `Confirmer le passage de « ${currentRole} » à « ${value} » ? Cette action est sensible.`
      );
      if (!ok) return;
    }
    setSaving(true);
    setSaved(false);
    setError(null);
    try {
      const res = await fetch(`/api/admin/agents/${userId}/update-role`, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ role: value }),
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
            Rôle système
          </label>
          <select
            value={value}
            onChange={(e) => setValue(e.target.value)}
            disabled={isSelf}
            className="w-full px-3 py-2 border border-klary-light-grey rounded-lg text-sm bg-white focus:outline-none focus:border-klary-orange disabled:bg-klary-light-grey/30 disabled:cursor-not-allowed"
          >
            {ROLES.map((r) => (
              <option key={r.value} value={r.value}>
                {r.label}
              </option>
            ))}
          </select>
        </div>
        <div className="pt-6">
          <button
            onClick={save}
            disabled={!changed || saving || isSelf}
            className={`px-4 py-2 rounded-lg text-sm font-semibold transition ${
              !changed || saving || isSelf
                ? "bg-klary-grey/20 text-klary-grey cursor-not-allowed"
                : saved
                ? "bg-green-600 text-white"
                : dangerous
                ? "bg-red-600 text-white hover:bg-red-700"
                : "bg-klary-orange text-white hover:bg-klary-orange/90"
            }`}
          >
            {saving ? "…" : saved ? "✓ Enregistré" : "Enregistrer"}
          </button>
        </div>
      </div>
      {error && <div className="mt-2 text-xs text-red-600">{error}</div>}
      <div className="mt-2 text-[11px] text-klary-grey">
        {isSelf
          ? "Vous ne pouvez pas modifier votre propre rôle."
          : ROLE_WARNING[value] || ""}
      </div>
    </div>
  );
}
