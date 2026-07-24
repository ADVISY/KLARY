import { Link } from "react-router-dom";
import { Mail } from "lucide-react";
import klaryLogo from "@/assets/klary-logo-horizontal.png";

const Maintenance = () => {
  return (
    <div
      className="relative min-h-screen flex flex-col overflow-hidden text-white"
      style={{
        background: `
          radial-gradient(900px 700px at 80% 10%, rgba(240, 101, 31, 0.18) 0%, transparent 60%),
          radial-gradient(700px 600px at 15% 90%, rgba(120, 100, 220, 0.22) 0%, transparent 60%),
          linear-gradient(180deg, #14123F 0%, #0D0B40 55%, #0A0830 100%)
        `,
      }}
    >
      {/* Grain / noise overlay */}
      <div
        aria-hidden
        className="absolute inset-0 opacity-[0.035] mix-blend-overlay pointer-events-none"
        style={{
          backgroundImage:
            "url(\"data:image/svg+xml,%3Csvg viewBox='0 0 200 200' xmlns='http://www.w3.org/2000/svg'%3E%3Cfilter id='n'%3E%3CfeTurbulence type='fractalNoise' baseFrequency='0.9' numOctaves='2' stitchTiles='stitch'/%3E%3C/filter%3E%3Crect width='100%25' height='100%25' filter='url(%23n)'/%3E%3C/svg%3E\")",
        }}
      />

      {/* Floating orbs */}
      <span
        aria-hidden
        className="absolute -top-24 -right-24 w-[520px] h-[520px] rounded-full pointer-events-none"
        style={{
          background: "radial-gradient(closest-side, hsl(19 90% 54% / 0.35), transparent 70%)",
          filter: "blur(60px)",
          animation: "kx-float-slow 22s ease-in-out infinite",
        }}
      />
      <span
        aria-hidden
        className="absolute -bottom-32 -left-32 w-[600px] h-[600px] rounded-full pointer-events-none"
        style={{
          background: "radial-gradient(closest-side, hsl(258 70% 60% / 0.30), transparent 70%)",
          filter: "blur(80px)",
          animation: "kx-float-slow 26s ease-in-out infinite reverse",
        }}
      />

      {/* Content */}
      <main className="relative z-10 flex-1 flex items-center justify-center px-6 py-16">
        <div
          className="max-w-2xl w-full text-center"
          style={{ animation: "kx-fade-in-up 900ms cubic-bezier(0.16, 1, 0.3, 1) both" }}
        >
          {/* Logo */}
          <div className="flex justify-center mb-12">
            <img
              src={klaryLogo}
              alt="Klary"
              className="h-11 md:h-14 w-auto brightness-0 invert"
            />
          </div>

          {/* Badge */}
          <span
            className="inline-flex items-center gap-2 px-3 py-1.5 rounded-full text-[11px] uppercase tracking-[0.18em] font-bold mb-8 backdrop-blur-sm"
            style={{
              background: "rgba(255, 255, 255, 0.08)",
              border: "1px solid rgba(255, 255, 255, 0.14)",
              color: "hsl(28 95% 78%)",
            }}
          >
            <span className="relative inline-flex w-2 h-2">
              <span className="absolute inset-0 rounded-full bg-[hsl(28_95%_65%)] animate-ping opacity-75" />
              <span className="relative w-2 h-2 rounded-full bg-[hsl(28_95%_65%)]" />
            </span>
            En préparation
          </span>

          {/* Headline */}
          <h1
            className="text-[2.5rem] sm:text-[3.25rem] lg:text-[4rem] font-bold leading-[1.02] tracking-tight mb-6"
            style={{ letterSpacing: "-0.03em" }}
          >
            Bientôt{" "}
            <span
              style={{
                background: "linear-gradient(120deg, hsl(19 90% 60%) 0%, hsl(28 95% 72%) 100%)",
                WebkitBackgroundClip: "text",
                backgroundClip: "text",
                WebkitTextFillColor: "transparent",
              }}
            >
              disponible.
            </span>
          </h1>

          {/* Subtitle */}
          <p className="text-lg md:text-xl leading-relaxed text-white/70 max-w-lg mx-auto mb-12">
            Notre site est en cours de finalisation. On revient très vite avec une nouvelle expérience.
          </p>

          {/* Contact card */}
          <div
            className="inline-flex flex-col sm:flex-row items-center gap-4 sm:gap-6 px-6 py-5 rounded-2xl backdrop-blur-sm"
            style={{
              background: "rgba(255, 255, 255, 0.05)",
              border: "1px solid rgba(255, 255, 255, 0.12)",
            }}
          >
            <div className="flex items-center gap-3 text-left">
              <span
                className="w-11 h-11 rounded-xl flex items-center justify-center shrink-0"
                style={{
                  background: "rgba(240, 101, 31, 0.15)",
                  color: "hsl(28 95% 72%)",
                }}
              >
                <Mail className="w-5 h-5" />
              </span>
              <div>
                <p className="text-[11px] uppercase tracking-[0.18em] font-bold text-white/50">
                  Une question ?
                </p>
                <a
                  href="mailto:admin@klary.ch"
                  className="text-base md:text-lg font-semibold text-white hover:text-[hsl(28_95%_72%)] transition-colors"
                >
                  admin@klary.ch
                </a>
              </div>
            </div>
          </div>
        </div>
      </main>

      {/* Footer */}
      <footer className="relative z-10 px-6 pb-8">
        <div className="max-w-4xl mx-auto flex flex-col sm:flex-row items-center justify-between gap-3 text-xs text-white/40">
          <p>© {new Date().getFullYear()} Klary Sàrl · Eysins, Suisse</p>
          <div className="flex items-center gap-5">
            <Link to="/mentions-legales" className="hover:text-white/70 transition-colors">
              Mentions légales
            </Link>
            <Link to="/politique-confidentialite" className="hover:text-white/70 transition-colors">
              Confidentialité
            </Link>
          </div>
        </div>
      </footer>

      <style>{`
        @keyframes kx-fade-in-up {
          from { opacity: 0; transform: translateY(24px); }
          to { opacity: 1; transform: translateY(0); }
        }
        @keyframes kx-float-slow {
          0%, 100% { transform: translate(0, 0) scale(1); }
          50% { transform: translate(30px, -40px) scale(1.05); }
        }
      `}</style>
    </div>
  );
};

export default Maintenance;
