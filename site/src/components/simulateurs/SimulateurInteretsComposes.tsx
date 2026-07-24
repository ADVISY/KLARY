import { useState, useMemo } from "react";
import { TrendingUp } from "lucide-react";
import { Input } from "@/components/ui/input";
import { Button } from "@/components/ui/button";
import { SimulateurShell, SimField } from "./SimulateurShell";
import { Area, AreaChart, ResponsiveContainer, Tooltip, XAxis, YAxis, CartesianGrid } from "recharts";

export const SimulateurInteretsComposes = () => {
  const [capitalInitial, setCapitalInitial] = useState(10000);
  const [versementMensuel, setVersementMensuel] = useState(500);
  const [duree, setDuree] = useState(20);
  const [taux, setTaux] = useState(5);

  const data = useMemo(() => {
    const r = taux / 100 / 12;
    const months = duree * 12;
    const points: { year: number; versements: number; interets: number; total: number }[] = [];
    let balance = capitalInitial;
    let totalVersements = capitalInitial;

    points.push({ year: 0, versements: capitalInitial, interets: 0, total: capitalInitial });

    for (let m = 1; m <= months; m++) {
      balance = balance * (1 + r) + versementMensuel;
      totalVersements += versementMensuel;
      if (m % 12 === 0) {
        points.push({
          year: m / 12,
          versements: Math.round(totalVersements),
          interets: Math.round(balance - totalVersements),
          total: Math.round(balance),
        });
      }
    }
    return points;
  }, [capitalInitial, versementMensuel, duree, taux]);

  const final = data[data.length - 1];
  const totalVersements = final.versements;
  const totalInterets = final.interets;
  const capitalFinal = final.total;

  return (
    <SimulateurShell
      id="interets-composes"
      icon={TrendingUp}
      eyebrow="Investissement"
      title="Calculatrice d'intérêts composés"
      subtitle="Visualisez la puissance des intérêts composés sur votre épargne et vos investissements."
      inputs={
        <>
          <SimField label="Capital initial" unit="CHF">
            <Input
              type="number"
              value={capitalInitial}
              onChange={(e) => setCapitalInitial(Number(e.target.value) || 0)}
              className="text-2xl font-semibold border-0 bg-transparent px-0 focus-visible:ring-0 h-auto py-1"
            />
          </SimField>

          <SimField label="Versement mensuel" unit="CHF">
            <Input
              type="number"
              value={versementMensuel}
              onChange={(e) => setVersementMensuel(Number(e.target.value) || 0)}
              className="text-2xl font-semibold border-0 bg-transparent px-0 focus-visible:ring-0 h-auto py-1"
            />
          </SimField>

          <SimField label="Horizon de placement" unit="Années">
            <Input
              type="number"
              value={duree}
              onChange={(e) => setDuree(Math.max(1, Number(e.target.value) || 1))}
              className="text-2xl font-semibold border-0 bg-transparent px-0 focus-visible:ring-0 h-auto py-1"
            />
          </SimField>

          <SimField label="Taux d'intérêt annuel" unit="%" hint="Rendement moyen estimé (actions long terme : ~5-7%)">
            <Input
              type="number"
              step="0.1"
              value={taux}
              onChange={(e) => setTaux(Number(e.target.value) || 0)}
              className="text-2xl font-semibold border-0 bg-transparent px-0 focus-visible:ring-0 h-auto py-1"
            />
          </SimField>
        </>
      }
      result={
        <>
          <div className="text-center mb-6">
            <p className="text-xs uppercase tracking-widest text-muted-foreground mb-2">
              Capital final
            </p>
            <p className="text-4xl md:text-5xl font-bold bg-gradient-to-r from-primary to-accent bg-clip-text text-transparent">
              CHF {capitalFinal.toLocaleString("fr-CH")}
            </p>
          </div>

          <div className="grid grid-cols-2 gap-3 mb-5">
            <div className="rounded-xl bg-background/60 border border-border/40 p-3">
              <p className="text-[10px] uppercase tracking-widest text-muted-foreground mb-1">Versements</p>
              <p className="text-lg font-semibold text-foreground">
                CHF {totalVersements.toLocaleString("fr-CH")}
              </p>
            </div>
            <div className="rounded-xl bg-primary/10 border border-primary/30 p-3">
              <p className="text-[10px] uppercase tracking-widest text-primary mb-1">Intérêts gagnés</p>
              <p className="text-lg font-semibold text-primary">
                CHF {totalInterets.toLocaleString("fr-CH")}
              </p>
            </div>
          </div>

          <div className="flex-1 min-h-[220px]">
            <ResponsiveContainer width="100%" height="100%">
              <AreaChart data={data} margin={{ top: 10, right: 0, left: -20, bottom: 0 }}>
                <defs>
                  <linearGradient id="gradVersements" x1="0" y1="0" x2="0" y2="1">
                    <stop offset="0%" stopColor="hsl(var(--muted-foreground))" stopOpacity={0.5} />
                    <stop offset="100%" stopColor="hsl(var(--muted-foreground))" stopOpacity={0.05} />
                  </linearGradient>
                  <linearGradient id="gradInterets" x1="0" y1="0" x2="0" y2="1">
                    <stop offset="0%" stopColor="hsl(var(--primary))" stopOpacity={0.7} />
                    <stop offset="100%" stopColor="hsl(var(--primary))" stopOpacity={0.05} />
                  </linearGradient>
                </defs>
                <CartesianGrid stroke="hsl(var(--border))" strokeDasharray="3 3" opacity={0.3} />
                <XAxis dataKey="year" stroke="hsl(var(--muted-foreground))" fontSize={11} tickLine={false} axisLine={false} />
                <YAxis stroke="hsl(var(--muted-foreground))" fontSize={11} tickLine={false} axisLine={false}
                  tickFormatter={(v) => `${(v / 1000).toFixed(0)}k`} />
                <Tooltip
                  contentStyle={{
                    background: "hsl(var(--background))",
                    border: "1px solid hsl(var(--border))",
                    borderRadius: 12,
                    fontSize: 12,
                  }}
                  formatter={(v: number) => `CHF ${v.toLocaleString("fr-CH")}`}
                  labelFormatter={(l) => `Année ${l}`}
                />
                <Area type="monotone" dataKey="versements" stackId="1" stroke="hsl(var(--muted-foreground))" fill="url(#gradVersements)" />
                <Area type="monotone" dataKey="interets" stackId="1" stroke="hsl(var(--primary))" fill="url(#gradInterets)" />
              </AreaChart>
            </ResponsiveContainer>
          </div>

          <Button variant="outline" className="w-full mt-5" asChild>
            <a href="/#contact">📈 Construire ma stratégie d'investissement</a>
          </Button>
        </>
      }
    />
  );
};
