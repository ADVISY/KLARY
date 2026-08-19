import { Link } from "react-router-dom";
import { Mail, Clock, MapPin } from "lucide-react";
import klaryLogoWhite from "@/assets/klary-logo-horizontal.png";

const columns = [
  {
    title: "Assurances",
    links: [
      { label: "Assurance maladie", href: "/assurances/sante" },
      { label: "3ᵉ pilier", href: "/assurances/3e-pilier" },
      { label: "RC & ménage", href: "/assurances/rc-menage" },
      { label: "Automobile", href: "/assurances/auto" },
      { label: "Protection juridique", href: "/assurances/protection-juridique" },
    ],
  },
  {
    title: "Prévoyance & finance",
    links: [
      { label: "Hypothèque", href: "/assurances/hypotheque" },
      { label: "LPP entreprise", href: "/entreprises/lpp" },
      { label: "Personnel d'entreprise", href: "/entreprises/personnel" },
      { label: "Simulateurs", href: "/simulateurs" },
    ],
  },
  {
    title: "Klary",
    links: [
      { label: "À propos", href: "/a-propos" },
      { label: "Carrière", href: "/carriere" },
      { label: "Guides", href: "/guides" },
      { label: "Contact", href: "#contact" },
    ],
  },
];

export const FooterV2 = () => {
  return (
    <footer className="bg-mesh-dark relative pt-20 pb-10 overflow-hidden">
      <div className="mx-auto max-w-7xl px-5 lg:px-8 relative">
        <div className="grid lg:grid-cols-[1.4fr_2fr] gap-12 lg:gap-20 mb-16">
          {/* Brand */}
          <div>
            <img
              src={klaryLogoWhite}
              alt="Klary"
              className="h-10 w-auto mb-6 brightness-0 invert"
            />
            <p className="text-base text-white/70 leading-relaxed max-w-md mb-8">
              Courtier en assurance indépendant. Conseil neutre, comparaison honnête,
              économies réelles — pour les particuliers et les PME en Suisse.
            </p>

            <ul className="space-y-3 text-sm text-white/70">
              <li className="flex items-center gap-3">
                <Mail className="w-4 h-4 shrink-0" style={{ color: "hsl(var(--accent-soft))" }} />
                <a href="mailto:admin@klary.ch" className="hover:text-white transition-colors">
                  admin@klary.ch
                </a>
              </li>
              <li className="flex items-center gap-3">
                <Clock className="w-4 h-4 shrink-0" style={{ color: "hsl(var(--accent-soft))" }} />
                <span>Lun–Ven 08h30–18h00</span>
              </li>
              <li className="flex items-start gap-3">
                <MapPin className="w-4 h-4 shrink-0 mt-0.5" style={{ color: "hsl(var(--accent-soft))" }} />
                <span>
                  Route de Crassier 15
                  <br />
                  1262 Eysins · Suisse
                </span>
              </li>
            </ul>
          </div>

          {/* Link columns */}
          <div className="grid sm:grid-cols-3 gap-8 sm:gap-10">
            {columns.map((col) => (
              <div key={col.title}>
                <p className="text-[11px] uppercase tracking-[0.16em] font-semibold text-white/55 mb-5">
                  {col.title}
                </p>
                <ul className="space-y-3">
                  {col.links.map((l) =>
                    l.href.startsWith("/") ? (
                      <li key={l.label}>
                        <Link to={l.href} className="text-sm text-white/75 hover:text-white transition-colors">
                          {l.label}
                        </Link>
                      </li>
                    ) : (
                      <li key={l.label}>
                        <a href={l.href} className="text-sm text-white/75 hover:text-white transition-colors">
                          {l.label}
                        </a>
                      </li>
                    )
                  )}
                </ul>
              </div>
            ))}
          </div>
        </div>

        {/* Legal bar */}
        <div className="pt-8 border-t border-white/10 flex flex-col md:flex-row gap-4 items-start md:items-center justify-between text-xs text-white/50">
          <p>© {new Date().getFullYear()} Klary Sàrl — CHE-275.800.008 — Tous droits réservés.</p>
          <div className="flex flex-wrap gap-x-6 gap-y-2">
            <Link to="/mentions-legales" className="hover:text-white/80 transition-colors">
              Mentions légales
            </Link>
            <Link to="/politique-confidentialite" className="hover:text-white/80 transition-colors">
              Politique de confidentialité
            </Link>
          </div>
        </div>
      </div>
    </footer>
  );
};
