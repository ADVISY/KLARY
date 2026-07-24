import { HeaderV2 } from "@/components/v2/HeaderV2";
import { FooterV2 } from "@/components/v2/FooterV2";
import { ScrollProgress } from "@/components/v2/ScrollProgress";
import { PageHeroV2 } from "@/components/v2/PageHeroV2";
import { PageSectionV2 } from "@/components/v2/PageSectionV2";

const sections = [
  {
    title: "Données collectées",
    body: [
      "Quand vous nous contactez (formulaire, email, téléphone), nous collectons les informations strictement nécessaires : nom, prénom, email, téléphone, et le contenu de votre demande.",
      "Lors d'une analyse de vos contrats, nous traitons des données complémentaires : copies de contrats actuels, informations sur votre situation familiale et professionnelle, état de santé déclaré.",
      "Aucune donnée n'est collectée sans votre consentement explicite.",
    ],
  },
  {
    title: "Utilisation des données",
    body: [
      "Vos données servent uniquement à : (1) répondre à votre demande, (2) effectuer l'analyse de vos contrats, (3) vous proposer des solutions adaptées, (4) gérer le suivi commercial et administratif.",
      "Nous ne vendons jamais vos données à des tiers. Elles ne sont partagées qu'avec les compagnies d'assurance, et uniquement avec votre accord écrit, pour obtenir des offres en votre nom.",
    ],
  },
  {
    title: "Conservation des données",
    body: [
      "Données de prospects : 24 mois après le dernier contact, puis suppression automatique.",
      "Données de clients : durée de la relation contractuelle + 10 ans (obligation légale suisse en matière fiscale et de courtage).",
      "Sur demande, nous supprimons immédiatement vos données sauf obligations légales.",
    ],
  },
  {
    title: "Vos droits (nLPD)",
    body: [
      "Conformément à la nouvelle Loi suisse sur la Protection des Données (nLPD), vous avez : un droit d'accès à vos données, un droit de rectification, un droit d'opposition au traitement, un droit à la portabilité, et un droit à l'effacement.",
      "Pour exercer ces droits, écrivez à admin@klary.ch en précisant votre demande. Nous répondons sous 30 jours maximum.",
    ],
  },
  {
    title: "Sécurité",
    body: [
      "Hébergement 100% suisse chez Infomaniak (data sovereignty CH).",
      "Connexion chiffrée HTTPS sur tout le site (certificat Let's Encrypt).",
      "Accès aux dossiers clients restreint aux conseillers habilités, traçabilité complète.",
    ],
  },
  {
    title: "Cookies",
    body: [
      "Le site klary.ch utilise uniquement des cookies techniques nécessaires à son fonctionnement (préférences de langue, session). Aucun cookie tiers ni de tracking publicitaire.",
      "Vous pouvez désactiver les cookies depuis votre navigateur sans impacter votre expérience.",
    ],
  },
];

const PolitiqueConfidentialite = () => {
  return (
    <div className="min-h-screen bg-background text-foreground">
      <ScrollProgress />
      <HeaderV2 />

      <main>
        <PageHeroV2
          variant="cool"
          eyebrow="Confidentialité"
          title="Vos données,"
          titleAccent="protégées."
          subtitle="Klary respecte strictement la nouvelle Loi suisse sur la Protection des Données (nLPD). Voici comment nous traitons vos informations."
        />

        {sections.map((s, i) => (
          <PageSectionV2 key={i} eyebrow={`Section ${String(i + 1).padStart(2, "0")}`} title={s.title}>
            <div className="max-w-3xl">
              <div
                className="kx-card !p-7 space-y-4 text-base leading-relaxed"
                style={{ color: "hsl(var(--foreground-soft))" }}
              >
                {s.body.map((p, j) => (
                  <p key={j}>{p}</p>
                ))}
              </div>
            </div>
          </PageSectionV2>
        ))}

        <PageSectionV2 eyebrow="Une question ?" title="Contactez notre responsable confidentialité">
          <div className="max-w-3xl text-base leading-relaxed" style={{ color: "hsl(var(--foreground-soft))" }}>
            <p>
              Pour toute question sur le traitement de vos données ou pour exercer vos droits, écrivez à{" "}
              <a href="mailto:admin@klary.ch" className="font-semibold hover:underline" style={{ color: "hsl(var(--accent))" }}>
                admin@klary.ch
              </a>.
            </p>
            <p className="mt-2 text-sm" style={{ color: "hsl(var(--muted-text))" }}>
              Dernière mise à jour : 26 mai 2026.
            </p>
          </div>
        </PageSectionV2>
      </main>

      <FooterV2 />
    </div>
  );
};

export default PolitiqueConfidentialite;
