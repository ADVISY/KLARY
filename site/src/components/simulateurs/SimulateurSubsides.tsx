import { useState, useMemo } from "react";
import { HeartHandshake, Check, X } from "lucide-react";
import { Input } from "@/components/ui/input";
import { Button } from "@/components/ui/button";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { SimulateurShell, SimField } from "./SimulateurShell";

const cantons = [
  "Genève", "Vaud", "Valais", "Fribourg", "Neuchâtel", "Jura",
  "Berne", "Zurich", "Lucerne", "Bâle-Ville", "Bâle-Campagne",
  "Argovie", "Thurgovie", "Saint-Gall", "Grisons", "Tessin",
];

export const SimulateurSubsides = () => {
  const [canton, setCanton] = useState("Genève");
  const [adultes, setAdultes] = useState(2);
  const [enfants, setEnfants] = useState(1);
  const [revenu, setRevenu] = useState(75000);
  const [prime, setPrime] = useState(450);

  const result = useMemo(() => {
    const taillefoyer = adultes + enfants;
    const limiteRevenu = 50000 + taillefoyer * 10000;

    if (revenu > limiteRevenu) {
      return {
        eligible: false,
        gain: 0,
        subsideMin: 0,
        subsideMax: 0,
        message: "D'après vos données, vous ne semblez pas éligible à un subside cantonal. D'autres pistes d'optimisation existent.",
      };
    }
    const tauxSubside = Math.max(0.1, Math.min(0.6, 1 - revenu / limiteRevenu));
    const subsideMin = Math.round(prime * tauxSubside * 0.7);
    const subsideMax = Math.round(prime * tauxSubside);
    return {
      eligible: true,
      gain: subsideMax * 12,
      subsideMin,
      subsideMax,
      message: `Vous pourriez recevoir entre CHF ${subsideMin} et CHF ${subsideMax} de subside par mois.`,
    };
  }, [canton, adultes, enfants, revenu, prime]);

  return (
    <SimulateurShell
      id="subsides"
      icon={HeartHandshake}
      eyebrow="Santé"
      title="Subsides d'assurance maladie"
      subtitle="Vérifiez votre éligibilité aux aides cantonales pour réduire vos primes santé."
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

          <SimField label="Adultes dans le foyer">
            <Input
              type="number"
              min={1}
              value={adultes}
              onChange={(e) => setAdultes(Number(e.target.value) || 1)}
              className="text-2xl font-semibold border-0 bg-transparent px-0 focus-visible:ring-0 h-auto py-1"
            />
          </SimField>

          <SimField label="Enfants à charge">
            <Input
              type="number"
              min={0}
              value={enfants}
              onChange={(e) => setEnfants(Number(e.target.value) || 0)}
              className="text-2xl font-semibold border-0 bg-transparent px-0 focus-visible:ring-0 h-auto py-1"
            />
          </SimField>

          <SimField label="Revenu annuel du ménage" unit="CHF">
            <Input
              type="number"
              value={revenu}
              onChange={(e) => setRevenu(Number(e.target.value) || 0)}
              className="text-2xl font-semibold border-0 bg-transparent px-0 focus-visible:ring-0 h-auto py-1"
            />
          </SimField>

          <SimField label="Prime moyenne par adulte" unit="CHF/mois">
            <Input
              type="number"
              value={prime}
              onChange={(e) => setPrime(Number(e.target.value) || 0)}
              className="text-2xl font-semibold border-0 bg-transparent px-0 focus-visible:ring-0 h-auto py-1"
            />
          </SimField>
        </>
      }
      result={
        <>
          <div className="text-center mb-6">
            <div className={`inline-flex items-center justify-center w-16 h-16 rounded-2xl mb-4 ${result.eligible ? "bg-primary/10" : "bg-muted"}`}>
              {result.eligible ? <Check className="w-8 h-8 text-primary" /> : <X className="w-8 h-8 text-muted-foreground" />}
            </div>
            <p className="text-xs uppercase tracking-widest text-muted-foreground mb-2">
              {result.eligible ? "Éligibilité probable" : "Non éligible"}
            </p>
            {result.eligible ? (
              <>
                <p className="text-4xl md:text-5xl font-bold bg-gradient-to-r from-primary to-accent bg-clip-text text-transparent">
                  CHF {result.subsideMin}–{result.subsideMax}
                </p>
                <p className="text-xs text-muted-foreground mt-1">par mois et par adulte</p>
              </>
            ) : (
              <p className="text-2xl font-semibold text-muted-foreground">Hors barème cantonal</p>
            )}
          </div>

          <div className="rounded-xl bg-background/60 border border-border/40 p-4 mb-5 text-sm text-foreground">
            {result.message}
          </div>

          {result.eligible && (
            <div className="rounded-xl bg-primary/10 border border-primary/30 p-4 mb-5">
              <p className="text-xs uppercase tracking-widest text-primary mb-1">Gain annuel estimé</p>
              <p className="text-2xl font-bold text-primary">
                jusqu'à CHF {result.gain.toLocaleString("fr-CH")}
              </p>
            </div>
          )}

          <div className="flex-1" />

          <Button variant="outline" className="w-full mt-2" asChild>
            <a href="/assurances/sante">🏥 Analyse gratuite de mes primes</a>
          </Button>
        </>
      }
    />
  );
};
