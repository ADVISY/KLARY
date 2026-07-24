import { useEffect, useState } from "react";

/**
 * Thin scroll progress bar — fixed at the very top of the page.
 * Fills with the brand accent color as the user scrolls down.
 */
export const ScrollProgress = () => {
  const [progress, setProgress] = useState(0);

  useEffect(() => {
    let raf = 0;
    const compute = () => {
      const h = document.documentElement;
      const max = (h.scrollHeight - h.clientHeight) || 1;
      const pct = Math.min(100, Math.max(0, (h.scrollTop / max) * 100));
      setProgress(pct);
    };
    const onScroll = () => {
      cancelAnimationFrame(raf);
      raf = requestAnimationFrame(compute);
    };
    compute();
    window.addEventListener("scroll", onScroll, { passive: true });
    window.addEventListener("resize", onScroll);
    return () => {
      cancelAnimationFrame(raf);
      window.removeEventListener("scroll", onScroll);
      window.removeEventListener("resize", onScroll);
    };
  }, []);

  return (
    <div
      aria-hidden
      className="fixed top-0 left-0 right-0 z-[200] pointer-events-none"
      style={{ height: "3px", background: "rgba(255, 255, 255, 0.06)" }}
    >
      <div
        style={{
          height: "100%",
          width: `${progress}%`,
          background: "linear-gradient(90deg, hsl(19 90% 54%), hsl(28 95% 65%))",
          boxShadow: "0 0 10px hsl(19 90% 54% / 0.6)",
          transition: "width 60ms linear",
          willChange: "width",
        }}
      />
    </div>
  );
};
