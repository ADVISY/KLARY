"use client";

import { useState } from "react";

type Props = {
  userId: string;
  agentName: string;
  /** Dossier existant, s'il y en a un. */
  existing: { submitted_at: string | null; form_token: string } | null;
};

/**
 * Ouvre le dossier RH d'un collaborateur déjà en poste, et donne le lien
 * direct à lui transmettre. Le collaborateur peut aussi le remplir depuis
 * son espace, onglet « Dossier RH » de Mon profil.
 */
export function OnboardingLauncher({ userId, agentName, existing }: Props) {
  const [state, setState] = useState<{
    loading: boolean;
    token: string | null;
    error: string | null;
  }>({ loading: false, token: existing?.form_token ?? null, error: null });
  const [copied, setCopied] = useState(false);

  const submitted = !!existing?.submitted_at;

  async function launch() {
    setState((s) => ({ ...s, loading: true, error: null }));
    try {
      const res = await fetch("/api/admin/onboarding/create-for-user", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ userId }),
      });
      const json = await res.json();
      if (!res.ok) throw new Error(json.error || "Échec de la création");
      setState({ loading: false, token: json.token, error: null });
    } catch (e: any) {
      setState((s) => ({ ...s, loading: false, error: e.message }));
    }
  }

  function copyLink() {
    if (!state.token) return;
    const url = `${window.location.origin}/app/onboarding/${state.token}`;
    navigator.clipboard.writeText(url).then(() => {
      setCopied(true);
      setTimeout(() => setCopied(false), 2500);
    });
  }

  if (submitted) {
    return (
      <div className="p-3 bg-green-50 border border-green-200 rounded-lg">
        <div className="text-xs font-semibold text-green-900 mb-1">
          Dossier RH complété
        </div>
        <span className="text-xs text-green-800">
          Transmis le{" "}
          {new Date(existing!.submitted_at as string).toLocaleDateString(
            "fr-CH"
          )}
        </span>
      </div>
    );
  }

  return (
    <div className="p-3 bg-klary-cream border border-klary-light-grey rounded-lg">
      <div className="text-xs font-semibold text-klary-navy mb-1">
        Dossier RH {state.token ? "en cours" : ""}
      </div>

      {!state.token && (
        <>
          <p className="text-xs text-klary-grey mb-2 max-w-xs">
            Ouvrir le dossier de {agentName} : AVS, banque, permis, LPP,
            allocations.
          </p>
          <button
            onClick={launch}
            disabled={state.loading}
            className="text-xs font-semibold px-3 py-1.5 bg-klary-orange text-white rounded hover:bg-klary-orange/90 disabled:opacity-50"
          >
            {state.loading ? "Ouverture…" : "Lancer l'onboarding"}
          </button>
        </>
      )}

      {state.token && (
        <>
          <p className="text-xs text-klary-grey mb-2 max-w-xs">
            Le collaborateur le voit dans son espace, onglet « Dossier RH ».
            Vous pouvez aussi lui envoyer le lien direct.
          </p>
          <button
            onClick={copyLink}
            className="text-xs font-semibold px-3 py-1.5 bg-white border border-klary-light-grey text-klary-navy rounded hover:border-klary-orange"
          >
            {copied ? "Lien copié ✓" : "Copier le lien"}
          </button>
        </>
      )}

      {state.error && (
        <p className="text-xs text-red-700 mt-2">{state.error}</p>
      )}
    </div>
  );
}
