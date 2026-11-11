import { NextRequest, NextResponse } from "next/server";
import { z } from "zod";
import { createSupabaseServerClient } from "@/lib/supabase/server";
import { REPORT_FIELDS, highestRole, todayZurich } from "@/lib/reports/fields";

const schema = z.object({
  metrics: z.record(z.number().min(0).nullable()),
  summary: z.string().trim().min(1).max(2000),
  problem: z.string().trim().max(2000).optional().default(""),
  solution: z.string().trim().max(2000).optional().default(""),
});

/**
 * POST /api/rapport
 * Enregistre le rapport du jour de la personne connectée (un seul par jour).
 * Le rôle et la date viennent du serveur ; RLS bloque toute autre date.
 */
export async function POST(request: NextRequest) {
  const supabase = createSupabaseServerClient();
  const {
    data: { user },
  } = await supabase.auth.getUser();
  if (!user) {
    return NextResponse.json({ error: "Non connecté." }, { status: 401 });
  }

  const parsed = schema.safeParse(await request.json().catch(() => null));
  if (!parsed.success) {
    return NextResponse.json({ error: "Rapport incomplet." }, { status: 400 });
  }

  const { data: roles } = await supabase
    .from("user_roles")
    .select("role")
    .eq("user_id", user.id)
    .eq("active", true);
  if (!roles?.length) {
    return NextResponse.json({ error: "Compte inactif." }, { status: 403 });
  }
  const role = highestRole(roles);

  // Chaque poste a ses propres compteurs ; seuls les champs facultatifs
  // peuvent rester vides
  const metrics: Record<string, number> = {};
  for (const field of REPORT_FIELDS[role] ?? []) {
    const value = parsed.data.metrics[field.key];
    if (value === null || value === undefined) {
      if (field.optional) continue;
      return NextResponse.json(
        { error: `Renseignez : ${field.label}.` },
        { status: 400 }
      );
    }
    if (value > field.max || (!field.decimal && !Number.isInteger(value))) {
      return NextResponse.json(
        { error: `Valeur incorrecte : ${field.label}.` },
        { status: 400 }
      );
    }
    metrics[field.key] = value;
  }

  const { error } = await supabase.from("daily_reports").upsert(
    {
      user_id: user.id,
      report_date: todayZurich(),
      role,
      metrics,
      summary: parsed.data.summary,
      problem: parsed.data.problem || null,
      solution: parsed.data.solution || null,
      updated_at: new Date().toISOString(),
    },
    { onConflict: "user_id,report_date" }
  );
  if (error) {
    console.error("[rapport] enregistrement impossible", error);
    return NextResponse.json(
      { error: "Enregistrement impossible, réessayez." },
      { status: 500 }
    );
  }
  return NextResponse.json({ ok: true });
}
