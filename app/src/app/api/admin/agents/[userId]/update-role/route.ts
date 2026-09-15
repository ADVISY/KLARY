import { NextRequest, NextResponse } from "next/server";
import { z } from "zod";
import { createSupabaseServerClient } from "@/lib/supabase/server";
import { createClient } from "@supabase/supabase-js";

/**
 * POST /api/admin/agents/[userId]/update-role
 *
 * Change le rôle d'un utilisateur. Seul un admin peut le faire.
 * Valeurs autorisées : agent | backoffice | manager | admin.
 *
 * Body : { role: "agent" | "backoffice" | "manager" | "admin" }
 */

const schema = z.object({
  role: z.enum(["agent", "backoffice", "manager", "admin"]),
});

export async function POST(
  request: NextRequest,
  { params }: { params: { userId: string } }
) {
  const supabase = createSupabaseServerClient();
  const {
    data: { user },
  } = await supabase.auth.getUser();
  if (!user) {
    return NextResponse.json({ error: "Non authentifié" }, { status: 401 });
  }

  // Seul un admin peut changer les rôles
  const { data: viewerRole } = await supabase
    .from("user_roles")
    .select("role")
    .eq("user_id", user.id)
    .eq("active", true)
    .maybeSingle();

  if (viewerRole?.role !== "admin") {
    return NextResponse.json(
      { error: "Réservé aux admins" },
      { status: 403 }
    );
  }

  const body = await request.json();
  const parsed = schema.safeParse(body);
  if (!parsed.success) {
    return NextResponse.json(
      { error: "Rôle invalide", details: parsed.error.flatten() },
      { status: 400 }
    );
  }

  const newRole = parsed.data.role;
  const targetUserId = params.userId;

  // Empêcher un admin de dégrader son propre compte (sécurité)
  if (targetUserId === user.id && newRole !== "admin") {
    return NextResponse.json(
      { error: "Vous ne pouvez pas modifier votre propre rôle" },
      { status: 400 }
    );
  }

  // Update via service_role pour bypass RLS
  const serviceSupabase = createClient(
    process.env.NEXT_PUBLIC_SUPABASE_URL!,
    process.env.SUPABASE_SERVICE_ROLE_KEY!,
    { auth: { persistSession: false, autoRefreshToken: false } }
  );

  const { error } = await serviceSupabase
    .from("user_roles")
    .update({
      role: newRole,
      updated_at: new Date().toISOString(),
    })
    .eq("user_id", targetUserId)
    .eq("active", true);

  if (error) {
    console.error("update-role error:", error);
    return NextResponse.json(
      { error: "Erreur de mise à jour", details: error.message },
      { status: 500 }
    );
  }

  return NextResponse.json({ success: true, role: newRole });
}
