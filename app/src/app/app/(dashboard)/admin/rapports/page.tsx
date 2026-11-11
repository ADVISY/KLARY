import Link from "next/link";
import { redirect } from "next/navigation";
import { createSupabaseServerClient } from "@/lib/supabase/server";
import {
  REPORT_FIELDS,
  ROLE_LABELS,
  SALES_ROLES,
  conversionRate,
  formatMetric,
  formatReportDate,
  highestRole,
  todayZurich,
} from "@/lib/reports/fields";

export const metadata = {
  title: "Rapports du jour — Klary",
};

export const dynamic = "force-dynamic";

function shiftDate(date: string, days: number): string {
  const d = new Date(`${date}T00:00:00Z`);
  d.setUTCDate(d.getUTCDate() + days);
  return d.toISOString().slice(0, 10);
}

export default async function AdminRapportsPage({
  searchParams,
}: {
  searchParams: { date?: string; personne?: string };
}) {
  const supabase = createSupabaseServerClient();
  const {
    data: { user },
  } = await supabase.auth.getUser();
  if (!user) redirect("/login");

  const { data: myRoles } = await supabase
    .from("user_roles")
    .select("role")
    .eq("user_id", user.id)
    .eq("active", true);
  const myRole = highestRole(myRoles);
  if (myRole !== "admin" && myRole !== "manager") redirect("/rapport");

  const today = todayZurich();
  const requested = /^\d{4}-\d{2}-\d{2}$/.test(searchParams.date ?? "")
    ? searchParams.date!
    : today;
  const date = requested > today ? today : requested;
  const personId = searchParams.personne;

  const { data: peopleRows } = await supabase
    .from("user_roles")
    .select("user_id, role, first_name, last_name")
    .eq("active", true);

  // Une personne avec plusieurs rôles n'apparaît qu'une fois, avec le plus élevé
  const peopleById = new Map<
    string,
    { user_id: string; role: string; name: string }
  >();
  for (const row of peopleRows ?? []) {
    const rows = (peopleRows ?? []).filter((r) => r.user_id === row.user_id);
    peopleById.set(row.user_id, {
      user_id: row.user_id,
      role: highestRole(rows),
      name:
        [row.first_name, row.last_name].filter(Boolean).join(" ") || "Sans nom",
    });
  }
  // Le responsable suit son équipe ; la direction voit tout le monde
  const people = Array.from(peopleById.values())
    .filter((p) =>
      myRole === "admin" ? true : p.role === "agent" || p.role === "backoffice"
    )
    .sort((a, b) => a.name.localeCompare(b.name, "fr"));
  const person = personId
    ? people.find((p) => p.user_id === personId)
    : undefined;

  let query = supabase
    .from("daily_reports")
    .select(
      "user_id, report_date, role, metrics, summary, problem, solution, updated_at"
    );
  query = person
    ? query
        .eq("user_id", person.user_id)
        .order("report_date", { ascending: false })
        .limit(30)
    : query.eq("report_date", date);
  const { data: reports } = await query;

  const reportedIds = new Set((reports ?? []).map((r) => r.user_id));
  const missing = person ? [] : people.filter((p) => !reportedIds.has(p.user_id));
  const salesReports = (reports ?? []).filter((r) =>
    SALES_ROLES.includes(r.role)
  );
  const plateau = (key: string) =>
    salesReports.reduce(
      (sum, r) => sum + ((r.metrics as Record<string, number>)[key] ?? 0),
      0
    );
  const plateauHeld = plateau("appointments_held");
  const plateauContracts = plateau("contracts");
  const nameOf = (id: string) =>
    peopleById.get(id)?.name ?? "Ancien collaborateur";

  return (
    <div className="max-w-5xl mx-auto p-6 md:p-10">
      <header className="mb-6">
        <div className="text-xs font-bold tracking-widest uppercase text-klary-orange mb-2">
          Suivi d&apos;équipe
        </div>
        <h1 className="text-3xl md:text-4xl font-bold text-klary-navy">
          {person ? person.name : "Rapports du jour"}
        </h1>
        {!person && (
          <p className="text-klary-grey mt-2 first-letter:uppercase">
            {formatReportDate(date)} · {reports?.length ?? 0} reçu
            {(reports?.length ?? 0) > 1 ? "s" : ""} sur {people.length}
          </p>
        )}
      </header>

      {person ? (
        <Link
          href={`/admin/rapports?date=${date}`}
          className="inline-block mb-6 text-sm font-semibold text-klary-orange"
        >
          ← Retour à la journée
        </Link>
      ) : (
        <nav className="flex flex-wrap gap-2 mb-6" aria-label="Choisir le jour">
          <Link
            href={`/admin/rapports?date=${shiftDate(date, -1)}`}
            className="px-4 py-2 rounded-lg bg-white border border-klary-light-grey text-sm font-semibold text-klary-navy"
          >
            ← Jour précédent
          </Link>
          {date < today && (
            <>
              <Link
                href={`/admin/rapports?date=${shiftDate(date, 1)}`}
                className="px-4 py-2 rounded-lg bg-white border border-klary-light-grey text-sm font-semibold text-klary-navy"
              >
                Jour suivant →
              </Link>
              <Link
                href="/admin/rapports"
                className="px-4 py-2 rounded-lg bg-white border border-klary-light-grey text-sm font-semibold text-klary-navy"
              >
                Aujourd&apos;hui
              </Link>
            </>
          )}
          <a
            href={`/api/rapport/export?date=${date}`}
            className="px-4 py-2 rounded-lg bg-klary-orange text-sm font-semibold text-white sm:ml-auto"
          >
            Télécharger le rapport global
          </a>
        </nav>
      )}

      {!person && salesReports.length > 0 && (
        <section className="mb-6 rounded-2xl bg-klary-navy text-white p-5">
          <h2 className="font-bold mb-3">Total de la journée</h2>
          <dl className="grid grid-cols-2 sm:grid-cols-5 gap-3">
            {[
              ["Appels", plateau("calls").toLocaleString("fr-CH")],
              [
                "RDV fixés",
                plateau("appointments_set").toLocaleString("fr-CH"),
              ],
              ["RDV honorés", plateauHeld.toLocaleString("fr-CH")],
              ["Contrats", plateauContracts.toLocaleString("fr-CH")],
              [
                "Transformation",
                plateauHeld > 0
                  ? `${Math.round((plateauContracts / plateauHeld) * 100)} %`
                  : "–",
              ],
            ].map(([label, value]) => (
              <div key={label}>
                <dt className="text-xs text-white/70">{label}</dt>
                <dd className="text-2xl font-bold">{value}</dd>
              </div>
            ))}
          </dl>
        </section>
      )}

      {missing.length > 0 && (
        <section className="mb-6 rounded-xl bg-orange-50 border border-orange-100 p-4">
          <h2 className="font-bold text-klary-navy mb-2">
            Pas encore de rapport ({missing.length})
          </h2>
          <div className="flex flex-wrap gap-2">
            {missing.map((p) => (
              <Link
                key={p.user_id}
                href={`/admin/rapports?personne=${p.user_id}&date=${date}`}
                className="px-3 py-1.5 rounded-full bg-white text-sm text-klary-navy border border-orange-100"
              >
                {p.name}
              </Link>
            ))}
          </div>
        </section>
      )}

      <div className="space-y-4">
        {[...(reports ?? [])]
          .sort((a, b) =>
            person
              ? b.report_date.localeCompare(a.report_date)
              : nameOf(a.user_id).localeCompare(nameOf(b.user_id), "fr")
          )
          .map((r) => {
            const metrics = r.metrics as Record<string, number>;
            const fields = REPORT_FIELDS[r.role] ?? [];
            const rate = SALES_ROLES.includes(r.role)
              ? conversionRate(metrics)
              : null;
            return (
              <article
                key={`${r.user_id}-${r.report_date}`}
                className="bg-white rounded-2xl border border-klary-light-grey p-5"
              >
                <div className="flex flex-wrap items-baseline justify-between gap-2 mb-3">
                  {person ? (
                    <h2 className="font-bold text-klary-navy first-letter:uppercase">
                      {formatReportDate(r.report_date)}
                    </h2>
                  ) : (
                    <h2 className="font-bold text-klary-navy">
                      <Link
                        href={`/admin/rapports?personne=${r.user_id}&date=${date}`}
                        className="hover:text-klary-orange"
                      >
                        {nameOf(r.user_id)}
                      </Link>
                    </h2>
                  )}
                  <span className="text-xs font-semibold uppercase tracking-wider text-klary-grey">
                    {ROLE_LABELS[r.role] ?? r.role}
                  </span>
                </div>
                {fields.length > 0 && (
                  <dl className="grid grid-cols-2 sm:grid-cols-3 gap-3 mb-3">
                    {fields.map((f) => (
                      <div key={f.key} className="rounded-lg bg-klary-cream p-3">
                        <dt className="text-xs text-klary-grey">{f.label}</dt>
                        <dd className="text-xl font-bold text-klary-navy">
                          {formatMetric(metrics[f.key])}
                        </dd>
                      </div>
                    ))}
                    {rate !== null && (
                      <div className="rounded-lg bg-klary-cream p-3">
                        <dt className="text-xs text-klary-grey">
                          Transformation
                        </dt>
                        <dd className="text-xl font-bold text-klary-navy">
                          {rate} %
                        </dd>
                      </div>
                    )}
                  </dl>
                )}
                <p className="text-sm text-klary-navy whitespace-pre-wrap">
                  {r.summary}
                </p>
                {r.problem && (
                  <p className="mt-2 text-sm text-klary-navy whitespace-pre-wrap">
                    <b>Problème :</b> {r.problem}
                  </p>
                )}
                {r.solution && (
                  <p className="mt-1 text-sm text-klary-navy whitespace-pre-wrap">
                    <b>Solution :</b> {r.solution}
                  </p>
                )}
              </article>
            );
          })}
        {(reports ?? []).length === 0 && (
          <p className="text-klary-grey">
            {person
              ? "Aucun rapport pour cette personne."
              : "Aucun rapport reçu pour ce jour."}
          </p>
        )}
      </div>
    </div>
  );
}
