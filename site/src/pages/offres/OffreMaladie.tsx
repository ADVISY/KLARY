import FunnelShell from "@/components/funnel/FunnelShell";
import FunnelHero from "@/components/funnel/FunnelHero";
import HealthFunnel from "@/components/funnel/HealthFunnel";
import NoIndex from "@/components/funnel/NoIndex";

/**
 * Page d'offre « assurance maladie ».
 *
 * Atterrissage de campagne payante, pas une page de site : aucune sortie, aucun
 * menu, et le statut d'intermédiaire lié au Groupe Mutuel affiché en pied sur
 * toutes les étapes. Reste en noindex, y compris après réouverture du site.
 */
const OffreMaladie = () => (
  <>
    <NoIndex />
    <FunnelShell
      tiedPartner={{
        label: "Klary Sàrl, intermédiaire d'assurance lié à",
        partnerName: "Groupe Mutuel",
        logoSrc: "/insurance-logos/groupe-mutuel.png",
      }}
    >
      <FunnelHero
        eyebrow="Assurance maladie 2027"
        title="VOTRE COUVERTURE MALADIE, EXPLIQUÉE CLAIREMENT"
        titleMobile="VOTRE COUVERTURE MALADIE"
      />
      <HealthFunnel />
    </FunnelShell>
  </>
);

export default OffreMaladie;
