export const metadata = {
  title: "Vérifiez votre email",
  robots: "noindex, nofollow",
};

export default function CheckEmailPage({
  searchParams,
}: {
  searchParams: { email?: string };
}) {
  const email = searchParams.email || "votre adresse @klary.ch";

  return (
    <main className="min-h-screen flex items-center justify-center px-6 py-12 bg-klary-cream">
      <div className="w-full max-w-md text-center">
        <div className="flex flex-col items-center gap-1 mb-8">
          <span className="text-3xl font-bold tracking-tight text-klary-navy">
            KLARY
          </span>
          <span className="text-[10px] font-semibold tracking-[0.2em] uppercase text-klary-grey">
            Plateforme interne
          </span>
        </div>

        <div className="bg-white rounded-2xl shadow-lg p-10 border border-klary-light-grey">
          {/* Icône email */}
          <div className="w-16 h-16 mx-auto mb-6 rounded-full bg-klary-orange/10 flex items-center justify-center">
            <svg
              className="w-8 h-8 text-klary-orange"
              fill="none"
              stroke="currentColor"
              strokeWidth={2}
              viewBox="0 0 24 24"
            >
              <path
                strokeLinecap="round"
                strokeLinejoin="round"
                d="M3 8l7.89 5.26a2 2 0 002.22 0L21 8M5 19h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v10a2 2 0 002 2z"
              />
            </svg>
          </div>

          <h1 className="text-2xl font-bold text-klary-navy mb-3">
            Vérifiez votre email.
          </h1>

          <p className="text-klary-grey leading-relaxed mb-6">
            Un lien de connexion a été envoyé à{" "}
            <strong className="text-klary-ink">{email}</strong>.
            <br />
            Cliquez dessus pour accéder à la plateforme.
          </p>

          <div className="text-sm text-klary-grey space-y-2 mb-6">
            <p>
              <strong className="text-klary-ink">Le lien expire dans 1 heure.</strong>
            </p>
            <p>
              Vous ne trouvez pas l'email ? Vérifiez vos spams et le dossier
              « Autres ».
            </p>
          </div>

          <a
            href="/login"
            className="inline-block text-sm text-klary-orange font-semibold hover:underline"
          >
            ← Utiliser une autre adresse email
          </a>
        </div>

        <div className="mt-8 text-center text-xs text-klary-grey">
          <p>
            Un problème ?{" "}
            <a
              href="mailto:admin@klary.ch"
              className="text-klary-orange font-semibold hover:underline"
            >
              admin@klary.ch
            </a>
          </p>
        </div>
      </div>
    </main>
  );
}
