/**
 * Convention de sortie Klary — document à imprimer sur papier Klary
 * pour signature manuscrite par l'agent partant.
 *
 * Basé sur les articles réels du contrat agent Klary v3 :
 *   • Art. 13 — Confidentialité permanente
 *   • Art. 14 — Interdiction de débauchage (12 mois, peine 6 mois commissions)
 *   • Art. 15 — Interdiction de concurrence post-contractuelle (12 mois VD+GE+NE+FR)
 *   • Art. 16 — Renonciation indemnité de clientèle (art. 418u CO)
 *   • Annexe III art. 2-3 — Compte de caution 20%/100% × 3 ans
 */

export type ConventionSortieProps = {
  firstName: string;
  lastName: string;
  functionTitle?: string;
  entryDate?: string;
  lastWorkingDay: string;
  reason: string;
  city?: string;
  issuedDate?: string;
};

const REASON_LABELS: Record<string, string> = {
  demission: "Démission",
  mutuel_accord: "Rupture d'un commun accord",
  rupture_essai: "Rupture de la période d'essai",
  fin_cdd: "Fin de contrat à durée déterminée",
  retraite: "Départ à la retraite",
  licenciement: "Licenciement (préavis normal)",
  faute_grave: "Licenciement pour faute grave (art. 337 CO)",
  abandon_poste: "Abandon de poste",
};

const AGGRAVATED = new Set(["faute_grave", "abandon_poste"]);

export function ConventionSortie({
  firstName,
  lastName,
  functionTitle = "Agent Klary",
  entryDate,
  lastWorkingDay,
  reason,
  city = "Le Mont-sur-Lausanne",
  issuedDate,
}: ConventionSortieProps) {
  const isAggravated = AGGRAVATED.has(reason);
  const reasonLabel = REASON_LABELS[reason] || reason;
  const today =
    issuedDate ||
    new Date().toLocaleDateString("fr-CH", {
      day: "numeric",
      month: "long",
      year: "numeric",
    });

  return (
    <div
      className="convention-klary bg-white mx-auto"
      style={{
        width: "210mm",
        minHeight: "297mm",
        padding: "18mm 20mm",
        fontFamily:
          "-apple-system, BlinkMacSystemFont, 'Segoe UI', 'Helvetica Neue', sans-serif",
        color: "#1A1660",
        boxShadow: "0 8px 40px rgba(26, 22, 96, 0.15)",
        fontSize: "10pt",
        lineHeight: 1.5,
        position: "relative",
      }}
    >
      {/* Header */}
      <div
        style={{
          borderBottom: "3px solid #F0651F",
          paddingBottom: "8mm",
          marginBottom: "10mm",
        }}
      >
        <img
          src="/klary-logo-color.svg"
          alt="Klary"
          style={{ height: "14mm", width: "auto", display: "block" }}
        />
        <div style={{ marginTop: "6mm" }}>
          <div
            style={{
              fontSize: "18pt",
              fontWeight: 700,
              color: "#1A1660",
              lineHeight: 1.15,
            }}
          >
            Convention de sortie et rappel des obligations post-emploi
          </div>
          <div
            style={{
              fontSize: "9pt",
              color: "#6E6A8E",
              marginTop: "3mm",
              fontStyle: "italic",
            }}
          >
            Objet : formalisation des obligations post-emploi et déblocage
            des documents administratifs de sortie
          </div>
        </div>
      </div>

      {/* Identité */}
      <div
        style={{
          padding: "5mm 6mm",
          background: "#FAF5EF",
          borderRadius: "2mm",
          marginBottom: "6mm",
        }}
      >
        <table width="100%" cellSpacing="0" cellPadding="2">
          <tbody>
            <tr>
              <td style={{ width: "40%", color: "#6E6A8E", fontSize: "9pt" }}>Employé</td>
              <td style={{ fontWeight: 700 }}>
                {firstName} {lastName}
              </td>
            </tr>
            <tr>
              <td style={{ color: "#6E6A8E", fontSize: "9pt" }}>Fonction</td>
              <td>{functionTitle}</td>
            </tr>
            {entryDate && (
              <tr>
                <td style={{ color: "#6E6A8E", fontSize: "9pt" }}>Date d'entrée Klary</td>
                <td>{entryDate}</td>
              </tr>
            )}
            <tr>
              <td style={{ color: "#6E6A8E", fontSize: "9pt" }}>Dernier jour travaillé</td>
              <td style={{ fontWeight: 700 }}>{lastWorkingDay}</td>
            </tr>
            <tr>
              <td style={{ color: "#6E6A8E", fontSize: "9pt" }}>Motif du départ</td>
              <td style={{ fontWeight: 700 }}>{reasonLabel}</td>
            </tr>
          </tbody>
        </table>
      </div>

      {/* Article 1 — Débauchage */}
      <Section number={1} title="Interdiction de débauchage (art. 14 du contrat)">
        Conformément à <strong>l'article 14</strong> du contrat, l'agent
        s'engage pendant <strong>douze (12) mois</strong> à compter de la fin
        des rapports contractuels, sur l'ensemble du territoire suisse, à
        <strong> NE PAS solliciter</strong>, directement ou indirectement :
        <ul style={{ margin: "2mm 0 2mm 6mm", padding: 0 }}>
          <li>Les employés ou agents actuels ou anciens de Klary</li>
          <li>Les partenaires ou clients de Klary</li>
          <li>Les clients des compagnies collaborant avec Klary</li>
        </ul>
        En cas de violation, une <strong>peine conventionnelle</strong> équivalente à
        <strong> six (6) mois de commissions moyennes par cas</strong> (art. 14.2)
        est due, sans préjudice de dommages-intérêts complémentaires.
      </Section>

      {/* Article 2 — Concurrence */}
      <Section number={2} title="Interdiction de concurrence post-contractuelle (art. 15)">
        Pendant <strong>douze (12) mois</strong> post-contrat, l'agent
        s'engage à ne pas exercer d'activité d'intermédiation ou de conseil
        en assurance :
        <ul style={{ margin: "2mm 0 2mm 6mm", padding: 0 }}>
          <li>
            Sur le canton de <strong>Vaud</strong> et les cantons limitrophes
            (<strong>Genève, Neuchâtel, Fribourg</strong>)
          </li>
          <li>
            Dans les branches d'assurance sur lesquelles il a été formé et
            actif chez Klary
          </li>
        </ul>
      </Section>

      {/* Article 3 — Compte de caution */}
      <Section
        number={3}
        title="Compte de caution — blocage des commissions à venir (Annexe III)"
      >
        <p style={{ margin: 0 }}>
          Par <strong>sécurité financière de l'entreprise</strong> et en
          garantie du bon suivi des contrats conclus par l'agent auprès de ses
          clients, Klary conserve dans le <strong>COMPTE DE CAUTION</strong> :
        </p>
        <ul style={{ margin: "1.5mm 0 1.5mm 6mm", padding: 0 }}>
          <li>
            L'intégralité des commissions dues à l'agent au moment de la fin
            des rapports contractuels
          </li>
          <li>
            L'intégralité des <strong>commissions récurrentes à venir</strong>{" "}
            sur les contrats déjà signés par l'agent avec ses clients
          </li>
        </ul>

        <p style={{ margin: "1.5mm 0" }}>
          L'agent <strong>récupère ses commissions PROGRESSIVEMENT</strong>, à
          mesure que les contrats qu'il a conclus avec ses clients atteignent
          leur échéance de responsabilité contractuelle (typiquement{" "}
          <strong>3 ans</strong> en assurance suisse).
        </p>

        <p style={{ margin: "1.5mm 0" }}>
          Si un contrat est résilié ou annulé avant échéance, Klary utilise le
          compte de caution pour rembourser les commissions perçues et non
          acquises, conformément à l'art. 418p CO et à l'Annexe III du contrat
          agent.
        </p>

        <p style={{ margin: "1.5mm 0" }}>
          À l'issue de la période de responsabilité (<strong>3 ans à compter
          de la fin du contrat d'agence</strong>), le <strong>solde éventuel</strong>{" "}
          du compte de caution est reversé à l'agent, déduction faite des
          annulations et remboursements survenus dans l'intervalle.
        </p>

        {isAggravated && (
          <div
            style={{
              marginTop: "2mm",
              padding: "3mm 4mm",
              background: "#fff5f5",
              borderLeft: "3px solid #dc2626",
              borderRadius: "1.5mm",
              fontSize: "9.5pt",
            }}
          >
            <strong>Spécificité — {reasonLabel.toLowerCase()} :</strong> en cas
            de faute grave, abandon de poste ou résiliation anticipée sans
            respect des délais contractuels, le solde du compte de caution
            peut être <strong>retenu en totalité</strong> et affecté au
            règlement des dommages-intérêts dus à Klary (art. 337c CO +
            Annexe III art. 3).
          </div>
        )}
      </Section>

      {/* Article 4 — Renonciation indemnité clientèle */}
      <Section number={4} title="Renonciation à l'indemnité de clientèle (art. 16 + 418u CO)">
        L'agent <strong>RÉITÈRE</strong> sa renonciation expresse à toute
        indemnité de clientèle au sens de l'article 418u CO, comme convenu à
        l'article 16 du contrat. Aucune revendication future ne pourra être
        formulée sur ce fondement.
      </Section>

      {/* Article 5 — Restitution */}
      <Section number={5} title="Restitution matériel et données (dernier jour travaillé)">
        L'agent restitue à Klary d'ici la date effective du départ :
        <div style={{ marginTop: "2mm", columns: 2, columnGap: "8mm" }}>
          <div>☐ Ordinateur portable + chargeur</div>
          <div>☐ Badge d'accès Regus (Eysins)</div>
          <div>☐ Clés éventuelles</div>
          <div>☐ Téléphone professionnel</div>
          <div>☐ Cartes de visite non distribuées</div>
          <div>☐ Toute donnée client détenue en local</div>
        </div>
      </Section>

      {/* Article 6 — Confidentialité */}
      <Section number={6} title="Obligation permanente de confidentialité (art. 13)">
        L'obligation de confidentialité <strong>subsiste après la fin du contrat sans limitation dans le temps</strong>.
        Il est expressément interdit :
        <ul style={{ margin: "2mm 0 2mm 6mm", padding: 0 }}>
          <li>De rendre les informations Klary accessibles à des tiers</li>
          <li>De les exploiter à des fins personnelles ou commerciales</li>
          <li>De communiquer ou publier toute information sans autorisation écrite préalable de Klary</li>
        </ul>
        Toute violation est susceptible de sanctions civiles (dommages-intérêts) et pénales (art. 162 CP, nLPD).
      </Section>

      {/* Encadré déblocage documents */}
      <div
        style={{
          border: "2px solid #F0651F",
          borderRadius: "2mm",
          padding: "5mm 6mm",
          marginTop: "6mm",
          marginBottom: "8mm",
          background: "#fff",
        }}
      >
        <div
          style={{
            fontSize: "9pt",
            fontWeight: 700,
            color: "#F0651F",
            textTransform: "uppercase",
            letterSpacing: "0.1em",
            marginBottom: "3mm",
          }}
        >
          ⚠ Déblocage des documents administratifs de sortie
        </div>
        <div style={{ fontSize: "9.5pt" }}>
          La signature de la présente convention <strong>débloque</strong> l'émission des documents suivants :
          <ul style={{ margin: "2mm 0", paddingLeft: "6mm" }}>
            <li>Certificat de travail qualifiant (Arbeitszeugnis)</li>
            <li>Attestation d'employeur pour l'assurance chômage (AC/SECO)</li>
            <li>Décompte de salaire final avec solde de tout compte</li>
            <li>Certificat de salaire annuel LAWID (début année suivante)</li>
            <li>Attestation de sortie LPP (via la caisse LPP)</li>
          </ul>
          <div
            style={{
              marginTop: "3mm",
              padding: "3mm 4mm",
              background: "#fef3c7",
              borderRadius: "1.5mm",
              color: "#78350f",
              fontSize: "9pt",
            }}
          >
            <strong>Sans signature de cette convention :</strong> aucun document
            de sortie ne sera émis, aucune attestation ne sera transmise à la
            caisse chômage, la procédure reste en pause indéfinie.
          </div>
        </div>
      </div>

      {/* Signatures */}
      <div style={{ marginTop: "10mm" }}>
        <div style={{ fontSize: "9.5pt", marginBottom: "8mm" }}>
          Fait à <strong>{city}</strong>, le <strong>{today}</strong>, en deux
          exemplaires originaux.
        </div>

        <table width="100%" cellSpacing="0" cellPadding="0">
          <tbody>
            <tr>
              <td style={{ width: "50%", paddingRight: "6mm", verticalAlign: "top" }}>
                <div style={{ fontSize: "8pt", color: "#6E6A8E", marginBottom: "16mm" }}>
                  Signature de l'agent
                </div>
                <div
                  style={{
                    borderTop: "1px solid #1A1660",
                    paddingTop: "2mm",
                    fontSize: "9pt",
                    fontWeight: 700,
                  }}
                >
                  {firstName} {lastName}
                </div>
                <div style={{ fontSize: "8pt", color: "#6E6A8E" }}>
                  (Signature manuscrite précédée de la mention « lu et approuvé »)
                </div>
              </td>
              <td style={{ width: "50%", paddingLeft: "6mm", verticalAlign: "top" }}>
                <div style={{ fontSize: "8pt", color: "#6E6A8E", marginBottom: "16mm" }}>
                  Signature Klary Sàrl
                </div>
                <div
                  style={{
                    borderTop: "1px solid #1A1660",
                    paddingTop: "2mm",
                    fontSize: "9pt",
                    fontWeight: 700,
                  }}
                >
                  Sacha Bacconnier
                </div>
                <div style={{ fontSize: "8pt", color: "#6E6A8E" }}>
                  Responsable d'agence
                </div>
              </td>
            </tr>
          </tbody>
        </table>
      </div>

      {/* Footer */}
      <div
        style={{
          position: "absolute",
          bottom: "10mm",
          left: "20mm",
          right: "20mm",
          fontSize: "7.5pt",
          color: "#A5A2C0",
          textAlign: "center",
          borderTop: "1px solid #DDD9E8",
          paddingTop: "3mm",
        }}
      >
        Klary Sàrl · Route de Lausanne 31 · 1052 Le Mont-sur-Lausanne · klary.ch
      </div>
    </div>
  );
}

function Section({
  number,
  title,
  children,
}: {
  number: number;
  title: string;
  children: React.ReactNode;
}) {
  return (
    <div style={{ marginBottom: "5mm" }}>
      <div
        style={{
          fontSize: "10pt",
          fontWeight: 700,
          color: "#1A1660",
          marginBottom: "1.5mm",
        }}
      >
        {number}. {title}
      </div>
      <div style={{ fontSize: "9.5pt", color: "#1F1B4B", textAlign: "justify" }}>
        {children}
      </div>
    </div>
  );
}
