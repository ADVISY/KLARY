import { useState, useEffect } from "react";
import { createPortal } from "react-dom";
import { Menu, X, ChevronDown, Phone, Globe, Shield, PiggyBank, Landmark, Sparkles, Calculator, ArrowRight, Building2 } from "lucide-react";
import { Button } from "@/components/ui/button";
import { Link } from "react-router-dom";
import advisyLogo from "@/assets/klary-logo-horizontal.png";
import menuAppIllustration from "@/assets/menu-app-illustration.png";
import lytaLogo from "@/assets/lyta-logo.svg";
import optimisLogo from "@/assets/optimis-logo.svg";
import iconSante from "@/assets/icons/icon-sante.png";
import iconRc from "@/assets/icons/icon-rc.png";
import iconAuto from "@/assets/icons/icon-auto.png";
import iconJuridique from "@/assets/icons/icon-juridique.png";
import iconPersonnel from "@/assets/icons/icon-personnel.png";
import icon3pilier from "@/assets/icons/icon-3pilier.png";
import iconLpp from "@/assets/icons/icon-lpp.png";
import iconHypotheque from "@/assets/icons/icon-hypotheque.png";
import iconMission from "@/assets/icons/icon-mission.png";
import iconCarriere from "@/assets/icons/icon-carriere.png";

const PHONE_NUMBER = "+41225000000";
const PHONE_DISPLAY = "+41 22 500 00 00";

type SubItem = { label: string; href: string; icon?: string; description?: string };
type ServicesColumn = { label: string; tagline: string; icon: any; subItems: SubItem[] };

const servicesColumns: ServicesColumn[] = [
  {
    label: "Assurance",
    tagline: "L'art de protéger l'essentiel",
    icon: Shield,
    subItems: [
      { label: "Santé", href: "/assurances/sante", icon: iconSante },
      { label: "Responsabilité & ménage", href: "/assurances/rc-menage", icon: iconRc },
      { label: "Automobile", href: "/assurances/auto", icon: iconAuto },
      { label: "Protection juridique", href: "/assurances/protection-juridique", icon: iconJuridique },
      { label: "Personnel d'entreprise", href: "/entreprises/personnel", icon: iconPersonnel },
    ],
  },
  {
    label: "Prévoyance",
    tagline: "Construire l'avenir avec sérénité",
    icon: PiggyBank,
    subItems: [
      { label: "3ᵉ pilier", href: "/assurances/3e-pilier", icon: icon3pilier },
      { label: "LPP — 2ᵉ pilier", href: "/entreprises/lpp", icon: iconLpp },
    ],
  },
  {
    label: "Finance",
    tagline: "Donnez vie à vos projets",
    icon: Landmark,
    subItems: [
      { label: "Hypothèque & financement", href: "/assurances/hypotheque", icon: iconHypotheque },
    ],
  },
];

const aboutColumns: ServicesColumn[] = [
  {
    label: "À propos",
    tagline: "L'humain au cœur de notre métier",
    icon: Building2,
    subItems: [
      {
        label: "Notre mission",
        href: "/a-propos",
        icon: iconMission,
        description: "Notre vision, nos valeurs et notre approche.",
      },
      {
        label: "Carrière",
        href: "/carriere",
        icon: iconCarriere,
        description: "Rejoignez une équipe ambitieuse en pleine croissance.",
      },
    ],
  },
];

const navLinks = [
  { label: "Accueil", href: "/", type: "link" },
  { label: "Services", type: "services" },
  { label: "Simulateurs", href: "/simulateurs", type: "link" },
  { label: "À propos", type: "about" },
  { label: "Contact", href: "#contact", type: "scroll" },
];

export const Navigation = () => {
  const [isOpen, setIsOpen] = useState(false);
  const [activeDropdown, setActiveDropdown] = useState<string | null>(null);
  const [closeTimeout, setCloseTimeout] = useState<ReturnType<typeof setTimeout> | null>(null);
  const [scrolled, setScrolled] = useState(false);

  useEffect(() => {
    const handleScroll = () => setScrolled(window.scrollY > 50);
    window.addEventListener("scroll", handleScroll);
    return () => window.removeEventListener("scroll", handleScroll);
  }, []);

  const scrollToSection = (href: string) => {
    const el = document.querySelector(href);
    if (el) { el.scrollIntoView({ behavior: "smooth" }); setIsOpen(false); }
  };

  const handleMouseEnter = (label: string) => {
    if (closeTimeout) { clearTimeout(closeTimeout); setCloseTimeout(null); }
    setActiveDropdown(label);
  };

  const handleMouseLeave = () => {
    const t = setTimeout(() => setActiveDropdown(null), 500);
    setCloseTimeout(t);
  };

  const linkClass = "text-body-sm font-medium text-white hover:text-primary-light transition-colors duration-300 relative";

  return (
    <nav
      className={`nav-pill fixed left-1/2 -translate-x-1/2 z-[100] rounded-full transition-all duration-500 ${
        scrolled
          ? "top-3 w-[94%] max-w-6xl !bg-[hsl(240_18%_9%/0.85)] backdrop-blur-xl shadow-medium"
          : "top-5 w-[96%] max-w-7xl !bg-[hsl(240_18%_9%/0.6)] backdrop-blur-xl shadow-soft"
      }`}
    >
      <div className="px-6 lg:px-8">
        <div className={`flex items-center justify-between transition-all duration-500 ${scrolled ? "h-12" : "h-14"}`}>
          {/* Logo */}
          <Link to="/" className="flex items-center hover:opacity-80 transition-opacity">
            <img
              src={advisyLogo}
              alt="Klary"
              className={`w-auto object-contain transition-all duration-500 ${scrolled ? "h-7 md:h-8" : "h-8 md:h-9"}`}
            />
          </Link>

          {/* Desktop Nav */}
          <div className="hidden lg:flex items-center gap-7 flex-1 justify-start ml-8">
            {navLinks.map((link) => (
              <div
                key={link.label}
                className="relative"
                onMouseEnter={() => (link.type === "services" || link.type === "about") && handleMouseEnter(link.label)}
                onMouseLeave={handleMouseLeave}
              >
                {link.type === "link" && link.href && (
                  <Link to={link.href} className={linkClass}>
                    {link.label}
                  </Link>
                )}
                {link.type === "external" && link.href && (
                  <a href={link.href} target="_blank" rel="noopener noreferrer" className={linkClass}>
                    {link.label}
                  </a>
                )}
                {link.type === "scroll" && link.href && (
                  <button onClick={() => scrollToSection(link.href!)} className={linkClass}>
                    {link.label}
                  </button>
                )}
                {link.type === "services" && (
                  <>
                    <button
                      className={`${linkClass} flex items-center gap-1`}
                      onClick={() => {
                        if (closeTimeout) { clearTimeout(closeTimeout); setCloseTimeout(null); }
                        setActiveDropdown(activeDropdown === link.label ? null : link.label);
                      }}
                    >
                      {link.label}
                      <ChevronDown className={`w-3.5 h-3.5 transition-transform duration-300 ${activeDropdown === link.label ? "rotate-180" : ""}`} />
                    </button>

                    {activeDropdown === link.label && (
                      <div
                        className="fixed left-1/2 -translate-x-1/2 top-[68px] pt-3 z-[120]"
                        onMouseEnter={() => handleMouseEnter(link.label)}
                        onMouseLeave={handleMouseLeave}
                      >
                        <div className="w-[1080px] max-w-[95vw] animate-fade-in pole-card !min-h-0 !rounded-[24px] !p-[1.5px]">
                          <div aria-hidden className="pole-card-border !rounded-[24px]" />
                          <div className="pole-card-inner !rounded-[22px] !p-0 !shadow-none overflow-hidden bg-[hsl(228_15%_8%/0.55)] backdrop-blur-2xl">
                          <div className="grid grid-cols-12">
                            <div className="col-span-8 grid grid-cols-3 p-6">
                              {servicesColumns.map((col) => {
                                const ColIcon = col.icon;
                                return (
                                  <div key={col.label} className="px-3 first:pl-0 last:pr-0 border-r border-white/[0.06] last:border-r-0">
                                    <div className="flex items-center gap-2.5 mb-4 px-2">
                                      <div className="w-8 h-8 rounded-lg bg-primary/15 flex items-center justify-center">
                                        <ColIcon className="w-4 h-4 text-primary-light" />
                                      </div>
                                      <p className="text-lg font-bold text-white leading-tight tracking-tight">{col.label}</p>
                                    </div>
                                    <div className="space-y-1">
                                      {col.subItems.map((item) => (
                                        <Link
                                          key={item.href}
                                          to={item.href}
                                          onClick={() => setActiveDropdown(null)}
                                          className="group/item flex items-center gap-3.5 px-2 py-2.5 rounded-lg hover:bg-white/[0.05] transition-colors duration-200"
                                        >
                                          {item.icon && (
                                            <img
                                              src={item.icon}
                                              alt=""
                                              loading="lazy"
                                              width={64}
                                              height={64}
                                              className="w-12 h-12 object-contain shrink-0 transition-transform duration-300 group-hover/item:scale-110 group-hover/item:rotate-3 brightness-125 saturate-150 drop-shadow-[0_0_12px_hsl(220_100%_75%/0.45)]"
                                            />
                                          )}
                                          <p className="text-[15px] font-medium text-white leading-tight tracking-tight">{item.label}</p>
                                        </Link>
                                      ))}
                                    </div>
                                  </div>
                                );
                              })}
                            </div>

                            <div className="col-span-4 bg-white/[0.02] border-l border-white/[0.06] p-5 flex flex-col gap-3">
                              <p className="text-micro text-primary-light uppercase tracking-[0.18em] mb-1">L'expérience Klary</p>
                              <a
                                href="https://klary.lyta.ch"
                                target="_blank"
                                rel="noopener noreferrer"
                                onClick={() => setActiveDropdown(null)}
                                className="group/card relative overflow-hidden rounded-2xl p-4 bg-gradient-to-br from-primary/30 via-primary/15 to-transparent border border-primary/20 hover:border-primary/40 transition-all duration-300 min-h-[140px]"
                              >
                                <img
                                  src={menuAppIllustration}
                                  alt=""
                                  loading="lazy"
                                  width={512}
                                  height={512}
                                  className="absolute -right-4 -bottom-4 w-32 h-32 object-contain opacity-90 group-hover/card:scale-105 group-hover/card:-rotate-3 transition-transform duration-500 pointer-events-none"
                                />
                                <div className="relative max-w-[60%]">
                                  <p className="text-body-sm font-semibold text-white mb-1.5 flex items-center gap-1.5 tracking-tight">
                                    <Sparkles className="w-3.5 h-3.5 text-primary-light" />
                                    Espace client
                                  </p>
                                  <p className="text-[11px] text-silver-dark leading-relaxed mb-2.5 font-light">Pilotez vos contrats, sinistres et documents depuis un espace privé.</p>
                                  <span className="inline-flex items-center gap-1 text-[11px] text-primary-light font-medium tracking-wide">
                                    Accéder à mon espace <ArrowRight className="w-3 h-3 transition-transform group-hover/card:translate-x-0.5" />
                                  </span>
                                </div>
                              </a>
                              <div className="group/card relative overflow-hidden rounded-2xl p-4 bg-gradient-to-br from-white/[0.18] via-white/[0.10] to-white/[0.04] border border-white/[0.25] backdrop-blur-2xl shadow-[inset_0_1px_0_0_hsl(0_0%_100%/0.25),0_8px_32px_-8px_hsl(0_0%_0%/0.4)] hover:border-white/[0.35] transition-all duration-300 min-h-[140px]">
                                <div className="absolute inset-0 bg-gradient-to-br from-white/[0.08] to-transparent opacity-60 pointer-events-none" />
                                <div className="absolute -top-12 -right-12 w-32 h-32 bg-white/[0.08] rounded-full blur-2xl pointer-events-none" />
                                <div className="relative">
                                  <p className="text-body-sm font-semibold text-white mb-1.5 flex items-center gap-1.5 tracking-tight">
                                    <Calculator className="w-3.5 h-3.5 text-white" />
                                    Nos outils
                                  </p>
                                  <p className="text-[11px] text-white/70 leading-relaxed mb-3 font-light">Propulsé par nos partenaires technologiques.</p>
                                  <div className="flex items-center gap-4 mb-1">
                                    <a
                                      href="https://lyta.ch"
                                      target="_blank"
                                      rel="noopener noreferrer"
                                      onClick={() => setActiveDropdown(null)}
                                      className="flex-1 flex items-center justify-center px-2 transition-transform duration-300 hover:scale-110"
                                    >
                                      <img src={lytaLogo} alt="LYTA" loading="lazy" className="max-h-12 w-auto object-contain" />
                                    </a>
                                    <a
                                      href="https://le-comparateur-optimis.ch"
                                      target="_blank"
                                      rel="noopener noreferrer"
                                      onClick={() => setActiveDropdown(null)}
                                      className="flex-1 flex items-center justify-center px-2 transition-transform duration-300 hover:scale-110"
                                    >
                                      <img src={optimisLogo} alt="OPTIMIS" loading="lazy" className="max-h-12 w-auto object-contain" />
                                    </a>
                                  </div>
                                </div>
                              </div>
                            </div>
                          </div>
                          </div>
                        </div>
                      </div>
                    )}
                  </>
                )}
                {link.type === "about" && (
                  <>
                    <button
                      className={`${linkClass} flex items-center gap-1`}
                      onClick={() => {
                        if (closeTimeout) { clearTimeout(closeTimeout); setCloseTimeout(null); }
                        setActiveDropdown(activeDropdown === link.label ? null : link.label);
                      }}
                    >
                      {link.label}
                      <ChevronDown className={`w-3.5 h-3.5 transition-transform duration-300 ${activeDropdown === link.label ? "rotate-180" : ""}`} />
                    </button>

                    {activeDropdown === link.label && (
                      <div
                        className="fixed left-1/2 -translate-x-1/2 top-[68px] pt-3 z-[120]"
                        onMouseEnter={() => handleMouseEnter(link.label)}
                        onMouseLeave={handleMouseLeave}
                      >
                        <div className="w-[520px] max-w-[95vw] animate-fade-in pole-card !min-h-0 !rounded-[24px] !p-[1.5px]">
                          <div aria-hidden className="pole-card-border !rounded-[24px]" />
                          <div className="pole-card-inner !rounded-[22px] !p-0 !shadow-none overflow-hidden bg-[hsl(228_15%_8%/0.55)] backdrop-blur-2xl">
                            <div className="p-6">
                              {aboutColumns.map((col) => {
                                const ColIcon = col.icon;
                                return (
                                  <div key={col.label}>
                                    <div className="flex items-center gap-2.5 mb-4 px-2">
                                      <div className="w-8 h-8 rounded-lg bg-primary/15 flex items-center justify-center">
                                        <ColIcon className="w-4 h-4 text-primary-light" />
                                      </div>
                                      <p className="text-lg font-bold text-white leading-tight tracking-tight">{col.label}</p>
                                    </div>
                                    <div className="space-y-1">
                                      {col.subItems.map((item) => (
                                        <Link
                                          key={item.href}
                                          to={item.href}
                                          onClick={() => setActiveDropdown(null)}
                                          className="group/item flex items-center gap-3.5 px-2 py-2.5 rounded-lg hover:bg-white/[0.05] transition-colors duration-200"
                                        >
                                          {item.icon && (
                                            <img
                                              src={item.icon}
                                              alt=""
                                              loading="lazy"
                                              width={64}
                                              height={64}
                                              className="w-12 h-12 object-contain shrink-0 transition-transform duration-300 group-hover/item:scale-110 group-hover/item:rotate-3 brightness-125 saturate-150 drop-shadow-[0_0_12px_hsl(220_100%_75%/0.45)]"
                                            />
                                          )}
                                          <div className="min-w-0">
                                            <p className="text-[15px] font-medium text-white leading-tight tracking-tight">{item.label}</p>
                                            {item.description && (
                                              <p className="text-[12px] text-silver-dark mt-0.5 leading-snug font-light">{item.description}</p>
                                            )}
                                          </div>
                                        </Link>
                                      ))}
                                    </div>
                                  </div>
                                );
                              })}
                            </div>
                          </div>
                        </div>
                      </div>
                    )}
                  </>
                )}
              </div>
            ))}
          </div>

          {/* Cluster droit façon Affirm */}
          <div className="hidden lg:flex items-center gap-3">
            <button
              aria-label="Langue"
              className="flex items-center gap-1 px-2 h-9 rounded-full text-silver-dark hover:text-white hover:bg-white/[0.06] transition-colors text-body-sm"
            >
              <Globe className="w-[18px] h-[18px]" />
              <ChevronDown className="w-3.5 h-3.5" />
            </button>
            <a
              href={`tel:${PHONE_NUMBER}`}
              className="nav-pill flex items-center gap-2 px-5 h-9 text-body-sm font-medium"
            >
              <Phone className="w-4 h-4" />
              <span>Appelez-nous</span>
            </a>
            <a
              href="https://klary.lyta.ch"
              target="_blank"
              rel="noopener noreferrer"
              className="nav-pill flex items-center px-5 h-9 text-body-sm font-medium"
            >
              Connexion
            </a>
          </div>

          {/* Mobile Toggle */}
          <Button variant="ghost" size="icon" className="lg:hidden text-foreground" onClick={() => setIsOpen(!isOpen)}>
            {isOpen ? <X className="h-5 w-5" /> : <Menu className="h-5 w-5" />}
          </Button>
        </div>
      </div>

      {/* Mobile / Tablet Mega Menu — rendered in portal to escape nav stacking context */}
      {isOpen && typeof document !== "undefined" && createPortal(
        <div className="lg:hidden fixed inset-0 z-[200] bg-[hsl(228_15%_6%/0.98)] backdrop-blur-2xl overflow-y-auto animate-fade-in">
          {/* Header bar */}
          <div className="sticky top-0 z-10 flex items-center justify-between px-5 h-16 bg-[hsl(228_15%_6%/0.95)] backdrop-blur-xl border-b border-white/[0.06]">
            <Link to="/" onClick={() => setIsOpen(false)} className="flex items-center">
              <img src={advisyLogo} alt="Klary" className="h-8 w-auto" />
            </Link>
            <Button variant="ghost" size="icon" className="text-white" onClick={() => setIsOpen(false)}>
              <X className="h-5 w-5" />
            </Button>
          </div>

          <div className="px-5 py-6 pb-24 space-y-8 max-w-3xl mx-auto">
            {/* Primary nav links */}
            <div className="flex flex-col gap-1">
              {navLinks
                .filter((l) => l.type !== "services" && l.type !== "dropdown")
                .map((link) => (
                  <div key={link.label}>
                    {link.type === "link" && link.href && (
                      <Link
                        to={link.href}
                        onClick={() => setIsOpen(false)}
                        className="block text-base font-semibold text-white py-2.5 border-b border-white/[0.06] hover:text-primary-light transition-colors"
                      >
                        {link.label}
                      </Link>
                    )}
                    {link.type === "scroll" && link.href && (
                      <button
                        onClick={() => { scrollToSection(link.href!); setIsOpen(false); }}
                        className="block w-full text-left text-base font-semibold text-white py-2.5 border-b border-white/[0.06] hover:text-primary-light transition-colors"
                      >
                        {link.label}
                      </button>
                    )}
                  </div>
                ))}
              {/* À propos sub-links flat */}
              <Link to="/a-propos" onClick={() => setIsOpen(false)} className="block text-base font-semibold text-white py-2.5 border-b border-white/[0.06] hover:text-primary-light transition-colors">À propos</Link>
              <Link to="/carriere" onClick={() => setIsOpen(false)} className="block text-base font-semibold text-white py-2.5 border-b border-white/[0.06] hover:text-primary-light transition-colors">Carrière</Link>
            </div>

            {/* Services — 3 columns stacked, desktop visual */}
            <div>
              <p className="text-micro text-primary-light uppercase tracking-[0.18em] mb-4">Nos services</p>
              <div className="space-y-5">
                {servicesColumns.map((col) => {
                  const ColIcon = col.icon;
                  return (
                    <div key={col.label} className="rounded-2xl bg-white/[0.03] border border-white/[0.06] p-5">
                      <div className="flex items-center gap-3 mb-4">
                        <div className="w-10 h-10 rounded-xl bg-primary/15 flex items-center justify-center">
                          <ColIcon className="w-5 h-5 text-primary-light" />
                        </div>
                        <div>
                          <p className="text-lg font-bold text-white leading-tight">{col.label}</p>
                          <p className="text-xs text-silver-dark">{col.tagline}</p>
                        </div>
                      </div>
                      <div className="grid grid-cols-1 sm:grid-cols-2 gap-1.5">
                        {col.subItems.map((item) => (
                          <Link
                            key={item.href}
                            to={item.href}
                            onClick={() => setIsOpen(false)}
                            className="flex items-center gap-3 px-2 py-2.5 rounded-xl hover:bg-white/[0.05] transition-colors"
                          >
                            {item.icon && (
                              <img
                                src={item.icon}
                                alt=""
                                loading="lazy"
                                className="w-12 h-12 object-contain shrink-0 brightness-125 saturate-150 drop-shadow-[0_0_12px_hsl(220_100%_75%/0.45)]"
                              />
                            )}
                            <p className="text-[15px] font-medium text-white leading-tight">{item.label}</p>
                          </Link>
                        ))}
                      </div>
                    </div>
                  );
                })}
              </div>
            </div>

            {/* Espace client + Outils — same as desktop right column */}
            <div className="space-y-3">
              <p className="text-micro text-primary-light uppercase tracking-[0.18em] mb-1">L'expérience Klary</p>
              <a
                href="https://klary.lyta.ch"
                target="_blank"
                rel="noopener noreferrer"
                onClick={() => setIsOpen(false)}
                className="group/card relative overflow-hidden rounded-2xl p-5 bg-gradient-to-br from-primary/30 via-primary/15 to-transparent border border-primary/20 block min-h-[140px]"
              >
                <img
                  src={menuAppIllustration}
                  alt=""
                  loading="lazy"
                  className="absolute -right-4 -bottom-4 w-32 h-32 object-contain opacity-90 pointer-events-none"
                />
                <div className="relative max-w-[60%]">
                  <p className="text-base font-semibold text-white mb-1.5 flex items-center gap-1.5">
                    <Sparkles className="w-4 h-4 text-primary-light" />
                    Espace client
                  </p>
                  <p className="text-xs text-silver-dark leading-relaxed mb-3 font-light">Pilotez vos contrats, sinistres et documents depuis un espace privé.</p>
                  <span className="inline-flex items-center gap-1 text-xs text-primary-light font-medium">
                    Accéder à mon espace <ArrowRight className="w-3 h-3" />
                  </span>
                </div>
              </a>

              <div className="rounded-2xl p-5 bg-gradient-to-br from-white/[0.10] to-white/[0.04] border border-white/[0.15]">
                <p className="text-base font-semibold text-white mb-1.5 flex items-center gap-1.5">
                  <Calculator className="w-4 h-4 text-white" />
                  Nos outils
                </p>
                <p className="text-xs text-white/70 leading-relaxed mb-3 font-light">Propulsé par nos partenaires technologiques.</p>
                <div className="flex items-center gap-4">
                  <a href="https://lyta.ch" target="_blank" rel="noopener noreferrer" onClick={() => setIsOpen(false)} className="flex-1 flex items-center justify-center px-2">
                    <img src={lytaLogo} alt="LYTA" loading="lazy" className="max-h-12 w-auto object-contain" />
                  </a>
                  <a href="https://le-comparateur-optimis.ch" target="_blank" rel="noopener noreferrer" onClick={() => setIsOpen(false)} className="flex-1 flex items-center justify-center px-2">
                    <img src={optimisLogo} alt="OPTIMIS" loading="lazy" className="max-h-12 w-auto object-contain" />
                  </a>
                </div>
              </div>
            </div>

            {/* Phone CTA */}
            <a
              href={`tel:${PHONE_NUMBER}`}
              onClick={() => setIsOpen(false)}
              className="flex items-center justify-center gap-2 bg-white text-[#0C0C12] font-medium rounded-full px-6 py-4 transition-all duration-300"
            >
              <Phone className="w-5 h-5" />
              <span>Appelez-nous : {PHONE_DISPLAY}</span>
            </a>
          </div>
        </div>,
        document.body
      )}
    </nav>
  );
};
