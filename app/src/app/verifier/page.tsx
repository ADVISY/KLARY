import { redirect } from "next/navigation";
import { PublicHeader, PublicFooter } from "./PublicChrome";

export const metadata = {
  title: "Vérification certification",
  description:
    "Vérifiez l'authenticité d'une certification Klary — indiquez le numéro figurant sur l'attestation pour confirmer sa validité.",
};

export default function VerifierPage({
  searchParams,
}: {
  searchParams: { n?: string; cert?: string };
}) {
  // Raccourci : ?n=XXX ou ?cert=XXX (via form GET) → redirige vers /verifier/XXX
  const target = searchParams.n || searchParams.cert;
  if (target) {
    redirect(`/verifier/${encodeURIComponent(target)}`);
  }

  return (
    <div className="min-h-screen bg-klary-cream flex flex-col">
      <PublicHeader />

      <main className="flex-1 flex items-center justify-center px-4 py-12">
        <div className="w-full max-w-xl">
          <div className="text-xs font-bold tracking-widest uppercase text-klary-orange mb-2 text-center">
            Vérification d'authenticité
          </div>
          <h1 className="text-3xl md:text-4xl font-bold text-klary-navy mb-3 text-center">
            Vérifier une certification Klary
          </h1>
          <p className="text-klary-grey text-center mb-8">
            Chaque certification interne Klary porte un numéro unique. Indiquez-le
            ci-dessous pour confirmer son authenticité, sa validité et le module
            concerné.
          </p>

          <div className="bg-white rounded-2xl border border-klary-light-grey p-6 md:p-8 shadow-sm">
            <form action="/verifier" method="GET" className="space-y-4">
              <div>
                <label
                  htmlFor="cert"
                  className="block text-xs font-semibold text-klary-ink mb-1.5 uppercase tracking-widest"
                >
                  Numéro de certificat
                </label>
                <input
                  id="cert"
                  name="cert"
                  type="text"
                  required
                  placeholder="Ex : KLARY-2026-0042"
                  className="w-full px-4 py-3 border border-klary-light-grey rounded-lg bg-white text-sm text-klary-navy focus:outline-none focus:border-klary-orange"
                />
                <p className="text-[11px] text-klary-grey mt-1.5">
                  Le numéro figure en haut de l'attestation PDF fournie par
                  l'agent.
                </p>
              </div>
              <button
                type="submit"
                className="w-full py-3 bg-klary-orange text-white font-bold rounded-lg hover:bg-klary-orange/90 transition"
              >
                Vérifier
              </button>
            </form>
          </div>

          <p className="text-center text-xs text-klary-grey mt-6">
            Vous êtes une compagnie partenaire et vous avez un doute ? Contactez{" "}
            <a href="mailto:admin@klary.ch" className="text-klary-orange underline">
              admin@klary.ch
            </a>
            .
          </p>
        </div>
      </main>

      <PublicFooter />
    </div>
  );
}
