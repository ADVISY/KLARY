export type ReportField = {
  key: string;
  label: string;
  max: number;
  /** Note avec décimale (ex. 8,4 sur 10) au lieu d'un nombre entier */
  decimal?: boolean;
  /** Peut rester vide : le responsable ne vend pas forcément */
  optional?: boolean;
};

// Le conseiller et le responsable suivent le même parcours commercial.
// Le responsable n'a pas toujours de portefeuille, ses compteurs sont facultatifs.
const SALES_FIELDS: ReportField[] = [
  { key: "calls", label: "Appels passés", max: 1000 },
  { key: "appointments_set", label: "Rendez-vous fixés", max: 500 },
  { key: "appointments_held", label: "Rendez-vous honorés", max: 500 },
  { key: "contracts", label: "Signatures", max: 200 },
  // Compteur à part, pas un sous-ensemble des signatures : on saisit les deux.
  { key: "lca", label: "Contrats LCA (complémentaires)", max: 200 },
];

export const REPORT_FIELDS: Record<string, ReportField[]> = {
  agent: SALES_FIELDS,
  manager: SALES_FIELDS.map((f) => ({ ...f, optional: true })),
  backoffice: [
    { key: "files", label: "Dossiers traités", max: 500 },
    { key: "emails", label: "Emails traités", max: 1000 },
    { key: "cancellations", label: "Résiliations envoyées", max: 500 },
    { key: "quality_calls", label: "Appels qualité", max: 500 },
    {
      key: "quality_score",
      label: "Note qualité moyenne (sur 10)",
      max: 10,
      decimal: true,
      optional: true,
    },
    { key: "to_recall", label: "Clients à rappeler", max: 500 },
  ],
  admin: [],
};

/** Colonnes du CSV : chaque compteur une seule fois, dans l'ordre d'apparition */
export const ALL_FIELDS: ReportField[] = Object.values(REPORT_FIELDS)
  .flat()
  .filter(
    (field, index, all) => all.findIndex((f) => f.key === field.key) === index
  );

/** Rôles qui alimentent le total commercial de la journée */
export const SALES_ROLES = ["agent", "manager"];

export const ROLE_LABELS: Record<string, string> = {
  admin: "Direction",
  manager: "Responsable",
  agent: "Conseiller",
  backoffice: "Back-office",
};

const ROLE_PRIORITY: Record<string, number> = {
  admin: 4,
  manager: 3,
  backoffice: 2,
  agent: 1,
};

/** Rôle le plus élevé parmi les lignes actives d'un utilisateur */
export function highestRole(rows: { role: string }[] | null): string {
  return (
    [...(rows ?? [])].sort(
      (a, b) => (ROLE_PRIORITY[b.role] ?? 0) - (ROLE_PRIORITY[a.role] ?? 0)
    )[0]?.role ?? "agent"
  );
}

/** Date du jour en Suisse, au format AAAA-MM-JJ */
export function todayZurich(): string {
  return new Intl.DateTimeFormat("en-CA", {
    timeZone: "Europe/Zurich",
    year: "numeric",
    month: "2-digit",
    day: "2-digit",
  }).format(new Date());
}

export function formatReportDate(date: string): string {
  return new Intl.DateTimeFormat("fr-CH", {
    weekday: "long",
    day: "numeric",
    month: "long",
    year: "numeric",
    timeZone: "UTC",
  }).format(new Date(`${date}T00:00:00Z`));
}

export function formatMetric(value: unknown): string {
  return typeof value === "number" ? value.toLocaleString("fr-CH") : "–";
}

/** Contrats signés rapportés aux rendez-vous réellement honorés */
export function conversionRate(
  metrics: Record<string, number>
): number | null {
  const held = metrics.appointments_held;
  const contracts = metrics.contracts;
  if (typeof held !== "number" || held <= 0) return null;
  if (typeof contracts !== "number") return null;
  return Math.round((contracts / held) * 100);
}
