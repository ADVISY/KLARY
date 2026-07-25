/**
 * Utilitaires de scoring et de génération pour le module formation.
 */

export function generateCertNumber(): string {
  const now = new Date();
  const y = now.getFullYear().toString().slice(-2);
  const m = String(now.getMonth() + 1).padStart(2, "0");
  const d = String(now.getDate()).padStart(2, "0");
  const rand = Math.random().toString(36).substring(2, 6).toUpperCase();
  return `KLA-${y}${m}${d}-${rand}`;
}

export function shuffleArray<T>(arr: T[]): T[] {
  const a = [...arr];
  for (let i = a.length - 1; i > 0; i--) {
    const j = Math.floor(Math.random() * (i + 1));
    [a[i], a[j]] = [a[j], a[i]];
  }
  return a;
}

export function calculateScore(
  answers: Record<string, number | null>,
  correctAnswers: Record<string, number>
): { correct: number; total: number; pct: number } {
  const total = Object.keys(correctAnswers).length;
  let correct = 0;
  for (const [qId, correctIdx] of Object.entries(correctAnswers)) {
    if (answers[qId] === correctIdx) correct++;
  }
  const pct = total > 0 ? Math.round((correct / total) * 100) : 0;
  return { correct, total, pct };
}

export function addMonths(date: Date, months: number): Date {
  const d = new Date(date);
  d.setMonth(d.getMonth() + months);
  return d;
}
