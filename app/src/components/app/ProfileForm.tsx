"use client";

import { useState } from "react";
import { useRouter } from "next/navigation";

interface ProfileFormProps {
  initial: {
    first_name: string | null;
    last_name: string | null;
    date_of_birth: string | null;
    phone: string | null;
    postal_street: string | null;
    postal_zip: string | null;
    postal_city: string | null;
    postal_country: string | null;
  };
  isFirstTime: boolean;
}

export function ProfileForm({ initial, isFirstTime }: ProfileFormProps) {
  const [status, setStatus] = useState<"idle" | "loading" | "success" | "error">(
    "idle"
  );
  const [errorMsg, setErrorMsg] = useState<string | null>(null);
  const router = useRouter();

  const handleSubmit = async (e: React.FormEvent<HTMLFormElement>) => {
    e.preventDefault();
    setStatus("loading");
    setErrorMsg(null);

    const formData = new FormData(e.currentTarget);
    const payload = Object.fromEntries(formData.entries());

    try {
      const res = await fetch("/api/profile/update", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(payload),
      });
      const data = await res.json();
      if (!res.ok) throw new Error(data?.error || "Erreur inconnue");

      setStatus("success");

      // Si c'était la 1re fois → redirect vers formation
      if (isFirstTime) {
        setTimeout(() => router.push("/formation"), 800);
      } else {
        router.refresh();
      }
    } catch (err) {
      setStatus("error");
      setErrorMsg(err instanceof Error ? err.message : "Erreur inconnue");
    }
  };

  return (
    <form onSubmit={handleSubmit} className="space-y-6">
      <div>
        <h3 className="text-sm font-bold text-klary-navy mb-3 uppercase tracking-wider">
          Identité
        </h3>
        <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
          <Field
            name="first_name"
            label="Prénom *"
            defaultValue={initial.first_name || ""}
            required
          />
          <Field
            name="last_name"
            label="Nom *"
            defaultValue={initial.last_name || ""}
            required
          />
        </div>
      </div>

      <div>
        <h3 className="text-sm font-bold text-klary-navy mb-3 uppercase tracking-wider">
          Coordonnées personnelles
        </h3>
        <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
          <Field
            name="date_of_birth"
            label="Date de naissance *"
            type="date"
            defaultValue={initial.date_of_birth || ""}
            required
          />
          <Field
            name="phone"
            label="Téléphone"
            type="tel"
            defaultValue={initial.phone || ""}
            placeholder="+41 79 000 00 00"
          />
        </div>
      </div>

      <div>
        <h3 className="text-sm font-bold text-klary-navy mb-3 uppercase tracking-wider">
          Adresse postale
        </h3>
        <div className="space-y-4">
          <Field
            name="postal_street"
            label="Rue et numéro *"
            defaultValue={initial.postal_street || ""}
            required
          />
          <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
            <Field
              name="postal_zip"
              label="Code postal *"
              defaultValue={initial.postal_zip || ""}
              required
            />
            <div className="md:col-span-2">
              <Field
                name="postal_city"
                label="Ville *"
                defaultValue={initial.postal_city || ""}
                required
              />
            </div>
          </div>
          <Field
            name="postal_country"
            label="Pays"
            defaultValue={initial.postal_country || "Suisse"}
          />
        </div>
      </div>

      {errorMsg && (
        <div className="p-3 rounded-lg bg-red-50 text-red-700 text-sm border border-red-200">
          {errorMsg}
        </div>
      )}

      {status === "success" && (
        <div className="p-3 rounded-lg bg-green-50 text-green-800 text-sm border border-green-200 font-semibold">
          ✓ Profil enregistré
          {isFirstTime && " — redirection vers la formation…"}
        </div>
      )}

      <button
        type="submit"
        disabled={status === "loading"}
        className="w-full py-3.5 bg-klary-orange text-white font-semibold rounded-xl hover:bg-klary-orange/90 transition disabled:opacity-50"
      >
        {status === "loading"
          ? "Enregistrement…"
          : isFirstTime
          ? "Valider mon profil et accéder à la formation"
          : "Enregistrer les modifications"}
      </button>
    </form>
  );
}

function Field({
  name,
  label,
  type = "text",
  defaultValue,
  required = false,
  placeholder,
}: {
  name: string;
  label: string;
  type?: string;
  defaultValue?: string;
  required?: boolean;
  placeholder?: string;
}) {
  return (
    <div>
      <label
        htmlFor={name}
        className="block text-sm font-semibold text-klary-ink mb-1.5"
      >
        {label}
      </label>
      <input
        id={name}
        name={name}
        type={type}
        defaultValue={defaultValue}
        required={required}
        placeholder={placeholder}
        className="w-full px-4 py-2.5 border border-klary-light-grey rounded-lg focus:outline-none focus:border-klary-orange focus:ring-2 focus:ring-klary-orange/20 transition"
      />
    </div>
  );
}
