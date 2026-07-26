import { redirect } from "next/navigation";
import { createSupabaseServerClient } from "@/lib/supabase/server";
import { AdminLibraryPanel } from "./AdminLibraryPanel";
import { CATEGORIES as FULL_CATEGORIES } from "../../library/categories";

export const metadata = {
  title: "Bibliothèque — Admin",
};

export const dynamic = "force-dynamic";

// Admin n'a besoin que de {key, label} pour le dropdown de catégorie
const CATEGORIES = FULL_CATEGORIES.map((c) => ({
  key: c.key,
  label: c.label,
}));

export default async function AdminLibraryPage() {
  const supabase = createSupabaseServerClient();
  const {
    data: { user },
  } = await supabase.auth.getUser();
  if (!user) redirect("/login");

  const { data: role } = await supabase
    .from("user_roles")
    .select("role")
    .eq("user_id", user.id)
    .eq("active", true)
    .maybeSingle();
  if (role?.role !== "admin" && role?.role !== "manager") {
    redirect("/formation");
  }

  const { data: docs } = await supabase
    .from("library_documents")
    .select("*")
    .order("created_at", { ascending: false });

  return (
    <div className="max-w-6xl mx-auto p-6 md:p-10">
      <header className="mb-8">
        <div className="text-xs font-bold tracking-widest uppercase text-klary-orange mb-2">
          Backoffice · Bibliothèque
        </div>
        <h1 className="text-3xl md:text-4xl font-bold text-klary-navy mb-3">
          Gestion des documents
        </h1>
        <p className="text-klary-grey">
          Ajoutez, modifiez ou masquez les documents accessibles aux agents
          via <a href="/library" className="text-klary-orange underline">/library</a>.
        </p>
      </header>

      <AdminLibraryPanel docs={docs || []} categories={CATEGORIES} />
    </div>
  );
}
