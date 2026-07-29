import { NextRequest, NextResponse } from "next/server";
import { createClient } from "@supabase/supabase-js";
import { z } from "zod";

const schema = z.object({
  token: z.string().uuid(),
  q1_enps: z.number().int().min(1).max(10),
  q2_charge: z.enum(["tres_faible", "faible", "equilibree", "lourde", "tres_lourde"]),
  q3_ambiance: z.number().int().min(1).max(10),
  q4_manager: z.number().int().min(1).max(10),
  q6_motivation: z.number().int().min(1).max(10),
  q5_improve: z.string().max(500).optional().or(z.literal("")),
  q7_continue: z.string().max(500).optional().or(z.literal("")),
});

/**
 * POST /api/barometre/submit
 * Body : { token, q1_enps, q2_charge, q3_ambiance, q4_manager, q6_motivation, q5_improve?, q7_continue? }
 *
 * Publique — anonyme, protégé par token.
 * 2 opérations distinctes pour préserver l'anonymat :
 *   1. INSERT dans barometer_responses (aucun user_id, seul le period_month lié à l'invite)
 *   2. UPDATE l'invite pour marquer responded_at (garde user_id, mais aucun lien avec le contenu)
 */
export async function POST(request: NextRequest) {
  try {
    const body = await request.json();
    const parsed = schema.safeParse(body);
    if (!parsed.success) {
      return NextResponse.json(
        { error: "Données invalides", details: parsed.error.flatten() },
        { status: 400 }
      );
    }

    const supabase = createClient(
      process.env.NEXT_PUBLIC_SUPABASE_URL!,
      process.env.SUPABASE_SERVICE_ROLE_KEY!,
      { auth: { persistSession: false, autoRefreshToken: false } }
    );

    // Valider le token
    const { data: invite } = await supabase
      .from("barometer_invites")
      .select("id, period_month, responded_at, expires_at")
      .eq("token", parsed.data.token)
      .maybeSingle();

    if (!invite) {
      return NextResponse.json({ error: "Lien invalide" }, { status: 404 });
    }
    if (invite.responded_at) {
      return NextResponse.json({ error: "Réponse déjà soumise", alreadyDone: true }, { status: 409 });
    }
    if (new Date(invite.expires_at) < new Date()) {
      return NextResponse.json({ error: "Lien expiré" }, { status: 410 });
    }

    // 1. INSERT réponse (anonyme — pas de user_id, seul period_month)
    const { error: insErr } = await supabase.from("barometer_responses").insert({
      period_month: invite.period_month,
      q1_enps: parsed.data.q1_enps,
      q2_charge: parsed.data.q2_charge,
      q3_ambiance: parsed.data.q3_ambiance,
      q4_manager: parsed.data.q4_manager,
      q6_motivation: parsed.data.q6_motivation,
      q5_improve: parsed.data.q5_improve || null,
      q7_continue: parsed.data.q7_continue || null,
    });

    if (insErr) {
      console.error("[barometre/submit] insert response err:", insErr);
      return NextResponse.json(
        { error: "Erreur enregistrement", details: insErr.message },
        { status: 500 }
      );
    }

    // 2. UPDATE invite → marque responded (aucun lien avec le contenu de la réponse)
    await supabase
      .from("barometer_invites")
      .update({ responded_at: new Date().toISOString() })
      .eq("id", invite.id);

    return NextResponse.json({ success: true });
  } catch (err: any) {
    console.error("[barometre/submit] fatal:", err);
    return NextResponse.json(
      { error: "Erreur serveur", details: err?.message },
      { status: 500 }
    );
  }
}
