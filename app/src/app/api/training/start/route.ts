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
      .select("key, title, duration_min, passing_score, retry_cooldown_hours")
      .eq("key", moduleKey)
      .eq("active", true)
      .single();

    if (modErr || !module) {
      return NextResponse.json(
        { error: "Module introuvable ou inactif" },
        { status: 404 }
      );
    }

    // ─── Nettoyage : marquer comme abandonnées les tentatives ouvertes
    //     depuis plus de 3h (l'utilisateur a fermé le navigateur)
    const staleAgo = new Date(Date.now() - 3 * 3600 * 1000);
    await supabase
      .from("training_attempts")
      .update({
        finished_at: new Date().toISOString(),
        aborted: true,
        abort_reason: "session_expired",
        passed: false,
      })
      .eq("user_id", user.id)
      .eq("module_key", moduleKey)
      .is("finished_at", null)
      .lt("started_at", staleAgo.toISOString());

    // ─── Vérif rôle : admin/manager bypass le cooldown ───
    const { data: roleRow } = await supabase
      .from("user_roles")
      .select("role")
      .eq("user_id", user.id)
      .eq("active", true)
      .in("role", ["admin", "manager"])
      .maybeSingle();
    const isPrivileged = !!roleRow;

    // ─── Cooldown post-échec (sauf admin/manager) ───
    const cooldownHours = (module as any).retry_cooldown_hours ?? 24;
    if (!isPrivileged && cooldownHours > 0) {
      const cooldownAgo = new Date(Date.now() - cooldownHours * 3600 * 1000);
      const { data: recentFail } = await supabase
        .from("training_attempts")
        .select("finished_at")
        .eq("user_id", user.id)
        .eq("module_key", moduleKey)
        .eq("passed", false)
        .not("finished_at", "is", null)
        .gte("finished_at", cooldownAgo.toISOString())
        .order("finished_at", { ascending: false })
        .limit(1)
        .maybeSingle();

      if (recentFail?.finished_at) {
        const nextAllowedAt = new Date(
          new Date(recentFail.finished_at).getTime() + cooldownHours * 3600 * 1000
        );
        const hoursLeft = Math.ceil(
          (nextAllowedAt.getTime() - Date.now()) / (3600 * 1000)
        );
        return NextResponse.json(
          {
            error: `Nouvelle tentative disponible dans ${hoursLeft}h. Prenez le temps de revoir la correction détaillée de votre dernière tentative avant de recommencer.`,
            nextAllowedAt: nextAllowedAt.toISOString(),
            cooldown: true,
          },
          { status: 429 }
        );
      }
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
