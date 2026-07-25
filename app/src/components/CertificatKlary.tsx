/**
 * Certificat Klary — rendu HTML A4 portrait print-ready.
 *
 * Design v2 :
 *   • Vrai logo Klary (image /klary-logo.png)
 *   • Watermark = même logo, centré, opacité 0.05 (filigrane discret)
 *   • Typographie : serif italique pour le titre, sans-serif bold pour le nom
 *   • Aucun trilingue générique, aucun texte répété "CERTIFICAT" vertical
 *   • Palette : navy #1A1660 + orange #F0651F + cream #FAF5EF
 *   • Signature responsable + numéro certif discret bas droite
 *
 * Usable en :
 *   - Aperçu HTML (page /certifications/[id]/apercu)
 *   - Impression navigateur → PDF (Cmd+P / Ctrl+P)
 *   - Futur PDF via puppeteer.print côté serveur
 */

export type CertificatKlaryProps = {
  agentName: string;
  agentDateOfBirth?: string;
  agentPostalAddress?: string;
  moduleTitle: string;
  moduleTopics?: string[];
  score: number;
  certNumber: string;
  issuedAt: string;
  validUntil: string;
  city?: string;
  signatoryName?: string;
  signatoryTitle?: string;
  /** Chemin logo Klary (par défaut /klary-logo-color.svg — vrai logo officiel couleurs) */
  logoSrc?: string;
  /** Chemin logo pour le watermark de fond (par défaut icône K seule) */
  watermarkSrc?: string;
};

export function CertificatKlary({
  agentName,
  agentDateOfBirth,
  agentPostalAddress,
  moduleTitle,
  moduleTopics = [],
  score,
  certNumber,
  issuedAt,
  validUntil,
  city = "Le Mont-sur-Lausanne",
  signatoryName = "Sacha Bacconnier",
  signatoryTitle = "Responsable d'agence — Klary Sàrl",
  logoSrc = "/klary-logo-color.svg",
  watermarkSrc = "/klary-icon.svg",
}: CertificatKlaryProps) {
  const issuedDate = new Date(issuedAt).toLocaleDateString("fr-CH", {
    day: "numeric",
    month: "long",
    year: "numeric",
  });
  const validDate = new Date(validUntil).toLocaleDateString("fr-CH", {
    day: "numeric",
    month: "long",
    year: "numeric",
  });

  return (
    <div
      className="certificat-klary relative bg-white mx-auto overflow-hidden"
      style={{
        width: "210mm",
        minHeight: "297mm",
        fontFamily:
          "-apple-system, BlinkMacSystemFont, 'Segoe UI', 'Helvetica Neue', Arial, sans-serif",
        color: "#1A1660",
        boxShadow: "0 8px 40px rgba(26, 22, 96, 0.15)",
      }}
    >
      {/* ═══════════════════════════════════════════════════════════
          FOND SÉCURISÉ — 3 couches superposées :
          1) Pattern K répété sur toute la surface (opacité ultra-faible)
          2) Filigrane diagonal "KLARY · CERTIFIÉ" répété
          3) Grille de sécurité (fines lignes croisées navy/orange)
          ═══════════════════════════════════════════════════════════ */}

      {/* Couche 1 : icône K répétée en tile */}
      <div
        aria-hidden
        style={{
          position: "absolute",
          inset: 0,
          backgroundImage: `url(${watermarkSrc})`,
          backgroundRepeat: "repeat",
          backgroundSize: "38mm 38mm",
          backgroundPosition: "center",
          opacity: 0.018,
          pointerEvents: "none",
          zIndex: 0,
        }}
      />

      {/* Couche 2 : filigrane texte diagonal "KLARY · CERTIFIÉ" */}
      <div
        aria-hidden
        style={{
          position: "absolute",
          inset: "-30%",
          width: "160%",
          height: "160%",
          transform: "rotate(-28deg)",
          transformOrigin: "center",
          opacity: 0.032,
          pointerEvents: "none",
          zIndex: 0,
          display: "flex",
          flexDirection: "column",
          justifyContent: "space-around",
          overflow: "hidden",
        }}
      >
        {Array.from({ length: 14 }).map((_, i) => (
          <div
            key={i}
            style={{
              fontSize: "18pt",
              fontWeight: 700,
              color: i % 2 === 0 ? "#1A1660" : "#F0651F",
              letterSpacing: "0.4em",
              whiteSpace: "nowrap",
              textTransform: "uppercase",
              fontFamily:
                "-apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif",
            }}
          >
            KLARY · CERTIFIÉ · KLARY · CERTIFIÉ · KLARY · CERTIFIÉ · KLARY ·
            CERTIFIÉ · KLARY · CERTIFIÉ · KLARY · CERTIFIÉ · KLARY · CERTIFIÉ
          </div>
        ))}
      </div>

      {/* Couche 3 : grille de sécurité en diamant fin (papier certificat) */}
      <div
        aria-hidden
        style={{
          position: "absolute",
          inset: 0,
          opacity: 0.02,
          pointerEvents: "none",
          zIndex: 0,
          backgroundImage: `
            repeating-linear-gradient(45deg, #1A1660 0 1px, transparent 1px 6mm),
            repeating-linear-gradient(-45deg, #F0651F 0 1px, transparent 1px 6mm)
          `,
        }}
      />

      {/* ── Cadre décoratif : liseré orange fin en haut + bas ── */}
      <div
        style={{
          position: "absolute",
          top: 0,
          left: 0,
          right: 0,
          height: "6mm",
          background: "#F0651F",
          zIndex: 1,
        }}
      />
      <div
        style={{
          position: "absolute",
          top: "6mm",
          left: 0,
          right: 0,
          height: "1px",
          background: "#1A1660",
          opacity: 0.2,
          zIndex: 1,
        }}
      />
      <div
        style={{
          position: "absolute",
          bottom: 0,
          left: 0,
          right: 0,
          height: "6mm",
          background: "#1A1660",
          zIndex: 1,
        }}
      />
      <div
        style={{
          position: "absolute",
          bottom: "6mm",
          left: 0,
          right: 0,
          height: "1px",
          background: "#F0651F",
          opacity: 0.4,
          zIndex: 1,
        }}
      />

      {/* ── Contenu ── */}
      <div
        style={{
          position: "relative",
          padding: "22mm 22mm 18mm",
          zIndex: 2,
        }}
      >
        {/* Logo Klary haut centré */}
        <div style={{ textAlign: "center", marginBottom: "10mm" }}>
          {/* eslint-disable-next-line @next/next/no-img-element */}
          <img
            src={logoSrc}
            alt="Klary"
            style={{
              height: "18mm",
              width: "auto",
              display: "inline-block",
            }}
          />
          <div
            style={{
              fontSize: "8pt",
              color: "#6E6A8E",
              fontWeight: 600,
              letterSpacing: "0.3em",
              textTransform: "uppercase",
              marginTop: "4px",
            }}
          >
            Courtage en assurance · Suisse
          </div>
        </div>

        {/* Titre principal — serif italique élégant */}
        <div
          style={{
            textAlign: "center",
            marginBottom: "12mm",
            marginTop: "4mm",
          }}
        >
          <div
            style={{
              fontFamily:
                "'Georgia', 'Times New Roman', 'Playfair Display', serif",
              fontStyle: "italic",
              fontWeight: 400,
              fontSize: "34pt",
              color: "#1A1660",
              lineHeight: 1.05,
              letterSpacing: "-0.02em",
            }}
          >
            Certificat de compétence
          </div>
          <div
            style={{
              width: "40mm",
              height: "2px",
              background: "#F0651F",
              margin: "8mm auto 0",
            }}
          />
        </div>

        {/* Nom bénéficiaire */}
        <div style={{ textAlign: "center", marginBottom: "14mm" }}>
          <div
            style={{
              fontSize: "9pt",
              color: "#6E6A8E",
              fontWeight: 700,
              letterSpacing: "0.25em",
              textTransform: "uppercase",
              marginBottom: "6mm",
            }}
          >
            Décerné à
          </div>
          <div
            style={{
              fontSize: "30pt",
              fontWeight: 700,
              color: "#1A1660",
              lineHeight: 1.1,
              letterSpacing: "-0.02em",
            }}
          >
            {agentName}
          </div>
          {(agentDateOfBirth || agentPostalAddress) && (
            <div
              style={{
                fontSize: "10pt",
                color: "#6E6A8E",
                marginTop: "6px",
                lineHeight: 1.5,
              }}
            >
              {agentDateOfBirth && <>Né(e) le {agentDateOfBirth}</>}
              {agentDateOfBirth && agentPostalAddress && " · "}
              {agentPostalAddress}
            </div>
          )}
        </div>

        {/* Texte de mention */}
        <div
          style={{
            textAlign: "center",
            fontSize: "12pt",
            color: "#1F1B4B",
            marginBottom: "8mm",
            fontStyle: "italic",
            lineHeight: 1.5,
          }}
        >
          pour avoir validé avec succès le module de formation interne
        </div>

        {/* Module certifié — bloc central proéminent */}
        <div
          style={{
            textAlign: "center",
            padding: "8mm 6mm",
            background:
              "linear-gradient(180deg, #FAF5EF 0%, #FFFFFF 100%)",
            border: "1px solid rgba(240, 101, 31, 0.25)",
            borderRadius: "3mm",
            marginBottom: "10mm",
          }}
        >
          <div
            style={{
              fontSize: "9pt",
              color: "#F0651F",
              fontWeight: 700,
              letterSpacing: "0.2em",
              textTransform: "uppercase",
              marginBottom: "4mm",
            }}
          >
            Module certifié
          </div>
          <div
            style={{
              fontSize: "22pt",
              fontWeight: 700,
              color: "#1A1660",
              lineHeight: 1.2,
              letterSpacing: "-0.01em",
            }}
          >
            {moduleTitle}
          </div>
        </div>

        {/* Sujets examinés */}
        {moduleTopics.length > 0 && (
          <div style={{ marginBottom: "10mm" }}>
            <div
              style={{
                fontSize: "9pt",
                color: "#6E6A8E",
                fontWeight: 700,
                letterSpacing: "0.15em",
                textTransform: "uppercase",
                marginBottom: "4mm",
                textAlign: "center",
              }}
            >
              Sujets examinés
            </div>
            <div
              style={{
                maxWidth: "150mm",
                margin: "0 auto",
                columnCount: moduleTopics.length > 4 ? 1 : 1,
              }}
            >
              <ul
                style={{
                  listStyle: "none",
                  padding: 0,
                  margin: 0,
                  fontSize: "10.5pt",
                  lineHeight: 1.7,
                }}
              >
                {moduleTopics.map((topic, i) => (
                  <li
                    key={i}
                    style={{
                      paddingLeft: "10mm",
                      position: "relative",
                      color: "#1F1B4B",
                    }}
                  >
                    <span
                      style={{
                        position: "absolute",
                        left: "4mm",
                        top: "6px",
                        width: "6px",
                        height: "6px",
                        background: "#F0651F",
                        borderRadius: "50%",
                      }}
                    />
                    {topic}
                  </li>
                ))}
              </ul>
            </div>
          </div>
        )}

        {/* Score + Validité */}
        <div
          style={{
            display: "flex",
            gap: "8mm",
            marginBottom: "14mm",
            justifyContent: "center",
          }}
        >
          <div
            style={{
              flex: "0 0 60mm",
              padding: "6mm 8mm",
              border: "1px solid #DDD9E8",
              borderRadius: "2mm",
              textAlign: "center",
              background: "#fff",
            }}
          >
            <div
              style={{
                fontSize: "8pt",
                color: "#6E6A8E",
                fontWeight: 700,
                letterSpacing: "0.2em",
                textTransform: "uppercase",
                marginBottom: "2mm",
              }}
            >
              Score obtenu
            </div>
            <div
              style={{
                fontSize: "26pt",
                fontWeight: 700,
                color: "#1A1660",
                lineHeight: 1,
              }}
            >
              {score}%
            </div>
          </div>
          <div
            style={{
              flex: "0 0 60mm",
              padding: "6mm 8mm",
              border: "1px solid #DDD9E8",
              borderRadius: "2mm",
              textAlign: "center",
              background: "#fff",
            }}
          >
            <div
              style={{
                fontSize: "8pt",
                color: "#6E6A8E",
                fontWeight: 700,
                letterSpacing: "0.2em",
                textTransform: "uppercase",
                marginBottom: "2mm",
              }}
            >
              Valide jusqu'au
            </div>
            <div
              style={{
                fontSize: "15pt",
                fontWeight: 700,
                color: "#1A1660",
                lineHeight: 1.2,
              }}
            >
              {validDate}
            </div>
          </div>
        </div>

        {/* Lieu + date + signature — bloc bas */}
        <div style={{ marginTop: "auto" }}>
          <div
            style={{
              fontSize: "10pt",
              color: "#6E6A8E",
              marginBottom: "18mm",
              textAlign: "center",
              fontStyle: "italic",
            }}
          >
            {city}, le {issuedDate}
          </div>

          <div
            style={{
              display: "flex",
              justifyContent: "space-between",
              alignItems: "flex-end",
              gap: "10mm",
            }}
          >
            {/* Signature responsable */}
            <div style={{ flex: 1 }}>
              <div
                style={{
                  height: "12mm",
                  marginBottom: "2mm",
                  /* espace pour signature manuscrite scannée future */
                }}
              />
              <div
                style={{
                  width: "70mm",
                  height: "1px",
                  background: "#1A1660",
                  opacity: 0.4,
                  marginBottom: "3mm",
                }}
              />
              <div
                style={{
                  fontSize: "11pt",
                  fontWeight: 700,
                  color: "#1A1660",
                  letterSpacing: "-0.01em",
                }}
              >
                {signatoryName}
              </div>
              <div
                style={{
                  fontSize: "9pt",
                  color: "#6E6A8E",
                  marginTop: "1px",
                }}
              >
                {signatoryTitle}
              </div>
            </div>

            {/* Numéro certificat — discret bas droite */}
            <div style={{ textAlign: "right", flexShrink: 0 }}>
              <div
                style={{
                  fontSize: "7pt",
                  color: "#6E6A8E",
                  letterSpacing: "0.2em",
                  textTransform: "uppercase",
                  marginBottom: "2px",
                }}
              >
                Numéro de certificat
              </div>
              <div
                style={{
                  fontSize: "10pt",
                  fontWeight: 700,
                  color: "#1A1660",
                  fontFamily:
                    "'SFMono-Regular', 'Consolas', 'Menlo', monospace",
                  letterSpacing: "0.02em",
                }}
              >
                {certNumber}
              </div>
              <div
                style={{
                  fontSize: "7pt",
                  color: "#6E6A8E",
                  marginTop: "6px",
                  maxWidth: "50mm",
                }}
              >
                Vérifiable sur klary.ch/verifier
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}
