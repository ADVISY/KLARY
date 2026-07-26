import { NextRequest, NextResponse } from "next/server";
import { createServerClient } from "@supabase/ssr";
import { cookies } from "next/headers";
import { createSupabaseServerClient } from "@/lib/supabase/server";

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

  const cookieStore = cookies();
  const service = createServerClient(
    process.env.NEXT_PUBLIC_SUPABASE_URL!,
    process.env.SUPABASE_SERVICE_ROLE_KEY!,
    {
      cookies: {
        getAll: () => cookieStore.getAll(),
        setAll: () => {},
      },
    }
  );

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
