import { funnelInputClass } from "./FunnelField";
import { cn } from "@/lib/utils";

/**
 * Saisie d'un numéro suisse, formaté pendant la frappe en 079 123 45 67.
 * On accepte aussi le +41 : le conseiller rappellera depuis la Suisse, donc
 * les deux écritures doivent passer sans faire échouer la validation.
 */

/** Met en forme à la suisse, sans jamais empêcher la frappe. */
export function formatSwissPhone(raw: string): string {
  const plus = raw.trim().startsWith("+");
  let digits = raw.replace(/\D/g, "");

  if (plus && digits.startsWith("41")) {
    const rest = digits.slice(2, 11);
    const parts = [rest.slice(0, 2), rest.slice(2, 5), rest.slice(5, 7), rest.slice(7, 9)].filter(Boolean);
    return `+41 ${parts.join(" ")}`.trim();
  }

  digits = digits.slice(0, 10);
  const parts = [digits.slice(0, 3), digits.slice(3, 6), digits.slice(6, 8), digits.slice(8, 10)].filter(Boolean);
  return parts.join(" ");
}

/** Dix chiffres en national, onze avec l'indicatif. */
export function isValidSwissPhone(value: string): boolean {
  const digits = value.replace(/\D/g, "");
  if (digits.startsWith("41")) return digits.length === 11;
  if (digits.startsWith("0")) return digits.length === 10;
  return false;
}

const PhoneInputCH = ({
  value,
  onChange,
  onInput,
  className,
}: {
  value: string;
  onChange: (value: string) => void;
  onInput?: () => void;
  className?: string;
}) => (
  <input
    type="tel"
    inputMode="tel"
    autoComplete="tel"
    placeholder="079 123 45 67"
    aria-label="Numéro de téléphone"
    value={value}
    onChange={(e) => {
      onChange(formatSwissPhone(e.target.value));
      onInput?.();
    }}
    className={cn(funnelInputClass, className)}
  />
);

export default PhoneInputCH;
