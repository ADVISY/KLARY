interface SBSGradientProps {
  /** Variant: navy-dominant, orange-dominant, or mixed (default) */
  variant?: "navy" | "orange" | "mix" | "warm";
  /** Height in px (default 220) */
  height?: number;
  /** Negative margin to overlap with neighbors */
  overlap?: number;
}

/**
 * SBS-style gradient band — sits between sections, creates a soft "halo"
 * effect framing the page with KLARY brand colors. Mimics the
 * gradient_upper.webp / gradient_lower.webp pattern from SBS Software.
 */
export const SBSGradient = ({
  variant = "mix",
  height = 220,
  overlap = 60,
}: SBSGradientProps) => {
  const bg = (() => {
    switch (variant) {
      case "navy":
        return `
          radial-gradient(ellipse 80% 100% at 50% 50%, hsl(244 65% 22% / 0.20), transparent 70%),
          radial-gradient(ellipse 60% 80% at 25% 50%, hsl(258 70% 45% / 0.16), transparent 70%),
          radial-gradient(ellipse 50% 70% at 75% 50%, hsl(244 80% 55% / 0.14), transparent 70%)
        `;
      case "orange":
        return `
          radial-gradient(ellipse 80% 100% at 50% 50%, hsl(19 90% 54% / 0.18), transparent 70%),
          radial-gradient(ellipse 60% 80% at 25% 50%, hsl(28 95% 65% / 0.14), transparent 70%),
          radial-gradient(ellipse 50% 70% at 75% 50%, hsl(15 85% 50% / 0.12), transparent 70%)
        `;
      case "warm":
        return `
          radial-gradient(ellipse 80% 100% at 30% 50%, hsl(19 90% 54% / 0.18), transparent 65%),
          radial-gradient(ellipse 70% 90% at 70% 50%, hsl(28 95% 65% / 0.16), transparent 65%),
          radial-gradient(ellipse 50% 60% at 50% 50%, hsl(244 65% 35% / 0.12), transparent 65%)
        `;
      case "mix":
      default:
        return `
          radial-gradient(ellipse 70% 90% at 20% 50%, hsl(244 65% 30% / 0.22), transparent 65%),
          radial-gradient(ellipse 70% 90% at 80% 50%, hsl(19 90% 54% / 0.22), transparent 65%),
          radial-gradient(ellipse 50% 70% at 50% 50%, hsl(258 70% 50% / 0.14), transparent 65%)
        `;
    }
  })();

  return (
    <div
      aria-hidden
      className="relative w-full pointer-events-none overflow-hidden"
      style={{
        height,
        marginTop: -overlap,
        marginBottom: -overlap,
      }}
    >
      {/* Main gradient layer */}
      <div
        className="absolute inset-0"
        style={{
          backgroundImage: bg,
          filter: "blur(24px)",
          willChange: "transform",
          animation: "kx-band-drift 18s ease-in-out infinite",
        }}
      />
      {/* Subtle noise to feel less flat */}
      <div
        className="absolute inset-0 opacity-[0.08] mix-blend-overlay"
        style={{
          backgroundImage:
            "url(\"data:image/svg+xml;utf8,<svg xmlns='http://www.w3.org/2000/svg' width='160' height='160'><filter id='n'><feTurbulence type='fractalNoise' baseFrequency='1.4' numOctaves='2' stitchTiles='stitch'/></filter><rect width='100%' height='100%' filter='url(%23n)'/></svg>\")",
        }}
      />
    </div>
  );
};
