import { redirect } from "next/navigation";
import { createSupabaseServerClient } from "@/lib/supabase/server";
import {
  REPORT_FIELDS,
  formatMetric,
  formatReportDate,
  highestRole,
  todayZurich,
} from "@/lib/reports/fields";
import { ReportForm } from "./ReportForm";

export const metadata = {
  title: "Mon rapport du jour — Klary",
};

export const dynamic = "force-dynamic";

export default async function RapportPage() {
  const supabase = createSupabaseServerClient();
  const {
    data: { user },
  } = await supabase.auth.getUser();
  if (!user) redirect("/login");

  const { data: roles } = await supabase
    .from("user_roles")
    .select("role")
    .eq("user_id", user.id)
    .eq("active", true);
  const role = highestRole(roles);
  const today = todayZurich();

  const { data: reports } = await supabase
    .from("daily_reports")
    .select("report_date, role, metrics, summary, problem, solution")
    .eq("user_id", user.id)
    .order("report_date", { ascending: false })
    .limit(15);
  const current = (reports ?? []).find((r) => r.report_date === today);
  const history = (reports ?? []).filter((r) => r.report_date !== today);

  return (
    <div className="max-w-3xl mx-auto p-6 md:p-10">
      <header className="mb-6">
        <div className="text-xs font-bold tracking-widest uppercase text-klary-orange mb-2">
          Avant de finir la journée
        </div>
        <h1 className="text-3xl md:text-4xl font-bold text-klary-navy mb-3">
          Mon rapport du jour
        </h1>
        <p className="text-klary-grey first-letter:uppercase">
          {formatReportDate(today)}
        </p>
      </header>

      <ReportForm
        fields={REPORT_FIELDS[role] ?? []}
        initial={
          current
            ? {
                metrics: current.metrics as Record<string, number>,
                summary: current.summary,
                problem: current.problem ?? "",
                solution: current.solution ?? "",
              }
            : null
        }
      />

      {history.length > 0 && (
        <section className="mt-10">
          <h2 className="text-lg font-bold text-klary-navy mb-3">
            Mes derniers rapports
          </h2>
          <div className="space-y-3">
            {history.map((r) => (
              <details
                key={r.report_date}
                className="bg-white rounded-xl border border-klary-light-grey p-4"
              >
                <summary className="cursor-pointer font-semibold text-klary-navy first-letter:uppercase">
                  {formatReportDate(r.report_date)}
                </summary>
                <div className="mt-3 text-sm text-klary-grey space-y-2">
                  {(REPORT_FIELDS[r.role] ?? []).length > 0 && (
                    <p>
                      {(REPORT_FIELDS[r.role] ?? [])
                        .map(
                          (f) =>
                            `${f.label} : ${formatMetric(
                              (r.metrics as Record<string, number>)[f.key]
                            )}`
                        )
                        .join(" · ")}
                    </p>
                  )}
                  <p className="whitespace-pre-wrap">{r.summary}</p>
                  {r.problem && (
                    <p className="whitespace-pre-wrap">
                      <b>Problème :</b> {r.problem}
                    </p>
                  )}
                  {r.solution && (
                    <p className="whitespace-pre-wrap">
                      <b>Solution :</b> {r.solution}
                    </p>
                  )}
                </div>
              </details>
            ))}
          </div>
        </section>
      )}
    </div>
  );
}
