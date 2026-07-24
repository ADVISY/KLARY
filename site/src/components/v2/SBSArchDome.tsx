interface SBSArchDomeProps {
  /** Color of the section ABOVE the dome (top edge) */
  from?: "light" | "dark";
  /** Color of the section BELOW the dome (bottom edge) */
  to?: "light" | "dark";
  /** Glow accent inside the dome */
  glow?: "navy" | "orange" | "mix";
  /** Height in px (default 320) */
  height?: number;
}

const DARK = "hsl(244 60% 9%)";   // matches FinalCta/SolutionSection bg
const LIGHT = "hsl(35 30% 96%)";  // matches page cream bg

/**
 * SBS-style arch dome bridging two adjacent sections (light ↔ dark).
 * The transition zone has a vertical linear gradient (from → to) plus a curved
 * "dome" radial gradient with brand glow at the transition point.
 *
 *   <SBSArchDome from="dark" to="light" glow="orange" />  // exit dark section
 *   <SBSArchDome from="light" to="dark" glow="mix" />     // enter dark section
 */
export const SBSArchDome = ({
  from = "light",
  to = "dark",
  glow = "mix",
  height = 320,
}: SBSArchDomeProps) => {
  const fromColor = from === "dark" ? DARK : LIGHT;
  const toColor = to === "dark" ? DARK : LIGHT;

  const glowColors = (() => {
    switch (glow) {
      case "navy":
        return {
          core: "hsl(244 80% 55%)",
          mid:  "hsl(244 70% 35%)",
        };
      case "orange":
        return {
          core: "hsl(28 95% 65%)",
          mid:  "hsl(19 90% 50%)",
        };
      case "mix":
      default:
        return {
          core: "hsl(19 90% 54%)",
          mid:  "hsl(244 70% 40%)",
        };
    }
  })();

  // Dome arches DOWN if going dark→light (dark section curves out)
  // Dome arches UP   if going light→dark (dark section emerges upward)
  const isDarkBelow = to === "dark";

  return (
    <div
      aria-hidden
      className="relative w-full pointer-events-none overflow-hidden"
      style={{ height }}
    >
      {/* Linear vertical fade — base color transition */}
      <div
        className="absolute inset-0"
        style={{
          background: `linear-gradient(180deg, ${fromColor} 0%, ${toColor} 100%)`,
        }}
      />

      {/* The "dome" — a wide ellipse positioned at the dark side */}
      <div
        className="absolute inset-0"
        style={{
          background: isDarkBelow
            ? // dark is below → dome shape rises FROM bottom
              `radial-gradient(
                ellipse 90% 130% at 50% 100%,
                ${glowColors.core} 0%,
                ${glowColors.mid} 22%,
                ${DARK} 45%,
                transparent 75%
              )`
            : // dark is above → dome shape dips FROM top
              `radial-gradient(
                ellipse 90% 130% at 50% 0%,
                ${glowColors.core} 0%,
                ${glowColors.mid} 22%,
                ${DARK} 45%,
                transparent 75%
              )`,
        }}
      />

      {/* Outer soft halo to feather edges */}
      <div
        className="absolute inset-0"
        style={{
          background: isDarkBelow
            ? `radial-gradient(ellipse 110% 75% at 50% 100%, ${glowColors.core}40, transparent 65%)`
            : `radial-gradient(ellipse 110% 75% at 50% 0%, ${glowColors.core}40, transparent 65%)`,
          filter: "blur(24px)",
        }}
      />

      {/* Subtle noise */}
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
