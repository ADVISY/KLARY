import { Header } from "@/components/marketing/Header";
import { Footer } from "@/components/marketing/Footer";
import Link from "next/link";

export const metadata = {
  title: "À propos",
  description:
    "Klary Sàrl — cabinet de courtage indépendant fondé par Anisa Sadiq. Notre engagement : la neutralité.",
};

export default function AProposPage() {
  return (
    <>
      <Header />
      <main className="max-w-3xl mx-auto px-6 py-16 md:py-24">
        <div className="mb-12">
          <div className="text-xs font-bold tracking-widest uppercase text-klary-orange mb-3">
            À propos
          </div>
          <h1 className="text-4xl md:text-5xl font-bold text-klary-navy tracking-tight mb-4">
            Klary, c'est nous.
          </h1>
          <p className="text-lg text-klary-grey">
            Un cabinet de courtage indépendant, basé au Mont-sur-Lausanne,
            fondé par des professionnels qui en avaient assez du courtage
            classique.
          </p>
        </div>

        <div className="space-y-8 text-klary-ink leading-relaxed">
          <section>
            <h2 className="text-2xl font-bold text-klary-navy mb-3">
              Notre constat
            </h2>
            <p>
              Le marché suisse du courtage manque de neutralité. Trop
              d'intermédiaires poussent les produits qui les rémunèrent le
              mieux plutôt que ceux qui protègent le mieux leurs clients. Nous
              avons choisi le chemin inverse.
            </p>
          </section>

          <section>
            <h2 className="text-2xl font-bold text-klary-navy mb-3">
              Notre pari
            </h2>
            <p>
              Comparer avec honnêteté, recommander sans agenda caché — quitte
              à conseiller à un prospect de garder son contrat actuel. Chez
              Klary, la même commission peu importe le produit retenu. Vous
              êtes conseillé selon vos besoins réels, pas selon nos intérêts.
            </p>
          </section>

          <section>
            <h2 className="text-2xl font-bold text-klary-navy mb-3">
              Anisa Sadiq — Gérante et fondatrice
            </h2>
            <p>
              Anisa a fondé Klary pour bâtir un cabinet de courtage à son
              image : neutre, exigeant, sans compromis. Sa vision : que chaque
              client Klary reparte avec la certitude d'avoir la meilleure
              couverture pour sa situation.
            </p>
          </section>

          <section>
            <h2 className="text-2xl font-bold text-klary-navy mb-3">
              Nos trois exigences
            </h2>
            <ul className="space-y-3">
              <li className="flex gap-3">
                <span className="text-klary-orange font-bold shrink-0">▸</span>
                <span>
                  <strong>Neutralité</strong> — le client passe avant la
                  commission. Toujours.
                </span>
              </li>
              <li className="flex gap-3">
                <span className="text-klary-orange font-bold shrink-0">▸</span>
                <span>
                  <strong>Transparence</strong> — chiffres, contrats, méthode
                  — rien n'est caché.
                </span>
              </li>
              <li className="flex gap-3">
                <span className="text-klary-orange font-bold shrink-0">▸</span>
                <span>
                  <strong>Exigence</strong> — un courtier, ce n'est pas un
                  vendeur. Formation continue, méthode rigoureuse, suivi
                  qualité.
                </span>
              </li>
            </ul>
          </section>
        </div>

        <div className="mt-16 text-center">
          <Link
            href="/contact"
            className="inline-flex items-center gap-2 px-6 py-3.5 bg-klary-orange text-white text-base font-semibold rounded-xl hover:bg-klary-orange/90 transition-colors"
          >
            Nous rencontrer
          </Link>
        </div>
      </main>
      <Footer />
    </>
  );
}
