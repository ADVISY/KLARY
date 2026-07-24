import { useEffect, useRef, useState } from "react";
import { useReveal } from "./useReveal";

interface UseCountUpOptions {
  end: number;
  duration?: number;
  start?: number;
  decimals?: number;
  prefix?: string;
  suffix?: string;
  separator?: string;
  formatter?: (n: number) => string;
  trigger?: "view" | "mount";
}

// Smooth easing (easeOutExpo)
const easeOutExpo = (t: number) => (t === 1 ? 1 : 1 - Math.pow(2, -10 * t));

const defaultFormat = (n: number, decimals: number, separator: string) => {
  const fixed = n.toFixed(decimals);
  const [intPart, decPart] = fixed.split(".");
  const formattedInt = intPart.replace(/\B(?=(\d{3})+(?!\d))/g, separator);
  return decPart ? `${formattedInt}.${decPart}` : formattedInt;
};

export const useCountUp = ({
  end,
  duration = 1800,
  start = 0,
  decimals = 0,
  prefix = "",
  suffix = "",
  separator = "'",
  formatter,
  trigger = "view",
}: UseCountUpOptions) => {
  const { ref, visible } = useReveal<HTMLSpanElement>({ once: true });
  const [value, setValue] = useState(trigger === "mount" ? start : start);
  const startedRef = useRef(false);

  useEffect(() => {
    if (trigger === "mount" || visible) {
      if (startedRef.current) return;
      startedRef.current = true;

      const startTime = performance.now();
      let frameId = 0;

      const tick = (now: number) => {
        const elapsed = now - startTime;
        const progress = Math.min(elapsed / duration, 1);
        const eased = easeOutExpo(progress);
        setValue(start + (end - start) * eased);
        if (progress < 1) {
          frameId = requestAnimationFrame(tick);
        }
      };

      frameId = requestAnimationFrame(tick);
      return () => cancelAnimationFrame(frameId);
    }
  }, [visible, trigger, duration, end, start]);

  const formatted = formatter
    ? formatter(value)
    : `${prefix}${defaultFormat(value, decimals, separator)}${suffix}`;

  return { ref, value, formatted };
};
