/**
 * Animated scroll-down indicator (like SBS).
 * A vertical "track" with a dot that travels down repeatedly.
 */
export const ScrollIndicator = ({ label = "Faites défiler pour explorer" }: { label?: string }) => {
  return (
    <div className="flex flex-col items-center gap-2.5">
      <span className="text-[10px] uppercase tracking-[0.18em] font-semibold" style={{ color: "inherit" }}>
        {label}
      </span>
      <div className="relative w-[1.5px] h-12 rounded-full overflow-hidden" style={{ background: "rgba(255,255,255,0.20)" }}>
        <span
          aria-hidden
          className="absolute left-1/2 top-0 -translate-x-1/2 w-[3px] h-3 rounded-full"
          style={{
            background: "hsl(var(--accent))",
            animation: "kx-scroll-dot 2.4s cubic-bezier(0.65, 0, 0.35, 1) infinite",
          }}
        />
      </div>
    </div>
  );
};
