import { NextRequest, NextResponse } from "next/server";
import { createServerClient } from "@supabase/ssr";
import { cookies } from "next/headers";
import { createSupabaseServerClient } from "@/lib/supabase/server";

/**
 * POST /api/library/[id]/delete
 * HARD delete — supprime le fichier du bucket ET la ligne DB.
 * Permet aussi de re-uploader avec le même nom sans conflit.
 */
export async function POST(
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

  // 1) Récupérer le storage_path
  const { data: doc, error: fetchErr } = await service
    .from("library_documents")
    .select("storage_path")
    .eq("id", params.id)
    .maybeSingle();

  if (fetchErr) {
    return NextResponse.json({ error: fetchErr.message }, { status: 500 });
  }

  // 2) Supprimer le fichier du bucket (best-effort, on continue même si absent)
  if (doc?.storage_path) {
    const { error: rmErr } = await service.storage
      .from("library")
      .remove([doc.storage_path]);
    if (rmErr) {
      console.warn("[library delete] storage remove failed:", rmErr.message);
      // On ne bloque pas — on continue pour supprimer la ligne DB
    }
  }

  // 3) Supprimer la ligne DB
  const { error: delErr } = await service
    .from("library_documents")
    .delete()
    .eq("id", params.id);

  if (delErr) {
    return NextResponse.json({ error: delErr.message }, { status: 500 });
  }

  return NextResponse.json({ success: true });
}
