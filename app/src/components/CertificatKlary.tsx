/**
 * Certificat Klary — rendu HTML print-ready (format A4 portrait).
 *
 * Inspiration :
 *   • Swiss Life Select (portrait, filigrane texte répété, double liseré, gros nom)
 *   • Assura Diplôme d'excellence (signature multiple, sceau, hiérarchie visuelle)
 * Charte Klary : navy #1A1660 · orange #F0651F · cream #FAF5EF
 *
 * Usable en :
 *   - Aperçu HTML (page /certifications/[id])
 *   - Impression (@media print → cache décors non-print)
 *   - Futur PDF via react-pdf ou puppeteer.print
 */

export type CertificatKlaryProps = {
  agentName: string;             // "Habib Agharbi"
  agentDateOfBirth?: string;      // "12 janvier 1998"
  agentPostalAddress?: string;    // "Route de Lausanne 110h, 1197 Prangins"
  moduleTitle: string;            // "Assurance Maladie (LAMal + LCA)"
  moduleTopics?: string[];        // ["LAMal — bases", "LCA hospitalière", ...]
  score: number;                  // 87
  certNumber: string;             // "KLARY-2026-MAL-0042"
  issuedAt: string;               // ISO date
  validUntil: string;             // ISO date
  city?: string;                  // "Le Mont-sur-Lausanne"
  signatoryName?: string;         // "Sacha Bacconnier"
  signatoryTitle?: string;        // "Responsable d'agence"
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
      className="certificat-klary relative bg-white mx-auto"
      style={{
        width: "210mm",
        minHeight: "297mm",
        padding: "18mm 20mm",
        fontFamily:
          "-apple-system, BlinkMacSystemFont, 'Segoe UI', 'Helvetica Neue', sans-serif",
        color: "#1A1660",
        boxShadow: "0 8px 40px rgba(26, 22, 96, 0.15)",
      }}
    >
      {/* Double liseré haut */}
      <div
        style={{
          position: "absolute",
          top: "8mm",
          left: "20mm",
          right: "20mm",
          height: "2px",
          background: "#F0651F",
        }}
      />
      <div
        style={{
          position: "absolute",
          top: "12mm",
          left: "20mm",
          right: "20mm",
          height: "1px",
          background: "#F0651F",
          opacity: 0.5,
        }}
      />

      {/* Double liseré bas */}
      <div
        style={{
          position: "absolute",
          bottom: "12mm",
          left: "20mm",
          right: "20mm",
          height: "1px",
          background: "#F0651F",
          opacity: 0.5,
        }}
      />
      <div
        style={{
          position: "absolute",
          bottom: "8mm",
          left: "20mm",
          right: "20mm",
          height: "2px",
          background: "#F0651F",
        }}
      />

      {/* Filigrane CERTIFICAT répété (vertical, opacité faible) */}
      <div
        aria-hidden
        style={{
          position: "absolute",
          top: 0,
          right: 0,
          width: "50mm",
          height: "100%",
          overflow: "hidden",
          pointerEvents: "none",
          opacity: 0.06,
          background:
            "repeating-linear-gradient(0deg, transparent 0 30px, #F0651F 30px 31px)",
        }}
      />
      <div
        aria-hidden
        style={{
          position: "absolute",
          top: "20mm",
          right: "-8mm",
          transform: "rotate(90deg)",
          transformOrigin: "top right",
          fontSize: "14pt",
          fontWeight: 700,
          letterSpacing: "0.2em",
          color: "#F0651F",
          opacity: 0.08,
          whiteSpace: "nowrap",
          pointerEvents: "none",
        }}
      >
        CERTIFICAT · CERTIFICAT · CERTIFICAT · CERTIFICAT · CERTIFICAT ·
        CERTIFICAT · CERTIFICAT
      </div>

      {/* Header — triple titre */}
      <div style={{ marginTop: "12mm", marginBottom: "14mm" }}>
        <div
          style={{
            fontSize: "34pt",
            fontWeight: 800,
            lineHeight: 1.05,
            color: "#F0651F",
            letterSpacing: "-0.01em",
          }}
        >
          CERTIFICAT
        </div>
        <div
          style={{
            fontSize: "26pt",
            fontWeight: 300,
            color: "#F0651F",
            opacity: 0.85,
            letterSpacing: "-0.01em",
            marginTop: "-4px",
          }}
        >
          CERTIFICATE
        </div>
        <div
          style={{
            fontSize: "18pt",
            fontWeight: 300,
            color: "#F0651F",
            opacity: 0.6,
            letterSpacing: "-0.01em",
            marginTop: "-4px",
          }}
        >
          ZERTIFIKAT
        </div>
      </div>

      {/* Nom bénéficiaire — TRÈS proéminent */}
      <div style={{ marginBottom: "10mm" }}>
        <div
          style={{
            fontSize: "28pt",
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
              marginTop: "4px",
              lineHeight: 1.5,
            }}
          >
            {agentDateOfBirth && <>Né(e) le {agentDateOfBirth}</>}
            {agentDateOfBirth && agentPostalAddress && " · "}
            {agentPostalAddress}
          </div>
        )}
        <div
          style={{
            fontSize: "13pt",
            color: "#1F1B4B",
            marginTop: "10px",
            fontWeight: 400,
          }}
        >
          a validé avec succès le module de formation interne
        </div>
      </div>

      {/* Titre du module — mise en avant navy */}
      <div
        style={{
          padding: "14px 20px",
          background: "#FAF5EF",
          borderLeft: "6px solid #F0651F",
          marginBottom: "10mm",
        }}
      >
        <div
          style={{
            fontSize: "10pt",
            color: "#F0651F",
            fontWeight: 700,
            letterSpacing: "0.15em",
            textTransform: "uppercase",
            marginBottom: "4px",
          }}
        >
          Module certifié
        </div>
        <div
          style={{
            fontSize: "20pt",
            fontWeight: 700,
            color: "#1A1660",
            lineHeight: 1.2,
            letterSpacing: "-0.01em",
          }}
        >
          {moduleTitle}
        </div>
      </div>

      {/* Sujets examinés (liste) */}
      {moduleTopics.length > 0 && (
        <div style={{ marginBottom: "10mm" }}>
          <div
            style={{
              fontSize: "10pt",
              color: "#6E6A8E",
              fontWeight: 600,
              letterSpacing: "0.05em",
              textTransform: "uppercase",
              marginBottom: "8px",
            }}
          >
            Sujets examinés
          </div>
          <ul
            style={{
              listStyle: "none",
              padding: 0,
              margin: 0,
              fontSize: "11pt",
              lineHeight: 1.7,
            }}
          >
            {moduleTopics.map((topic, i) => (
              <li key={i} style={{ paddingLeft: "16px", position: "relative" }}>
                <span
                  style={{
                    position: "absolute",
                    left: 0,
                    top: "8px",
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
      )}

      {/* Score + validité */}
      <div
        style={{
          display: "flex",
          gap: "16px",
          marginBottom: "12mm",
        }}
      >
        <div
          style={{
            flex: 1,
            padding: "12px 16px",
            border: "1px solid #DDD9E8",
            borderRadius: "8px",
          }}
        >
          <div
            style={{
              fontSize: "9pt",
              color: "#6E6A8E",
              fontWeight: 600,
              letterSpacing: "0.1em",
              textTransform: "uppercase",
              marginBottom: "2px",
            }}
          >
            Score obtenu
          </div>
          <div
            style={{
              fontSize: "20pt",
              fontWeight: 700,
              color: "#1A1660",
            }}
          >
            {score}%
          </div>
        </div>
        <div
          style={{
            flex: 1,
            padding: "12px 16px",
            border: "1px solid #DDD9E8",
            borderRadius: "8px",
          }}
        >
          <div
            style={{
              fontSize: "9pt",
              color: "#6E6A8E",
              fontWeight: 600,
              letterSpacing: "0.1em",
              textTransform: "uppercase",
              marginBottom: "2px",
            }}
          >
            Valide jusqu'au
          </div>
          <div
            style={{
              fontSize: "13pt",
              fontWeight: 700,
              color: "#1A1660",
            }}
          >
            {validDate}
          </div>
        </div>
      </div>

      {/* Bloc bas : date + signature */}
      <div
        style={{
          position: "absolute",
          bottom: "22mm",
          left: "20mm",
          right: "20mm",
        }}
      >
        <div
          style={{
            fontSize: "10pt",
            color: "#6E6A8E",
            marginBottom: "18mm",
          }}
        >
          {city}, le {issuedDate}
        </div>

        <div style={{ display: "flex", justifyContent: "space-between", alignItems: "flex-end" }}>
          <div>
            <div
              style={{
                width: "60mm",
                height: "1px",
                background: "#1A1660",
                marginBottom: "6px",
              }}
            />
            <div
              style={{
                fontSize: "11pt",
                fontWeight: 700,
                color: "#1A1660",
              }}
            >
              {signatoryName}
            </div>
            <div style={{ fontSize: "9pt", color: "#6E6A8E" }}>
              {signatoryTitle}
            </div>
          </div>

          {/* Numéro certificat en petit à droite */}
          <div style={{ textAlign: "right" }}>
            <div
              style={{
                fontSize: "8pt",
                color: "#6E6A8E",
                letterSpacing: "0.1em",
                textTransform: "uppercase",
              }}
            >
              N° certificat
            </div>
            <div
              style={{
                fontSize: "10pt",
                fontWeight: 700,
                color: "#1A1660",
                fontFamily: "'SFMono-Regular', 'Menlo', monospace",
                marginTop: "2px",
              }}
            >
              {certNumber}
            </div>
          </div>
        </div>
      </div>

      {/* Logo Klary bas centre */}
      <div
        style={{
          position: "absolute",
          bottom: "5mm",
          left: "50%",
          transform: "translateX(-50%)",
          textAlign: "center",
        }}
      >
        <div
          style={{
            fontSize: "16pt",
            fontWeight: 800,
            color: "#1A1660",
            letterSpacing: "0.02em",
          }}
        >
          KLARY
        </div>
        <div
          style={{
            fontSize: "7pt",
            color: "#6E6A8E",
            fontWeight: 600,
            letterSpacing: "0.2em",
            textTransform: "uppercase",
            marginTop: "-2px",
          }}
        >
          Courtage en assurance · Suisse
        </div>
      </div>
    </div>
  );
}
