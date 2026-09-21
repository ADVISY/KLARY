"use client";

import { useState, useMemo, useEffect } from "react";
import Link from "next/link";
import { useSearchParams, useRouter } from "next/navigation";
import {
  synthese,
  formatCHF,
  type DossierClient,
} from "@/lib/hypotheque/calculs";
import { PlanClientPrint } from "./PlanClientPrint";

type Phase = 1 | 2 | 3 | 4 | 5 | 6 | 7;

const PHASES: { id: Phase; title: string; duree: string; objectif: string }[] = [
  { id: 1, title: "Accueil & cadrage", duree: "5 min", objectif: "Poser le deal honnête" },
  { id: 2, title: "Découverte", duree: "15-20 min", objectif: "Faire parler, chiffrer" },
  { id: 3, title: "Reformulation", duree: "2 min", objectif: "Renvoyer son rêve" },
  { id: 4, title: "Révélation", duree: "5-10 min", objectif: "Nommer le 3ᵉ pilier" },
  { id: 5, title: "Chiffrage", duree: "10 min", objectif: "Les 8 calculs honnêtes" },
  { id: 6, title: "Closing", duree: "5 min", objectif: "Yes ladder + objections" },
  { id: 7, title: "Signature & suivi", duree: "5 min", objectif: "Conformité art. 45 LSA" },
];

const DEFAULT_DOSSIER: DossierClient = {
  prixBien: 600000,
  revenuAnnuel: 78000,
  loyerMensuel: 1800,
  versementMensuel: 200,
  anneesDuree: 15,
  tauxMarginal: 0.25,
  rendementAnnuel: 0.03,
};

export function PremierPlanLogementWizard() {
  const [phase, setPhase] = useState<Phase>(1);
  const [dossier, setDossier] = useState<DossierClient>(DEFAULT_DOSSIER);
  const [simId, setSimId] = useState<string | null>(null);
  const [saving, setSaving] = useState(false);
  const [saved, setSaved] = useState(false);
  const s = useMemo(() => synthese(dossier), [dossier]);
  const params = useSearchParams();
  const router = useRouter();

  // Charger une simulation existante depuis l'URL ?load=<id>
  useEffect(() => {
    const loadId = params.get("load");
    if (!loadId) return;
    (async () => {
      const res = await fetch(`/api/outils/hypotheque/load?id=${loadId}`);
      if (!res.ok) return;
      const data = await res.json();
      if (data.dossier) {
        setDossier({ ...DEFAULT_DOSSIER, ...data.dossier });
        setSimId(loadId);
      }
    })();
  }, [params]);

  const setField = <K extends keyof DossierClient>(key: K, value: DossierClient[K]) =>
    setDossier((d) => ({ ...d, [key]: value }));

  const sauvegarder = async () => {
    setSaving(true);
    setSaved(false);
    try {
      const res = await fetch("/api/outils/hypotheque/save", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ id: simId, dossier, synthese: s }),
      });
      const data = await res.json();
      if (data.id) {
        setSimId(data.id);
        setSaved(true);
        setTimeout(() => setSaved(false), 2500);
        if (!simId) {
          router.replace(`/outils/hypotheque?load=${data.id}`);
        }
      }
    } finally {
      setSaving(false);
    }
  };

  return (
    <div className="max-w-[1200px] mx-auto p-4 md:p-8">
      <header className="mb-8 flex flex-wrap items-start justify-between gap-4">
        <div>
          <div className="text-xs font-bold tracking-widest uppercase text-klary-orange mb-2">
            Outil conseiller · Hypothèque
          </div>
          <h1 className="text-3xl md:text-4xl font-bold text-klary-navy mb-3">
            Premier Plan Logement
          </h1>
          <p className="text-klary-grey max-w-2xl">
            Guide de RDV en 7 phases avec les 8 calculs à poser en direct
            devant le client. Basé sur le manuel Optimis 2026 et les
            garde-fous d&apos;honnêteté du contrat lié Assura.
          </p>
        </div>
        <div className="flex flex-col gap-2">
          <button
            onClick={sauvegarder}
            disabled={saving}
            className={`px-4 py-2 rounded-lg text-sm font-semibold transition ${
              saved
                ? "bg-emerald-600 text-white"
                : "bg-klary-navy text-white hover:bg-klary-navy/90 disabled:opacity-50"
            }`}
          >
            {saving ? "…" : saved ? "✓ Sauvegardé" : simId ? "Mettre à jour" : "💾 Sauvegarder"}
          </button>
          <Link
            href="/outils/hypotheque/historique"
            className="px-4 py-2 rounded-lg text-sm font-semibold border border-klary-light-grey text-klary-navy hover:border-klary-orange transition text-center"
          >
            📚 Historique
          </Link>
        </div>
      </header>

      {/* Stepper phases */}
      <nav className="mb-8 overflow-x-auto">
        <ol className="flex gap-2 min-w-max">
          {PHASES.map((p) => {
            const active = p.id === phase;
            const done = p.id < phase;
            return (
              <li key={p.id}>
                <button
                  onClick={() => setPhase(p.id)}
                  className={`px-4 py-3 rounded-xl text-left transition min-w-[140px] ${
                    active
                      ? "bg-klary-navy text-white shadow-lg"
                      : done
                      ? "bg-klary-orange/10 text-klary-orange border border-klary-orange/30"
                      : "bg-white border border-klary-light-grey text-klary-grey hover:border-klary-navy"
                  }`}
                >
                  <div className="text-xs opacity-70 mb-1">
                    Phase {p.id} · {p.duree}
                  </div>
                  <div className="font-bold text-sm">{p.title}</div>
                </button>
              </li>
            );
          })}
        </ol>
      </nav>

      {/* Layout : colonne gauche = contenu phase, droite = mini-carte chiffres client */}
      <div className="grid gap-6 lg:grid-cols-[1fr_320px]">
        <section className="bg-white rounded-2xl border border-klary-light-grey p-6 md:p-8 min-h-[500px]">
          {phase === 1 && <Phase1 />}
          {phase === 2 && <Phase2 dossier={dossier} setField={setField} />}
          {phase === 3 && <Phase3 dossier={dossier} s={s} />}
          {phase === 4 && <Phase4 />}
          {phase === 5 && <Phase5 dossier={dossier} s={s} setField={setField} />}
          {phase === 6 && <Phase6 />}
          {phase === 7 && <Phase7 dossier={dossier} />}

          <div className="mt-8 pt-6 border-t border-klary-light-grey flex items-center justify-between gap-3">
            <button
              onClick={() => setPhase((p) => Math.max(1, p - 1) as Phase)}
              disabled={phase === 1}
              className="px-4 py-2 rounded-lg text-sm font-semibold border border-klary-light-grey text-klary-navy hover:bg-klary-cream disabled:opacity-40 disabled:cursor-not-allowed"
            >
              ← Phase précédente
            </button>
            <div className="text-xs text-klary-grey">
              {phase}/7 · {PHASES[phase - 1].objectif}
            </div>
            <button
              onClick={() => setPhase((p) => Math.min(7, p + 1) as Phase)}
              disabled={phase === 7}
              className="px-5 py-2 rounded-lg text-sm font-semibold bg-klary-orange text-white hover:bg-klary-orange/90 disabled:opacity-40 disabled:cursor-not-allowed"
            >
              Phase suivante →
            </button>
          </div>
        </section>

        {/* Composant impression (visible seulement à l'impression) */}
        <PlanClientPrint dossier={dossier} s={s} />

        {/* Aside chiffres client toujours visibles */}
        <aside className="lg:sticky lg:top-6 self-start bg-klary-navy text-white rounded-2xl p-5 space-y-3 text-sm">
          <div className="text-[10px] uppercase tracking-widest text-white/60 font-bold mb-2">
            Chiffres client
          </div>
          <ChiffreLine label="Prix du bien" value={`${formatCHF(dossier.prixBien)} CHF`} />
          <ChiffreLine label="Revenu annuel" value={`${formatCHF(dossier.revenuAnnuel)} CHF`} />
          <ChiffreLine label="Loyer actuel" value={`${formatCHF(dossier.loyerMensuel)} /mois`} />
          <ChiffreLine label="Versement 3a proposé" value={`${formatCHF(dossier.versementMensuel)} /mois`} />
          <ChiffreLine label="Durée du plan" value={`${dossier.anneesDuree} ans`} />

          <div className="pt-3 mt-3 border-t border-white/10">
            <div className="text-[10px] uppercase tracking-widest text-klary-orange font-bold mb-2">
              Verdict banque
            </div>
            {s.projetPasse ? (
              <div className="text-emerald-300 text-sm font-semibold">
                ✓ Le projet passe côté banque
              </div>
            ) : (
              <div>
                <div className="text-red-300 text-sm font-semibold">
                  ✗ Projet trop élevé actuellement
                </div>
                <div className="text-xs text-white/70 mt-1">
                  Capacité max : {formatCHF(s.capaciteAchatMax)} CHF
                </div>
                <div className="text-xs text-white/70">
                  Manque : {formatCHF(Math.abs(s.ecartCapacite))} CHF de capacité
                </div>
              </div>
            )}
          </div>
        </aside>
      </div>
    </div>
  );
}

function ChiffreLine({ label, value }: { label: string; value: string }) {
  return (
    <div className="flex items-center justify-between gap-3">
      <span className="text-white/60 text-xs">{label}</span>
      <span className="font-semibold">{value}</span>
    </div>
  );
}

// ═══════════ Phase 1 · Accueil & cadrage ═══════════
function Phase1() {
  return (
    <div>
      <PhaseHeader n={1} title="Accueil & cadrage" duree="5 min" />
      <div className="mt-6 space-y-4">
        <div className="bg-klary-cream/60 rounded-xl p-5">
          <div className="text-xs font-bold uppercase text-klary-orange mb-2 tracking-widest">
            📢 Ce que tu dis (mot pour mot)
          </div>
          <p className="text-klary-navy leading-relaxed italic">
            « Aujourd&apos;hui l&apos;idée c&apos;est simple : on regarde votre
            situation, on voit si devenir propriétaire est réaliste et sous
            combien de temps. Si c&apos;est jouable je vous montre comment ; si
            ça ne l&apos;est pas, je vous le dis franchement. Ça vous va comme
            deal ? »
          </p>
        </div>
        <div className="bg-emerald-50 border-l-4 border-emerald-500 rounded p-4 text-sm text-emerald-900">
          Le <strong>« je vous le dirai si ça ne marche pas »</strong> désarme
          et crédibilise. C&apos;est aussi vrai. Attends le « oui » du client
          avant de passer à la phase 2.
        </div>
      </div>
    </div>
  );
}

// ═══════════ Phase 2 · Découverte ═══════════
function Phase2({
  dossier,
  setField,
}: {
  dossier: DossierClient;
  setField: <K extends keyof DossierClient>(key: K, value: DossierClient[K]) => void;
}) {
  return (
    <div>
      <PhaseHeader n={2} title="Découverte" duree="15-20 min" />
      <p className="text-klary-grey mt-2 mb-6">
        Client parle <strong>70 %</strong> du temps. Questions ouvertes
        d&apos;abord, chiffres ensuite.
      </p>

      <div className="grid md:grid-cols-2 gap-6 mb-6">
        <div className="bg-klary-cream/60 rounded-xl p-5">
          <div className="text-xs font-bold uppercase text-klary-orange mb-3 tracking-widest">
            Questions ouvertes
          </div>
          <ul className="space-y-2 text-sm text-klary-navy">
            <li>◆ Devenir propriétaire, rêve de longue date ou récent ?</li>
            <li>◆ Le projet : appart, maison, où, combien de pièces ?</li>
            <li>◆ Qu&apos;est-ce qui vous a empêché de vous lancer jusqu&apos;ici ?</li>
          </ul>
        </div>
        <div className="bg-klary-cream/60 rounded-xl p-5">
          <div className="text-xs font-bold uppercase text-klary-orange mb-3 tracking-widest">
            Questions fermées
          </div>
          <ul className="space-y-2 text-sm text-klary-navy">
            <li>• Projet seul ou à deux ?</li>
            <li>• Pas de poursuites en cours ?</li>
            <li>• Combien épargné par mois aujourd&apos;hui ?</li>
          </ul>
        </div>
      </div>

      <div className="border-t border-klary-light-grey pt-6">
        <div className="text-xs font-bold uppercase text-klary-orange mb-4 tracking-widest">
          Identité client (pour le PDF récapitulatif)
        </div>
        <div className="grid gap-4 md:grid-cols-2 mb-6">
          <TextInput
            label="Prénom"
            value={dossier.clientPrenom || ""}
            onChange={(v) => setField("clientPrenom", v)}
          />
          <TextInput
            label="Nom"
            value={dossier.clientNom || ""}
            onChange={(v) => setField("clientNom", v)}
          />
          <TextInput
            label="Type de bien (appart, maison, PPE...)"
            value={dossier.typeBien || ""}
            onChange={(v) => setField("typeBien", v)}
          />
          <TextInput
            label="Localité visée"
            value={dossier.localite || ""}
            onChange={(v) => setField("localite", v)}
          />
        </div>

        <div className="text-xs font-bold uppercase text-klary-orange mb-4 tracking-widest">
          Chiffres client
        </div>
        <div className="grid gap-4 md:grid-cols-2">
          <NumberInput
            label="Prix du bien visé (CHF)"
            value={dossier.prixBien}
            step={10000}
            onChange={(v) => setField("prixBien", v)}
          />
          <NumberInput
            label="Revenu annuel brut (CHF)"
            value={dossier.revenuAnnuel}
            step={1000}
            onChange={(v) => setField("revenuAnnuel", v)}
          />
          <NumberInput
            label="Loyer mensuel actuel (CHF)"
            value={dossier.loyerMensuel}
            step={50}
            onChange={(v) => setField("loyerMensuel", v)}
          />
          <NumberInput
            label="Versement 3a proposé (CHF/mois)"
            value={dossier.versementMensuel}
            step={50}
            onChange={(v) => setField("versementMensuel", v)}
          />
          <NumberInput
            label="Durée du plan (années)"
            value={dossier.anneesDuree}
            step={1}
            min={5}
            max={30}
            onChange={(v) => setField("anneesDuree", v)}
          />
          <NumberInput
            label="Taux marginal fiscal estimé (%)"
            value={Math.round((dossier.tauxMarginal ?? 0.25) * 100)}
            step={1}
            min={10}
            max={45}
            onChange={(v) => setField("tauxMarginal", v / 100)}
          />
        </div>
      </div>
    </div>
  );
}

// ═══════════ Phase 3 · Reformulation ═══════════
function Phase3({ dossier, s }: { dossier: DossierClient; s: ReturnType<typeof synthese> }) {
  return (
    <div>
      <PhaseHeader n={3} title="Reformulation" duree="2 min" />
      <div className="mt-6">
        <div className="bg-klary-cream/60 rounded-xl p-5 mb-4">
          <div className="text-xs font-bold uppercase text-klary-orange mb-3 tracking-widest">
            📢 Reformulation type (adapte les mots)
          </div>
          <p className="text-klary-navy leading-relaxed italic">
            « Donc si je résume : vous voulez un bien à{" "}
            <strong className="not-italic bg-klary-orange/20 px-1">
              {formatCHF(dossier.prixBien)} CHF
            </strong>
            , votre blocage principal c&apos;est l&apos;apport, et
            aujourd&apos;hui vous perdez{" "}
            <strong className="not-italic bg-klary-orange/20 px-1">
              {formatCHF(s.loyerPerdu)} CHF
            </strong>{" "}
            sur {dossier.anneesDuree} ans en loyer. Si je vous montre un moyen
            de transformer une partie de ce que vous perdez en patrimoine, tout
            en payant moins d&apos;impôts, ça vaut le coup qu&apos;on continue ? »
          </p>
        </div>
        <div className="bg-emerald-50 border-l-4 border-emerald-500 rounded p-4 text-sm text-emerald-900">
          Le <strong>« oui »</strong> ici = le client s&apos;engage à écouter la
          solution. Sans ce oui, ne passe pas à la révélation.
        </div>
      </div>
    </div>
  );
}

// ═══════════ Phase 4 · Révélation ═══════════
function Phase4() {
  const leviers = [
    { icon: "🏠", titre: "Accession", pitch: "Un dossier que la banque prend au sérieux" },
    { icon: "📈", titre: "Épargne qui travaille", pitch: "Nantissement : vous gardez le capital, il fructifie" },
    { icon: "💰", titre: "Fiscalité", pitch: "~1 500 à 2 500 CHF d'impôt en moins par an" },
    { icon: "🛡", titre: "Protection famille", pitch: "Décès / incapacité couverts dès le 1er franc" },
    { icon: "⚖", titre: "Succession", pitch: "Transmission directe hors succession" },
  ];
  return (
    <div>
      <PhaseHeader n={4} title="Révélation — le moment 3ᵉ pilier" duree="5-10 min" />
      <div className="mt-6 space-y-4">
        <div className="bg-klary-cream/60 rounded-xl p-5">
          <div className="text-xs font-bold uppercase text-klary-orange mb-3 tracking-widest">
            📢 Le pitch de révélation
          </div>
          <p className="text-klary-navy leading-relaxed italic">
            « L&apos;outil qu&apos;on utilise, c&apos;est le <strong className="not-italic">pilier 3a</strong>. Mais oubliez
            ce que vous croyez savoir : ici ce n&apos;est pas un truc de retraite dans
            40 ans. C&apos;est un <strong className="not-italic">accélérateur d&apos;apport</strong> : la banque le voit
            comme une épargne sérieuse, ça la rassure, et on peut le mettre en
            gage pour compléter votre apport sans le liquider. »
          </p>
        </div>

        <div className="grid gap-3 md:grid-cols-2">
          {leviers.map((l, i) => (
            <div key={i} className="bg-white border border-klary-light-grey rounded-xl p-4">
              <div className="text-2xl mb-1">{l.icon}</div>
              <div className="font-bold text-klary-navy">{l.titre}</div>
              <div className="text-sm text-klary-grey mt-1">{l.pitch}</div>
            </div>
          ))}
        </div>

        <div className="bg-amber-50 border-l-4 border-amber-500 rounded p-4 text-sm text-amber-900 mt-4">
          <strong>⚠ Garde-fous :</strong>
          <ul className="mt-2 space-y-1 list-disc pl-5">
            <li>Jamais « 7 258 CHF d&apos;impôt en moins » (c&apos;est le plafond, pas l&apos;économie)</li>
            <li>Jamais « propriétaire l&apos;an prochain »</li>
            <li>Le nantissement ne remplace PAS les 10 % durs</li>
            <li>Le rendement 3 % n&apos;est pas garanti</li>
          </ul>
        </div>
      </div>
    </div>
  );
}

// ═══════════ Phase 5 · Chiffrage (les 8 calculs) ═══════════
function Phase5({
  dossier,
  s,
  setField,
}: {
  dossier: DossierClient;
  s: ReturnType<typeof synthese>;
  setField: <K extends keyof DossierClient>(key: K, value: DossierClient[K]) => void;
}) {
  return (
    <div>
      <PhaseHeader n={5} title="Chiffrage — les 8 calculs honnêtes" duree="10 min" />
      <p className="text-klary-grey mt-2 mb-6">
        Courbe émotionnelle : calculs 1-3 « c&apos;est dur » → 4-8 « c&apos;est faisable ».
      </p>

      {/* Mini éditeur de version */}
      <div className="mb-6 flex flex-wrap gap-3 text-xs">
        <label className="flex items-center gap-2 text-klary-grey">
          Versement /mois :
          <input
            type="number"
            value={dossier.versementMensuel}
            step={50}
            onChange={(e) => setField("versementMensuel", Number(e.target.value))}
            className="w-24 px-2 py-1 border border-klary-light-grey rounded text-klary-navy font-semibold"
          />
        </label>
        <label className="flex items-center gap-2 text-klary-grey">
          Durée :
          <input
            type="number"
            value={dossier.anneesDuree}
            step={1}
            min={5}
            max={30}
            onChange={(e) => setField("anneesDuree", Number(e.target.value))}
            className="w-16 px-2 py-1 border border-klary-light-grey rounded text-klary-navy font-semibold"
          />
          ans
        </label>
      </div>

      <div className="grid gap-3 md:grid-cols-2">
        <CalcCard
          n={1}
          titre="Apport nécessaire"
          formule="20 % du prix (dont 10 % durs)"
          value={`${formatCHF(s.apport.total)} CHF`}
          detail={`Dur : ${formatCHF(s.apport.dur)} · Mou (3a/LPP) : ${formatCHF(s.apport.mou)}`}
          tone="dur"
        />
        <CalcCard
          n={2}
          titre="Charges annuelles"
          formule="5,89 % du prix (banque)"
          value={`${formatCHF(s.chargesTheoriques)} CHF/an`}
          detail={`Soit ${formatCHF(s.chargesTheoriques / 12)} CHF/mois`}
          tone="dur"
        />
        <CalcCard
          n={3}
          titre="Revenu annuel requis"
          formule="charges ÷ 33 %"
          value={`${formatCHF(s.revenuRequis)} CHF`}
          detail={
            s.projetPasse
              ? `✓ Vous avez ${formatCHF(dossier.revenuAnnuel)} CHF`
              : `✗ Manque ${formatCHF(s.revenuRequis - dossier.revenuAnnuel)} CHF`
          }
          tone={s.projetPasse ? "ok" : "dur"}
        />
        <CalcCard
          n={4}
          titre="Capacité d'achat maximale"
          formule="(revenu × 33 %) ÷ 5,89 %"
          value={`${formatCHF(s.capaciteAchatMax)} CHF`}
          detail={
            s.ecartCapacite >= 0
              ? `✓ Marge de ${formatCHF(s.ecartCapacite)} CHF`
              : `✗ Réajuster à ${formatCHF(s.capaciteAchatMax)} CHF`
          }
          tone="ok"
        />
        <CalcCard
          n={5}
          titre="Économie fiscale /an"
          formule="versement × taux marginal"
          value={`${formatCHF(s.economieFiscale.min)}-${formatCHF(s.economieFiscale.max)} CHF`}
          detail={`Médian ${formatCHF(s.economieFiscale.median)} CHF (varie selon canton)`}
          tone="ok"
        />
        <CalcCard
          n={6}
          titre="Effort réel /mois"
          formule="versement − économie d'impôt"
          value={`${formatCHF(s.effortReel.net)} CHF`}
          detail={`Brut ${formatCHF(s.effortReel.brut)} − impôt ${formatCHF(s.effortReel.economieFiscale)}`}
          tone="ok"
        />
        <CalcCard
          n={7}
          titre={`Capital à ${dossier.anneesDuree} ans`}
          formule="V × [((1+r)ⁿ − 1) ÷ r] · r = 3 %"
          value={`${formatCHF(s.capitalFutur.avecRendement)} CHF`}
          detail={`Sans rendement : ${formatCHF(s.capitalFutur.sansRendement)} CHF`}
          tone="ok"
        />
        <CalcCard
          n={8}
          titre="Bilan net en sa faveur"
          formule="capital − effort net cumulé"
          value={`+${formatCHF(s.bilanNet.benefice)} CHF`}
          detail={`Capital ${formatCHF(s.bilanNet.capital)} − effort net ${formatCHF(s.bilanNet.effortNetCumule)}`}
          tone="ok"
        />
      </div>

      <div className="mt-6 bg-klary-navy text-white rounded-xl p-5">
        <div className="text-xs uppercase tracking-widest text-klary-orange font-bold mb-2">
          💡 Loyer perdu sur {dossier.anneesDuree} ans
        </div>
        <div className="text-3xl font-bold">{formatCHF(s.loyerPerdu)} CHF</div>
        <div className="text-white/70 text-sm mt-1">
          « Cet argent, il part et vous ne le reverrez jamais. » — puis silence.
        </div>
      </div>
    </div>
  );
}

// ═══════════ Phase 6 · Closing ═══════════
function Phase6() {
  const yesLadder = [
    "Dans 10 ans vous paierez un logement de toute façon, vrai ou faux ? → oui",
    "Vous préférez construire VOTRE patrimoine que celui de votre proprio ? → oui",
    "Payer moins d'impôts pendant que vous épargnez pour vous, ça vous dérange ? → non",
    "150 francs, le prix d'un abo fitness, vous pouvez le sortir ? → oui",
    "Protéger votre famille en cas de pépin, vous préférez, oui ? → oui",
    "Alors y a-t-il une seule bonne raison d'attendre ? 🎯",
  ];
  const objections = [
    {
      q: "Le 3ᵉ pilier c'est de l'arnaque",
      r: "Vous avez à moitié raison : l'arnaque, c'est la façon dont certains le vendent, pas l'outil. C'est reconnu par l'État, la déduction est garantie par l'État, et l'argent reste à vous. Une arnaque, l'argent disparaît. Là il ne bouge pas de votre poche. Et vous avez 14 jours pour tout annuler.",
    },
    {
      q: "10 ans, c'est trop long",
      r: "Ces 10 ans passent de toute façon. La seule question : dans 10 ans, propriétaire, ou toujours locataire avec 10 ans de loyer partis en fumée ? Et vous pouvez baisser, augmenter ou mettre en pause quand vous voulez.",
    },
    {
      q: "Je vais réfléchir",
      r: "Bien sûr. Juste : c'est laquelle des trois — le temps, le montant, ou vous ne me faites pas encore confiance ? Qu'on règle ça maintenant pendant que je suis là.",
    },
    {
      q: "Finalement je ne veux plus",
      r: "On signe rien, respirez. Mais entre nous : c'est le projet que vous ne voulez plus, ou juste le chiffre qui vous a serré le ventre ? Si c'est le montant, on descend à 150 et c'est réglé.",
    },
    {
      q: "C'est trop cher",
      r: "On oublie le plafond. À 150 francs, ça passe pour vous ? Le but c'est de démarrer, on augmentera quand vous serez à l'aise.",
    },
  ];
  return (
    <div>
      <PhaseHeader n={6} title="Closing" duree="5 min" />
      <div className="mt-6 space-y-6">
        <div className="bg-klary-cream/60 rounded-xl p-5">
          <div className="text-xs font-bold uppercase text-klary-orange mb-3 tracking-widest">
            🪜 Yes ladder — le client se convainc lui-même
          </div>
          <ol className="space-y-2 text-sm text-klary-navy list-decimal pl-5">
            {yesLadder.map((q, i) => (
              <li key={i}>{q}</li>
            ))}
          </ol>
        </div>

        <div>
          <div className="text-xs font-bold uppercase text-klary-orange mb-3 tracking-widest">
            💬 Bibliothèque d&apos;objections
          </div>
          <div className="space-y-2">
            {objections.map((o, i) => (
              <details key={i} className="bg-white border border-klary-light-grey rounded-xl p-4 group">
                <summary className="cursor-pointer font-semibold text-klary-navy list-none flex items-center justify-between">
                  <span>« {o.q} »</span>
                  <span className="text-klary-orange text-xs group-open:rotate-90 transition">▶</span>
                </summary>
                <p className="text-sm text-klary-grey mt-3 leading-relaxed">{o.r}</p>
              </details>
            ))}
          </div>
        </div>

        <div className="bg-emerald-50 border-l-4 border-emerald-500 rounded p-4 text-sm text-emerald-900">
          <strong>3 réflexes d&apos;or :</strong>
          <ol className="mt-2 space-y-1 list-decimal pl-5">
            <li>Un « non » soudain après un « oui » = peur d&apos;un chiffre. Ajuste le montant, pas le principe.</li>
            <li>Baisse toujours le montant (605 → 300 → 150) avant de perdre le client.</li>
            <li>Premier versement le mois prochain + ajustable = retire l&apos;engagement dans la douleur.</li>
          </ol>
        </div>
      </div>
    </div>
  );
}

// ═══════════ Phase 7 · Signature ═══════════
function Phase7({ dossier }: { dossier: DossierClient }) {
  const nomClient = [dossier.clientPrenom, dossier.clientNom].filter(Boolean).join(" ") || "Client";
  const checklist = [
    "Pièce d'identité + date de naissance + IBAN collectés",
    "Bénéficiaires (capital-décès) : à qui va le capital ?",
    "Questionnaire de santé rempli EXACTEMENT (fausse déclaration = couverture annulée)",
    "Droit de rétractation 14 jours annoncé toi-même → rassure le client",
    "Attestation fiscale annuelle expliquée",
    "RDV annuel programmé (montée en versement + lancement dossier accession)",
  ];
  const conformite = [
    "Fiche information art. 45 LSA remise en début de RDV",
    "Statut intermédiaire lié Assura mentionné (pas FINMA)",
    "nLPD : consentement données santé recueilli",
    "Publicité non trompeuse : jamais « 7 258 d'impôt en moins »",
    "Saisie LYTA/CRM : statut + motif après RDV",
  ];
  return (
    <div>
      <PhaseHeader n={7} title="Signature & suivi" duree="5 min" />

      {/* PDF pour le client */}
      <div className="mt-6 bg-gradient-to-br from-klary-orange to-klary-orange/80 text-white rounded-2xl p-6">
        <div className="flex items-start justify-between gap-4 flex-wrap">
          <div className="flex-1 min-w-[240px]">
            <div className="text-[10px] uppercase tracking-widest text-white/80 font-bold mb-1">
              À remettre au client
            </div>
            <h3 className="text-xl font-bold mb-1">Plan personnel PDF</h3>
            <p className="text-sm text-white/85">
              Récapitulatif imprimable A4 avec les chiffres calculés, le plan
              proposé et les 2 zones de signature. Prêt à remettre à{" "}
              <strong>{nomClient}</strong>.
            </p>
          </div>
          <button
            onClick={() => window.print()}
            className="px-5 py-3 bg-white text-klary-orange font-bold rounded-xl hover:shadow-lg transition text-sm inline-flex items-center gap-2"
          >
            <svg className="w-4 h-4" fill="none" stroke="currentColor" strokeWidth={2.5} viewBox="0 0 24 24">
              <path strokeLinecap="round" strokeLinejoin="round" d="M4 16v2a2 2 0 002 2h12a2 2 0 002-2v-2M7 10l5 5 5-5M12 15V3" />
            </svg>
            Télécharger le PDF
          </button>
        </div>
        <div className="mt-3 text-xs text-white/75 italic">
          Astuce : au clic, choisis « Enregistrer au format PDF » dans le
          dialogue d&apos;impression de ton navigateur. Le layout est déjà
          optimisé A4.
        </div>
      </div>

      <div className="mt-6 grid md:grid-cols-2 gap-6">
        <div>
          <div className="text-xs font-bold uppercase text-klary-orange mb-3 tracking-widest">
            ✍ Check-list signature
          </div>
          <ul className="space-y-2">
            {checklist.map((c, i) => (
              <li key={i} className="flex items-start gap-2 text-sm text-klary-navy">
                <input type="checkbox" className="mt-1 accent-klary-orange" />
                <span>{c}</span>
              </li>
            ))}
          </ul>
        </div>
        <div>
          <div className="text-xs font-bold uppercase text-klary-orange mb-3 tracking-widest">
            ⚠ Conformité Klary (lié Assura)
          </div>
          <ul className="space-y-2">
            {conformite.map((c, i) => (
              <li key={i} className="flex items-start gap-2 text-sm text-klary-navy">
                <input type="checkbox" className="mt-1 accent-klary-orange" />
                <span>{c}</span>
              </li>
            ))}
          </ul>
        </div>
      </div>
      <div className="mt-6 bg-klary-navy text-white rounded-xl p-5 text-sm">
        <div className="text-xs uppercase tracking-widest text-klary-orange font-bold mb-2">
          🎯 Après le RDV
        </div>
        Rétention = KPI n°1. Une résiliation précoce = reprise de commission
        (clawback Assura art. 4 annexe 1). Rappelle le client à J+7 pour
        confirmer qu&apos;il a reçu la police et n&apos;a pas de doute.
      </div>
    </div>
  );
}

// ═══════════ Composants utilitaires ═══════════

function PhaseHeader({ n, title, duree }: { n: number; title: string; duree: string }) {
  return (
    <div>
      <div className="text-xs font-bold uppercase text-klary-orange tracking-widest mb-1">
        Phase {n} · {duree}
      </div>
      <h2 className="text-2xl font-bold text-klary-navy">{title}</h2>
    </div>
  );
}

function TextInput({
  label,
  value,
  onChange,
}: {
  label: string;
  value: string;
  onChange: (v: string) => void;
}) {
  return (
    <label className="block">
      <span className="text-xs font-bold uppercase text-klary-grey tracking-widest mb-2 block">
        {label}
      </span>
      <input
        type="text"
        value={value}
        onChange={(e) => onChange(e.target.value)}
        className="w-full px-3 py-2 border border-klary-light-grey rounded-lg text-klary-navy font-semibold focus:outline-none focus:border-klary-orange"
      />
    </label>
  );
}

function NumberInput({
  label,
  value,
  step = 1,
  min,
  max,
  onChange,
}: {
  label: string;
  value: number;
  step?: number;
  min?: number;
  max?: number;
  onChange: (v: number) => void;
}) {
  return (
    <label className="block">
      <span className="text-xs font-bold uppercase text-klary-grey tracking-widest mb-2 block">
        {label}
      </span>
      <input
        type="number"
        value={value}
        step={step}
        min={min}
        max={max}
        onChange={(e) => onChange(Number(e.target.value))}
        className="w-full px-3 py-2 border border-klary-light-grey rounded-lg text-klary-navy font-semibold focus:outline-none focus:border-klary-orange"
      />
    </label>
  );
}

function CalcCard({
  n,
  titre,
  formule,
  value,
  detail,
  tone,
}: {
  n: number;
  titre: string;
  formule: string;
  value: string;
  detail: string;
  tone: "dur" | "ok";
}) {
  const border = tone === "dur" ? "border-red-200" : "border-emerald-200";
  const bg = tone === "dur" ? "bg-red-50/60" : "bg-emerald-50/60";
  const badge = tone === "dur" ? "bg-red-500" : "bg-emerald-500";
  return (
    <div className={`rounded-xl border p-4 ${border} ${bg}`}>
      <div className="flex items-start gap-3">
        <span className={`shrink-0 w-7 h-7 rounded-full text-white flex items-center justify-center font-bold text-sm ${badge}`}>
          {n}
        </span>
        <div className="flex-1 min-w-0">
          <div className="text-xs uppercase tracking-wide text-klary-grey">{formule}</div>
          <div className="font-bold text-klary-navy">{titre}</div>
          <div className="text-2xl font-bold text-klary-navy mt-1">{value}</div>
          <div className="text-xs text-klary-grey mt-1">{detail}</div>
        </div>
      </div>
    </div>
  );
}
