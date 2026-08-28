import { redirect } from "next/navigation";
import { createSupabaseServerClient } from "@/lib/supabase/server";
import { ProfileForm } from "@/components/app/ProfileForm";

export const metadata = {
  title: "Mon profil",
};

export default async function ProfilePage() {
  const supabase = createSupabaseServerClient();
  const {
    data: { user },
  } = await supabase.auth.getUser();

  if (!user) redirect("/login");

  const { data: profile } = await supabase
    .from("user_roles")
    .select(
      "first_name, last_name, date_of_birth, phone, postal_street, postal_zip, postal_city, postal_country, profile_completed"
    )
    .eq("user_id", user.id)
    .eq("active", true)
    .maybeSingle();

  const isFirstTime = !profile?.profile_completed;

  return (
    <div className="max-w-4xl mx-auto p-6 md:p-10">
      <header className="mb-8">
        <div className="text-xs font-bold tracking-widest uppercase text-klary-orange mb-2">
          Mon profil agent
        </div>
        <h1 className="text-3xl md:text-4xl font-bold text-klary-navy mb-3">
          {isFirstTime ? "Complétez votre profil" : "Mes informations"}
        </h1>
        <p className="text-klary-grey leading-relaxed">
          {isFirstTime ? (
            <>
              Ces informations sont nécessaires pour <strong>émettre votre
              attestation de certification interne Klary</strong>. Vos données
              restent confidentielles.
            </>
          ) : (
            "Ces informations figurent sur vos attestations de certification."
          )}
        </p>
      </header>

      <div className="bg-white rounded-2xl border border-klary-light-grey p-6 md:p-8">
        <ProfileForm
          initial={{
            first_name: profile?.first_name || null,
            last_name: profile?.last_name || null,
            date_of_birth: profile?.date_of_birth || null,
            phone: profile?.phone || null,
            postal_street: profile?.postal_street || null,
            postal_zip: profile?.postal_zip || null,
            postal_city: profile?.postal_city || null,
            postal_country: profile?.postal_country || null,
          }}
          isFirstTime={isFirstTime}
        />
      </div>

      <p className="text-xs text-klary-grey text-center mt-6 italic">
        Email associé : <strong>{user.email}</strong>
      </p>
    </div>
  );
}
