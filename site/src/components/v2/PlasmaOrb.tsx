import { CSSProperties } from "react";

interface PlasmaOrbProps {
  size?: number;
  className?: string;
  style?: CSSProperties;
  /** "orange" or "navy" variant */
  variant?: "orange" | "navy" | "violet";
}

/**
 * SBS-style plasma orb — animated glowing sphere of energy.
 * Pure CSS+SVG, GPU-accelerated. Uses KLARY palette (orange/navy/violet).
 *
 * Built lighter than v1: only 2 rotating SVG layers + 1 pulse glow.
 */
export const PlasmaOrb = ({
  size = 360,
  className = "",
  style,
  variant = "orange",
}: PlasmaOrbProps) => {
  const colors = (() => {
    switch (variant) {
      case "navy":
        return { core: "hsl(244 85% 75%)", mid: "hsl(244 80% 45%)", ring: "hsl(244 70% 25%)" };
      case "violet":
        return { core: "hsl(280 80% 75%)", mid: "hsl(280 65% 50%)", ring: "hsl(280 60% 28%)" };
      case "orange":
      default:
        return { core: "hsl(28 100% 70%)", mid: "hsl(19 95% 55%)", ring: "hsl(15 90% 45%)" };
    }
  })();

  return (
    <div
      aria-hidden
      className={`relative ${className}`}
      style={{ width: size, height: size, ...style }}
    >
      {/* Soft outer pulse glow */}
      <div
        className="absolute inset-0 rounded-full"
        style={{
          background: `radial-gradient(circle, ${colors.ring}55 0%, transparent 65%)`,
          animation: "kx-orb-pulse 5s ease-in-out infinite",
          willChange: "opacity, transform",
        }}
      />

      {/* Inner energy ball */}
      <div
        className="absolute inset-[15%] rounded-full"
        style={{
          background: `radial-gradient(circle at 35% 30%, ${colors.core} 0%, ${colors.mid} 40%, ${colors.ring} 75%, transparent 95%)`,
          boxShadow: `0 0 80px ${colors.mid}66, 0 0 40px ${colors.core}99`,
          animation: "kx-orb-pulse 4s ease-in-out infinite 0.5s",
          willChange: "opacity, transform",
        }}
      />

      {/* Rotating energy bands */}
      <svg
        viewBox="0 0 200 200"
        className="absolute inset-0 w-full h-full"
        style={{ animation: "kx-orb-rotate 22s linear infinite", willChange: "transform" }}
      >
        <defs>
          <radialGradient id={`kx-orb-${variant}`} cx="50%" cy="50%" r="50%">
            <stop offset="60%" stopColor={colors.core} stopOpacity="0" />
            <stop offset="78%" stopColor={colors.core} stopOpacity="0.65" />
            <stop offset="82%" stopColor={colors.core} stopOpacity="0.9" />
            <stop offset="88%" stopColor={colors.core} stopOpacity="0.2" />
            <stop offset="100%" stopColor={colors.core} stopOpacity="0" />
          </radialGradient>
        </defs>
        <ellipse cx="100" cy="100" rx="92" ry="32" fill={`url(#kx-orb-${variant})`} transform="rotate(20 100 100)" />
        <ellipse cx="100" cy="100" rx="92" ry="22" fill={`url(#kx-orb-${variant})`} transform="rotate(-30 100 100)" opacity="0.7" />
        <ellipse cx="100" cy="100" rx="86" ry="14" fill={`url(#kx-orb-${variant})`} transform="rotate(75 100 100)" opacity="0.5" />
      </svg>

      {/* Bright highlight */}
      <div
        className="absolute"
        style={{
          left: "32%", top: "28%",
          width: "14%", height: "14%",
          background: `radial-gradient(circle, white 0%, ${colors.core} 60%, transparent 100%)`,
          opacity: 0.7,
        }}
      />
    </div>
  );
};
