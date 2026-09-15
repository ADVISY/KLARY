"use client";

import { useCallback, useEffect, useRef, useState } from "react";
import Link from "next/link";
import { formatDuration } from "@/lib/afa/scoring";

type Option = { text: string };
type Question = {
  id: string;
  external_id: string | null;
  question_type: string;
  context: string | null;
  question: string;
  points: number;
  options: Option[];
};

type CorrectionOption = {
  text: string;
  correct: boolean;
  why_wrong?: string | null;
};
type CorrectionItem = {
  id: string;
  question: string;
  context: string | null;
  explanation: string | null;
  points: number;
  options: CorrectionOption[];
  selected: number[];
  pointsPartial: number;
  pointsStrict: number;
  isPerfect: boolean;
  errorType: "omission" | "commission" | "mixte" | null;
  missedIndices: number[];
  wrongIndices: number[];
};
type Result = {
  passingPct: number;
  passed: boolean;
  pointsMax: number;
  pointsPartial: number;
  pointsStrict: number;
  scorePctPartial: number;
  scorePctStrict: number;
  perfectCount: number;
  total: number;
  errorBreakdown: { omission: number; commission: number; mixte: number };
  correction: CorrectionItem[];
};

export function AfaRunner({
  filiereKey,
  mode,
  themeKey,
  title,
  backHref,
}: {
  filiereKey: string;
  mode: "simulation" | "drill" | "pieges";
  themeKey?: string;
  title: string;
  backHref: string;
}) {
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);
  const [sessionId, setSessionId] = useState<string | null>(null);
  const [questions, setQuestions] = useState<Question[]>([]);
  const [answers, setAnswers] = useState<Record<string, number[]>>({});
  const [index, setIndex] = useState(0);
  const [remaining, setRemaining] = useState<number | null>(null);
  const [result, setResult] = useState<Result | null>(null);
  const [submitting, setSubmitting] = useState(false);

  const startedAt = useRef<number>(Date.now());
  const submittedRef = useRef(false);

  // ─── Démarrage
  useEffect(() => {
    let cancelled = false;
    (async () => {
      try {
        const res = await fetch("/api/afa/session/start", {
          method: "POST",
          headers: { "Content-Type": "application/json" },
          body: JSON.stringify({
            filiere_key: filiereKey,
            mode,
            theme_key: themeKey,
          }),
        });
        const data = await res.json();
        if (cancelled) return;
        if (!res.ok) {
          setError(data.error || "Impossible de démarrer la session");
          return;
        }
        setSessionId(data.sessionId);
        setQuestions(data.questions);
        setRemaining(data.durationSec ?? null);
        startedAt.current = Date.now();
      } catch {
        if (!cancelled) setError("Erreur réseau");
      } finally {
        if (!cancelled) setLoading(false);
      }
    })();
    return () => {
      cancelled = true;
    };
  }, [filiereKey, mode, themeKey]);

  const submit = useCallback(
    async (auto: boolean) => {
      if (submittedRef.current || !sessionId) return;
      submittedRef.current = true;
      setSubmitting(true);
      try {
        const res = await fetch("/api/afa/session/submit", {
          method: "POST",
          headers: { "Content-Type": "application/json" },
          body: JSON.stringify({
            sessionId,
            answers,
            timeUsedSec: Math.round((Date.now() - startedAt.current) / 1000),
            autoSubmitted: auto,
          }),
        });
        const data = await res.json();
        if (!res.ok) {
          setError(data.error || "Erreur lors de la correction");
          submittedRef.current = false;
          return;
        }
        setResult(data);
      } catch {
        setError("Erreur réseau");
        submittedRef.current = false;
      } finally {
        setSubmitting(false);
      }
    },
    [answers, sessionId]
  );

  // ─── Chrono avec remise automatique
  useEffect(() => {
    if (remaining === null || result) return;
    if (remaining <= 0) {
      void submit(true);
      return;
    }
    const t = setTimeout(() => setRemaining((r) => (r === null ? r : r - 1)), 1000);
    return () => clearTimeout(t);
  }, [remaining, result, submit]);

  const toggle = (qId: string, optIdx: number, single: boolean) => {
    setAnswers((prev) => {
      const cur = prev[qId] ?? [];
      if (single) return { ...prev, [qId]: cur[0] === optIdx ? [] : [optIdx] };
      return {
        ...prev,
        [qId]: cur.includes(optIdx)
          ? cur.filter((i) => i !== optIdx)
          : [...cur, optIdx].sort((a, b) => a - b),
      };
    });
  };

  if (loading) {
    return <Centered>Préparation de la session…</Centered>;
  }
  if (error) {
    return (
      <Centered>
        <p className="text-klary-orange font-medium mb-4">{error}</p>
        <Link href={backHref} className="text-klary-navy underline">
          Retour
        </Link>
      </Centered>
    );
  }
  if (result) {
    return <Correction result={result} backHref={backHref} />;
  }

  const q = questions[index];
  if (!q) return <Centered>Aucune question.</Centered>;

  const single = q.question_type === "single" || q.question_type === "vrai_faux";
  const selected = answers[q.id] ?? [];
  const answeredCount = Object.values(answers).filter((a) => a.length > 0).length;
  const lowTime = remaining !== null && remaining <= 300;

  return (
    <div className="max-w-3xl mx-auto p-6 md:p-10">
      {/* En-tête : progression + chrono */}
      <div className="flex items-center justify-between gap-4 mb-6">
        <div>
          <div className="text-xs font-bold tracking-widest uppercase text-klary-orange">
            {title}
          </div>
          <div className="text-sm text-klary-grey mt-1">
            Question {index + 1} sur {questions.length} · {answeredCount}{" "}
            répondue{answeredCount > 1 ? "s" : ""}
          </div>
        </div>
        {remaining !== null && (
          <div
            className={`text-2xl font-bold tabular-nums px-4 py-2 rounded-lg ${
              lowTime
                ? "bg-klary-orange text-white"
                : "bg-klary-cream text-klary-navy"
            }`}
            role="timer"
            aria-live={lowTime ? "assertive" : "off"}
          >
            {formatDuration(remaining)}
          </div>
        )}
      </div>

      <div className="h-1.5 bg-klary-light-grey rounded-full mb-8 overflow-hidden">
        <div
          className="h-full bg-klary-navy transition-all"
          style={{ width: `${((index + 1) / questions.length) * 100}%` }}
        />
      </div>

      {/* Question */}
      <article className="rounded-2xl border border-klary-light-grey bg-white p-6 mb-6">
        {q.context && (
          <p className="text-sm italic text-klary-grey border-l-2 border-klary-orange pl-4 mb-4">
            {q.context}
          </p>
        )}
        <h2 className="text-lg font-semibold text-klary-navy mb-1">
          {q.question}
        </h2>
        <p className="text-xs text-klary-grey mb-5">
          {q.points} point{q.points > 1 ? "s" : ""} ·{" "}
          {single ? "une seule réponse" : "plusieurs réponses possibles"}
        </p>

        <ul className="space-y-2">
          {q.options.map((o, i) => {
            const checked = selected.includes(i);
            return (
              <li key={i}>
                <label
                  className={`flex gap-3 items-start p-4 rounded-xl border cursor-pointer transition ${
                    checked
                      ? "border-klary-navy bg-klary-navy/5"
                      : "border-klary-light-grey hover:border-klary-grey"
                  }`}
                >
                  <input
                    type={single ? "radio" : "checkbox"}
                    name={`q-${q.id}`}
                    checked={checked}
                    onChange={() => toggle(q.id, i, single)}
                    className="mt-1 accent-klary-navy"
                  />
                  <span className="text-sm text-klary-ink">{o.text}</span>
                </label>
              </li>
            );
          })}
        </ul>
      </article>

      {/* Navigation */}
      <div className="flex items-center justify-between gap-3">
        <button
          type="button"
          onClick={() => setIndex((i) => Math.max(0, i - 1))}
          disabled={index === 0}
          className="px-5 py-2.5 rounded-lg border border-klary-light-grey text-klary-navy disabled:opacity-40"
        >
          Précédent
        </button>

        {index < questions.length - 1 ? (
          <button
            type="button"
            onClick={() => setIndex((i) => i + 1)}
            className="px-5 py-2.5 rounded-lg bg-klary-navy text-white font-medium"
          >
            Suivant
          </button>
        ) : (
          <button
            type="button"
            onClick={() => void submit(false)}
            disabled={submitting}
            className="px-5 py-2.5 rounded-lg bg-klary-orange text-white font-medium disabled:opacity-60"
          >
            {submitting ? "Correction…" : "Terminer et corriger"}
          </button>
        )}
      </div>

      {/* Accès direct aux questions */}
      <div className="flex flex-wrap gap-2 mt-8">
        {questions.map((qq, i) => {
          const done = (answers[qq.id] ?? []).length > 0;
          return (
            <button
              key={qq.id}
              type="button"
              onClick={() => setIndex(i)}
              aria-label={`Aller à la question ${i + 1}`}
              className={`w-9 h-9 rounded-lg text-xs font-medium border transition ${
                i === index
                  ? "bg-klary-navy text-white border-klary-navy"
                  : done
                  ? "bg-klary-cream text-klary-navy border-klary-light-grey"
                  : "bg-white text-klary-grey border-klary-light-grey"
              }`}
            >
              {i + 1}
            </button>
          );
        })}
      </div>
    </div>
  );
}

function Centered({ children }: { children: React.ReactNode }) {
  return (
    <div className="max-w-3xl mx-auto p-10 text-center text-klary-grey">
      {children}
    </div>
  );
}

function Correction({
  result,
  backHref,
}: {
  result: Result;
  backHref: string;
}) {
  const { errorBreakdown } = result;
  const ecart = result.scorePctPartial - result.scorePctStrict;

  return (
    <div className="max-w-3xl mx-auto p-6 md:p-10">
      <header className="mb-8">
        <div className="text-xs font-bold tracking-widest uppercase text-klary-orange mb-2">
          Résultat
        </div>
        <h1 className="text-3xl font-bold text-klary-navy">
          {result.passed ? "Seuil atteint" : "Seuil non atteint"}
        </h1>
        <p className="text-klary-grey mt-2">
          Le seuil de réussite est de {result.passingPct} % des points.
        </p>
      </header>

      <div className="grid gap-4 sm:grid-cols-3 mb-6">
        <ScoreCard
          label="Score partiel"
          value={`${result.scorePctPartial} %`}
          hint={`${result.pointsPartial} / ${result.pointsMax} points`}
          highlight={result.passed}
        />
        <ScoreCard
          label="Score strict"
          value={`${result.scorePctStrict} %`}
          hint={`${result.perfectCount} / ${result.total} questions parfaites`}
        />
        <ScoreCard
          label="Écart"
          value={`${ecart} pts`}
          hint="Partiel moins strict"
        />
      </div>

      {/* Diagnostic — c'est la partie qui oriente la révision */}
      <section className="rounded-2xl bg-klary-cream border border-klary-light-grey p-6 mb-8">
        <h2 className="font-bold text-klary-navy mb-3">Diagnostic</h2>
        {errorBreakdown.omission > 0 && (
          <p className="text-sm text-klary-ink mb-2">
            <strong>{errorBreakdown.omission}</strong> question
            {errorBreakdown.omission > 1 ? "s" : ""} où des bonnes réponses ont
            été oubliées. Les cases cochées étaient justes, mais incomplètes.
            C&apos;est le motif d&apos;échec le plus coûteux : chaque option manquée
            retire des points sans qu&apos;on s&apos;en rende compte.
          </p>
        )}
        {errorBreakdown.commission > 0 && (
          <p className="text-sm text-klary-ink mb-2">
            <strong>{errorBreakdown.commission}</strong> question
            {errorBreakdown.commission > 1 ? "s" : ""} où une option fausse a été
            cochée. Cocher large ne paie pas : chaque erreur annule une bonne
            réponse.
          </p>
        )}
        {errorBreakdown.mixte > 0 && (
          <p className="text-sm text-klary-ink mb-2">
            <strong>{errorBreakdown.mixte}</strong> question
            {errorBreakdown.mixte > 1 ? "s" : ""} à la fois incomplète
            {errorBreakdown.mixte > 1 ? "s" : ""} et comportant une erreur.
          </p>
        )}
        {ecart >= 20 && (
          <p className="text-sm text-klary-ink mt-3 pt-3 border-t border-klary-light-grey">
            L&apos;écart de {ecart} points entre partiel et strict est important : la
            matière est comprise, mais les réponses ne sont pas menées jusqu&apos;au
            bout. Sur chaque question à choix multiples, relire les options non
            cochées avant de valider.
          </p>
        )}
        {errorBreakdown.omission === 0 &&
          errorBreakdown.commission === 0 &&
          errorBreakdown.mixte === 0 && (
            <p className="text-sm text-klary-ink">
              Aucune erreur sur cette session.
            </p>
          )}
      </section>

      {/* Correction détaillée */}
      <h2 className="text-lg font-bold text-klary-navy mb-4">Correction</h2>
      <ol className="space-y-5">
        {result.correction.map((c, n) => (
          <li
            key={c.id}
            className={`rounded-2xl border p-5 ${
              c.isPerfect
                ? "border-emerald-200 bg-emerald-50/40"
                : "border-klary-light-grey bg-white"
            }`}
          >
            <div className="flex items-start justify-between gap-4 mb-3">
              <h3 className="font-semibold text-klary-navy">
                {n + 1}. {c.question}
              </h3>
              <span className="shrink-0 text-xs font-medium text-klary-grey">
                {c.pointsPartial} / {c.points} pt
                {c.points > 1 ? "s" : ""}
              </span>
            </div>

            {c.context && (
              <p className="text-sm italic text-klary-grey mb-3">{c.context}</p>
            )}

            <ul className="space-y-2 mb-3">
              {c.options.map((o, i) => {
                const chosen = c.selected.includes(i);
                const missed = c.missedIndices.includes(i);
                const wrong = c.wrongIndices.includes(i);
                return (
                  <li
                    key={i}
                    className={`text-sm p-3 rounded-lg border ${
                      o.correct
                        ? "border-emerald-300 bg-emerald-50"
                        : wrong
                        ? "border-red-300 bg-red-50"
                        : "border-klary-light-grey bg-white"
                    }`}
                  >
                    <div className="flex gap-2">
                      <span aria-hidden>
                        {o.correct ? "✓" : chosen ? "✗" : "·"}
                      </span>
                      <div>
                        <span className="text-klary-ink">{o.text}</span>
                        {missed && (
                          <span className="ml-2 text-xs font-semibold text-klary-orange">
                            oubliée
                          </span>
                        )}
                        {o.why_wrong && (
                          <p className="text-xs text-klary-grey mt-1">
                            {o.why_wrong}
                          </p>
                        )}
                      </div>
                    </div>
                  </li>
                );
              })}
            </ul>

            {c.explanation && (
              <p className="text-sm text-klary-ink bg-klary-cream rounded-lg p-3">
                {c.explanation}
              </p>
            )}
          </li>
        ))}
      </ol>

      <div className="mt-8 flex gap-3">
        <Link
          href={backHref}
          className="px-5 py-2.5 rounded-lg bg-klary-navy text-white font-medium"
        >
          Retour à la révision
        </Link>
      </div>
    </div>
  );
}

function ScoreCard({
  label,
  value,
  hint,
  highlight,
}: {
  label: string;
  value: string;
  hint: string;
  highlight?: boolean;
}) {
  return (
    <div
      className={`rounded-xl border p-5 ${
        highlight
          ? "border-emerald-300 bg-emerald-50"
          : "border-klary-light-grey bg-white"
      }`}
    >
      <div className="text-xs uppercase tracking-wide text-klary-grey mb-1">
        {label}
      </div>
      <div className="text-3xl font-bold text-klary-navy">{value}</div>
      <div className="text-xs text-klary-grey mt-1">{hint}</div>
    </div>
  );
}
