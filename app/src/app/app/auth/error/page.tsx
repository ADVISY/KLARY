import Image from "next/image";

export const metadata = {
  title: "Erreur d'authentification",
  robots: "noindex, nofollow",
};

export default function AuthErrorPage({
  searchParams,
}: {
  searchParams: { message?: string };
}) {
  const message = searchParams.message || "Une erreur est survenue.";

  return (
    <main className="min-h-screen flex items-center justify-center px-6 py-12 bg-klary-cream">
      <div className="w-full max-w-md text-center">
        <div className="flex flex-col items-center mb-8">
          <Image
            src="/klary-logo.png"
            alt="Klary"
            width={140}
            height={47}
            priority
            className="h-10 w-auto"
          />
        </div>

        <div className="bg-white rounded-2xl shadow-lg p-10 border border-klary-light-grey">
          <div className="w-16 h-16 mx-auto mb-6 rounded-full bg-red-50 flex items-center justify-center text-red-500 text-3xl">
            ✕
          </div>

          <h1 className="text-2xl font-bold text-klary-navy mb-3">
            Connexion impossible.
          </h1>

          <p className="text-klary-grey leading-relaxed mb-6">{message}</p>

          <a
            href="/login"
            className="inline-block px-5 py-2.5 bg-klary-orange text-white font-semibold rounded-lg hover:bg-klary-orange/90 transition-colors"
          >
            Réessayer
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
