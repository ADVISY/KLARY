import { redirect } from "next/navigation";
import { createSupabaseServerClient } from "@/lib/supabase/server";
import { InitiateOffboardingModal } from "./InitiateOffboardingModal";

export const metadata = {
  title: "Agents — Admin",
};

export const dynamic = "force-dynamic";

const ROLE_LABELS: Record<string, string> = {
  admin: "Admin",
  manager: "Manager",
  agent: "Agent",
};

const ROLE_COLORS: Record<string, string> = {
  admin: "bg-red-100 text-red-800",
  manager: "bg-purple-100 text-purple-800",
  agent: "bg-blue-100 text-blue-800",
};

export default async function AdminAgentsPage() {
  const supabase = createSupabaseServerClient();
  const {
    data: { user },
  } = await supabase.auth.getUser();
  if (!user) redirect("/login");

  const { data: viewerRole } = await supabase
    .from("user_roles")
    .select("role")
    .eq("user_id", user.id)
    .eq("active", true)
    .maybeSingle();
  if (viewerRole?.role !== "admin" && viewerRole?.role !== "manager")
    redirect("/formation");

  // Tous les user_roles actifs
  const { data: rows } = await supabase
    .from("user_roles")
    .select(
      "user_id, role, first_name, last_name, active, profile_completed, date_of_birth, postal_city, phone, created_at"
    )
    .order("created_at", { ascending: false });

  // Certifs actives par agent
  const userIds = Array.from(new Set((rows || []).map((r) => r.user_id)));
  const { data: certs } = userIds.length
    ? await supabase
        .from("training_certifications")
        .select("user_id, module_key, valid_until, revoked")
        .in("user_id", userIds)
        .eq("revoked", false)
    : { data: [] };
  const certsByUser = new Map<string, any[]>();
  for (const c of certs || []) {
    const arr = certsByUser.get(c.user_id) || [];
    arr.push(c);
    certsByUser.set(c.user_id, arr);
  }

  const MODULE_LABELS: Record<string, string> = {
    maladie: "Maladie",
    lpp: "LPP",
    prevoyance: "Prévoyance",
    hypotheque: "Hypothèque",
    prospection_vente: "Prospection & Vente",
  };

  const total = rows?.length || 0;
  const active = rows?.filter((r) => r.active).length || 0;
  const agents = rows?.filter((r) => r.role === "agent").length || 0;
  const managers = rows?.filter((r) => r.role === "manager").length || 0;
  const admins = rows?.filter((r) => r.role === "admin").length || 0;

  return (
    <div className="max-w-6xl mx-auto p-6 md:p-10">
      <header className="mb-8">
        <div className="text-xs font-bold tracking-widest uppercase text-klary-orange mb-2">
          Backoffice · Équipe
        </div>
        <h1 className="text-3xl md:text-4xl font-bold text-klary-navy mb-3">
          Agents & équipe Klary
        </h1>
        <p className="text-klary-grey">
          Vue d'ensemble des utilisateurs de la plateforme Klary : agents,
          managers, admins.
        </p>
      </header>

      {/* Stats */}
      <div className="grid grid-cols-2 md:grid-cols-4 gap-4 mb-8">
        <div className="bg-white rounded-xl border border-klary-light-grey p-4">
          <div className="text-[10px] uppercase tracking-widest text-klary-grey font-bold mb-1">
            Total actifs
          </div>
          <div className="text-2xl font-bold text-klary-navy">{active}</div>
        </div>
        <div className="bg-white rounded-xl border border-blue-200 p-4">
          <div className="text-[10px] uppercase tracking-widest text-blue-700 font-bold mb-1">
            Agents
          </div>
          <div className="text-2xl font-bold text-blue-700">{agents}</div>
        </div>
        <div className="bg-white rounded-xl border border-purple-200 p-4">
          <div className="text-[10px] uppercase tracking-widest text-purple-700 font-bold mb-1">
            Managers
          </div>
          <div className="text-2xl font-bold text-purple-700">{managers}</div>
        </div>
        <div className="bg-white rounded-xl border border-red-200 p-4">
          <div className="text-[10px] uppercase tracking-widest text-red-700 font-bold mb-1">
            Admins
          </div>
          <div className="text-2xl font-bold text-red-700">{admins}</div>
        </div>
      </div>

      {!rows || rows.length === 0 ? (
        <div className="bg-white rounded-2xl border border-klary-light-grey p-10 text-center">
          <div className="text-3xl mb-3">👥</div>
          <h2 className="text-xl font-bold text-klary-navy mb-2">
            Aucun utilisateur enregistré
          </h2>
          <p className="text-klary-grey">
            Les utilisateurs qui se connectent avec un email @klary.ch
            apparaîtront ici automatiquement.
          </p>
        </div>
      ) : (
        <div className="bg-white rounded-2xl border border-klary-light-grey overflow-hidden">
          <table className="w-full text-sm">
            <thead className="bg-klary-cream text-klary-ink">
              <tr>
                <th className="text-left px-5 py-3 font-semibold">Nom</th>
                <th className="text-left px-5 py-3 font-semibold">Rôle</th>
                <th className="text-left px-5 py-3 font-semibold">Ville</th>
                <th className="text-center px-5 py-3 font-semibold">
                  Profil
                </th>
                <th className="text-left px-5 py-3 font-semibold">
                  Certifications actives
                </th>
                <th className="text-left px-5 py-3 font-semibold">
                  Créé le
                </th>
                <th className="text-center px-5 py-3 font-semibold">
                  Statut
                </th>
                <th className="text-right px-5 py-3 font-semibold">
                  Actions
                </th>
              </tr>
            </thead>
            <tbody>
              {rows.map((r: any) => {
                const uc = certsByUser.get(r.user_id) || [];
                const fullName =
                  [r.first_name, r.last_name].filter(Boolean).join(" ") ||
                  "—";
                return (
                  <tr
                    key={`${r.user_id}-${r.role}`}
                    className="border-t border-klary-light-grey hover:bg-klary-cream/30"
                  >
                    <td className="px-5 py-3">
                      <div className="font-semibold text-klary-navy">
                        {fullName}
                      </div>
                      {r.phone && (
                        <div className="text-xs text-klary-grey">
                          {r.phone}
                        </div>
                      )}
                    </td>
                    <td className="px-5 py-3">
                      <span
                        className={`px-2 py-1 rounded-full text-[10px] font-bold uppercase ${
                          ROLE_COLORS[r.role] || "bg-gray-100 text-gray-700"
                        }`}
                      >
                        {ROLE_LABELS[r.role] || r.role}
                      </span>
                    </td>
                    <td className="px-5 py-3 text-klary-ink text-xs">
                      {r.postal_city || "—"}
                    </td>
                    <td className="px-5 py-3 text-center">
                      {r.profile_completed ? (
                        <span className="text-green-700 font-bold">✓</span>
                      ) : (
                        <span className="text-yellow-700">⏳</span>
                      )}
                    </td>
                    <td className="px-5 py-3">
                      {uc.length === 0 ? (
                        <span className="text-xs text-klary-grey italic">
                          aucune
                        </span>
                      ) : (
                        <div className="flex flex-wrap gap-1">
                          {uc.map((c: any) => {
                            const expired =
                              new Date(c.valid_until) < new Date();
                            return (
                              <span
                                key={c.module_key}
                                className={`text-[10px] px-1.5 py-0.5 rounded ${
                                  expired
                                    ? "bg-yellow-100 text-yellow-800"
                                    : "bg-green-100 text-green-800"
                                }`}
                                title={`Valide jusqu'au ${new Date(
                                  c.valid_until
                                ).toLocaleDateString("fr-CH")}`}
                              >
                                {MODULE_LABELS[c.module_key] || c.module_key}
                                {expired ? " (expirée)" : ""}
                              </span>
                            );
                          })}
                        </div>
                      )}
                    </td>
                    <td className="px-5 py-3 text-klary-grey text-xs">
                      {new Date(r.created_at).toLocaleDateString("fr-CH")}
                    </td>
                    <td className="px-5 py-3 text-center">
                      {r.active ? (
                        <span className="px-2 py-0.5 rounded-full text-[10px] font-semibold bg-green-100 text-green-800">
                          Actif
                        </span>
                      ) : (
                        <span className="px-2 py-0.5 rounded-full text-[10px] font-semibold bg-gray-100 text-gray-600">
                          Inactif
                        </span>
                      )}
                    </td>
                    <td className="px-5 py-3 text-right">
                      {r.active && viewerRole?.role === "admin" && (
                        <InitiateOffboardingModal
                          agentId={r.user_id}
                          agentName={fullName}
                        />
                      )}
                    </td>
                  </tr>
                );
              })}
            </tbody>
          </table>
        </div>
      )}
    </div>
  );
}
