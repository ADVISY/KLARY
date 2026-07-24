import Link from "next/link";

export function Footer() {
  const year = new Date().getFullYear();
  return (
    <footer className="bg-klary-navy text-white/80 mt-24">
      <div className="max-w-6xl mx-auto px-6 py-12 grid grid-cols-1 md:grid-cols-4 gap-8">
        {/* Brand */}
        <div className="md:col-span-2">
          <div className="text-2xl font-bold text-white tracking-tight mb-2">
            KLARY
          </div>
          <p className="text-xs uppercase tracking-widest text-white/50 mb-4">
            Courtage en assurance
          </p>
          <p className="text-sm text-white/70 max-w-md leading-relaxed">
            Cabinet de courtage indépendant en Suisse. On compare, on négocie,
            on optimise — santé, prévoyance, hypothèque. Neutralité et
            transparence.
          </p>
        </div>

        {/* Nos services */}
        <div>
          <h4 className="text-xs font-bold tracking-widest uppercase text-white mb-4">
            Nos services
          </h4>
          <ul className="space-y-2 text-sm">
            <li>
              <Link
                href="/services"
                className="hover:text-white transition-colors"
              >
                Assurance maladie
              </Link>
            </li>
            <li>
              <Link
                href="/services"
                className="hover:text-white transition-colors"
              >
                Prévoyance
              </Link>
            </li>
            <li>
              <Link
                href="/services"
                className="hover:text-white transition-colors"
              >
                LPP libre passage
              </Link>
            </li>
            <li>
              <Link
                href="/services"
                className="hover:text-white transition-colors"
              >
                Hypothèque
              </Link>
            </li>
          </ul>
        </div>

        {/* Cabinet */}
        <div>
          <h4 className="text-xs font-bold tracking-widest uppercase text-white mb-4">
            Cabinet
          </h4>
          <ul className="space-y-2 text-sm">
            <li>
              <Link
                href="/a-propos"
                className="hover:text-white transition-colors"
              >
                À propos
              </Link>
            </li>
            <li>
              <Link
                href="/postuler"
                className="hover:text-white transition-colors"
              >
                Nous rejoindre
              </Link>
            </li>
            <li>
              <Link
                href="/contact"
                className="hover:text-white transition-colors"
              >
                Contact
              </Link>
            </li>
          </ul>
        </div>
      </div>

      <div className="border-t border-white/10">
        <div className="max-w-6xl mx-auto px-6 py-6 flex flex-col md:flex-row items-center justify-between gap-4 text-xs text-white/60">
          <div>
            © {year} Klary Sàrl · Route de Lausanne 31 · 1052 Le
            Mont-sur-Lausanne
          </div>
          <div className="flex items-center gap-6">
            <Link
              href="/mentions-legales"
              className="hover:text-white transition-colors"
            >
              Mentions légales
            </Link>
            <Link
              href="/politique-confidentialite"
              className="hover:text-white transition-colors"
            >
              Confidentialité
            </Link>
          </div>
        </div>
      </div>
    </footer>
  );
}
