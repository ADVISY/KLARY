"use client";

import { useState } from "react";
import { useRouter } from "next/navigation";
import { createSupabaseBrowserClient } from "@/lib/supabase/client";

export function LoginForm() {
  const [email, setEmail] = useState("");
  const [status, setStatus] = useState<"idle" | "loading" | "error">("idle");
  const [errorMsg, setErrorMsg] = useState<string | null>(null);
  const router = useRouter();

  const handleSubmit = async (e: React.FormEvent<HTMLFormElement>) => {
    e.preventDefault();

    // Validation email @klary.ch
    if (!email.trim().toLowerCase().endsWith("@klary.ch")) {
      setStatus("error");
      setErrorMsg("Seuls les emails @klary.ch sont autorisés.");
      return;
    }

    setStatus("loading");
    setErrorMsg(null);

    try {
      const supabase = createSupabaseBrowserClient();
      const origin =
        typeof window !== "undefined" ? window.location.origin : "";

      const { error } = await supabase.auth.signInWithOtp({
        email: email.trim().toLowerCase(),
        options: {
          emailRedirectTo: `${origin}/api/auth/callback`,
          shouldCreateUser: true,
        },
      });

      if (error) {
        setStatus("error");
        setErrorMsg(error.message);
        return;
      }

      // Redirection vers page "check email"
      router.push(`/auth/check-email?email=${encodeURIComponent(email)}`);
    } catch (err) {
      setStatus("error");
      setErrorMsg(err instanceof Error ? err.message : "Erreur inconnue");
    }
  };

  return (
    <form onSubmit={handleSubmit} className="space-y-5">
      <div>
        <label
          htmlFor="email"
          className="block text-sm font-semibold text-klary-ink mb-1.5"
        >
          Votre email professionnel Klary
        </label>
        <input
          required
          type="email"
          id="email"
          value={email}
          onChange={(e) => setEmail(e.target.value)}
          placeholder="prenom.nom@klary.ch"
          pattern=".+@klary\.ch$"
          className="w-full px-4 py-3 border border-klary-light-grey rounded-lg focus:outline-none focus:border-klary-orange focus:ring-2 focus:ring-klary-orange/20 transition"
          disabled={status === "loading"}
        />
        <p className="mt-1.5 text-xs text-klary-grey italic">
          Seuls les emails @klary.ch sont acceptés.
        </p>
      </div>

      {errorMsg && (
        <div className="p-3 rounded-lg bg-red-50 text-red-700 text-sm border border-red-200">
          {errorMsg}
        </div>
      )}

      <button
        type="submit"
        disabled={status === "loading"}
        className="w-full py-3.5 bg-klary-orange text-white font-semibold rounded-xl hover:bg-klary-orange/90 transition-colors disabled:opacity-50 disabled:cursor-not-allowed"
      >
        {status === "loading" ? "Envoi du lien…" : "Recevoir mon lien de connexion"}
      </button>

      <p className="text-xs text-klary-grey text-center leading-relaxed">
        Vous recevrez un email avec un lien à cliquer.
        <br />
        Pas de mot de passe à retenir.
      </p>
    </form>
  );
}
