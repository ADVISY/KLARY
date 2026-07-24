import { Bell, Check, ArrowRight, TrendingDown } from "lucide-react";
import { KlaryAppHeader } from "../KlaryAppHeader";

export const AlertScreen = () => {
  return (
    <div className="relative w-full h-full px-4 pt-2.5 pb-2 flex flex-col bg-gradient-to-b from-[#F6F3FF] via-white to-[#F3EFE7]">
      <KlaryAppHeader
        eyebrow="Notification"
        title="Optimisation trouvée"
        trailing={
          <div className="w-8 h-8 rounded-full bg-[hsl(160_70%_42%/0.12)] flex items-center justify-center">
            <Bell className="w-4 h-4" style={{ color: "hsl(160 70% 42%)" }} />
          </div>
        }
      />

      <div
        className="rounded-2xl bg-white border border-[hsl(160_70%_42%/0.25)] p-3 mb-2.5"
        style={{ boxShadow: "0 8px 24px -8px hsl(160 70% 42% / 0.20)" }}
      >
        <div className="flex items-center gap-2 mb-2">
          <div className="w-7 h-7 rounded-lg bg-[hsl(160_70%_42%/0.12)] flex items-center justify-center">
            <TrendingDown className="w-3.5 h-3.5" style={{ color: "hsl(160 70% 42%)" }} />
          </div>
          <p
            className="text-[9.5px] uppercase tracking-wider font-bold"
            style={{ color: "hsl(160 70% 42%)" }}
          >
            Santé
          </p>
        </div>
        <p className="text-[12.5px] font-bold text-foreground leading-snug mb-2">
          On peut réduire votre prime de{" "}
          <span className="text-[hsl(160_70%_38%)]">184 CHF/an</span> avec la même couverture.
        </p>
        <ul className="space-y-1">
          {["Même franchise (2'500)", "Même modèle (médecin)", "Compagnie noté A+"].map((t) => (
            <li
              key={t}
              className="flex items-center gap-1.5 text-[10px]"
              style={{ color: "hsl(var(--muted-text))" }}
            >
              <Check className="w-3 h-3 shrink-0" style={{ color: "hsl(160 70% 42%)" }} />
              {t}
            </li>
          ))}
        </ul>
      </div>

      <div className="space-y-1.5 mt-auto">
        <button
          className="w-full rounded-xl py-2.5 text-[12px] font-semibold text-white flex items-center justify-center gap-1.5"
          style={{ background: "hsl(160 70% 38%)" }}
        >
          Appliquer
          <ArrowRight className="w-3 h-3" />
        </button>
        <button
          className="w-full rounded-xl py-2 text-[11px] font-semibold border"
          style={{ color: "hsl(var(--muted-text))", borderColor: "hsl(var(--neutral-light))" }}
        >
          Plus tard
        </button>
      </div>
    </div>
  );
};
