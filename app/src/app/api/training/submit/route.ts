import { NextRequest, NextResponse } from "next/server";
import { createSupabaseServerClient } from "@/lib/supabase/server";
import {
  generateCertNumber,
  calculateScore,
  addMonths,
} from "@/lib/training/scoring";

/**
 * POST /api/training/submit
 * Body: { attemptId, answers: { [questionId]: chosenIndex }, cheat_count, time_used_sec, aborted?, abort_reason? }
 * Réponse: { attempt, passed, score_pct, certification? }
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
    const attemptId = String(body.attemptId || "");
    const answers: Record<string, number | null> = body.answers || {};
    const cheatCount = Number(body.cheat_count || 0);
    const timeUsedSec = Number(body.time_used_sec || 0);
    const aborted = Boolean(body.aborted);
    const abortReason: string | null = body.abort_reason || null;

    if (!attemptId) {
      return NextResponse.json(
        { error: "attemptId requis" },
        { status: 400 }
      );
    }

    // Récupérer l'attempt (vérifier ownership)
    const { data: attempt, error: attErr } = await supabase
      .from("training_attempts")
      .select("*")
      .eq("id", attemptId)
      .eq("user_id", user.id)
      .single();

    if (attErr || !attempt) {
      return NextResponse.json(
        { error: "Tentative introuvable" },
        { status: 404 }
      );
    }

    if (attempt.finished_at) {
      return NextResponse.json(
        { error: "Tentative déjà terminée" },
        { status: 400 }
      );
    }

    // Récupérer les bonnes réponses depuis les questions correspondant au module
    const { data: questions } = await supabase
      .from("training_questions")
      .select("id, correct")
      .eq("module_key", attempt.module_key)
      .eq("active", true);

    const correctMap: Record<string, number> = {};
    for (const q of questions || []) {
      correctMap[q.id] = q.correct;
    }

    // Calculer le score (sur les questions PRÉSENTÉES au user = clés de `answers`)
    const answeredMap = { ...correctMap };
    // On ne score que les questions que l'utilisateur a effectivement vues
    const presentedIds = new Set(Object.keys(answers));
    const filteredCorrect: Record<string, number> = {};
    for (const id of Object.keys(correctMap)) {
      if (presentedIds.has(id)) filteredCorrect[id] = correctMap[id];
    }
    const { correct, total, pct } = calculateScore(answers, filteredCorrect);

    // Récupérer le module pour connaître passing_score
    const { data: moduleData } = await supabase
      .from("training_modules")
      .select("passing_score, title")
      .eq("key", attempt.module_key)
      .single();

    const passingScore = moduleData?.passing_score || 80;
    const passed = !aborted && pct >= passingScore;

    // Mettre à jour l'attempt
    await supabase
      .from("training_attempts")
      .update({
        finished_at: new Date().toISOString(),
        score_pct: pct,
        passed,
        cheat_count: cheatCount,
        aborted,
        abort_reason: abortReason,
        raw_answers: answers,
        time_used_sec: timeUsedSec,
      })
      .eq("id", attemptId);

    // Si réussi → créer la certification (6 mois de validité)
    let certification = null;
    if (passed) {
      const validUntil = addMonths(new Date(), 6);
      const certNumber = generateCertNumber();

      const { data: certData } = await supabase
        .from("training_certifications")
        .insert({
          cert_number: certNumber,
          user_id: user.id,
          module_key: attempt.module_key,
          attempt_id: attemptId,
          score_pct: pct,
          valid_until: validUntil.toISOString().split("T")[0],
        })
        .select()
        .single();

      certification = certData;
    }

    return NextResponse.json({
      passed,
      score_pct: pct,
      correct_count: correct,
      total_count: total,
      passing_score: passingScore,
      certification,
      aborted,
    });
  } catch (error) {
    console.error("training/submit error:", error);
    return NextResponse.json({ error: "Erreur serveur" }, { status: 500 });
  }
}
