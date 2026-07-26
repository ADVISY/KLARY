"use client";

import { useState } from "react";
import { useRouter } from "next/navigation";

const REASONS = [
  { value: "demission", label: "Démission" },
  { value: "mutuel_accord", label: "Rupture d'un commun accord" },
  { value: "rupture_essai", label: "Rupture période d'essai" },
  { value: "fin_cdd", label: "Fin CDD" },
  { value: "retraite", label: "Départ à la retraite" },
  { value: "licenciement", label: "Licenciement (préavis normal)" },
  { value: "faute_grave", label: "Licenciement pour faute grave (art. 337 CO)" },
  { value: "abandon_poste", label: "Abandon de poste" },
];

const SENSITIVE = new Set(["faute_grave", "abandon_poste", "licenciement"]);

export function InitiateOffboardingModal({
  agentId,
  agentName,
}: {
  agentId: string;
  agentName: string;
}) {
  const router = useRouter();
  const [open, setOpen] = useState(false);
  const [reason, setReason] = useState("");
  const [lastDay, setLastDay] = useState("");
  const [notes, setNotes] = useState("");
  const [submitting, setSubmitting] = useState(false);
  const [error, setError] = useState<string | null>(null);

  const isSensitive = SENSITIVE.has(reason);

  const submit = async () => {
    setSubmitting(true);
    setError(null);
    try {
      const res = await fetch("/api/admin/offboarding/initiate", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
          user_id: agentId,
          reason,
          last_working_day: lastDay,
          admin_notes: notes,
        }),
      });
      const data = await res.json();
      if (!res.ok) {
        setError(data?.error || "Erreur");
        setSubmitting(false);
        return;
      }
      router.push(data.redirectUrl || "/admin/offboarding");
    } catch {
      setError("Erreur réseau");
      setSubmitting(false);
    }
  };

  return (
    <>
      <button
        onClick={() => setOpen(true)}
        className="text-xs font-semibold text-red-600 hover:underline"
      >
        Initier offboarding →
      </button>

      {open && (
        <div className="fixed inset-0 z-50 flex items-center justify-center p-4 bg-black/50">
          <div className="bg-white rounded-2xl max-w-lg w-full p-6 shadow-2xl">
            <div className="flex items-start justify-between mb-4">
              <div>
                <div className="text-xs font-bold uppercase tracking-widest text-red-600 mb-1">
                  ⚠ Action critique
                </div>
                <h2 className="text-xl font-bold text-klary-navy">
                  Initier offboarding
                </h2>
                <div className="text-sm text-klary-grey mt-1">
                  Agent : <strong>{agentName}</strong>
                </div>
              </div>
              <button
                onClick={() => setOpen(false)}
                className="text-klary-grey hover:text-klary-navy text-2xl leading-none"
              >
                ×
              </button>
            </div>

            <div className="p-3 bg-red-50 border-l-4 border-red-500 rounded text-xs text-red-900 mb-4">
              <strong>Cette action est irréversible.</strong> En confirmant :
              <ul className="list-disc pl-5 mt-1 space-y-0.5">
                <li>
                  L'accès de l'agent à app.klary.ch est <strong>immédiatement révoqué</strong>
                </li>
                <li>
                  Email URGENT envoyé à <code>office@klary.ch</code> pour révoquer les autres accès (Infomaniak, LYTA, Google, badges, compagnies)
                </li>
                <li>Email agent l'informant du départ (sans PJ)</li>
                <li>Email supervision admin + avocat</li>
                <li>Convention de sortie disponible dans le dossier</li>
              </ul>
            </div>

            <div className="space-y-4">
              <div>
                <label className="block text-xs font-semibold text-klary-ink mb-1.5">
                  Motif du départ *
                </label>
                <select
                  value={reason}
                  onChange={(e) => setReason(e.target.value)}
                  className="w-full px-3 py-2 border border-klary-light-grey rounded-lg text-sm focus:outline-none focus:border-klary-orange"
                >
                  <option value="">— Sélectionnez —</option>
                  {REASONS.map((r) => (
                    <option key={r.value} value={r.value}>
                      {r.label}
                    </option>
                  ))}
                </select>
                {isSensitive && (
                  <div className="mt-2 p-2 bg-red-50 border-l-4 border-red-500 rounded text-xs text-red-900">
                    🚨 Motif sensible — l'avocat sera alerté automatiquement.
                    Consultez-le AVANT de confirmer si possible.
                  </div>
                )}
              </div>

              <div>
                <label className="block text-xs font-semibold text-klary-ink mb-1.5">
                  Dernier jour travaillé *
                </label>
                <input
                  type="date"
                  value={lastDay}
                  onChange={(e) => setLastDay(e.target.value)}
                  className="w-full px-3 py-2 border border-klary-light-grey rounded-lg text-sm focus:outline-none focus:border-klary-orange"
                />
              </div>

              <div>
                <label className="block text-xs font-semibold text-klary-ink mb-1.5">
                  Notes admin (facultatif — visible aux équipes finance/office/avocat)
                </label>
                <textarea
                  value={notes}
                  onChange={(e) => setNotes(e.target.value)}
                  rows={3}
                  className="w-full px-3 py-2 border border-klary-light-grey rounded-lg text-sm focus:outline-none focus:border-klary-orange"
                  placeholder="Contexte, éléments clés, points d'attention…"
                />
              </div>

              {error && (
                <div className="p-3 bg-red-50 border-l-4 border-red-400 rounded text-xs text-red-800">
                  {error}
                </div>
              )}
            </div>

            <div className="flex gap-2 mt-6">
              <button
                onClick={() => setOpen(false)}
                className="flex-1 py-2.5 border border-klary-light-grey text-klary-navy font-semibold rounded-lg hover:border-klary-navy text-sm"
              >
                Annuler
              </button>
              <button
                onClick={submit}
                disabled={submitting || !reason || !lastDay}
                className="flex-1 py-2.5 bg-red-600 text-white font-semibold rounded-lg hover:bg-red-700 disabled:opacity-40 disabled:cursor-not-allowed text-sm"
              >
                {submitting ? "Envoi…" : "Confirmer et notifier équipe"}
              </button>
            </div>
          </div>
        </div>
      )}
    </>
  );
}
