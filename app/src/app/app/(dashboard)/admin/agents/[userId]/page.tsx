import { redirect, notFound } from "next/navigation";
import Link from "next/link";
import { createServerClient } from "@supabase/ssr";
import { cookies } from "next/headers";
import { createSupabaseServerClient } from "@/lib/supabase/server";
import { AgentDocumentsSection } from "./AgentDocumentsSection";
import { InitiateOffboardingModal } from "../InitiateOffboardingModal";
import { JobTitleEditor } from "./JobTitleEditor";

const JOB_TITLE_LABELS: Record<string, string> = {
  conseiller: "Conseiller",
  telephoniste: "Téléphoniste",
};

export const metadata = {
  title: "Fiche agent — Admin",
};

export const dynamic = "force-dynamic";

const ROLE_LABELS: Record<string, string> = {
  admin: "Admin",
  manager: "Manager",
  agent: "Agent",
};
const ROLE_COLORS: Record<string, string> = {
  admin: "bg-red-100 text-red-800",
  manager: "bg-purple-100 text-purple-800",
  agent: "bg-blue-100 text-blue-800",
};
const MODULE_LABELS: Record<string, string> = {
  maladie: "Maladie",
  lpp: "LPP",
  prevoyance: "Prévoyance",
  hypotheque: "Hypothèque",
  prospection_vente: "Prospection & Vente",
};

export default async function AgentDetailPage({
  params,
}: {
  params: { userId: string };
}) {
  const supabase = createSupabaseServerClient();
  const {
    data: { user },
  } = await supabase.auth.getUser();
  if (!user) redirect("/login");

  const { data: viewerRole } = await supabase
    .from("user_roles")
    .select("role")
    .eq("user_id", user.id)
    .eq("active", true)
    .maybeSingle();
  if (viewerRole?.role !== "admin" && viewerRole?.role !== "manager")
    redirect("/formation");

  // Profil agent
  const { data: profile } = await supabase
    .from("user_roles")
    .select("*")
    .eq("user_id", params.userId)
    .maybeSingle();
  if (!profile) notFound();

  // Récup email via service_role
  const cookieStore = cookies();
  const service = createServerClient(
    process.env.NEXT_PUBLIC_SUPABASE_URL!,
    process.env.SUPABASE_SERVICE_ROLE_KEY!,
    {
      cookies: {
        getAll: () => cookieStore.getAll(),
        setAll: () => {},
      },
    }
  );
  const { data: authRes } = await service.auth.admin.getUserById(params.userId);
  const email = authRes?.user?.email;

  // Certifications actives
  const { data: certs } = await supabase
    .from("training_certifications")
    .select("*")
    .eq("user_id", params.userId)
    .eq("revoked", false)
    .order("issued_at", { ascending: false });

  // Documents internes
  const { data: docs } = await supabase
    .from("internal_documents")
    .select("*")
    .eq("user_id", params.userId)
    .eq("is_active", true)
    .order("created_at", { ascending: false });

  // Offboardings (historique + en cours)
  const { data: offboardings } = await supabase
    .from("offboarding_processes")
    .select("id, reason, last_working_day, completed_at, created_at")
    .eq("user_id", params.userId)
    .order("created_at", { ascending: false });
  const currentOffboarding =
    offboardings?.find((o: any) => !o.completed_at) || null;

  const fullName =
    [profile.first_name, profile.last_name].filter(Boolean).join(" ") || "—";

  return (
    <div className="max-w-5xl mx-auto p-6 md:p-10">
      <div className="mb-6">
        <Link
          href="/admin/agents"
          className="text-sm text-klary-grey hover:text-klary-orange"
        >
          ← Retour à la liste
        </Link>
      </div>

      {/* Header identité */}
      <div className="bg-white rounded-2xl border border-klary-light-grey p-8 mb-6">
        <div className="flex items-start justify-between gap-4 mb-4">
          <div>
            <div className="text-xs font-bold tracking-widest uppercase text-klary-orange mb-2">
              Fiche agent
            </div>
            <h1 className="text-3xl font-bold text-klary-navy">{fullName}</h1>
            {email && (
              <div className="text-sm text-klary-grey mt-1">{email}</div>
            )}
          </div>
          <div className="flex flex-col items-end gap-2">
            <span
              className={`px-3 py-1 rounded-full text-xs font-bold uppercase ${
                ROLE_COLORS[profile.role] || "bg-gray-100 text-gray-700"
              }`}
            >
              {ROLE_LABELS[profile.role] || profile.role}
            </span>
            {profile.active ? (
              <span className="px-2 py-0.5 rounded-full text-[10px] font-semibold bg-green-100 text-green-800">
                Actif
              </span>
            ) : (
              <span className="px-2 py-0.5 rounded-full text-[10px] font-semibold bg-gray-100 text-gray-600">
                Inactif
              </span>
            )}
          </div>
        </div>

        <div className="grid grid-cols-1 md:grid-cols-3 gap-3 mt-6 text-sm">
          <InfoBlock
            label="Poste occupé"
            value={
              profile.job_title
                ? JOB_TITLE_LABELS[profile.job_title] || profile.job_title
                : null
            }
          />
          <InfoBlock label="Date de naissance" value={profile.date_of_birth} />
          <InfoBlock label="Téléphone" value={profile.phone} />
          <InfoBlock label="Rue" value={profile.postal_street} />
          <InfoBlock
            label="NPA + ville"
            value={
              [profile.postal_zip, profile.postal_city].filter(Boolean).join(" ") ||
              null
            }
          />
          <InfoBlock
            label="Profil complet"
            value={profile.profile_completed ? "✓ Oui" : "⏳ Non"}
          />
        </div>

        {profile.role === "agent" && (
          <div className="mt-6">
            <JobTitleEditor
              userId={params.userId}
              currentJobTitle={profile.job_title || null}
            />
          </div>
        )}
        {(profile.role === "admin" || profile.role === "manager") && (
          <div className="mt-6 p-3 bg-blue-50 border-l-4 border-blue-400 rounded text-xs text-blue-900">
            💼 En tant qu'<strong>{profile.role}</strong>, cet utilisateur voit
            l'intégralité de la bibliothèque — pas besoin d'assigner un poste
            (conseiller / téléphoniste).
          </div>
        )}
      </div>

      {/* Actions rapides */}
      {viewerRole?.role === "admin" && (
        <div className="bg-white rounded-2xl border border-klary-light-grey p-6 mb-6">
          <h2 className="font-bold text-klary-navy mb-4">
            🎬 Actions & procédures
          </h2>
          <div className="flex flex-wrap gap-3">
            {profile.active && !currentOffboarding && (
              <div className="p-3 bg-red-50 border border-red-200 rounded-lg">
                <div className="text-xs font-semibold text-red-900 mb-1">
                  Fin de collaboration
                </div>
                <InitiateOffboardingModal
                  agentId={params.userId}
                  agentName={fullName}
                />
              </div>
            )}
            {currentOffboarding && (
              <Link
                href={`/admin/offboarding/${currentOffboarding.id}`}
                className="p-3 bg-yellow-50 border border-yellow-200 rounded-lg text-xs font-semibold text-yellow-900 hover:bg-yellow-100"
              >
                ⏳ Offboarding en cours — voir le dossier →
              </Link>
            )}
            <div className="p-3 bg-klary-cream border border-klary-light-grey rounded-lg opacity-60">
              <div className="text-xs font-semibold text-klary-navy mb-1">
                Générer une attestation
              </div>
              <span className="text-xs text-klary-grey italic">
                Bientôt : certif travail, attestation AC, LAWID
              </span>
            </div>
          </div>
        </div>
      )}

      {/* Certifications */}
      <div className="bg-white rounded-2xl border border-klary-light-grey p-6 mb-6">
        <h2 className="font-bold text-klary-navy mb-4 flex items-center gap-2">
          🎓 Certifications ({certs?.length || 0})
        </h2>
        {!certs || certs.length === 0 ? (
          <p className="text-sm text-klary-grey italic">
            Aucune certification pour l'instant.
          </p>
        ) : (
          <div className="space-y-2">
            {certs.map((c: any) => {
              const expired = new Date(c.valid_until) < new Date();
              return (
                <div
                  key={c.id}
                  className={`p-3 rounded-lg border ${
                    expired
                      ? "border-yellow-300 bg-yellow-50"
                      : "border-green-300 bg-green-50"
                  }`}
                >
                  <div className="flex items-center justify-between">
                    <div>
                      <div className="font-semibold text-sm text-klary-navy">
                        {MODULE_LABELS[c.module_key] || c.module_key}
                      </div>
                      <div className="text-xs text-klary-grey">
                        {c.cert_number} · Score {c.score_pct}%
                      </div>
                    </div>
                    <div className="text-xs text-right">
                      <div className={expired ? "text-yellow-700" : "text-green-700"}>
                        {expired ? "Expirée le " : "Valide jusqu'au "}
                        <strong>
                          {new Date(c.valid_until).toLocaleDateString("fr-CH")}
                        </strong>
                      </div>
                    </div>
                  </div>
                </div>
              );
            })}
          </div>
        )}
      </div>

      {/* Documents internes — coffre-fort */}
      <AgentDocumentsSection
        userId={params.userId}
        docs={docs || []}
        canDelete={viewerRole?.role === "admin"}
      />

      {/* Historique offboarding */}
      {offboardings && offboardings.length > 0 && (
        <div className="bg-white rounded-2xl border border-klary-light-grey p-6 mt-6">
          <h2 className="font-bold text-klary-navy mb-4 flex items-center gap-2">
            🚪 Historique offboarding
          </h2>
          <div className="space-y-2">
            {offboardings.map((o: any) => (
              <Link
                key={o.id}
                href={`/admin/offboarding/${o.id}`}
                className="block p-3 border border-klary-light-grey rounded-lg hover:border-klary-orange text-sm"
              >
                <div className="flex items-center justify-between">
                  <div>
                    <strong className="text-klary-navy">{o.reason}</strong>
                    {o.last_working_day && (
                      <span className="ml-2 text-xs text-klary-grey">
                        · Dernier jour :{" "}
                        {new Date(o.last_working_day).toLocaleDateString("fr-CH")}
                      </span>
                    )}
                  </div>
                  <span
                    className={`text-[10px] px-2 py-0.5 rounded-full font-semibold ${
                      o.completed_at
                        ? "bg-green-100 text-green-800"
                        : "bg-yellow-100 text-yellow-800"
                    }`}
                  >
                    {o.completed_at ? "Finalisé" : "En cours"}
                  </span>
                </div>
              </Link>
            ))}
          </div>
        </div>
      )}
    </div>
  );
}

function InfoBlock({
  label,
  value,
}: {
  label: string;
  value?: string | null;
}) {
  return (
    <div>
      <div className="text-[10px] uppercase tracking-widest text-klary-grey font-bold mb-1">
        {label}
      </div>
      <div className="text-sm font-semibold text-klary-navy">
        {value || <span className="text-klary-grey/50 italic">—</span>}
      </div>
    </div>
  );
}
