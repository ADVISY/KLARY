import { Heart, TrendingUp, Home, Shield, ArrowUpRight } from "lucide-react";
import { KlaryAppHeader } from "../KlaryAppHeader";

const items = [
  { icon: Heart, label: "Assurance maladie", price: "287.-", saving: "-184", accent: "hsl(0 75% 60%)" },
  { icon: TrendingUp, label: "3ᵉ pilier", price: "350.-", saving: "-840", accent: "hsl(160 70% 42%)" },
  { icon: Home, label: "Hypothèque", price: "1.42%", saving: "vs 1.78", accent: "hsl(244 65% 38%)" },
  { icon: Shield, label: "RC ménage", price: "16.-", saving: "-52", accent: "hsl(19 90% 54%)" },
];

export const DashboardScreen = () => {
  return (
    <div className="relative w-full h-full px-4 pt-2.5 pb-2 flex flex-col bg-gradient-to-b from-[#FAF7F0] via-white to-[#F3EFE7]">
      <KlaryAppHeader
        eyebrow="Tableau de bord"
        title="Mes contrats"
        trailing={
          <div
            className="w-8 h-8 rounded-full flex items-center justify-center text-[11px] font-bold"
            style={{ background: "hsl(28 100% 90%)", color: "hsl(19 90% 50%)" }}
          >
            4
          </div>
        }
      />

      <div className="flex-1 space-y-2 overflow-hidden">
        {items.map((it) => {
          const Icon = it.icon;
          return (
            <div
              key={it.label}
              className="flex items-center gap-2.5 p-2.5 rounded-xl bg-white border border-neutral-light/70"
            >
              <div
                className="w-8 h-8 rounded-lg flex items-center justify-center shrink-0"
                style={{ background: `${it.accent}14`, color: it.accent }}
              >
                <Icon className="w-4 h-4" />
              </div>
              <div className="flex-1 min-w-0">
                <p className="text-[11px] font-semibold text-foreground leading-tight truncate">
                  {it.label}
                </p>
                <p className="text-[9px] text-muted-text mt-0.5 tabular-nums">{it.saving} CHF/an</p>
              </div>
              <span className="text-[11px] font-bold text-foreground tabular-nums shrink-0">
                {it.price}
              </span>
            </div>
          );
        })}
      </div>

      <div className="mt-2.5 p-2.5 rounded-xl bg-gradient-to-br from-[hsl(244_65%_22%)] to-[hsl(244_55%_38%)] text-white">
        <p className="text-[8.5px] uppercase tracking-wider font-semibold opacity-70">
          Économisé sur 12 mois
        </p>
        <div className="flex items-end justify-between mt-0.5">
          <p className="text-[18px] font-bold tabular-nums leading-none">- 1'247 CHF</p>
          <ArrowUpRight className="w-4 h-4 text-[hsl(28_95%_70%)]" />
        </div>
      </div>
    </div>
  );
};
