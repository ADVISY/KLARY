import { NextRequest, NextResponse } from "next/server";
import { createClient } from "@supabase/supabase-js";
import { createSupabaseServerClient } from "@/lib/supabase/server";

/**
 * GET /api/library/[id]/download
 * Retourne une signed URL 1h vers le document + incrémente le compteur.
 *   - Défaut : Content-Disposition attachment (déclenche téléchargement)
 *   - ?preview=1 : Content-Disposition inline (rendu direct dans navigateur)
 * Réservé aux utilisateurs authentifiés.
 */
export async function GET(
  req: NextRequest,
  { params }: { params: { id: string } }
) {
  try {
    const preview = req.nextUrl.searchParams.get("preview") === "1";

    // Sanity check env vars
    const supaUrl = process.env.NEXT_PUBLIC_SUPABASE_URL;
    const serviceKey = process.env.SUPABASE_SERVICE_ROLE_KEY;
    if (!supaUrl || !serviceKey) {
      console.error("[library/download] env missing:", {
        hasUrl: !!supaUrl,
        hasServiceKey: !!serviceKey,
      });
      return NextResponse.json(
        { error: "Configuration serveur incomplète (env)" },
        { status: 500 }
      );
    }

    const supabase = createSupabaseServerClient();
    const {
      data: { user },
    } = await supabase.auth.getUser();
    if (!user) {
      return NextResponse.json({ error: "Non authentifié" }, { status: 401 });
    }

    const { data: doc, error: docErr } = await supabase
      .from("library_documents")
      .select("id, storage_path, filename, download_count, is_active")
      .eq("id", params.id)
      .maybeSingle();

    if (docErr) {
      console.error("[library/download] DB read error:", docErr);
      return NextResponse.json(
        { error: "Erreur lecture DB", details: docErr.message },
        { status: 500 }
      );
    }

    if (!doc || !doc.is_active) {
      return NextResponse.json({ error: "Document introuvable" }, { status: 404 });
    }

    // Client service_role pur (sans cookies) — bypass RLS/session pour signed URL
    const service = createClient(supaUrl, serviceKey, {
      auth: { persistSession: false, autoRefreshToken: false },
    });

    const { data: sig, error: sigErr } = await service.storage
      .from("library")
      .createSignedUrl(
        doc.storage_path,
        3600,
        preview ? undefined : { download: doc.filename }
      );

    if (sigErr || !sig?.signedUrl) {
      console.error("[library/download] signed URL error:", {
        path: doc.storage_path,
        error: sigErr,
      });
      return NextResponse.json(
        {
          error: "Impossible de générer le lien",
          details: sigErr?.message,
          storage_path: doc.storage_path,
        },
        { status: 500 }
      );
    }

    // Incrémenter le compteur (best-effort) — uniquement pour téléchargement réel
    if (!preview) {
      service
        .from("library_documents")
        .update({ download_count: (doc.download_count || 0) + 1 })
        .eq("id", doc.id)
        .then(() => {});
    }

    return NextResponse.json({ url: sig.signedUrl });
  } catch (err: any) {
    console.error("[library/download] fatal:", err);
    return NextResponse.json(
      { error: "Erreur serveur", details: err?.message || String(err) },
      { status: 500 }
    );
  }
}
