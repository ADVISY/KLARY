import { createSupabaseServerClient } from "@/lib/supabase/server";
import { LibraryBrowser } from "./LibraryBrowser";
import { CATEGORIES } from "./categories";

export const metadata = {
  title: "Bibliothèque — Klary",
};

export const dynamic = "force-dynamic";

export default async function LibraryPage() {
  const supabase = createSupabaseServerClient();
  const { data: docs } = await supabase
    .from("library_documents")
    .select(
      "id, title, description, category, tags, filename, size_bytes, content_type, download_count, created_at"
    )
    .eq("is_active", true)
    .order("created_at", { ascending: false });

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
