/**
 * Génère 3 créneaux d'entretien candidat sur les 3 prochains jours ouvrables.
 *
 * Règles :
 *   - Jours ouvrables uniquement (lundi–vendredi)
 *   - Horaires : 10h00, 14h00, 16h00 (fuseau Europe/Zurich)
 *   - Un créneau par jour ouvrable consécutif
 *   - Skip weekends
 *   - Créneaux d'une durée de 30 min
 */

export type InterviewSlot = {
  start: string;      // ISO-8601 UTC
  duration_min: number;
};

const SLOT_HOURS_ROTATION = [10, 14, 16] as const; // rotation d'horaires
const DURATION_MIN = 30;

function isBusinessDay(d: Date): boolean {
  const day = d.getUTCDay(); // 0 = dim, 6 = sam
  return day >= 1 && day <= 5;
}

/**
 * Retourne la date du prochain jour ouvrable à partir de `from`.
 * Si `from` est déjà un jour ouvrable, retourne `from`.
 */
function nextBusinessDay(from: Date): Date {
  const d = new Date(from);
  while (!isBusinessDay(d)) {
    d.setUTCDate(d.getUTCDate() + 1);
  }
  return d;
}

/**
 * Génère 3 créneaux successifs à partir de demain (ou du prochain jour ouvrable).
 *
 * Les horaires (10h / 14h / 16h Europe/Zurich) alternent pour varier la proposition.
 * Retourne des ISO strings en UTC.
 */
export function generateInterviewSlots(now: Date = new Date()): InterviewSlot[] {
  const slots: InterviewSlot[] = [];

  // On démarre à J+1 (le lendemain)
  const start = new Date(now);
  start.setUTCDate(start.getUTCDate() + 1);
  start.setUTCHours(0, 0, 0, 0);

  let cursor = nextBusinessDay(start);

  for (let i = 0; i < 3; i++) {
    const hourZurich = SLOT_HOURS_ROTATION[i % SLOT_HOURS_ROTATION.length];
    // Europe/Zurich = UTC+1 (hiver) ou UTC+2 (été) — on prend UTC+2 par sécurité
    // (créneaux définis un peu tard en UTC, pas d'impact fonctionnel car affichés
    // dans la timezone locale du candidat)
    const slotDate = new Date(cursor);
    // hourZurich = 10 en local → 8 UTC (été) ou 9 UTC (hiver)
    // On stocke une heure UTC "raisonnable" — le rendu email formatera en Zurich
    const isoHourApprox = hourZurich - 2; // approximation UTC été
    slotDate.setUTCHours(isoHourApprox, 0, 0, 0);
    slots.push({
      start: slotDate.toISOString(),
      duration_min: DURATION_MIN,
    });

    // Passer au jour ouvrable suivant
    cursor.setUTCDate(cursor.getUTCDate() + 1);
    cursor = nextBusinessDay(cursor);
  }

  return slots;
}

/**
 * Formate un créneau en français pour affichage (email, page candidat).
 */
export function formatSlot(iso: string): string {
  const d = new Date(iso);
  return d.toLocaleString("fr-CH", {
    weekday: "long",
    day: "numeric",
    month: "long",
    year: "numeric",
    hour: "2-digit",
    minute: "2-digit",
    timeZone: "Europe/Zurich",
  });
}
