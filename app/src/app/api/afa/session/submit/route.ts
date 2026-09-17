import { NextRequest, NextResponse } from "next/server";
import { createSupabaseServerClient } from "@/lib/supabase/server";
import { scoreSession, type AfaOption } from "@/lib/afa/scoring";

/**
 * POST /api/afa/session/submit
 * Body: { sessionId, answers: { [questionId]: number[] }, timeUsedSec, autoSubmitted? }
 *
 * Corrige la session et renvoie le détail question par question,
 * avec le double score (partiel / strict) et le diagnostic d'erreurs.
 */
export async function POST(request: NextRequest) {
  try {
    const supabase = createSupabaseServerClient();
    const {
      data: { user },
    } = await supabase.auth.getUser();
    if (!user) {
      return NextResponse.json({ error: "Non authentifié" }, { status: 401 });
    }

    const body = await request.json();
    const sessionId = String(body.sessionId || "");
    const answers: Record<string, number[]> = body.answers || {};
    const timeUsedSec = Number(body.timeUsedSec) || 0;
    const autoSubmitted = Boolean(body.autoSubmitted);

    const { data: session } = await supabase
      .from("afa_sessions")
      .select("id, user_id, filiere_key, mode, question_ids, finished_at")
      .eq("id", sessionId)
      .eq("user_id", user.id)
      .single();

    if (!session) {
      return NextResponse.json({ error: "Session introuvable" }, { status: 404 });
    }
    if (session.finished_at) {
      return NextResponse.json(
        { error: "Session déjà terminée" },
        { status: 400 }
      );
    }

    // On ne score que les questions réellement présentées.
    const presentedIds = session.question_ids as string[];
    const { data: questions } = await supabase
      .from("afa_questions")
      .select("id, external_id, question, context, options, points, explanation")
      .in("id", presentedIds);

    if (!questions?.length) {
      return NextResponse.json(
        { error: "Questions introuvables" },
        { status: 500 }
      );
    }

    const ordered = presentedIds
      .map((id) => questions.find((q) => q.id === id))
      .filter((q): q is NonNullable<typeof q> => Boolean(q));

    const scored = scoreSession(
      ordered.map((q) => ({
        id: q.id,
        points: q.points,
        options: q.options as AfaOption[],
      })),
      answers
    );

    const { data: filiere } = await supabase
      .from("afa_filieres")
      .select("passing_pct, internal_target_pct")
      .eq("key", session.filiere_key)
      .single();

    // Cible interne Klary (80 %) : plus haute que le seuil officiel VBV (60 %)
    // pour donner une marge de sécurité au candidat.
    const targetPct = filiere?.internal_target_pct ?? 80;
    const passed = scored.scorePctPartial >= targetPct;

    await supabase
      .from("afa_sessions")
      .update({
        finished_at: new Date().toISOString(),
        time_used_sec: timeUsedSec,
        auto_submitted: autoSubmitted,
        points_max: scored.pointsMax,
        points_partial: scored.pointsPartial,
        points_strict: scored.pointsStrict,
        score_pct_partial: scored.scorePctPartial,
        score_pct_strict: scored.scorePctStrict,
        passed,
      })
      .eq("id", sessionId);

    // Une ligne par question : c'est ce qui alimente le suivi par notion.
    const answerRows = scored.results.map((r) => ({
      session_id: sessionId,
      question_id: r.questionId,
      selected: answers[r.questionId] ?? [],
      points_max: r.pointsMax,
      points_partial: r.pointsPartial,
      points_strict: r.pointsStrict,
      is_perfect: r.isPerfect,
      error_type: r.errorType,
    }));
    await supabase.from("afa_answers").upsert(answerRows, {
      onConflict: "session_id,question_id",
    });

    // Correction détaillée : c'est seulement ici qu'on renvoie le corrigé.
    const correction = ordered.map((q) => {
      const r = scored.results.find((x) => x.questionId === q.id)!;
      return {
        id: q.id,
        externalId: q.external_id,
        context: q.context,
        question: q.question,
        explanation: q.explanation,
        points: q.points,
        options: q.options as AfaOption[],
        selected: answers[q.id] ?? [],
        pointsPartial: r.pointsPartial,
        pointsStrict: r.pointsStrict,
        isPerfect: r.isPerfect,
        errorType: r.errorType,
        missedIndices: r.missedIndices,
        wrongIndices: r.wrongIndices,
      };
    });

    return NextResponse.json({
      passingPct: filiere?.passing_pct ?? 60,
      targetPct,
      passed,
      pointsMax: scored.pointsMax,
      pointsPartial: scored.pointsPartial,
      pointsStrict: scored.pointsStrict,
      scorePctPartial: scored.scorePctPartial,
      scorePctStrict: scored.scorePctStrict,
      perfectCount: scored.perfectCount,
      total: scored.total,
      errorBreakdown: scored.errorBreakdown,
      correction,
    });
  } catch (err) {
    console.error("[afa/session/submit]", err);
    return NextResponse.json({ error: "Erreur serveur" }, { status: 500 });
  }
}
