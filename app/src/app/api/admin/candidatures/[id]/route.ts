import { NextRequest, NextResponse } from "next/server";
import { createSupabaseServerClient } from "@/lib/supabase/server";
import { z } from "zod";

const updateSchema = z.object({
  status: z.enum([
    "new",
    "reviewed",
    "interview_1",
    "interview_2",
    "test_ok",
    "offered",
    "hired",
    "rejected",
    "archived",
  ]),
  internal_notes: z.string().max(10000).optional().or(z.literal("")),
});

/**
 * POST /api/admin/candidatures/[id]
 * Accepte formulaire HTML (form-data) OU JSON.
 */
export async function POST(
  request: NextRequest,
  { params }: { params: { id: string } }
) {
  try {
    const supabase = createSupabaseServerClient();
    const {
      data: { user },
    } = await supabase.auth.getUser();
    if (!user) {
      return NextResponse.json({ error: "Non authentifié" }, { status: 401 });
    }

    // Vérif role admin/manager
    const { data: role } = await supabase
      .from("user_roles")
      .select("role")
      .eq("user_id", user.id)
      .eq("active", true)
      .maybeSingle();
    if (role?.role !== "admin" && role?.role !== "manager") {
      return NextResponse.json({ error: "Accès refusé" }, { status: 403 });
    }

    let payload: Record<string, any>;
    const contentType = request.headers.get("content-type") || "";
    if (contentType.includes("application/json")) {
      payload = await request.json();
    } else {
      const fd = await request.formData();
      payload = Object.fromEntries(fd.entries());
    }

    const parsed = updateSchema.safeParse({
      status: payload.status,
      internal_notes: payload.internal_notes || "",
    });
    if (!parsed.success) {
      return NextResponse.json(
        { error: "Données invalides", details: parsed.error.flatten() },
        { status: 400 }
      );
    }

    const { error } = await supabase
      .from("candidates")
      .update({
        status: parsed.data.status,
        internal_notes: parsed.data.internal_notes || null,
      })
      .eq("id", params.id);

    if (error) {
      console.error("Update error:", error);
      return NextResponse.json(
        { error: "Erreur d'enregistrement" },
        { status: 500 }
      );
    }

    // Log dans candidate_events (optionnel)
    await supabase.from("candidate_events").insert({
      candidate_id: params.id,
      event_type: "status_or_notes_updated",
      actor_agent_id: user.id,
      details: parsed.data,
    }).select().maybeSingle();

    // Rediriger vers la page détail
    return NextResponse.redirect(
      new URL(`/admin/candidatures/${params.id}`, request.url),
      { status: 303 }
    );
  } catch (error) {
    console.error("admin/candidatures POST:", error);
    return NextResponse.json({ error: "Erreur serveur" }, { status: 500 });
  }
}
