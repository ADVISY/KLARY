import { FormStep } from "@/components/forms/MultiStepForm";

export const insuranceForms: Record<string, FormStep[]> = {
  sante: [
    {
      id: "age",
      title: "Quel âge avez-vous ?",
      fields: [{ type: "number", name: "age", label: "Âge", placeholder: "35", min: 0, max: 120, suffix: "ans" }],
    },
    {
      id: "canton",
      title: "Dans quel canton résidez-vous ?",
      fields: [
        {
          type: "select",
          name: "canton",
          label: "Canton",
          placeholder: "Sélectionnez votre canton",
          options: [
            { value: "GE", label: "Genève" },
            { value: "VD", label: "Vaud" },
            { value: "VS", label: "Valais" },
            { value: "FR", label: "Fribourg" },
            { value: "NE", label: "Neuchâtel" },
            { value: "JU", label: "Jura" },
            { value: "BE", label: "Berne" },
            { value: "ZH", label: "Zurich" },
            { value: "autre", label: "Autre" },
          ],
        },
      ],
    },
    {
      id: "modele",
      title: "Quel modèle d'assurance préférez-vous ?",
      fields: [
        {
          type: "radio",
          name: "modele",
          label: "Modèle LAMal",
          options: [
            { value: "standard", label: "Standard", hint: "Libre choix du médecin" },
            { value: "medecin", label: "Médecin de famille", hint: "−10% en moyenne" },
            { value: "hmo", label: "HMO", hint: "Cabinet de groupe, −20%" },
            { value: "telmed", label: "Telmed", hint: "Téléconsultation, −15%" },
          ],
        },
      ],
    },
    {
      id: "franchise",
      title: "Quelle franchise annuelle ?",
      description: "Plus la franchise est élevée, plus la prime baisse.",
      fields: [
        { type: "slider", name: "franchise", label: "Franchise", min: 300, max: 2500, step: 100, defaultValue: 300, suffix: "CHF" },
      ],
    },
    {
      id: "complementaires",
      title: "Souhaitez-vous des complémentaires ?",
      fields: [
        {
          type: "radio",
          name: "complementaires",
          label: "Couverture LCA",
          options: [
            { value: "non", label: "Non, juste la LAMal" },
            { value: "base", label: "Base", hint: "Médecines douces, dentaire" },
            { value: "demi", label: "Demi-privée" },
            { value: "privee", label: "Privée", hint: "Chambre privée, médecin de choix" },
          ],
        },
      ],
    },
  ],

  menage: [
    {
      id: "logement",
      title: "Quel type de logement ?",
      fields: [
        {
          type: "radio",
          name: "logement",
          label: "Logement",
          options: [
            { value: "appartement-loc", label: "Appartement loué" },
            { value: "appartement-prop", label: "Appartement en propriété" },
            { value: "maison-loc", label: "Maison louée" },
            { value: "maison-prop", label: "Maison en propriété" },
          ],
        },
      ],
    },
    {
      id: "surface",
      title: "Quelle est la surface du logement ?",
      fields: [{ type: "number", name: "surface", label: "Surface", placeholder: "80", suffix: "m²" }],
    },
    {
      id: "personnes",
      title: "Combien de personnes vivent dans le foyer ?",
      fields: [{ type: "number", name: "personnes", label: "Personnes", placeholder: "2", min: 1, max: 20 }],
    },
    {
      id: "valeur",
      title: "Estimation de la valeur du mobilier",
      fields: [
        { type: "slider", name: "valeur_mobilier", label: "Valeur mobilier", min: 10000, max: 200000, step: 5000, defaultValue: 40000, suffix: "CHF" },
      ],
    },
    {
      id: "vol",
      title: "Souhaitez-vous l'option vol ?",
      fields: [
        {
          type: "radio",
          name: "vol",
          label: "Vol simple à domicile",
          options: [
            { value: "oui", label: "Oui", hint: "Recommandé en zone urbaine" },
            { value: "non", label: "Non" },
          ],
        },
      ],
    },
  ],

  juridique: [
    {
      id: "situation",
      title: "Quelle situation à couvrir ?",
      fields: [
        {
          type: "radio",
          name: "situation",
          label: "Situation",
          options: [
            { value: "privee", label: "Vie privée uniquement" },
            { value: "circulation", label: "Circulation uniquement" },
            { value: "les-deux", label: "Privée + Circulation", hint: "Recommandé" },
            { value: "pro", label: "Professionnelle" },
          ],
        },
      ],
    },
    {
      id: "foyer",
      title: "Composition du foyer",
      fields: [
        {
          type: "radio",
          name: "foyer",
          label: "Foyer",
          options: [
            { value: "seul", label: "Personne seule" },
            { value: "couple", label: "Couple" },
            { value: "famille", label: "Famille avec enfants" },
          ],
        },
      ],
    },
    {
      id: "couverture",
      title: "Quel niveau de couverture ?",
      fields: [
        {
          type: "radio",
          name: "couverture",
          label: "Plafond annuel souhaité",
          options: [
            { value: "250k", label: "250'000 CHF", hint: "Standard" },
            { value: "500k", label: "500'000 CHF", hint: "Confort" },
            { value: "1M", label: "1'000'000 CHF", hint: "Premium" },
          ],
        },
      ],
    },
  ],

  auto: [
    {
      id: "vehicule",
      title: "Quel type de véhicule ?",
      fields: [
        {
          type: "radio",
          name: "vehicule",
          label: "Véhicule",
          options: [
            { value: "citadine", label: "Citadine" },
            { value: "berline", label: "Berline / Break" },
            { value: "suv", label: "SUV / 4x4" },
            { value: "premium", label: "Premium / Sportive" },
          ],
        },
      ],
    },
    {
      id: "annee",
      title: "Année du véhicule",
      fields: [{ type: "number", name: "annee", label: "Année de mise en circulation", placeholder: "2020", min: 1980, max: 2030 }],
    },
    {
      id: "valeur",
      title: "Valeur à neuf du véhicule",
      fields: [
        { type: "slider", name: "valeur", label: "Valeur catalogue", min: 5000, max: 200000, step: 1000, defaultValue: 35000, suffix: "CHF" },
      ],
    },
    {
      id: "km",
      title: "Kilométrage annuel estimé",
      fields: [
        {
          type: "radio",
          name: "km",
          label: "Kilomètres par an",
          options: [
            { value: "5000", label: "Moins de 5'000 km" },
            { value: "10000", label: "5'000 à 10'000 km" },
            { value: "20000", label: "10'000 à 20'000 km" },
            { value: "plus", label: "Plus de 20'000 km" },
          ],
        },
      ],
    },
    {
      id: "couverture",
      title: "Quelle couverture souhaitez-vous ?",
      fields: [
        {
          type: "radio",
          name: "couverture",
          label: "Type de couverture",
          options: [
            { value: "rc", label: "RC seule", hint: "Minimum légal" },
            { value: "casco-partielle", label: "Casco partielle", hint: "Vol, incendie, bris de glace" },
            { value: "casco-complete", label: "Casco complète", hint: "Tous risques" },
          ],
        },
      ],
    },
  ],

  "3e-pilier": [
    {
      id: "age",
      title: "Quel âge avez-vous ?",
      fields: [{ type: "number", name: "age", label: "Âge", placeholder: "35", min: 18, max: 65, suffix: "ans" }],
    },
    {
      id: "revenu",
      title: "Quel est votre revenu annuel brut ?",
      fields: [
        { type: "slider", name: "revenu", label: "Revenu annuel", min: 30000, max: 300000, step: 5000, defaultValue: 80000, suffix: "CHF" },
      ],
    },
    {
      id: "objectif",
      title: "Quel est votre objectif principal ?",
      fields: [
        {
          type: "radio",
          name: "objectif",
          label: "Objectif",
          options: [
            { value: "retraite", label: "Préparer ma retraite" },
            { value: "logement", label: "Acheter un logement" },
            { value: "fiscal", label: "Optimiser ma fiscalité" },
            { value: "famille", label: "Protéger ma famille" },
          ],
        },
      ],
    },
    {
      id: "montant",
      title: "Combien souhaitez-vous verser par mois ?",
      fields: [
        { type: "slider", name: "montant_mensuel", label: "Versement mensuel", min: 50, max: 595, step: 25, defaultValue: 300, suffix: "CHF" },
      ],
    },
    {
      id: "profil",
      title: "Quel profil de risque vous correspond ?",
      fields: [
        {
          type: "radio",
          name: "profil",
          label: "Profil",
          options: [
            { value: "prudent", label: "Prudent", hint: "Garantie capital" },
            { value: "equilibre", label: "Équilibré", hint: "Mix actions / obligations" },
            { value: "dynamique", label: "Dynamique", hint: "Majoritairement actions" },
          ],
        },
      ],
    },
  ],

  lpp: [
    {
      id: "nb-comptes",
      title: "Combien de comptes de libre passage avez-vous ?",
      fields: [
        {
          type: "radio",
          name: "nb_comptes",
          label: "Comptes connus",
          options: [
            { value: "0", label: "Je ne sais pas" },
            { value: "1", label: "1 compte" },
            { value: "2", label: "2 comptes" },
            { value: "3+", label: "3 ou plus" },
          ],
        },
      ],
    },
    {
      id: "montant",
      title: "Estimation totale de vos avoirs",
      fields: [
        { type: "slider", name: "montant_total", label: "Montant estimé", min: 0, max: 1000000, step: 10000, defaultValue: 100000, suffix: "CHF" },
      ],
    },
    {
      id: "age",
      title: "Quel âge avez-vous ?",
      fields: [{ type: "number", name: "age", label: "Âge", placeholder: "40", min: 18, max: 70, suffix: "ans" }],
    },
    {
      id: "objectif",
      title: "Quel est votre objectif ?",
      fields: [
        {
          type: "radio",
          name: "objectif",
          label: "Objectif",
          options: [
            { value: "retrouver", label: "Retrouver mes anciens avoirs" },
            { value: "regrouper", label: "Regrouper mes comptes" },
            { value: "optimiser", label: "Optimiser le rendement" },
            { value: "retrait", label: "Préparer un retrait" },
          ],
        },
      ],
    },
  ],

  hypotheque: [
    {
      id: "projet",
      title: "Quel est votre projet ?",
      fields: [
        {
          type: "radio",
          name: "projet",
          label: "Projet",
          options: [
            { value: "achat", label: "Achat d'un bien" },
            { value: "renouvellement", label: "Renouvellement d'hypothèque" },
            { value: "construction", label: "Construction" },
            { value: "renegociation", label: "Renégociation de taux" },
          ],
        },
      ],
    },
    {
      id: "prix",
      title: "Prix du bien immobilier",
      fields: [
        { type: "slider", name: "prix", label: "Prix du bien", min: 200000, max: 3000000, step: 50000, defaultValue: 800000, suffix: "CHF" },
      ],
    },
    {
      id: "fonds-propres",
      title: "Fonds propres disponibles",
      description: "Minimum 20 % du prix d'achat (dont 10 % en cash hors LPP).",
      fields: [
        { type: "slider", name: "fonds_propres", label: "Fonds propres", min: 50000, max: 1500000, step: 10000, defaultValue: 200000, suffix: "CHF" },
      ],
    },
    {
      id: "revenu",
      title: "Revenu annuel brut du foyer",
      fields: [
        { type: "slider", name: "revenu", label: "Revenu annuel", min: 50000, max: 500000, step: 5000, defaultValue: 150000, suffix: "CHF" },
      ],
    },
    {
      id: "taux",
      title: "Quel type de taux préférez-vous ?",
      fields: [
        {
          type: "radio",
          name: "taux",
          label: "Type de taux",
          options: [
            { value: "fixe", label: "Taux fixe", hint: "Sécurité long terme" },
            { value: "saron", label: "SARON", hint: "Variable, généralement moins cher" },
            { value: "mix", label: "Mixte", hint: "Combinaison des deux" },
            { value: "conseil", label: "Je veux un conseil" },
          ],
        },
      ],
    },
  ],
};
