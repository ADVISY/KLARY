import { notFound } from "next/navigation";
import { createServerClient } from "@supabase/ssr";
import { cookies } from "next/headers";
import { SlotSelector } from "./SlotSelector";

export const metadata = {
  title: "Confirmez votre créneau — Klary",
  robots: "noindex, nofollow",
};

export const dynamic = "force-dynamic";

export default async function EntretienPage({
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

  const { data: interview } = await supabase
    .from("interview_slots")
    .select(
      "id, candidate_id, proposed_slots, selection_token, selected_slot_index, selected_at"
    )
    .eq("selection_token", params.token)
    .maybeSingle();

  if (!interview) notFound();

  const { data: candidate } = await supabase
    .from("candidates")
    .select("first_name, last_name, position_applied")
    .eq("id", interview.candidate_id)
    .maybeSingle();

  const slots = (interview.proposed_slots as any[]) || [];
  const alreadySelected = interview.selected_at != null;
  const selectedIdx = interview.selected_slot_index;

  return (
    <div className="min-h-screen bg-klary-cream flex items-center justify-center p-6">
      <div className="max-w-2xl w-full bg-white rounded-3xl shadow-xl overflow-hidden">
        {/* Header */}
        <div className="bg-klary-navy px-8 py-6">
          <div className="text-white text-xl font-bold tracking-tight">
            KLARY
          </div>
          <div className="text-white/60 text-[10px] font-semibold uppercase tracking-widest mt-1">
            Confirmation d'entretien
          </div>
        </div>
        <div className="h-1 bg-klary-orange" />

        <div className="p-8 md:p-10">
          {alreadySelected ? (
            <>
              <div className="w-16 h-16 rounded-full bg-green-100 text-green-600 flex items-center justify-center text-3xl mx-auto mb-4">
                ✓
              </div>
              <h1 className="text-2xl font-bold text-klary-navy text-center mb-2">
                Créneau déjà confirmé
              </h1>
              <p className="text-center text-klary-grey mb-6">
                Bonjour {candidate?.first_name}, votre créneau est bien enregistré.
              </p>
              {selectedIdx != null && slots[selectedIdx] && (
                <div className="p-4 bg-klary-cream border-l-4 border-klary-orange rounded-lg">
                  <div className="text-[10px] uppercase tracking-widest text-klary-orange font-bold mb-1">
                    Rendez-vous confirmé
                  </div>
                  <div className="text-lg font-bold text-klary-navy">
                    {formatSlotClient(slots[selectedIdx].start)}
                  </div>
                </div>
              )}
              <p className="mt-6 text-sm text-klary-grey text-center">
                Une confirmation vous a été envoyée par email. Vous recevrez le
                lien Google Meet 24h avant le rendez-vous.
              </p>
            </>
          ) : (
            <>
              <h1 className="text-2xl md:text-3xl font-bold text-klary-navy mb-2">
                Bonjour {candidate?.first_name} 👋
              </h1>
              <p className="text-klary-grey mb-6 leading-relaxed">
                Choisissez le créneau qui vous convient pour votre entretien
                {candidate?.position_applied && (
                  <> pour le poste <strong>{candidate.position_applied}</strong></>
                )}
                . Durée : 30 minutes, en visio Google Meet.
              </p>

              <SlotSelector token={params.token} slots={slots} />

              <p className="mt-6 text-xs text-klary-grey">
                Aucune de ces dates ne convient ? Écrivez-nous à{" "}
                <a
                  href="mailto:rh@klary.ch"
                  className="text-klary-orange font-semibold"
                >
                  rh@klary.ch
                </a>
                .
              </p>
            </>
          )}
        </div>

        {/* Footer */}
        <div className="bg-klary-cream px-8 py-4 text-center text-xs text-klary-grey border-t border-klary-light-grey">
          Klary Sàrl · Route de Lausanne 31 · 1052 Le Mont-sur-Lausanne
        </div>
      </div>
    </div>
  );
}

// Server-safe formatter (miroir de formatSlot mais serialisable)
function formatSlotClient(iso: string): string {
  return new Date(iso).toLocaleString("fr-CH", {
    weekday: "long",
    day: "numeric",
    month: "long",
    year: "numeric",
    hour: "2-digit",
    minute: "2-digit",
    timeZone: "Europe/Zurich",
  });
}
