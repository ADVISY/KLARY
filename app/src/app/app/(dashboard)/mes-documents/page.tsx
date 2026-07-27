import { redirect } from "next/navigation";
import { createSupabaseServerClient } from "@/lib/supabase/server";
import { MyDocumentsList } from "./MyDocumentsList";
import { PageTabs } from "@/components/app/PageTabs";

export const metadata = {
  title: "Mes documents — Klary",
};

const DOCUMENTS_TABS = [
  { href: "/library", label: "Bibliothèque" },
  { href: "/mes-documents", label: "Mes documents privés" },
];

export const dynamic = "force-dynamic";

export default async function MesDocumentsPage() {
  const supabase = createSupabaseServerClient();
  const {
    data: { user },
  } = await supabase.auth.getUser();
  if (!user) redirect("/login");

  // L'agent voit UNIQUEMENT ses propres docs actifs (RLS gère ça)
  const { data: docs } = await supabase
    .from("internal_documents")
    .select(
      "id, document_type, title, description, filename, size_bytes, content_type, signature_method, signed_at, created_at"
    )
    .eq("user_id", user.id)
    .eq("is_active", true)
    .order("created_at", { ascending: false });

  return (
    <div className="max-w-4xl mx-auto p-6 md:p-10">
      <header className="mb-6">
        <div className="text-xs font-bold tracking-widest uppercase text-klary-orange mb-2">
          Espace personnel
        </div>
        <h1 className="text-3xl md:text-4xl font-bold text-klary-navy mb-3">
          Mes documents Klary
        </h1>
        <p className="text-klary-grey">
          Retrouvez ici tous les documents administratifs qui vous concernent :
          contrat de travail, avenants, attestations, certificats, décomptes de
          salaire… Téléchargez-les à tout moment en cas de besoin (banque,
          administration, régie immobilière…).
        </p>
      </header>

      <PageTabs tabs={DOCUMENTS_TABS} />

      <MyDocumentsList docs={docs || []} />
    </div>
  );
}
