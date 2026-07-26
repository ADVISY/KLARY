import { redirect } from "next/navigation";
import { createSupabaseServerClient } from "@/lib/supabase/server";
import { ConventionSortie } from "@/components/ConventionSortie";
import { PrintButton } from "../[id]/convention/PrintButton";

export const metadata = {
  title: "Aperçu convention de sortie",
  robots: "noindex, nofollow",
};

export const dynamic = "force-dynamic";

const DEMO_REASONS = [
  { value: "demission", label: "Démission" },
  { value: "mutuel_accord", label: "Rupture d'un commun accord" },
  { value: "rupture_essai", label: "Rupture période d'essai" },
  { value: "fin_cdd", label: "Fin CDD" },
  { value: "retraite", label: "Retraite" },
  { value: "licenciement", label: "Licenciement" },
  { value: "faute_grave", label: "Faute grave (aggravé)" },
  { value: "abandon_poste", label: "Abandon de poste (aggravé)" },
];

export default async function PreviewConvention({
  searchParams,
}: {
  searchParams: { reason?: string };
}) {
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
  if (role?.role !== "admin" && role?.role !== "manager")
    redirect("/formation");

  const reason = searchParams?.reason || "demission";

  return (
    <div className="min-h-screen bg-klary-navy/10 py-10 print:py-0 print:bg-white">
      {/* Barre non imprimable */}
      <div className="max-w-3xl mx-auto mb-4 px-4 print:hidden">
        <div className="p-4 bg-yellow-100 border-2 border-yellow-400 rounded-xl mb-4">
          <div className="flex items-center gap-2">
            <span className="text-xl">👁</span>
            <div>
              <div className="font-bold text-yellow-900 text-sm">
                Aperçu convention de sortie — données fictives
              </div>
              <div className="text-xs text-yellow-800 mt-0.5">
                Ce document est généré avec des infos factices. Aucun agent
                réel n'est concerné.
              </div>
            </div>
          </div>
        </div>

        <div className="bg-white rounded-xl border border-klary-light-grey p-4 mb-4">
          <div className="text-xs font-semibold text-klary-navy mb-2">
            Tester avec différents motifs
          </div>
          <div className="flex flex-wrap gap-2">
            {DEMO_REASONS.map((r) => (
              <a
                key={r.value}
                href={`/admin/offboarding/preview-convention?reason=${r.value}`}
                className={`text-xs px-3 py-1.5 rounded-lg border transition ${
                  reason === r.value
                    ? "bg-klary-orange text-white border-klary-orange"
                    : "bg-white text-klary-navy border-klary-light-grey hover:border-klary-orange"
                }`}
              >
                {r.label}
              </a>
            ))}
          </div>
        </div>

        <div className="flex items-center justify-between gap-3">
          <div className="text-sm text-klary-grey">
            À imprimer sur papier Klary tamponné · <strong>2 exemplaires</strong>
          </div>
          <div className="flex gap-2">
            <a
              href="/admin/offboarding"
              className="px-4 py-2 bg-white border border-klary-light-grey rounded-lg text-sm font-semibold text-klary-navy hover:border-klary-navy"
            >
              Retour
            </a>
            <PrintButton />
          </div>
        </div>
      </div>

      <ConventionSortie
        firstName="Prénom"
        lastName="Nom"
        functionTitle="Conseiller Klary"
        entryDate="15 mars 2024"
        lastWorkingDay="30 septembre 2026"
        reason={reason}
      />
    </div>
  );
}
