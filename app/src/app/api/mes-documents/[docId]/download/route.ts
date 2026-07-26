import { NextRequest, NextResponse } from "next/server";
import { createServerClient } from "@supabase/ssr";
import { cookies } from "next/headers";
import { createSupabaseServerClient } from "@/lib/supabase/server";

/**
 * GET /api/mes-documents/[docId]/download
 * L'agent connecté télécharge UN de SES propres documents internes.
 * Vérif stricte : le doc doit appartenir au user connecté (user_id = auth.uid())
 * ET être actif (is_active = true).
 */
export async function GET(
  _req: NextRequest,
  { params }: { params: { docId: string } }
) {
  const supabase = createSupabaseServerClient();
  const {
    data: { user },
  } = await supabase.auth.getUser();
  if (!user) {
    return NextResponse.json({ error: "Non authentifié" }, { status: 401 });
  }

  // Charger le doc avec vérif ownership + actif
  const { data: doc } = await supabase
    .from("internal_documents")
    .select("storage_path, filename, user_id, is_active")
    .eq("id", params.docId)
    .maybeSingle();

  if (!doc) {
    return NextResponse.json({ error: "Document introuvable" }, { status: 404 });
  }
  if (doc.user_id !== user.id) {
    return NextResponse.json({ error: "Accès refusé" }, { status: 403 });
  }
  if (!doc.is_active) {
    return NextResponse.json(
      { error: "Document indisponible" },
      { status: 404 }
    );
  }

  // Générer signed URL via service_role (bucket privé)
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
