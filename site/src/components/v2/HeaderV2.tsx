import { useEffect, useRef, useState } from "react";
import { Link, useNavigate, useLocation } from "react-router-dom";
import {
  Menu, X, Mail, ChevronDown, ArrowRight, ArrowUpRight, Sparkles,
  Heart, Wallet, Shield, Car, Home, Building2, Users, Scale,
  BookOpen, Calculator, HelpCircle, MessageSquare, Star,
} from "lucide-react";
import klaryLogo from "@/assets/klary-logo-horizontal.png";
import lytaLogo from "@/assets/lyta-logo.svg";
import optimisLogo from "@/assets/optimis-logo.svg";

const CONTACT_EMAIL = "admin@klary.ch";

type MenuLink = { label: string; desc: string; href: string; icon: any; accent: string; badge?: string };
type MegaKey = "assurances" | "ressources";
type NavMega = { label: string; mega: MegaKey };
type NavSimple = { label: string; href: string; mega?: undefined };
type NavItem = NavMega | NavSimple;

const particuliers: MenuLink[] = [
  { label: "Assurance maladie", desc: "LAMal + complémentaires",  href: "/assurances/sante",                icon: Heart,    accent: "hsl(0 75% 60%)"  },
  { label: "3ᵉ pilier",          desc: "Prévoyance privée",         href: "/assurances/3e-pilier",            icon: Wallet,   accent: "hsl(160 70% 42%)" },
  { label: "Hypothèque",         desc: "Financement immobilier",    href: "/assurances/hypotheque",           icon: Home,     accent: "hsl(28 90% 50%)"  },
  { label: "RC & ménage",        desc: "Le combo de base",          href: "/assurances/rc-menage",            icon: Shield,   accent: "hsl(244 65% 42%)" },
  { label: "Automobile",         desc: "RC, casco, occupants",      href: "/assurances/auto",                 icon: Car,      accent: "hsl(220 70% 55%)" },
  { label: "Protection juridique", desc: "Privée & circulation",    href: "/assurances/protection-juridique", icon: Scale,    accent: "hsl(195 75% 45%)" },
];

const entreprises: MenuLink[] = [
  { label: "LPP — 2ᵉ pilier",     desc: "Caisse de pension",        href: "/entreprises/lpp",                 icon: Building2, accent: "hsl(280 60% 50%)" },
  { label: "Personnel d'entreprise", desc: "Indemnités journalières", href: "/entreprises/personnel",        icon: Users,     accent: "hsl(244 65% 42%)" },
];

const ressources: MenuLink[] = [
  { label: "Guides",         desc: "Tout comprendre l'assurance suisse", href: "/guides",       icon: BookOpen,      accent: "hsl(19 90% 54%)"  },
  { label: "Simulateurs",    desc: "5 calculateurs gratuits",            href: "/simulateurs",  icon: Calculator,    accent: "hsl(244 65% 42%)" },
  { label: "FAQ",            desc: "Questions fréquentes",               href: "/#faq",         icon: HelpCircle,    accent: "hsl(220 70% 55%)" },
  { label: "Nous contacter", desc: "Parlons de votre situation",         href: "/#contact",     icon: MessageSquare, accent: "hsl(160 70% 42%)" },
];

const navItems: NavItem[] = [
  { label: "Assurances", mega: "assurances" },
  { label: "Comment ça marche", href: "/#process" },
  { label: "Ressources", mega: "ressources" },
  { label: "À propos", href: "/a-propos" },
  { label: "Carrière", href: "/recrutement" },
];


export const HeaderV2 = () => {
  const [scrolled, setScrolled] = useState(false);
  const [mobileOpen, setMobileOpen] = useState(false);
  const [openMega, setOpenMega] = useState<MegaKey | null>(null);
  const closeTimer = useRef<ReturnType<typeof setTimeout> | null>(null);
  const navigate = useNavigate();
  const location = useLocation();

  useEffect(() => {
    const onScroll = () => setScrolled(window.scrollY > 24);
    onScroll();
    window.addEventListener("scroll", onScroll, { passive: true });
    return () => window.removeEventListener("scroll", onScroll);
  }, []);

  const megaOpen = openMega !== null;

  /**
   * Navigation universelle :
   *  - "/" ou "/xxx"   → route SPA
   *  - "/#anchor"      → naviguer à "/" puis scroll vers l'ancre (marche depuis n'importe quelle page)
   *  - "#anchor"       → scroll uniquement (page courante)
   *  - "tel:" / "mailto:" → géré ailleurs
   */
  const handleNav = (href: string) => {
    setMobileOpen(false);
    setOpenMega(null);

    if (href.startsWith("/#")) {
      const anchor = href.slice(1); // "#process"
      if (location.pathname !== "/") {
        navigate("/");
        setTimeout(() => {
          const el = document.querySelector(anchor);
          if (el) el.scrollIntoView({ behavior: "smooth" });
        }, 150);
      } else {
        const el = document.querySelector(anchor);
        if (el) el.scrollIntoView({ behavior: "smooth" });
      }
    } else if (href.startsWith("#")) {
      const el = document.querySelector(href);
      if (el) el.scrollIntoView({ behavior: "smooth" });
    } else if (href.startsWith("/")) {
      navigate(href);
    }
  };

  const enterMega = (key: MegaKey) => {
    if (closeTimer.current) { clearTimeout(closeTimer.current); closeTimer.current = null; }
    setOpenMega(key);
  };
  const leaveMega = () => {
    closeTimer.current = setTimeout(() => setOpenMega(null), 180);
  };

  return (
    <>
      {/* Backdrop blur when mega menu is open */}
      <div
        aria-hidden
        className={`fixed inset-0 z-[90] transition-all duration-500 ease-out pointer-events-none ${
          megaOpen ? "backdrop-blur-sm bg-foreground/[0.06] opacity-100" : "opacity-0"
        }`}
      />

      <header className="kx-header" data-scrolled={scrolled || megaOpen ? "true" : "false"}>
        <div className="mx-auto max-w-7xl px-5 lg:px-8">
          <div className="flex items-center justify-between h-16 md:h-[72px]">
            <Link to="/" className="flex items-center shrink-0" aria-label="Klary — Accueil">
              <img src={klaryLogo} alt="Klary" className="h-7 md:h-9 w-auto" loading="eager" />
            </Link>

            <nav className="hidden lg:flex items-center gap-7">
              {navItems.map((item) => {
                if ("mega" in item && item.mega) {
                  const isOpen = openMega === item.mega;
                  return (
                    <div
                      key={item.label}
                      className="relative"
                      onMouseEnter={() => enterMega(item.mega)}
                      onMouseLeave={leaveMega}
                    >
                      <button
                        type="button"
                        onClick={() => setOpenMega((v) => (v === item.mega ? null : item.mega))}
                        className="kx-nav-link flex items-center gap-1"
                        data-active={isOpen ? "true" : "false"}
                      >
                        {item.label}
                        <ChevronDown
                          className={`w-3.5 h-3.5 transition-transform duration-300 ${isOpen ? "rotate-180" : ""}`}
                        />
                      </button>
                    </div>
                  );
                }
                // Link direct (route ou anchor cross-page)
                if (item.href.startsWith("/") && !item.href.startsWith("/#")) {
                  return (
                    <Link key={item.label} to={item.href} className="kx-nav-link">
                      {item.label}
                    </Link>
                  );
                }
                return (
                  <button key={item.label} type="button" onClick={() => handleNav(item.href)} className="kx-nav-link">
                    {item.label}
                  </button>
                );
              })}
            </nav>

            <div className="hidden lg:flex items-center gap-3">
              <a href={`mailto:${CONTACT_EMAIL}`} className="kx-btn kx-btn-ghost text-[0.875rem] !py-2 !px-3">
                <Mail className="w-4 h-4" />
                <span className="hidden xl:inline">{CONTACT_EMAIL}</span>
              </a>
              <button type="button" onClick={() => handleNav("/#contact")} className="kx-btn kx-btn-accent !py-2.5 !px-5 text-[0.875rem]">
                Mon analyse gratuite
              </button>
            </div>

            <button
              type="button"
              onClick={() => setMobileOpen((v) => !v)}
              className="lg:hidden inline-flex items-center justify-center w-10 h-10 rounded-full hover:bg-neutral-light/60 transition-colors"
              aria-label={mobileOpen ? "Fermer le menu" : "Ouvrir le menu"}
            >
              {mobileOpen ? <X className="w-5 h-5" /> : <Menu className="w-5 h-5" />}
            </button>
          </div>
        </div>

        {/* ───── MEGA MENU PANEL ───── */}
        <div
          className={`hidden lg:block absolute left-0 right-0 top-full transition-all duration-400 ease-out ${
            megaOpen ? "opacity-100 translate-y-0 pointer-events-auto" : "opacity-0 -translate-y-3 pointer-events-none"
          }`}
          onMouseEnter={() => openMega && enterMega(openMega)}
          onMouseLeave={leaveMega}
          style={{ transitionDuration: "400ms" }}
        >
          <div
            className={`mx-auto px-5 lg:px-8 pt-3 ${
              openMega === "ressources" ? "max-w-[720px]" : "max-w-[1180px]"
            }`}
          >
            <div
              className="relative rounded-[28px] overflow-hidden"
              style={{
                background: "linear-gradient(180deg, hsl(35 35% 99%) 0%, hsl(35 30% 96%) 100%)",
                border: "1px solid hsl(var(--neutral-light))",
                boxShadow: "0 32px 64px -16px rgba(26, 22, 96, 0.18), 0 16px 32px -8px rgba(26, 22, 96, 0.10)",
              }}
            >
              {openMega === "assurances" && (
                <div className="grid grid-cols-[1.05fr_0.85fr_1.1fr]">
                  <MegaColumn label="Particuliers" items={particuliers} onItem={() => setOpenMega(null)} startIdx={0} />
                  <MegaColumn label="Entreprises" items={entreprises} onItem={() => setOpenMega(null)} startIdx={particuliers.length} />
                  <EspaceClientPromo
                    onClose={() => setOpenMega(null)}
                    startIdx={particuliers.length + entreprises.length}
                  />
                </div>
              )}

              {openMega === "ressources" && (
                <div className="grid grid-cols-2">
                  <MegaColumn
                    label="Contenus"
                    items={ressources.slice(0, 2)}
                    onItem={() => setOpenMega(null)}
                    startIdx={0}
                  />
                  <MegaColumn
                    label="Aide & contact"
                    items={ressources.slice(2)}
                    onItem={() => setOpenMega(null)}
                    startIdx={2}
                  />
                </div>
              )}

              {/* Partners strip */}
              <div
                className="border-t border-neutral-light/70 px-6 py-4 flex items-center gap-6"
                style={{ background: "linear-gradient(90deg, hsl(35 35% 98%), hsl(35 30% 96%) 50%, hsl(35 35% 98%))" }}
              >
                <p
                  className="text-[10px] uppercase tracking-[0.18em] font-bold shrink-0 flex items-center gap-2"
                  style={{ color: "hsl(var(--muted-text))" }}
                >
                  <span className="w-4 h-[1.5px] bg-[hsl(var(--accent))] rounded-full" />
                  Nos partenaires officiels
                </p>
                <div className="flex items-center gap-6 flex-1">
                  <a
                    href="https://lyta.ch"
                    target="_blank"
                    rel="noopener noreferrer"
                    onClick={() => setMegaOpen(false)}
                    className="group/partner flex items-center gap-2.5 px-3 py-2 rounded-lg transition-all duration-300 hover:bg-white hover:shadow-soft"
                  >
                    <img
                      src={lytaLogo}
                      alt="LYTA"
                      className="h-7 w-auto object-contain transition-transform duration-300 group-hover/partner:scale-105"
                    />
                    <span className="hidden xl:block text-[11px] leading-tight" style={{ color: "hsl(var(--muted-text))" }}>
                      <span className="block font-semibold text-foreground">CRM courtage</span>
                      Plateforme de gestion
                    </span>
                  </a>

                  <span className="w-px h-8 bg-neutral-light" />

                  <a
                    href="https://le-comparateur-optimis.ch"
                    target="_blank"
                    rel="noopener noreferrer"
                    onClick={() => setMegaOpen(false)}
                    className="group/partner flex items-center gap-2.5 px-3 py-2 rounded-lg transition-all duration-300 hover:bg-white hover:shadow-soft"
                  >
                    <img
                      src={optimisLogo}
                      alt="OPTIMIS"
                      className="h-7 w-auto object-contain transition-transform duration-300 group-hover/partner:scale-105"
                    />
                    <span className="hidden xl:block text-[11px] leading-tight" style={{ color: "hsl(var(--muted-text))" }}>
                      <span className="block font-semibold text-foreground">Comparateur</span>
                      Distribution leads
                    </span>
                  </a>
                </div>
                <span
                  className="text-[10px] uppercase tracking-wider font-semibold shrink-0"
                  style={{ color: "hsl(var(--muted-text))" }}
                >
                  Écosystème Klary
                </span>
              </div>

              {/* Bottom stats strip */}
              <div
                className="border-t border-neutral-light/70 px-6 py-3.5 flex items-center justify-between gap-6 text-[12.5px]"
                style={{ background: "linear-gradient(90deg, transparent, hsl(35 35% 97%), transparent)" }}
              >
                <div className="flex items-center gap-6">
                  <div className="flex items-center gap-2">
                    <div className="flex gap-0.5">
                      {[...Array(5)].map((_, i) => (
                        <Star key={i} className="w-3 h-3 fill-[hsl(45_100%_55%)] text-[hsl(45_100%_55%)]" />
                      ))}
                    </div>
                    <span className="font-semibold text-foreground tabular-nums">4,8/5</span>
                    <span style={{ color: "hsl(var(--muted-text))" }}>· 2'500 clients</span>
                  </div>
                  <span className="text-foreground">
                    <span className="font-semibold tabular-nums" style={{ color: "hsl(var(--accent))" }}>+1'247 CHF</span>
                    <span className="ml-1.5" style={{ color: "hsl(var(--muted-text))" }}>économies moyennes/an</span>
                  </span>
                  <span className="font-semibold text-foreground">
                    <span className="tabular-nums">15 min</span>
                    <span className="ml-1.5 font-normal" style={{ color: "hsl(var(--muted-text))" }}>pour une analyse complète</span>
                  </span>
                </div>
                <button
                  type="button"
                  onClick={() => handleNav("/#contact")}
                  className="group inline-flex items-center gap-1.5 font-semibold transition-all"
                  style={{ color: "hsl(var(--accent))" }}
                >
                  Démarrer mon analyse gratuite
                  <ArrowRight className="w-3.5 h-3.5 transition-transform group-hover:translate-x-0.5" />
                </button>
              </div>
            </div>
          </div>
        </div>

        {/* Mobile sheet */}
        {mobileOpen && <MobileSheet onClose={() => setMobileOpen(false)} onScroll={handleNav} />}
      </header>
    </>
  );
};

// ─────────────────────────────────────────────────────────────

const MegaColumn = ({
  label, items, onItem, startIdx,
}: { label: string; items: MenuLink[]; onItem: () => void; startIdx: number }) => (
  <div className="p-6 lg:p-7 border-r border-neutral-light/70">
    <p
      className="text-[10.5px] uppercase tracking-[0.18em] font-bold mb-5 flex items-center gap-2"
      style={{ color: "hsl(var(--muted-text))" }}
    >
      <span className="w-4 h-[1.5px] bg-[hsl(var(--accent))] rounded-full" />
      {label}
    </p>
    <div className="space-y-0.5">
      {items.map((item, i) => (
        <MegaItem key={item.label} item={item} onClick={onItem} delay={(startIdx + i) * 40} />
      ))}
    </div>
  </div>
);

const MegaItem = ({ item, onClick, delay }: { item: MenuLink; onClick: () => void; delay: number }) => {
  const Icon = item.icon;
  const navigate = useNavigate();
  const location = useLocation();

  const handleClick = (e: React.MouseEvent) => {
    // /#anchor — navigation cross-page vers home + scroll
    if (item.href.startsWith("/#")) {
      e.preventDefault();
      const anchor = item.href.slice(1);
      if (location.pathname !== "/") {
        navigate("/");
        setTimeout(() => {
          const el = document.querySelector(anchor);
          if (el) el.scrollIntoView({ behavior: "smooth" });
        }, 150);
      } else {
        const el = document.querySelector(anchor);
        if (el) el.scrollIntoView({ behavior: "smooth" });
      }
    }
    // #anchor sur page courante uniquement
    else if (item.href.startsWith("#")) {
      e.preventDefault();
      const el = document.querySelector(item.href);
      if (el) el.scrollIntoView({ behavior: "smooth" });
    }
    onClick();
  };

  return (
    <Link
      to={item.href.startsWith("/#") ? "/" : item.href.startsWith("/") ? item.href : "#"}
      onClick={handleClick}
      className="group/it relative flex items-center gap-3 p-2.5 rounded-xl transition-all duration-200 hover:bg-white hover:shadow-soft"
      style={{
        animation: `kx-mega-item-in 0.5s cubic-bezier(0.16, 1, 0.3, 1) ${delay}ms backwards`,
      }}
    >
      {/* Accent left bar */}
      <span
        className="absolute left-0 top-2 bottom-2 w-[3px] rounded-r transition-all duration-300 origin-top"
        style={{
          background: item.accent,
          transform: "scaleY(0)",
        }}
      />
      <style>
        {`.group\\/it:hover > span:first-child { transform: scaleY(1) !important; }`}
      </style>
      <span
        className="w-10 h-10 rounded-xl flex items-center justify-center shrink-0 transition-all duration-300 group-hover/it:scale-105"
        style={{
          background: `${item.accent}14`,
          color: item.accent,
        }}
      >
        <Icon className="w-[18px] h-[18px]" />
      </span>
      <span className="min-w-0 flex-1">
        <span className="flex items-center gap-1.5">
          <span className="block text-[14px] font-semibold text-foreground leading-tight tracking-tight">
            {item.label}
          </span>
          {item.badge && (
            <span
              className="px-1.5 py-0.5 rounded-full text-[9px] font-bold uppercase tracking-wider"
              style={{ background: `${item.accent}1A`, color: item.accent }}
            >
              {item.badge}
            </span>
          )}
        </span>
        <span className="block text-[11.5px] mt-0.5" style={{ color: "hsl(var(--muted-text))" }}>
          {item.desc}
        </span>
      </span>
      <ArrowUpRight className="w-4 h-4 opacity-0 -translate-x-1 transition-all duration-300 group-hover/it:opacity-100 group-hover/it:translate-x-0" style={{ color: "hsl(var(--muted-text))" }} />
    </Link>
  );
};

// ─── Espace client promo (dark, fintech-style) ───

const EspaceClientPromo = ({ onClose, startIdx }: { onClose: () => void; startIdx: number }) => (
  <a
    href="https://klary.lyta.ch"
    target="_blank"
    rel="noopener noreferrer"
    onClick={onClose}
    className="group/promo block relative p-6 lg:p-7 overflow-hidden text-white"
    style={{
      background: "linear-gradient(160deg, #1A1660 0%, #0D0B40 100%)",
      animation: `kx-mega-item-in 0.55s cubic-bezier(0.16, 1, 0.3, 1) ${startIdx * 40}ms backwards`,
    }}
  >
    {/* Floating orbs */}
    <span
      aria-hidden
      className="absolute -top-12 -right-12 w-52 h-52 rounded-full pointer-events-none"
      style={{
        background: "radial-gradient(closest-side, hsl(19 90% 54% / 0.55), transparent 70%)",
        filter: "blur(28px)",
      }}
    />
    <span
      aria-hidden
      className="absolute -bottom-16 -left-16 w-56 h-56 rounded-full pointer-events-none"
      style={{
        background: "radial-gradient(closest-side, hsl(258 70% 60% / 0.40), transparent 70%)",
        filter: "blur(40px)",
      }}
    />

    <div className="relative">
      {/* Header */}
      <div className="flex items-center justify-between mb-4">
        <span className="inline-flex items-center gap-1.5 px-2.5 py-1 rounded-full bg-white/10 backdrop-blur-sm text-[10px] uppercase tracking-wider font-bold">
          <Sparkles className="w-3 h-3 text-[hsl(28_95%_70%)]" />
          Espace client
        </span>
        <span className="px-2 py-0.5 rounded-full bg-[hsl(19_90%_54%)] text-white text-[9px] font-bold uppercase tracking-wider">
          New
        </span>
      </div>

      <p className="text-[18px] font-bold tracking-tight leading-snug mb-2">
        Vos contrats,<br />
        vos sinistres,<br />
        vos économies.
      </p>
      <p className="text-[11.5px] text-white/65 leading-relaxed mb-4 max-w-[200px]">
        Pilotez tout depuis un espace privé. Signature électronique, alertes, rapport d'économies temps réel.
      </p>

      {/* Mini dashboard preview */}
      <div className="relative rounded-xl bg-white/[0.04] border border-white/10 backdrop-blur-sm p-3 mb-4">
        <div className="flex items-center justify-between mb-2.5">
          <span className="text-[9px] uppercase tracking-wider font-bold text-white/55">Mes contrats</span>
          <span className="flex items-center gap-1 text-[9px] text-[hsl(160_70%_60%)] font-bold tabular-nums">
            <span className="relative inline-flex w-1.5 h-1.5">
              <span className="absolute inset-0 rounded-full bg-[hsl(160_70%_60%)] animate-ping opacity-75" />
              <span className="relative w-1.5 h-1.5 rounded-full bg-[hsl(160_70%_60%)]" />
            </span>
            Live
          </span>
        </div>
        <div className="space-y-1.5">
          {[
            { l: "Maladie", v: "287.- ", t: "-184 CHF", c: "hsl(0 75% 60%)" },
            { l: "3ᵉ pilier", v: "350.- ", t: "-840 CHF", c: "hsl(160 70% 50%)" },
            { l: "Hypo", v: "1.42 %", t: "vs 1.78", c: "hsl(28 95% 65%)" },
          ].map((r) => (
            <div key={r.l} className="flex items-center justify-between text-[10.5px]">
              <span className="text-white/85 font-medium">{r.l}</span>
              <div className="flex items-center gap-2">
                <span className="text-white tabular-nums font-semibold">{r.v}</span>
                <span className="px-1.5 py-0.5 rounded text-[8.5px] font-bold tabular-nums" style={{ background: `${r.c}28`, color: r.c }}>
                  {r.t}
                </span>
              </div>
            </div>
          ))}
        </div>
        <div className="mt-2.5 pt-2.5 border-t border-white/10 flex items-center justify-between">
          <span className="text-[8.5px] uppercase tracking-wider font-bold text-white/45">Total / an</span>
          <span className="text-[12px] font-bold tabular-nums text-[hsl(28_95%_70%)]">- 1'247 CHF</span>
        </div>
      </div>

      <span className="inline-flex items-center gap-1.5 text-[12.5px] font-semibold text-[hsl(28_95%_70%)] group-hover/promo:gap-2.5 transition-all">
        Accéder à mon espace
        <ArrowRight className="w-3.5 h-3.5 transition-transform group-hover/promo:translate-x-1" />
      </span>
    </div>
  </a>
);

// ─── Mobile sheet ───

const MobileSheet = ({ onClose, onScroll }: { onClose: () => void; onScroll: (href: string) => void }) => (
  <div className="lg:hidden absolute left-0 right-0 top-full bg-background border-t border-neutral-light shadow-medium animate-in fade-in duration-200">
    <div className="px-5 py-6 space-y-4 max-h-[calc(100vh-80px)] overflow-y-auto">
      <MobileSection title="Particuliers" items={particuliers} onClose={onClose} />
      <MobileSection title="Entreprises" items={entreprises} onClose={onClose} />
      <MobileSection title="Ressources" items={ressources} onClose={onClose} />

      {/* Liens directs sans mega */}
      <div className="pt-4 border-t border-neutral-light">
        <p className="text-[10px] uppercase tracking-wider font-bold pb-2" style={{ color: "hsl(var(--muted-text))" }}>
          Klary
        </p>
        <div className="grid grid-cols-2 gap-1.5">
          <Link to="/a-propos" onClick={onClose} className="flex items-center gap-2.5 p-2.5 rounded-xl border border-neutral-light/70">
            <span className="text-[13px] font-semibold text-foreground">À propos</span>
          </Link>
          <Link to="/recrutement" onClick={onClose} className="flex items-center gap-2.5 p-2.5 rounded-xl border border-neutral-light/70">
            <span className="text-[13px] font-semibold text-foreground">Carrière</span>
          </Link>
          <button
            type="button"
            onClick={() => onScroll("/#process")}
            className="col-span-2 flex items-center gap-2.5 p-2.5 rounded-xl border border-neutral-light/70"
          >
            <span className="text-[13px] font-semibold text-foreground">Comment ça marche</span>
          </button>
        </div>
      </div>

      <div className="pt-4 flex flex-col gap-3 border-t border-neutral-light">
        <a href={`mailto:${CONTACT_EMAIL}`} className="kx-btn kx-btn-outline w-full">
          <Mail className="w-4 h-4" />
          {CONTACT_EMAIL}
        </a>
        <button type="button" onClick={() => onScroll("/#contact")} className="kx-btn kx-btn-accent w-full">
          Mon analyse gratuite
        </button>
      </div>
    </div>
  </div>
);

const MobileSection = ({ title, items, onClose }: { title: string; items: MenuLink[]; onClose: () => void }) => {
  const navigate = useNavigate();
  const location = useLocation();

  const goto = (href: string) => {
    onClose();
    if (href.startsWith("/#")) {
      const anchor = href.slice(1);
      if (location.pathname !== "/") {
        navigate("/");
        setTimeout(() => document.querySelector(anchor)?.scrollIntoView({ behavior: "smooth" }), 150);
      } else {
        document.querySelector(anchor)?.scrollIntoView({ behavior: "smooth" });
      }
    } else if (href.startsWith("/")) {
      navigate(href);
    }
  };

  return (
    <div>
      <p className="text-[10px] uppercase tracking-wider font-bold pb-2" style={{ color: "hsl(var(--muted-text))" }}>{title}</p>
      <div className="grid grid-cols-2 gap-1.5">
        {items.map((item) => {
          const Icon = item.icon;
          return (
            <button
              key={item.label}
              type="button"
              onClick={() => goto(item.href)}
              className="flex items-start gap-2.5 p-2.5 rounded-xl border border-neutral-light/70 text-left"
            >
              <span className="w-8 h-8 rounded-lg flex items-center justify-center shrink-0" style={{ background: `${item.accent}14`, color: item.accent }}>
                <Icon className="w-4 h-4" />
              </span>
              <span className="min-w-0">
                <span className="block text-[13px] font-semibold text-foreground leading-tight">{item.label}</span>
                <span className="block text-[10px] mt-0.5" style={{ color: "hsl(var(--muted-text))" }}>{item.desc}</span>
              </span>
            </button>
          );
        })}
      </div>
    </div>
  );
};
