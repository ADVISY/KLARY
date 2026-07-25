import { NextRequest, NextResponse } from "next/server";
import { createSupabaseServerClient } from "@/lib/supabase/server";
import { shuffleArray } from "@/lib/training/scoring";

/**
 * POST /api/training/start
 * Body: { module_key: string }
 * Réponse: { attemptId, module, questions }
 *
 * Crée une nouvelle tentative + retourne les questions SANS les bonnes réponses.
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
    const moduleKey = String(body.module_key || "");

    if (!moduleKey) {
      return NextResponse.json(
        { error: "module_key requis" },
        { status: 400 }
      );
    }

    // Vérifier que le module existe et est actif
    const { data: module, error: modErr } = await supabase
      .from("training_modules")
      .select("key, title, duration_min, passing_score")
      .eq("key", moduleKey)
      .eq("active", true)
      .single();

    if (modErr || !module) {
      return NextResponse.json(
        { error: "Module introuvable ou inactif" },
        { status: 404 }
      );
    }

    // Récupérer les questions actives — SANS le champ `correct` côté client
    const { data: questions, error: qErr } = await supabase
      .from("training_questions")
      .select("id, external_id, category, question_type, question, options")
      .eq("module_key", moduleKey)
      .eq("active", true);

    if (qErr || !questions || questions.length === 0) {
      return NextResponse.json(
        { error: "Aucune question disponible pour ce module" },
        { status: 404 }
      );
    }

    // Mélange aléatoire
    const shuffled = shuffleArray(questions);

    // Créer l'attempt
    const { data: attempt, error: attErr } = await supabase
      .from("training_attempts")
      .insert({
        user_id: user.id,
        module_key: moduleKey,
        user_agent: request.headers.get("user-agent") || null,
      })
      .select()
      .single();

    if (attErr || !attempt) {
      return NextResponse.json(
        { error: "Impossible de démarrer la tentative" },
        { status: 500 }
      );
    }

    return NextResponse.json({
      attemptId: attempt.id,
      module: {
        key: module.key,
        title: module.title,
        duration_min: module.duration_min,
        passing_score: module.passing_score,
      },
      questions: shuffled,
    });
  } catch (error) {
    console.error("training/start error:", error);
    return NextResponse.json({ error: "Erreur serveur" }, { status: 500 });
  }
}
