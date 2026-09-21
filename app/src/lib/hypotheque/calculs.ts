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
 * Versement mensuel nécessaire pour atteindre un capital cible en N années.
 * Formule inversée des annuités capitalisées :
 *   V = C × r / ((1+r)^n - 1)   avec r = taux mensuel, n = nombre de mois
 *
 * Utilisé pour dimensionner le 3a en fonction d'un objectif immobilier.
 */
export function versementMensuelPourCapital(
  capitalCible: number,
  anneesDuree: number,
  rendementAnnuel = RENDEMENT_3A_DEFAUT
): number {
  if (anneesDuree <= 0 || capitalCible <= 0) return 0;
  const n = anneesDuree * 12;
  const r = rendementAnnuel / 12;
  if (r === 0) return Math.ceil(capitalCible / n);
  const v = (capitalCible * r) / (Math.pow(1 + r, n) - 1);
  return Math.ceil(v);
}

/**
 * Plan complet basé sur l'objectif immobilier du client.
 * Renvoie tout le nécessaire pour lui dire :
 *   - combien de prévoyance à constituer
 *   - combien mettre au 3a par mois pour l'atteindre
 *   - combien de cash épargner en parallèle pour le dur
 */
export interface ObjectifImmobilier {
  ageClient: number;
  /** Si présent → mode couple (2 conjoints, 2 comptes 3a possibles) */
  ageConjoint?: number;
  prixBienCible: number;
  horizonAchatAnnees: number;
  epargneCashActuelle?: number;
  lppExistante?: number;
  troisieme_a_existant?: number;
  rendementAnnuel?: number;
}

/**
 * Nombre de 3a plafond pleins disponibles selon la situation.
 * En couple, chaque conjoint a son propre plafond (7 258 CHF/an).
 */
export function plafondsDisponiblesAnnuel(o: ObjectifImmobilier): {
  nbComptes: number;
  plafondTotal: number;
  plafondMensuel: number;
} {
  const nbComptes = o.ageConjoint ? 2 : 1;
  const plafondUnitaire = 7258; // 3a salarié 2025-2026
  return {
    nbComptes,
    plafondTotal: nbComptes * plafondUnitaire,
    plafondMensuel: Math.floor((nbComptes * plafondUnitaire) / 12),
  };
}

/**
 * Profil de risque 3a recommandé selon l'âge et l'horizon d'achat.
 * Règle simple : plus on est jeune et plus l'horizon est long, plus on peut
 * viser un rendement élevé (fonds actions). En fin de carrière ou horizon
 * court, on protège le capital.
 */
export function profilRisque3aRecommande(
  ageClient: number,
  horizonAchatAnnees: number
): {
  profil: "actions" | "equilibre" | "prudent";
  rendementAttendu: number;
  vehicule: "3a bancaire fonds" | "3a bancaire compte" | "3a assurance";
  raison: string;
} {
  const anneesJusquaRetraite = Math.max(0, 65 - ageClient);
  const horizonLongTerme = Math.min(anneesJusquaRetraite, horizonAchatAnnees + 5);

  if (ageClient < 40 && horizonAchatAnnees >= 8) {
    return {
      profil: "actions",
      rendementAttendu: 0.04,
      vehicule: "3a bancaire fonds",
      raison: `À ${ageClient} ans avec un horizon de ${horizonAchatAnnees} ans, un fonds actions 3a est le plus performant. Le temps absorbe la volatilité.`,
    };
  }
  if (ageClient < 55 && horizonAchatAnnees >= 5) {
    return {
      profil: "equilibre",
      rendementAttendu: 0.03,
      vehicule: horizonAchatAnnees >= 10 ? "3a bancaire fonds" : "3a bancaire compte",
      raison: `À ${ageClient} ans, profil équilibré 50 % actions / 50 % obligations. Compromis entre performance et sécurité.`,
    };
  }
  return {
    profil: "prudent",
    rendementAttendu: 0.015,
    vehicule: "3a bancaire compte",
    raison: `À ${ageClient} ans ou horizon court (${horizonAchatAnnees} ans), on protège le capital. 3a bancaire simple ou fonds obligataires uniquement.`,
  };
}

/**
 * Estimation d'une LPP « médiane suisse » basée sur l'âge et un salaire type.
 * Fournit un ordre de grandeur si le client ne connaît pas son montant exact.
 * Utilise les bonifications de vieillesse art. 16 LPP :
 *   25-34 ans : 7 % · 35-44 : 10 % · 45-54 : 15 % · 55-65 : 18 %
 */
export function lppEstimeeSelonAge(
  ageClient: number,
  salaireAnnuel: number = 80000
): number {
  const salaireCoordonne = Math.max(0, Math.min(salaireAnnuel, 90720) - 25725);
  if (salaireCoordonne <= 0 || ageClient < 25) return 0;

  const tranches = [
    { from: 25, to: 34, taux: 0.07 },
    { from: 35, to: 44, taux: 0.1 },
    { from: 45, to: 54, taux: 0.15 },
    { from: 55, to: 65, taux: 0.18 },
  ];
  let capital = 0;
  for (const t of tranches) {
    const anneesDansLaTranche =
      Math.min(ageClient, t.to) - Math.max(25, t.from) + 1;
    if (anneesDansLaTranche > 0) {
      capital += salaireCoordonne * t.taux * anneesDansLaTranche;
    }
  }
  return Math.round(capital);
}

export interface PlanObjectif {
  apportTotal: number;
  apportDur: number;
  apportMou: number;
  cashADeposer: number;
  prevoyanceRequise: number;
  prevoyanceDejaEnPlace: number;
  prevoyanceAConstituer: number;
  versement3aMensuelRequis: number;
  cashMensuelRequis: number;
  totalEffortMensuel: number;
  faisable: boolean;
}

export function planPourObjectif(o: ObjectifImmobilier): PlanObjectif {
  const rendement = o.rendementAnnuel ?? RENDEMENT_3A_DEFAUT;
  const apportTotal = o.prixBienCible * 0.2;
  const apportDur = o.prixBienCible * 0.1;
  const apportMou = o.prixBienCible * 0.1;

  const cashActuel = o.epargneCashActuelle ?? 0;
  const troisA = o.troisieme_a_existant ?? 0;
  const lpp = o.lppExistante ?? 0;
  const prevoyanceDejaEnPlace = troisA + lpp;

  const cashADeposer = Math.max(0, apportDur - cashActuel - troisA);
  const prevoyanceAConstituer = Math.max(0, apportMou - prevoyanceDejaEnPlace);

  const versement3a = versementMensuelPourCapital(
    prevoyanceAConstituer,
    o.horizonAchatAnnees,
    rendement
  );
  const cashMensuel =
    o.horizonAchatAnnees > 0 ? Math.ceil(cashADeposer / (o.horizonAchatAnnees * 12)) : 0;

  // Faisabilité en fonction du nombre de comptes 3a possibles
  const plafonds = plafondsDisponiblesAnnuel(o);
  const faisable = versement3a <= plafonds.plafondMensuel;

  return {
    apportTotal,
    apportDur,
    apportMou,
    cashADeposer,
    prevoyanceRequise: apportMou,
    prevoyanceDejaEnPlace,
    prevoyanceAConstituer,
    versement3aMensuelRequis: versement3a,
    cashMensuelRequis: cashMensuel,
    totalEffortMensuel: versement3a + cashMensuel,
    faisable,
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
