import Link from "next/link";
import { createSupabaseServerClient } from "@/lib/supabase/server";

export const metadata = { title: "Révision AFA" };

const FILIERE_DEFAUT = "maladie_complementaire";

export default async function RevisionAfaPage({
  searchParams,
}: {
  searchParams: { filiere?: string };
}) {
  const supabase = createSupabaseServerClient();
  const filiereKey = searchParams.filiere || FILIERE_DEFAUT;

  const {
    data: { user },
  } = await supabase.auth.getUser();

  const { data: filieres } = await supabase
    .from("afa_filieres")
    .select("key, title, passing_pct, internal_target_pct, duration_min")
    .eq("active", true)
    .order("sort_order");

  const filiere = filieres?.find((f) => f.key === filiereKey) ?? filieres?.[0];

  const { data: themes } = await supabase
    .from("afa_themes")
    .select("id, key, title, description")
    .eq("filiere_key", filiereKey)
    .eq("active", true)
    .order("sort_order");

  // Nombre de questions actives par thème
  const { data: questionCounts } = await supabase
    .from("afa_questions")
    .select("theme_id")
    .eq("filiere_key", filiereKey)
    .eq("active", true);

  const countByTheme = new Map<string, number>();
  for (const q of questionCounts ?? []) {
    if (q.theme_id) countByTheme.set(q.theme_id, (countByTheme.get(q.theme_id) ?? 0) + 1);
  }

  // Historique des sessions terminées
  const { data: sessions } = user
    ? await supabase
        .from("afa_sessions")
        .select("id, mode, score_pct_partial, score_pct_strict, passed, finished_at, points_partial, points_max")
        .eq("user_id", user.id)
        .eq("filiere_key", filiereKey)
        .not("finished_at", "is", null)
        .order("finished_at", { ascending: false })
        .limit(8)
    : { data: [] };

  const derniere = sessions?.[0];
  const simulations = (sessions ?? []).filter((s) => s.mode === "simulation");

  return (
    <div className="max-w-[1200px] mx-auto p-6 md:p-10">
      <header className="mb-8">
        <div className="text-xs font-bold tracking-widest uppercase text-klary-orange mb-2">
          Préparation examen VBV
        </div>
        <h1 className="text-3xl md:text-4xl font-bold text-klary-navy mb-3">
          Révision AFA
        </h1>
        <p className="text-klary-grey max-w-2xl">
          Entraînement libre et illimité. L&apos;épreuve dure{" "}
          {filiere?.duration_min ?? 30} minutes. Seuil VBV officiel{" "}
          {filiere?.passing_pct ?? 60} %.{" "}
          <strong className="text-klary-navy">
            Cible interne Klary : {filiere?.internal_target_pct ?? 80} %
          </strong>{" "}
          (marge de sécurité pour passer sereinement).
        </p>
      </header>

      {/* Sélecteur de filière */}
      {filieres && filieres.length > 1 && (
        <nav className="flex flex-wrap gap-2 mb-8">
          {filieres.map((f) => (
            <Link
              key={f.key}
              href={`/revision-afa?filiere=${f.key}`}
              className={`px-4 py-2 rounded-full text-sm font-medium border transition ${
                f.key === filiereKey
                  ? "bg-klary-navy text-white border-klary-navy"
                  : "bg-white text-klary-grey border-klary-light-grey hover:border-klary-navy"
              }`}
            >
              {f.title}
            </Link>
          ))}
        </nav>
      )}

      {/* Actions principales */}
      <div className="grid gap-4 md:grid-cols-3 mb-10">
        <Link
          href={`/revision-afa/simulation?filiere=${filiereKey}`}
          className="group rounded-2xl bg-klary-navy text-white p-6 hover:shadow-lg transition"
        >
          <div className="text-3xl mb-3">⏱</div>
          <h2 className="text-xl font-bold mb-2">Simulation examen</h2>
          <p className="text-sm text-white/70">
            {filiere?.duration_min ?? 30} minutes chrono, format VBV, environ 30
            points. Remise automatique à l&apos;échéance.
          </p>
        </Link>

        <Link
          href={`/revision-afa/quiz/pieges?filiere=${filiereKey}`}
          className="group rounded-2xl bg-klary-orange text-white p-6 hover:shadow-lg transition"
        >
          <div className="text-3xl mb-3">⚠️</div>
          <h2 className="text-xl font-bold mb-2">Les pièges</h2>
          <p className="text-sm text-white/80">
            Uniquement les notions sur lesquelles des erreurs ont déjà été
            commises. Sans chrono.
          </p>
        </Link>

        <Link
          href={`/revision-afa/fiches?filiere=${filiereKey}`}
          className="group rounded-2xl bg-white border border-klary-light-grey p-6 hover:border-klary-navy transition"
        >
          <div className="text-3xl mb-3">📋</div>
          <h2 className="text-xl font-bold mb-2 text-klary-navy">
            Fiches mémoire
          </h2>
          <p className="text-sm text-klary-grey">
            Chiffres clés, produits LCA, pièges classiques. À relire juste avant
            l&apos;épreuve.
          </p>
        </Link>
      </div>

      {/* Progression */}
      {derniere && (
        <section className="mb-10">
          <h2 className="text-lg font-bold text-klary-navy mb-4">
            Où tu en es
          </h2>
          <div className="grid gap-4 sm:grid-cols-3">
            <Stat
              label="Dernier score (partiel)"
              value={`${derniere.score_pct_partial ?? 0} %`}
              hint={`${derniere.points_partial ?? 0} / ${derniere.points_max ?? 0} points · cible ${filiere?.internal_target_pct ?? 80} %`}
              tone={
                (derniere.score_pct_partial ?? 0) >=
                (filiere?.internal_target_pct ?? 80)
                  ? "ok"
                  : "warn"
              }
            />
            <Stat
              label="Dernier score (strict)"
              value={`${derniere.score_pct_strict ?? 0} %`}
              hint={`Tout ou rien par question · cible ${filiere?.internal_target_pct ?? 80} %`}
              tone={
                (derniere.score_pct_strict ?? 0) >=
                (filiere?.internal_target_pct ?? 80)
                  ? "ok"
                  : "warn"
              }
            />
            <Stat
              label="Simulations passées"
              value={String(simulations.length)}
              hint="En conditions d'examen"
              tone="neutral"
            />
          </div>
          <p className="text-xs text-klary-grey mt-3 max-w-2xl">
            Un score partiel élevé avec un score strict bas signifie des réponses
            incomplètes : les bonnes cases sont trouvées, mais pas toutes. C&apos;est
            le motif d&apos;échec le plus fréquent en QCM à réponses multiples.
          </p>
        </section>
      )}

      {/* Thèmes */}
      <section>
        <h2 className="text-lg font-bold text-klary-navy mb-4">
          Réviser par thème
        </h2>
        <div className="grid gap-3 md:grid-cols-2">
          {(themes ?? []).map((t) => {
            const n = countByTheme.get(t.id) ?? 0;
            return (
              <Link
                key={t.id}
                href={`/revision-afa/quiz/${t.key}?filiere=${filiereKey}`}
                aria-disabled={n === 0}
                className={`rounded-xl border p-5 transition ${
                  n === 0
                    ? "border-klary-light-grey bg-klary-cream/50 pointer-events-none opacity-60"
                    : "border-klary-light-grey bg-white hover:border-klary-navy"
                }`}
              >
                <div className="flex items-start justify-between gap-4">
                  <div>
                    <h3 className="font-semibold text-klary-navy">{t.title}</h3>
                    <p className="text-sm text-klary-grey mt-1">
                      {t.description}
                    </p>
                  </div>
                  <span className="shrink-0 text-xs font-medium text-klary-grey bg-klary-cream rounded-full px-3 py-1">
                    {n === 0 ? "à venir" : `${n} Q`}
                  </span>
                </div>
              </Link>
            );
          })}
        </div>
      </section>
    </div>
  );
}

function Stat({
  label,
  value,
  hint,
  tone,
}: {
  label: string;
  value: string;
  hint: string;
  tone: "ok" | "warn" | "neutral";
}) {
  const toneClass =
    tone === "ok"
      ? "text-emerald-600"
      : tone === "warn"
      ? "text-klary-orange"
      : "text-klary-navy";
  return (
    <div className="rounded-xl border border-klary-light-grey bg-white p-5">
      <div className="text-xs uppercase tracking-wide text-klary-grey mb-1">
        {label}
      </div>
      <div className={`text-3xl font-bold ${toneClass}`}>{value}</div>
      <div className="text-xs text-klary-grey mt-1">{hint}</div>
    </div>
  );
}
