"use client";

import { useState } from "react";
import { useRouter } from "next/navigation";

export function GoogleCalendarCard({
  connected,
  authorizedEmail,
  connectedAt,
}: {
  connected: boolean;
  authorizedEmail: string | null;
  connectedAt: string | null;
}) {
  const router = useRouter();
  const [busy, setBusy] = useState(false);

  const disconnect = async () => {
    if (!confirm("Déconnecter Google Calendar ? Les entretiens à venir ne seront plus ajoutés automatiquement à l'agenda.")) return;
    setBusy(true);
    try {
      const res = await fetch("/api/google/disconnect", { method: "POST" });
      if (!res.ok) {
        const data = await res.json().catch(() => ({}));
        alert("Erreur : " + (data?.error || res.status));
        setBusy(false);
        return;
      }
      router.refresh();
    } catch (err: any) {
      alert("Erreur réseau : " + err?.message);
      setBusy(false);
    }
  };

  return (
    <div className="bg-white rounded-2xl border border-klary-light-grey p-6">
      <div className="flex items-start gap-4">
        <div className="w-12 h-12 rounded-xl bg-blue-50 flex items-center justify-center text-2xl shrink-0">
          📅
        </div>
        <div className="flex-1 min-w-0">
          <h2 className="font-bold text-klary-navy text-lg">
            Google Calendar
          </h2>
          <p className="text-sm text-klary-grey mt-1">
            Ajoute automatiquement les entretiens confirmés à l'agenda Google
            de l'admin. Le candidat reçoit aussi l'invitation par email.
          </p>

          {connected ? (
            <div className="mt-4 space-y-3">
              <div className="p-3 rounded-lg bg-green-50 border border-green-200 text-sm">
                <div className="flex items-center gap-2 text-green-800 font-semibold">
                  <span className="w-2 h-2 rounded-full bg-green-500"></span>
                  Connecté
                </div>
                {authorizedEmail && (
                  <div className="text-xs text-green-900 mt-1">
                    Compte : <strong>{authorizedEmail}</strong>
                  </div>
                )}
                {connectedAt && (
                  <div className="text-xs text-green-900/80 mt-0.5">
                    Depuis le{" "}
                    {new Date(connectedAt).toLocaleDateString("fr-CH", {
                      day: "numeric",
                      month: "long",
                      year: "numeric",
                    })}
                  </div>
                )}
              </div>
              <button
                onClick={disconnect}
                disabled={busy}
                className="px-4 py-2 text-sm font-semibold text-red-700 border border-red-300 rounded-lg hover:bg-red-50 disabled:opacity-50"
              >
                {busy ? "…" : "Déconnecter"}
              </button>
            </div>
          ) : (
            <div className="mt-4">
              <div className="p-3 rounded-lg bg-gray-50 border border-gray-200 text-sm text-gray-600 mb-3">
                <div className="flex items-center gap-2 font-semibold">
                  <span className="w-2 h-2 rounded-full bg-gray-400"></span>
                  Non connecté
                </div>
              </div>
              <a
                href="/api/google/connect"
                className="inline-flex items-center gap-2 px-4 py-2.5 bg-klary-navy text-white font-semibold rounded-lg hover:bg-klary-navy/90 text-sm"
              >
                <svg
                  className="w-4 h-4"
                  viewBox="0 0 24 24"
                  fill="currentColor"
                >
                  <path d="M22.56 12.25c0-.78-.07-1.53-.2-2.25H12v4.26h5.92c-.26 1.37-1.04 2.53-2.21 3.31v2.77h3.57c2.08-1.92 3.28-4.74 3.28-8.09z" fill="#4285F4"/>
                  <path d="M12 23c2.97 0 5.46-.98 7.28-2.66l-3.57-2.77c-.98.66-2.23 1.06-3.71 1.06-2.86 0-5.29-1.93-6.16-4.53H2.18v2.84C3.99 20.53 7.7 23 12 23z" fill="#34A853"/>
                  <path d="M5.84 14.09c-.22-.66-.35-1.36-.35-2.09s.13-1.43.35-2.09V7.07H2.18C1.43 8.55 1 10.22 1 12s.43 3.45 1.18 4.93l2.85-2.22.81-.62z" fill="#FBBC05"/>
                  <path d="M12 5.38c1.62 0 3.06.56 4.21 1.64l3.15-3.15C17.45 2.09 14.97 1 12 1 7.7 1 3.99 3.47 2.18 7.07l3.66 2.84c.87-2.6 3.3-4.53 6.16-4.53z" fill="#EA4335"/>
                </svg>
                Connecter Google Calendar
              </a>
              <p className="text-xs text-klary-grey mt-2">
                ⚠ Vérifie que <code>GOOGLE_CLIENT_ID</code>,{" "}
                <code>GOOGLE_CLIENT_SECRET</code> et{" "}
                <code>GOOGLE_REDIRECT_URI</code> sont configurés (voir setup
                ci-dessous).
              </p>
            </div>
          )}
        </div>
      </div>
    </div>
  );
}
