/**
 * Convention de sortie Klary — 2 pages A4 portrait à imprimer.
 *
 * Page 1 : Header + identité employé + articles 1-3 (débauchage,
 *          concurrence, compte de caution)
 * Page 2 : Articles 4-6 (renonciation, restitution, confidentialité)
 *          + encart déblocage documents + signatures
 *
 * Basé sur les articles réels du contrat agent Klary v3.
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

const PAGE_STYLE = {
  width: "210mm",
  minHeight: "297mm",
  height: "297mm",
  padding: "16mm 20mm 14mm",
  fontFamily:
    "-apple-system, BlinkMacSystemFont, 'Segoe UI', 'Helvetica Neue', sans-serif",
  color: "#1A1660",
  boxShadow: "0 8px 40px rgba(26, 22, 96, 0.15)",
  fontSize: "9.5pt",
  lineHeight: 1.45,
  position: "relative" as const,
  background: "#fff",
  boxSizing: "border-box" as const,
};

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
    <div className="convention-container">
      {/* ═══════════════════════════════════════════════════════════
          PAGE 1/2 — Identité + Articles 1-3
          ═══════════════════════════════════════════════════════════ */}
      <div
        className="convention-page"
        style={{
          ...PAGE_STYLE,
          margin: "0 auto",
        }}
      >
        {/* Header */}
        <div
          style={{
            borderBottom: "3px solid #F0651F",
            paddingBottom: "5mm",
            marginBottom: "6mm",
          }}
        >
          <img
            src="/klary-logo-color.svg"
            alt="Klary"
            style={{ height: "12mm", width: "auto", display: "block" }}
          />
          <div style={{ marginTop: "4mm" }}>
            <div
              style={{
                fontSize: "16pt",
                fontWeight: 700,
                color: "#1A1660",
                lineHeight: 1.15,
              }}
            >
              Convention de sortie et rappel des obligations post-emploi
            </div>
            <div
              style={{
                fontSize: "8.5pt",
                color: "#6E6A8E",
                marginTop: "2mm",
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
            padding: "3.5mm 5mm",
            background: "#FAF5EF",
            borderRadius: "2mm",
            marginBottom: "5mm",
          }}
        >
          <table width="100%" cellSpacing="0" cellPadding="1.5">
            <tbody>
              <tr>
                <td style={{ width: "40%", color: "#6E6A8E", fontSize: "8.5pt" }}>Employé</td>
                <td style={{ fontWeight: 700, fontSize: "10pt" }}>
                  {firstName} {lastName}
                </td>
              </tr>
              <tr>
                <td style={{ color: "#6E6A8E", fontSize: "8.5pt" }}>Fonction</td>
                <td>{functionTitle}</td>
              </tr>
              {entryDate && (
                <tr>
                  <td style={{ color: "#6E6A8E", fontSize: "8.5pt" }}>Date d'entrée Klary</td>
                  <td>{entryDate}</td>
                </tr>
              )}
              <tr>
                <td style={{ color: "#6E6A8E", fontSize: "8.5pt" }}>Dernier jour travaillé</td>
                <td style={{ fontWeight: 700 }}>{lastWorkingDay}</td>
              </tr>
              <tr>
                <td style={{ color: "#6E6A8E", fontSize: "8.5pt" }}>Motif du départ</td>
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
          <ul style={{ margin: "1.5mm 0 1.5mm 5mm", padding: 0 }}>
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
          en assurance sur le canton de <strong>Vaud</strong> et les cantons
          limitrophes (<strong>Genève, Neuchâtel, Fribourg</strong>), dans les
          branches d'assurance sur lesquelles il a été formé et actif chez
          Klary.
        </Section>

        {/* Article 3 — Compte de caution */}
        <Section
          number={3}
          title="Compte de caution — blocage des commissions à venir (Annexe III)"
        >
          <p style={{ margin: 0 }}>
            Par <strong>sécurité financière de l'entreprise</strong> et en
            garantie du bon suivi des contrats conclus par l'agent auprès de
            ses clients, Klary conserve dans le{" "}
            <strong>COMPTE DE CAUTION</strong> :
          </p>
          <ul style={{ margin: "1mm 0 1mm 5mm", padding: 0 }}>
            <li>
              L'intégralité des commissions dues à l'agent au moment de la fin
              des rapports contractuels
            </li>
            <li>
              L'intégralité des <strong>commissions récurrentes à venir</strong>{" "}
              sur les contrats déjà signés par l'agent avec ses clients
            </li>
          </ul>
          <p style={{ margin: "1mm 0" }}>
            L'agent <strong>récupère ses commissions PROGRESSIVEMENT</strong>,
            à mesure que les contrats qu'il a conclus atteignent leur échéance
            de responsabilité contractuelle (typiquement <strong>3 ans</strong>{" "}
            en assurance suisse). Si un contrat est résilié ou annulé avant
            échéance, Klary utilise le compte de caution pour rembourser les
            commissions perçues et non acquises (art. 418p CO).
          </p>
          <p style={{ margin: "1mm 0" }}>
            À l'issue de la période de responsabilité (
            <strong>3 ans à compter de la fin du contrat d'agence</strong>), le{" "}
            <strong>solde éventuel</strong> est reversé à l'agent, déduction
            faite des annulations et remboursements survenus.
          </p>
          {isAggravated && (
            <div
              style={{
                marginTop: "1.5mm",
                padding: "2.5mm 3.5mm",
                background: "#fff5f5",
                borderLeft: "3px solid #dc2626",
                borderRadius: "1.5mm",
                fontSize: "9pt",
              }}
            >
              <strong>Spécificité — {reasonLabel.toLowerCase()} :</strong> en
              cas de faute grave, abandon de poste ou résiliation anticipée
              sans respect des délais contractuels, le solde du compte de
              caution peut être <strong>retenu en totalité</strong> et affecté
              au règlement des dommages-intérêts dus à Klary (art. 337c CO +
              Annexe III art. 3).
            </div>
          )}
        </Section>

        {/* Footer page 1 */}
        <div
          style={{
            position: "absolute",
            bottom: "6mm",
            left: "20mm",
            right: "20mm",
            fontSize: "7pt",
            color: "#A5A2C0",
            display: "flex",
            justifyContent: "space-between",
            borderTop: "1px solid #DDD9E8",
            paddingTop: "2mm",
          }}
        >
          <span>Klary Sàrl · Convention de sortie {firstName} {lastName}</span>
          <span>Page 1 / 2 — suite au verso</span>
        </div>
      </div>

      {/* ═══════════════════════════════════════════════════════════
          PAGE 2/2 — Articles 4-6 + déblocage + signatures
          ═══════════════════════════════════════════════════════════ */}
      <div
        className="convention-page"
        style={{
          ...PAGE_STYLE,
          margin: "10mm auto 0",
          pageBreakBefore: "always",
          breakBefore: "page",
        }}
      >
        {/* Header compact page 2 */}
        <div
          style={{
            display: "flex",
            justifyContent: "space-between",
            alignItems: "center",
            borderBottom: "2px solid #F0651F",
            paddingBottom: "3mm",
            marginBottom: "5mm",
          }}
        >
          <img
            src="/klary-logo-color.svg"
            alt="Klary"
            style={{ height: "8mm", width: "auto", display: "block" }}
          />
          <div style={{ fontSize: "9pt", color: "#6E6A8E", textAlign: "right" }}>
            Convention de sortie<br />
            <strong style={{ color: "#1A1660" }}>{firstName} {lastName}</strong> — {reasonLabel}
          </div>
        </div>

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
          <div style={{ marginTop: "1.5mm", columns: 2 as any, columnGap: "6mm", fontSize: "9pt" }}>
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
          L'obligation de confidentialité{" "}
          <strong>subsiste après la fin du contrat sans limitation dans le temps</strong>.
          Il est expressément interdit de rendre les informations Klary
          accessibles à des tiers, de les exploiter à des fins personnelles ou
          commerciales, ou de communiquer/publier toute information sans
          autorisation écrite préalable de Klary. Toute violation est
          susceptible de sanctions civiles (dommages-intérêts) et pénales
          (art. 162 CP, nLPD).
        </Section>

        {/* Encadré déblocage documents */}
        <div
          style={{
            border: "2px solid #F0651F",
            borderRadius: "2mm",
            padding: "4mm 5mm",
            marginTop: "4mm",
            marginBottom: "6mm",
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
              marginBottom: "2mm",
            }}
          >
            ⚠ Déblocage des documents administratifs de sortie
          </div>
          <div style={{ fontSize: "9pt" }}>
            La signature de la présente convention <strong>débloque</strong>{" "}
            l'émission des documents suivants :
            <ul style={{ margin: "1.5mm 0", paddingLeft: "5mm" }}>
              <li>Certificat de travail qualifiant (Arbeitszeugnis)</li>
              <li>Attestation d'employeur pour l'assurance chômage (AC / SECO)</li>
              <li>Décompte de salaire final avec solde de tout compte</li>
              <li>Certificat de salaire annuel LAWID (début année suivante)</li>
              <li>Attestation de sortie LPP (via la caisse LPP)</li>
            </ul>
            <div
              style={{
                marginTop: "2mm",
                padding: "2.5mm 3.5mm",
                background: "#fef3c7",
                borderRadius: "1.5mm",
                color: "#78350f",
                fontSize: "8.5pt",
              }}
            >
              <strong>Sans signature de cette convention :</strong> aucun
              document de sortie ne sera émis, aucune attestation ne sera
              transmise à la caisse chômage, la procédure reste en pause
              indéfinie.
            </div>
          </div>
        </div>

        {/* Signatures */}
        <div style={{ marginTop: "6mm" }}>
          <div style={{ fontSize: "9pt", marginBottom: "6mm" }}>
            Fait à <strong>{city}</strong>, le <strong>{today}</strong>, en
            deux exemplaires originaux (un pour l'agent, un pour Klary).
          </div>

          <table width="100%" cellSpacing="0" cellPadding="0">
            <tbody>
              <tr>
                <td style={{ width: "50%", paddingRight: "5mm", verticalAlign: "top" }}>
                  <div style={{ fontSize: "8pt", color: "#6E6A8E", marginBottom: "18mm" }}>
                    Signature de l'agent
                  </div>
                  <div
                    style={{
                      borderTop: "1px solid #1A1660",
                      paddingTop: "1.5mm",
                      fontSize: "9pt",
                      fontWeight: 700,
                    }}
                  >
                    {firstName} {lastName}
                  </div>
                  <div style={{ fontSize: "7.5pt", color: "#6E6A8E" }}>
                    (Signature manuscrite précédée de la mention « lu et approuvé »)
                  </div>
                </td>
                <td style={{ width: "50%", paddingLeft: "5mm", verticalAlign: "top" }}>
                  <div style={{ fontSize: "8pt", color: "#6E6A8E", marginBottom: "18mm" }}>
                    Signature Klary Sàrl
                  </div>
                  <div
                    style={{
                      borderTop: "1px solid #1A1660",
                      paddingTop: "1.5mm",
                      fontSize: "9pt",
                      fontWeight: 700,
                    }}
                  >
                    Sacha Bacconnier
                  </div>
                  <div style={{ fontSize: "7.5pt", color: "#6E6A8E" }}>
                    Responsable d'agence
                  </div>
                </td>
              </tr>
            </tbody>
          </table>
        </div>

        {/* Footer page 2 */}
        <div
          style={{
            position: "absolute",
            bottom: "6mm",
            left: "20mm",
            right: "20mm",
            fontSize: "7pt",
            color: "#A5A2C0",
            display: "flex",
            justifyContent: "space-between",
            borderTop: "1px solid #DDD9E8",
            paddingTop: "2mm",
          }}
        >
          <span>Klary Sàrl · Route de Lausanne 31 · 1052 Le Mont-sur-Lausanne · klary.ch</span>
          <span>Page 2 / 2</span>
        </div>
      </div>

      {/* CSS d'impression — chaque .convention-page = 1 page A4 */}
      <style>{`
        @media print {
          .convention-container {
            margin: 0 !important;
            padding: 0 !important;
          }
          .convention-page {
            margin: 0 !important;
            box-shadow: none !important;
            page-break-after: always;
            break-after: page;
          }
          .convention-page:last-child {
            page-break-after: auto;
            break-after: auto;
          }
        }
      `}</style>
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
    <div style={{ marginBottom: "4mm" }}>
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
      <div style={{ fontSize: "9pt", color: "#1F1B4B", textAlign: "justify" }}>
        {children}
      </div>
    </div>
  );
}
