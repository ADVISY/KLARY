import { NextRequest, NextResponse } from "next/server";
import { createServerClient } from "@supabase/ssr";
import { cookies } from "next/headers";
import { createSupabaseServerClient } from "@/lib/supabase/server";

/**
 * GET /api/admin/agents/[userId]/documents/[docId]/download
 * Retourne une signed URL 1h vers le document. Admin/manager only.
 */
export async function GET(
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
  if (role?.role !== "admin" && role?.role !== "manager") {
    return NextResponse.json({ error: "Accès refusé" }, { status: 403 });
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

  const { data: doc } = await service
    .from("internal_documents")
    .select("storage_path, filename, user_id, is_active")
    .eq("id", params.docId)
    .maybeSingle();

  if (!doc || doc.user_id !== params.userId || !doc.is_active) {
    return NextResponse.json({ error: "Document introuvable" }, { status: 404 });
  }

  const { data: sig } = await service.storage
    .from("internal-documents")
    .createSignedUrl(doc.storage_path, 3600, { download: doc.filename });

  if (!sig?.signedUrl) {
    return NextResponse.json(
      { error: "Impossible de générer le lien" },
      { status: 500 }
    );
  }

  return NextResponse.json({ url: sig.signedUrl });
}
