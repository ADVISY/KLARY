interface Orb {
  size: number;       // px
  color: string;      // hsl(...) sans le hsl()
  x: string;          // CSS pos (left)
  y: string;          // CSS pos (top)
  blur: number;
  delay: number;      // anim delay (s)
  duration: number;   // anim duration (s)
  opacity: number;
}

interface FloatingOrbsProps {
  orbs?: Orb[];
  variant?: "warm" | "navy";
}

const presetWarm: Orb[] = [
  { size: 360, color: "19 90% 54%", x: "8%",  y: "12%", blur: 50, delay: 0,   duration: 11, opacity: 0.45 },
  { size: 260, color: "28 95% 65%", x: "82%", y: "18%", blur: 40, delay: 1.5, duration: 9,  opacity: 0.35 },
  { size: 420, color: "244 65% 38%", x: "65%", y: "78%", blur: 60, delay: 0.8, duration: 13, opacity: 0.50 },
  { size: 180, color: "19 95% 60%", x: "20%", y: "85%", blur: 35, delay: 2.4, duration: 10, opacity: 0.30 },
];

const presetNavy: Orb[] = [
  { size: 320, color: "244 80% 50%", x: "12%", y: "20%", blur: 60, delay: 0,   duration: 12, opacity: 0.55 },
  { size: 240, color: "19 90% 54%",  x: "78%", y: "30%", blur: 50, delay: 1.8, duration: 10, opacity: 0.40 },
  { size: 380, color: "258 70% 50%", x: "55%", y: "82%", blur: 70, delay: 0.6, duration: 14, opacity: 0.45 },
];

export const FloatingOrbs = ({ variant = "warm", orbs }: FloatingOrbsProps) => {
  const used = orbs ?? (variant === "navy" ? presetNavy : presetWarm);
  return (
    <div aria-hidden className="pointer-events-none absolute inset-0 overflow-hidden z-0">
      {used.map((o, i) => (
        <span
          key={i}
          className="absolute rounded-full"
          style={{
            width: o.size,
            height: o.size,
            left: o.x,
            top: o.y,
            transform: "translate(-50%, -50%)",
            background: `radial-gradient(circle at center, hsl(${o.color} / ${o.opacity}), transparent 65%)`,
            filter: `blur(${o.blur}px)`,
            animation: `kx-orb-float ${o.duration}s ease-in-out ${o.delay}s infinite`,
            willChange: "transform, opacity",
          }}
        />
      ))}
    </div>
  );
};
