import { useEffect, useRef } from "react";

/**
 * Canvas fixe full-viewport posé derrière tout le contenu.
 * Cross-fade entre 5 palettes de gradient, piloté par la progression de scroll.
 * Plus 3 orbes parallax qui dérivent et changent d'opacité.
 *
 * Pour que ce fond soit visible, les sections au-dessus doivent être bg-transparent.
 */

type Layer = { stop: number; bg: string };

const LAYERS: Layer[] = [
  {
    // 0.00 — Crème chaude (sortie de hero, début sections)
    stop: 0,
    bg: `radial-gradient(1400px 90vh at 50% -10%, #FFE7C9 0%, #FAF5EA 35%, #F3EFE7 80%, #F3EFE7 100%),
         linear-gradient(180deg, #FAF5EA 0%, #F3EFE7 100%)`,
  },
  {
    // 0.25 — Warm peach (sections problème / before-after)
    stop: 0.25,
    bg: `radial-gradient(1300px 100vh at 25% 30%, #FFE0BB 0%, #FBE5CC 35%, #F4EADB 75%, #F3EFE7 100%),
         radial-gradient(1100px 80vh at 80% 60%, #FFD4A6 0%, #FAE2C8 40%, transparent 75%)`,
  },
  {
    // 0.5 — Rose poudré chaud (autour de Coverages / Process)
    stop: 0.5,
    bg: `radial-gradient(1400px 100vh at 30% 40%, #FFCFB5 0%, #FDC4B8 30%, #F5C3CC 60%, #EDD0DE 85%, #F3EFE7 100%),
         radial-gradient(1100px 80vh at 80% 70%, #F0CFD8 0%, #EDDFE7 60%, transparent 100%)`,
  },
  {
    // 0.75 — Lavande douce (Testimonials / Partners / FAQ)
    stop: 0.75,
    bg: `radial-gradient(1300px 90vh at 50% 50%, #E2D9F2 0%, #ECE2EF 40%, #F3EFE7 100%),
         radial-gradient(900px 70vh at 20% 30%, #DCD4F0 0%, transparent 65%)`,
  },
  {
    // 1.0 — Navy profond (footer prend le relais)
    stop: 1,
    bg: `radial-gradient(1400px 90vh at 50% 110%, #1A1660 0%, #100D32 60%, #0A0820 100%),
         linear-gradient(180deg, #6D3A78 0%, #1A1660 80%)`,
  },
];

const SPAN = 0.28; // largeur de la "zone visible" autour de chaque stop

export const ScrollAmbient = () => {
  const rootRef = useRef<HTMLDivElement | null>(null);
  const layerRefs = useRef<(HTMLDivElement | null)[]>([]);
  const orbRefs = useRef<{
    orange: HTMLDivElement | null;
    violet: HTMLDivElement | null;
    navy: HTMLDivElement | null;
    halo: HTMLDivElement | null;
  }>({ orange: null, violet: null, navy: null, halo: null });

  useEffect(() => {
    let raf = 0;

    const update = () => {
      raf = 0;
      const max = document.documentElement.scrollHeight - window.innerHeight;
      const p = max > 0 ? Math.min(1, Math.max(0, window.scrollY / max)) : 0;

      // Opacité gaussienne sur chaque couche
      layerRefs.current.forEach((el, i) => {
        if (!el) return;
        const stop = LAYERS[i].stop;
        const dist = Math.abs(p - stop);
        const t = Math.max(0, 1 - dist / SPAN);
        // Easing : smoothstep
        const op = t * t * (3 - 2 * t);
        el.style.opacity = op.toFixed(3);
      });

      // Orbes parallax
      const orange = orbRefs.current.orange;
      if (orange) {
        const tx = p * 30; // vw
        const ty = p * 220 - 10; // vh
        orange.style.transform = `translate3d(${tx}vw, ${ty}vh, 0)`;
        orange.style.opacity = Math.min(0.85, 0.45 + p * 0.6).toFixed(3);
      }

      const violet = orbRefs.current.violet;
      if (violet) {
        const tx = p * -25;
        const ty = p * 180;
        violet.style.transform = `translate3d(${tx}vw, ${ty}vh, 0)`;
        violet.style.opacity = Math.min(0.9, 0.25 + p * 0.85).toFixed(3);
      }

      const navy = orbRefs.current.navy;
      if (navy) {
        const tx = p * -15;
        const ty = p * 160;
        navy.style.transform = `translate3d(${tx}vw, ${ty}vh, 0)`;
        navy.style.opacity = Math.min(0.85, 0.05 + p * 0.95).toFixed(3);
      }

      const halo = orbRefs.current.halo;
      if (halo) {
        halo.style.opacity = Math.max(0, 1 - p * 2.5).toFixed(3);
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

  return (
    <div
      ref={rootRef}
      aria-hidden
      className="fixed inset-0 pointer-events-none overflow-hidden"
      style={{ zIndex: 0 }}
    >
      {/* Base crème de sécurité */}
      <div className="absolute inset-0" style={{ background: "#F3EFE7" }} />

      {/* Couches gradient cross-fade */}
      {LAYERS.map((l, i) => (
        <div
          key={i}
          ref={(el) => (layerRefs.current[i] = el)}
          className="absolute inset-0"
          style={{
            background: l.bg,
            opacity: 0,
            willChange: "opacity",
          }}
        />
      ))}

      {/* Orbe orange — parallax */}
      <div
        ref={(el) => (orbRefs.current.orange = el)}
        className="absolute -left-[20vw] pointer-events-none"
        style={{
          top: 0,
          width: "70vw",
          height: "70vw",
          borderRadius: "9999px",
          background:
            "radial-gradient(circle at 50% 50%, rgba(240, 101, 31, 0.55) 0%, rgba(240, 101, 31, 0.25) 35%, transparent 70%)",
          filter: "blur(40px)",
          mixBlendMode: "screen",
          willChange: "transform, opacity",
        }}
      />

      {/* Orbe violet */}
      <div
        ref={(el) => (orbRefs.current.violet = el)}
        className="absolute pointer-events-none"
        style={{
          top: "20vh",
          right: "-15vw",
          width: "60vw",
          height: "60vw",
          borderRadius: "9999px",
          background:
            "radial-gradient(circle at 50% 50%, rgba(150, 60, 180, 0.55) 0%, rgba(109, 58, 120, 0.30) 40%, transparent 70%)",
          filter: "blur(50px)",
          mixBlendMode: "screen",
          willChange: "transform, opacity",
        }}
      />

      {/* Orbe navy */}
      <div
        ref={(el) => (orbRefs.current.navy = el)}
        className="absolute pointer-events-none"
        style={{
          top: "50vh",
          left: "30vw",
          width: "60vw",
          height: "60vw",
          borderRadius: "9999px",
          background:
            "radial-gradient(circle at 50% 50%, rgba(58, 45, 136, 0.50) 0%, rgba(26, 22, 96, 0.30) 45%, transparent 75%)",
          filter: "blur(60px)",
          mixBlendMode: "screen",
          willChange: "transform, opacity",
        }}
      />

      {/* Halo blanc du haut — fond le hero */}
      <div
        ref={(el) => (orbRefs.current.halo = el)}
        className="absolute inset-x-0 top-0 h-[60vh] pointer-events-none"
        style={{
          background:
            "radial-gradient(80% 100% at 50% 0%, rgba(255, 255, 255, 0.55) 0%, rgba(255, 255, 255, 0.15) 40%, transparent 80%)",
          willChange: "opacity",
        }}
      />

      {/* Grain subtil */}
      <div
        className="absolute inset-0 pointer-events-none"
        style={{
          backgroundImage:
            "radial-gradient(rgba(255,255,255,0.04) 1px, transparent 1px)",
          backgroundSize: "3px 3px",
          opacity: 0.5,
          mixBlendMode: "overlay",
        }}
      />
    </div>
  );
};
