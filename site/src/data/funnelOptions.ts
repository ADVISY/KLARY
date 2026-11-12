/**
 * Options de référence des tunnels d'offre Klary.
 * Un seul fichier pour que les libellés affichés et les valeurs stockées
 * dans le lead restent alignés entre le formulaire, l'e-mail et la base.
 */

/** Cantons suisses, romands en tête puisque c'est le marché de Klary. */
export const CANTONS: { code: string; name: string }[] = [
  { code: "VD", name: "Vaud" },
  { code: "GE", name: "Genève" },
  { code: "VS", name: "Valais" },
  { code: "FR", name: "Fribourg" },
  { code: "NE", name: "Neuchâtel" },
  { code: "JU", name: "Jura" },
  { code: "BE", name: "Berne" },
  { code: "AG", name: "Argovie" },
  { code: "AI", name: "Appenzell Rhodes-Intérieures" },
  { code: "AR", name: "Appenzell Rhodes-Extérieures" },
  { code: "BL", name: "Bâle-Campagne" },
  { code: "BS", name: "Bâle-Ville" },
  { code: "GL", name: "Glaris" },
  { code: "GR", name: "Grisons" },
  { code: "LU", name: "Lucerne" },
  { code: "NW", name: "Nidwald" },
  { code: "OW", name: "Obwald" },
  { code: "SG", name: "Saint-Gall" },
  { code: "SH", name: "Schaffhouse" },
  { code: "SO", name: "Soleure" },
  { code: "SZ", name: "Schwytz" },
  { code: "TG", name: "Thurgovie" },
  { code: "TI", name: "Tessin" },
  { code: "UR", name: "Uri" },
  { code: "ZG", name: "Zoug" },
  { code: "ZH", name: "Zurich" },
];

export function cantonName(code: string): string {
  return CANTONS.find((c) => c.code === code)?.name ?? code;
}

/**
 * Assureurs maladie proposés à l'étape « chez qui êtes-vous aujourd'hui ».
 * C'est la situation DU PROSPECT, pas une liste de partenaires Klary : afficher
 * les grands assureurs du marché est indispensable pour qu'il puisse répondre.
 * Les logos vivent dans `public/insurance-logos/`.
 */
export const HEALTH_INSURERS: { value: string; label: string; logo: string }[] = [
  { value: "groupe-mutuel", label: "Groupe Mutuel", logo: "/insurance-logos/groupe-mutuel.png" },
  { value: "assura", label: "Assura", logo: "/insurance-logos/assura.png" },
  { value: "css", label: "CSS", logo: "/insurance-logos/css-assurance.png" },
  { value: "helsana", label: "Helsana", logo: "/insurance-logos/helsana.png" },
  { value: "swica", label: "Swica", logo: "/insurance-logos/swica.png" },
  { value: "sanitas", label: "Sanitas", logo: "/insurance-logos/sanitas.jpg" },
  { value: "visana", label: "Visana", logo: "/insurance-logos/visana.jpg" },
  { value: "concordia", label: "Concordia", logo: "/insurance-logos/concordia.jpg" },
  { value: "sympany", label: "Sympany", logo: "/insurance-logos/sympany.png" },
  { value: "kpt", label: "KPT", logo: "/insurance-logos/kpt-cpt.jpg" },
  { value: "atupri", label: "Atupri", logo: "/insurance-logos/atupri.png" },
];

/** Situation familiale : pèse directement sur la prime et sur le subside. */
export const FAMILY_SITUATIONS = [
  { value: "single", label: "Seul(e)" },
  { value: "couple", label: "En couple" },
  { value: "family", label: "Famille avec enfants" },
  { value: "single-parent", label: "Famille monoparentale" },
] as const;

/** Modèles d'assurance de base LAMal. */
export const LAMAL_MODELS = [
  { value: "standard", label: "Libre choix du médecin" },
  { value: "family-doctor", label: "Médecin de famille" },
  { value: "hmo", label: "Réseau HMO" },
  { value: "telmed", label: "Télémédecine" },
  { value: "unknown", label: "Je ne sais pas" },
] as const;

/** Franchises adultes LAMal. */
export const FRANCHISES_ADULT = [300, 500, 1000, 1500, 2000, 2500];

/** Tranches de revenu brut du ménage, pour l'estimation du droit au subside. */
export const INCOME_RANGES = [
  { value: "lt-30", label: "Moins de 30 000 CHF" },
  { value: "30-45", label: "30 000 à 45 000 CHF" },
  { value: "45-60", label: "45 000 à 60 000 CHF" },
  { value: "60-75", label: "60 000 à 75 000 CHF" },
  { value: "75-90", label: "75 000 à 90 000 CHF" },
  { value: "gt-90", label: "Plus de 90 000 CHF" },
] as const;

/** Taille du ménage fiscal. */
export const HOUSEHOLD_SIZES = [
  { value: "1", label: "1 personne" },
  { value: "2", label: "2 personnes" },
  { value: "3", label: "3 personnes" },
  { value: "4", label: "4 personnes" },
  { value: "5+", label: "5 personnes et plus" },
] as const;

/** Situations qui ouvrent ou élargissent le droit au subside. */
export const SPECIAL_SITUATIONS = [
  { value: "none", label: "Aucune de ces situations" },
  { value: "student", label: "Étudiant(e) ou en formation" },
  { value: "pensioner", label: "Rentier AVS ou AI" },
  { value: "supplementary", label: "Prestations complémentaires" },
  { value: "social-aid", label: "Aide sociale" },
  { value: "unemployed", label: "Sans emploi" },
] as const;

/** Créneau de rappel souhaité. */
export const AVAILABILITY = [
  { value: "morning", label: "Le matin" },
  { value: "afternoon", label: "L'après-midi" },
  { value: "evening", label: "En fin de journée" },
  { value: "any", label: "Peu importe" },
] as const;

/**
 * Tranches de revenu dont on sait qu'elles n'ouvrent en principe aucun droit.
 * Sert uniquement à adapter le message de fin, jamais à refuser un dossier :
 * seul le canton décide, et les barèmes changent chaque année.
 */
export const INCOME_UNLIKELY_ELIGIBLE = ["gt-90"];

/**
 * Traduit une valeur technique en libellé lisible.
 *
 * Le tunnel manipule des valeurs stables (`groupe-mutuel`, `45-60`, `single`),
 * mais un conseiller qui ouvre la feuille de suivi doit lire « Groupe Mutuel »,
 * « 45 000 à 60 000 CHF », « Seul(e) ». On envoie donc les deux : la valeur
 * technique pour la machine, le libellé pour l'humain.
 */
export function labelOf(
  options: readonly { value: string; label: string }[],
  value: string
): string {
  if (!value) return "";
  return options.find((o) => o.value === value)?.label ?? value;
}

/** Oui / Non lisible, et chaîne vide quand la question n'a pas été posée. */
export function ouiNon(value: boolean | null | undefined): string {
  if (value === null || value === undefined) return "";
  return value ? "Oui" : "Non";
}
