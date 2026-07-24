import { Sparkles, ArrowRight, Calculator } from "lucide-react";
import { KlaryAppHeader } from "../KlaryAppHeader";

export const SimulatorScreen = () => {
  return (
    <div className="relative w-full h-full px-4 pt-2.5 pb-2 flex flex-col bg-gradient-to-b from-white via-[#FBF7EE] to-[#F3EFE7]">
      <KlaryAppHeader
        eyebrow="Simulateur"
        title="Comparer LAMal"
        trailing={
          <div className="w-8 h-8 rounded-full bg-[hsl(19_95%_94%)] flex items-center justify-center">
            <Calculator className="w-4 h-4" style={{ color: "hsl(19 90% 50%)" }} />
          </div>
        }
      />

      <div className="space-y-2">
        <div className="rounded-xl bg-white border border-neutral-light/70 p-2.5">
          <p className="text-[8px] uppercase tracking-wider font-semibold text-muted-text">Âge</p>
          <p className="text-[13px] font-bold text-foreground tabular-nums mt-0.5">34 ans</p>
        </div>
        <div className="rounded-xl bg-white border border-neutral-light/70 p-2.5">
          <p className="text-[8px] uppercase tracking-wider font-semibold text-muted-text">
            Canton · Franchise
          </p>
          <p className="text-[13px] font-bold text-foreground mt-0.5">VD · 2500.-</p>
        </div>
        <div className="rounded-xl bg-white border border-neutral-light/70 p-2.5">
          <p className="text-[8px] uppercase tracking-wider font-semibold text-muted-text">
            Modèle
          </p>
          <p className="text-[13px] font-bold text-foreground mt-0.5">Médecin de famille</p>
        </div>
      </div>

      <div
        className="mt-2.5 p-2.5 rounded-xl"
        style={{
          background: "linear-gradient(135deg, hsl(28 100% 92%) 0%, hsl(19 95% 88%) 100%)",
        }}
      >
        <div className="flex items-center gap-1.5 mb-0.5">
          <Sparkles className="w-3 h-3" style={{ color: "hsl(19 90% 50%)" }} />
          <p
            className="text-[8.5px] uppercase tracking-wider font-bold"
            style={{ color: "hsl(19 90% 40%)" }}
          >
            Économie estimée
          </p>
        </div>
        <p
          className="text-[20px] font-bold leading-none tabular-nums"
          style={{ color: "hsl(19 90% 35%)" }}
        >
          - 312 CHF
        </p>
        <p className="text-[9.5px] mt-0.5" style={{ color: "hsl(19 70% 35%)" }}>
          /an, à couverture égale
        </p>
      </div>

      <button
        className="mt-auto w-full rounded-xl py-2.5 text-[12px] font-semibold text-white flex items-center justify-center gap-1.5"
        style={{
          background: "linear-gradient(135deg, hsl(19 90% 54%) 0%, hsl(15 90% 48%) 100%)",
        }}
      >
        Voir les 12 offres
        <ArrowRight className="w-3 h-3" />
      </button>
    </div>
  );
};
