import { createSupabaseServerClient } from "@/lib/supabase/server";
import { LibraryBrowser } from "./LibraryBrowser";
import { CATEGORIES } from "./categories";

export const metadata = {
  title: "Bibliothèque — Klary",
};

export const dynamic = "force-dynamic";

export default async function LibraryPage() {
  const supabase = createSupabaseServerClient();

  // Récupérer le user + son poste + son rôle admin/manager/agent
  const {
    data: { user },
  } = await supabase.auth.getUser();
  const { data: userRole } = user
    ? await supabase
        .from("user_roles")
        .select("role, job_title")
        .eq("user_id", user.id)
        .eq("active", true)
        .maybeSingle()
    : { data: null };

  const isPrivileged =
    userRole?.role === "admin" || userRole?.role === "manager";
  const jobTitle = userRole?.job_title || null;

  // Récupérer tous les docs actifs
  const { data: allDocs } = await supabase
    .from("library_documents")
    .select(
      "id, title, description, category, tags, target_roles, filename, size_bytes, content_type, download_count, created_at"
    )
    .eq("is_active", true)
    .order("created_at", { ascending: false });

  // Filtrer côté serveur selon poste (admin/manager voient tout)
  const docs = isPrivileged
    ? allDocs
    : (allDocs || []).filter((d: any) => {
        const t = d.target_roles || [];
        if (t.length === 0) return true; // aucun poste ciblé → visible par tous
        if (!jobTitle) return false; // agent sans poste → ne voit que les docs globaux
        return t.includes(jobTitle);
      });

  return (
    <div className="max-w-6xl mx-auto p-6 md:p-10">
      <header className="mb-8">
        <div className="text-xs font-bold tracking-widest uppercase text-klary-orange mb-2">
          Ressources internes
        </div>
        <h1 className="text-3xl md:text-4xl font-bold text-klary-navy mb-3">
          Bibliothèque Klary
        </h1>
        <p className="text-klary-grey">
          Fiches produits, scripts d'appel, argumentaires, procédures — tout
          ce dont vous avez besoin pour vos rendez-vous clients.
        </p>
      </header>

      <LibraryBrowser docs={docs || []} categories={CATEGORIES} />
    </div>
  );
}
