import { useEffect, useRef } from "react";

interface MouseSpotlightProps {
  className?: string;
  color?: string;
  size?: number;
  blur?: number;
  opacity?: number;
}

/**
 * Curseur spotlight — un radial gradient suit la souris dans le parent (qui doit être position:relative).
 * S'auto-désactive sur touch / petit écran.
 */
export const MouseSpotlight = ({
  className = "",
  color = "240, 101, 31", // accent KLARY rgb
  size = 520,
  blur = 80,
  opacity = 0.18,
}: MouseSpotlightProps) => {
  const ref = useRef<HTMLDivElement | null>(null);
  const rafId = useRef<number | null>(null);

  useEffect(() => {
    const el = ref.current;
    if (!el) return;
    const parent = el.parentElement;
    if (!parent) return;

    // Skip on touch devices
    if (typeof window !== "undefined" && window.matchMedia?.("(hover: none)").matches) {
      el.style.display = "none";
      return;
    }

    const handleMove = (e: MouseEvent) => {
      const rect = parent.getBoundingClientRect();
      const x = e.clientX - rect.left;
      const y = e.clientY - rect.top;
      if (rafId.current) cancelAnimationFrame(rafId.current);
      rafId.current = requestAnimationFrame(() => {
        el.style.background = `radial-gradient(${size}px circle at ${x}px ${y}px, rgba(${color}, ${opacity}), transparent 70%)`;
        el.style.opacity = "1";
      });
    };

    const handleLeave = () => {
      el.style.opacity = "0";
    };

    parent.addEventListener("mousemove", handleMove);
    parent.addEventListener("mouseleave", handleLeave);
    el.style.transition = "opacity 220ms ease-out";
    el.style.opacity = "0";

    return () => {
      parent.removeEventListener("mousemove", handleMove);
      parent.removeEventListener("mouseleave", handleLeave);
      if (rafId.current) cancelAnimationFrame(rafId.current);
    };
  }, [color, size, blur, opacity]);

  return (
    <div
      ref={ref}
      aria-hidden
      className={`pointer-events-none absolute inset-0 z-[1] ${className}`}
      style={{
        mixBlendMode: "plus-lighter",
      }}
    />
  );
};
