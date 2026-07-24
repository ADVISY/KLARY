import { ReactNode } from "react";

interface PhoneFrameProps {
  children: ReactNode;
  className?: string;
}

/**
 * iPhone-like frame avec safe areas iOS correctes :
 *  - Status bar absolue (44px), notch dynamique centré
 *  - Safe area top : 44px (status bar)
 *  - Safe area bottom : 24px (home indicator)
 *  - Le content area est dans <div data-screen-content> qui clip naturellement
 */
export const PhoneFrame = ({ children, className = "" }: PhoneFrameProps) => {
  return (
    <div
      className={`relative mx-auto ${className}`}
      style={{
        width: "320px",
        maxWidth: "100%",
        aspectRatio: "9 / 19.5",
      }}
    >
      {/* Outer bezel — soft shadow + reflection */}
      <div
        className="absolute inset-0 rounded-[44px]"
        style={{
          background: "linear-gradient(160deg, #0E0B30 0%, #1A1660 45%, #0E0B30 100%)",
          boxShadow:
            "0 32px 80px -16px rgba(15, 10, 60, 0.45), 0 16px 36px -10px rgba(15, 10, 60, 0.25), inset 0 1px 0 rgba(255,255,255,0.10), inset 0 -1px 0 rgba(0,0,0,0.30)",
          padding: "9px",
        }}
      >
        {/* Inner screen */}
        <div
          className="relative w-full h-full rounded-[36px] overflow-hidden bg-white"
          style={{ isolation: "isolate" }}
        >
          {/* Status bar (44px) — iOS-style avec notch dynamique centré */}
          <div
            aria-hidden
            className="absolute top-0 left-0 right-0 z-[20] flex items-center justify-between px-7 text-[11px] font-semibold text-foreground/90 tabular-nums"
            style={{ height: "44px", paddingTop: "12px" }}
          >
            <span>9:41</span>
            <div className="flex items-center gap-1">
              <svg width="14" height="10" viewBox="0 0 16 11" fill="none">
                <rect x="0" y="7" width="2.5" height="3.5" rx="0.4" fill="currentColor" />
                <rect x="3.5" y="5" width="2.5" height="5.5" rx="0.4" fill="currentColor" />
                <rect x="7" y="3" width="2.5" height="7.5" rx="0.4" fill="currentColor" />
                <rect x="10.5" y="1" width="2.5" height="9.5" rx="0.4" fill="currentColor" />
              </svg>
              <svg width="20" height="10" viewBox="0 0 22 10" fill="none">
                <rect x="0.5" y="0.5" width="18" height="9" rx="2" stroke="currentColor" strokeOpacity="0.5" />
                <rect x="2" y="2" width="14" height="6" rx="1" fill="currentColor" />
                <rect x="19.5" y="3" width="1.5" height="4" rx="0.5" fill="currentColor" fillOpacity="0.5" />
              </svg>
            </div>
          </div>

          {/* Dynamic Island (notch) */}
          <div
            aria-hidden
            className="absolute top-2.5 left-1/2 -translate-x-1/2 z-[25] rounded-full bg-[#0B0828]"
            style={{ width: "92px", height: "26px" }}
          />

          {/* Content area : start AFTER status bar (44px) and end BEFORE home indicator (24px) */}
          <div
            data-screen-content
            className="absolute left-0 right-0 overflow-hidden"
            style={{ top: "44px", bottom: "24px" }}
          >
            {children}
          </div>

          {/* Home indicator iOS (gris pill au fond) */}
          <div
            aria-hidden
            className="absolute bottom-1.5 left-1/2 -translate-x-1/2 z-[20] rounded-full"
            style={{
              width: "104px",
              height: "4px",
              background: "rgba(16, 14, 47, 0.35)",
            }}
          />
        </div>
      </div>
    </div>
  );
};
