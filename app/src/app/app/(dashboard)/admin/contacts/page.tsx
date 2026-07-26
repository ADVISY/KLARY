import { redirect } from "next/navigation";
import Link from "next/link";
import { createSupabaseServerClient } from "@/lib/supabase/server";

export const metadata = {
  title: "Messages contact — Admin",
};

export const dynamic = "force-dynamic";

const SUBJECT_LABELS: Record<string, string> = {
  demande_information: "Demande d'information",
  demande_devis: "Demande de devis / comparatif",
  assurance_maladie: "Assurance maladie",
  prevoyance: "Prévoyance / 3e pilier",
  lpp_libre_passage: "LPP libre passage",
  hypotheque: "Hypothèque",
  autre: "Autre",
};

const STATUS_LABELS: Record<string, { label: string; color: string }> = {
  new: { label: "Nouveau", color: "bg-blue-100 text-blue-800" },
  in_progress: { label: "En cours", color: "bg-yellow-100 text-yellow-800" },
  answered: { label: "Répondu", color: "bg-purple-100 text-purple-800" },
  converted_lead: {
    label: "Converti en lead",
    color: "bg-green-100 text-green-800",
  },
  closed: { label: "Fermé", color: "bg-gray-100 text-gray-600" },
  spam: { label: "Spam", color: "bg-red-100 text-red-800" },
};

export default async function AdminContactsPage() {
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

  const { data: messages } = await supabase
    .from("contact_messages")
    .select("*")
    .order("created_at", { ascending: false })
    .limit(200);

  const total = messages?.length || 0;
  const newCount = messages?.filter((m) => m.status === "new").length || 0;
  const inProgress =
    messages?.filter((m) => m.status === "in_progress").length || 0;
  const converted =
    messages?.filter((m) => m.status === "converted_lead").length || 0;

  return (
    <div className="max-w-6xl mx-auto p-6 md:p-10">
      <header className="mb-8">
        <div className="text-xs font-bold tracking-widest uppercase text-klary-orange mb-2">
          Backoffice · Contact
        </div>
        <h1 className="text-3xl md:text-4xl font-bold text-klary-navy mb-3">
          Messages de contact
        </h1>
        <p className="text-klary-grey">
          Messages reçus via le formulaire de contact klary.ch. Les 200
          derniers.
        </p>
      </header>

      {/* Stats */}
      <div className="grid grid-cols-2 md:grid-cols-4 gap-4 mb-8">
        <div className="bg-white rounded-xl border border-klary-light-grey p-4">
          <div className="text-[10px] uppercase tracking-widest text-klary-grey font-bold mb-1">
            Total
          </div>
          <div className="text-2xl font-bold text-klary-navy">{total}</div>
        </div>
        <div className="bg-white rounded-xl border border-blue-200 p-4">
          <div className="text-[10px] uppercase tracking-widest text-blue-700 font-bold mb-1">
            Nouveaux
          </div>
          <div className="text-2xl font-bold text-blue-700">{newCount}</div>
        </div>
        <div className="bg-white rounded-xl border border-yellow-200 p-4">
          <div className="text-[10px] uppercase tracking-widest text-yellow-700 font-bold mb-1">
            En cours
          </div>
          <div className="text-2xl font-bold text-yellow-700">{inProgress}</div>
        </div>
        <div className="bg-white rounded-xl border border-green-200 p-4">
          <div className="text-[10px] uppercase tracking-widest text-green-700 font-bold mb-1">
            Convertis lead
          </div>
          <div className="text-2xl font-bold text-green-700">{converted}</div>
        </div>
      </div>

      {!messages || messages.length === 0 ? (
        <div className="bg-white rounded-2xl border border-klary-light-grey p-10 text-center">
          <div className="text-3xl mb-3">💬</div>
          <h2 className="text-xl font-bold text-klary-navy mb-2">
            Aucun message pour l'instant
          </h2>
          <p className="text-klary-grey">
            Les messages envoyés via klary.ch/contact apparaîtront ici.
          </p>
        </div>
      ) : (
        <div className="space-y-3">
          {messages.map((m: any) => {
            const status =
              STATUS_LABELS[m.status] || STATUS_LABELS.new;
            const subject =
              SUBJECT_LABELS[m.subject] || m.subject || "—";
            return (
              <div
                key={m.id}
                className="bg-white rounded-2xl border border-klary-light-grey p-5 hover:shadow-sm transition"
              >
                <div className="flex items-start justify-between gap-4 mb-3">
                  <div>
                    <div className="font-bold text-klary-navy">
                      {m.first_name} {m.last_name}
                    </div>
                    <div className="text-xs text-klary-grey mt-0.5">
                      <a
                        href={`mailto:${m.email}`}
                        className="text-klary-orange hover:underline"
                      >
                        {m.email}
                      </a>
                      {m.phone && ` · ${m.phone}`}
                    </div>
                  </div>
                  <div className="flex flex-col items-end gap-1">
                    <span
                      className={`px-2 py-0.5 rounded-full text-[10px] font-semibold ${status.color}`}
                    >
                      {status.label}
                    </span>
                    <span className="text-[11px] text-klary-grey">
                      {new Date(m.created_at).toLocaleString("fr-CH", {
                        day: "2-digit",
                        month: "2-digit",
                        year: "2-digit",
                        hour: "2-digit",
                        minute: "2-digit",
                      })}
                    </span>
                  </div>
                </div>

                <div className="text-[10px] font-bold uppercase tracking-widest text-klary-orange mb-2">
                  {subject}
                </div>

                <div className="p-3 bg-klary-cream rounded-lg text-sm text-klary-ink whitespace-pre-wrap leading-relaxed">
                  {m.message}
                </div>

                {m.internal_notes && (
                  <div className="mt-3 p-3 bg-yellow-50 border-l-4 border-yellow-400 rounded text-xs text-yellow-900">
                    <strong>Notes internes :</strong> {m.internal_notes}
                  </div>
                )}

                <div className="mt-3 flex items-center gap-2 flex-wrap">
                  <a
                    href={`mailto:${m.email}?subject=Re: ${subject} — Klary`}
                    className="text-xs font-semibold text-klary-orange hover:underline"
                  >
                    Répondre par email →
                  </a>
                  {m.responded_at && (
                    <span className="text-[10px] text-klary-grey">
                      · Répondu le{" "}
                      {new Date(m.responded_at).toLocaleDateString("fr-CH")}
                    </span>
                  )}
                </div>
              </div>
            );
          })}
        </div>
      )}
    </div>
  );
}
