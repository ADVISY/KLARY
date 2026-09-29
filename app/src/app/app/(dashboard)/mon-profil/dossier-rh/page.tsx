import Link from "next/link";
import { redirect } from "next/navigation";
import { createSupabaseServerClient } from "@/lib/supabase/server";
import { PageTabs } from "@/components/app/PageTabs";
import { OnboardingForm } from "@/app/app/onboarding/[token]/OnboardingForm";

export const metadata = { title: "Mon dossier RH" };
export const dynamic = "force-dynamic";

export default async function DossierRhPage() {
  const supabase = createSupabaseServerClient();
  const {
    data: { user },
  } = await supabase.auth.getUser();
  if (!user) redirect("/login");

  const { data: profile } = await supabase
    .from("user_roles")
    .select("first_name, last_name, role")
    .eq("user_id", user.id)
    .eq("active", true)
    .maybeSingle();

  const { data: form } = await supabase
    .from("onboarding_forms")
    .select("id, form_token, submitted_at, created_at")
    .eq("user_id", user.id)
    .maybeSingle();

  const isPending = !!form && !form.submitted_at;
  const isDone = !!form?.submitted_at;

  const tabs = [
    { href: "/mon-profil", label: "Identité" },
    {
      href: "/mon-profil/dossier-rh",
      label: "Dossier RH",
      ...(isPending ? { badge: "À compléter" } : {}),
    },
  ];

  return (
    <div className="max-w-4xl mx-auto p-6 md:p-10">
      <header className="mb-6">
        <div className="text-xs font-bold tracking-widest uppercase text-klary-orange mb-2">
          Mon profil agent
        </div>
        <h1 className="text-3xl md:text-4xl font-bold text-klary-navy mb-3">
          Mon dossier RH
        </h1>
        <p className="text-klary-grey leading-relaxed">
          Les informations nécessaires à l&apos;établissement de votre contrat,
          de vos fiches de salaire et de vos affiliations sociales. Elles sont
          transmises uniquement à la direction et à la fiduciaire.
        </p>
      </header>

      <PageTabs tabs={tabs} />

      {/* ─── Aucun dossier ouvert ─── */}
      {!form && (
        <div className="bg-klary-cream/40 border border-dashed border-klary-light-grey rounded-2xl p-10 text-center">
          <div className="text-4xl mb-3">📋</div>
          <h2 className="text-lg font-bold text-klary-navy mb-2">
            Aucun dossier à compléter pour le moment
          </h2>
          <p className="text-sm text-klary-grey max-w-md mx-auto">
            Votre dossier RH n&apos;a pas encore été ouvert. Il le sera par la
            direction au moment de votre engagement. Vous recevrez une
            notification dès qu&apos;il sera disponible ici.
          </p>
        </div>
      )}

      {/* ─── Dossier déjà transmis ─── */}
      {isDone && (
        <div className="bg-emerald-50 border border-emerald-200 rounded-2xl p-8">
          <div className="flex items-start gap-4">
            <div className="text-3xl leading-none">✓</div>
            <div>
              <h2 className="text-lg font-bold text-klary-navy mb-1">
                Dossier transmis
              </h2>
              <p className="text-sm text-klary-grey mb-3">
                Vous avez transmis votre dossier le{" "}
                <strong className="text-klary-navy">
                  {new Date(form!.submitted_at as string).toLocaleDateString(
                    "fr-CH",
                    { day: "2-digit", month: "long", year: "numeric" }
                  )}
                </strong>
                . Il a été transmis à la direction et à la fiduciaire.
              </p>
              <p className="text-sm text-klary-grey">
                Un changement de situation à signaler (adresse, état civil,
                coordonnées bancaires, naissance) ? Contactez directement votre
                responsable, les informations transmises ne sont plus
                modifiables ici.
              </p>
              <Link
                href="/mes-documents"
                className="inline-block mt-4 text-sm font-semibold text-klary-orange hover:underline"
              >
                Voir mes documents →
              </Link>
            </div>
          </div>
        </div>
      )}

      {/* ─── Dossier à remplir ─── */}
      {isPending && (
        <>
          <div className="bg-amber-50 border-l-4 border-amber-400 rounded-r-xl p-5 mb-6">
            <h2 className="font-bold text-klary-navy mb-1">
              Votre dossier est à compléter
            </h2>
            <p className="text-sm text-klary-grey">
              Prévoyez une quinzaine de minutes et munissez-vous de votre carte
              AVS, de vos coordonnées bancaires et de votre titre de séjour le
              cas échéant. Vous pouvez enregistrer et reprendre plus tard.
            </p>
          </div>

          <OnboardingForm
            token={form!.form_token}
            candidateFirstName={profile?.first_name || ""}
            candidateLastName={profile?.last_name || ""}
            positionApplied={profile?.role === "agent" ? "Conseiller" : ""}
          />
        </>
      )}
    </div>
  );
}
