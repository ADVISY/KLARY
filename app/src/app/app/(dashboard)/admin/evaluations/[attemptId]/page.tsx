import { redirect, notFound } from "next/navigation";
import Link from "next/link";
import { createSupabaseServerClient } from "@/lib/supabase/server";

export const metadata = {
  title: "Détail évaluation — Admin",
};

const MODULE_LABELS: Record<string, string> = {
  maladie: "Maladie (LAMal + LCA)",
  lpp: "LPP Libre Passage",
  prevoyance: "Prévoyance & 3e pilier",
  hypotheque: "Hypothèque",
};

export default async function AdminAttemptDetail({
  params,
}: {
  params: { attemptId: string };
}) {
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

  const { data: attempt } = await supabase
    .from("training_attempts")
    .select("*")
    .eq("id", params.attemptId)
    .maybeSingle();
  if (!attempt) notFound();

  // Agent
  const { data: agent } = await supabase
    .from("user_roles")
    .select("first_name, last_name, date_of_birth, postal_city")
    .eq("user_id", attempt.user_id)
    .eq("active", true)
    .maybeSingle();
  const { data: authUser } = await supabase.auth.admin
    ?.getUserById?.(attempt.user_id)
    .catch(() => ({ data: null } as any));

  // Cert éventuelle
  const { data: cert } = await supabase
    .from("training_certifications")
    .select("*")
    .eq("attempt_id", params.attemptId)
    .maybeSingle();

  // Questions + réponses
  const rawAnswers = (attempt.raw_answers || {}) as Record<string, number>;
  const questionIds = Object.keys(rawAnswers);
  const { data: questions } = questionIds.length
    ? await supabase
        .from("training_questions")
        .select(
          "id, external_id, category, question, options, correct, explanation, why_wrong, consequence"
        )
        .in("id", questionIds)
    : { data: [] };

  const agentName = agent
    ? [agent.first_name, agent.last_name].filter(Boolean).join(" ")
    : "—";
  const email = (authUser as any)?.user?.email;
  const moduleLabel =
    MODULE_LABELS[attempt.module_key] || attempt.module_key;

  const passed = attempt.passed && !attempt.aborted;
  const finished = !!attempt.finished_at;

  const wrongByCategory: Record<string, number> = {};
  const totalByCategory: Record<string, number> = {};
  for (const q of (questions || []) as any[]) {
    const cat = q.category || "Autre";
    totalByCategory[cat] = (totalByCategory[cat] || 0) + 1;
    if (rawAnswers[q.id] !== q.correct)
      wrongByCategory[cat] = (wrongByCategory[cat] || 0) + 1;
  }

  return (
    <div className="max-w-4xl mx-auto p-6 md:p-10">
      <div className="mb-6">
        <Link
          href="/admin/evaluations"
          className="text-sm text-klary-grey hover:text-klary-orange transition"
        >
          ← Retour aux évaluations
        </Link>
      </div>

      {/* Header agent + module */}
      <div className="bg-white rounded-2xl border border-klary-light-grey p-8 mb-6">
        <div className="text-xs font-bold tracking-widest uppercase text-klary-orange mb-2">
          Évaluation
        </div>
        <h1 className="text-3xl font-bold text-klary-navy mb-2">
          {agentName}
        </h1>
        {email && (
          <div className="text-sm text-klary-grey mb-3">{email}</div>
        )}
        <div className="text-lg text-klary-navy font-semibold mb-4">
          {moduleLabel}
        </div>

        <div className="grid grid-cols-2 md:grid-cols-4 gap-3 text-sm">
          <Kpi
            label="Score"
            value={attempt.score_pct != null ? `${attempt.score_pct}%` : "—"}
            highlight={passed ? "green" : finished ? "red" : "grey"}
          />
          <Kpi
            label="Durée"
            value={
              attempt.time_used_sec != null
                ? `${Math.floor(attempt.time_used_sec / 60)}m ${
                    attempt.time_used_sec % 60
                  }s`
                : "—"
            }
          />
          <Kpi
            label="Avertissements"
            value={String(attempt.cheat_count || 0)}
            highlight={(attempt.cheat_count || 0) > 0 ? "red" : undefined}
          />
          <Kpi
            label="Statut"
            value={
              !finished
                ? "En cours"
                : attempt.aborted
                ? attempt.abort_reason === "cheat"
                  ? "Triche"
                  : "Abandon"
                : passed
                ? "Certifié"
                : "Échoué"
            }
            highlight={
              passed ? "green" : attempt.aborted ? "red" : finished ? "yellow" : undefined
            }
          />
        </div>

        <div className="mt-4 pt-4 border-t border-klary-light-grey text-xs text-klary-grey space-y-1">
          <div>
            Début :{" "}
            {new Date(attempt.started_at).toLocaleString("fr-CH", {
              dateStyle: "full",
              timeStyle: "short",
            } as any)}
          </div>
          {attempt.finished_at && (
            <div>
              Fin :{" "}
              {new Date(attempt.finished_at).toLocaleString("fr-CH", {
                dateStyle: "full",
                timeStyle: "short",
              } as any)}
            </div>
          )}
          {cert && (
            <div className="text-klary-orange font-semibold">
              Certificat n° {cert.cert_number}
              {cert.revoked && (
                <span className="ml-2 px-2 py-0.5 bg-red-100 text-red-700 rounded text-[10px]">
                  RÉVOQUÉ
                </span>
              )}
            </div>
          )}
        </div>
      </div>

      {/* Résumé erreurs par catégorie */}
      {questions && questions.length > 0 && (
        <div className="bg-white rounded-2xl border border-klary-light-grey p-6 mb-6">
          <h2 className="font-bold text-klary-navy mb-4">
            Score par catégorie
          </h2>
          <div className="space-y-2 text-sm">
            {Object.entries(totalByCategory).map(([cat, tot]) => {
              const wrong = wrongByCategory[cat] || 0;
              const pct = Math.round(((tot - wrong) / tot) * 100);
              return (
                <div
                  key={cat}
                  className="flex items-center justify-between py-2 border-b border-klary-light-grey last:border-0"
                >
                  <span className="text-klary-navy">{cat}</span>
                  <span className="text-xs">
                    <span
                      className={
                        pct === 100
                          ? "text-green-700 font-semibold"
                          : pct >= 50
                          ? "text-yellow-700 font-semibold"
                          : "text-red-700 font-semibold"
                      }
                    >
                      {tot - wrong} / {tot} ({pct}%)
                    </span>
                  </span>
                </div>
              );
            })}
          </div>
        </div>
      )}

      {/* Détail question par question */}
      {questions && questions.length > 0 && (
        <div className="bg-white rounded-2xl border border-klary-light-grey p-6">
          <h2 className="font-bold text-klary-navy mb-4">
            Réponses détaillées ({questions.length} questions)
          </h2>
          <div className="space-y-4">
            {questions.map((q: any, idx: number) => {
              const userAns = rawAnswers[q.id];
              const isCorrect = userAns === q.correct;
              const userWhyWrong =
                !isCorrect && Array.isArray(q.why_wrong) && userAns != null
                  ? q.why_wrong[userAns]
                  : null;

              return (
                <div
                  key={q.id}
                  className={`p-4 rounded-xl border-2 ${
                    isCorrect
                      ? "border-green-200 bg-green-50/40"
                      : "border-red-200 bg-red-50/40"
                  }`}
                >
                  <div className="flex items-center justify-between mb-2">
                    <div className="text-xs uppercase tracking-widest text-klary-grey font-bold">
                      Q{idx + 1} · {q.category} · {q.external_id}
                    </div>
                    <span
                      className={`text-xs font-bold px-2 py-0.5 rounded-full ${
                        isCorrect
                          ? "bg-green-600 text-white"
                          : "bg-red-600 text-white"
                      }`}
                    >
                      {isCorrect ? "CORRECT" : "ERREUR"}
                    </span>
                  </div>
                  <div className="font-semibold text-klary-navy mb-3 text-sm leading-relaxed">
                    {q.question}
                  </div>

                  <div className="text-xs space-y-2 mb-3">
                    <div className="grid grid-cols-1 gap-1">
                      {q.options.map((opt: string, i: number) => {
                        const isUser = userAns === i;
                        const isRight = q.correct === i;
                        return (
                          <div
                            key={i}
                            className={`px-3 py-1.5 rounded border ${
                              isRight
                                ? "border-green-400 bg-green-100/60"
                                : isUser
                                ? "border-red-400 bg-red-100/60"
                                : "border-klary-light-grey bg-white"
                            }`}
                          >
                            <span className="mr-2 font-mono text-[10px]">
                              {isRight ? "✓" : isUser ? "✗" : " "}
                            </span>
                            <span
                              className={
                                isRight
                                  ? "text-green-800 font-semibold"
                                  : isUser
                                  ? "text-red-800 line-through"
                                  : "text-klary-grey"
                              }
                            >
                              {opt}
                            </span>
                          </div>
                        );
                      })}
                    </div>
                  </div>

                  {userWhyWrong && (
                    <div className="p-2.5 bg-red-100/60 border-l-4 border-red-500 rounded text-xs text-red-900 mb-2">
                      <div className="text-[9px] uppercase tracking-widest font-bold text-red-700 mb-0.5">
                        Pourquoi la réponse de l'agent est fausse
                      </div>
                      {userWhyWrong}
                    </div>
                  )}
                  {q.explanation && (
                    <div className="p-2.5 bg-klary-cream border-l-4 border-klary-orange rounded text-xs text-klary-ink mb-2">
                      <div className="text-[9px] uppercase tracking-widest font-bold text-klary-orange mb-0.5">
                        Explication
                      </div>
                      {q.explanation}
                    </div>
                  )}
                  {q.consequence && (
                    <div className="p-2.5 bg-klary-navy/5 border-l-4 border-klary-navy rounded text-xs text-klary-navy">
                      <div className="text-[9px] uppercase tracking-widest font-bold text-klary-navy mb-0.5">
                        Conséquence réelle
                      </div>
                      {q.consequence}
                    </div>
                  )}
                </div>
              );
            })}
          </div>
        </div>
      )}
    </div>
  );
}

function Kpi({
  label,
  value,
  highlight,
}: {
  label: string;
  value: string;
  highlight?: "green" | "red" | "yellow" | "grey";
}) {
  const color =
    highlight === "green"
      ? "text-green-700"
      : highlight === "red"
      ? "text-red-700"
      : highlight === "yellow"
      ? "text-yellow-700"
      : "text-klary-navy";
  return (
    <div className="p-3 border border-klary-light-grey rounded-lg bg-white">
      <div className="text-[10px] uppercase tracking-widest text-klary-grey font-bold mb-1">
        {label}
      </div>
      <div className={`text-lg font-bold ${color}`}>{value}</div>
    </div>
  );
}
