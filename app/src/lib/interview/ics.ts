/**
 * Générateur ICS (iCalendar RFC 5545) pour invitation entretien candidat.
 *
 * Sortie : contenu texte compatible avec Google Calendar, Outlook,
 * Apple Calendar. Le candidat reçoit un .ics en pièce jointe email,
 * clique dessus → import automatique dans son agenda + rappel 24h avant.
 *
 * L'événement contient l'adresse physique du bureau — le candidat peut
 * taper dessus dans son agenda pour ouvrir Google Maps direct.
 */

export const KLARY_OFFICE = {
  name: "Klary Sàrl — Bureau",
  building: "Bâtiment Regus",
  street: "Route de Crassier 7",
  city: "1262 Eysins",
  country: "Suisse",
  accessInstruction:
    "Présentez-vous à l'accueil Regus au rez-de-chaussée et demandez Klary.",
  mapsUrl:
    "https://maps.google.com/?q=Route+de+Crassier+7,+1262+Eysins",
};

export const KLARY_OFFICE_FULL_ADDRESS = `${KLARY_OFFICE.building}, ${KLARY_OFFICE.street}, ${KLARY_OFFICE.city}, ${KLARY_OFFICE.country}`;

type IcsParams = {
  uid: string;                    // ID unique (ex: token candidat)
  startISO: string;               // ISO-8601 UTC du RDV
  durationMin: number;            // 30 typiquement
  candidateName: string;
  candidateEmail: string;
  organizerEmail?: string;        // email admin
  organizerName?: string;
};

/**
 * Convertit une date en format ICS : YYYYMMDDTHHMMSSZ (UTC).
 */
function toIcsDate(d: Date): string {
  return d
    .toISOString()
    .replace(/[-:]/g, "")
    .replace(/\.\d{3}/, "");
}

/**
 * Échappe les caractères spéciaux dans les valeurs ICS (RFC 5545 §3.3.11).
 */
function escapeIcs(s: string): string {
  return s
    .replace(/\\/g, "\\\\")
    .replace(/;/g, "\\;")
    .replace(/,/g, "\\,")
    .replace(/\n/g, "\\n");
}

/**
 * Génère le contenu ICS complet d'un entretien Klary au bureau.
 */
export function generateInterviewIcs(params: IcsParams): string {
  const start = new Date(params.startISO);
  const end = new Date(start.getTime() + params.durationMin * 60 * 1000);
  const now = new Date();

  const summary = "Entretien Klary — Rendez-vous au bureau";
  const description = [
    `Entretien Klary avec ${params.candidateName}`,
    "",
    "Adresse du bureau :",
    KLARY_OFFICE_FULL_ADDRESS,
    "",
    `⚠ ACCÈS : ${KLARY_OFFICE.accessInstruction}`,
    "",
    `Itinéraire Google Maps : ${KLARY_OFFICE.mapsUrl}`,
    "",
    "En cas d'empêchement, prévenez-nous à rh@klary.ch.",
  ].join("\n");

  const organizerLine = params.organizerEmail
    ? `ORGANIZER;CN=${escapeIcs(
        params.organizerName || "Klary"
      )}:mailto:${params.organizerEmail}`
    : `ORGANIZER;CN=Klary:mailto:rh@klary.ch`;

  const lines = [
    "BEGIN:VCALENDAR",
    "VERSION:2.0",
    "PRODID:-//Klary//Entretien//FR",
    "CALSCALE:GREGORIAN",
    "METHOD:REQUEST",
    "BEGIN:VEVENT",
    `UID:${params.uid}@klary.ch`,
    `DTSTAMP:${toIcsDate(now)}`,
    `DTSTART:${toIcsDate(start)}`,
    `DTEND:${toIcsDate(end)}`,
    `SUMMARY:${escapeIcs(summary)}`,
    `LOCATION:${escapeIcs(KLARY_OFFICE_FULL_ADDRESS)}`,
    `DESCRIPTION:${escapeIcs(description)}`,
    organizerLine,
    `ATTENDEE;CN=${escapeIcs(
      params.candidateName
    )};RSVP=TRUE:mailto:${params.candidateEmail}`,
    "STATUS:CONFIRMED",
    "SEQUENCE:0",
    // Rappel 24h avant
    "BEGIN:VALARM",
    "ACTION:DISPLAY",
    "TRIGGER:-P1D",
    "DESCRIPTION:Rappel : entretien Klary demain",
    "END:VALARM",
    // Rappel 1h avant
    "BEGIN:VALARM",
    "ACTION:DISPLAY",
    "TRIGGER:-PT1H",
    "DESCRIPTION:Rappel : entretien Klary dans 1 heure",
    "END:VALARM",
    "END:VEVENT",
    "END:VCALENDAR",
  ];

  // ICS utilise CRLF comme séparateur de lignes (RFC 5545)
  return lines.join("\r\n");
}
