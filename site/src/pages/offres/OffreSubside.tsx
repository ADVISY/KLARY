import FunnelShell from "@/components/funnel/FunnelShell";
import FunnelHero from "@/components/funnel/FunnelHero";
import SubsidyFunnel from "@/components/funnel/SubsidyFunnel";
import NoIndex from "@/components/funnel/NoIndex";

/**
 * Page d'offre « subside à l'assurance maladie ».
 *
 * Le subside est versé par le canton : la page promet une vérification du
 * droit et un accompagnement du dossier, jamais un montant. Le statut
 * d'intermédiaire lié reste affiché, puisque l'appel qui suit portera aussi
 * sur l'assurance elle-même.
 */
const OffreSubside = () => (
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
        eyebrow="Subside 2027"
        title="VÉRIFIEZ VOTRE DROIT AU SUBSIDE CANTONAL"
        titleMobile="VOTRE DROIT AU SUBSIDE"
      />
      <SubsidyFunnel />
    </FunnelShell>
  </>
);

export default OffreSubside;
