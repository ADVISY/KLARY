import { useEffect, useRef, useState } from "react";

interface ScrambleTextProps {
  text: string;
  className?: string;
  style?: React.CSSProperties;
  duration?: number;
}

/**
 * Soft per-character crossfade.
 * Each character of the OLD text fades out, each character of the NEW text fades in,
 * with a slight stagger from left to right. No random / intermediate characters.
 */
export const ScrambleText = ({
  text,
  className,
  style,
  duration = 700,
}: ScrambleTextProps) => {
  const [progress, setProgress] = useState(1);
  const [from, setFrom] = useState(text);
  const [to, setTo] = useState(text);
  const frameRef = useRef<number>();
  const prevText = useRef(text);

  useEffect(() => {
    if (prevText.current === text) return;
    setFrom(prevText.current);
    setTo(text);
    prevText.current = text;

    const start = performance.now();
    const tick = (now: number) => {
      const p = Math.min(1, (now - start) / duration);
      setProgress(p);
      if (p < 1) frameRef.current = requestAnimationFrame(tick);
    };
    setProgress(0);
    frameRef.current = requestAnimationFrame(tick);
    return () => {
      if (frameRef.current) cancelAnimationFrame(frameRef.current);
    };
  }, [text, duration]);

  const maxLen = Math.max(from.length, to.length);
  const stagger = 0.35; // portion of duration spread across characters

  return (
    <span className={className} style={style}>
      <span className="relative inline-block whitespace-pre">
        {/* Sizing layer (invisible) — keeps width = longest of old/new */}
        <span className="invisible">
          {to.length >= from.length ? to : from}
        </span>

        {/* Old text fading out */}
        <span className="absolute inset-0 whitespace-pre" aria-hidden="true">
          {Array.from(from).map((ch, i) => {
            const charStart = (i / Math.max(maxLen, 1)) * stagger;
            const charProgress = Math.max(
              0,
              Math.min(1, (progress - charStart) / (1 - stagger))
            );
            return (
              <span
                key={`out-${i}`}
                style={{ opacity: 1 - charProgress, display: "inline-block" }}
              >
                {ch}
              </span>
            );
          })}
        </span>

        {/* New text fading in */}
        <span className="absolute inset-0 whitespace-pre">
          {Array.from(to).map((ch, i) => {
            const charStart = (i / Math.max(maxLen, 1)) * stagger;
            const charProgress = Math.max(
              0,
              Math.min(1, (progress - charStart) / (1 - stagger))
            );
            return (
              <span
                key={`in-${i}`}
                style={{ opacity: charProgress, display: "inline-block" }}
              >
                {ch}
              </span>
            );
          })}
        </span>
      </span>
    </span>
  );
};
