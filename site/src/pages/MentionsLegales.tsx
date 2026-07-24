import { HeaderV2 } from "@/components/v2/HeaderV2";
import { FooterV2 } from "@/components/v2/FooterV2";
import { ScrollProgress } from "@/components/v2/ScrollProgress";
import { PageHeroV2 } from "@/components/v2/PageHeroV2";
import { PageSectionV2 } from "@/components/v2/PageSectionV2";

const MentionsLegales = () => {
  return (
    <div className="min-h-screen bg-background text-foreground">
      <ScrollProgress />
      <HeaderV2 />

      <main>
        <PageHeroV2
          variant="cool"
          eyebrow="Mentions légales"
          title="Informations"
          titleAccent="légales."
          subtitle="Conformément au droit suisse, voici les informations relatives à l'éditeur du site et aux conditions d'utilisation."
        />

        <PageSectionV2 eyebrow="Éditeur" title="Klary Sàrl">
          <div className="max-w-3xl">
            <div className="kx-card !p-7 text-base leading-relaxed" style={{ color: "hsl(var(--foreground-soft))" }}>
              <p className="text-lg font-semibold text-foreground mb-3">Klary Sàrl</p>
              <p>Cabinet de conseil en assurance indépendant</p>
              <p className="mt-3">
                <strong className="text-foreground">Adresse :</strong> Route de Crassier 15, 1262 Eysins, Suisse
                <br />
                <strong className="text-foreground">Email :</strong>{" "}
                <a href="mailto:admin@klary.ch" className="hover:underline" style={{ color: "hsl(var(--accent))" }}>
                  admin@klary.ch
                </a>
              </p>
              <p className="mt-3">
                <strong className="text-foreground">Numéro IDE :</strong> CHE-XXX.XXX.XXX
                <br />
                <strong className="text-foreground">Inscription FINMA :</strong> En cours
              </p>
            </div>
          </div>
        </PageSectionV2>

        <PageSectionV2 eyebrow="Hébergement" title="Hébergeur du site">
          <div className="max-w-3xl">
            <div className="kx-card !p-7 text-base leading-relaxed" style={{ color: "hsl(var(--foreground-soft))" }}>
              <p>
                <strong className="text-foreground">Infomaniak Network SA</strong>
                <br />
                Rue Eugène-Marziano 25, 1227 Les Acacias, Suisse
                <br />
                <a
                  href="https://www.infomaniak.com"
                  target="_blank"
                  rel="noopener noreferrer"
                  className="hover:underline"
                  style={{ color: "hsl(var(--accent))" }}
                >
                  www.infomaniak.com
                </a>
              </p>
            </div>
          </div>
        </PageSectionV2>

        <PageSectionV2 eyebrow="Propriété intellectuelle" title="Droits d'auteur et marques">
          <div className="max-w-3xl space-y-4 text-base leading-relaxed" style={{ color: "hsl(var(--foreground-soft))" }}>
            <p>
              L'ensemble du contenu du site klary.ch (textes, images, vidéos, logos, graphismes, code source, structure)
              est la propriété exclusive de Klary Sàrl ou de ses partenaires. Toute reproduction, représentation,
              modification, publication, adaptation, totale ou partielle, par quelque procédé que ce soit, est
              interdite sans autorisation écrite préalable.
            </p>
            <p>
              Les marques des compagnies d'assurance affichées sur le site (Helvetia, Swiss Life, AXA, Zurich,
              Generali, etc.) appartiennent à leurs détenteurs respectifs. Klary Sàrl agit en tant que courtier
              indépendant et n'est lié à aucune compagnie.
            </p>
          </div>
        </PageSectionV2>

        <PageSectionV2 eyebrow="Responsabilité" title="Limitation de responsabilité">
          <div className="max-w-3xl space-y-4 text-base leading-relaxed" style={{ color: "hsl(var(--foreground-soft))" }}>
            <p>
              Les informations diffusées sur le site klary.ch sont fournies à titre indicatif. Elles ne constituent
              pas une recommandation d'investissement ou une offre contractuelle. Pour toute décision relative à
              vos assurances ou votre prévoyance, nous vous recommandons de prendre contact avec un de nos conseillers.
            </p>
            <p>
              Klary Sàrl s'efforce de maintenir les informations à jour mais ne peut garantir leur exactitude
              absolue. Les tarifs et conditions communiqués peuvent varier en fonction de votre profil et des
              modifications apportées par les compagnies.
            </p>
          </div>
        </PageSectionV2>

        <PageSectionV2 eyebrow="Contact" title="Une question ?">
          <div className="max-w-3xl text-base leading-relaxed" style={{ color: "hsl(var(--foreground-soft))" }}>
            <p>
              Pour toute question juridique ou demande spécifique concernant le site, vous pouvez nous écrire à{" "}
              <a href="mailto:admin@klary.ch" className="font-semibold hover:underline" style={{ color: "hsl(var(--accent))" }}>
                admin@klary.ch
              </a>.
            </p>
          </div>
        </PageSectionV2>
      </main>

      <FooterV2 />
    </div>
  );
};

export default MentionsLegales;
