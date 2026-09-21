import Link from "next/link";
import { redirect } from "next/navigation";
import { createSupabaseServerClient } from "@/lib/supabase/server";
import { formatCHF } from "@/lib/hypotheque/calculs";

export const metadata = { title: "Historique PPL — Klary" };
export const dynamic = "force-dynamic";

const OUTCOME_LABELS: Record<string, { label: string; color: string }> = {
  en_reflexion: { label: "En réflexion", color: "bg-amber-100 text-amber-800" },
  signee: { label: "Signée ✓", color: "bg-emerald-100 text-emerald-800" },
  refusee: { label: "Refusée", color: "bg-gray-100 text-gray-700" },
  a_relancer: { label: "À relancer", color: "bg-blue-100 text-blue-800" },
};

export default async function HistoriquePPLPage() {
  const supabase = createSupabaseServerClient();
  const {
    data: { user },
  } = await supabase.auth.getUser();
  if (!user) redirect("/login");

  const { data: simulations } = await supabase
    .from("outil_simulations")
    .select("id, client_prenom, client_nom, dossier, outcome, notes, relance_at, created_at, updated_at")
    .eq("user_id", user.id)
    .eq("outil", "hypotheque_ppl")
    .order("created_at", { ascending: false })
    .limit(100);

  const list = simulations ?? [];

  return (
    <div className="max-w-[1200px] mx-auto p-6 md:p-10">
      <div className="mb-6">
        <Link
          href="/outils/hypotheque"
          className="text-sm text-klary-grey hover:text-klary-orange"
        >
          ← Nouveau Premier Plan Logement
        </Link>
      </div>

      <header className="mb-8">
        <div className="text-xs font-bold tracking-widest uppercase text-klary-orange mb-2">
          Outil hypothèque · Historique
        </div>
        <h1 className="text-3xl md:text-4xl font-bold text-klary-navy mb-3">
          Mes simulations PPL
        </h1>
        <p className="text-klary-grey">
          {list.length} simulation{list.length > 1 ? "s" : ""} sauvegardée{list.length > 1 ? "s" : ""}.
          Clique sur un dossier pour le rejouer, ré-imprimer le PDF ou modifier
          le statut de suivi.
        </p>
      </header>

      {list.length === 0 ? (
        <div className="text-center py-16 bg-klary-cream/40 rounded-2xl border border-dashed border-klary-light-grey">
          <div className="text-4xl mb-3">📊</div>
          <div className="text-klary-navy font-bold mb-1">
            Pas encore de simulation sauvegardée
          </div>
          <div className="text-sm text-klary-grey mb-4">
            Fais ta première simulation, puis clique sur « Sauvegarder » en fin
            de wizard.
          </div>
          <Link
            href="/outils/hypotheque"
            className="inline-block px-5 py-2 bg-klary-orange text-white rounded-lg font-semibold text-sm hover:bg-klary-orange/90"
          >
            Nouvelle simulation
          </Link>
        </div>
      ) : (
        <div className="grid gap-3">
          {list.map((sim: any) => {
            const nom =
              [sim.client_prenom, sim.client_nom].filter(Boolean).join(" ") ||
              "Client sans nom";
            const created = new Date(sim.created_at).toLocaleDateString("fr-CH", {
              day: "2-digit",
              month: "short",
              year: "numeric",
            });
            const outcomeMeta = sim.outcome ? OUTCOME_LABELS[sim.outcome] : null;
            const prixBien = sim.dossier?.prixBien ?? 0;
            const versement = sim.dossier?.versementMensuel ?? 0;
            return (
              <Link
                key={sim.id}
                href={`/outils/hypotheque?load=${sim.id}`}
                className="block bg-white border border-klary-light-grey rounded-xl p-5 hover:border-klary-orange transition"
              >
                <div className="flex items-start justify-between gap-4">
                  <div className="flex-1 min-w-0">
                    <div className="flex items-center gap-3 flex-wrap mb-2">
                      <h3 className="font-bold text-klary-navy text-lg">{nom}</h3>
                      {outcomeMeta && (
                        <span
                          className={`text-[10px] px-2 py-0.5 rounded-full font-semibold uppercase tracking-wide ${outcomeMeta.color}`}
                        >
                          {outcomeMeta.label}
                        </span>
                      )}
                      {sim.dossier?.localite && (
                        <span className="text-xs text-klary-grey">
                          · {sim.dossier.localite}
                        </span>
                      )}
                    </div>
                    <div className="text-sm text-klary-grey flex gap-4 flex-wrap">
                      <span>
                        <strong className="text-klary-navy">
                          {formatCHF(prixBien)} CHF
                        </strong>{" "}
                        prix bien
                      </span>
                      <span>
                        <strong className="text-klary-navy">
                          {formatCHF(versement)}
                        </strong>{" "}
                        /mois 3a proposé
                      </span>
                      <span>Créé le {created}</span>
                    </div>
                    {sim.notes && (
                      <div className="mt-2 text-sm text-klary-grey italic line-clamp-2">
                        « {sim.notes} »
                      </div>
                    )}
                    {sim.relance_at && (
                      <div className="mt-2 text-xs text-blue-600 font-semibold">
                        🔔 Relance prévue le{" "}
                        {new Date(sim.relance_at).toLocaleDateString("fr-CH")}
                      </div>
                    )}
                  </div>
                  <div className="text-klary-orange text-xl">→</div>
                </div>
              </Link>
            );
          })}
        </div>
      )}
    </div>
  );
}
