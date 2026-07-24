import { useState, useMemo } from "react";
import { Home, AlertTriangle, CheckCircle2 } from "lucide-react";
import { Input } from "@/components/ui/input";
import { Button } from "@/components/ui/button";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { SimulateurShell, SimField } from "./SimulateurShell";
import { Bar, BarChart, ResponsiveContainer, Tooltip, XAxis, YAxis, CartesianGrid, Cell } from "recharts";

export const SimulateurHypothecaire = () => {
  const [prixBien, setPrixBien] = useState(1000000);
  const [fondsPropres, setFondsPropres] = useState(200000);
  const [taux, setTaux] = useState(1.8);
  const [duree, setDuree] = useState(15);
  const [amortType, setAmortType] = useState<"direct" | "indirect">("indirect");
  const [revenuAnnuel, setRevenuAnnuel] = useState(150000);

  const calc = useMemo(() => {
    const pret = Math.max(0, prixBien - fondsPropres);
    const ratioFP = (fondsPropres / prixBien) * 100;

    // 1er rang = 66% du prix (pas d'amortissement obligatoire)
    // 2e rang = pret - 1er rang (à amortir en 15 ans)
    const premierRang = Math.min(pret, prixBien * 0.66);
    const deuxiemeRang = Math.max(0, pret - premierRang);
    const amortAnnuel = deuxiemeRang / 15;

    const interetsAnnuels = pret * (taux / 100);
    const entretienAnnuel = prixBien * 0.01; // 1% entretien

    // Charges théoriques (banque) : 5% intérêts + 1% entretien + amort
    const interetsTheoriques = pret * 0.05;
    const chargesTheoriques = interetsTheoriques + entretienAnnuel + amortAnnuel;
    const ratioCharges = (chargesTheoriques / revenuAnnuel) * 100;

    const mensualiteInterets = interetsAnnuels / 12;
    const mensualiteAmort = amortAnnuel / 12;
    const mensualiteEntretien = entretienAnnuel / 12;
    const mensualiteTotale = mensualiteInterets + mensualiteAmort + mensualiteEntretien;

    const fpOk = ratioFP >= 20;
    const chargesOk = ratioCharges <= 33;
    const eligible = fpOk && chargesOk;

    return {
      pret,
      ratioFP,
      premierRang,
      deuxiemeRang,
      amortAnnuel,
      interetsAnnuels,
      entretienAnnuel,
      mensualiteTotale,
      mensualiteInterets,
      mensualiteAmort,
      mensualiteEntretien,
      chargesTheoriques,
      ratioCharges,
      fpOk,
      chargesOk,
      eligible,
    };
  }, [prixBien, fondsPropres, taux, duree, amortType, revenuAnnuel]);

  const chartData = [
    { name: "Intérêts", value: Math.round(calc.mensualiteInterets), fill: "hsl(var(--primary))" },
    { name: "Amortissement", value: Math.round(calc.mensualiteAmort), fill: "hsl(var(--accent))" },
    { name: "Entretien", value: Math.round(calc.mensualiteEntretien), fill: "hsl(var(--muted-foreground))" },
  ];

  return (
    <SimulateurShell
      id="hypothecaire"
      icon={Home}
      eyebrow="Immobilier"
      title="Simulateur de prêt hypothécaire"
      subtitle="Calculez votre capacité d'achat selon les normes bancaires suisses (fonds propres 20%, charges ≤ 33%)."
      inputs={
        <>
          <SimField label="Prix du bien" unit="CHF">
            <Input
              type="number"
              value={prixBien}
              onChange={(e) => setPrixBien(Number(e.target.value) || 0)}
              className="text-2xl font-semibold border-0 bg-transparent px-0 focus-visible:ring-0 h-auto py-1"
            />
          </SimField>

          <SimField
            label="Fonds propres"
            unit="CHF"
            hint={`Soit ${calc.ratioFP.toFixed(1)}% du prix (minimum 20% requis, dont 10% hors LPP)`}
          >
            <Input
              type="number"
              value={fondsPropres}
              onChange={(e) => setFondsPropres(Number(e.target.value) || 0)}
              className="text-2xl font-semibold border-0 bg-transparent px-0 focus-visible:ring-0 h-auto py-1"
            />
          </SimField>

          <SimField label="Taux d'intérêt hypothécaire" unit="%">
            <Input
              type="number"
              step="0.1"
              value={taux}
              onChange={(e) => setTaux(Number(e.target.value) || 0)}
              className="text-2xl font-semibold border-0 bg-transparent px-0 focus-visible:ring-0 h-auto py-1"
            />
          </SimField>

          <SimField label="Durée du prêt" unit="Années">
            <Input
              type="number"
              value={duree}
              onChange={(e) => setDuree(Number(e.target.value) || 1)}
              className="text-2xl font-semibold border-0 bg-transparent px-0 focus-visible:ring-0 h-auto py-1"
            />
          </SimField>

          <SimField label="Type d'amortissement">
            <Select value={amortType} onValueChange={(v: "direct" | "indirect") => setAmortType(v)}>
              <SelectTrigger className="border-0 bg-transparent px-0 focus:ring-0 h-auto py-1 text-lg font-semibold">
                <SelectValue />
              </SelectTrigger>
              <SelectContent className="bg-background z-50">
                <SelectItem value="indirect">Indirect (via 3ᵉ pilier - optimisé fiscalement)</SelectItem>
                <SelectItem value="direct">Direct (remboursement classique)</SelectItem>
              </SelectContent>
            </Select>
          </SimField>

          <SimField label="Revenu annuel brut du ménage" unit="CHF">
            <Input
              type="number"
              value={revenuAnnuel}
              onChange={(e) => setRevenuAnnuel(Number(e.target.value) || 0)}
              className="text-2xl font-semibold border-0 bg-transparent px-0 focus-visible:ring-0 h-auto py-1"
            />
          </SimField>
        </>
      }
      result={
        <>
          <div className="text-center mb-5">
            <p className="text-xs uppercase tracking-widest text-muted-foreground mb-2">
              Mensualité totale
            </p>
            <p className="text-4xl md:text-5xl font-bold bg-gradient-to-r from-primary to-accent bg-clip-text text-transparent">
              CHF {Math.round(calc.mensualiteTotale).toLocaleString("fr-CH")}
            </p>
            <p className="text-xs text-muted-foreground mt-1">par mois (intérêts + amort + entretien)</p>
          </div>

          {/* Eligibility badges */}
          <div className="grid grid-cols-2 gap-2 mb-5">
            <div className={`rounded-xl border p-3 ${calc.fpOk ? "bg-primary/10 border-primary/30" : "bg-destructive/10 border-destructive/30"}`}>
              <div className="flex items-center gap-1.5 mb-1">
                {calc.fpOk ? <CheckCircle2 className="w-3.5 h-3.5 text-primary" /> : <AlertTriangle className="w-3.5 h-3.5 text-destructive" />}
                <p className="text-[10px] uppercase tracking-widest font-semibold">Fonds propres</p>
              </div>
              <p className="text-sm font-bold">{calc.ratioFP.toFixed(1)}% / 20%</p>
            </div>
            <div className={`rounded-xl border p-3 ${calc.chargesOk ? "bg-primary/10 border-primary/30" : "bg-destructive/10 border-destructive/30"}`}>
              <div className="flex items-center gap-1.5 mb-1">
                {calc.chargesOk ? <CheckCircle2 className="w-3.5 h-3.5 text-primary" /> : <AlertTriangle className="w-3.5 h-3.5 text-destructive" />}
                <p className="text-[10px] uppercase tracking-widest font-semibold">Charges théo.</p>
              </div>
              <p className="text-sm font-bold">{calc.ratioCharges.toFixed(1)}% / 33%</p>
            </div>
          </div>

          <div className="rounded-xl bg-background/60 border border-border/40 p-4 mb-4 space-y-1.5 text-sm">
            <div className="flex justify-between"><span className="text-muted-foreground">Prêt total</span><span className="font-semibold">CHF {calc.pret.toLocaleString("fr-CH")}</span></div>
            <div className="flex justify-between"><span className="text-muted-foreground">1er rang (66%)</span><span>CHF {Math.round(calc.premierRang).toLocaleString("fr-CH")}</span></div>
            <div className="flex justify-between"><span className="text-muted-foreground">2e rang (à amortir 15 ans)</span><span>CHF {Math.round(calc.deuxiemeRang).toLocaleString("fr-CH")}</span></div>
          </div>

          <div className="flex-1 min-h-[160px]">
            <ResponsiveContainer width="100%" height="100%">
              <BarChart data={chartData} margin={{ top: 10, right: 10, left: -20, bottom: 0 }}>
                <CartesianGrid stroke="hsl(var(--border))" strokeDasharray="3 3" opacity={0.3} vertical={false} />
                <XAxis dataKey="name" stroke="hsl(var(--muted-foreground))" fontSize={11} tickLine={false} axisLine={false} />
                <YAxis stroke="hsl(var(--muted-foreground))" fontSize={11} tickLine={false} axisLine={false} />
                <Tooltip
                  contentStyle={{
                    background: "hsl(var(--background))",
                    border: "1px solid hsl(var(--border))",
                    borderRadius: 12,
                    fontSize: 12,
                  }}
                  formatter={(v: number) => `CHF ${v.toLocaleString("fr-CH")}/mois`}
                />
                <Bar dataKey="value" radius={[8, 8, 0, 0]}>
                  {chartData.map((entry, i) => <Cell key={i} fill={entry.fill} />)}
                </Bar>
              </BarChart>
            </ResponsiveContainer>
          </div>

          <Button variant="outline" className="w-full mt-4" asChild>
            <a href="/assurances/hypotheque">🏠 Étudier mon dossier hypothécaire</a>
          </Button>
        </>
      }
    />
  );
};
