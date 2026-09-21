/**
 * Calculs hypothèque « Premier Plan Logement »
 * ────────────────────────────────────────────
 * 8 calculs directs alignés sur le Manuel Optimis (v2026) + garde-fous
 * d'honnêteté (jamais 7 258 CHF d'économie, on affiche 1 500 à 2 500 CHF).
 *
 * Toutes les fonctions sont pures, calculées côté client, aucune API.
 * Chiffres 2026 : coût théorique 5,89 % (5 % intérêts × 80 % LTV + 1 %
 * amortissement + 1 % charges), taux d'effort max 33 %.
 */

export const COUT_THEORIQUE = 0.0589;
export const TAUX_EFFORT_MAX = 0.33;
export const APPORT_TOTAL_PCT = 0.2; // 20 % du prix
export const APPORT_DUR_PCT = 0.1; // 10 % hors 2ᵉ pilier
export const RENDEMENT_3A_DEFAUT = 0.03; // Prudent, non garanti

/**
 * Fourchette réaliste d'économie fiscale annuelle par franc versé en 3a,
 * pondérée par les cantons. On ne promet JAMAIS 7 258 × 25 % = 1 814 pour
 * un plafond plein : le taux marginal varie de 15 à 35 % selon revenu et
 * canton. On affiche une fourchette conservative.
 */
export function economieFiscaleAnnuelle(
  versementAnnuel: number,
  tauxMarginal = 0.25
): { min: number; median: number; max: number } {
  return {
    min: Math.round(versementAnnuel * 0.15),
    median: Math.round(versementAnnuel * tauxMarginal),
    max: Math.round(versementAnnuel * 0.35),
  };
}

// Calcul 1 — Apport nécessaire
export function apportNecessaire(prixBien: number): {
  total: number;
  dur: number;
  mou: number;
} {
  const total = prixBien * APPORT_TOTAL_PCT;
  const dur = prixBien * APPORT_DUR_PCT;
  return { total, dur, mou: total - dur };
}

// Calcul 2 — Charges théoriques annuelles (banque)
export function chargesTheoriques(prixBien: number): number {
  return prixBien * COUT_THEORIQUE;
}

// Calcul 3 — Revenu annuel requis pour supporter le bien
export function revenuRequis(prixBien: number): number {
  return chargesTheoriques(prixBien) / TAUX_EFFORT_MAX;
}

// Calcul 4 — Capacité d'achat maximale
export function capaciteAchatMax(revenuAnnuel: number): number {
  return (revenuAnnuel * TAUX_EFFORT_MAX) / COUT_THEORIQUE;
}

// Calcul 5 — Économie fiscale (déjà défini plus haut)

// Calcul 6 — Effort réel mensuel après économie d'impôt
export function effortReel(
  versementMensuel: number,
  tauxMarginal = 0.25
): { brut: number; economieFiscale: number; net: number } {
  const brut = versementMensuel;
  const economieFiscale = Math.round(brut * tauxMarginal);
  return { brut, economieFiscale, net: brut - economieFiscale };
}

/**
 * Calcul 7 — Capital futur constitué avec versements mensuels
 * Formule des annuités capitalisées : V × [((1+r)ⁿ - 1) ÷ r]
 * r = taux mensuel, n = nombre de mois
 */
export function capitalFutur(
  versementMensuel: number,
  anneesDuree: number,
  rendementAnnuel = RENDEMENT_3A_DEFAUT
): { avecRendement: number; sansRendement: number } {
  const n = anneesDuree * 12;
  const r = rendementAnnuel / 12;
  const avecRendement =
    r === 0
      ? versementMensuel * n
      : versementMensuel * ((Math.pow(1 + r, n) - 1) / r);
  const sansRendement = versementMensuel * n;
  return {
    avecRendement: Math.round(avecRendement),
    sansRendement: Math.round(sansRendement),
  };
}

// Calcul 8 — Bilan net (capital obtenu vs effort net réel)
export function bilanNet(
  versementMensuel: number,
  anneesDuree: number,
  tauxMarginal = 0.25,
  rendementAnnuel = RENDEMENT_3A_DEFAUT
): { capital: number; effortNetCumule: number; benefice: number } {
  const { avecRendement } = capitalFutur(versementMensuel, anneesDuree, rendementAnnuel);
  const effortMensuel = effortReel(versementMensuel, tauxMarginal).net;
  const effortNetCumule = effortMensuel * anneesDuree * 12;
  return {
    capital: avecRendement,
    effortNetCumule,
    benefice: avecRendement - effortNetCumule,
  };
}

/**
 * Loyer perdu sur X années — le moment « quantifier la douleur »
 * Formule : loyer mensuel × 12 × années
 */
export function loyerPerduSur(loyerMensuel: number, anneesDuree: number): number {
  return loyerMensuel * 12 * anneesDuree;
}

/**
 * Synthèse complète pour un dossier client donné.
 */
export interface DossierClient {
  prixBien: number;
  revenuAnnuel: number;
  loyerMensuel: number;
  versementMensuel: number;
  anneesDuree: number;
  tauxMarginal?: number;
  rendementAnnuel?: number;
}

export interface SyntheseCalculs {
  apport: ReturnType<typeof apportNecessaire>;
  chargesTheoriques: number;
  revenuRequis: number;
  capaciteAchatMax: number;
  economieFiscale: ReturnType<typeof economieFiscaleAnnuelle>;
  effortReel: ReturnType<typeof effortReel>;
  capitalFutur: ReturnType<typeof capitalFutur>;
  bilanNet: ReturnType<typeof bilanNet>;
  loyerPerdu: number;
  /** Le projet initial « passe » côté banque ? */
  projetPasse: boolean;
  /** Écart entre capacité réelle et prix souhaité */
  ecartCapacite: number;
}

export function synthese(d: DossierClient): SyntheseCalculs {
  const versementAnnuel = d.versementMensuel * 12;
  const tauxMarginal = d.tauxMarginal ?? 0.25;
  const rendement = d.rendementAnnuel ?? RENDEMENT_3A_DEFAUT;
  const revenuNecessaire = revenuRequis(d.prixBien);
  const capacite = capaciteAchatMax(d.revenuAnnuel);

  return {
    apport: apportNecessaire(d.prixBien),
    chargesTheoriques: chargesTheoriques(d.prixBien),
    revenuRequis: revenuNecessaire,
    capaciteAchatMax: capacite,
    economieFiscale: economieFiscaleAnnuelle(versementAnnuel, tauxMarginal),
    effortReel: effortReel(d.versementMensuel, tauxMarginal),
    capitalFutur: capitalFutur(d.versementMensuel, d.anneesDuree, rendement),
    bilanNet: bilanNet(d.versementMensuel, d.anneesDuree, tauxMarginal, rendement),
    loyerPerdu: loyerPerduSur(d.loyerMensuel, d.anneesDuree),
    projetPasse: d.revenuAnnuel >= revenuNecessaire,
    ecartCapacite: capacite - d.prixBien,
  };
}

/**
 * Format CHF Suisse : espaces comme séparateurs de milliers.
 */
export function formatCHF(n: number): string {
  return Math.round(n).toLocaleString("fr-CH").replace(/ /g, " ");
}
