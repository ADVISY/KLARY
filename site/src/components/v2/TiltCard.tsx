import { CSSProperties, ReactNode, useEffect, useRef } from "react";

interface TiltCardProps {
  children: ReactNode;
  className?: string;
  style?: CSSProperties;
  max?: number;
  glow?: boolean;
  glowColor?: string;
  href?: string;
  onClick?: () => void;
  as?: "div" | "a" | "button" | "article" | "li" | "figure";
}

/**
 * Card wrapper with 3D tilt-on-hover + optional inner glow that follows the mouse.
 * GPU-accelerated, falls back to no-op on touch devices.
 */
export const TiltCard = ({
  children,
  className = "",
  style,
  max = 6,
  glow = true,
  glowColor = "240, 101, 31",
  href,
  onClick,
  as = "div",
}: TiltCardProps) => {
  const ref = useRef<HTMLDivElement | null>(null);
  const glowRef = useRef<HTMLDivElement | null>(null);
  const rafId = useRef<number | null>(null);

  useEffect(() => {
    const el = ref.current;
    if (!el) return;
    if (typeof window !== "undefined" && window.matchMedia?.("(hover: none)").matches) return;

    const handleMove = (e: MouseEvent) => {
      const rect = el.getBoundingClientRect();
      const x = e.clientX - rect.left;
      const y = e.clientY - rect.top;
      const dx = (x - rect.width / 2) / (rect.width / 2);
      const dy = (y - rect.height / 2) / (rect.height / 2);

      if (rafId.current) cancelAnimationFrame(rafId.current);
      rafId.current = requestAnimationFrame(() => {
        el.style.transform = `perspective(900px) rotateX(${(-dy * max).toFixed(2)}deg) rotateY(${(dx * max).toFixed(2)}deg) translateZ(0) scale(1.02)`;
        if (glow && glowRef.current) {
          glowRef.current.style.background = `radial-gradient(circle 280px at ${x}px ${y}px, rgba(${glowColor}, 0.32), transparent 65%)`;
          glowRef.current.style.opacity = "1";
        }
      });
    };

    const handleLeave = () => {
      if (rafId.current) cancelAnimationFrame(rafId.current);
      el.style.transition = "transform 500ms cubic-bezier(0.16, 1, 0.3, 1)";
      el.style.transform = `perspective(900px) rotateX(0deg) rotateY(0deg) translateZ(0) scale(1)`;
      if (glow && glowRef.current) {
        glowRef.current.style.opacity = "0";
      }
      setTimeout(() => {
        if (el) el.style.transition = "";
      }, 520);
    };

    const handleEnter = () => {
      el.style.transition = "transform 80ms linear";
    };

    el.addEventListener("mouseenter", handleEnter);
    el.addEventListener("mousemove", handleMove);
    el.addEventListener("mouseleave", handleLeave);
    el.style.transformStyle = "preserve-3d";
    el.style.willChange = "transform";

    return () => {
      el.removeEventListener("mouseenter", handleEnter);
      el.removeEventListener("mousemove", handleMove);
      el.removeEventListener("mouseleave", handleLeave);
      if (rafId.current) cancelAnimationFrame(rafId.current);
    };
  }, [glow, glowColor, max]);

  const Tag = as as keyof JSX.IntrinsicElements;

  return (
    <Tag
      ref={ref as any}
      className={`relative ${className}`}
      style={style}
      href={href as any}
      onClick={onClick as any}
    >
      {glow && (
        <span
          ref={glowRef}
          aria-hidden
          className="pointer-events-none absolute inset-0 rounded-[inherit] opacity-0 transition-opacity duration-300 z-[1]"
          style={{ mixBlendMode: "plus-lighter" }}
        />
      )}
      <span className="relative z-[2] block h-full w-full" style={{ display: "contents" }}>
        {children}
      </span>
    </Tag>
  );
};
