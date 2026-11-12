import { useEffect, useState } from "react";
import { funnelInputClass } from "./FunnelField";
import { cn } from "@/lib/utils";

/**
 * Date de naissance en un seul champ, mis en forme pendant la frappe.
 *
 * La version à trois champs avec saut de focus automatique perdait des
 * caractères : quand on tape vite, les frappes partent encore vers le champ
 * précédent pendant que React déplace le focus. Un champ unique n'a pas ce
 * problème, accepte le collage, et laisse la correction au clavier se faire
 * naturellement.
 */

/** Garde les chiffres et pose les barres obliques entre les groupes. */
function formatBirthDate(raw: string): string {
  const digits = raw.replace(/\D/g, "").slice(0, 8);
  const day = digits.slice(0, 2);
  const month = digits.slice(2, 4);
  const year = digits.slice(4, 8);
  return [day, month, year].filter((part) => part.length > 0).join("/");
}

/** Renvoie la date seulement si elle est complète, plausible et réelle. */
function parseBirthDate(formatted: string): Date | null {
  const digits = formatted.replace(/\D/g, "");
  if (digits.length !== 8) return null;

  const day = Number(digits.slice(0, 2));
  const month = Number(digits.slice(2, 4));
  const year = Number(digits.slice(4, 8));
  const thisYear = new Date().getFullYear();

  if (month < 1 || month > 12) return null;
  if (day < 1 || day > 31) return null;
  if (year < thisYear - 110 || year > thisYear) return null;

  const parsed = new Date(year, month - 1, day);
  // Écarte les dates qui n'existent pas, par exemple le 31 février.
  if (parsed.getDate() !== day || parsed.getMonth() !== month - 1) return null;
  return parsed;
}

const BirthDateInput = ({
  value,
  onChange,
  className,
  autoFocus,
}: {
  value: Date | null;
  onChange: (date: Date | null) => void;
  className?: string;
  autoFocus?: boolean;
}) => {
  const [text, setText] = useState(() =>
    value
      ? [
          String(value.getDate()).padStart(2, "0"),
          String(value.getMonth() + 1).padStart(2, "0"),
          String(value.getFullYear()),
        ].join("/")
      : ""
  );

  useEffect(() => {
    onChange(parseBirthDate(text));
    // onChange vient de updateFormData, qui est mémoïsé côté appelant.
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [text]);

  return (
    <input
      type="text"
      inputMode="numeric"
      autoComplete="bday"
      placeholder="JJ/MM/AAAA"
      aria-label="Date de naissance, jour mois année"
      // Le champ prend le focus à l'ouverture de l'étape : une étape de saisie
      // qui demande un geste de plus pour commencer perd des répondants.
      autoFocus={autoFocus}
      value={text}
      onChange={(e) => setText(formatBirthDate(e.target.value))}
      className={cn(funnelInputClass, "max-w-[220px] text-center text-lg tracking-wider", className)}
    />
  );
};

export default BirthDateInput;
