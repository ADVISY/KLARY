import { redirect, notFound } from "next/navigation";
import Link from "next/link";
import { createServerClient, type CookieOptions } from "@supabase/ssr";
import { cookies } from "next/headers";
import { createSupabaseServerClient } from "@/lib/supabase/server";

export const metadata = {
  title: "Détail candidature",
};

const STATUS_OPTIONS = [
  "new",
  "reviewed",
  "interview_1",
  "interview_2",
  "test_ok",
  "offered",
  "hired",
  "rejected",
  "archived",
];

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
  if (role?.role !== "admin" && role?.role !== "manager") redirect("/formation");

  const { data: candidate } = await supabase
    .from("candidates")
    .select("*")
    .eq("id", params.id)
    .maybeSingle();

  if (!candidate) notFound();

  // Signed URL pour download CV (côté serveur avec service_role si nécessaire)
  let signedUrl: string | null = null;
  if (candidate.cv_storage_path) {
    const cookieStore = cookies();
    const serviceClient = createServerClient(
      process.env.NEXT_PUBLIC_SUPABASE_URL!,
      process.env.SUPABASE_SERVICE_ROLE_KEY!,
      {
        cookies: {
          getAll: () => cookieStore.getAll(),
          setAll: () => {},
        },
      }
    );
    const { data: sig } = await serviceClient.storage
      .from("cvs")
      .createSignedUrl(candidate.cv_storage_path, 3600);
    signedUrl = sig?.signedUrl || null;
  }

  return (
    <div className="max-w-3xl mx-auto p-6 md:p-10">
      <div className="mb-6">
        <Link
          href="/admin/candidatures"
          className="text-sm text-klary-grey hover:text-klary-orange transition"
        >
          ← Retour aux candidatures
        </Link>
      </div>

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
          <InfoRow
            label="Source"
            value={candidate.source || "—"}
          />
          <InfoRow
            label="Reçu le"
            value={new Date(candidate.created_at).toLocaleString("fr-CH")}
          />
          <InfoRow
            label="Suppression prévue"
            value={new Date(candidate.scheduled_delete_at).toLocaleDateString("fr-CH")}
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

        {signedUrl && (
          <div className="mb-4">
            <a
              href={signedUrl}
              target="_blank"
              rel="noopener noreferrer"
              className="inline-flex items-center gap-2 px-5 py-3 bg-klary-navy text-white font-semibold rounded-xl hover:bg-klary-navy/90 transition"
            >
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
              Télécharger le CV (PDF)
            </a>
            <p className="text-xs text-klary-grey mt-2 italic">
              Lien valable 1 heure.
            </p>
          </div>
        )}
      </div>

      {/* Statut + Notes internes (form) */}
      <div className="bg-white rounded-2xl border border-klary-light-grey p-6">
        <h2 className="font-bold text-klary-navy mb-4">Suivi interne</h2>
        <form
          action={`/api/admin/candidatures/${candidate.id}`}
          method="POST"
          className="space-y-4"
        >
          <div>
            <label className="block text-sm font-semibold text-klary-ink mb-1.5">
              Statut
            </label>
            <select
              name="status"
              defaultValue={candidate.status}
              className="w-full px-4 py-2.5 border border-klary-light-grey rounded-lg focus:outline-none focus:border-klary-orange bg-white"
            >
              {STATUS_OPTIONS.map((s) => (
                <option key={s} value={s}>
                  {s}
                </option>
              ))}
            </select>
          </div>
          <div>
            <label className="block text-sm font-semibold text-klary-ink mb-1.5">
              Notes internes
            </label>
            <textarea
              name="internal_notes"
              rows={4}
              defaultValue={candidate.internal_notes || ""}
              className="w-full px-4 py-2.5 border border-klary-light-grey rounded-lg focus:outline-none focus:border-klary-orange"
            />
          </div>
          <button
            type="submit"
            className="w-full py-3 bg-klary-orange text-white font-semibold rounded-xl hover:bg-klary-orange/90 transition"
          >
            Enregistrer
          </button>
        </form>
      </div>
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
