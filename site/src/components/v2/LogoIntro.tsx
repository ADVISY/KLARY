import { useEffect, useState } from "react";
import { KlaryLogoFullAnimated } from "./KlaryLogoFullAnimated";

interface LogoIntroProps {
  onComplete: () => void;
}

/**
 * Brand intro — full SVG with REAL Klary letterforms, animated per component.
 *   t=0           – cream gradient bg + ambient orbs fade in
 *   t=200         – K body (3 navy stripes + 2 dark stripes) drops in with spring
 *   t=900–1260    – 4 orange petals pop in one by one
 *   t=1500        – "klary" wordmark (real brand font) slides in with blur clear
 *   t=2100        – tagline fades up
 *   t=2900        – everything fades + scales out → site
 */
export const LogoIntro = ({ onComplete }: LogoIntroProps) => {
  const [phase, setPhase] = useState<"in" | "out">("in");

  useEffect(() => {
    const out = setTimeout(() => setPhase("out"), 3700);
    const done = setTimeout(onComplete, 4400);
    return () => {
      clearTimeout(out);
      clearTimeout(done);
    };
  }, [onComplete]);

  return (
    <div
      aria-hidden
      className={`fixed inset-0 z-[300] flex items-center justify-center transition-all duration-700 ease-out ${
        phase === "out" ? "opacity-0 scale-[1.04] pointer-events-none" : "opacity-100"
      }`}
      style={{
        background:
          "radial-gradient(circle at 50% 45%, #FFFFFF 0%, #F8F4EA 50%, #ECE5DA 100%)",
      }}
    >
      {/* Ambient orbs */}
      <span
        aria-hidden
        className="absolute pointer-events-none"
        style={{
          left: "50%", top: "50%",
          width: 720, height: 720,
          transform: "translate(-50%, -50%)",
          background: "radial-gradient(closest-side, hsl(19 90% 54% / 0.18), transparent 70%)",
          filter: "blur(60px)",
          animation: "kx-intro-orb-1 2.2s ease-out forwards",
        }}
      />
      <span
        aria-hidden
        className="absolute pointer-events-none"
        style={{
          left: "50%", top: "50%",
          width: 520, height: 520,
          transform: "translate(-50%, -50%)",
          background: "radial-gradient(closest-side, hsl(244 65% 35% / 0.14), transparent 70%)",
          filter: "blur(50px)",
          animation: "kx-intro-orb-2 2.2s ease-out forwards",
        }}
      />

      {/* Full Klary logo (icon + real wordmark) — components animate individually */}
      <div className="relative">
        <KlaryLogoFullAnimated
          animateIn
          startDelay={200}
          className="block"
          style={{ width: "clamp(280px, 36vw, 460px)", height: "auto" }}
        />

        {/* Tagline */}
        <span
          className="absolute left-1/2 -translate-x-1/2 top-full mt-3 md:mt-5 whitespace-nowrap text-[0.7rem] md:text-sm font-medium tracking-[0.16em] uppercase"
          style={{
            opacity: 0,
            animation: "kx-intro-tagline 0.7s cubic-bezier(0.16, 1, 0.3, 1) 2100ms forwards",
            background: "linear-gradient(90deg, hsl(20 30% 30%) 0%, hsl(244 65% 22%) 50%, hsl(220 60% 35%) 100%)",
            WebkitBackgroundClip: "text",
            backgroundClip: "text",
            WebkitTextFillColor: "transparent",
          }}
        >
          l'assurance enfin claire
        </span>
      </div>
    </div>
  );
};
