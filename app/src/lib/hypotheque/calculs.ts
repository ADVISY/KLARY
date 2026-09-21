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
 * Combien de prévoyance nécessaire pour couvrir le 10 % « mou » de l'apport.
 * Sur un bien de X CHF, l'apport total est 20 % dont 10 % dur (cash / 3a lié
 * en tant que hors LPP) et 10 % mou (peut être LPP retiré/nanti + 3a nanti).
 *
 * Prévoyance requise = 10 % du prix du bien
 */
export function prevoyanceRequisePourApport(prixBien: number): {
  apportMou: number;
  suggestions: { label: string; montant: number; explication: string }[];
} {
  const apportMou = prixBien * 0.1;
  return {
    apportMou,
    suggestions: [
      {
        label: "Tout 3a nanti",
        montant: apportMou,
        explication: "Nantissement du 3a auprès de la banque, le capital reste intact.",
      },
      {
        label: "50 % LPP + 50 % 3a",
        montant: apportMou,
        explication: "Retrait EPL du 2ᵉ pilier art. 30c LPP + nantissement 3a.",
      },
      {
        label: "Tout LPP retiré",
        montant: apportMou,
        explication: "Retrait anticipé LPP art. 30c, impact sur rente future à évaluer.",
      },
    ],
  };
}

/**
 * Temps nécessaire pour constituer un capital cible (formule inversée).
 * Sur combien d'années avec versement mensuel donné pour atteindre le
 * capital cible, à taux de rendement donné.
 *
 * Approximation numérique par itération (Newton pas nécessaire pour l'ordre
 * de grandeur souhaité).
 */
export function anneesNecessairesPourCapital(
  capitalCible: number,
  versementMensuel: number,
  rendementAnnuel = RENDEMENT_3A_DEFAUT
): number {
  if (versementMensuel <= 0 || capitalCible <= 0) return 0;
  // Sans rendement : temps = capital / (versement × 12)
  if (rendementAnnuel <= 0) {
    return Math.ceil(capitalCible / (versementMensuel * 12) * 10) / 10;
  }
  const r = rendementAnnuel / 12;
  // V × ((1+r)^n - 1)/r = capitalCible → n = log(1 + capitalCible × r / V) / log(1+r)
  const n = Math.log(1 + (capitalCible * r) / versementMensuel) / Math.log(1 + r);
  return Math.ceil((n / 12) * 10) / 10; // arrondi à 0.1 année
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
  /** Nom du client pour le PDF récapitulatif */
  clientNom?: string;
  clientPrenom?: string;
  /** Type de bien visé (appartement, maison, autre) */
  typeBien?: string;
  /** Localité du projet */
  localite?: string;
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
