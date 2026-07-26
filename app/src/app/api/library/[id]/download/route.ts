import { NextRequest, NextResponse } from "next/server";
import { createServerClient } from "@supabase/ssr";
import { cookies } from "next/headers";
import { createSupabaseServerClient } from "@/lib/supabase/server";

/**
 * GET /api/library/[id]/download
 * Retourne une signed URL 1h vers le document + incrémente le compteur.
 * Réservé aux utilisateurs authentifiés.
 */
export async function GET(
  _req: NextRequest,
  { params }: { params: { id: string } }
) {
  const supabase = createSupabaseServerClient();
  const {
    data: { user },
  } = await supabase.auth.getUser();
  if (!user) {
    return NextResponse.json({ error: "Non authentifié" }, { status: 401 });
  }

  const { data: doc } = await supabase
    .from("library_documents")
    .select("id, storage_path, filename, download_count, is_active")
    .eq("id", params.id)
    .maybeSingle();

  if (!doc || !doc.is_active) {
    return NextResponse.json({ error: "Document introuvable" }, { status: 404 });
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

  const { data: sig } = await service.storage
    .from("library")
    .createSignedUrl(doc.storage_path, 3600, { download: doc.filename });

  if (!sig?.signedUrl) {
    return NextResponse.json(
      { error: "Impossible de générer le lien" },
      { status: 500 }
    );
  }

  // Incrémenter le compteur (best-effort)
  service
    .from("library_documents")
    .update({ download_count: (doc.download_count || 0) + 1 })
    .eq("id", doc.id)
    .then(() => {});

  return NextResponse.json({ url: sig.signedUrl });
}
