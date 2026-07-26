import { redirect, notFound } from "next/navigation";
import Link from "next/link";
import { createClient } from "@supabase/supabase-js";
import { createSupabaseServerClient } from "@/lib/supabase/server";

export const metadata = {
  title: "Détail candidature",
};

// Force le re-render à chaque requête pour régénérer les signed URLs 1h
export const dynamic = "force-dynamic";

// Statuts en français avec description contextuelle
const STATUS_OPTIONS: {
  value: string;
  label: string;
  description: string;
}[] = [
  { value: "new", label: "Nouveau", description: "Candidature reçue, à examiner" },
  { value: "reviewed", label: "Examinée", description: "Profil étudié — aucun email envoyé" },
  {
    value: "interview_1",
    label: "Entretien 1 — envoyer invitation",
    description: "📧 Génère 3 créneaux et envoie invitation au candidat",
  },
  {
    value: "interview_2",
    label: "Entretien 2 (2ᵉ tour)",
    description: "2ᵉ entretien planifié manuellement",
  },
  { value: "test_ok", label: "Test réussi", description: "Évaluation technique validée" },
  { value: "offered", label: "Offre envoyée", description: "Proposition d'embauche transmise" },
  {
    value: "hired",
    label: "Embauché — envoyer bienvenue",
    description: "📧 Envoie email bienvenue + parcours 4 étapes",
  },
  {
    value: "active",
    label: "Actif — envoyer activation",
    description: "📧 Envoie email accès complets activés (portefeuille, CRM, email)",
  },
  {
    value: "rejected",
    label: "Refusé — envoyer refus",
    description: "📧 Envoie email de refus poli au candidat",
  },
  { value: "archived", label: "Archivé", description: "Dossier fermé" },
];

// Labels documents additionnels (mapping vers un nom lisible)
const DOC_LABELS: Record<string, string> = {
  diplomes: "Diplômes / attestations",
  casier: "Extrait de casier judiciaire",
  poursuites: "Extrait de l'office des poursuites",
};

// Labels lisibles pour les email_events
const EMAIL_EVENT_LABELS: Record<string, string> = {
  candidature_confirmation: "Accusé de réception candidature",
  candidature_admin_notif: "Notif admin (nouvelle candidature)",
  candidature_refus: "Refus poli",
  invitation_entretien: "Invitation entretien + 3 créneaux",
  entretien_confirmation_candidat: "Confirmation créneau candidat",
  entretien_notif_admin: "Notif admin (créneau confirmé)",
  candidature_bienvenue: "Bienvenue + lien onboarding",
  candidature_activation: "Activation accès complets",
  onboarding_recu_comptable: "Onboarding reçu → comptable + CC",
  onboarding_confirmation_candidat: "Confirmation onboarding candidat",
  agent_1re_certif_assistantes: "1ère certif → assistantes",
};

function formatFileSize(bytes: number): string {
  if (bytes < 1024) return `${bytes} o`;
  if (bytes < 1024 * 1024) return `${(bytes / 1024).toFixed(0)} Ko`;
  return `${(bytes / (1024 * 1024)).toFixed(1)} Mo`;
}

export default async function CandidatureDetailPage({
  params,
}: {
  params: { id: string };
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

  const { data: candidate } = await supabase
    .from("candidates")
    .select("*")
    .eq("id", params.id)
    .maybeSingle();

  if (!candidate) notFound();

  // Historique événements
  const { data: events } = await supabase
    .from("candidate_events")
    .select("event_type, details, created_at")
    .eq("candidate_id", params.id)
    .order("created_at", { ascending: false })
    .limit(10);

  // Historique emails envoyés
  const { data: emails } = await supabase
    .from("email_events")
    .select("event_type, recipient, cc, subject, status, error, sent_at")
    .eq("candidate_id", params.id)
    .order("sent_at", { ascending: false });

  // Créneaux d'entretien (s'il en existe)
  const { data: interview } = await supabase
    .from("interview_slots")
    .select("*")
    .eq("candidate_id", params.id)
    .order("created_at", { ascending: false })
    .limit(1)
    .maybeSingle();

  // Dossier d'onboarding (s'il existe)
  const { data: onboarding } = await supabase
    .from("onboarding_forms")
    .select(
      "id, form_token, created_at, submitted_at, comptable_notified_at, form_data, uploaded_docs"
    )
    .eq("candidate_id", params.id)
    .order("created_at", { ascending: false })
    .limit(1)
    .maybeSingle();

  // Client service_role pur (sans cookies) pour signed URLs storage — bypass RLS
  const serviceClient = createClient(
    process.env.NEXT_PUBLIC_SUPABASE_URL!,
    process.env.SUPABASE_SERVICE_ROLE_KEY!,
    { auth: { persistSession: false, autoRefreshToken: false } }
  );

  // Signed URL CV
  let cvSignedUrl: string | null = null;
  if (candidate.cv_storage_path) {
    const { data: sig } = await serviceClient.storage
      .from("cvs")
      .createSignedUrl(candidate.cv_storage_path, 3600);
    cvSignedUrl = sig?.signedUrl || null;
  }

  // Signed URLs pour documents additionnels
  type AdditionalDoc = {
    key: string;
    filename: string;
    storage_path: string;
    size_bytes: number;
    signedUrl?: string | null;
  };
  const additionalDocs: AdditionalDoc[] = Array.isArray(
    candidate.additional_documents
  )
    ? candidate.additional_documents
    : [];

  for (const doc of additionalDocs) {
    const { data: sig } = await serviceClient.storage
      .from("cvs")
      .createSignedUrl(doc.storage_path, 3600);
    doc.signedUrl = sig?.signedUrl || null;
  }

  const proposedSlots = (interview?.proposed_slots as any[]) || [];
  const selectedSlot =
    interview?.selected_slot_index != null
      ? proposedSlots[interview.selected_slot_index as number]
      : null;

  return (
    <div className="max-w-4xl mx-auto p-6 md:p-10">
      <div className="mb-6">
        <Link
          href="/admin/candidatures"
          className="text-sm text-klary-grey hover:text-klary-orange transition"
        >
          ← Retour aux candidatures
        </Link>
      </div>

      {/* ─── Bloc identité + informations ─── */}
      <div className="bg-white rounded-2xl border border-klary-light-grey p-8 mb-6">
        <div className="text-xs font-bold tracking-widest uppercase text-klary-orange mb-2">
          Candidature
        </div>
        <h1 className="text-3xl font-bold text-klary-navy mb-4">
          {candidate.first_name} {candidate.last_name}
        </h1>

        <div className="grid grid-cols-1 md:grid-cols-2 gap-4 mb-6">
          <InfoRow label="Email" value={candidate.email} />
          <InfoRow label="Téléphone" value={candidate.phone || "—"} />
          <InfoRow
            label="Poste visé"
            value={candidate.position_applied || "—"}
          />
          <InfoRow label="Source" value={candidate.source || "—"} />
          <InfoRow
            label="Reçue le"
            value={new Date(candidate.created_at).toLocaleString("fr-CH")}
          />
          <InfoRow
            label="Suppression prévue"
            value={new Date(candidate.scheduled_delete_at).toLocaleDateString(
              "fr-CH"
            )}
          />
        </div>

        {candidate.cover_letter && (
          <div className="mb-6">
            <div className="text-xs font-bold uppercase tracking-widest text-klary-grey mb-2">
              Lettre de motivation
            </div>
            <div className="p-4 bg-klary-cream rounded-xl text-sm text-klary-ink whitespace-pre-wrap">
              {candidate.cover_letter}
            </div>
          </div>
        )}

        {candidate.why_klary && (
          <div className="mb-6">
            <div className="text-xs font-bold uppercase tracking-widest text-klary-grey mb-2">
              Pourquoi Klary
            </div>
            <div className="p-4 bg-klary-cream rounded-xl text-sm text-klary-ink whitespace-pre-wrap">
              {candidate.why_klary}
            </div>
          </div>
        )}
      </div>

      {/* ─── Bloc documents ─── */}
      <div className="bg-white rounded-2xl border border-klary-light-grey p-8 mb-6">
        <h2 className="font-bold text-klary-navy mb-4 flex items-center gap-2">
          <svg
            className="w-5 h-5"
            fill="none"
            stroke="currentColor"
            strokeWidth={2}
            viewBox="0 0 24 24"
          >
            <path
              strokeLinecap="round"
              strokeLinejoin="round"
              d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"
            />
          </svg>
          Documents transmis
        </h2>

        <div className="space-y-3">
          {/* CV */}
          <DocumentRow
            label="CV"
            description="Curriculum vitae principal"
            filename={candidate.cv_storage_path?.split("/").pop() || "cv.pdf"}
            signedUrl={cvSignedUrl}
            highlight
          />

          {/* Documents additionnels */}
          {additionalDocs.length > 0 &&
            additionalDocs.map((doc) => (
              <DocumentRow
                key={doc.storage_path}
                label={DOC_LABELS[doc.key] || doc.key}
                description={`${formatFileSize(doc.size_bytes)}`}
                filename={doc.filename}
                signedUrl={doc.signedUrl || null}
              />
            ))}

          {additionalDocs.length === 0 && (
            <p className="text-xs text-klary-grey italic pt-2">
              Aucun document additionnel transmis (diplômes / casier / poursuites).
            </p>
          )}
        </div>

        <p className="text-xs text-klary-grey mt-4 italic">
          Les liens de téléchargement sont valables 1 heure. Rechargez la page
          pour régénérer les liens.
        </p>
      </div>

      {/* ─── Bloc entretien (si créneaux existent) ─── */}
      {interview && (
        <div className="bg-white rounded-2xl border border-klary-light-grey p-8 mb-6">
          <h2 className="font-bold text-klary-navy mb-4 flex items-center gap-2">
            📅 Entretien
          </h2>
          {selectedSlot ? (
            <div className="p-4 bg-green-50 border-l-4 border-green-500 rounded-lg">
              <div className="text-[10px] uppercase tracking-widest text-green-700 font-bold mb-1">
                Créneau confirmé par le candidat
              </div>
              <div className="text-lg font-bold text-klary-navy">
                {new Date(selectedSlot.start).toLocaleString("fr-CH", {
                  weekday: "long",
                  day: "numeric",
                  month: "long",
                  year: "numeric",
                  hour: "2-digit",
                  minute: "2-digit",
                  timeZone: "Europe/Zurich",
                })}
              </div>
              <div className="text-xs text-klary-grey mt-1">
                Durée : {selectedSlot.duration_min} min
              </div>
            </div>
          ) : (
            <div>
              <p className="text-sm text-klary-grey mb-3">
                Créneaux proposés au candidat — en attente de sa sélection :
              </p>
              <ul className="space-y-2 text-sm">
                {proposedSlots.map((slot: any, i: number) => (
                  <li key={i} className="p-3 bg-klary-cream rounded-lg">
                    <span className="font-semibold">Option {i + 1} :</span>{" "}
                    {new Date(slot.start).toLocaleString("fr-CH", {
                      weekday: "long",
                      day: "numeric",
                      month: "long",
                      hour: "2-digit",
                      minute: "2-digit",
                      timeZone: "Europe/Zurich",
                    })}
                  </li>
                ))}
              </ul>
              <p className="text-xs text-klary-grey mt-3 italic">
                Lien envoyé au candidat :{" "}
                <code className="text-klary-orange">
                  /entretien/{interview.selection_token?.slice(0, 8)}…
                </code>
              </p>
            </div>
          )}
        </div>
      )}

      {/* ─── Bloc dossier onboarding ─── */}
      {onboarding && (
        <div className="bg-white rounded-2xl border border-klary-light-grey p-8 mb-6">
          <h2 className="font-bold text-klary-navy mb-4 flex items-center gap-2">
            📁 Dossier d'onboarding
          </h2>
          {onboarding.submitted_at ? (
            <div>
              <div className="flex items-center gap-2 text-green-700 font-semibold mb-3">
                <span className="text-xl">✓</span>
                <span>
                  Soumis le{" "}
                  {new Date(onboarding.submitted_at).toLocaleString("fr-CH")}
                </span>
              </div>
              {onboarding.comptable_notified_at ? (
                <div className="text-xs text-green-700 mb-3">
                  📧 Comptable notifié le{" "}
                  {new Date(
                    onboarding.comptable_notified_at
                  ).toLocaleString("fr-CH")}
                </div>
              ) : (
                <div className="text-xs text-yellow-700 mb-3">
                  ⏳ Notification comptable en cours
                </div>
              )}

              {Array.isArray(onboarding.uploaded_docs) && (
                <div className="text-xs text-klary-grey mb-3">
                  {onboarding.uploaded_docs.length} document(s) téléversé(s).
                </div>
              )}

              <Link
                href={`/admin/onboarding/${onboarding.id}`}
                className="inline-flex items-center gap-2 px-4 py-2.5 bg-klary-navy text-white font-semibold rounded-lg hover:bg-klary-navy/90 transition text-sm"
              >
                Voir le dossier complet →
              </Link>
            </div>
          ) : (
            <div>
              <div className="flex items-center gap-2 text-yellow-700 font-semibold mb-2">
                <span>⏳</span>
                <span>En attente de soumission du candidat</span>
              </div>
              <div className="text-xs text-klary-grey">
                Créé le{" "}
                {new Date(onboarding.created_at).toLocaleString("fr-CH")}
              </div>
              <details className="mt-3">
                <summary className="text-xs text-klary-grey cursor-pointer hover:text-klary-orange">
                  Voir le lien privé envoyé au candidat
                </summary>
                <div className="mt-2 p-2 bg-klary-cream rounded font-mono text-xs text-klary-orange break-all">
                  {process.env.NEXT_PUBLIC_APP_URL ||
                    "https://app.klary.ch"}
                  /onboarding/{onboarding.form_token}
                </div>
              </details>
              <Link
                href={`/admin/onboarding/${onboarding.id}`}
                className="mt-3 inline-flex items-center gap-2 text-xs font-semibold text-klary-orange hover:underline"
              >
                Voir la fiche onboarding →
              </Link>
            </div>
          )}
        </div>
      )}

      {/* ─── Bloc statut + notes internes ─── */}
      <div className="bg-white rounded-2xl border border-klary-light-grey p-8 mb-6">
        <h2 className="font-bold text-klary-navy mb-4">Suivi interne</h2>
        <form
          action={`/api/admin/candidatures/${candidate.id}`}
          method="POST"
          className="space-y-4"
        >
          <div>
            <label className="block text-sm font-semibold text-klary-ink mb-1.5">
              Statut de la candidature
            </label>
            <select
              name="status"
              defaultValue={candidate.status}
              className="w-full px-4 py-2.5 border border-klary-light-grey rounded-lg focus:outline-none focus:border-klary-orange bg-white"
            >
              {STATUS_OPTIONS.map((s) => (
                <option key={s.value} value={s.value}>
                  {s.label}
                </option>
              ))}
            </select>
            <p className="text-xs text-klary-grey mt-1.5 italic">
              💡{" "}
              {
                STATUS_OPTIONS.find((s) => s.value === candidate.status)
                  ?.description
              }
            </p>
          </div>
          <div>
            <label className="block text-sm font-semibold text-klary-ink mb-1.5">
              Notes internes (privées, non visibles par le candidat)
            </label>
            <textarea
              name="internal_notes"
              rows={4}
              defaultValue={candidate.internal_notes || ""}
              className="w-full px-4 py-2.5 border border-klary-light-grey rounded-lg focus:outline-none focus:border-klary-orange"
              placeholder="Impressions entretien, points forts, points d'attention…"
            />
          </div>
          <button
            type="submit"
            className="w-full py-3 bg-klary-orange text-white font-semibold rounded-xl hover:bg-klary-orange/90 transition"
          >
            Enregistrer et déclencher les notifications
          </button>
        </form>
      </div>

      {/* ─── Historique EMAILS envoyés ─── */}
      {emails && emails.length > 0 && (
        <div className="bg-white rounded-2xl border border-klary-light-grey p-6 mb-6">
          <h2 className="font-bold text-klary-navy mb-4 flex items-center gap-2">
            📧 Emails envoyés ({emails.length})
          </h2>
          <ul className="space-y-2">
            {emails.map((e: any, i: number) => {
              const label =
                EMAIL_EVENT_LABELS[e.event_type] || e.event_type;
              const isFailed = e.status === "failed";
              return (
                <li
                  key={i}
                  className={`p-3 rounded-xl border ${
                    isFailed
                      ? "border-red-300 bg-red-50/40"
                      : "border-klary-light-grey bg-white"
                  }`}
                >
                  <div className="flex items-start justify-between gap-3">
                    <div className="min-w-0 flex-1">
                      <div className="flex items-center gap-2 flex-wrap">
                        <span
                          className={`text-[10px] uppercase tracking-widest font-bold px-2 py-0.5 rounded ${
                            isFailed
                              ? "bg-red-100 text-red-800"
                              : "bg-klary-orange/10 text-klary-orange"
                          }`}
                        >
                          {label}
                        </span>
                        <span className="text-[11px] font-mono text-klary-grey">
                          {new Date(e.sent_at).toLocaleString("fr-CH", {
                            day: "2-digit",
                            month: "2-digit",
                            year: "2-digit",
                            hour: "2-digit",
                            minute: "2-digit",
                          })}
                        </span>
                        {isFailed && (
                          <span className="text-[10px] uppercase font-bold text-red-700">
                            ⚠ Échec
                          </span>
                        )}
                      </div>
                      <div className="text-sm font-semibold text-klary-navy mt-1">
                        {e.subject}
                      </div>
                      <div className="text-xs text-klary-grey mt-0.5">
                        <strong>À :</strong> {e.recipient}
                        {e.cc && (
                          <>
                            <br />
                            <strong>Cc :</strong> {e.cc}
                          </>
                        )}
                        {e.error && (
                          <>
                            <br />
                            <span className="text-red-700">
                              Erreur : {e.error}
                            </span>
                          </>
                        )}
                      </div>
                    </div>
                  </div>
                </li>
              );
            })}
          </ul>
        </div>
      )}

      {/* ─── Historique événements ─── */}
      {events && events.length > 0 && (
        <div className="bg-white rounded-2xl border border-klary-light-grey p-6">
          <h2 className="font-bold text-klary-navy mb-4">Historique</h2>
          <ul className="space-y-2">
            {events.map((e: any, i: number) => (
              <li
                key={i}
                className="text-xs text-klary-grey flex items-start gap-3 pb-2 border-b border-klary-light-grey last:border-0 last:pb-0"
              >
                <span className="font-mono text-klary-navy/60 shrink-0">
                  {new Date(e.created_at).toLocaleString("fr-CH", {
                    day: "2-digit",
                    month: "2-digit",
                    hour: "2-digit",
                    minute: "2-digit",
                  })}
                </span>
                <span>
                  {e.event_type === "status_or_notes_updated" && e.details ? (
                    <>
                      Statut :{" "}
                      <strong className="text-klary-navy">
                        {STATUS_OPTIONS.find(
                          (s) => s.value === e.details.from
                        )?.label || e.details.from}
                      </strong>
                      {" → "}
                      <strong className="text-klary-orange">
                        {STATUS_OPTIONS.find((s) => s.value === e.details.to)
                          ?.label || e.details.to}
                      </strong>
                    </>
                  ) : (
                    e.event_type
                  )}
                </span>
              </li>
            ))}
          </ul>
        </div>
      )}
    </div>
  );
}

function InfoRow({ label, value }: { label: string; value: string }) {
  return (
    <div>
      <div className="text-[10px] uppercase tracking-widest text-klary-grey font-bold mb-1">
        {label}
      </div>
      <div className="text-sm font-semibold text-klary-navy break-all">
        {value}
      </div>
    </div>
  );
}

function DocumentRow({
  label,
  description,
  filename,
  signedUrl,
  highlight = false,
}: {
  label: string;
  description: string;
  filename: string;
  signedUrl: string | null;
  highlight?: boolean;
}) {
  return (
    <div
      className={`flex items-center justify-between gap-4 p-4 rounded-xl border ${
        highlight
          ? "border-klary-orange/30 bg-klary-orange/5"
          : "border-klary-light-grey bg-white"
      }`}
    >
      <div className="min-w-0 flex-1">
        <div className="font-semibold text-klary-navy">{label}</div>
        <div className="text-xs text-klary-grey mt-0.5 truncate">
          {filename} · {description}
        </div>
      </div>
      {signedUrl ? (
        <div className="flex items-center gap-2 shrink-0">
          <a
            href={signedUrl}
            target="_blank"
            rel="noopener noreferrer"
            title="Ouvrir dans un nouvel onglet"
            className="px-3 py-2 text-xs font-semibold text-klary-navy border border-klary-navy/20 rounded-lg hover:bg-klary-navy/5 transition"
          >
            👁 Voir
          </a>
          <a
            href={`${signedUrl}&download=${encodeURIComponent(filename)}`}
            title="Télécharger sur votre appareil"
            className={`px-3 py-2 text-xs font-semibold text-white rounded-lg transition ${
              highlight
                ? "bg-klary-orange hover:bg-klary-orange/90"
                : "bg-klary-navy hover:bg-klary-navy/90"
            }`}
          >
            ⬇ Télécharger
          </a>
        </div>
      ) : (
        <span className="text-xs text-red-600 shrink-0">
          Lien indisponible
        </span>
      )}
    </div>
  );
}
