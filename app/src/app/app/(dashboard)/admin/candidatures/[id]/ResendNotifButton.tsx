"use client";

import { useState } from "react";
import { useRouter } from "next/navigation";

interface Props {
  candidateId: string;
  variant?: "primary" | "secondary";
  target?: "admin" | "candidate" | "both";
  label?: string;
}

/**
 * Bouton "Renvoyer notification" — déclenche POST /api/admin/candidatures/[id]/resend-notif
 * Utile quand l'envoi automatique a échoué (ex: clé Resend expirée, rate limit).
 */
export function ResendNotifButton({
  candidateId,
  variant = "secondary",
  target = "both",
  label,
}: Props) {
  const router = useRouter();
  const [loading, setLoading] = useState(false);
  const [feedback, setFeedback] = useState<{
    type: "success" | "error";
    message: string;
  } | null>(null);

  const defaultLabel =
    target === "admin"
      ? "Renvoyer notification admin"
      : target === "candidate"
        ? "Renvoyer confirmation candidat"
        : "Renvoyer les notifications";

  const handleClick = async () => {
    if (loading) return;
    setLoading(true);
    setFeedback(null);
    try {
      const res = await fetch(
        `/api/admin/candidatures/${candidateId}/resend-notif`,
        {
          method: "POST",
          headers: { "Content-Type": "application/json" },
          body: JSON.stringify({ target }),
        }
      );
      const data = await res.json();
      if (!res.ok) {
        throw new Error(data?.error || "Erreur d'envoi");
      }
      const parts: string[] = [];
      if (data?.results?.admin) {
        parts.push(data.results.admin.ok ? "admin ✅" : "admin ❌");
      }
      if (data?.results?.candidate) {
        parts.push(data.results.candidate.ok ? "candidat ✅" : "candidat ❌");
      }
      setFeedback({
        type: "success",
        message: `Renvoyé : ${parts.join(" · ") || "OK"}`,
      });
      // Refresh la page pour voir les nouveaux email_events
      setTimeout(() => router.refresh(), 800);
    } catch (err: any) {
      setFeedback({
        type: "error",
        message: err?.message || "Erreur d'envoi",
      });
    } finally {
      setLoading(false);
    }
  };

  const baseCls =
    "inline-flex items-center gap-1.5 px-3 py-1.5 rounded-lg text-xs font-semibold transition disabled:opacity-60 disabled:cursor-wait";
  const variantCls =
    variant === "primary"
      ? "bg-klary-orange text-white hover:bg-klary-orange/90"
      : "bg-klary-navy/5 text-klary-navy hover:bg-klary-navy/10 border border-klary-light-grey";

  return (
    <div className="inline-flex flex-col items-start gap-1">
      <button
        type="button"
        onClick={handleClick}
        disabled={loading}
        className={`${baseCls} ${variantCls}`}
      >
        {loading ? "⏳ Envoi…" : `🔁 ${label || defaultLabel}`}
      </button>
      {feedback && (
        <span
          className={`text-[11px] font-medium ${
            feedback.type === "success" ? "text-emerald-700" : "text-red-700"
          }`}
        >
          {feedback.message}
        </span>
      )}
    </div>
  );
}
