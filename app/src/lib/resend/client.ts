import { Resend } from "resend";

/**
 * Client Resend partagé.
 * Utilisé côté serveur uniquement (Server Components, API routes, Edge Functions).
 */
const apiKey = process.env.RESEND_API_KEY;

export const resend = apiKey ? new Resend(apiKey) : null;

export const FROM_EMAIL =
  process.env.RESEND_FROM_EMAIL || "Klary <noreply@klary.ch>";

export const ADMIN_EMAIL =
  process.env.RESEND_ADMIN_EMAIL || "admin@klary.ch";

/**
 * Liste des emails des assistant(e)s Klary destinataires des tâches
 * d'onboarding technique (création email Infomaniak, Google Agenda,
 * Google Sheet, accès LYTA).
 * Configurable via `RESEND_ASSISTANTS_EMAILS` (séparés par des virgules).
 * Fallback : admin@klary.ch.
 */
export const ASSISTANTS_EMAILS: string[] = (
  process.env.RESEND_ASSISTANTS_EMAILS || ""
)
  .split(",")
  .map((s) => s.trim())
  .filter(Boolean);
if (ASSISTANTS_EMAILS.length === 0) {
  ASSISTANTS_EMAILS.push(ADMIN_EMAIL);
}

/**
 * Emails des comptables/finance Klary destinataires des dossiers
 * d'onboarding candidat → employé (identité + adresse + banque +
 * prévoyance + docs).
 * Configurable via `RESEND_COMPTABLE_EMAILS` (séparés par des virgules).
 * Défaut : finance@klary.ch.
 */
export const COMPTABLE_EMAILS: string[] = (
  process.env.RESEND_COMPTABLE_EMAILS || "finance@klary.ch"
)
  .split(",")
  .map((s) => s.trim())
  .filter(Boolean);

/**
 * Emails "office" (back-office / secrétariat) mis en CC sur les
 * notifications importantes (onboarding, ...).
 * Configurable via `RESEND_OFFICE_EMAILS` (séparés par des virgules).
 * Défaut : office@klary.ch.
 */
export const OFFICE_EMAILS: string[] = (
  process.env.RESEND_OFFICE_EMAILS || "office@klary.ch"
)
  .split(",")
  .map((s) => s.trim())
  .filter(Boolean);

/**
 * Wrapper safe : ne fait rien si Resend n'est pas configuré.
 * (Utile en dev local sans clé API — évite de casser les endpoints.)
 */
export async function sendEmail(params: {
  to: string | string[];
  cc?: string | string[];
  bcc?: string | string[];
  subject: string;
  html: string;
  text?: string;
  replyTo?: string;
  attachments?: { filename: string; content: string | Buffer }[];
}) {
  if (!resend) {
    console.warn("[Resend] RESEND_API_KEY manquant — email non envoyé");
    return { ok: false, skipped: true };
  }

  const result = await resend.emails.send({
    from: FROM_EMAIL,
    to: params.to,
    cc: params.cc,
    bcc: params.bcc,
    subject: params.subject,
    html: params.html,
    text: params.text,
    replyTo: params.replyTo,
    attachments: params.attachments as any,
  });

  if (result.error) {
    console.error("[Resend] Erreur envoi:", result.error);
    return { ok: false, error: result.error.message };
  }

  return { ok: true, id: result.data?.id };
}
