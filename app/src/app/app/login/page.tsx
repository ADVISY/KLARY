import { LoginForm } from "@/components/app/LoginForm";

export const metadata = {
  title: "Connexion",
  robots: "noindex, nofollow",
};

export default function LoginPage() {
  return (
    <main className="min-h-screen flex items-center justify-center px-6 py-12 bg-klary-cream">
      <div className="w-full max-w-md">
        {/* Logo Klary */}
        <div className="flex flex-col items-center gap-1 mb-8">
          <span className="text-3xl font-bold tracking-tight text-klary-navy">
            KLARY
          </span>
          <span className="text-[10px] font-semibold tracking-[0.2em] uppercase text-klary-grey">
            Plateforme interne
          </span>
        </div>

        {/* Card login */}
        <div className="bg-white rounded-2xl shadow-lg p-8 border border-klary-light-grey">
          <div className="mb-6">
            <h1 className="text-2xl font-bold text-klary-navy mb-2">
              Connexion agent
            </h1>
            <p className="text-sm text-klary-grey leading-relaxed">
              Accès réservé au personnel Klary. Recevez un lien de connexion
              par email — pas de mot de passe.
            </p>
          </div>

          <LoginForm />
        </div>

        {/* Footer */}
        <div className="mt-8 text-center text-xs text-klary-grey">
          <p>
            Un problème ? Contactez{" "}
            <a
              href="mailto:admin@klary.ch"
              className="text-klary-orange font-semibold hover:underline"
            >
              admin@klary.ch
            </a>
          </p>
          <p className="mt-3">
            <a
              href="https://klary.ch"
              className="hover:text-klary-orange transition-colors"
            >
              ← Retour sur klary.ch
            </a>
          </p>
        </div>
      </div>
    </main>
  );
}
