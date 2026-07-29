import { redirect } from "next/navigation";
import { createClient } from "@supabase/supabase-js";
import { createSupabaseServerClient } from "@/lib/supabase/server";

export const dynamic = "force-dynamic";
export const metadata = { title: "Baromètre équipe — Admin" };

const CHARGE_LABELS: Record<string, { emoji: string; label: string; color: string }> = {
  tres_faible: { emoji: "😴", label: "Trop faible", color: "bg-blue-100 text-blue-800" },
  faible: { emoji: "🙂", label: "Faible", color: "bg-blue-50 text-blue-700" },
  equilibree: { emoji: "✅", label: "Équilibrée", color: "bg-green-100 text-green-800" },
  lourde: { emoji: "😅", label: "Lourde", color: "bg-orange-100 text-orange-800" },
  tres_lourde: { emoji: "🔥", label: "Trop lourde", color: "bg-red-100 text-red-800" },
};

const MIN_RESPONSES_TO_SHOW = 3;

export default async function AdminBarometrePage() {
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
  if (role?.role !== "admin" && role?.role !== "manager") redirect("/formation");

  const service = createClient(
    process.env.NEXT_PUBLIC_SUPABASE_URL!,
    process.env.SUPABASE_SERVICE_ROLE_KEY!,
    { auth: { persistSession: false, autoRefreshToken: false } }
  );

  // Charger 12 derniers mois de réponses
  const { data: allResponses } = await service
    .from("barometer_responses")
    .select("*")
    .order("period_month", { ascending: false });

  // Charger état des invitations 6 derniers mois
  const { data: allInvites } = await service
    .from("barometer_invites")
    .select("period_month, responded_at")
    .order("invited_at", { ascending: false });

  // Grouper par mois
  const responsesByMonth = new Map<string, any[]>();
  for (const r of allResponses || []) {
    if (!responsesByMonth.has(r.period_month)) responsesByMonth.set(r.period_month, []);
    responsesByMonth.get(r.period_month)!.push(r);
  }

  const invitesByMonth = new Map<string, { total: number; responded: number }>();
  for (const i of allInvites || []) {
    const cur = invitesByMonth.get(i.period_month) || { total: 0, responded: 0 };
    cur.total += 1;
    if (i.responded_at) cur.responded += 1;
    invitesByMonth.set(i.period_month, cur);
  }

  // Prendre les 6 derniers mois en ordre chronologique
  const allMonths = Array.from(
    new Set([...responsesByMonth.keys(), ...invitesByMonth.keys()])
  )
    .sort()
    .reverse()
    .slice(0, 6)
    .reverse();

  const currentMonth = allMonths[allMonths.length - 1];
  const currentResponses = currentMonth ? responsesByMonth.get(currentMonth) || [] : [];
  const currentInvites = currentMonth ? invitesByMonth.get(currentMonth) : null;
  const currentCanShow = currentResponses.length >= MIN_RESPONSES_TO_SHOW;

  // ─── Métriques agrégées par mois pour graphiques ───
  const metrics = allMonths.map((m) => {
    const rs = responsesByMonth.get(m) || [];
    const nb = rs.length;
    const invites = invitesByMonth.get(m);
    if (nb < MIN_RESPONSES_TO_SHOW) return { month: m, nb, hidden: true, invites };
    const avg = (key: string) =>
      Math.round((rs.reduce((s, r) => s + r[key], 0) / nb) * 10) / 10;
    // eNPS calculation
    const promoters = rs.filter((r) => r.q1_enps >= 9).length;
    const detractors = rs.filter((r) => r.q1_enps <= 6).length;
    const enps = Math.round(((promoters - detractors) / nb) * 100);
    return {
      month: m,
      nb,
      hidden: false,
      invites,
      enps,
      ambiance: avg("q3_ambiance"),
      manager: avg("q4_manager"),
      motivation: avg("q6_motivation"),
    };
  });

  const previousMonth = metrics.length >= 2 ? metrics[metrics.length - 2] : null;
  const current = metrics[metrics.length - 1];

  return (
    <div className="max-w-6xl mx-auto p-6 md:p-10">
      <header className="mb-8">
        <div className="text-xs font-bold tracking-widest uppercase text-klary-orange mb-2">
          Baromètre équipe
        </div>
        <h1 className="text-3xl md:text-4xl font-bold text-klary-navy mb-3">
          Pulse mensuel Klary
        </h1>
        <p className="text-klary-grey">
          7 questions anonymes envoyées à toute l'équipe chaque 1er du mois. Impossible de lier
          une réponse à une personne. Les résultats sont masqués si moins de {MIN_RESPONSES_TO_SHOW} réponses.
        </p>
      </header>

      {!current ? (
        <EmptyState />
      ) : (
        <>
          {/* Bandeau du mois courant */}
          <div className="mb-6 flex items-center justify-between p-4 bg-white rounded-2xl border border-klary-light-grey">
            <div>
              <div className="text-xs uppercase tracking-widest text-klary-grey font-bold">
                Mois courant
              </div>
              <div className="text-lg font-bold text-klary-navy">
                {formatMonth(current.month)}
              </div>
            </div>
            <div className="text-right">
              <div className="text-xs uppercase tracking-widest text-klary-grey font-bold">
                Répondants
              </div>
              <div className="text-lg font-bold text-klary-navy">
                {current.invites?.responded ?? current.nb} / {current.invites?.total ?? "?"}
              </div>
            </div>
          </div>

          {/* KPIs mois courant */}
          {current.hidden ? (
            <div className="mb-8 p-6 bg-yellow-50 border-2 border-yellow-300 rounded-2xl text-center">
              <div className="text-3xl mb-2">🔒</div>
              <div className="font-bold text-yellow-900">
                Résultats masqués — seulement {current.nb} réponse(s) ce mois
              </div>
              <div className="text-sm text-yellow-800 mt-1">
                Il faut au moins {MIN_RESPONSES_TO_SHOW} réponses pour préserver l'anonymat.
              </div>
            </div>
          ) : (
            <div className="mb-8 grid grid-cols-1 md:grid-cols-4 gap-4">
              <KpiCard
                title="eNPS"
                value={current.enps!}
                unit=""
                previous={previousMonth?.enps}
                colorFn={(v) => (v >= 30 ? "green" : v >= 0 ? "orange" : "red")}
                caption="Recommandation Klary"
              />
              <KpiCard
                title="Ambiance"
                value={current.ambiance!}
                unit="/10"
                previous={previousMonth?.ambiance}
                colorFn={(v) => (v >= 7 ? "green" : v >= 5 ? "orange" : "red")}
                caption="Feeling équipe"
              />
              <KpiCard
                title="Manager"
                value={current.manager!}
                unit="/10"
                previous={previousMonth?.manager}
                colorFn={(v) => (v >= 7 ? "green" : v >= 5 ? "orange" : "red")}
                caption="Support reçu"
              />
              <KpiCard
                title="Motivation"
                value={current.motivation!}
                unit="/10"
                previous={previousMonth?.motivation}
                colorFn={(v) => (v >= 7 ? "green" : v >= 5 ? "orange" : "red")}
                caption="Énergie perçue"
              />
            </div>
          )}

          {/* Répartition charge de travail du mois */}
          {currentCanShow && (
            <div className="mb-8 bg-white rounded-2xl border border-klary-light-grey p-6">
              <h2 className="font-bold text-klary-navy mb-4">
                Charge de travail — {formatMonth(current.month)}
              </h2>
              <div className="space-y-2">
                {Object.keys(CHARGE_LABELS).map((key) => {
                  const nb = currentResponses.filter((r) => r.q2_charge === key).length;
                  const pct = Math.round((nb / currentResponses.length) * 100);
                  const cfg = CHARGE_LABELS[key];
                  return (
                    <div key={key} className="flex items-center gap-3">
                      <div className={`px-3 py-1 rounded-full text-xs font-semibold ${cfg.color} w-40 shrink-0`}>
                        {cfg.emoji} {cfg.label}
                      </div>
                      <div className="flex-1 bg-klary-cream rounded-full h-6 overflow-hidden relative">
                        <div
                          className="h-full bg-klary-navy rounded-full transition-all"
                          style={{ width: `${pct}%` }}
                        />
                        <div className="absolute inset-0 flex items-center justify-end pr-2 text-xs font-semibold text-klary-navy">
                          {nb} ({pct}%)
                        </div>
                      </div>
                    </div>
                  );
                })}
              </div>
            </div>
          )}

          {/* Historique 6 mois — mini graphique */}
          <div className="mb-8 bg-white rounded-2xl border border-klary-light-grey p-6">
            <h2 className="font-bold text-klary-navy mb-4">Historique 6 derniers mois</h2>
            <div className="overflow-x-auto">
              <table className="w-full text-sm">
                <thead>
                  <tr className="border-b-2 border-klary-navy">
                    <th className="text-left py-2 text-xs uppercase text-klary-grey font-bold">Mois</th>
                    <th className="text-center py-2 text-xs uppercase text-klary-grey font-bold">Réponses</th>
                    <th className="text-center py-2 text-xs uppercase text-klary-grey font-bold">eNPS</th>
                    <th className="text-center py-2 text-xs uppercase text-klary-grey font-bold">Ambiance</th>
                    <th className="text-center py-2 text-xs uppercase text-klary-grey font-bold">Manager</th>
                    <th className="text-center py-2 text-xs uppercase text-klary-grey font-bold">Motivation</th>
                  </tr>
                </thead>
                <tbody>
                  {metrics.map((m) => (
                    <tr key={m.month} className="border-b border-klary-light-grey">
                      <td className="py-3 font-semibold text-klary-navy">{formatMonth(m.month)}</td>
                      <td className="text-center text-klary-grey">
                        {m.invites?.responded ?? m.nb} / {m.invites?.total ?? "?"}
                      </td>
                      {m.hidden ? (
                        <td colSpan={4} className="text-center text-yellow-700 text-xs italic">
                          🔒 &lt; {MIN_RESPONSES_TO_SHOW} réponses
                        </td>
                      ) : (
                        <>
                          <td className="text-center font-mono">{m.enps}</td>
                          <td className="text-center font-mono">{m.ambiance}</td>
                          <td className="text-center font-mono">{m.manager}</td>
                          <td className="text-center font-mono">{m.motivation}</td>
                        </>
                      )}
                    </tr>
                  ))}
                </tbody>
              </table>
            </div>
          </div>

          {/* Commentaires libres du mois */}
          {currentCanShow && (
            <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
              <CommentBlock
                title="🎯 À améliorer"
                emoji="🎯"
                comments={currentResponses.map((r) => r.q5_improve).filter(Boolean)}
                color="border-orange-300 bg-orange-50"
              />
              <CommentBlock
                title="⭐ À continuer"
                emoji="⭐"
                comments={currentResponses.map((r) => r.q7_continue).filter(Boolean)}
                color="border-green-300 bg-green-50"
              />
            </div>
          )}
        </>
      )}
    </div>
  );
}

function EmptyState() {
  return (
    <div className="bg-white rounded-2xl border border-klary-light-grey p-10 text-center">
      <div className="text-4xl mb-3">📊</div>
      <h2 className="text-xl font-bold text-klary-navy mb-2">Aucun baromètre encore</h2>
      <p className="text-klary-grey">
        Le baromètre s'envoie automatiquement le 1er du mois à toute l'équipe active. Les résultats
        apparaîtront ici dès la première vague de réponses.
      </p>
    </div>
  );
}

function KpiCard({
  title,
  value,
  unit,
  previous,
  colorFn,
  caption,
}: {
  title: string;
  value: number;
  unit: string;
  previous?: number;
  colorFn: (v: number) => "green" | "orange" | "red";
  caption: string;
}) {
  const color = colorFn(value);
  const bg = { green: "bg-green-50 border-green-300", orange: "bg-orange-50 border-orange-300", red: "bg-red-50 border-red-300" }[color];
  const txt = { green: "text-green-700", orange: "text-orange-700", red: "text-red-700" }[color];

  let deltaStr = "";
  let deltaColor = "text-klary-grey";
  if (previous != null) {
    const delta = value - previous;
    if (Math.abs(delta) < 0.05) {
      deltaStr = "= stable";
    } else {
      deltaStr = `${delta > 0 ? "▲" : "▼"} ${Math.abs(delta).toFixed(1)} vs mois -1`;
      if (Math.abs(delta) >= 2) deltaColor = delta > 0 ? "text-green-600" : "text-red-600 font-bold";
      else deltaColor = delta > 0 ? "text-green-600" : "text-orange-600";
    }
  }

  return (
    <div className={`p-4 rounded-2xl border-2 ${bg}`}>
      <div className="text-xs uppercase tracking-widest text-klary-grey font-bold mb-2">
        {title}
      </div>
      <div className={`text-3xl font-bold ${txt}`}>
        {value}
        <span className="text-lg font-normal text-klary-grey">{unit}</span>
      </div>
      <div className="text-xs text-klary-grey mt-1">{caption}</div>
      {deltaStr && <div className={`text-xs mt-2 font-semibold ${deltaColor}`}>{deltaStr}</div>}
    </div>
  );
}

function CommentBlock({
  title,
  emoji,
  comments,
  color,
}: {
  title: string;
  emoji: string;
  comments: string[];
  color: string;
}) {
  return (
    <div className={`rounded-2xl border-2 ${color} p-5`}>
      <h3 className="font-bold text-klary-navy mb-3">{title}</h3>
      {comments.length === 0 ? (
        <p className="text-sm text-klary-grey italic">Aucun commentaire ce mois.</p>
      ) : (
        <ul className="space-y-3">
          {comments.map((c, i) => (
            <li
              key={i}
              className="text-sm text-klary-navy leading-relaxed pl-3 border-l-2 border-klary-orange/40"
            >
              "{c}"
            </li>
          ))}
        </ul>
      )}
    </div>
  );
}

function formatMonth(periodMonth: string): string {
  const [year, month] = periodMonth.split("-");
  return new Date(Number(year), Number(month) - 1, 1).toLocaleDateString("fr-CH", {
    month: "long",
    year: "numeric",
  });
}
