import { createSupabaseServerClient } from "@/lib/supabase/server";

export const metadata = {
  title: "Mes certifications",
};

export default async function CertificationsPage() {
  const supabase = createSupabaseServerClient();
  const {
    data: { user },
  } = await supabase.auth.getUser();

  const { data: certs } = user
    ? await supabase
        .from("training_certifications")
        .select("*, training_modules(title)")
        .eq("user_id", user.id)
        .order("issued_at", { ascending: false })
    : { data: [] };

  return (
    <div className="max-w-5xl mx-auto p-6 md:p-10">
      <header className="mb-10">
        <div className="text-xs font-bold tracking-widest uppercase text-klary-orange mb-2">
          Certifications
        </div>
        <h1 className="text-3xl md:text-4xl font-bold text-klary-navy mb-3">
          Mes certifications Klary
        </h1>
        <p className="text-klary-grey">
          Historique de vos évaluations réussies. Les certifications sont
          valides 6 mois — à renouveler régulièrement.
        </p>
      </header>

      {!certs || certs.length === 0 ? (
        <div className="bg-white rounded-2xl border border-klary-light-grey p-10 text-center">
          <div className="w-14 h-14 mx-auto mb-4 rounded-full bg-klary-orange/10 flex items-center justify-center">
            <svg
              className="w-7 h-7 text-klary-orange"
              fill="none"
              stroke="currentColor"
              strokeWidth={2}
              viewBox="0 0 24 24"
            >
              <path
                strokeLinecap="round"
                strokeLinejoin="round"
                d="M9 12l2 2 4-4"
              />
            </svg>
          </div>
          <h2 className="text-xl font-bold text-klary-navy mb-2">
            Aucune certification pour l'instant.
          </h2>
          <p className="text-klary-grey mb-6">
            Passez votre première évaluation pour obtenir votre attestation Klary.
          </p>
          <a
            href="/formation"
            className="inline-flex items-center gap-2 px-5 py-2.5 bg-klary-orange text-white font-semibold rounded-lg hover:bg-klary-orange/90 transition"
          >
            Aller à la formation
          </a>
        </div>
      ) : (
        <div className="space-y-4">
          {certs.map((cert: any) => {
            const isExpired = new Date(cert.valid_until) < new Date();
            return (
              <div
                key={cert.id}
                className="bg-white rounded-xl border border-klary-light-grey p-5 flex items-center justify-between"
              >
                <div>
                  <div className="text-xs font-semibold text-klary-orange uppercase tracking-widest mb-1">
                    {cert.cert_number}
                  </div>
                  <div className="font-bold text-klary-navy text-lg">
                    {cert.training_modules?.title || cert.module_key}
                  </div>
                  <div className="text-sm text-klary-grey mt-1">
                    Score : <strong>{cert.score_pct}%</strong> · Émise le{" "}
                    {new Date(cert.issued_at).toLocaleDateString("fr-CH")}
                    {" · "}
                    Valide jusqu'au{" "}
                    <span
                      className={
                        isExpired
                          ? "text-red-600 font-semibold"
                          : "text-klary-ink font-semibold"
                      }
                    >
                      {new Date(cert.valid_until).toLocaleDateString("fr-CH")}
                    </span>
                  </div>
                </div>
                <div className="flex flex-col items-end gap-2">
                  {cert.revoked ? (
                    <span className="px-3 py-1 bg-red-100 text-red-700 text-xs font-semibold rounded-full">
                      Révoquée
                    </span>
                  ) : isExpired ? (
                    <span className="px-3 py-1 bg-yellow-100 text-yellow-700 text-xs font-semibold rounded-full">
                      Expirée
                    </span>
                  ) : (
                    <span className="px-3 py-1 bg-green-100 text-green-700 text-xs font-semibold rounded-full">
                      Valide
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
