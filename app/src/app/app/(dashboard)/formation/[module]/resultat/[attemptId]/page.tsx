import Link from "next/link";
import { notFound, redirect } from "next/navigation";
import { createSupabaseServerClient } from "@/lib/supabase/server";

export const metadata = {
  title: "Résultat de l'évaluation",
  robots: "noindex, nofollow",
};

export default async function ResultPage({
  params,
}: {
  params: { module: string; attemptId: string };
}) {
  const supabase = createSupabaseServerClient();
  const {
    data: { user },
  } = await supabase.auth.getUser();
  if (!user) redirect("/login");

  const { data: attempt } = await supabase
    .from("training_attempts")
    .select("*, training_modules(title, passing_score)")
    .eq("id", params.attemptId)
    .eq("user_id", user.id)
    .maybeSingle();

  if (!attempt) notFound();

  if (!attempt.finished_at) {
    redirect(`/formation/${params.module}/quiz`);
  }

  // Certification si passed
  const { data: cert } = await supabase
    .from("training_certifications")
    .select("*")
    .eq("attempt_id", params.attemptId)
    .maybeSingle();

  const rawAnswers = (attempt.raw_answers || {}) as Record<string, number>;
  const questionIds = Object.keys(rawAnswers);

  const { data: questions } = questionIds.length
    ? await supabase
        .from("training_questions")
        .select("id, external_id, category, question, options, correct, explanation")
        .in("id", questionIds)
    : { data: [] };

  const passed = attempt.passed && !attempt.aborted;
  const passingScore = (attempt as any).training_modules?.passing_score || 80;
  const moduleTitle = (attempt as any).training_modules?.title || attempt.module_key;

  return (
    <div className="max-w-3xl mx-auto p-6 md:p-10">
      {/* Header résultat */}
      <div
        className={`rounded-2xl p-8 md:p-10 text-center mb-6 border-2 ${
          passed
            ? "bg-green-50 border-green-200"
            : attempt.aborted
            ? "bg-red-50 border-red-200"
            : "bg-yellow-50 border-yellow-200"
        }`}
      >
        <div
          className={`w-20 h-20 rounded-full mx-auto mb-5 flex items-center justify-center text-4xl font-bold text-white ${
            passed ? "bg-green-600" : attempt.aborted ? "bg-red-600" : "bg-yellow-500"
          }`}
        >
          {passed ? "✓" : "✕"}
        </div>
        <h1 className="text-3xl font-bold text-klary-navy mb-2">
          {passed
            ? "Félicitations, vous êtes certifié·e !"
            : attempt.aborted
            ? attempt.abort_reason === "cheat"
              ? "Évaluation interrompue."
              : "Temps écoulé."
            : "Non validé cette fois."}
        </h1>
        <p className="text-klary-grey mb-6">
          {passed
            ? `Vous êtes maintenant Klary — apte à conseiller : ${moduleTitle}`
            : `Score minimum requis : ${passingScore}%. Un complément de formation est nécessaire avant de repasser.`}
        </p>

        <div className="inline-flex items-center gap-8 bg-white rounded-xl p-5 border border-klary-light-grey">
          <div>
            <div className="text-[10px] uppercase tracking-widest text-klary-grey font-bold mb-1">
              Score
            </div>
            <div className="text-4xl font-bold text-klary-navy">
              {attempt.score_pct ?? 0}%
            </div>
          </div>
          <div className="w-px h-12 bg-klary-light-grey" />
          <div>
            <div className="text-[10px] uppercase tracking-widest text-klary-grey font-bold mb-1">
              Temps
            </div>
            <div className="text-2xl font-bold text-klary-navy">
              {Math.floor((attempt.time_used_sec || 0) / 60)}m{" "}
              {(attempt.time_used_sec || 0) % 60}s
            </div>
          </div>
        </div>
      </div>

      {/* Attestation */}
      {passed && cert && (
        <div className="bg-white rounded-2xl border-2 border-klary-orange/30 p-6 mb-6">
          <div className="flex items-start justify-between gap-4 mb-4">
            <div>
              <div className="text-xs uppercase tracking-widest text-klary-orange font-bold mb-1">
                Attestation
              </div>
              <div className="text-lg font-bold text-klary-navy">
                {cert.cert_number}
              </div>
            </div>
            <div className="text-right">
              <div className="text-xs text-klary-grey">Valide jusqu'au</div>
              <div className="text-sm font-semibold text-klary-navy">
                {new Date(cert.valid_until).toLocaleDateString("fr-CH")}
              </div>
            </div>
          </div>
          <p className="text-sm text-klary-grey">
            Votre attestation officielle a été enregistrée. Consultez-la dans{" "}
            <Link
              href="/certifications"
              className="text-klary-orange font-semibold hover:underline"
            >
              Mes certifications
            </Link>
            .
          </p>
        </div>
      )}

      {/* Correction détaillée */}
      {questions && questions.length > 0 && !attempt.aborted && (
        <details className="bg-white rounded-2xl border border-klary-light-grey p-6">
          <summary className="font-bold text-klary-navy cursor-pointer">
            Voir la correction détaillée ({questions.length} questions)
          </summary>
          <div className="mt-6 space-y-5">
            {questions.map((q: any, idx: number) => {
              const userAns = rawAnswers[q.id];
              const isCorrect = userAns === q.correct;
              return (
                <div
                  key={q.id}
                  className="pb-5 border-b border-klary-light-grey last:border-b-0 last:pb-0"
                >
                  <div className="text-xs uppercase tracking-widest text-klary-grey mb-1 font-bold">
                    Question {idx + 1} · {q.category}
                  </div>
                  <div className="font-semibold text-klary-navy mb-2">
                    {q.question}
                  </div>
                  <div className="text-sm space-y-1 mb-3">
                    <div>
                      Votre réponse :{" "}
                      <span
                        className={
                          isCorrect
                            ? "text-green-700 font-semibold"
                            : "text-red-700 font-semibold"
                        }
                      >
                        {userAns !== null && userAns !== undefined
                          ? q.options[userAns]
                          : "Non répondu"}
                      </span>
                    </div>
                    {!isCorrect && (
                      <div>
                        Bonne réponse :{" "}
                        <span className="text-green-700 font-semibold">
                          {q.options[q.correct]}
                        </span>
                      </div>
                    )}
                  </div>
                  {q.explanation && (
                    <div className="p-3 bg-klary-cream rounded-lg text-sm text-klary-ink border-l-4 border-klary-orange">
                      💡 {q.explanation}
                    </div>
                  )}
                </div>
              );
            })}
          </div>
        </details>
      )}

      {/* Actions */}
      <div className="mt-6 flex flex-col sm:flex-row gap-3">
        <Link
          href="/formation"
          className="flex-1 py-3 text-center bg-white border border-klary-light-grey text-klary-navy font-semibold rounded-xl hover:border-klary-navy transition"
        >
          Retour aux modules
        </Link>
        {passed && (
          <Link
            href="/certifications"
            className="flex-1 py-3 text-center bg-klary-orange text-white font-semibold rounded-xl hover:bg-klary-orange/90 transition"
          >
            Voir mes certifications
          </Link>
        )}
      </div>
    </div>
  );
}
