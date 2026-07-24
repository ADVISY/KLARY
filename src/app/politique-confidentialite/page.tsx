import { Header } from "@/components/marketing/Header";
import { Footer } from "@/components/marketing/Footer";

export const metadata = {
  title: "Politique de confidentialité",
  robots: "noindex, follow",
};

export default function PolitiqueConfidentialitePage() {
  return (
    <>
      <Header />
      <main className="max-w-3xl mx-auto px-6 py-16 md:py-24">
        <h1 className="text-4xl font-bold text-klary-navy mb-8">
          Politique de confidentialité
        </h1>

        <div className="space-y-6 text-klary-ink leading-relaxed">
          <p className="text-klary-grey italic">
            Dernière mise à jour : {new Date().getFullYear()}
          </p>

          <section>
            <h2 className="text-xl font-bold text-klary-navy mb-2">
              Responsable du traitement
            </h2>
            <p>
              Klary Sàrl · Route de Lausanne 31 · 1052 Le Mont-sur-Lausanne ·
              Suisse. Contact : admin@klary.ch
            </p>
          </section>

          <section>
            <h2 className="text-xl font-bold text-klary-navy mb-2">
              Données collectées
            </h2>
            <p>Nous collectons uniquement les données que vous nous confiez :</p>
            <ul className="list-disc pl-6 space-y-1 mt-2">
              <li>
                <strong>Formulaire de contact</strong> — nom, prénom, email,
                téléphone, sujet, message.
              </li>
              <li>
                <strong>Formulaire de candidature</strong> — nom, prénom, email,
                téléphone, poste visé, CV (PDF), lettre de motivation
                éventuelle.
              </li>
              <li>
                <strong>Espace agent</strong> (accès réservé) — email
                @klary.ch, résultats d'évaluations, certifications obtenues.
              </li>
            </ul>
          </section>

          <section>
            <h2 className="text-xl font-bold text-klary-navy mb-2">
              Finalités
            </h2>
            <ul className="list-disc pl-6 space-y-1">
              <li>Répondre à vos demandes de contact / devis</li>
              <li>Étudier votre candidature à un poste chez Klary</li>
              <li>Gérer la formation interne et la certification des agents</li>
            </ul>
          </section>

          <section>
            <h2 className="text-xl font-bold text-klary-navy mb-2">
              Durée de conservation
            </h2>
            <ul className="list-disc pl-6 space-y-1">
              <li>
                <strong>Messages de contact</strong> : 24 mois maximum, puis
                suppression automatique.
              </li>
              <li>
                <strong>Candidatures non retenues</strong> : 12 mois maximum
                à compter du dépôt, puis suppression automatique. Sur demande,
                suppression immédiate possible.
              </li>
              <li>
                <strong>Dossiers agents</strong> : durée du contrat + 10 ans
                (art. 962 CO — obligation de conservation).
              </li>
            </ul>
          </section>

          <section>
            <h2 className="text-xl font-bold text-klary-navy mb-2">
              Vos droits (nLPD)
            </h2>
            <p>Vous disposez à tout moment des droits suivants :</p>
            <ul className="list-disc pl-6 space-y-1 mt-2">
              <li>Droit d'accès à vos données</li>
              <li>Droit de rectification</li>
              <li>Droit à l'effacement (« droit à l'oubli »)</li>
              <li>Droit d'opposition au traitement</li>
              <li>Droit à la portabilité</li>
            </ul>
            <p className="mt-3">
              Pour exercer ces droits, écrivez-nous à{" "}
              <a
                href="mailto:admin@klary.ch"
                className="text-klary-orange hover:underline"
              >
                admin@klary.ch
              </a>{" "}
              avec l'objet « [nLPD] Demande d'accès/rectification/effacement ».
              Réponse sous 30 jours (art. 25 nLPD).
            </p>
          </section>

          <section>
            <h2 className="text-xl font-bold text-klary-navy mb-2">
              Sécurité
            </h2>
            <p>
              Vos données sont chiffrées au repos (AES-256) et en transit (TLS
              1.3). Elles sont hébergées en Europe (Francfort). Aucun transfert
              hors UE/Suisse. Accès strictement limité aux personnes autorisées
              de Klary.
            </p>
          </section>

          <section>
            <h2 className="text-xl font-bold text-klary-navy mb-2">
              Cookies
            </h2>
            <p>
              Ce site n'utilise que des cookies techniques strictement
              nécessaires à son fonctionnement (session utilisateur). Aucun
              cookie publicitaire ou de tracking tiers.
            </p>
          </section>

          <section>
            <h2 className="text-xl font-bold text-klary-navy mb-2">
              Contact PFPDT
            </h2>
            <p>
              En cas de litige non résolu avec nous, vous pouvez contacter le
              Préposé fédéral à la protection des données et à la transparence
              (PFPDT) : Feldeggweg 1, 3003 Berne ·{" "}
              <a
                href="https://www.edoeb.admin.ch"
                target="_blank"
                rel="noopener noreferrer"
                className="text-klary-orange hover:underline"
              >
                edoeb.admin.ch
              </a>
            </p>
          </section>
        </div>
      </main>
      <Footer />
    </>
  );
}
