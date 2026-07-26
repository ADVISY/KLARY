import { NextRequest, NextResponse } from "next/server";
import { createServerClient } from "@supabase/ssr";
import { cookies } from "next/headers";
import { createSupabaseServerClient } from "@/lib/supabase/server";

const MAX_SIZE = 25 * 1024 * 1024; // 25 Mo
const ACCEPTED_TYPES = [
  "application/pdf",
  "image/jpeg",
  "image/jpg",
  "image/png",
  "application/msword",
  "application/vnd.openxmlformats-officedocument.wordprocessingml.document",
];

/**
 * POST /api/admin/agents/[userId]/documents
 * Multipart form-data : upload d'un document RH pour un agent.
 * Fields: file (required), document_type, title, description
 */
export async function POST(
  request: NextRequest,
  { params }: { params: { userId: string } }
) {
  try {
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

    const fd = await request.formData();
    const file = fd.get("file") as File | null;
    const documentType = String(fd.get("document_type") || "").trim();
    const title = String(fd.get("title") || "").trim();
    const description = String(fd.get("description") || "").trim();
    const signatureMethod = String(fd.get("signature_method") || "manuscrite_scan").trim();

    if (!file || file.size === 0) {
      return NextResponse.json({ error: "Fichier manquant" }, { status: 400 });
    }
    if (!documentType) {
      return NextResponse.json({ error: "Type de document requis" }, { status: 400 });
    }
    if (!title) {
      return NextResponse.json({ error: "Titre requis" }, { status: 400 });
    }
    if (file.size > MAX_SIZE) {
      return NextResponse.json({ error: "Fichier trop lourd (max 25 Mo)" }, { status: 400 });
    }
    if (!ACCEPTED_TYPES.includes(file.type)) {
      return NextResponse.json({ error: "Type de fichier non accepté" }, { status: 400 });
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

    // Path : {userId}/{year}/{documentType}_{timestamp}.{ext}
    const ext = file.name.split(".").pop() || "pdf";
    const now = Date.now();
    const path = `${params.userId}/${new Date().getFullYear()}/${documentType}_${now}.${ext}`.toLowerCase();

    const buf = await file.arrayBuffer();
    const { error: upErr } = await service.storage
      .from("internal-documents")
      .upload(path, buf, { contentType: file.type, upsert: false });

    if (upErr) {
      console.error("[internal-docs upload] err:", upErr);
      return NextResponse.json(
        { error: "Erreur upload storage", details: upErr.message },
        { status: 500 }
      );
    }

    const { data: inserted, error: insErr } = await service
      .from("internal_documents")
      .insert({
        user_id: params.userId,
        document_type: documentType,
        title,
        description: description || null,
        storage_path: path,
        filename: file.name,
        size_bytes: file.size,
        content_type: file.type,
        signature_method: signatureMethod,
        signed_at: signatureMethod !== "unsigned" ? new Date().toISOString() : null,
        created_by: user.id,
      })
      .select()
      .single();

    if (insErr) {
      console.error("[internal-docs insert] err:", insErr);
      await service.storage.from("internal-documents").remove([path]);
      return NextResponse.json(
        { error: "Erreur DB", details: insErr.message },
        { status: 500 }
      );
    }

    return NextResponse.json({ success: true, id: inserted.id });
  } catch (err: any) {
    console.error("[internal-docs upload] fatal:", err);
    return NextResponse.json(
      { error: "Erreur serveur", details: err?.message },
      { status: 500 }
    );
  }
}
