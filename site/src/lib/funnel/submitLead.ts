import { supabase } from "@/integrations/supabase/client";

/**
 * Envoi des demandes issues des pages d'offre vers la table `site_leads`.
 *
 * Deux pièges, tous deux rencontrés pour de vrai :
 *
 * 1. Le client Supabase du site se remplace par un proxy silencieux quand les
 *    variables d'environnement manquent, et toute écriture renvoie alors
 *    `{ data: null, error: null }`, c'est-à-dire un faux succès. Un faux
 *    succès sur un formulaire de prospection perd un prospect sans que
 *    personne ne s'en aperçoive : on vérifie donc explicitement la présence
 *    de la configuration avant d'écrire.
 *
 * 2. On ne demande SURTOUT pas la ligne en retour. Le public a le droit
 *    d'insérer dans `site_leads`, jamais de la lire, et réclamer la ligne
 *    insérée oblige PostgREST à la relire : la demande entière est alors
 *    refusée, avec un message trompeur de violation de policy. Un `insert`
 *    sans retour suffit, et `error` dit la vérité.
 */

const SUPABASE_CONFIGURED =
  !!import.meta.env.VITE_SUPABASE_URL && !!import.meta.env.VITE_SUPABASE_PUBLISHABLE_KEY;

/** Adresse de repli communiquée au prospect si l'enregistrement échoue. */
export const FALLBACK_EMAIL = "admin@klary.ch";

export type LeadSource = "maladie" | "subside";

export interface LeadInput {
  source: LeadSource;
  /** Code de campagne, pour retrouver l'origine dans les rapports. */
  campaign: string;
  firstName: string;
  lastName: string;
  email: string;
  phone: string;
  canton?: string;
  postalCode?: string;
  birthDate?: Date | null;
  /** Le prospect a accepté d'être conseillé par un intermédiaire lié. */
  consentTied: boolean;
  /** Toutes les réponses du tunnel, telles que saisies. */
  answers: Record<string, unknown>;
}

export type LeadResult =
  | { ok: true; id: string | null }
  | { ok: false; reason: "config" | "network" | "database" };

function isoDate(date?: Date | null): string | null {
  if (!date) return null;
  const y = date.getFullYear();
  const m = String(date.getMonth() + 1).padStart(2, "0");
  const d = String(date.getDate()).padStart(2, "0");
  return `${y}-${m}-${d}`;
}

export async function submitLead(input: LeadInput): Promise<LeadResult> {
  if (!SUPABASE_CONFIGURED) {
    console.error("[lead] Supabase non configuré : la demande n'a pas été enregistrée.");
    return { ok: false, reason: "config" };
  }

  const row = {
    source: input.source,
    campaign: input.campaign,
    first_name: input.firstName.trim(),
    last_name: input.lastName.trim(),
    email: input.email.trim().toLowerCase(),
    phone: input.phone.trim(),
    canton: input.canton || null,
    postal_code: input.postalCode || null,
    birth_date: isoDate(input.birthDate),
    consent_tied: input.consentTied,
    answers: input.answers,
    page_url: typeof window !== "undefined" ? window.location.href : null,
  };

  try {
    // Le typage généré ne connaît pas encore `site_leads` : cast assumé ici,
    // à retirer après régénération des types Supabase.
    const { error } = await (supabase as never as SupabaseLike)
      .from("site_leads")
      .insert(row);

    if (error) {
      console.error("[lead] enregistrement refusé", error);
      return { ok: false, reason: "database" };
    }
    return { ok: true };
  } catch (err) {
    console.error("[lead] envoi impossible", err);
    return { ok: false, reason: "network" };
  }
}

/** Surface minimale utilisée, le temps que les types Supabase soient régénérés. */
interface SupabaseLike {
  from: (table: string) => {
    insert: (row: Record<string, unknown>) => Promise<{
      error: { message: string } | null;
    }>;
  };
}
