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
 * Wrapper safe : ne fait rien si Resend n'est pas configuré.
 * (Utile en dev local sans clé API — évite de casser les endpoints.)
 */
export async function sendEmail(params: {
  to: string | string[];
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
