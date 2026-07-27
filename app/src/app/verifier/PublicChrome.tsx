import Link from "next/link";

/**
 * Header + Footer publics utilisés par les pages /verifier.
 * Extrait en composant partagé pour respecter les règles Next.js
 * (page.tsx ne doit pas exporter autre chose que le default + metadata).
 */

export function PublicHeader() {
  return (
    <header className="bg-white border-b border-klary-light-grey">
      <div className="max-w-6xl mx-auto px-4 py-4 flex items-center justify-between">
        <Link href="/" className="inline-block">
          {/* eslint-disable-next-line @next/next/no-img-element */}
          <img
            src="/klary-logo-color.png"
            alt="Klary"
            style={{ height: "38px", width: "auto", display: "block" }}
          />
        </Link>
        <nav className="flex items-center gap-4 text-sm">
          <Link href="/services" className="text-klary-grey hover:text-klary-navy">
            Nos services
          </Link>
          <Link href="/a-propos" className="text-klary-grey hover:text-klary-navy">
            À propos
          </Link>
          <Link
            href="/contact"
            className="text-klary-navy font-semibold hover:text-klary-orange"
          >
            Contact
          </Link>
        </nav>
      </div>
    </header>
  );
}

export function PublicFooter() {
  return (
    <footer className="bg-klary-navy text-white/70 py-6 px-4 text-xs text-center">
      © {new Date().getFullYear()} Klary Sàrl · Route de Crassier 7, 1262 Eysins
      · <a href="mailto:admin@klary.ch" className="underline">admin@klary.ch</a>
    </footer>
  );
}
