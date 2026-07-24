import { Header } from "@/components/marketing/Header";
import { Footer } from "@/components/marketing/Footer";

export const metadata = {
  title: "Mentions légales",
  robots: "noindex, follow",
};

export default function MentionsLegalesPage() {
  return (
    <>
      <Header />
      <main className="max-w-3xl mx-auto px-6 py-16 md:py-24">
        <h1 className="text-4xl font-bold text-klary-navy mb-8">
          Mentions légales
        </h1>

        <div className="prose prose-klary space-y-6 text-klary-ink leading-relaxed">
          <section>
            <h2 className="text-xl font-bold text-klary-navy mb-2">
              Éditeur du site
            </h2>
            <p>
              <strong>Klary Sàrl</strong>
              <br />
              Route de Lausanne 31<br />
              1052 Le Mont-sur-Lausanne — Suisse<br />
              Email : <a href="mailto:admin@klary.ch" className="text-klary-orange hover:underline">admin@klary.ch</a>
              <br />
              Site web : <a href="https://klary.ch" className="text-klary-orange hover:underline">klary.ch</a>
            </p>
          </section>

          <section>
            <h2 className="text-xl font-bold text-klary-navy mb-2">
              Informations sur l'entreprise
            </h2>
            <p>
              <strong>Numéro d'identification (IDE)</strong> : en cours d'attribution
              <br />
              <strong>Numéro FINMA (registre courtiers)</strong> : en cours d'attribution
              <br />
              <strong>Forme juridique</strong> : société à responsabilité limitée (Sàrl) de droit suisse
              <br />
              <strong>Gérante</strong> : Anisa Sadiq
            </p>
          </section>

          <section>
            <h2 className="text-xl font-bold text-klary-navy mb-2">
              Hébergement
            </h2>
            <p>
              Ce site est hébergé par Vercel Inc. (États-Unis) via des serveurs
              situés dans l'Union européenne (Francfort). La base de données
              utilise Supabase (région EU-Central-1).
            </p>
          </section>

          <section>
            <h2 className="text-xl font-bold text-klary-navy mb-2">
              Propriété intellectuelle
            </h2>
            <p>
              L'ensemble des contenus (textes, images, graphismes, logo) présents
              sur ce site sont la propriété exclusive de Klary Sàrl, sauf mention
              contraire. Toute reproduction, même partielle, est interdite sans
              autorisation écrite préalable.
            </p>
          </section>

          <section>
            <h2 className="text-xl font-bold text-klary-navy mb-2">
              Responsabilité
            </h2>
            <p>
              Les informations fournies sur ce site sont indicatives et ne
              constituent en aucun cas un conseil personnalisé. Klary Sàrl décline
              toute responsabilité quant aux décisions prises sur la seule base
              des informations présentes sur ce site. Un conseil personnalisé
              nécessite un entretien direct avec un conseiller Klary.
            </p>
          </section>

          <section>
            <h2 className="text-xl font-bold text-klary-navy mb-2">
              Droit applicable
            </h2>
            <p>
              Le présent site et ses conditions d'utilisation sont régis par le
              droit suisse. En cas de litige, les tribunaux vaudois sont
              exclusivement compétents.
            </p>
          </section>
        </div>
      </main>
      <Footer />
    </>
  );
}
