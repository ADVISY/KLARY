import { useEffect, useRef, useState } from "react";
import { PhoneFrame } from "./PhoneFrame";
import { DashboardScreen } from "./screens/DashboardScreen";
import { SimulatorScreen } from "./screens/SimulatorScreen";
import { AlertScreen } from "./screens/AlertScreen";
import { ReportScreen } from "./screens/ReportScreen";
import { EspaceClientScreen } from "./screens/EspaceClientScreen";

const screens = [
  { id: "dashboard", Comp: DashboardScreen, label: "Mes contrats" },
  { id: "espace", Comp: EspaceClientScreen, label: "Espace client" },
  { id: "simulator", Comp: SimulatorScreen, label: "Simulateur" },
  { id: "alert", Comp: AlertScreen, label: "Optimisations" },
  { id: "report", Comp: ReportScreen, label: "Rapport" },
];

const CYCLE_MS = 3500;

export const PhoneMockup3D = () => {
  const [idx, setIdx] = useState(0);
  const wrapRef = useRef<HTMLDivElement | null>(null);

  useEffect(() => {
    const t = setInterval(() => setIdx((i) => (i + 1) % screens.length), CYCLE_MS);
    return () => clearInterval(t);
  }, []);

  // Subtle mouse-tilt — gentle, capped
  useEffect(() => {
    const el = wrapRef.current;
    if (!el) return;
    if (typeof window !== "undefined" && window.matchMedia?.("(hover: none)").matches) return;

    let rafId: number | null = null;
    const handle = (e: MouseEvent) => {
      const rect = el.getBoundingClientRect();
      const dx = (e.clientX - (rect.left + rect.width / 2)) / (rect.width / 2);
      const dy = (e.clientY - (rect.top + rect.height / 2)) / (rect.height / 2);
      if (rafId) cancelAnimationFrame(rafId);
      rafId = requestAnimationFrame(() => {
        el.style.transform = `perspective(1200px) rotateX(${(-dy * 3).toFixed(2)}deg) rotateY(${(dx * 5).toFixed(2)}deg) translateZ(0)`;
      });
    };
    const leave = () => {
      if (rafId) cancelAnimationFrame(rafId);
      el.style.transform = `perspective(1200px) rotateX(0deg) rotateY(-4deg) translateZ(0)`;
    };

    // Initial slight tilt
    el.style.transition = "transform 600ms cubic-bezier(0.16,1,0.3,1)";
    el.style.transform = `perspective(1200px) rotateX(0deg) rotateY(-4deg) translateZ(0)`;
    el.style.willChange = "transform";

    const parent = el.parentElement;
    parent?.addEventListener("mousemove", handle);
    parent?.addEventListener("mouseleave", leave);
    return () => {
      parent?.removeEventListener("mousemove", handle);
      parent?.removeEventListener("mouseleave", leave);
      if (rafId) cancelAnimationFrame(rafId);
    };
  }, []);

  return (
    <div className="relative" style={{ perspective: "1200px" }}>
      <div ref={wrapRef} className="relative">
        <PhoneFrame>
          {screens.map(({ id, Comp }, i) => {
            const isActive = i === idx;
            const offset = i - idx;
            const translateX = isActive ? 0 : offset > 0 ? 100 : -100;
            return (
              <div
                key={id}
                className="absolute inset-0 transition-all duration-[650ms]"
                style={{
                  opacity: isActive ? 1 : 0,
                  transform: `translateX(${translateX}%) scale(${isActive ? 1 : 0.96})`,
                  pointerEvents: isActive ? "auto" : "none",
                  transitionTimingFunction: "cubic-bezier(0.32, 0.72, 0, 1)",
                  willChange: "transform, opacity",
                }}
              >
                <Comp />
              </div>
            );
          })}
        </PhoneFrame>
      </div>

      {/* Tab indicators below phone */}
      <div className="mt-8 flex items-center justify-center gap-1.5">
        {screens.map((s, i) => (
          <button
            key={s.id}
            type="button"
            onClick={() => setIdx(i)}
            className="group flex flex-col items-center gap-1.5"
            aria-label={s.label}
          >
            <span
              className="block h-[3px] rounded-full transition-all duration-500"
              style={{
                width: i === idx ? 28 : 16,
                background: i === idx ? "hsl(var(--accent))" : "rgba(255, 255, 255, 0.30)",
              }}
            />
            <span
              className="text-[10px] uppercase tracking-wider font-semibold transition-colors duration-300"
              style={{
                color: i === idx ? "rgba(255,255,255,0.95)" : "rgba(255,255,255,0.50)",
              }}
            >
              {s.label}
            </span>
          </button>
        ))}
      </div>
    </div>
  );
};
