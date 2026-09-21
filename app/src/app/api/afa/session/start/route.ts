import { NextRequest, NextResponse } from "next/server";
import { createSupabaseServerClient } from "@/lib/supabase/server";
import { shuffle } from "@/lib/afa/scoring";

/**
 * POST /api/afa/session/start
 * Body: { filiere_key, mode: 'simulation'|'drill'|'pieges', theme_key?, count? }
 *
 * Crée une session et renvoie les questions SANS le corrigé.
 * Contrairement au module certification, il n'y a ni cooldown ni anti-triche :
 * on est en entraînement, la répétition est le but.
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
    const filiereKey = String(body.filiere_key || "");
    const mode = String(body.mode || "");
    const themeKey = body.theme_key ? String(body.theme_key) : null;

    if (!filiereKey || !["simulation", "drill", "pieges"].includes(mode)) {
      return NextResponse.json(
        { error: "filiere_key et mode valides requis" },
        { status: 400 }
      );
    }

    const { data: filiere } = await supabase
      .from("afa_filieres")
      .select("key, title, passing_pct, internal_target_pct, duration_min")
      .eq("key", filiereKey)
      .eq("active", true)
      .single();

    if (!filiere) {
      return NextResponse.json(
        { error: "Filière introuvable" },
        { status: 404 }
      );
    }

    // ─── Sélection des questions selon le mode
    let themeId: string | null = null;
    if (themeKey) {
      const { data: theme } = await supabase
        .from("afa_themes")
        .select("id")
        .eq("filiere_key", filiereKey)
        .eq("key", themeKey)
        .single();
      themeId = theme?.id ?? null;
    }

    let query = supabase
      .from("afa_questions")
      .select("id, external_id, question_type, context, question, options, points, theme_id")
      .eq("filiere_key", filiereKey)
      .eq("active", true);

    if (themeId) query = query.eq("theme_id", themeId);

    if (mode === "pieges") {
      // Uniquement les questions rattachées à une notion marquée piège
      const { data: trapQuestionIds } = await supabase
        .from("afa_question_notions")
        .select("question_id, afa_notions!inner(is_trap)")
        .eq("afa_notions.is_trap", true);
      const ids = Array.from(
        new Set((trapQuestionIds ?? []).map((r: { question_id: string }) => r.question_id))
      );
      if (ids.length === 0) {
        return NextResponse.json(
          { error: "Aucune question piège disponible" },
          { status: 404 }
        );
      }
      query = query.in("id", ids);
    }

    const { data: allQuestions, error: qErr } = await query;
    if (qErr || !allQuestions?.length) {
      return NextResponse.json(
        { error: "Aucune question disponible pour cette sélection" },
        { status: 404 }
      );
    }

    // Simulation = format examen : on vise ~30 points, ordre figé.
    // Drill / pièges = volume demandé, par défaut 10.
    let picked = shuffle(allQuestions);
    if (mode === "simulation") {
      const target = 30;
      const chosen: typeof picked = [];
      let sum = 0;
      for (const q of picked) {
        if (sum >= target) break;
        chosen.push(q);
        sum += q.points;
      }
      picked = chosen;
    } else {
      // Drill / pièges : par défaut TOUTES les questions disponibles ;
      // body.count = nombre explicite, "all" ou 0 = toutes.
      const raw = body.count;
      const useAll = raw === "all" || raw === 0 || raw === "0";
      const requested = useAll ? picked.length : Number(raw) || picked.length;
      const count = Math.min(Math.max(requested, 1), picked.length);
      picked = picked.slice(0, count);
    }

    const durationSec =
      mode === "simulation" ? filiere.duration_min * 60 : null;

    const { data: session, error: sErr } = await supabase
      .from("afa_sessions")
      .insert({
        user_id: user.id,
        filiere_key: filiereKey,
        mode,
        theme_id: themeId,
        question_ids: picked.map((q) => q.id),
        duration_sec: durationSec,
        points_max: picked.reduce((s, q) => s + q.points, 0),
      })
      .select("id, started_at, duration_sec, points_max")
      .single();

    if (sErr || !session) {
      return NextResponse.json(
        { error: "Impossible de créer la session" },
        { status: 500 }
      );
    }

    // On retire `correct` et `why_wrong` avant d'envoyer au client :
    // le corrigé ne doit jamais transiter pendant la session.
    const safeQuestions = picked.map((q) => ({
      id: q.id,
      external_id: q.external_id,
      question_type: q.question_type,
      context: q.context,
      question: q.question,
      points: q.points,
      options: (q.options as { text: string }[]).map((o) => ({ text: o.text })),
    }));

    return NextResponse.json({
      sessionId: session.id,
      filiere,
      mode,
      durationSec: session.duration_sec,
      pointsMax: session.points_max,
      questions: safeQuestions,
    });
  } catch (err) {
    console.error("[afa/session/start]", err);
    return NextResponse.json({ error: "Erreur serveur" }, { status: 500 });
  }
}
