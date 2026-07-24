import { useState, useMemo } from "react";
import { PiggyBank } from "lucide-react";
import { Input } from "@/components/ui/input";
import { Button } from "@/components/ui/button";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { SimulateurShell, SimField } from "./SimulateurShell";
import { Bar, BarChart, ResponsiveContainer, Tooltip, XAxis, YAxis, CartesianGrid, Cell } from "recharts";

const cantons = [
  "Genève", "Vaud", "Valais", "Fribourg", "Neuchâtel", "Jura",
  "Berne", "Zurich", "Lucerne", "Bâle-Ville", "Bâle-Campagne",
  "Argovie", "Thurgovie", "Saint-Gall", "Grisons", "Tessin",
];

const tauxCantonaux: Record<string, number> = {
  "Genève": 0.30, "Vaud": 0.28, "Valais": 0.25, "Fribourg": 0.26,
  "Neuchâtel": 0.27, "Jura": 0.26, "Berne": 0.27, "Zurich": 0.24,
  "Lucerne": 0.23, "Bâle-Ville": 0.29, "Bâle-Campagne": 0.26,
  "Argovie": 0.24, "Thurgovie": 0.23, "Saint-Gall": 0.25,
  "Grisons": 0.22, "Tessin": 0.26,
};

export const SimulateurImpot = () => {
  const [canton, setCanton] = useState("Genève");
  const [situation, setSituation] = useState("célibataire");
  const [revenu, setRevenu] = useState(80000);
  const [cotisation, setCotisation] = useState(7056);

  const result = useMemo(() => {
    const taux = tauxCantonaux[canton] ?? 0.25;
    const coef = situation === "marié" ? 0.85 : situation === "enfants" ? 0.80 : 1;
    const economie = cotisation * taux * coef;
    const cotisationNette = cotisation - economie;
    return {
      economie: Math.round(economie),
      cotisationNette: Math.round(cotisationNette),
      pourcentage: (economie / cotisation) * 100,
    };
  }, [canton, situation, cotisation]);

  // Projection 30 ans
  const projection = useMemo(() => {
    return Array.from({ length: 7 }, (_, i) => {
      const annees = (i + 1) * 5;
      return {
        annees: `${annees}a`,
        economie: Math.round(result.economie * annees),
      };
    });
  }, [result.economie]);

  return (
    <SimulateurShell
      id="impot"
      icon={PiggyBank}
      eyebrow="Fiscalité"
      title="Simulateur d'économie d'impôt"
      subtitle="Calculez en quelques clics l'économie fiscale grâce à votre 3ᵉ pilier."
      inputs={
        <>
          <SimField label="Canton de résidence">
            <Select value={canton} onValueChange={setCanton}>
              <SelectTrigger className="border-0 bg-transparent px-0 focus:ring-0 h-auto py-1 text-lg font-semibold">
                <SelectValue />
              </SelectTrigger>
              <SelectContent className="bg-background z-50">
                {cantons.map((c) => <SelectItem key={c} value={c}>{c}</SelectItem>)}
              </SelectContent>
            </Select>
          </SimField>

          <SimField label="Situation familiale">
            <Select value={situation} onValueChange={setSituation}>
              <SelectTrigger className="border-0 bg-transparent px-0 focus:ring-0 h-auto py-1 text-lg font-semibold">
                <SelectValue />
              </SelectTrigger>
              <SelectContent className="bg-background z-50">
                <SelectItem value="célibataire">Célibataire</SelectItem>
                <SelectItem value="marié">Marié(e)</SelectItem>
                <SelectItem value="enfants">Avec enfants</SelectItem>
              </SelectContent>
            </Select>
          </SimField>

          <SimField label="Revenu annuel brut" unit="CHF">
            <Input
              type="number"
              value={revenu}
              onChange={(e) => setRevenu(Number(e.target.value) || 0)}
              className="text-2xl font-semibold border-0 bg-transparent px-0 focus-visible:ring-0 h-auto py-1"
            />
          </SimField>

          <SimField label="Cotisation 3ᵉ pilier annuelle" unit="CHF" hint="Maximum 2026 : CHF 7'258 (salarié) / 20% du revenu (indépendant)">
            <Input
              type="number"
              value={cotisation}
              onChange={(e) => setCotisation(Number(e.target.value) || 0)}
              className="text-2xl font-semibold border-0 bg-transparent px-0 focus-visible:ring-0 h-auto py-1"
            />
          </SimField>
        </>
      }
      result={
        <>
          <div className="text-center mb-5">
            <p className="text-xs uppercase tracking-widest text-muted-foreground mb-2">
              Économie d'impôt annuelle
            </p>
            <p className="text-4xl md:text-5xl font-bold bg-gradient-to-r from-primary to-accent bg-clip-text text-transparent">
              CHF {result.economie.toLocaleString("fr-CH")}
            </p>
            <p className="text-xs text-muted-foreground mt-1">soit {result.pourcentage.toFixed(1)}% de votre cotisation</p>
          </div>

          <div className="grid grid-cols-2 gap-3 mb-5">
            <div className="rounded-xl bg-background/60 border border-border/40 p-3">
              <p className="text-[10px] uppercase tracking-widest text-muted-foreground mb-1">Cotisé</p>
              <p className="text-lg font-semibold">CHF {cotisation.toLocaleString("fr-CH")}</p>
            </div>
            <div className="rounded-xl bg-primary/10 border border-primary/30 p-3">
              <p className="text-[10px] uppercase tracking-widest text-primary mb-1">Coût net</p>
              <p className="text-lg font-semibold text-primary">CHF {result.cotisationNette.toLocaleString("fr-CH")}</p>
            </div>
          </div>

          <p className="text-xs text-muted-foreground mb-2 text-center">Projection cumulée d'économies</p>
          <div className="flex-1 min-h-[200px]">
            <ResponsiveContainer width="100%" height="100%">
              <BarChart data={projection} margin={{ top: 10, right: 0, left: -20, bottom: 0 }}>
                <CartesianGrid stroke="hsl(var(--border))" strokeDasharray="3 3" opacity={0.3} vertical={false} />
                <XAxis dataKey="annees" stroke="hsl(var(--muted-foreground))" fontSize={11} tickLine={false} axisLine={false} />
                <YAxis stroke="hsl(var(--muted-foreground))" fontSize={11} tickLine={false} axisLine={false}
                  tickFormatter={(v) => `${(v / 1000).toFixed(0)}k`} />
                <Tooltip
                  contentStyle={{ background: "hsl(var(--background))", border: "1px solid hsl(var(--border))", borderRadius: 12, fontSize: 12 }}
                  formatter={(v: number) => `CHF ${v.toLocaleString("fr-CH")}`}
                />
                <Bar dataKey="economie" radius={[8, 8, 0, 0]}>
                  {projection.map((_, i) => <Cell key={i} fill="hsl(var(--primary))" />)}
                </Bar>
              </BarChart>
            </ResponsiveContainer>
          </div>

          <Button variant="outline" className="w-full mt-4" asChild>
            <a href="/assurances/3e-pilier">💡 Demander une étude 3ᵉ pilier</a>
          </Button>
        </>
      }
    />
  );
};
