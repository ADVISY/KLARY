import Link from "next/link";
import { createSupabaseServerClient } from "@/lib/supabase/server";
import { PageTabs } from "@/components/app/PageTabs";

const FORMATION_TABS = [
  { href: "/formation", label: "Modules" },
  { href: "/certifications", label: "Mes certifications" },
];

export const metadata = {
  title: "Formation",
};

export default async function FormationPage() {
  const supabase = createSupabaseServerClient();

  const { data: modules } = await supabase
    .from("training_modules")
    .select("*")
    .eq("active", true)
    .order("key");

  const { data: { user } } = await supabase.auth.getUser();

  // Récupérer les tentatives de l'utilisateur pour afficher son statut par module
  const { data: attempts } = user
    ? await supabase
        .from("training_attempts")
        .select("module_key, passed, score_pct, finished_at")
        .eq("user_id", user.id)
        .not("finished_at", "is", null)
        .order("finished_at", { ascending: false })
    : { data: [] };

  // Certifications valides
  const { data: certs } = user
    ? await supabase
        .from("training_certifications")
        .select("module_key, valid_until, revoked")
        .eq("user_id", user.id)
        .eq("revoked", false)
    : { data: [] };

  const getBestAttempt = (moduleKey: string) =>
    attempts?.find((a) => a.module_key === moduleKey);
  const getCertification = (moduleKey: string) =>
    certs?.find((c) => c.module_key === moduleKey);

  return (
    <div className="max-w-[1200px] mx-auto p-6 md:p-10">
      <header className="mb-6">
        <div className="text-xs font-bold tracking-widest uppercase text-klary-orange mb-2">
          Formation & certification
        </div>
        <h1 className="text-3xl md:text-4xl font-bold text-klary-navy mb-3">
          Vos modules de formation
        </h1>
        <p className="text-klary-grey">
          Sélectionnez un module pour passer votre certification interne. Vous
          devez obtenir au moins 80 % pour être certifié.
        </p>
      </header>

      <PageTabs tabs={FORMATION_TABS} />

      <div className="grid grid-cols-1 md:grid-cols-2 gap-5">
        {modules?.map((module) => {
          const attempt = getBestAttempt(module.key);
          const cert = getCertification(module.key);
          const isPassed = cert && !cert.revoked;

          return (
            <div
              key={module.key}
              className="bg-white rounded-2xl border border-klary-light-grey p-6 hover:shadow-lg transition-shadow"
            >
              <div className="flex items-start justify-between mb-3">
                <h3 className="text-xl font-bold text-klary-navy">
                  {module.title}
                </h3>
                {isPassed && (
                  <span className="px-2 py-1 bg-green-100 text-green-700 text-xs font-semibold rounded-full">
                    Certifié
                  </span>
                )}
              </div>

              <p className="text-sm text-klary-grey mb-5 leading-relaxed">
                {module.description}
              </p>

              <div className="flex items-center gap-4 text-xs text-klary-grey mb-5">
                <span>⏱ {module.duration_min} min</span>
                <span>·</span>
                <span>🎯 {module.passing_score}% min</span>
              </div>

              {attempt && (
                <div className="text-xs text-klary-grey mb-4">
                  Dernière tentative :{" "}
                  <span
                    className={
                      attempt.passed ? "text-green-700 font-semibold" : "text-red-700 font-semibold"
                    }
                  >
                    {attempt.score_pct}%
                  </span>
                </div>
              )}

              <Link
                href={`/formation/${module.key}`}
                className="block w-full py-2.5 bg-klary-orange text-white font-semibold rounded-lg text-center hover:bg-klary-orange/90 transition"
              >
                {isPassed ? "Repasser (optionnel)" : "Commencer l'évaluation"}
              </Link>
            </div>
          );
        })}
      </div>

      {(!modules || modules.length === 0) && (
        <div className="text-center py-16 text-klary-grey">
          Aucun module disponible pour le moment.
        </div>
      )}
    </div>
  );
}
