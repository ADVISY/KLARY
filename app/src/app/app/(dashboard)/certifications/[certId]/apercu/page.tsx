import { notFound, redirect } from "next/navigation";
import { createSupabaseServerClient } from "@/lib/supabase/server";
import { CertificatKlary } from "@/components/CertificatKlary";
import { PrintClientButton } from "./PrintClientButton";

export const metadata = {
  title: "Aperçu certificat — Klary",
  robots: "noindex, nofollow",
};

// Sujets par module (à externaliser plus tard en base)
const MODULE_TOPICS: Record<string, string[]> = {
  maladie: [
    "LAMal : bases, franchises, quote-part, résiliations",
    "LCA : ambulatoire, hospitalier, dentaire, complémentaires",
    "Modèles alternatifs : HMO, médecin de famille, télémédecine",
    "Calcul décisionnel — franchise 300 vs 2500 selon profil client",
    "Compagnies : Groupe Mutuel, Helsana, Swica, CSS, Assura, Sanitas",
    "Règlement interne Klary : confidentialité, non-sollicitation, appartenance clients",
    "Étude de cas cliniques : famille, senior, indépendant",
  ],
  lpp: [
    "Cadre légal LPP et libre passage",
    "Reconstitution de comptes multiples",
    "Fiscalité au retrait, achats rétroactifs",
    "Argumentaire consolidation client",
  ],
  prevoyance: [
    "3e pilier A vs B, plafonds annuels",
    "Assurance-vie mixte, décès, incapacité de gain",
    "Fiscalité 3a à la sortie",
    "Optimisation retraite globale",
  ],
  hypotheque: [
    "Fondamentaux financement immobilier",
    "Taux fixe vs SARON, arbitrages",
    "Amortissement direct vs indirect",
    "Interaction hypothèque + 2e/3e pilier",
  ],
};

export default async function ApercuCertificatPage({
  params,
}: {
  params: { certId: string };
}) {
  const supabase = createSupabaseServerClient();
  const {
    data: { user },
  } = await supabase.auth.getUser();
  if (!user) redirect("/login");

  const { data: cert } = await supabase
    .from("training_certifications")
    .select(
      "cert_number, module_key, score_pct, issued_at, valid_until, user_id, training_modules(title)"
    )
    .eq("id", params.certId)
    .maybeSingle();

  if (!cert) notFound();

  // L'agent voit son certif, admin/manager voit tous
  const { data: viewer } = await supabase
    .from("user_roles")
    .select("role")
    .eq("user_id", user.id)
    .eq("active", true)
    .maybeSingle();
  const isPrivileged =
    viewer?.role === "admin" || viewer?.role === "manager";
  if (cert.user_id !== user.id && !isPrivileged) {
    return notFound();
  }

  // Charger le profil de l'agent bénéficiaire (nom, DOB, adresse)
  const { data: profile } = await supabase
    .from("user_roles")
    .select(
      "first_name, last_name, date_of_birth, postal_street, postal_zip, postal_city"
    )
    .eq("user_id", cert.user_id)
    .eq("active", true)
    .maybeSingle();

  const agentName = profile
    ? `${profile.first_name || ""} ${profile.last_name || ""}`.trim()
    : "Agent Klary";
  const dob = profile?.date_of_birth
    ? new Date(profile.date_of_birth).toLocaleDateString("fr-CH", {
        day: "numeric",
        month: "long",
        year: "numeric",
      })
    : undefined;
  const postal = profile
    ? [
        profile.postal_street,
        profile.postal_zip && profile.postal_city
          ? `${profile.postal_zip} ${profile.postal_city}`
          : profile.postal_city,
      ]
        .filter(Boolean)
        .join(", ")
    : undefined;

  const moduleTitle =
    (cert as any).training_modules?.title || cert.module_key;
  const topics = MODULE_TOPICS[cert.module_key] || [];

  return (
    <div className="min-h-screen bg-klary-navy/10 py-10 print:py-0 print:bg-white">
      {/* Barre d'action non imprimable */}
      <div className="max-w-3xl mx-auto mb-6 flex items-center justify-between px-4 print:hidden">
        <div className="text-sm text-klary-grey">
          Aperçu certificat — utilisez « Imprimer » pour sauvegarder en PDF.
        </div>
        <div className="flex gap-2">
          <a
            href="/certifications"
            className="px-4 py-2 bg-white border border-klary-light-grey rounded-lg text-sm font-semibold text-klary-navy hover:border-klary-navy"
          >
            Retour
          </a>
          <PrintClientButton />
        </div>
      </div>

      <CertificatKlary
        agentName={agentName}
        agentDateOfBirth={dob}
        agentPostalAddress={postal}
        moduleTitle={moduleTitle}
        moduleTopics={topics}
        score={cert.score_pct}
        certNumber={cert.cert_number}
        issuedAt={cert.issued_at}
        validUntil={cert.valid_until}
      />
    </div>
  );
}
