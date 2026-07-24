import { CSSProperties } from "react";

interface KlaryLogoSvgProps {
  className?: string;
  style?: CSSProperties;
  /** Animate parts in with stagger when true. False = static logo. */
  animateIn?: boolean;
  /** Base delay before the first part starts (ms) */
  startDelay?: number;
  /** Color overrides */
  navyLight?: string;
  navyDark?: string;
  orange?: string;
}

/**
 * SVG reconstruction of the KLARY icon (no white background, separate components).
 * Each stripe and petal is its own element so we can animate them individually.
 *
 * Layout reference (200x200 viewBox):
 *  - 3 light-navy diagonal stripes (top → bottom-left slope) on the left half
 *  - 2 dark-navy diagonal stripes (top-left → bottom-right slope) at the bottom-center
 *  - 4 orange petals clustered to the right
 */
export const KlaryLogoSvg = ({
  className = "",
  style,
  animateIn = false,
  startDelay = 0,
  navyLight = "#1A1660",
  navyDark = "#0D2D5C",
  orange = "#F0651F",
}: KlaryLogoSvgProps) => {
  // Each part: timing in ms relative to `startDelay`
  const parts = {
    stripe1: { delay: 0,    anim: "kx-stripe-drop" },
    stripe2: { delay: 110,  anim: "kx-stripe-drop" },
    stripe3: { delay: 220,  anim: "kx-stripe-drop" },
    dark1:   { delay: 360,  anim: "kx-stripe-rise" },
    dark2:   { delay: 460,  anim: "kx-stripe-rise" },
    petal1:  { delay: 600,  anim: "kx-petal-pop" },
    petal2:  { delay: 700,  anim: "kx-petal-pop" },
    petal3:  { delay: 800,  anim: "kx-petal-pop" },
    petal4:  { delay: 900,  anim: "kx-petal-pop" },
  };

  const styleFor = (key: keyof typeof parts): CSSProperties => {
    if (!animateIn) return {};
    const p = parts[key];
    return {
      opacity: 0,
      animation: `${p.anim} 0.7s cubic-bezier(0.34, 1.56, 0.64, 1) ${startDelay + p.delay}ms forwards`,
    };
  };

  return (
    <svg
      viewBox="0 0 200 200"
      xmlns="http://www.w3.org/2000/svg"
      className={className}
      style={style}
      fill="none"
    >
      {/* 3 light-navy diagonal stripes (curved at the bottom-left) */}
      <g stroke={navyLight} strokeWidth="24" strokeLinecap="round" fill="none">
        <path
          d="M 70 18 L 30 130 Q 28 145 35 158"
          style={{ ...styleFor("stripe1"), transformOrigin: "70px 18px" }}
        />
        <path
          d="M 112 18 L 72 130 Q 70 145 77 158"
          style={{ ...styleFor("stripe2"), transformOrigin: "112px 18px" }}
        />
        <path
          d="M 154 18 L 114 130 Q 112 145 119 158"
          style={{ ...styleFor("stripe3"), transformOrigin: "154px 18px" }}
        />
      </g>

      {/* 2 darker navy stripes (lower-center, opposite slope) */}
      <g stroke={navyDark} strokeWidth="22" strokeLinecap="round" fill="none">
        <line
          x1="76" y1="96" x2="116" y2="182"
          style={{ ...styleFor("dark1"), transformOrigin: "76px 96px" }}
        />
        <line
          x1="106" y1="96" x2="146" y2="182"
          style={{ ...styleFor("dark2"), transformOrigin: "106px 96px" }}
        />
      </g>

      {/* 4 orange petals */}
      <g fill={orange}>
        <ellipse
          cx="146" cy="62" rx="14" ry="9"
          transform="rotate(-32 146 62)"
          style={{ ...styleFor("petal1"), transformOrigin: "146px 62px" }}
        />
        <ellipse
          cx="170" cy="100" rx="15" ry="9.5"
          transform="rotate(-8 170 100)"
          style={{ ...styleFor("petal2"), transformOrigin: "170px 100px" }}
        />
        <ellipse
          cx="146" cy="128" rx="15" ry="9.5"
          transform="rotate(28 146 128)"
          style={{ ...styleFor("petal3"), transformOrigin: "146px 128px" }}
        />
        <ellipse
          cx="172" cy="155" rx="13" ry="8.5"
          transform="rotate(58 172 155)"
          style={{ ...styleFor("petal4"), transformOrigin: "172px 155px" }}
        />
      </g>
    </svg>
  );
};
