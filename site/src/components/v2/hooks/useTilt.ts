import { useRef, useCallback, useEffect } from "react";

interface UseTiltOptions {
  max?: number;
  scale?: number;
  speed?: number;
}

export const useTilt = <T extends HTMLElement = HTMLDivElement>({
  max = 8,
  scale = 1.015,
  speed = 350,
}: UseTiltOptions = {}) => {
  const ref = useRef<T | null>(null);
  const rafId = useRef<number | null>(null);

  const handleMove = useCallback(
    (e: MouseEvent) => {
      const el = ref.current;
      if (!el) return;

      const rect = el.getBoundingClientRect();
      const cx = rect.left + rect.width / 2;
      const cy = rect.top + rect.height / 2;
      const dx = (e.clientX - cx) / (rect.width / 2);
      const dy = (e.clientY - cy) / (rect.height / 2);

      if (rafId.current) cancelAnimationFrame(rafId.current);
      rafId.current = requestAnimationFrame(() => {
        el.style.transform = `perspective(900px) rotateX(${(-dy * max).toFixed(2)}deg) rotateY(${(dx * max).toFixed(2)}deg) scale(${scale})`;
        el.style.transition = `transform 60ms linear`;
      });
    },
    [max, scale]
  );

  const handleLeave = useCallback(() => {
    const el = ref.current;
    if (!el) return;
    if (rafId.current) cancelAnimationFrame(rafId.current);
    el.style.transition = `transform ${speed}ms cubic-bezier(0.16, 1, 0.3, 1)`;
    el.style.transform = `perspective(900px) rotateX(0deg) rotateY(0deg) scale(1)`;
  }, [speed]);

  useEffect(() => {
    const el = ref.current;
    if (!el) return;
    el.addEventListener("mousemove", handleMove);
    el.addEventListener("mouseleave", handleLeave);
    el.style.willChange = "transform";
    return () => {
      el.removeEventListener("mousemove", handleMove);
      el.removeEventListener("mouseleave", handleLeave);
      if (rafId.current) cancelAnimationFrame(rafId.current);
    };
  }, [handleMove, handleLeave]);

  return { ref };
};
