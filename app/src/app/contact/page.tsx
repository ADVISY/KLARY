"use client";

import { useState } from "react";
import { Header } from "@/components/marketing/Header";
import { Footer } from "@/components/marketing/Footer";

const SUBJECTS = [
  { value: "demande_information", label: "Demande d'information" },
  { value: "demande_devis", label: "Demande de devis / comparatif" },
  { value: "assurance_maladie", label: "Assurance maladie (LAMal / LCA)" },
  { value: "prevoyance", label: "Prévoyance / 3e pilier" },
  { value: "lpp_libre_passage", label: "LPP libre passage" },
  { value: "hypotheque", label: "Hypothèque" },
  { value: "autre", label: "Autre" },
];

export default function ContactPage() {
  const [status, setStatus] = useState<"idle" | "loading" | "success" | "error">(
    "idle"
  );
  const [errorMsg, setErrorMsg] = useState<string | null>(null);

  const handleSubmit = async (e: React.FormEvent<HTMLFormElement>) => {
    e.preventDefault();
    setStatus("loading");
    setErrorMsg(null);

    const formData = new FormData(e.currentTarget);
    const payload = Object.fromEntries(formData.entries());

    try {
      const res = await fetch("/api/contact", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(payload),
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
            Contact
          </div>
          <h1 className="text-4xl md:text-5xl font-bold text-klary-navy tracking-tight mb-4">
            Parlons ensemble.
          </h1>
          <p className="text-lg text-klary-grey">
            Réservez 15 minutes avec un de nos conseillers — c'est gratuit et
            sans engagement. On revient vers vous sous 24h.
          </p>
        </div>

        {status === "success" ? (
          <div className="p-8 rounded-2xl bg-green-50 border border-green-200">
            <div className="text-4xl mb-3">✓</div>
            <h2 className="text-2xl font-bold text-klary-navy mb-2">
              Message reçu, merci !
            </h2>
            <p className="text-klary-grey">
              Un conseiller Klary vous rappelle sous 24h ouvrées. Si urgent :{" "}
              <a
                href="mailto:admin@klary.ch"
                className="text-klary-orange font-semibold hover:underline"
              >
                admin@klary.ch
              </a>
            </p>
          </div>
        ) : (
          <form
            onSubmit={handleSubmit}
            className="space-y-5 p-6 md:p-8 bg-white rounded-2xl border border-klary-light-grey"
          >
            <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
              <div>
                <label
                  htmlFor="first_name"
                  className="block text-sm font-semibold text-klary-ink mb-1.5"
                >
                  Prénom *
                </label>
                <input
                  required
                  type="text"
                  id="first_name"
                  name="first_name"
                  className="w-full px-4 py-2.5 border border-klary-light-grey rounded-lg focus:outline-none focus:border-klary-orange focus:ring-2 focus:ring-klary-orange/20 transition"
                />
              </div>
              <div>
                <label
                  htmlFor="last_name"
                  className="block text-sm font-semibold text-klary-ink mb-1.5"
                >
                  Nom *
                </label>
                <input
                  required
                  type="text"
                  id="last_name"
                  name="last_name"
                  className="w-full px-4 py-2.5 border border-klary-light-grey rounded-lg focus:outline-none focus:border-klary-orange focus:ring-2 focus:ring-klary-orange/20 transition"
                />
              </div>
            </div>

            <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
              <div>
                <label
                  htmlFor="email"
                  className="block text-sm font-semibold text-klary-ink mb-1.5"
                >
                  Email *
                </label>
                <input
                  required
                  type="email"
                  id="email"
                  name="email"
                  className="w-full px-4 py-2.5 border border-klary-light-grey rounded-lg focus:outline-none focus:border-klary-orange focus:ring-2 focus:ring-klary-orange/20 transition"
                />
              </div>
              <div>
                <label
                  htmlFor="phone"
                  className="block text-sm font-semibold text-klary-ink mb-1.5"
                >
                  Téléphone
                </label>
                <input
                  type="tel"
                  id="phone"
                  name="phone"
                  placeholder="+41 79 000 00 00"
                  className="w-full px-4 py-2.5 border border-klary-light-grey rounded-lg focus:outline-none focus:border-klary-orange focus:ring-2 focus:ring-klary-orange/20 transition"
                />
              </div>
            </div>

            <div>
              <label
                htmlFor="subject"
                className="block text-sm font-semibold text-klary-ink mb-1.5"
              >
                Sujet *
              </label>
              <select
                required
                id="subject"
                name="subject"
                defaultValue=""
                className="w-full px-4 py-2.5 border border-klary-light-grey rounded-lg focus:outline-none focus:border-klary-orange focus:ring-2 focus:ring-klary-orange/20 transition bg-white"
              >
                <option value="" disabled>
                  Choisissez un sujet…
                </option>
                {SUBJECTS.map((s) => (
                  <option key={s.value} value={s.value}>
                    {s.label}
                  </option>
                ))}
              </select>
            </div>

            <div>
              <label
                htmlFor="message"
                className="block text-sm font-semibold text-klary-ink mb-1.5"
              >
                Votre message *
              </label>
              <textarea
                required
                id="message"
                name="message"
                rows={5}
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
                J'accepte que Klary Sàrl traite mes données personnelles pour
                répondre à ma demande, conformément à sa{" "}
                <a
                  href="/politique-confidentialite"
                  className="text-klary-orange hover:underline"
                >
                  politique de confidentialité
                </a>
                . Mes données sont conservées 24 mois maximum.
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
              {status === "loading" ? "Envoi…" : "Envoyer le message"}
            </button>
          </form>
        )}

        <div className="mt-10 text-center text-sm text-klary-grey">
          Vous préférez l'email ?{" "}
          <a
            href="mailto:admin@klary.ch"
            className="text-klary-orange font-semibold hover:underline"
          >
            admin@klary.ch
          </a>
        </div>
      </main>
      <Footer />
    </>
  );
}
