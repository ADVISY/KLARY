import { useEffect, useRef } from "react";

/**
 * Dôme lumineux SBS-style à cheval sur la frontière entre deux sections.
 * Le dôme est un grand demi-cercle radial qui "perce" la frontière sombre/claire
 * comme un soleil filtrant ou une aurore.
 *
 * Architecture :
 *  - Une bande de hauteur fixe (~480px) avec gradient linéaire vertical (continuité de couleur)
 *  - Un dôme RADIAL massif (90vw × 460px) centré horizontalement, à 50% de la bande
 *  - 2 couches de halo (couleur primaire + accent) qui pulse en respiration
 *  - Particules en orbite
 *  - Parallax vertical fort sur la couche principale
 */

type Variant = "navy-to-cream" | "cream-to-navy";

interface ArcTransitionProps {
  variant?: Variant;
  height?: number;
}

const PALETTES: Record<Variant, {
  topColor: string;
  bottomColor: string;
  domeStops: string;
  accentStops: string;
}> = {
  "navy-to-cream": {
    topColor: "#0D0B40",
    bottomColor: "#F3EFE7",
    // Dôme principal : orange→rose→violet→navy
    domeStops: `
      rgba(255, 245, 200, 1) 0%,
      rgba(255, 180, 100, 0.98) 10%,
      rgba(240, 101, 31, 0.95) 22%,
      rgba(232, 70, 110, 0.85) 38%,
      rgba(192, 74, 122, 0.72) 55%,
      rgba(109, 58, 120, 0.55) 72%,
      rgba(45, 27, 92, 0.30) 88%,
      transparent 100%
    `,
    // Halo extérieur jaune doux
    accentStops: `
      rgba(255, 235, 170, 0.6) 0%,
      rgba(255, 180, 100, 0.4) 30%,
      transparent 70%
    `,
  },
  "cream-to-navy": {
    topColor: "#F3EFE7",
    bottomColor: "#0D0B40",
    domeStops: `
      rgba(255, 245, 200, 1) 0%,
      rgba(255, 180, 100, 0.98) 10%,
      rgba(240, 101, 31, 0.95) 22%,
      rgba(232, 70, 110, 0.85) 38%,
      rgba(192, 74, 122, 0.72) 55%,
      rgba(109, 58, 120, 0.55) 72%,
      rgba(45, 27, 92, 0.30) 88%,
      transparent 100%
    `,
    accentStops: `
      rgba(255, 235, 170, 0.55) 0%,
      rgba(255, 180, 100, 0.35) 30%,
      transparent 70%
    `,
  },
};

export const ArcTransition = ({ variant = "navy-to-cream", height = 480 }: ArcTransitionProps) => {
  const rootRef = useRef<HTMLElement | null>(null);
  const domeWrapRef = useRef<HTMLDivElement | null>(null);
  const accentWrapRef = useRef<HTMLDivElement | null>(null);
  const coreWrapRef = useRef<HTMLDivElement | null>(null);

  // Parallax vertical lié au scroll
  useEffect(() => {
    const root = rootRef.current;
    if (!root) return;

    let raf = 0;
    const update = () => {
      raf = 0;
      const rect = root.getBoundingClientRect();
      const vh = window.innerHeight;
      const center = (rect.top + rect.bottom) / 2;
      const rel = (vh / 2 - center) / vh;

      // Couches à vitesses différentes pour effet de profondeur
      if (domeWrapRef.current) {
        domeWrapRef.current.style.transform = `translate3d(0, ${rel * 60}%, 0)`;
      }
      if (accentWrapRef.current) {
        accentWrapRef.current.style.transform = `translate3d(0, ${rel * 90}%, 0)`;
      }
      if (coreWrapRef.current) {
        coreWrapRef.current.style.transform = `translate3d(0, ${rel * 35}%, 0)`;
      }
    };

    const onScroll = () => {
      if (raf) return;
      raf = requestAnimationFrame(update);
    };

    update();
    window.addEventListener("scroll", onScroll, { passive: true });
    window.addEventListener("resize", update, { passive: true });
    return () => {
      window.removeEventListener("scroll", onScroll);
      window.removeEventListener("resize", update);
      if (raf) cancelAnimationFrame(raf);
    };
  }, []);

  const palette = PALETTES[variant];
  // Le dôme est plus haut que large pour donner l'effet "demi-soleil"
  const domeWidthVw = 95;
  const domeHeightPx = Math.round(height * 1.05);

  return (
    <section
      ref={rootRef}
      aria-hidden
      className="relative w-full overflow-hidden"
      style={{
        height: `${height}px`,
        background: `linear-gradient(180deg, ${palette.topColor} 0%, ${palette.bottomColor} 100%)`,
      }}
    >
      {/* Halo accent extérieur — large ellipse jaune douce, blur fort, pulse lent */}
      <div
        ref={accentWrapRef}
        className="absolute inset-0 pointer-events-none"
        style={{ willChange: "transform" }}
      >
        <div
          className="absolute left-1/2 top-1/2"
          style={{
            width: `${domeWidthVw + 30}vw`,
            height: `${domeHeightPx + 200}px`,
            background: `radial-gradient(ellipse 50vw ${Math.round(height * 0.6)}px at 50% 50%, ${palette.accentStops})`,
            transform: "translate(-50%, -50%)",
            filter: "blur(40px)",
            animation: "kx-arc-halo 8s ease-in-out infinite",
            willChange: "transform, opacity",
          }}
        />
      </div>

      {/* Dôme principal — radial-gradient avec couleurs OPAQUES (pas mix-blend) */}
      <div
        ref={domeWrapRef}
        className="absolute inset-0 pointer-events-none"
        style={{ willChange: "transform" }}
      >
        <div
          className="absolute left-1/2 top-1/2"
          style={{
            width: `${domeWidthVw}vw`,
            height: `${domeHeightPx}px`,
            background: `radial-gradient(ellipse 40vw ${Math.round(height * 0.55)}px at 50% 50%, ${palette.domeStops})`,
            transform: "translate(-50%, -50%)",
            animation: "kx-arc-pulse 6s ease-in-out infinite",
            willChange: "transform, filter",
          }}
        />
      </div>

      {/* Cœur lumineux brillant — petit point très intense, pulse rapide */}
      <div
        ref={coreWrapRef}
        className="absolute inset-0 pointer-events-none"
        style={{ willChange: "transform" }}
      >
        <div
          className="absolute left-1/2 top-1/2"
          style={{
            width: `${Math.round(domeWidthVw * 0.55)}vw`,
            height: `${Math.round(height * 0.5)}px`,
            background: `radial-gradient(ellipse 18vw ${Math.round(height * 0.22)}px at 50% 50%,
              rgba(255, 250, 230, 0.95) 0%,
              rgba(255, 215, 150, 0.7) 25%,
              rgba(255, 165, 90, 0.45) 50%,
              transparent 80%)`,
            transform: "translate(-50%, -50%)",
            mixBlendMode: "screen",
            animation: "kx-arc-core 3s ease-in-out infinite",
            willChange: "transform, opacity, filter",
          }}
        />
      </div>

      {/* Rayons en conic-gradient — tournent lentement */}
      <div
        className="absolute left-1/2 top-1/2 pointer-events-none"
        style={{
          width: `${Math.round(domeWidthVw * 0.7)}vw`,
          height: `${Math.round(height * 0.7)}px`,
          background: `conic-gradient(from 0deg at 50% 50%,
            rgba(255, 200, 130, 0) 0deg,
            rgba(255, 200, 130, 0.30) 18deg,
            rgba(255, 200, 130, 0) 36deg,
            rgba(255, 200, 130, 0.25) 72deg,
            rgba(255, 200, 130, 0) 90deg,
            rgba(255, 200, 130, 0.25) 126deg,
            rgba(255, 200, 130, 0) 144deg,
            rgba(255, 200, 130, 0.25) 180deg,
            rgba(255, 200, 130, 0) 198deg,
            rgba(255, 200, 130, 0.25) 234deg,
            rgba(255, 200, 130, 0) 252deg,
            rgba(255, 200, 130, 0.25) 288deg,
            rgba(255, 200, 130, 0) 306deg,
            rgba(255, 200, 130, 0.25) 342deg,
            rgba(255, 200, 130, 0) 360deg
          )`,
          maskImage: "radial-gradient(circle at 50% 50%, black 5%, transparent 60%)",
          WebkitMaskImage: "radial-gradient(circle at 50% 50%, black 5%, transparent 60%)",
          mixBlendMode: "screen",
          opacity: 0.55,
          transform: "translate(-50%, -50%)",
          animation: "kx-bg-rotate 18s linear infinite",
          willChange: "transform",
        }}
      />

      {/* Particules orbitant */}
      <div className="absolute left-1/2 top-1/2 pointer-events-none" style={{ width: 0, height: 0 }}>
        {[
          { size: 14, dur: 9, delay: 0,   color: "rgba(255, 230, 160, 1)", accent: "rgba(240, 101, 31, 0.85)", orbit: "kx-arc-orbit-1" },
          { size: 10, dur: 13, delay: -4, color: "rgba(255, 200, 220, 0.95)", accent: "rgba(192, 74, 122, 0.8)", orbit: "kx-arc-orbit-2" },
          { size: 8,  dur: 16, delay: -6, color: "rgba(220, 200, 255, 1)", accent: "rgba(109, 58, 120, 0.85)", orbit: "kx-arc-orbit-1" },
          { size: 6,  dur: 11, delay: -2, color: "rgba(255, 245, 200, 1)", accent: "rgba(255, 165, 90, 0.7)", orbit: "kx-arc-orbit-2" },
        ].map((p, i) => (
          <div
            key={i}
            className="absolute"
            style={{
              top: 0,
              left: 0,
              width: `${p.size}px`,
              height: `${p.size}px`,
              borderRadius: "9999px",
              background: `radial-gradient(circle, ${p.color} 0%, ${p.accent} 50%, transparent 80%)`,
              filter: `blur(${Math.max(1.5, p.size * 0.2)}px)`,
              animation: `${p.orbit} ${p.dur}s linear infinite${i % 2 ? ' reverse' : ''}`,
              animationDelay: `${p.delay}s`,
              mixBlendMode: "screen",
              willChange: "transform",
            }}
          />
        ))}
      </div>

      {/* Grain léger pour casser les bandes de gradient */}
      <div
        aria-hidden
        className="absolute inset-0 pointer-events-none"
        style={{
          backgroundImage: "radial-gradient(rgba(255,255,255,0.04) 1px, transparent 1px)",
          backgroundSize: "3px 3px",
          opacity: 0.35,
          mixBlendMode: "overlay",
        }}
      />
    </section>
  );
};
