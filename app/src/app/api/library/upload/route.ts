import { NextRequest, NextResponse } from "next/server";
import { createServerClient } from "@supabase/ssr";
import { cookies } from "next/headers";
import { createSupabaseServerClient } from "@/lib/supabase/server";

const MAX_SIZE = 25 * 1024 * 1024; // 25 Mo — plus permissif que les CV candidat

/**
 * POST /api/library/upload
 * Multipart form-data admin/manager only :
 *   - file (obligatoire)
 *   - title (obligatoire)
 *   - description (optionnel)
 *   - category (obligatoire — cf. CATEGORIES agent page)
 *   - tags (optionnel, comma-separated)
 */
export async function POST(request: NextRequest) {
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
    const title = String(fd.get("title") || "").trim();
    const description = String(fd.get("description") || "").trim();
    const category = String(fd.get("category") || "").trim();
    const tagsRaw = String(fd.get("tags") || "").trim();
    const targetRolesRaw = fd.getAll("target_roles").map((r) => String(r));
    // Filtre uniquement les valeurs valides
    const targetRoles = targetRolesRaw.filter((r) =>
      ["conseiller", "telephoniste"].includes(r)
    );

    if (!file || file.size === 0) {
      return NextResponse.json({ error: "Fichier manquant" }, { status: 400 });
    }
    if (!title) {
      return NextResponse.json({ error: "Titre manquant" }, { status: 400 });
    }
    if (!category) {
      return NextResponse.json({ error: "Catégorie manquante" }, { status: 400 });
    }
    if (file.size > MAX_SIZE) {
      return NextResponse.json(
        { error: `Fichier trop lourd (max 25 Mo)` },
        { status: 400 }
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

    // Slug pour path
    const ext = file.name.split(".").pop() || "bin";
    const slug = title
      .toLowerCase()
      .normalize("NFD")
      .replace(/[̀-ͯ]/g, "")
      .replace(/[^a-z0-9]+/g, "_")
      .replace(/^_+|_+$/g, "")
      .slice(0, 60);
    const now = Date.now();
    const path = `${category}/${slug}_${now}.${ext}`;

    const buf = await file.arrayBuffer();
    const { error: upErr } = await service.storage
      .from("library")
      .upload(path, buf, { contentType: file.type, upsert: false });

    if (upErr) {
      console.error("[library upload] upload err:", upErr);
      return NextResponse.json(
        { error: "Erreur upload storage", details: upErr.message },
        { status: 500 }
      );
    }

    const tags = tagsRaw
      ? tagsRaw
          .split(",")
          .map((t) => t.trim())
          .filter(Boolean)
      : [];

    const { data: inserted, error: insErr } = await service
      .from("library_documents")
      .insert({
        title,
        description: description || null,
        category,
        tags,
        target_roles: targetRoles,
        storage_path: path,
        filename: file.name,
        size_bytes: file.size,
        content_type: file.type,
        uploaded_by: user.id,
      })
      .select()
      .single();

    if (insErr) {
      console.error("[library upload] insert err:", insErr);
      await service.storage.from("library").remove([path]);
      return NextResponse.json(
        { error: "Erreur DB", details: insErr.message },
        { status: 500 }
      );
    }

    return NextResponse.json({ success: true, id: inserted.id });
  } catch (err: any) {
    console.error("[library upload] fatal:", err);
    return NextResponse.json(
      { error: "Erreur serveur", details: err?.message },
      { status: 500 }
    );
  }
}
