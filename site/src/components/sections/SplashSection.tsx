import advisyLogo from "@/assets/klary-logo-horizontal.png";

interface SplashSectionProps {
  onEnter: () => void;
}

export const SplashSection = ({ onEnter }: SplashSectionProps) => {
  return (
    <section className="min-h-screen flex items-center justify-center relative overflow-hidden bg-background">
      {/* Ambient glow — aligné sur le hero (violet/bleu/magenta) */}
      <div aria-hidden className="pointer-events-none absolute inset-0 overflow-hidden">
        {/* Aurora wash — adouci */}
        <div
          className="absolute left-1/2 top-1/2 -translate-x-1/2 -translate-y-1/2 w-[1600px] h-[1600px] rounded-full"
          style={{
            background:
              "radial-gradient(closest-side, hsl(258 90% 62% / 0.20), hsl(232 90% 58% / 0.10) 35%, transparent 75%)",
          filter: "blur(160px)",
          }}
        />
        {/* Magenta gauche — léger */}
        <div
          className="absolute left-[18%] top-[60%] -translate-y-1/2 w-[800px] h-[800px] rounded-full"
          style={{
            background:
              "radial-gradient(closest-side, hsl(315 100% 65% / 0.15), transparent 75%)",
          filter: "blur(140px)",
          }}
        />
        {/* Bleu droite — adouci */}
        <div
          className="absolute right-[18%] top-[45%] -translate-y-1/2 w-[800px] h-[800px] rounded-full"
          style={{
            background:
              "radial-gradient(closest-side, hsl(220 100% 65% / 0.15), transparent 75%)",
          filter: "blur(140px)",
          }}
        />
        {/* Halo central chaud — discret */}
        <div
          className="absolute left-1/2 top-1/2 -translate-x-1/2 -translate-y-1/2 w-[600px] h-[600px] rounded-full"
          style={{
            background:
              "radial-gradient(closest-side, hsl(265 100% 88% / 0.17), transparent 80%)",
            filter: "blur(80px)",
          }}
        />
        {/* Grain principal */}
        <div
          className="absolute inset-0 opacity-[0.18] mix-blend-overlay"
          style={{
            backgroundImage:
              "url(\"data:image/svg+xml;utf8,<svg xmlns='http://www.w3.org/2000/svg' width='240' height='240'><filter id='n'><feTurbulence type='fractalNoise' baseFrequency='1.2' numOctaves='3' stitchTiles='stitch'/><feColorMatrix type='matrix' values='0 0 0 0 1  0 0 0 0 1  0 0 0 0 1  0 0 0 0.95 0'/></filter><rect width='100%' height='100%' filter='url(%23n)'/></svg>\")",
          }}
        />
        {/* Grain fin */}
        <div
          className="absolute inset-0 opacity-[0.10] mix-blend-soft-light"
          style={{
            backgroundImage:
              "url(\"data:image/svg+xml;utf8,<svg xmlns='http://www.w3.org/2000/svg' width='140' height='140'><filter id='n2'><feTurbulence type='fractalNoise' baseFrequency='2.4' numOctaves='2' stitchTiles='stitch'/></filter><rect width='100%' height='100%' filter='url(%23n2)'/></svg>\")",
          }}
        />
      </div>

      <div className="relative z-10 flex flex-col items-center gap-12 px-6 animate-fade-in">
        <img
          src={advisyLogo}
          alt="Klary"
          className="w-auto h-36 md:h-44 object-contain"
        />

        <button
          onClick={onEnter}
          className="nav-pill inline-flex items-center justify-center gap-3 font-medium rounded-full px-8 py-3.5 text-base text-white !bg-[hsl(240_18%_9%/0.85)] backdrop-blur-xl"
        >
          <span>Entrer dans le site</span>
          <span aria-hidden>→</span>
        </button>
      </div>
    </section>
  );
};
