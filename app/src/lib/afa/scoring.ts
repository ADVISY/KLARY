/**
 * Scoring des sessions de révision AFA.
 *
 * Le règlement VBV (art. 3.72) parle de « points obtenus pour les bonnes
 * réponses » sans détailler de malus, et le barème exact n'est communiqué
 * que pendant l'épreuve. On ne peut donc pas reproduire le barème officiel
 * à l'identique. On calcule DEUX scores et on affiche les deux :
 *
 *  - partiel : crédit proportionnel, avec pénalité pour chaque option fausse
 *              cochée. C'est l'estimation la plus proche d'un barème VBV.
 *  - strict  : tout ou rien par question.
 *
 * Afficher les deux est délibéré. Un score partiel seul récompense le fait
 * de « cocher large », ce qui entraîne un réflexe risqué si l'examen réel
 * pénalise les mauvaises cases. L'écart entre les deux scores est en
 * lui-même le diagnostic : partiel élevé + strict bas = réponses
 * incomplètes, ce qui est le motif d'échec le plus courant.
 */

export type AfaOption = {
  text: string;
  correct: boolean;
  why_wrong?: string | null;
};

export type AfaQuestionScoring = {
  id: string;
  points: number;
  options: AfaOption[];
};

export type QuestionResult = {
  questionId: string;
  pointsMax: number;
  pointsPartial: number;
  pointsStrict: number;
  isPerfect: boolean;
  /** null si la question est juste, ou non répondue sans sélection */
  errorType: "omission" | "commission" | "mixte" | null;
  correctIndices: number[];
  missedIndices: number[];
  wrongIndices: number[];
};

/**
 * Score une question.
 *
 * Partiel = points × max(0, justesCochées − faussesCochées) / nbJustes
 * Strict  = points si l'ensemble coché est exactement l'ensemble juste, sinon 0
 */
export function scoreQuestion(
  question: AfaQuestionScoring,
  selected: number[]
): QuestionResult {
  const correctIndices = question.options
    .map((o, i) => (o.correct ? i : -1))
    .filter((i) => i >= 0);

  const sel = new Set(selected);
  const correctSet = new Set(correctIndices);

  const hits = correctIndices.filter((i) => sel.has(i));
  const wrongIndices = selected.filter((i) => !correctSet.has(i));
  const missedIndices = correctIndices.filter((i) => !sel.has(i));

  const nbCorrect = correctIndices.length || 1;
  const rawPartial = (hits.length - wrongIndices.length) / nbCorrect;
  const pointsPartial = Math.max(0, Math.round(rawPartial * question.points));

  const isPerfect =
    missedIndices.length === 0 &&
    wrongIndices.length === 0 &&
    selected.length > 0;

  const pointsStrict = isPerfect ? question.points : 0;

  let errorType: QuestionResult["errorType"] = null;
  if (!isPerfect && selected.length > 0) {
    if (missedIndices.length > 0 && wrongIndices.length > 0) errorType = "mixte";
    else if (missedIndices.length > 0) errorType = "omission";
    else errorType = "commission";
  } else if (!isPerfect) {
    // aucune case cochée : compte comme une omission
    errorType = "omission";
  }

  return {
    questionId: question.id,
    pointsMax: question.points,
    pointsPartial,
    pointsStrict,
    isPerfect,
    errorType,
    correctIndices,
    missedIndices,
    wrongIndices,
  };
}

export type SessionScore = {
  pointsMax: number;
  pointsPartial: number;
  pointsStrict: number;
  scorePctPartial: number;
  scorePctStrict: number;
  perfectCount: number;
  total: number;
  /** Répartition des erreurs — pilote la remédiation affichée. */
  errorBreakdown: { omission: number; commission: number; mixte: number };
  results: QuestionResult[];
};

export function scoreSession(
  questions: AfaQuestionScoring[],
  answers: Record<string, number[]>
): SessionScore {
  const results = questions.map((q) => scoreQuestion(q, answers[q.id] ?? []));

  const pointsMax = results.reduce((s, r) => s + r.pointsMax, 0);
  const pointsPartial = results.reduce((s, r) => s + r.pointsPartial, 0);
  const pointsStrict = results.reduce((s, r) => s + r.pointsStrict, 0);

  const errorBreakdown = { omission: 0, commission: 0, mixte: 0 };
  for (const r of results) {
    if (r.errorType) errorBreakdown[r.errorType]++;
  }

  const pct = (v: number) =>
    pointsMax > 0 ? Math.round((v / pointsMax) * 100) : 0;

  return {
    pointsMax,
    pointsPartial,
    pointsStrict,
    scorePctPartial: pct(pointsPartial),
    scorePctStrict: pct(pointsStrict),
    perfectCount: results.filter((r) => r.isPerfect).length,
    total: results.length,
    errorBreakdown,
    results,
  };
}

/** Mélange sans muter l'entrée. */
export function shuffle<T>(arr: T[]): T[] {
  const a = [...arr];
  for (let i = a.length - 1; i > 0; i--) {
    const j = Math.floor(Math.random() * (i + 1));
    [a[i], a[j]] = [a[j], a[i]];
  }
  return a;
}

/** Format mm:ss pour le chrono. */
export function formatDuration(sec: number): string {
  const m = Math.floor(Math.max(0, sec) / 60);
  const s = Math.max(0, sec) % 60;
  return `${String(m).padStart(2, "0")}:${String(s).padStart(2, "0")}`;
}
