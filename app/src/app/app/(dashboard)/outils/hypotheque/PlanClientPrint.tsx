"use client";

import { formatCHF, type DossierClient, type SyntheseCalculs } from "@/lib/hypotheque/calculs";

/**
 * Layout A4 optimisé impression / PDF pour remettre au client à la fin du RDV.
 * S'affiche uniquement via la classe .print-only (media print).
 */
export function PlanClientPrint({
  dossier,
  s,
}: {
  dossier: DossierClient;
  s: SyntheseCalculs;
}) {
  const nomClient = [dossier.clientPrenom, dossier.clientNom].filter(Boolean).join(" ") || "Client";
  const dateJour = new Date().toLocaleDateString("fr-CH", {
    day: "2-digit",
    month: "long",
    year: "numeric",
  });

  return (
    <div className="ppl-print">
      <style jsx global>{`
        .ppl-print {
          display: none;
        }
        @media print {
          @page {
            size: A4;
            margin: 15mm 12mm;
          }
          body * {
            visibility: hidden;
          }
          .ppl-print,
          .ppl-print * {
            visibility: visible;
          }
          .ppl-print {
            position: absolute;
            top: 0;
            left: 0;
            display: block;
            width: 100%;
            font-family: -apple-system, "Helvetica Neue", Helvetica, sans-serif;
            color: #100D32;
            font-size: 11pt;
            line-height: 1.45;
          }
          .ppl-print h1 {
            font-size: 22pt;
            color: #100D32;
            margin: 0 0 6px 0;
            font-weight: 800;
          }
          .ppl-print h2 {
            font-size: 13pt;
            color: #100D32;
            margin: 18px 0 8px 0;
            padding-bottom: 4px;
            border-bottom: 2px solid #F0651F;
            text-transform: uppercase;
            letter-spacing: 0.05em;
          }
          .ppl-print .eyebrow {
            font-size: 9pt;
            color: #F0651F;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.15em;
            margin-bottom: 4px;
          }
          .ppl-print .meta {
            font-size: 9pt;
            color: #6E6A8E;
            margin-bottom: 20px;
          }
          .ppl-print table {
            width: 100%;
            border-collapse: collapse;
            margin: 6px 0 14px 0;
            font-size: 10pt;
          }
          .ppl-print th,
          .ppl-print td {
            border-bottom: 1px solid #E5E4EA;
            padding: 6px 8px;
            text-align: left;
            vertical-align: top;
          }
          .ppl-print th {
            background: #FAF7EE;
            font-weight: 700;
            color: #100D32;
            font-size: 9pt;
            text-transform: uppercase;
            letter-spacing: 0.03em;
          }
          .ppl-print .num {
            text-align: right;
            font-weight: 700;
            color: #100D32;
            font-variant-numeric: tabular-nums;
          }
          .ppl-print .highlight {
            background: #F0651F;
            color: #fff;
            padding: 10px 14px;
            border-radius: 6px;
            margin: 12px 0;
            font-size: 11pt;
          }
          .ppl-print .highlight strong {
            font-size: 18pt;
            display: block;
            margin-top: 3px;
          }
          .ppl-print .verdict-ok {
            background: #ECFDF5;
            border-left: 4px solid #10B981;
            padding: 10px 14px;
            margin: 12px 0;
            color: #065F46;
            font-size: 10pt;
          }
          .ppl-print .verdict-nok {
            background: #FEF2F2;
            border-left: 4px solid #EF4444;
            padding: 10px 14px;
            margin: 12px 0;
            color: #991B1B;
            font-size: 10pt;
          }
          .ppl-print .signature-row {
            margin-top: 30px;
            display: flex;
            justify-content: space-between;
            gap: 40px;
          }
          .ppl-print .signature-box {
            flex: 1;
            border-top: 1px solid #100D32;
            padding-top: 6px;
            font-size: 9pt;
            color: #6E6A8E;
          }
          .ppl-print .footer {
            position: fixed;
            bottom: 8mm;
            left: 12mm;
            right: 12mm;
            font-size: 8pt;
            color: #6E6A8E;
            border-top: 1px solid #E5E4EA;
            padding-top: 4px;
            text-align: center;
          }
          .ppl-print .disclaimer {
            font-size: 8pt;
            color: #6E6A8E;
            font-style: italic;
            margin-top: 16px;
            padding: 8px;
            background: #FAF7EE;
            border-radius: 4px;
          }
        }
      `}</style>

      {/* En-tête */}
      <div className="eyebrow">Plan personnel · Premier Plan Logement</div>
      <h1>Votre projet d&apos;accession à la propriété</h1>
      <div className="meta">
        Préparé pour <strong>{nomClient}</strong> · {dateJour} · Klary Sàrl (intermédiaire lié Assura SA)
      </div>

      {/* Projet visé */}
      <h2>Votre projet</h2>
      <table>
        <tbody>
          <tr>
            <th style={{ width: "45%" }}>Type de bien</th>
            <td>{dossier.typeBien || "À définir"}</td>
          </tr>
          <tr>
            <th>Localité visée</th>
            <td>{dossier.localite || "À définir"}</td>
          </tr>
          <tr>
            <th>Prix du bien visé</th>
            <td className="num">{formatCHF(dossier.prixBien)} CHF</td>
          </tr>
          <tr>
            <th>Revenu annuel brut</th>
            <td className="num">{formatCHF(dossier.revenuAnnuel)} CHF</td>
          </tr>
          <tr>
            <th>Loyer actuel</th>
            <td className="num">{formatCHF(dossier.loyerMensuel)} CHF /mois</td>
          </tr>
        </tbody>
      </table>

      {/* Ce que dit la banque */}
      <h2>Ce que dit la banque</h2>
      <table>
        <tbody>
          <tr>
            <th style={{ width: "45%" }}>Apport nécessaire (20 %)</th>
            <td className="num">{formatCHF(s.apport.total)} CHF</td>
          </tr>
          <tr>
            <th>Dont apport « dur » obligatoire (10 %)</th>
            <td className="num">{formatCHF(s.apport.dur)} CHF</td>
          </tr>
          <tr>
            <th>Charges annuelles théoriques (5,89 %)</th>
            <td className="num">{formatCHF(s.chargesTheoriques)} CHF /an</td>
          </tr>
          <tr>
            <th>Revenu annuel requis (max 33 %)</th>
            <td className="num">{formatCHF(s.revenuRequis)} CHF</td>
          </tr>
          <tr>
            <th>Votre capacité d&apos;achat maximale</th>
            <td className="num">{formatCHF(s.capaciteAchatMax)} CHF</td>
          </tr>
        </tbody>
      </table>

      {s.projetPasse ? (
        <div className="verdict-ok">
          ✓ <strong>Le projet passe côté banque.</strong> Votre revenu couvre les charges théoriques du bien visé. Marge de capacité : {formatCHF(s.ecartCapacite)} CHF.
        </div>
      ) : (
        <div className="verdict-nok">
          ✗ <strong>Le projet actuel dépasse votre capacité.</strong> Écart de {formatCHF(Math.abs(s.ecartCapacite))} CHF. Deux leviers : ajuster le prix cible à {formatCHF(s.capaciteAchatMax)} CHF, ou constituer un revenu complémentaire.
        </div>
      )}

      {/* Le loyer perdu */}
      <div className="highlight">
        Loyer qui « part en fumée » sur {dossier.anneesDuree} ans
        <strong>{formatCHF(s.loyerPerdu)} CHF</strong>
      </div>

      {/* Le plan proposé */}
      <h2>Votre plan d&apos;épargne 3ᵉ pilier proposé</h2>
      <table>
        <tbody>
          <tr>
            <th style={{ width: "45%" }}>Versement mensuel proposé</th>
            <td className="num">{formatCHF(dossier.versementMensuel)} CHF /mois</td>
          </tr>
          <tr>
            <th>Économie fiscale estimée (fourchette)</th>
            <td className="num">{formatCHF(s.economieFiscale.min)} à {formatCHF(s.economieFiscale.max)} CHF /an</td>
          </tr>
          <tr>
            <th>Effort réel après économie d&apos;impôt</th>
            <td className="num">{formatCHF(s.effortReel.net)} CHF /mois</td>
          </tr>
          <tr>
            <th>Capital constitué sur {dossier.anneesDuree} ans (rendement 3 % non garanti)</th>
            <td className="num">{formatCHF(s.capitalFutur.avecRendement)} CHF</td>
          </tr>
          <tr>
            <th>Capital sans rendement (garanti minimum)</th>
            <td className="num">{formatCHF(s.capitalFutur.sansRendement)} CHF</td>
          </tr>
          <tr style={{ background: "#FAF7EE" }}>
            <th>Bilan net en votre faveur</th>
            <td className="num">+{formatCHF(s.bilanNet.benefice)} CHF</td>
          </tr>
        </tbody>
      </table>

      {/* 5 leviers */}
      <h2>Ce que votre 3ᵉ pilier vous apporte</h2>
      <table>
        <tbody>
          <tr>
            <th style={{ width: "30%" }}>🏠 Accession propriété</th>
            <td>Un dossier que la banque prend au sérieux. Nantissement possible pour compléter l&apos;apport sans liquider le capital.</td>
          </tr>
          <tr>
            <th>📈 Épargne qui travaille</th>
            <td>Le capital fructifie pendant que vous le gardez. Vous restez propriétaire de votre épargne à tout moment.</td>
          </tr>
          <tr>
            <th>💰 Fiscalité</th>
            <td>1 500 à 2 500 CHF d&apos;impôt en moins par an selon votre canton et votre revenu.</td>
          </tr>
          <tr>
            <th>🛡 Protection famille</th>
            <td>Couverture décès et incapacité de gain dès le 1ᵉʳ franc versé.</td>
          </tr>
          <tr>
            <th>⚖ Succession optimisée</th>
            <td>Transmission directe au bénéficiaire désigné, hors succession classique.</td>
          </tr>
        </tbody>
      </table>

      {/* Disclaimer */}
      <div className="disclaimer">
        <strong>Information importante :</strong> Ce document est un plan indicatif préparé sur la base des informations que vous nous avez communiquées. Les économies fiscales sont estimées et dépendent de votre situation exacte (canton, revenu, déductions). Le rendement de 3 % est prudent et n&apos;est pas garanti. Le retrait anticipé du 3ᵉ pilier n&apos;est possible que pour certains motifs prévus par la loi (art. 3 OPP 3). Vous disposez d&apos;un droit de rétractation de 14 jours après signature de la proposition (art. 2a LCA). Klary Sàrl est intermédiaire lié au sens de l&apos;art. 40 al. 3 LSA avec Assura SA et Assura-Basis SA.
      </div>

      {/* Signature */}
      <div className="signature-row">
        <div className="signature-box">
          <div><strong>Le client</strong></div>
          <div>{nomClient}</div>
          <div style={{ marginTop: "40px", fontSize: "8pt" }}>Signature</div>
        </div>
        <div className="signature-box">
          <div><strong>Votre conseiller Klary</strong></div>
          <div>Date : {dateJour}</div>
          <div style={{ marginTop: "40px", fontSize: "8pt" }}>Signature</div>
        </div>
      </div>

      <div className="footer">
        Klary Sàrl · Route de Lausanne 31 · 1052 Le Mont-sur-Lausanne · admin@klary.ch · www.klary.ch<br />
        IDE CHE-275.800.008 · Intermédiaire lié Assura SA (art. 40 al. 3 LSA)
      </div>
    </div>
  );
}
