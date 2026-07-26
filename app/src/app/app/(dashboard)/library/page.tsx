import { createSupabaseServerClient } from "@/lib/supabase/server";
import { LibraryBrowser } from "./LibraryBrowser";

export const metadata = {
  title: "Bibliothèque — Klary",
};

export const CATEGORIES = [
  {
    key: "fiche_produit",
    label: "Fiches produits",
    icon: "📄",
    color: "bg-blue-100 text-blue-800",
  },
  {
    key: "script_appel",
    label: "Scripts d'appel",
    icon: "📞",
    color: "bg-orange-100 text-orange-800",
  },
  {
    key: "pv_conseil",
    label: "PV de conseil",
    icon: "✍",
    color: "bg-purple-100 text-purple-800",
  },
  {
    key: "argumentaire",
    label: "Argumentaires",
    icon: "💡",
    color: "bg-yellow-100 text-yellow-800",
  },
  {
    key: "reference_finma",
    label: "Références FINMA",
    icon: "⚖",
    color: "bg-red-100 text-red-800",
  },
  {
    key: "procedure_klary",
    label: "Procédures Klary",
    icon: "📋",
    color: "bg-green-100 text-green-800",
  },
  {
    key: "autre",
    label: "Autre",
    icon: "📎",
    color: "bg-gray-100 text-gray-700",
  },
];

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
