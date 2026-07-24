export default function Home() {
  return (
    <main className="min-h-screen flex items-center justify-center px-6 py-12">
      <div className="max-w-lg w-full text-center">
        {/* Logo Klary texte (simple, en attendant l'image) */}
        <div className="inline-flex flex-col items-center gap-1 mb-12">
          <span className="text-3xl font-bold tracking-tight text-klary-navy">
            KLARY
          </span>
          <span className="text-[10px] font-semibold tracking-[0.2em] uppercase text-klary-grey">
            Courtage en assurance
          </span>
        </div>

        {/* Badge en préparation */}
        <div className="inline-flex items-center gap-2 px-3 py-1.5 rounded-full bg-white/70 border border-klary-light-grey text-xs font-semibold tracking-wider uppercase text-klary-grey mb-10">
          <span className="relative flex w-2 h-2">
            <span className="absolute inline-flex h-full w-full rounded-full bg-klary-orange opacity-75 animate-ping" />
            <span className="relative inline-flex rounded-full h-2 w-2 bg-klary-orange" />
          </span>
          En préparation
        </div>

        {/* Titre principal */}
        <h1 className="text-3xl md:text-4xl font-bold text-klary-navy leading-tight mb-6">
          Plateforme interne <span className="text-klary-orange">Klary.</span>
        </h1>

        {/* Sous-titre */}
        <p className="text-base text-klary-grey leading-relaxed mb-12 max-w-md mx-auto">
          Espace de formation et de certification interne réservé aux agents
          Klary. Disponible prochainement.
        </p>

        {/* Contact */}
        <div className="inline-flex items-center gap-3 px-5 py-3 rounded-xl bg-white border border-klary-light-grey">
          <div className="w-10 h-10 rounded-lg bg-klary-orange/10 flex items-center justify-center text-klary-orange text-lg">
            ✉
          </div>
          <div className="text-left">
            <div className="text-[10px] font-semibold tracking-wider uppercase text-klary-grey">
              Une question ?
            </div>
            <a
              href="mailto:admin@klary.ch"
              className="text-base font-semibold text-klary-navy hover:text-klary-orange transition-colors"
            >
              admin@klary.ch
            </a>
          </div>
        </div>

        {/* Footer */}
        <footer className="mt-16 text-xs text-klary-grey/70">
          <p>Klary Sàrl · Route de Lausanne 31 · 1052 Le Mont-sur-Lausanne</p>
          <p className="mt-1">
            <a
              href="https://klary.ch"
              className="hover:text-klary-orange transition-colors"
            >
              klary.ch
            </a>{" "}
            · © {new Date().getFullYear()}
          </p>
        </footer>
      </div>
    </main>
  );
}
