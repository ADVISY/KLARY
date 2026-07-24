import Link from "next/link";

const NAV_ITEMS = [
  { href: "/services", label: "Nos services" },
  { href: "/a-propos", label: "À propos" },
  { href: "/postuler", label: "Rejoindre" },
  { href: "/contact", label: "Contact" },
];

export function Header() {
  return (
    <header className="sticky top-0 z-50 bg-white/90 backdrop-blur border-b border-klary-light-grey/50">
      <div className="max-w-6xl mx-auto px-6 py-4 flex items-center justify-between">
        <Link href="/" className="flex items-center gap-2 group">
          <span className="text-xl font-bold tracking-tight text-klary-navy group-hover:text-klary-orange transition-colors">
            KLARY
          </span>
        </Link>

        <nav className="hidden md:flex items-center gap-8">
          {NAV_ITEMS.map((item) => (
            <Link
              key={item.href}
              href={item.href}
              className="text-sm font-medium text-klary-ink hover:text-klary-orange transition-colors"
            >
              {item.label}
            </Link>
          ))}
        </nav>

        <Link
          href="/contact"
          className="inline-flex items-center gap-2 px-4 py-2 bg-klary-orange text-white text-sm font-semibold rounded-lg hover:bg-klary-orange/90 transition-colors"
        >
          Nous contacter
        </Link>
      </div>
    </header>
  );
}
