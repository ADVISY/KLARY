import { TrendingDown, BarChart3 } from "lucide-react";
import { KlaryAppHeader } from "../KlaryAppHeader";

// Smooth area chart, hard-coded as SVG path
const months = ["J", "F", "M", "A", "M", "J", "J", "A", "S", "O", "N", "D"];

export const ReportScreen = () => {
  // Path = cumulative savings curve
  const W = 240;
  const H = 70;
  const pts = [10, 60, 120, 200, 310, 460, 590, 720, 840, 970, 1100, 1247];
  const max = Math.max(...pts);
  const stepX = W / (pts.length - 1);
  const coords = pts.map((p, i) => [i * stepX, H - (p / max) * (H - 8) - 4]);
  const linePath = coords
    .map(([x, y], i) => `${i === 0 ? "M" : "L"} ${x.toFixed(1)} ${y.toFixed(1)}`)
    .join(" ");
  const areaPath = `${linePath} L ${W} ${H} L 0 ${H} Z`;

  return (
    <div className="relative w-full h-full px-4 pt-2.5 pb-2 flex flex-col bg-gradient-to-b from-white via-[#F8F4EA] to-[#EFEAE0]">
      <KlaryAppHeader
        eyebrow="Rapport · 2026"
        title="Vos économies"
        trailing={
          <div className="w-8 h-8 rounded-full bg-[hsl(19_95%_94%)] flex items-center justify-center">
            <BarChart3 className="w-4 h-4" style={{ color: "hsl(19 90% 50%)" }} />
          </div>
        }
      />

      <div className="rounded-2xl bg-white border border-neutral-light/70 p-2.5 mb-2">
        <p className="text-[8.5px] uppercase tracking-wider font-semibold text-muted-text">
          Total cumulé
        </p>
        <div className="flex items-baseline gap-1.5 mt-0.5">
          <p className="text-[20px] font-bold tabular-nums leading-none text-foreground">
            1'247 CHF
          </p>
          <span
            className="inline-flex items-center gap-0.5 text-[10px] font-bold"
            style={{ color: "hsl(160 70% 42%)" }}
          >
            <TrendingDown className="w-2.5 h-2.5" />
            -23%
          </span>
        </div>

        <svg
          viewBox={`0 0 ${W} ${H}`}
          className="w-full mt-2"
          style={{ height: "70px" }}
          preserveAspectRatio="none"
        >
          <defs>
            <linearGradient id="kg-area" x1="0" y1="0" x2="0" y2="1">
              <stop offset="0%" stopColor="hsl(19 90% 54%)" stopOpacity="0.42" />
              <stop offset="100%" stopColor="hsl(19 90% 54%)" stopOpacity="0" />
            </linearGradient>
          </defs>
          <path d={areaPath} fill="url(#kg-area)" />
          <path
            d={linePath}
            fill="none"
            stroke="hsl(19 90% 54%)"
            strokeWidth="2"
            strokeLinecap="round"
            strokeLinejoin="round"
          />
          {coords.map(([x, y], i) =>
            i === coords.length - 1 ? (
              <g key={i}>
                <circle cx={x} cy={y} r="5" fill="hsl(19 90% 54%)" opacity="0.18" />
                <circle cx={x} cy={y} r="2.5" fill="hsl(19 90% 54%)" />
              </g>
            ) : null
          )}
        </svg>

        <div
          className="flex justify-between text-[8px] font-medium mt-1"
          style={{ color: "hsl(var(--muted-text))" }}
        >
          {months.map((m, i) => (
            <span key={i}>{m}</span>
          ))}
        </div>
      </div>

      <div className="grid grid-cols-2 gap-1.5">
        {[
          { label: "Santé", val: "-184", accent: "hsl(0 75% 60%)" },
          { label: "3ᵉ pilier", val: "-840", accent: "hsl(160 70% 42%)" },
          { label: "Hypo", val: "-156", accent: "hsl(244 65% 38%)" },
          { label: "RC", val: "-67", accent: "hsl(19 90% 54%)" },
        ].map((m) => (
          <div key={m.label} className="rounded-xl bg-white border border-neutral-light/70 p-2">
            <p className="text-[8px] uppercase font-semibold" style={{ color: m.accent }}>
              {m.label}
            </p>
            <p className="text-[12px] font-bold tabular-nums text-foreground">{m.val} CHF</p>
          </div>
        ))}
      </div>
    </div>
  );
};
