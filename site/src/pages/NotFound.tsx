import { Link, useLocation } from "react-router-dom";
import { useEffect } from "react";
import { ArrowLeft, ArrowRight, Search, AlertCircle } from "lucide-react";
import { HeaderV2 } from "@/components/v2/HeaderV2";
import { FooterV2 } from "@/components/v2/FooterV2";
import { ScrollProgress } from "@/components/v2/ScrollProgress";
import { Reveal } from "@/components/v2/Reveal";

const NotFound = () => {
  const location = useLocation();

  useEffect(() => {
    console.warn("404:", location.pathname);
  }, [location.pathname]);

  const popularLinks = [
    { label: "Assurance maladie",  href: "/assurances/sante" },
    { label: "3ᵉ pilier",           href: "/assurances/3e-pilier" },
    { label: "Hypothèque",          href: "/assurances/hypotheque" },
    { label: "RC & ménage",         href: "/assurances/rc-menage" },
    { label: "Simulateurs",         href: "/simulateurs" },
    { label: "À propos",            href: "/a-propos" },
  ];

  return (
    <div className="min-h-screen bg-background text-foreground flex flex-col">
      <ScrollProgress />
      <HeaderV2 />

      <main
        className="flex-1 relative overflow-hidden flex items-center justify-center pt-28 pb-16 md:pt-36 md:pb-24"
        style={{
          background: `radial-gradient(
            1500px 80vh at 50% 0px,
            #FAF7EE 0px, #F4E5D0 16%, #F0BD8E 35%, #E8745D 55%, #C04A7A 72%, #6D3A78 88%, #2D1B5C 100%
          )`,
        }}
      >
        {/* Animated overlays */}
        <div
          aria-hidden
          className="absolute inset-0 pointer-events-none"
          style={{
            background: `radial-gradient(800px 600px at 30% 60%, rgba(240, 101, 31, 0.4), transparent 65%)`,
            animation: "kx-orb-cross 12s ease-in-out infinite",
            mixBlendMode: "screen",
            willChange: "transform, opacity",
          }}
        />
        <div
          aria-hidden
          className="absolute inset-0 pointer-events-none"
          style={{
            background: `radial-gradient(700px 500px at 70% 60%, rgba(109, 58, 120, 0.4), transparent 65%)`,
            animation: "kx-orb-cross 14s ease-in-out infinite reverse",
            animationDelay: "-3s",
            mixBlendMode: "screen",
            willChange: "transform, opacity",
          }}
        />

        <div className="relative z-[2] mx-auto max-w-3xl px-5 lg:px-8 text-center">
          <Reveal>
            <span
              className="inline-flex items-center gap-2 px-3 py-1.5 rounded-full text-[11px] font-semibold uppercase tracking-[0.16em] mb-6"
              style={{
                background: "rgba(255,255,255,0.70)",
                color: "hsl(var(--accent))",
                border: "1px solid rgba(26, 22, 96, 0.10)",
              }}
            >
              <AlertCircle className="w-3 h-3" />
              Erreur 404
            </span>

            <h1
              className="font-extrabold tracking-tight leading-[0.95] mb-6"
              style={{
                fontSize: "clamp(4rem, 14vw, 9rem)",
                letterSpacing: "-0.04em",
                background: "linear-gradient(135deg, #100D32 0%, #1A1660 40%, hsl(19 90% 50%) 100%)",
                WebkitBackgroundClip: "text",
                backgroundClip: "text",
                WebkitTextFillColor: "transparent",
              }}
            >
              404
            </h1>

            <h2 className="text-2xl md:text-3xl font-bold mb-4 text-foreground tracking-tight">
              Cette page n'existe pas (ou plus).
            </h2>

            <p className="text-base md:text-lg leading-relaxed mb-8 max-w-xl mx-auto" style={{ color: "hsl(244 40% 22%)" }}>
              L'URL <code className="font-mono text-sm px-1.5 py-0.5 rounded bg-white/60 text-foreground">{location.pathname}</code>{" "}
              n'a pas été trouvée. Elle a peut-être été déplacée ou supprimée.
            </p>

            <div className="flex flex-col sm:flex-row gap-3 justify-center mb-12">
              <Link to="/" className="kx-btn kx-btn-accent">
                <ArrowLeft className="w-4 h-4" />
                Retour à l'accueil
              </Link>
              <Link to="/assurances" className="kx-btn kx-btn-outline">
                Voir nos couvertures
                <ArrowRight className="w-4 h-4" />
              </Link>
            </div>
          </Reveal>

          <Reveal delay={200}>
            <div className="rounded-2xl bg-white/70 backdrop-blur-sm border border-white/60 p-6 md:p-7">
              <p
                className="text-[11px] uppercase tracking-[0.16em] font-bold mb-4 flex items-center justify-center gap-2"
                style={{ color: "hsl(var(--accent))" }}
              >
                <Search className="w-3.5 h-3.5" />
                Pages populaires
              </p>
              <div className="grid grid-cols-2 md:grid-cols-3 gap-2">
                {popularLinks.map((l) => (
                  <Link
                    key={l.href}
                    to={l.href}
                    className="text-sm font-medium text-foreground hover:text-[hsl(var(--accent))] transition-colors py-2 px-3 rounded-lg hover:bg-white/60"
                  >
                    {l.label}
                  </Link>
                ))}
              </div>
            </div>
          </Reveal>
        </div>
      </main>

      <FooterV2 />
    </div>
  );
};

export default NotFound;
