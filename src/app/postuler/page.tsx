"use client";

import { useState } from "react";
import { Header } from "@/components/marketing/Header";
import { Footer } from "@/components/marketing/Footer";

const POSITIONS = [
  { value: "agent_maladie", label: "Agent — Assurance maladie" },
  { value: "agent_prevoyance", label: "Agent — Prévoyance / 3e pilier" },
  { value: "agent_lpp", label: "Agent — LPP libre passage" },
  { value: "agent_hypotheque", label: "Agent — Hypothèque" },
  { value: "responsable_agence", label: "Responsable d'agence" },
  { value: "assistante", label: "Assistante administrative" },
  { value: "autre", label: "Autre poste / candidature spontanée" },
];

export default function PostulerPage() {
  const [status, setStatus] = useState<"idle" | "loading" | "success" | "error">(
    "idle"
  );
  const [errorMsg, setErrorMsg] = useState<string | null>(null);

  const handleSubmit = async (e: React.FormEvent<HTMLFormElement>) => {
    e.preventDefault();
    setStatus("loading");
    setErrorMsg(null);

    const formData = new FormData(e.currentTarget);

    try {
      const res = await fetch("/api/candidature", {
        method: "POST",
        body: formData,
      });
      const data = await res.json();

      if (!res.ok) throw new Error(data?.error || "Une erreur est survenue.");
      setStatus("success");
      (e.target as HTMLFormElement).reset();
    } catch (err) {
      setStatus("error");
      setErrorMsg(err instanceof Error ? err.message : "Erreur inconnue");
    }
  };

  return (
    <>
      <Header />
      <main className="max-w-2xl mx-auto px-6 py-16 md:py-24">
        <div className="mb-10">
          <div className="text-xs font-bold tracking-widest uppercase text-klary-orange mb-3">
            Rejoindre Klary
          </div>
          <h1 className="text-4xl md:text-5xl font-bold text-klary-navy tracking-tight mb-4">
            Envie de nous rejoindre ?
          </h1>
          <p className="text-lg text-klary-grey">
            Klary recrute ses premiers agents pour son lancement en septembre
            2026. Envoyez-nous votre candidature — nous revenons vers vous sous
            72h.
          </p>
        </div>

        {status === "success" ? (
          <div className="p-8 rounded-2xl bg-green-50 border border-green-200">
            <div className="text-4xl mb-3">✓</div>
            <h2 className="text-2xl font-bold text-klary-navy mb-2">
              Candidature reçue, merci !
            </h2>
            <p className="text-klary-grey">
              Sacha Bacconnier (responsable d'agence) revient vers vous sous
              72h ouvrées.
            </p>
          </div>
        ) : (
          <form
            onSubmit={handleSubmit}
            encType="multipart/form-data"
            className="space-y-5 p-6 md:p-8 bg-white rounded-2xl border border-klary-light-grey"
          >
            <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
              <div>
                <label className="block text-sm font-semibold text-klary-ink mb-1.5">
                  Prénom *
                </label>
                <input
                  required
                  type="text"
                  name="first_name"
                  className="w-full px-4 py-2.5 border border-klary-light-grey rounded-lg focus:outline-none focus:border-klary-orange focus:ring-2 focus:ring-klary-orange/20 transition"
                />
              </div>
              <div>
                <label className="block text-sm font-semibold text-klary-ink mb-1.5">
                  Nom *
                </label>
                <input
                  required
                  type="text"
                  name="last_name"
                  className="w-full px-4 py-2.5 border border-klary-light-grey rounded-lg focus:outline-none focus:border-klary-orange focus:ring-2 focus:ring-klary-orange/20 transition"
                />
              </div>
            </div>

            <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
              <div>
                <label className="block text-sm font-semibold text-klary-ink mb-1.5">
                  Email *
                </label>
                <input
                  required
                  type="email"
                  name="email"
                  className="w-full px-4 py-2.5 border border-klary-light-grey rounded-lg focus:outline-none focus:border-klary-orange focus:ring-2 focus:ring-klary-orange/20 transition"
                />
              </div>
              <div>
                <label className="block text-sm font-semibold text-klary-ink mb-1.5">
                  Téléphone
                </label>
                <input
                  type="tel"
                  name="phone"
                  className="w-full px-4 py-2.5 border border-klary-light-grey rounded-lg focus:outline-none focus:border-klary-orange focus:ring-2 focus:ring-klary-orange/20 transition"
                />
              </div>
            </div>

            <div>
              <label className="block text-sm font-semibold text-klary-ink mb-1.5">
                Poste visé *
              </label>
              <select
                required
                name="position_applied"
                defaultValue=""
                className="w-full px-4 py-2.5 border border-klary-light-grey rounded-lg focus:outline-none focus:border-klary-orange focus:ring-2 focus:ring-klary-orange/20 transition bg-white"
              >
                <option value="" disabled>
                  Choisissez un poste…
                </option>
                {POSITIONS.map((p) => (
                  <option key={p.value} value={p.value}>
                    {p.label}
                  </option>
                ))}
              </select>
            </div>

            <div>
              <label className="block text-sm font-semibold text-klary-ink mb-1.5">
                Votre CV (PDF, max 5 Mo) *
              </label>
              <input
                required
                type="file"
                name="cv"
                accept=".pdf,application/pdf"
                className="w-full px-4 py-2 border border-klary-light-grey rounded-lg file:mr-4 file:py-2 file:px-4 file:rounded-md file:border-0 file:bg-klary-orange file:text-white file:font-semibold hover:file:bg-klary-orange/90 file:cursor-pointer transition"
              />
            </div>

            <div>
              <label className="block text-sm font-semibold text-klary-ink mb-1.5">
                Lettre de motivation
              </label>
              <textarea
                name="cover_letter"
                rows={5}
                placeholder="Optionnel — quelques mots sur votre motivation, votre expérience…"
                className="w-full px-4 py-2.5 border border-klary-light-grey rounded-lg focus:outline-none focus:border-klary-orange focus:ring-2 focus:ring-klary-orange/20 transition"
              />
            </div>

            <label className="flex gap-3 items-start cursor-pointer">
              <input
                required
                type="checkbox"
                name="consent"
                className="mt-1 accent-klary-orange"
              />
              <span className="text-sm text-klary-grey leading-relaxed">
                J'accepte que Klary Sàrl traite mes données personnelles et
                conserve mon CV pour évaluer ma candidature. Mes données sont
                conservées 12 mois maximum, puis supprimées automatiquement.
                Voir la{" "}
                <a
                  href="/politique-confidentialite"
                  className="text-klary-orange hover:underline"
                >
                  politique de confidentialité
                </a>
                .
              </span>
            </label>

            {errorMsg && (
              <div className="p-3 rounded-lg bg-red-50 text-red-700 text-sm border border-red-200">
                {errorMsg}
              </div>
            )}

            <button
              type="submit"
              disabled={status === "loading"}
              className="w-full py-3.5 bg-klary-orange text-white font-semibold rounded-xl hover:bg-klary-orange/90 transition-colors disabled:opacity-50"
            >
              {status === "loading" ? "Envoi…" : "Envoyer ma candidature"}
            </button>
          </form>
        )}
      </main>
      <Footer />
    </>
  );
}
