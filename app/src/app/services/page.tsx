import { Header } from "@/components/marketing/Header";
import { Footer } from "@/components/marketing/Footer";
import Link from "next/link";

const services = [
  {
    title: "Assurance maladie",
    tagline: "LAMal + LCA. La bonne couverture, au juste prix.",
    points: [
      "Comparaison des 5 principales compagnies suisses",
      "Optimisation LAMal + complémentaires LCA (ambulatoire, hospitalier, dentaire)",
      "Vérification de votre droit aux subsides RIP",
      "Résiliations et changement de caisse pris en charge",
    ],
  },
  {
    title: "Prévoyance vie & 3e pilier",
    tagline: "Construire son avenir en toute sérénité.",
    points: [
      "3e pilier lié (3a) — optimisation fiscale immédiate",
      "3e pilier libre (3b) — souplesse totale",
      "Assurance-vie mixte, capital garanti",
      "Stratégie d'accession à la propriété via nantissement",
    ],
  },
  {
    title: "LPP libre passage",
    tagline: "Vos fonds oubliés, retrouvés et optimisés.",
    points: [
      "Recherche via le Fonds de garantie LPP suisse",
      "Regroupement de vos anciens comptes",
      "Stratégie d'échelonnement du retrait à la retraite",
      "Réduction d'impôt sur le retrait en capital",
    ],
  },
  {
    title: "Hypothèque",
    tagline: "Le bon financement, du bon partenaire.",
    points: [
      "Comparaison multi-banques et multi-compagnies",
      "Négociation du taux et des conditions",
      "Structuration 1er / 2e rang + amortissement direct/indirect",
      "Conseil neutre sur banque cantonale vs assurance vs privée",
    ],
  },
];

export const metadata = {
  title: "Nos services",
  description:
    "Assurance maladie, prévoyance, LPP libre passage et hypothèque — Klary, courtier indépendant en Suisse.",
};

export default function ServicesPage() {
  return (
    <>
      <Header />
      <main className="max-w-4xl mx-auto px-6 py-16 md:py-24">
        <div className="mb-14">
          <div className="text-xs font-bold tracking-widest uppercase text-klary-orange mb-3">
            Nos services
          </div>
          <h1 className="text-4xl md:text-5xl font-bold text-klary-navy tracking-tight mb-4">
            Ce que Klary fait pour vous.
          </h1>
          <p className="text-lg text-klary-grey max-w-2xl">
            Quatre domaines complémentaires, un seul interlocuteur — pour vous
            faire gagner du temps, de l'argent, et de la clarté.
          </p>
        </div>

        <div className="space-y-8">
          {services.map((s) => (
            <article
              key={s.title}
              className="p-6 md:p-8 rounded-2xl bg-white border border-klary-light-grey"
            >
              <h2 className="text-2xl font-bold text-klary-navy mb-2">
                {s.title}
              </h2>
              <p className="text-klary-orange font-semibold mb-5">
                {s.tagline}
              </p>
              <ul className="space-y-2">
                {s.points.map((p) => (
                  <li key={p} className="flex gap-3 text-klary-ink">
                    <span className="text-klary-orange font-bold shrink-0">
                      ▸
                    </span>
                    <span>{p}</span>
                  </li>
                ))}
              </ul>
            </article>
          ))}
        </div>

        <div className="mt-16 text-center">
          <Link
            href="/contact"
            className="inline-flex items-center gap-2 px-6 py-3.5 bg-klary-orange text-white text-base font-semibold rounded-xl hover:bg-klary-orange/90 transition-colors"
          >
            Prendre contact
          </Link>
        </div>
      </main>
      <Footer />
    </>
  );
}
