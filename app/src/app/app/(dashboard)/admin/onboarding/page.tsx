import { redirect } from "next/navigation";
import Link from "next/link";
import { createSupabaseServerClient } from "@/lib/supabase/server";
import { PageTabs } from "@/components/app/PageTabs";

export const metadata = {
  title: "Onboarding — Admin",
};

const RH_TABS = [
  { href: "/admin/onboarding", label: "Onboarding" },
  { href: "/admin/offboarding", label: "Offboarding" },
];

export default async function AdminOnboardingListPage() {
  const supabase = createSupabaseServerClient();
  const {
    data: { user },
  } = await supabase.auth.getUser();
  if (!user) redirect("/login");

  const { data: role } = await supabase
    .from("user_roles")
    .select("role")
    .eq("user_id", user.id)
    .eq("active", true)
    .maybeSingle();
  if (role?.role !== "admin" && role?.role !== "manager")
    redirect("/formation");

  const { data: forms } = await supabase
    .from("onboarding_forms")
    .select(
      "id, candidate_id, form_token, created_at, submitted_at, comptable_notified_at, uploaded_docs"
    )
    .order("created_at", { ascending: false });

  const candIds = Array.from(
    new Set((forms || []).map((f) => f.candidate_id))
  );
  const { data: candidates } = candIds.length
    ? await supabase
        .from("candidates")
        .select("id, first_name, last_name, email, position_applied")
        .in("id", candIds)
    : { data: [] };
  const candMap = new Map((candidates || []).map((c: any) => [c.id, c]));

  const total = forms?.length || 0;
  const submitted =
    forms?.filter((f) => f.submitted_at).length || 0;
  const pending = total - submitted;

  return (
    <div className="max-w-6xl mx-auto p-6 md:p-10">
      <header className="mb-6">
        <div className="text-xs font-bold tracking-widest uppercase text-klary-orange mb-2">
          Backoffice · Onboarding
        </div>
        <h1 className="text-3xl md:text-4xl font-bold text-klary-navy mb-3">
          Dossiers d'onboarding
        </h1>
        <p className="text-klary-grey">
          Suivi des formulaires d'onboarding remplis par les candidats après
          leur embauche.
        </p>
      </header>

      <PageTabs tabs={RH_TABS} />

      <div className="grid grid-cols-3 gap-4 mb-8">
        <div className="bg-white rounded-xl border border-klary-light-grey p-4">
          <div className="text-[10px] uppercase tracking-widest text-klary-grey font-bold mb-1">
            Total
          </div>
          <div className="text-2xl font-bold text-klary-navy">{total}</div>
        </div>
        <div className="bg-white rounded-xl border border-green-200 p-4">
          <div className="text-[10px] uppercase tracking-widest text-green-700 font-bold mb-1">
            Soumis
          </div>
          <div className="text-2xl font-bold text-green-700">{submitted}</div>
        </div>
        <div className="bg-white rounded-xl border border-yellow-200 p-4">
          <div className="text-[10px] uppercase tracking-widest text-yellow-700 font-bold mb-1">
            En attente
          </div>
          <div className="text-2xl font-bold text-yellow-700">{pending}</div>
        </div>
      </div>

      {!forms || forms.length === 0 ? (
        <div className="bg-white rounded-2xl border border-klary-light-grey p-10 text-center">
          <div className="text-3xl mb-3">📁</div>
          <h2 className="text-xl font-bold text-klary-navy mb-2">
            Aucun dossier d'onboarding pour l'instant.
          </h2>
          <p className="text-klary-grey">
            Les dossiers créés apparaîtront quand une candidature passe au
            statut « Embauché ».
          </p>
        </div>
      ) : (
        <div className="bg-white rounded-2xl border border-klary-light-grey overflow-hidden">
          <table className="w-full text-sm">
            <thead className="bg-klary-cream text-klary-ink">
              <tr>
                <th className="text-left px-5 py-3 font-semibold">Candidat</th>
                <th className="text-left px-5 py-3 font-semibold">Poste</th>
                <th className="text-left px-5 py-3 font-semibold">Créé</th>
                <th className="text-left px-5 py-3 font-semibold">Soumis</th>
                <th className="text-center px-5 py-3 font-semibold">Docs</th>
                <th className="text-left px-5 py-3 font-semibold">Statut</th>
                <th className="text-right px-5 py-3 font-semibold">Actions</th>
              </tr>
            </thead>
            <tbody>
              {forms.map((f: any) => {
                const c = candMap.get(f.candidate_id) as any;
                const nDocs = Array.isArray(f.uploaded_docs)
                  ? f.uploaded_docs.length
                  : 0;
                return (
                  <tr
                    key={f.id}
                    className="border-t border-klary-light-grey hover:bg-klary-cream/30 transition"
                  >
                    <td className="px-5 py-3">
                      <div className="font-semibold text-klary-navy">
                        {c ? `${c.first_name} ${c.last_name}` : "—"}
                      </div>
                      {c && (
                        <div className="text-xs text-klary-grey">{c.email}</div>
                      )}
                    </td>
                    <td className="px-5 py-3 text-klary-ink">
                      {c?.position_applied || "—"}
                    </td>
                    <td className="px-5 py-3 text-klary-grey text-xs">
                      {new Date(f.created_at).toLocaleDateString("fr-CH")}
                    </td>
                    <td className="px-5 py-3 text-klary-grey text-xs">
                      {f.submitted_at
                        ? new Date(f.submitted_at).toLocaleDateString("fr-CH")
                        : "—"}
                    </td>
                    <td className="px-5 py-3 text-center font-mono text-klary-navy">
                      {nDocs || "—"}
                    </td>
                    <td className="px-5 py-3">
                      {f.submitted_at ? (
                        <span className="px-2 py-1 rounded-full text-xs font-semibold bg-green-100 text-green-800">
                          Soumis
                        </span>
                      ) : (
                        <span className="px-2 py-1 rounded-full text-xs font-semibold bg-yellow-100 text-yellow-800">
                          En attente
                        </span>
                      )}
                    </td>
                    <td className="px-5 py-3 text-right">
                      <Link
                        href={`/admin/onboarding/${f.id}`}
                        className="text-klary-orange font-semibold hover:underline text-sm"
                      >
                        Détail →
                      </Link>
                    </td>
                  </tr>
                );
              })}
            </tbody>
          </table>
        </div>
      )}
    </div>
  );
}
