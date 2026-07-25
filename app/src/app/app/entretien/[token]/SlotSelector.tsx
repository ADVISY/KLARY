"use client";

import { useState } from "react";
import { useRouter } from "next/navigation";

type Slot = {
  start: string;
  duration_min: number;
};

function formatSlot(iso: string): string {
  return new Date(iso).toLocaleString("fr-CH", {
    weekday: "long",
    day: "numeric",
    month: "long",
    year: "numeric",
    hour: "2-digit",
    minute: "2-digit",
    timeZone: "Europe/Zurich",
  });
}

export function SlotSelector({
  token,
  slots,
}: {
  token: string;
  slots: Slot[];
}) {
  const [selected, setSelected] = useState<number | null>(null);
  const [submitting, setSubmitting] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const router = useRouter();

  const confirm = async () => {
    if (selected === null) return;
    setError(null);
    setSubmitting(true);
    try {
      const res = await fetch("/api/entretien/select", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ token, slot_index: selected }),
      });
      const data = await res.json();
      if (!res.ok) {
        setError(data.error || "Erreur d'enregistrement");
        setSubmitting(false);
        return;
      }
      // Recharger la page pour afficher l'écran "déjà confirmé"
      router.refresh();
    } catch (e) {
      setError("Erreur réseau. Réessayez.");
      setSubmitting(false);
    }
  };

  return (
    <div>
      <div className="space-y-3 mb-6">
        {slots.map((slot, i) => (
          <button
            key={i}
            type="button"
            onClick={() => setSelected(i)}
            className={`w-full text-left p-4 rounded-xl border-2 transition-all ${
              selected === i
                ? "border-klary-orange bg-klary-orange/5 shadow-md"
                : "border-klary-light-grey hover:border-klary-navy/40 bg-white"
            }`}
          >
            <div className="flex items-start justify-between gap-3">
              <div>
                <div className="text-[10px] uppercase tracking-widest text-klary-grey font-bold mb-1">
                  Option {i + 1}
                </div>
                <div className="font-semibold text-klary-navy leading-snug">
                  {formatSlot(slot.start)}
                </div>
                <div className="text-xs text-klary-grey mt-1">
                  Durée : {slot.duration_min} min · Présentiel au bureau
                </div>
              </div>
              <div
                className={`w-6 h-6 rounded-full border-2 flex items-center justify-center shrink-0 ${
                  selected === i
                    ? "border-klary-orange bg-klary-orange"
                    : "border-klary-light-grey"
                }`}
              >
                {selected === i && (
                  <span className="text-white text-xs">✓</span>
                )}
              </div>
            </div>
          </button>
        ))}
      </div>

      {error && (
        <div className="mb-4 p-3 bg-red-50 border-l-4 border-red-400 rounded text-sm text-red-800">
          {error}
        </div>
      )}

      <button
        type="button"
        disabled={selected === null || submitting}
        onClick={confirm}
        className={`w-full py-3 rounded-xl font-bold text-white transition ${
          selected === null || submitting
            ? "bg-klary-grey/40 cursor-not-allowed"
            : "bg-klary-orange hover:bg-klary-orange/90"
        }`}
      >
        {submitting ? "Enregistrement…" : "Confirmer ce créneau"}
      </button>
    </div>
  );
}
