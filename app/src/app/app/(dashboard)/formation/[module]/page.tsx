import { notFound } from "next/navigation";
import Link from "next/link";
import { createSupabaseServerClient } from "@/lib/supabase/server";

export const metadata = {
  title: "Démarrer l'évaluation",
};

export default async function ModuleStartPage({
  params,
  searchParams,
}: {
  params: { module: string };
  searchParams: { error?: string };
}) {
  const supabase = createSupabaseServerClient();

  const { data: module } = await supabase
    .from("training_modules")
    .select("*")
    .eq("key", params.module)
    .eq("active", true)
    .maybeSingle();

  if (!module) notFound();

  // Compter les questions actives
  const { count: questionCount } = await supabase
    .from("training_questions")
    .select("*", { count: "exact", head: true })
    .eq("module_key", params.module)
    .eq("active", true);

  const hasQuestions = (questionCount || 0) > 0;

  // ─── Rôle utilisateur + cooldown check ───
  const {
    data: { user },
  } = await supabase.auth.getUser();

  const { data: roleRow } = user
    ? await supabase
        .from("user_roles")
        .select("role")
        .eq("user_id", user.id)
        .eq("active", true)
        .maybeSingle()
    : { data: null };
  const isPrivileged =
    roleRow?.role === "admin" || roleRow?.role === "manager";

  const cooldownHours = (module as any).retry_cooldown_hours ?? 24;
  let cooldownRemainingHours: number | null = null;
  if (user && !isPrivileged && cooldownHours > 0) {
    const cooldownAgo = new Date(
      Date.now() - cooldownHours * 3600 * 1000
    );
    const { data: recentFail } = await supabase
      .from("training_attempts")
      .select("finished_at")
      .eq("user_id", user.id)
      .eq("module_key", params.module)
      .eq("passed", false)
      .not("finished_at", "is", null)
      .gte("finished_at", cooldownAgo.toISOString())
      .order("finished_at", { ascending: false })
      .limit(1)
      .maybeSingle();
    if (recentFail?.finished_at) {
      const nextAllowedAt = new Date(
        new Date(recentFail.finished_at).getTime() +
          cooldownHours * 3600 * 1000
      );
      cooldownRemainingHours = Math.max(
        1,
        Math.ceil((nextAllowedAt.getTime() - Date.now()) / (3600 * 1000))
      );
    }
  }

  const showError = searchParams?.error === "start_failed";

  return (
    <div className="max-w-2xl mx-auto p-6 md:p-10">
      <div className="mb-6">
        <Link
          href="/formation"
          className="text-sm text-klary-grey hover:text-klary-orange transition"
        >
          ← Retour aux modules
        </Link>
      </div>

      <div className="bg-white rounded-2xl border border-klary-light-grey p-8 shadow-sm">
        <div className="text-xs font-bold tracking-widest uppercase text-klary-orange mb-2">
          Évaluation
        </div>
        <h1 className="text-3xl font-bold text-klary-navy mb-3">
          {module.title}
        </h1>
        <p className="text-klary-grey leading-relaxed mb-8">
          {module.description}
        </p>

        {/* Stats */}
        <div className="grid grid-cols-3 gap-3 mb-8">
          <div className="bg-klary-cream rounded-xl p-4 text-center">
            <div className="text-[10px] font-bold uppercase tracking-widest text-klary-grey mb-1">
              Questions
            </div>
            <div className="text-2xl font-bold text-klary-navy">
              {questionCount || 0}
            </div>
          </div>
          <div className="bg-klary-cream rounded-xl p-4 text-center">
            <div className="text-[10px] font-bold uppercase tracking-widest text-klary-grey mb-1">
              Durée
            </div>
            <div className="text-2xl font-bold text-klary-navy">
              {module.duration_min}
              <span className="text-sm text-klary-grey"> min</span>
            </div>
          </div>
          <div className="bg-klary-cream rounded-xl p-4 text-center">
            <div className="text-[10px] font-bold uppercase tracking-widest text-klary-grey mb-1">
              Score min
            </div>
            <div className="text-2xl font-bold text-klary-navy">
              {module.passing_score}%
            </div>
          </div>
        </div>

        {/* Règles */}
        <div className="bg-klary-orange/5 border-l-4 border-klary-orange rounded-r-xl p-5 mb-8">
          <h3 className="font-bold text-klary-navy mb-3">Règles importantes</h3>
          <ul className="space-y-2 text-sm text-klary-ink">
            <li className="flex gap-2">
              <span className="text-klary-orange font-bold">▸</span>
              <span>
                Ne changez pas d'onglet pendant l'évaluation. Après{" "}
                <strong>2 avertissements</strong>, le test est automatiquement
                échoué.
              </span>
            </li>
            <li className="flex gap-2">
              <span className="text-klary-orange font-bold">▸</span>
              <span>Répondez seul, sans consulter d'aide externe.</span>
            </li>
            <li className="flex gap-2">
              <span className="text-klary-orange font-bold">▸</span>
              <span>Aucun retour arrière une fois validée une question.</span>
            </li>
            <li className="flex gap-2">
              <span className="text-klary-orange font-bold">▸</span>
              <span>
                Résultat immédiat et correction détaillée à la fin. Certification
                automatique en cas de succès.
              </span>
            </li>
          </ul>
        </div>

        {/* Message d'erreur si redirection depuis le quiz */}
        {showError && (
          <div className="p-4 bg-red-50 border border-red-200 rounded-xl text-red-800 text-sm mb-4">
            ⚠ Impossible de démarrer l'évaluation. Vérifiez le message ci-dessous — il peut s'agir du cooldown après un précédent essai, d'une session expirée ou d'un problème réseau.
          </div>
        )}

        {/* Cooldown actif — bloque le démarrage */}
        {hasQuestions && cooldownRemainingHours !== null && (
          <div className="p-5 bg-yellow-50 border-2 border-yellow-300 rounded-xl mb-4">
            <div className="flex items-center gap-2 text-yellow-900 font-bold mb-2">
              ⏳ Nouvelle tentative dans {cooldownRemainingHours}h
            </div>
            <p className="text-sm text-yellow-800 leading-relaxed">
              Vous avez récemment échoué à ce module. Un délai de{" "}
              {cooldownHours}h est nécessaire avant de repasser l'évaluation.
              Consultez la correction détaillée de votre dernière tentative
              (via <Link href="/formation" className="underline font-semibold">Formation</Link>) et travaillez les points marqués en rouge avant de retenter.
            </p>
          </div>
        )}

        {/* Bouton démarrage */}
        {hasQuestions ? (
          <>
            <form action={`/formation/${params.module}/quiz`} method="GET">
              <button
                type="submit"
                disabled={cooldownRemainingHours !== null}
                className="w-full py-4 bg-klary-orange text-white font-semibold rounded-xl hover:bg-klary-orange/90 transition text-lg disabled:bg-klary-grey/40 disabled:cursor-not-allowed"
              >
                {cooldownRemainingHours !== null
                  ? `⏳ Bloqué pendant ${cooldownRemainingHours}h`
                  : "Je suis prêt·e — Démarrer l'évaluation →"}
              </button>
            </form>
            {isPrivileged && (
              <p className="mt-3 text-xs text-klary-grey text-center italic">
                💡 En tant qu'{roleRow?.role}, vous n'êtes pas soumis au cooldown — vous pouvez toujours démarrer une évaluation pour tester.
              </p>
            )}
          </>
        ) : (
          <div className="p-4 bg-yellow-50 border border-yellow-200 rounded-xl text-yellow-800 text-sm text-center">
            📚 Ce module est en cours de préparation. Les questions seront
            disponibles prochainement.
          </div>
        )}
      </div>
    </div>
  );
}
