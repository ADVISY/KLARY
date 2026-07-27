import { redirect } from "next/navigation";
import Link from "next/link";
import { createSupabaseServerClient } from "@/lib/supabase/server";
import { PageTabs } from "@/components/app/PageTabs";

export const metadata = {
  title: "Offboarding — Admin",
};

export const dynamic = "force-dynamic";

const RH_TABS = [
  { href: "/admin/onboarding", label: "Onboarding" },
  { href: "/admin/offboarding", label: "Offboarding" },
];

const REASON_LABELS: Record<string, string> = {
  demission: "Démission",
  mutuel_accord: "Rupture commun accord",
  rupture_essai: "Rupture période essai",
  fin_cdd: "Fin CDD",
  retraite: "Retraite",
  licenciement: "Licenciement",
  faute_grave: "Faute grave",
  abandon_poste: "Abandon de poste",
};

const REASON_COLORS: Record<string, string> = {
  demission: "bg-blue-100 text-blue-800",
  mutuel_accord: "bg-blue-100 text-blue-800",
  rupture_essai: "bg-blue-100 text-blue-800",
  fin_cdd: "bg-blue-100 text-blue-800",
  retraite: "bg-blue-100 text-blue-800",
  licenciement: "bg-orange-100 text-orange-800",
  faute_grave: "bg-red-100 text-red-800",
  abandon_poste: "bg-red-100 text-red-800",
};

export default async function AdminOffboardingListPage() {
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

  const { data: rows } = await supabase
    .from("offboarding_processes")
    .select("*")
    .order("created_at", { ascending: false });

  const total = rows?.length || 0;
  const inProgress =
    rows?.filter((r) => !r.completed_at).length || 0;
  const completed = rows?.filter((r) => r.completed_at).length || 0;
  const sensitive =
    rows?.filter(
      (r) =>
        !r.completed_at &&
        (r.reason === "faute_grave" ||
          r.reason === "abandon_poste" ||
          r.reason === "licenciement")
    ).length || 0;

  return (
    <div className="max-w-6xl mx-auto p-6 md:p-10">
      <header className="mb-6">
        <div className="text-xs font-bold tracking-widest uppercase text-klary-orange mb-2">
          Backoffice · Offboarding
        </div>
        <h1 className="text-3xl md:text-4xl font-bold text-klary-navy mb-3">
          Départs d'agents
        </h1>
        <p className="text-klary-grey">
          Processus d'offboarding en cours et historique. Pour initier un
          nouveau offboarding, allez sur{" "}
          <Link href="/admin/agents" className="text-klary-orange underline">
            /admin/agents
          </Link>{" "}
          → bouton "Initier offboarding" sur l'agent concerné.
        </p>
      </header>

      <PageTabs tabs={RH_TABS} />

      <div className="grid grid-cols-2 md:grid-cols-4 gap-4 mb-8">
        <div className="bg-white rounded-xl border border-klary-light-grey p-4">
          <div className="text-[10px] uppercase tracking-widest text-klary-grey font-bold mb-1">
            Total
          </div>
          <div className="text-2xl font-bold text-klary-navy">{total}</div>
        </div>
        <div className="bg-white rounded-xl border border-yellow-200 p-4">
          <div className="text-[10px] uppercase tracking-widest text-yellow-700 font-bold mb-1">
            En cours
          </div>
          <div className="text-2xl font-bold text-yellow-700">{inProgress}</div>
        </div>
        <div className="bg-white rounded-xl border border-red-200 p-4">
          <div className="text-[10px] uppercase tracking-widest text-red-700 font-bold mb-1">
            Sensibles
          </div>
          <div className="text-2xl font-bold text-red-700">{sensitive}</div>
        </div>
        <div className="bg-white rounded-xl border border-green-200 p-4">
          <div className="text-[10px] uppercase tracking-widest text-green-700 font-bold mb-1">
            Finalisés
          </div>
          <div className="text-2xl font-bold text-green-700">{completed}</div>
        </div>
      </div>

      {!rows || rows.length === 0 ? (
        <div className="bg-white rounded-2xl border border-klary-light-grey p-10 text-center">
          <div className="text-3xl mb-3">👋</div>
          <h2 className="text-xl font-bold text-klary-navy mb-2">
            Aucun offboarding en cours
          </h2>
          <p className="text-klary-grey">
            Les processus de départ apparaîtront ici quand un admin en
            initie un depuis <Link href="/admin/agents" className="text-klary-orange">/admin/agents</Link>.
          </p>
        </div>
      ) : (
        <div className="bg-white rounded-2xl border border-klary-light-grey overflow-hidden">
          <table className="w-full text-sm">
            <thead className="bg-klary-cream text-klary-ink">
              <tr>
                <th className="text-left px-5 py-3 font-semibold">Agent</th>
                <th className="text-left px-5 py-3 font-semibold">Motif</th>
                <th className="text-left px-5 py-3 font-semibold">
                  Dernier jour
                </th>
                <th className="text-center px-5 py-3 font-semibold">
                  Convention
                </th>
                <th className="text-center px-5 py-3 font-semibold">Statut</th>
                <th className="text-right px-5 py-3 font-semibold">Actions</th>
              </tr>
            </thead>
            <tbody>
              {rows.map((r: any) => {
                const conventionSigned = !!r.convention_signed_uploaded_at;
                const status = r.completed_at
                  ? { label: "Finalisé", color: "bg-green-100 text-green-800" }
                  : conventionSigned
                  ? { label: "En cours", color: "bg-yellow-100 text-yellow-800" }
                  : {
                      label: "En attente signature",
                      color: "bg-orange-100 text-orange-800",
                    };
                return (
                  <tr
                    key={r.id}
                    className="border-t border-klary-light-grey hover:bg-klary-cream/30"
                  >
                    <td className="px-5 py-3">
                      <div className="font-semibold text-klary-navy">
                        {r.first_name} {r.last_name}
                      </div>
                      <div className="text-xs text-klary-grey">
                        {r.agent_email}
                      </div>
                    </td>
                    <td className="px-5 py-3">
                      <span
                        className={`px-2 py-0.5 rounded-full text-[10px] font-semibold ${
                          REASON_COLORS[r.reason] || "bg-gray-100 text-gray-700"
                        }`}
                      >
                        {REASON_LABELS[r.reason] || r.reason}
                      </span>
                    </td>
                    <td className="px-5 py-3 text-klary-ink text-xs">
                      {r.last_working_day
                        ? new Date(r.last_working_day).toLocaleDateString("fr-CH")
                        : "—"}
                    </td>
                    <td className="px-5 py-3 text-center">
                      {conventionSigned ? (
                        <span className="text-green-700 font-bold">✓</span>
                      ) : (
                        <span className="text-orange-700">⏳</span>
                      )}
                    </td>
                    <td className="px-5 py-3 text-center">
                      <span
                        className={`px-2 py-0.5 rounded-full text-[10px] font-semibold ${status.color}`}
                      >
                        {status.label}
                      </span>
                    </td>
                    <td className="px-5 py-3 text-right">
                      <Link
                        href={`/admin/offboarding/${r.id}`}
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
