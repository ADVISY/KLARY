import { notFound } from "next/navigation";
import { createClient } from "@supabase/supabase-js";
import { BarometerForm } from "./BarometerForm";

export const dynamic = "force-dynamic";

export const metadata = {
  title: "Baromètre équipe Klary",
  robots: { index: false, follow: false },
};

export default async function BarometrePage({
  params,
}: {
  params: { token: string };
}) {
  const supabase = createClient(
    process.env.NEXT_PUBLIC_SUPABASE_URL!,
    process.env.SUPABASE_SERVICE_ROLE_KEY!,
    { auth: { persistSession: false, autoRefreshToken: false } }
  );

  const { data: invite } = await supabase
    .from("barometer_invites")
    .select("id, user_id, period_month, responded_at, expires_at")
    .eq("token", params.token)
    .maybeSingle();

  if (!invite) notFound();

  const alreadyDone = !!invite.responded_at;
  const expired = new Date(invite.expires_at) < new Date();

  const [year, month] = invite.period_month.split("-");
  const monthLabel = new Date(Number(year), Number(month) - 1, 1).toLocaleDateString("fr-CH", {
    month: "long",
    year: "numeric",
  });

  // Prénom pour personnaliser (sans révéler l'identité — c'est nous qui envoyons le token)
  const { data: profile } = await supabase
    .from("user_roles")
    .select("first_name")
    .eq("user_id", invite.user_id)
    .maybeSingle();

  return (
    <div className="min-h-screen bg-klary-cream flex flex-col">
      {/* Header simple */}
      <header className="bg-white border-b border-klary-light-grey">
        <div className="max-w-3xl mx-auto px-4 py-4 flex items-center justify-between">
          {/* eslint-disable-next-line @next/next/no-img-element */}
          <img
            src="/klary-logo-color.png"
            alt="Klary"
            style={{ height: "38px", width: "auto", display: "block" }}
          />
          <div className="text-xs font-bold tracking-widest uppercase text-klary-orange">
            Baromètre équipe
          </div>
        </div>
      </header>

      <main className="flex-1 px-4 py-8">
        <div className="max-w-2xl mx-auto">
          {alreadyDone ? (
            <div className="bg-white rounded-2xl border-2 border-green-300 p-8 text-center shadow-sm">
              <div className="w-16 h-16 mx-auto mb-4 rounded-full bg-green-100 flex items-center justify-center text-3xl">
                ✅
              </div>
              <h1 className="text-2xl font-bold text-klary-navy mb-2">
                Merci {profile?.first_name || ""} !
              </h1>
              <p className="text-klary-grey">
                Ta réponse a bien été enregistrée pour {monthLabel}. Elle est totalement anonyme —
                impossible de faire un lien avec ton identité.
              </p>
              <p className="text-klary-grey text-sm mt-4">
                Tu recevras une nouvelle invitation le 1er du mois prochain.
              </p>
            </div>
          ) : expired ? (
            <div className="bg-white rounded-2xl border-2 border-yellow-300 p-8 text-center shadow-sm">
              <div className="w-16 h-16 mx-auto mb-4 rounded-full bg-yellow-100 flex items-center justify-center text-3xl">
                ⏳
              </div>
              <h1 className="text-2xl font-bold text-klary-navy mb-2">Lien expiré</h1>
              <p className="text-klary-grey">
                Ce lien de baromètre {monthLabel} a expiré. Contacte{" "}
                <a href="mailto:admin@klary.ch" className="text-klary-orange underline">
                  admin@klary.ch
                </a>{" "}
                si tu veux quand même partager ton feedback.
              </p>
            </div>
          ) : (
            <>
              <div className="mb-6 text-center">
                <div className="text-xs font-bold tracking-widest uppercase text-klary-orange mb-1">
                  Anonyme · 2 minutes · 7 questions
                </div>
                <h1 className="text-2xl md:text-3xl font-bold text-klary-navy mb-2">
                  Baromètre équipe — {monthLabel}
                </h1>
                <p className="text-klary-grey text-sm">
                  Salut {profile?.first_name || "toi"} ! Tes réponses ne sont associées à AUCUN
                  identifiant, personne ne peut savoir ce que tu as répondu. Réponds honnêtement.
                </p>
              </div>

              <BarometerForm token={params.token} />
            </>
          )}
        </div>
      </main>

      <footer className="bg-klary-navy text-white/70 py-4 px-4 text-xs text-center">
        © {new Date().getFullYear()} Klary Sàrl — Baromètre 100% anonyme
      </footer>
    </div>
  );
}
