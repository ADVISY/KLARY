import { CSSProperties, ReactNode } from "react";
import { useReveal } from "./hooks/useReveal";

interface RevealProps {
  children: ReactNode;
  delay?: number;
  y?: number;
  duration?: number;
  className?: string;
  as?: "div" | "section" | "li" | "article" | "header" | "h1" | "h2" | "h3" | "p" | "span";
  // Force la variante : 'default' (translateY + scale + blur), 'fade' (opacity only), 'lift' (gros déplacement)
  variant?: "default" | "fade" | "lift";
}

/**
 * Wrap any node with a scroll-triggered reveal animation.
 * Default: opacity + translateY + scale + blur cascade (premium feel).
 * Use `delay` (ms) for staggered cascades on grids.
 */
export const Reveal = ({
  children,
  delay = 0,
  y = 40,
  duration = 900,
  className = "",
  as = "div",
  variant = "default",
}: RevealProps) => {
  const { ref, visible } = useReveal<HTMLDivElement>();

  let initialTransform = `translateY(${y}px) scale(0.96)`;
  let initialFilter = "blur(8px)";
  if (variant === "fade") {
    initialTransform = "none";
    initialFilter = "none";
  } else if (variant === "lift") {
    initialTransform = `translateY(${y * 1.5}px) scale(0.92)`;
    initialFilter = "blur(12px)";
  }

  const style: CSSProperties = {
    opacity: visible ? 1 : 0,
    transform: visible ? "translateY(0) scale(1)" : initialTransform,
    filter: visible ? "blur(0)" : initialFilter,
    transition: `opacity ${duration}ms cubic-bezier(0.16,1,0.3,1) ${delay}ms, transform ${duration}ms cubic-bezier(0.16,1,0.3,1) ${delay}ms, filter ${Math.max(400, duration * 0.6)}ms ease-out ${delay}ms`,
    willChange: "transform, opacity, filter",
  };
  const Tag = as as keyof JSX.IntrinsicElements;
  return (
    <Tag ref={ref as any} className={className} style={style}>
      {children}
    </Tag>
  );
};
