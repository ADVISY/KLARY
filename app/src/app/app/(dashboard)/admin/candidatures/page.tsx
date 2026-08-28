import { redirect } from "next/navigation";
import Link from "next/link";
import { createSupabaseServerClient } from "@/lib/supabase/server";

export const metadata = {
  title: "Candidatures",
};

const STATUS_LABELS: Record<string, { label: string; color: string }> = {
  new: { label: "Nouveau", color: "bg-blue-100 text-blue-800" },
  reviewed: { label: "Examiné", color: "bg-purple-100 text-purple-800" },
  interview_1: {
    label: "Entretien 1",
    color: "bg-indigo-100 text-indigo-800",
  },
  interview_2: {
    label: "Entretien 2",
    color: "bg-indigo-100 text-indigo-800",
  },
  test_ok: { label: "Test OK", color: "bg-teal-100 text-teal-800" },
  offered: { label: "Offre envoyée", color: "bg-yellow-100 text-yellow-800" },
  hired: { label: "Embauché", color: "bg-green-100 text-green-800" },
  active: { label: "Actif en production", color: "bg-emerald-100 text-emerald-800" },
  rejected: { label: "Refusé", color: "bg-red-100 text-red-800" },
  archived: { label: "Archivé", color: "bg-gray-100 text-gray-600" },
};

export default async function CandidaturesPage() {
  const supabase = createSupabaseServerClient();
  const {
    data: { user },
  } = await supabase.auth.getUser();
  if (!user) redirect("/login");

  // Vérification role admin
  const { data: role } = await supabase
    .from("user_roles")
    .select("role")
    .eq("user_id", user.id)
    .eq("active", true)
    .maybeSingle();

  if (role?.role !== "admin" && role?.role !== "manager") {
    redirect("/formation");
  }

  const { data: candidates } = await supabase
    .from("candidates")
    .select("*")
    .order("created_at", { ascending: false });

  return (
    <div className="max-w-[1400px] mx-auto p-6 md:p-10">
      <header className="mb-8">
        <div className="text-xs font-bold tracking-widest uppercase text-klary-orange mb-2">
          Backoffice · Recrutement
        </div>
        <h1 className="text-3xl md:text-4xl font-bold text-klary-navy mb-3">
          Candidatures reçues
        </h1>
        <p className="text-klary-grey">
          {candidates?.length || 0} candidature{(candidates?.length || 0) > 1 ? "s" : ""} dans la base
        </p>
      </header>

      {!candidates || candidates.length === 0 ? (
        <div className="bg-white rounded-2xl border border-klary-light-grey p-12 text-center">
          <div className="text-4xl mb-3">📮</div>
          <h2 className="text-xl font-bold text-klary-navy mb-2">
            Aucune candidature pour l'instant.
          </h2>
          <p className="text-klary-grey">
            Les candidatures reçues via klary.ch/postuler apparaîtront ici.
          </p>
        </div>
      ) : (
        <div className="bg-white rounded-2xl border border-klary-light-grey overflow-hidden">
          <div className="w-full overflow-x-auto -mx-4 sm:mx-0">
            <table className="w-full text-sm">
            <thead className="bg-klary-cream text-klary-ink">
              <tr>
                <th className="text-left px-5 py-3 font-semibold">Candidat</th>
                <th className="text-left px-5 py-3 font-semibold">Poste</th>
                <th className="text-left px-5 py-3 font-semibold">Reçu le</th>
                <th className="text-left px-5 py-3 font-semibold">Statut</th>
                <th className="text-right px-5 py-3 font-semibold">Actions</th>
              </tr>
            </thead>
            <tbody>
              {candidates.map((c: any) => {
                const status = STATUS_LABELS[c.status] || STATUS_LABELS.new;
                return (
                  <tr
                    key={c.id}
                    className="border-t border-klary-light-grey hover:bg-klary-cream/30 transition"
                  >
                    <td className="px-5 py-3">
                      <div className="font-semibold text-klary-navy">
                        {c.first_name} {c.last_name}
                      </div>
                      <div className="text-xs text-klary-grey">{c.email}</div>
                      {c.phone && (
                        <div className="text-xs text-klary-grey">{c.phone}</div>
                      )}
                    </td>
                    <td className="px-5 py-3 text-klary-ink">
                      {c.position_applied || "—"}
                    </td>
                    <td className="px-5 py-3 text-klary-grey">
                      {new Date(c.created_at).toLocaleDateString("fr-CH", {
                        day: "2-digit",
                        month: "short",
                        year: "numeric",
                      })}
                    </td>
                    <td className="px-5 py-3">
                      <span
                        className={`px-2 py-1 rounded-full text-xs font-semibold ${status.color}`}
                      >
                        {status.label}
                      </span>
                    </td>
                    <td className="px-5 py-3 text-right">
                      <Link
                        href={`/admin/candidatures/${c.id}`}
                        className="text-klary-orange font-semibold hover:underline text-sm"
                      >
                        Voir →
                      </Link>
                    </td>
                  </tr>
                );
              })}
            </tbody>
          </table>
          </div>
        </div>
      )}
    </div>
  );
}
