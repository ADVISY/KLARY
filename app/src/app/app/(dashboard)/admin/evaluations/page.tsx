import { redirect } from "next/navigation";
import Link from "next/link";
import { createSupabaseServerClient } from "@/lib/supabase/server";

export const metadata = {
  title: "Évaluations — Admin",
};

const MODULE_LABELS: Record<string, string> = {
  maladie: "Maladie (LAMal + LCA)",
  lpp: "LPP Libre Passage",
  prevoyance: "Prévoyance & 3e pilier",
  hypotheque: "Hypothèque",
};

export default async function AdminEvaluationsPage() {
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

  // Toutes les tentatives, jointes avec l'agent + le module
  const { data: attempts } = await supabase
    .from("training_attempts")
    .select(
      "id, user_id, module_key, started_at, finished_at, score_pct, passed, cheat_count, aborted, abort_reason, time_used_sec"
    )
    .order("started_at", { ascending: false })
    .limit(200);

  // Cache agents pour éviter n+1
  const userIds = Array.from(
    new Set((attempts || []).map((a) => a.user_id))
  );
  const { data: agents } = userIds.length
    ? await supabase
        .from("user_roles")
        .select("user_id, first_name, last_name")
        .in("user_id", userIds)
    : { data: [] };
  const agentsById = new Map(
    (agents || []).map((a: any) => [a.user_id, a])
  );

  // Certifications valides par attempt
  const attemptIds = (attempts || []).map((a) => a.id);
  const { data: certs } = attemptIds.length
    ? await supabase
        .from("training_certifications")
        .select("attempt_id, cert_number, valid_until, revoked")
        .in("attempt_id", attemptIds)
    : { data: [] };
  const certsByAttempt = new Map(
    (certs || []).map((c: any) => [c.attempt_id, c])
  );

  // Stats globales
  const total = attempts?.length || 0;
  const passed = attempts?.filter((a) => a.passed && !a.aborted).length || 0;
  const failed =
    attempts?.filter((a) => a.finished_at && !a.passed).length || 0;
  const inProgress =
    attempts?.filter((a) => !a.finished_at).length || 0;
  const successRate = total > 0 ? Math.round((passed / total) * 100) : 0;

  return (
    <div className="max-w-[1400px] mx-auto p-6 md:p-10">
      <header className="mb-8">
        <div className="text-xs font-bold tracking-widest uppercase text-klary-orange mb-2">
          Backoffice · Formation
        </div>
        <h1 className="text-3xl md:text-4xl font-bold text-klary-navy mb-3">
          Évaluations & certifications
        </h1>
        <p className="text-klary-grey">
          Suivi des évaluations des agents Klary — les 200 dernières tentatives.
        </p>
      </header>

      {/* Stats */}
      <div className="grid grid-cols-2 md:grid-cols-4 gap-4 mb-8">
        <div className="bg-white rounded-xl border border-klary-light-grey p-4">
          <div className="text-[10px] uppercase tracking-widest text-klary-grey font-bold mb-1">
            Tentatives
          </div>
          <div className="text-2xl font-bold text-klary-navy">{total}</div>
        </div>
        <div className="bg-white rounded-xl border border-green-200 p-4">
          <div className="text-[10px] uppercase tracking-widest text-green-700 font-bold mb-1">
            Certifiés
          </div>
          <div className="text-2xl font-bold text-green-700">{passed}</div>
        </div>
        <div className="bg-white rounded-xl border border-red-200 p-4">
          <div className="text-[10px] uppercase tracking-widest text-red-700 font-bold mb-1">
            Échoués
          </div>
          <div className="text-2xl font-bold text-red-700">{failed}</div>
        </div>
        <div className="bg-white rounded-xl border border-klary-orange/30 p-4">
          <div className="text-[10px] uppercase tracking-widest text-klary-orange font-bold mb-1">
            Taux réussite
          </div>
          <div className="text-2xl font-bold text-klary-navy">{successRate}%</div>
        </div>
      </div>

      {!attempts || attempts.length === 0 ? (
        <div className="bg-white rounded-2xl border border-klary-light-grey p-10 text-center">
          <div className="text-3xl mb-3">📊</div>
          <h2 className="text-xl font-bold text-klary-navy mb-2">
            Aucune évaluation encore.
          </h2>
          <p className="text-klary-grey">
            Les tentatives des agents apparaîtront ici.
          </p>
        </div>
      ) : (
        <div className="bg-white rounded-2xl border border-klary-light-grey overflow-hidden">
          <div className="w-full overflow-x-auto -mx-4 sm:mx-0">
            <table className="w-full text-sm">
            <thead className="bg-klary-cream text-klary-ink">
              <tr>
                <th className="text-left px-5 py-3 font-semibold">Agent</th>
                <th className="text-left px-5 py-3 font-semibold">Module</th>
                <th className="text-left px-5 py-3 font-semibold">Date</th>
                <th className="text-center px-5 py-3 font-semibold">Score</th>
                <th className="text-left px-5 py-3 font-semibold">Statut</th>
                <th className="text-right px-5 py-3 font-semibold">Actions</th>
              </tr>
            </thead>
            <tbody>
              {attempts.map((a: any) => {
                const agent = agentsById.get(a.user_id) as any;
                const agentName = agent
                  ? [agent.first_name, agent.last_name]
                      .filter(Boolean)
                      .join(" ") || "—"
                  : "—";
                const cert = certsByAttempt.get(a.id) as any;
                let statusLabel = "";
                let statusColor = "";
                if (!a.finished_at) {
                  statusLabel = "En cours";
                  statusColor = "bg-blue-100 text-blue-800";
                } else if (a.aborted) {
                  statusLabel =
                    a.abort_reason === "cheat"
                      ? "Interrompu (triche)"
                      : a.abort_reason === "timeout"
                      ? "Temps écoulé"
                      : "Abandonné";
                  statusColor = "bg-red-100 text-red-800";
                } else if (a.passed) {
                  statusLabel = cert?.revoked ? "Révoqué" : "Certifié";
                  statusColor = cert?.revoked
                    ? "bg-gray-100 text-gray-600"
                    : "bg-green-100 text-green-800";
                } else {
                  statusLabel = "Échoué";
                  statusColor = "bg-yellow-100 text-yellow-800";
                }
                return (
                  <tr
                    key={a.id}
                    className="border-t border-klary-light-grey hover:bg-klary-cream/30 transition"
                  >
                    <td className="px-5 py-3">
                      <div className="font-semibold text-klary-navy">
                        {agentName}
                      </div>
                    </td>
                    <td className="px-5 py-3 text-klary-ink">
                      {MODULE_LABELS[a.module_key] || a.module_key}
                    </td>
                    <td className="px-5 py-3 text-klary-grey text-xs">
                      {new Date(a.started_at).toLocaleString("fr-CH", {
                        day: "2-digit",
                        month: "2-digit",
                        year: "2-digit",
                        hour: "2-digit",
                        minute: "2-digit",
                      })}
                    </td>
                    <td className="px-5 py-3 text-center">
                      {a.score_pct != null ? (
                        <span className="font-mono font-bold text-klary-navy">
                          {a.score_pct}%
                        </span>
                      ) : (
                        <span className="text-klary-grey text-xs">—</span>
                      )}
                    </td>
                    <td className="px-5 py-3">
                      <span
                        className={`px-2 py-1 rounded-full text-xs font-semibold ${statusColor}`}
                      >
                        {statusLabel}
                      </span>
                      {a.cheat_count > 0 && !a.aborted && (
                        <span className="ml-2 text-xs text-red-600">
                          ⚠ {a.cheat_count}
                        </span>
                      )}
                    </td>
                    <td className="px-5 py-3 text-right">
                      <Link
                        href={`/admin/evaluations/${a.id}`}
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
        </div>
      )}
    </div>
  );
}
