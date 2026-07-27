import Link from "next/link";
import { createClient } from "@supabase/supabase-js";
import { PublicHeader, PublicFooter } from "../PublicChrome";

export const dynamic = "force-dynamic"; // pas de cache — statut peut évoluer

const MODULE_LABELS: Record<string, string> = {
  maladie: "Assurance maladie (LAMal / LCA)",
  lpp: "Prévoyance professionnelle (LPP)",
  prevoyance: "Prévoyance privée (3e pilier)",
  hypotheque: "Hypothèque",
  prospection_vente: "Prospection & Vente",
};

export async function generateMetadata({
  params,
}: {
  params: { cert: string };
}) {
  return {
    title: `Vérification ${params.cert}`,
    description: `Vérification publique de l'authenticité du certificat Klary n° ${params.cert}.`,
    // Empêche indexation Google des pages de vérif individuelles (protège vie privée)
    robots: { index: false, follow: false },
  };
}

export default async function VerifierCertPage({
  params,
}: {
  params: { cert: string };
}) {
  const certNumber = decodeURIComponent(params.cert).trim();

  // Client service_role pur — page publique, on bypass RLS
  const supabase = createClient(
    process.env.NEXT_PUBLIC_SUPABASE_URL!,
    process.env.SUPABASE_SERVICE_ROLE_KEY!,
    { auth: { persistSession: false, autoRefreshToken: false } }
  );

  const { data: cert } = await supabase
    .from("training_certifications")
    .select(
      "id, cert_number, module_key, issued_at, valid_until, score_pct, revoked, revoked_at, revoked_reason, user_id"
    )
    .eq("cert_number", certNumber)
    .maybeSingle();

  // Charger le nom si trouvé
  let holderName: string | null = null;
  if (cert) {
    const { data: profile } = await supabase
      .from("user_roles")
      .select("first_name, last_name")
      .eq("user_id", cert.user_id)
      .maybeSingle();
    if (profile) {
      holderName = [profile.first_name, profile.last_name]
        .filter(Boolean)
        .join(" ")
        .trim() || null;
    }
  }

  const now = new Date();
  const expired = cert ? new Date(cert.valid_until) < now : false;

  // Statut
  let status: "valid" | "expired" | "revoked" | "not_found" = "not_found";
  if (cert) {
    if (cert.revoked) status = "revoked";
    else if (expired) status = "expired";
    else status = "valid";
  }

  return (
    <div className="min-h-screen bg-klary-cream flex flex-col">
      <PublicHeader />

      <main className="flex-1 flex items-center justify-center px-4 py-12">
        <div className="w-full max-w-xl">
          <div className="mb-4 text-xs">
            <Link
              href="/verifier"
              className="text-klary-grey hover:text-klary-orange"
            >
              ← Autre vérification
            </Link>
          </div>

          {status === "not_found" && <NotFoundCard certNumber={certNumber} />}

          {cert && status !== "not_found" && (
            <ResultCard
              status={status}
              certNumber={cert.cert_number}
              holderName={holderName}
              moduleLabel={
                MODULE_LABELS[cert.module_key] || cert.module_key
              }
              issuedAt={cert.issued_at}
              validUntil={cert.valid_until}
              scorePct={cert.score_pct}
              revokedAt={cert.revoked_at}
              revokedReason={cert.revoked_reason}
            />
          )}
        </div>
      </main>

      <PublicFooter />
    </div>
  );
}

// ─── Composants d'affichage ───

function NotFoundCard({ certNumber }: { certNumber: string }) {
  return (
    <div className="bg-white rounded-2xl border-2 border-red-300 p-6 md:p-8 shadow-sm">
      <div className="flex items-center gap-3 mb-4">
        <div className="w-12 h-12 rounded-full bg-red-100 flex items-center justify-center text-2xl">
          ❌
        </div>
        <div>
          <h1 className="text-xl font-bold text-red-800">
            Certificat introuvable
          </h1>
          <p className="text-xs text-red-700 mt-0.5">
            N° saisi : <code className="font-mono">{certNumber}</code>
          </p>
        </div>
      </div>
      <p className="text-sm text-klary-navy leading-relaxed">
        Aucun certificat Klary ne correspond à ce numéro. Vérifiez la saisie
        (majuscules, tirets), ou contactez{" "}
        <a href="mailto:admin@klary.ch" className="text-klary-orange underline">
          admin@klary.ch
        </a>{" "}
        pour valider manuellement.
      </p>
    </div>
  );
}

function ResultCard({
  status,
  certNumber,
  holderName,
  moduleLabel,
  issuedAt,
  validUntil,
  scorePct,
  revokedAt,
  revokedReason,
}: {
  status: "valid" | "expired" | "revoked";
  certNumber: string;
  holderName: string | null;
  moduleLabel: string;
  issuedAt: string;
  validUntil: string;
  scorePct: number;
  revokedAt: string | null;
  revokedReason: string | null;
}) {
  const badge = {
    valid: {
      color: "border-green-400 bg-green-50",
      pill: "bg-green-500 text-white",
      icon: "✅",
      label: "Certificat valide",
      caption: "Cette certification est actuellement en cours de validité.",
    },
    expired: {
      color: "border-yellow-400 bg-yellow-50",
      pill: "bg-yellow-500 text-white",
      icon: "⏳",
      label: "Certificat expiré",
      caption:
        "Cette certification a été délivrée par Klary mais sa période de validité est dépassée. Un renouvellement est nécessaire.",
    },
    revoked: {
      color: "border-red-400 bg-red-50",
      pill: "bg-red-600 text-white",
      icon: "🚫",
      label: "Certificat révoqué",
      caption:
        "Cette certification a été révoquée par Klary et n'est plus valide.",
    },
  }[status];

  const fmt = (iso: string) =>
    new Date(iso).toLocaleDateString("fr-CH", {
      day: "numeric",
      month: "long",
      year: "numeric",
    });

  return (
    <div
      className={`bg-white rounded-2xl border-2 ${badge.color} p-6 md:p-8 shadow-sm`}
    >
      {/* Header avec statut */}
      <div className="flex items-center gap-3 mb-6 pb-6 border-b border-klary-light-grey">
        <div className="text-3xl">{badge.icon}</div>
        <div className="flex-1">
          <div
            className={`inline-block ${badge.pill} px-3 py-1 rounded-full text-xs font-bold uppercase tracking-widest mb-1`}
          >
            {badge.label}
          </div>
          <div className="text-xs text-klary-grey">{badge.caption}</div>
        </div>
      </div>

      {/* Détails */}
      <div className="space-y-4">
        <Row label="Titulaire" value={holderName || "— (nom masqué)"} strong />
        <Row label="Module certifié" value={moduleLabel} strong />
        <Row label="Numéro de certificat" value={certNumber} mono />
        <Row label="Date d'émission" value={fmt(issuedAt)} />
        <Row
          label="Valide jusqu'au"
          value={fmt(validUntil)}
          highlight={status === "expired" ? "text-yellow-700" : status === "valid" ? "text-green-700" : undefined}
        />
        <Row label="Score obtenu" value={`${scorePct} %`} />

        {status === "revoked" && (
          <>
            <Row
              label="Date de révocation"
              value={revokedAt ? fmt(revokedAt) : "—"}
              highlight="text-red-700"
            />
            {revokedReason && (
              <Row label="Motif" value={revokedReason} highlight="text-red-700" />
            )}
          </>
        )}
      </div>

      {/* Attestation Klary */}
      <div className="mt-8 pt-6 border-t border-klary-light-grey text-[11px] text-klary-grey text-center leading-relaxed">
        Cette page est une vérification officielle Klary Sàrl. Les données
        affichées proviennent directement du registre interne des certifications.
        Vérification consultée le{" "}
        <strong>
          {new Date().toLocaleDateString("fr-CH", {
            day: "numeric",
            month: "long",
            year: "numeric",
            hour: "2-digit",
            minute: "2-digit",
          })}
        </strong>
        .
      </div>
    </div>
  );
}

function Row({
  label,
  value,
  strong,
  mono,
  highlight,
}: {
  label: string;
  value: string;
  strong?: boolean;
  mono?: boolean;
  highlight?: string;
}) {
  return (
    <div className="flex items-baseline justify-between gap-4 text-sm">
      <div className="text-[11px] uppercase tracking-widest text-klary-grey font-bold shrink-0">
        {label}
      </div>
      <div
        className={[
          "text-right",
          strong ? "font-bold text-klary-navy" : "text-klary-navy",
          mono ? "font-mono text-xs" : "",
          highlight || "",
        ]
          .filter(Boolean)
          .join(" ")}
      >
        {value}
      </div>
    </div>
  );
}
