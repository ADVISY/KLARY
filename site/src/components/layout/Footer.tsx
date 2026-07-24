import advisyLogo from "@/assets/klary-logo-horizontal.png";
import { Link } from "react-router-dom";
import { Mail, Phone, Clock } from "lucide-react";

export const Footer = () => {
  const scrollToSection = (href: string) => {
    const el = document.querySelector(href);
    if (el) el.scrollIntoView({ behavior: "smooth" });
  };

  const quickLinks = [
    { label: "Accueil", href: "/" },
    { label: "Assurances", href: "/assurances/sante" },
    { label: "À propos", href: "/a-propos" },
    { label: "Carrière", href: "/carriere" },
    { label: "Contact", href: "#contact", scroll: true },
  ];

  return (
    <footer className="relative py-20 lg:py-24 border-t border-white/[0.06] overflow-hidden">
      <div className="absolute bottom-0 left-1/2 -translate-x-1/2 w-[600px] h-[200px] bg-primary/[0.06] rounded-full blur-[160px] pointer-events-none" />

      <div className="container relative z-10 mx-auto px-4 lg:px-8">
        <div className="grid md:grid-cols-2 lg:grid-cols-4 gap-12 lg:gap-16 mb-16">
          {/* Logo & desc */}
          <div>
            <img src={advisyLogo} alt="Klary" className="h-8 w-auto mb-5" />
            <p className="text-body-sm text-muted-foreground leading-relaxed">
              Klary, votre partenaire de confiance en assurance et prévoyance en Suisse. Des conseils clairs et un accompagnement humain.
            </p>
          </div>

          {/* Quick links */}
          <div>
            <h3 className="text-micro text-foreground mb-5 uppercase">Liens rapides</h3>
            <div className="flex flex-col gap-3">
              {quickLinks.map((link) =>
                link.scroll ? (
                  <button key={link.href} onClick={() => scrollToSection(link.href)} className="text-body-sm text-muted-foreground hover:text-foreground transition-colors text-left">
                    {link.label}
                  </button>
                ) : (
                  <Link key={link.href} to={link.href} className="text-body-sm text-muted-foreground hover:text-foreground transition-colors">
                    {link.label}
                  </Link>
                )
              )}
            </div>
          </div>

          {/* Contact */}
          <div>
            <h3 className="text-micro text-foreground mb-5 uppercase">Contact</h3>
            <div className="flex flex-col gap-4">
              <div className="flex items-center gap-3">
                <Phone className="w-4 h-4 text-primary-light" />
                <a href="tel:+41225000000" className="text-body-sm text-muted-foreground hover:text-foreground transition-colors font-light">+41 22 500 00 00</a>
              </div>
              <div className="flex items-center gap-3">
                <Mail className="w-4 h-4 text-primary-light" />
                <a href="mailto:admin@klary.ch" className="text-body-sm text-muted-foreground hover:text-foreground transition-colors font-light">admin@klary.ch</a>
              </div>
              <div className="flex items-center gap-3">
                <Clock className="w-4 h-4 text-primary-light" />
                <span className="text-body-sm text-muted-foreground font-light">Lun–Ven : 08h30–18h00</span>
              </div>
            </div>
          </div>

          {/* Legal */}
          <div>
            <h3 className="text-micro text-foreground mb-5 uppercase">Informations légales</h3>
            <div className="flex flex-col gap-3">
              <Link to="/politique-confidentialite" className="text-body-sm text-muted-foreground hover:text-foreground transition-colors">Politique de confidentialité</Link>
              <Link to="/mentions-legales" className="text-body-sm text-muted-foreground hover:text-foreground transition-colors">Mentions légales</Link>
            </div>
          </div>
        </div>

        {/* Bottom bar */}
        <div className="pt-8 border-t border-white/[0.06]">
          <div className="flex flex-col md:flex-row justify-between items-center gap-4">
            <p className="text-micro text-muted-foreground">© 2025 Klary Suisse — Tous droits réservés.</p>
            <p className="text-micro text-muted-foreground">Cabinet de conseil indépendant, enregistré en Suisse.</p>
          </div>
        </div>
      </div>

      {/* Giant Klary logo watermark — Affirm-style */}
      <div className="relative mt-12 lg:mt-16 px-4 overflow-hidden pointer-events-none select-none" aria-hidden="true">
        
        <img
          src={advisyLogo}
          alt=""
          className="relative mx-auto w-full max-w-[1400px] opacity-10"
        />
      </div>
    </footer>
  );
};
