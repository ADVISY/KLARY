import { FileText, ShieldCheck, Download, Bell, ChevronRight } from "lucide-react";
import { KlaryAppHeader } from "../KlaryAppHeader";

const documents = [
  { label: "Police LAMal 2026", date: "12.01.26", status: "Signé", color: "hsl(160 70% 42%)" },
  { label: "Avenant 3ᵉ pilier", date: "08.01.26", status: "À signer", color: "hsl(19 90% 54%)" },
  { label: "Décompte sinistre #2841", date: "22.12.25", status: "Traité", color: "hsl(244 65% 38%)" },
];

export const EspaceClientScreen = () => {
  return (
    <div className="relative w-full h-full px-4 pt-2.5 pb-2 flex flex-col bg-gradient-to-b from-white via-[#F7F2E9] to-[#EFEAE0]">
      <KlaryAppHeader
        eyebrow="Espace privé"
        title="Bonjour, Hugo 👋"
        trailing={
          <div className="relative">
            <div className="w-9 h-9 rounded-full flex items-center justify-center bg-foreground text-background text-[11px] font-bold">
              HL
            </div>
            <span className="absolute -top-0.5 -right-0.5 w-3 h-3 rounded-full bg-[hsl(19_90%_54%)] border-2 border-white" />
          </div>
        }
      />

      {/* Status pill */}
      <div className="rounded-xl bg-gradient-to-br from-[hsl(244_65%_22%)] to-[hsl(244_55%_38%)] p-2.5 mb-2.5 text-white">
        <div className="flex items-center gap-2 mb-1">
          <ShieldCheck className="w-3.5 h-3.5 text-[hsl(28_95%_70%)]" />
          <p className="text-[8.5px] uppercase tracking-wider font-bold opacity-80">
            Couverture active
          </p>
        </div>
        <p className="text-[13px] font-bold leading-tight">5 contrats · suivi par Klary</p>
        <p className="text-[9.5px] opacity-70 mt-0.5">Dernière analyse · 22.01.2026</p>
      </div>

      {/* Documents list */}
      <div className="flex-1 space-y-1.5 overflow-hidden">
        <p
          className="text-[8.5px] uppercase tracking-wider font-bold mb-1"
          style={{ color: "hsl(var(--muted-text))" }}
        >
          Mes documents
        </p>
        {documents.map((d) => (
          <div
            key={d.label}
            className="flex items-center gap-2 p-2 rounded-xl bg-white border border-neutral-light/70"
          >
            <div
              className="w-7 h-7 rounded-lg flex items-center justify-center shrink-0"
              style={{ background: `${d.color}14`, color: d.color }}
            >
              <FileText className="w-3.5 h-3.5" />
            </div>
            <div className="flex-1 min-w-0">
              <p className="text-[10.5px] font-semibold text-foreground leading-tight truncate">
                {d.label}
              </p>
              <div className="flex items-center gap-1.5 mt-0.5">
                <p className="text-[8.5px] text-muted-text">{d.date}</p>
                <span
                  className="text-[7.5px] font-bold uppercase tracking-wider px-1.5 py-0.5 rounded-full"
                  style={{ background: `${d.color}1A`, color: d.color }}
                >
                  {d.status}
                </span>
              </div>
            </div>
            <Download
              className="w-3.5 h-3.5 shrink-0"
              style={{ color: "hsl(var(--muted-text))" }}
            />
          </div>
        ))}
      </div>

      {/* Notification */}
      <div className="mt-2.5 p-2 rounded-xl bg-[hsl(19_95%_96%)] border border-[hsl(19_90%_85%)] flex items-center gap-2">
        <div className="w-7 h-7 rounded-lg bg-[hsl(19_90%_54%/0.15)] flex items-center justify-center shrink-0">
          <Bell className="w-3.5 h-3.5" style={{ color: "hsl(19 90% 50%)" }} />
        </div>
        <div className="flex-1 min-w-0">
          <p className="text-[10px] font-bold text-foreground leading-tight">
            3 actions en attente
          </p>
          <p className="text-[8.5px] mt-0.5" style={{ color: "hsl(var(--muted-text))" }}>
            1 signature, 2 documents à valider
          </p>
        </div>
        <ChevronRight className="w-3.5 h-3.5 shrink-0" style={{ color: "hsl(19 90% 50%)" }} />
      </div>
    </div>
  );
};
