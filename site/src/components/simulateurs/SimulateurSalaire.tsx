import { useState, useMemo } from "react";
import { Wallet } from "lucide-react";
import { Input } from "@/components/ui/input";
import { Button } from "@/components/ui/button";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { SimulateurShell, SimField } from "./SimulateurShell";
import { Cell, Pie, PieChart, ResponsiveContainer, Tooltip } from "recharts";

export const SimulateurSalaire = () => {
  const [age, setAge] = useState(35);
  const [statut, setStatut] = useState("résident");
  const [salaireBrut, setSalaireBrut] = useState(7000);

  const result = useMemo(() => {
    const brut = salaireBrut;
    const avs = brut * 0.0525;
    const ac = brut * 0.022;
    const lpp = age >= 25 ? brut * 0.08 : 0;
    const tauxImpot = statut === "frontalier" ? 0.08 : 0.12;
    const impots = brut * tauxImpot;
    const net = brut - avs - ac - lpp - impots;
    return {
      net: Math.round(net),
      avs: Math.round(avs),
      ac: Math.round(ac),
      lpp: Math.round(lpp),
      impots: Math.round(impots),
    };
  }, [age, statut, salaireBrut]);

  const chartData = [
    { name: "Net", value: result.net, fill: "hsl(var(--primary))" },
    { name: "Impôts", value: result.impots, fill: "hsl(var(--accent))" },
    { name: "AVS/AI/APG", value: result.avs, fill: "hsl(var(--muted-foreground))" },
    { name: "LPP", value: result.lpp, fill: "hsl(var(--secondary))" },
    { name: "Chômage", value: result.ac, fill: "hsl(var(--border))" },
  ].filter((d) => d.value > 0);

  return (
    <SimulateurShell
      id="salaire"
      icon={Wallet}
      eyebrow="Salaire"
      title="Du brut au net en un instant"
      subtitle="Comprenez où va votre salaire et planifiez votre budget en toute clarté."
      inputs={
        <>
          <SimField label="Salaire brut mensuel" unit="CHF">
            <Input
              type="number"
              value={salaireBrut}
              onChange={(e) => setSalaireBrut(Number(e.target.value) || 0)}
              className="text-2xl font-semibold border-0 bg-transparent px-0 focus-visible:ring-0 h-auto py-1"
            />
          </SimField>

          <SimField label="Âge" unit="Années">
            <Input
              type="number"
              value={age}
              onChange={(e) => setAge(Number(e.target.value) || 0)}
              className="text-2xl font-semibold border-0 bg-transparent px-0 focus-visible:ring-0 h-auto py-1"
            />
          </SimField>

          <SimField label="Statut">
            <Select value={statut} onValueChange={setStatut}>
              <SelectTrigger className="border-0 bg-transparent px-0 focus:ring-0 h-auto py-1 text-lg font-semibold">
                <SelectValue />
              </SelectTrigger>
              <SelectContent className="bg-background z-50">
                <SelectItem value="résident">Résident suisse</SelectItem>
                <SelectItem value="frontalier">Frontalier</SelectItem>
              </SelectContent>
            </Select>
          </SimField>

          <div className="mt-6 rounded-xl bg-muted/30 border border-border/40 p-4 text-xs text-muted-foreground">
            ℹ️ Estimation indicative : les charges varient selon le canton, la commune, la caisse de pension et le statut familial.
          </div>
        </>
      }
      result={
        <>
          <div className="text-center mb-5">
            <p className="text-xs uppercase tracking-widest text-muted-foreground mb-2">
              Salaire net mensuel
            </p>
            <p className="text-4xl md:text-5xl font-bold bg-gradient-to-r from-primary to-accent bg-clip-text text-transparent">
              CHF {result.net.toLocaleString("fr-CH")}
            </p>
            <p className="text-xs text-muted-foreground mt-1">
              soit {((result.net / salaireBrut) * 100).toFixed(1)}% du brut
            </p>
          </div>

          <div className="flex-1 min-h-[220px]">
            <ResponsiveContainer width="100%" height="100%">
              <PieChart>
                <Pie
                  data={chartData}
                  cx="50%"
                  cy="50%"
                  innerRadius={55}
                  outerRadius={90}
                  paddingAngle={2}
                  dataKey="value"
                  stroke="hsl(var(--background))"
                  strokeWidth={2}
                >
                  {chartData.map((entry, i) => <Cell key={i} fill={entry.fill} />)}
                </Pie>
                <Tooltip
                  contentStyle={{ background: "hsl(var(--background))", border: "1px solid hsl(var(--border))", borderRadius: 12, fontSize: 12 }}
                  formatter={(v: number) => `CHF ${v.toLocaleString("fr-CH")}`}
                />
              </PieChart>
            </ResponsiveContainer>
          </div>

          <div className="grid grid-cols-2 gap-2 mt-2">
            {chartData.map((d) => (
              <div key={d.name} className="flex items-center gap-2 text-xs">
                <span className="w-2.5 h-2.5 rounded-full flex-shrink-0" style={{ background: d.fill }} />
                <span className="text-muted-foreground">{d.name}</span>
                <span className="ml-auto font-semibold">CHF {d.value.toLocaleString("fr-CH")}</span>
              </div>
            ))}
          </div>

          <Button variant="outline" className="w-full mt-5" asChild>
            <a href="/#contact">💼 Optimiser ma fiscalité</a>
          </Button>
        </>
      }
    />
  );
};
