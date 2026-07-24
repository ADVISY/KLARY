export default function Home() {
  return (
    <main className="min-h-screen flex items-center justify-center px-6">
      <div className="max-w-xl w-full text-center">
        <div className="inline-flex items-center gap-2 px-3 py-1 rounded-full bg-white/70 border border-klary-light-grey text-xs font-semibold tracking-wider uppercase text-klary-grey mb-8">
          <span className="w-2 h-2 rounded-full bg-klary-orange animate-pulse" />
          En construction
        </div>

        <h1 className="text-4xl md:text-5xl font-bold tracking-tight text-klary-navy mb-4">
          Plateforme interne{" "}
          <span className="text-klary-orange">Klary</span>
        </h1>

        <p className="text-base md:text-lg text-klary-grey mb-8 leading-relaxed">
          Formation et certification interne des agents Klary Sàrl.
          <br />
          Accès réservé au personnel autorisé.
        </p>

        <div className="inline-flex items-center gap-2 text-sm text-klary-grey">
          <span>Sept 2026</span>
          <span className="opacity-40">·</span>
          <span>Klary Sàrl</span>
        </div>
      </div>
    </main>
  );
}
