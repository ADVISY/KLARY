import { notFound } from "next/navigation";
import { createServerClient } from "@supabase/ssr";
import { cookies } from "next/headers";
import { OnboardingForm } from "./OnboardingForm";

export const metadata = {
  title: "Dossier d'onboarding — Klary",
  robots: "noindex, nofollow",
};

export const dynamic = "force-dynamic";

export default async function OnboardingPage({
  params,
}: {
  params: { token: string };
}) {
  const cookieStore = cookies();
  const supabase = createServerClient(
    process.env.NEXT_PUBLIC_SUPABASE_URL!,
    process.env.SUPABASE_SERVICE_ROLE_KEY!,
    {
      cookies: {
        getAll: () => cookieStore.getAll(),
        setAll: () => {},
      },
    }
  );

  const { data: form } = await supabase
    .from("onboarding_forms")
    .select("id, candidate_id, form_token, submitted_at")
    .eq("form_token", params.token)
    .maybeSingle();

  if (!form) notFound();

  const { data: candidate } = await supabase
    .from("candidates")
    .select("first_name, last_name, email, position_applied")
    .eq("id", form.candidate_id)
    .maybeSingle();

  const alreadySubmitted = !!form.submitted_at;

  return (
    <div className="min-h-screen bg-klary-cream py-10 px-4">
      <div className="max-w-3xl mx-auto">
        {/* Header */}
        <div className="bg-white rounded-t-3xl overflow-hidden shadow-lg">
          <div className="bg-klary-navy px-8 py-6">
            <div className="text-white text-xl font-bold tracking-tight">
              KLARY
            </div>
            <div className="text-white/60 text-[10px] font-semibold uppercase tracking-widest mt-1">
              Dossier d'onboarding
            </div>
          </div>
          <div className="h-1 bg-klary-orange" />
        </div>

        <div className="bg-white shadow-lg p-8 md:p-10">
          {alreadySubmitted ? (
            <div className="text-center py-8">
              <div className="w-16 h-16 rounded-full bg-green-100 text-green-600 flex items-center justify-center text-3xl mx-auto mb-4">
                ✓
              </div>
              <h1 className="text-2xl font-bold text-klary-navy mb-2">
                Dossier déjà transmis
              </h1>
              <p className="text-klary-grey">
                Merci {candidate?.first_name}, votre dossier a bien été
                enregistré. Notre comptable prépare votre contrat — vous
                recevrez tout sous 48-72 heures.
              </p>
            </div>
          ) : (
            <>
              <h1 className="text-2xl md:text-3xl font-bold text-klary-navy mb-2">
                Bienvenue {candidate?.first_name} 👋
              </h1>
              <p className="text-klary-grey leading-relaxed mb-6">
                Pour préparer votre contrat de travail et votre premier salaire,
                merci de remplir ce dossier. <strong>Durée estimée : 10 minutes</strong>.
                Prévoyez à portée de main : carte AVS, carte d'identité, RIB
                bancaire, permis de séjour (si applicable), certificat de sortie
                LPP de votre précédent employeur (si applicable).
              </p>

              <OnboardingForm
                token={params.token}
                candidateFirstName={candidate?.first_name || ""}
                candidateLastName={candidate?.last_name || ""}
                positionApplied={candidate?.position_applied || ""}
              />
            </>
          )}
        </div>

        <div className="bg-klary-cream px-8 py-4 text-center text-xs text-klary-grey rounded-b-3xl">
          Klary Sàrl · Route de Lausanne 31 · 1052 Le Mont-sur-Lausanne · <a href="https://klary.ch" className="text-klary-orange">klary.ch</a>
        </div>
      </div>
    </div>
  );
}
