import { NextRequest, NextResponse } from "next/server";
import { createSupabaseServerClient, createSupabaseServiceClient } from "@/lib/supabase/server";

/**
 * POST /api/admin/agents/[userId]/documents/[docId]/delete
 * Soft delete (is_active = false). Admin only.
 * Le fichier reste dans le bucket, réactivable si besoin.
 */
export async function POST(
  _req: NextRequest,
  { params }: { params: { userId: string; docId: string } }
) {
  const supabase = createSupabaseServerClient();
  const {
    data: { user },
  } = await supabase.auth.getUser();
  if (!user) {
    return NextResponse.json({ error: "Non authentifié" }, { status: 401 });
  }

  const { data: role } = await supabase
    .from("user_roles")
    .select("role")
    .eq("user_id", user.id)
    .eq("active", true)
    .maybeSingle();
  if (role?.role !== "admin") {
    return NextResponse.json(
      { error: "Accès refusé (admin uniquement)" },
      { status: 403 }
    );
  }

  const service = createSupabaseServiceClient();

  const { error } = await service
    .from("internal_documents")
    .update({ is_active: false })
    .eq("id", params.docId)
    .eq("user_id", params.userId);

  if (error) {
    return NextResponse.json({ error: error.message }, { status: 500 });
  }

  return NextResponse.json({ success: true });
}
