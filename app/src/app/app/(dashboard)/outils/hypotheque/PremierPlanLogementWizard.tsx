"use client";

import { useState, useMemo, useEffect } from "react";
import Link from "next/link";
import { useSearchParams, useRouter } from "next/navigation";
import {
  synthese,
  formatCHF,
  prevoyanceRequisePourApport,
  anneesNecessairesPourCapital,
  planPourObjectif,
  profilRisque3aRecommande,
  plafondsDisponiblesAnnuel,
  lppEstimeeSelonAge,
  type DossierClient,
  type ObjectifImmobilier,
} from "@/lib/hypotheque/calculs";
import { PlanClientPrint } from "./PlanClientPrint";

const DEFAULT_DOSSIER: DossierClient = {
  prixBien: 600000,
  revenuAnnuel: 90000,
  loyerMensuel: 1800,
  versementMensuel: 200,
  anneesDuree: 15,
  tauxMarginal: 0.25,
  rendementAnnuel: 0.03,
};

const DEFAULT_OBJECTIF: ObjectifImmobilier = {
  ageClient: 35,
  prixBienCible: 600000,
  horizonAchatAnnees: 10,
  epargneCashActuelle: 20000,
  lppExistante: 15000,
  troisieme_a_existant: 5000,
  rendementAnnuel: 0.03,
};

export function PremierPlanLogementWizard() {
  const [dossier, setDossier] = useState<DossierClient>(DEFAULT_DOSSIER);
  const [objectif, setObjectif] = useState<ObjectifImmobilier>(DEFAULT_OBJECTIF);
  const [simId, setSimId] = useState<string | null>(null);
  const [saving, setSaving] = useState(false);
  const [saved, setSaved] = useState(false);
  const s = useMemo(() => synthese(dossier), [dossier]);
  const plan = useMemo(() => planPourObjectif(objectif), [objectif]);
  const profil = useMemo(
    () => profilRisque3aRecommande(objectif.ageClient, objectif.horizonAchatAnnees),
    [objectif.ageClient, objectif.horizonAchatAnnees]
  );
  const plafonds = useMemo(() => plafondsDisponiblesAnnuel(objectif), [objectif]);
  const lppEstimee = useMemo(
    () => lppEstimeeSelonAge(objectif.ageClient, dossier.revenuAnnuel),
    [objectif.ageClient, dossier.revenuAnnuel]
  );
  const params = useSearchParams();
  const router = useRouter();

  const setObj = <K extends keyof ObjectifImmobilier>(key: K, value: ObjectifImmobilier[K]) =>
    setObjectif((o) => ({ ...o, [key]: value }));

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
        if (!simId) router.replace(`/outils/hypotheque?load=${data.id}`);
      }
    } finally {
      setSaving(false);
    }
  };

  return (
    <div className="max-w-[1100px] mx-auto p-4 md:p-8">
      {/* Header */}
      <header className="mb-8 flex flex-wrap items-start justify-between gap-4">
        <div>
          <div className="text-xs font-bold tracking-widest uppercase text-klary-orange mb-2">
            Simulateur hypothèque · Premier Plan Logement
          </div>
          <h1 className="text-3xl md:text-4xl font-bold text-klary-navy mb-3">
            Vos simulations en toute transparence
          </h1>
          <p className="text-klary-grey max-w-2xl">
            Chaque calcul est expliqué juste en dessous. Le client voit d&apos;où
            viennent les chiffres, les règles bancaires appliquées, et peut
            repartir avec son PDF nominatif.
          </p>
        </div>
        <div className="flex flex-col gap-2 shrink-0">
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
          <button
            onClick={() => window.print()}
            className="px-4 py-2 rounded-lg text-sm font-semibold bg-klary-orange text-white hover:bg-klary-orange/90 transition"
          >
            📄 Télécharger PDF
          </button>
          <Link
            href="/outils/hypotheque/historique"
            className="px-4 py-2 rounded-lg text-sm font-semibold border border-klary-light-grey text-klary-navy hover:border-klary-orange transition text-center"
          >
            📚 Historique
          </Link>
        </div>
      </header>

      {/* Bloc identité client (pour PDF) */}
      <section className="bg-white rounded-2xl border border-klary-light-grey p-6 mb-6">
        <div className="text-xs font-bold uppercase text-klary-orange mb-4 tracking-widest">
          Identité client (pour le PDF)
        </div>
        <div className="grid gap-4 md:grid-cols-4">
          <TextInput label="Prénom" value={dossier.clientPrenom || ""} onChange={(v) => setField("clientPrenom", v)} />
          <TextInput label="Nom" value={dossier.clientNom || ""} onChange={(v) => setField("clientNom", v)} />
          <TextInput label="Type de bien" value={dossier.typeBien || ""} onChange={(v) => setField("typeBien", v)} />
          <TextInput label="Localité" value={dossier.localite || ""} onChange={(v) => setField("localite", v)} />
        </div>
      </section>

      {/* Bloc chiffres client (paramètres partagés) */}
      <section className="bg-klary-navy text-white rounded-2xl p-6 mb-8">
        <div className="text-xs font-bold uppercase text-klary-orange mb-4 tracking-widest">
          Paramètres du dossier
        </div>
        <div className="grid gap-4 md:grid-cols-3">
          <NumberInputDark label="Prix du bien (CHF)" value={dossier.prixBien} step={10000} onChange={(v) => setField("prixBien", v)} />
          <NumberInputDark label="Revenu annuel brut (CHF)" value={dossier.revenuAnnuel} step={1000} onChange={(v) => setField("revenuAnnuel", v)} />
          <NumberInputDark label="Loyer actuel (CHF/mois)" value={dossier.loyerMensuel} step={50} onChange={(v) => setField("loyerMensuel", v)} />
          <NumberInputDark label="Versement 3a proposé (CHF/mois)" value={dossier.versementMensuel} step={50} onChange={(v) => setField("versementMensuel", v)} />
          <NumberInputDark label="Durée du plan (années)" value={dossier.anneesDuree} step={1} min={5} max={30} onChange={(v) => setField("anneesDuree", v)} />
          <NumberInputDark label="Taux marginal fiscal (%)" value={Math.round((dossier.tauxMarginal ?? 0.25) * 100)} step={1} min={10} max={45} onChange={(v) => setField("tauxMarginal", v / 100)} />
        </div>
      </section>

      {/* Simulateur inversé : plan personnel selon objectif */}
      <section className="bg-gradient-to-br from-klary-orange to-klary-orange/85 text-white rounded-2xl p-6 md:p-8 mb-8">
        <div className="text-xs font-bold uppercase text-white/85 tracking-widest mb-2">
          🎯 Objectif RDV · Conclure un 3a plafond plein
        </div>
        <h2 className="text-2xl md:text-3xl font-bold mb-2">
          Maxer la prévoyance partout, pas juste pour l&apos;apport
        </h2>
        <p className="text-white/85 text-sm mb-6 max-w-2xl">
          Renseigne le projet visé et la situation actuelle du client. On
          calcule le minimum nécessaire pour couvrir son apport, puis on
          te montre pourquoi viser directement le <strong>plafond plein
          annuel</strong> ({formatCHF(plafonds.plafondTotal)} CHF/an
          en {plafonds.nbComptes > 1 ? "couple avec 2 comptes 3a" : "célibataire"})
          multiplie l&apos;économie fiscale, le capital constitué et la
          protection famille.
        </p>

        {/* Toggle couple */}
        <div className="mb-4 flex items-center gap-3">
          <span className="text-xs uppercase tracking-widest text-white/85 font-bold">
            Situation :
          </span>
          <button
            onClick={() => setObj("ageConjoint", undefined)}
            className={`px-3 py-1.5 rounded-lg text-xs font-bold transition ${
              !objectif.ageConjoint
                ? "bg-white text-klary-orange"
                : "bg-white/10 text-white hover:bg-white/20"
            }`}
          >
            👤 Célibataire
          </button>
          <button
            onClick={() => setObj("ageConjoint", 35)}
            className={`px-3 py-1.5 rounded-lg text-xs font-bold transition ${
              objectif.ageConjoint
                ? "bg-white text-klary-orange"
                : "bg-white/10 text-white hover:bg-white/20"
            }`}
          >
            👥 Couple
          </button>
          {objectif.ageConjoint !== undefined && (
            <span className="text-xs text-white/80 ml-2">
              → 2 comptes 3a = plafond doublé ({formatCHF(plafonds.plafondTotal)} CHF/an)
            </span>
          )}
        </div>

        {/* Inputs profil client */}
        <div className="grid gap-4 md:grid-cols-4 mb-4">
          <NumberInputOrange
            label={objectif.ageConjoint !== undefined ? "Âge client 1" : "Âge du client"}
            value={objectif.ageClient}
            step={1}
            min={18}
            max={70}
            onChange={(v) => setObj("ageClient", v)}
            suffix="ans"
          />
          {objectif.ageConjoint !== undefined && (
            <NumberInputOrange
              label="Âge conjoint"
              value={objectif.ageConjoint}
              step={1}
              min={18}
              max={70}
              onChange={(v) => setObj("ageConjoint", v)}
              suffix="ans"
            />
          )}
          <NumberInputOrange
            label="Prix du bien visé"
            value={objectif.prixBienCible}
            step={10000}
            onChange={(v) => setObj("prixBienCible", v)}
            suffix="CHF"
          />
          <NumberInputOrange
            label="Achat dans"
            value={objectif.horizonAchatAnnees}
            step={1}
            min={1}
            max={30}
            onChange={(v) => setObj("horizonAchatAnnees", v)}
            suffix="ans"
          />
        </div>

        {/* Inputs situation actuelle */}
        <div className="grid gap-4 md:grid-cols-3 mb-6">
          <NumberInputOrange
            label="Épargne cash actuelle"
            value={objectif.epargneCashActuelle ?? 0}
            step={1000}
            onChange={(v) => setObj("epargneCashActuelle", v)}
            suffix="CHF"
          />
          <NumberInputOrange
            label={`3a déjà en place${objectif.ageConjoint !== undefined ? " (cumulé)" : ""}`}
            value={objectif.troisieme_a_existant ?? 0}
            step={1000}
            onChange={(v) => setObj("troisieme_a_existant", v)}
            suffix="CHF"
          />
          <NumberInputOrange
            label={`LPP mobilisable${objectif.ageConjoint !== undefined ? " (cumulée)" : ""}`}
            value={objectif.lppExistante ?? 0}
            step={1000}
            onChange={(v) => setObj("lppExistante", v)}
            suffix="CHF"
          />
        </div>

        {/* Profil recommandé auto selon âge */}
        <div className="bg-white/10 border border-white/20 rounded-lg p-4 mb-6">
          <div className="text-[10px] uppercase tracking-widest text-white/70 font-bold mb-2">
            🎓 Recommandation véhicule 3a selon l&apos;âge
          </div>
          <div className="flex flex-wrap items-center gap-3">
            <span className="text-lg font-bold text-white">{profil.vehicule}</span>
            <span className={`text-xs px-2 py-1 rounded-full font-bold ${
              profil.profil === "actions" ? "bg-emerald-500 text-white"
              : profil.profil === "equilibre" ? "bg-amber-500 text-white"
              : "bg-white/20 text-white"
            }`}>
              Profil {profil.profil} · rendement attendu {Math.round(profil.rendementAttendu * 100)} %
            </span>
          </div>
          <div className="text-xs text-white/80 mt-2 leading-relaxed">{profil.raison}</div>
          {lppEstimee > 0 && (objectif.lppExistante ?? 0) === 0 && (
            <div className="mt-3 pt-3 border-t border-white/10 text-xs text-white/85">
              💡 LPP estimée pour {objectif.ageClient} ans avec salaire {formatCHF(dossier.revenuAnnuel)} :{" "}
              <strong className="text-klary-cream">~{formatCHF(lppEstimee)} CHF</strong>.
              Pense à demander le certificat LPP exact au client.
            </div>
          )}
        </div>

        {/* Résultats */}
        <div className="bg-white text-klary-navy rounded-xl p-6">
          <div className="text-xs font-bold uppercase text-klary-orange tracking-widest mb-3">
            📊 Voici ton plan personnel
          </div>

          <div className="grid md:grid-cols-3 gap-4 mb-5">
            <PlanCard
              label="Nantissement annuel banque"
              value={`${formatCHF(plan.prevoyanceAConstituer / Math.max(1, objectif.horizonAchatAnnees))} CHF/an`}
              hint={`Sur ${objectif.horizonAchatAnnees} ans → total ${formatCHF(plan.prevoyanceAConstituer)} CHF de 3a à constituer`}
              tone="orange"
            />
            <PlanCard
              label={`Versement 3a mensuel requis${objectif.ageConjoint !== undefined ? ` (cumul ${plafonds.nbComptes} comptes)` : ""}`}
              value={`${formatCHF(plan.versement3aMensuelRequis)} CHF /mois`}
              hint={
                plan.faisable
                  ? `✓ Sous le plafond 3a mensuel (${formatCHF(plafonds.plafondMensuel)} CHF/mois pour ${plafonds.nbComptes} compte${plafonds.nbComptes > 1 ? "s" : ""})`
                  : `⚠ Dépasse le plafond 3a (${formatCHF(plafonds.plafondMensuel)} CHF/mois max) → cumuler avec 3b ou LPP`
              }
              tone={plan.faisable ? "ok" : "warn"}
            />
            <PlanCard
              label="Effort mensuel total"
              value={`${formatCHF(plan.totalEffortMensuel)} CHF /mois`}
              hint={`Dont ${formatCHF(plan.versement3aMensuelRequis)} en 3a + ${formatCHF(plan.cashMensuelRequis)} en épargne cash pour le dur`}
              tone="navy"
            />
          </div>

          {/* Décomposition apport */}
          <div className="border-t border-klary-light-grey pt-4">
            <div className="text-xs font-bold uppercase text-klary-navy tracking-widest mb-3">
              🧱 Décomposition de l&apos;apport {formatCHF(plan.apportTotal)} CHF (20 % du bien)
            </div>
            <div className="grid md:grid-cols-2 gap-3">
              <div className="bg-red-50 border border-red-200 rounded-lg p-4">
                <div className="text-xs uppercase tracking-widest text-red-700 font-bold mb-1">
                  10 % « Dur » ({formatCHF(plan.apportDur)} CHF)
                </div>
                <ul className="text-sm text-klary-navy space-y-1 mt-2">
                  <li>
                    ➕ Cash actuel : <strong>{formatCHF(objectif.epargneCashActuelle ?? 0)} CHF</strong>
                  </li>
                  <li>
                    ➕ 3a lié actuel : <strong>{formatCHF(objectif.troisieme_a_existant ?? 0)} CHF</strong>
                  </li>
                  {plan.cashADeposer > 0 ? (
                    <li className="text-red-700 font-semibold pt-1 border-t border-red-200">
                      ⚠ Il manque {formatCHF(plan.cashADeposer)} CHF cash → {formatCHF(plan.cashMensuelRequis)} CHF/mois à épargner
                    </li>
                  ) : (
                    <li className="text-emerald-700 font-semibold pt-1 border-t border-emerald-200">
                      ✓ Le dur est déjà couvert par la situation actuelle
                    </li>
                  )}
                </ul>
              </div>
              <div className="bg-emerald-50 border border-emerald-200 rounded-lg p-4">
                <div className="text-xs uppercase tracking-widest text-emerald-700 font-bold mb-1">
                  10 % « Mou » ({formatCHF(plan.apportMou)} CHF)
                </div>
                <ul className="text-sm text-klary-navy space-y-1 mt-2">
                  <li>
                    ➕ LPP mobilisable : <strong>{formatCHF(objectif.lppExistante ?? 0)} CHF</strong>
                  </li>
                  <li>
                    ➕ 3a en cours : va monter à <strong>{formatCHF(plan.prevoyanceAConstituer + (objectif.troisieme_a_existant ?? 0))} CHF</strong> en {objectif.horizonAchatAnnees} ans
                  </li>
                  {plan.prevoyanceAConstituer > 0 ? (
                    <li className="text-emerald-700 font-semibold pt-1 border-t border-emerald-200">
                      → Verser {formatCHF(plan.versement3aMensuelRequis)} CHF/mois au 3a nanti
                    </li>
                  ) : (
                    <li className="text-emerald-700 font-semibold pt-1 border-t border-emerald-200">
                      ✓ Le mou est déjà couvert par LPP + 3a existants
                    </li>
                  )}
                </ul>
              </div>
            </div>
          </div>

          {/* Stratégie MAX 3a — objectif Klary : plafond plein */}
          <div className="mt-6 bg-gradient-to-br from-klary-orange to-klary-orange/80 text-white rounded-xl p-6 border-4 border-klary-navy">
            <div className="text-[10px] uppercase tracking-widest text-white/90 font-bold mb-2">
              🎯 Recommandation Klary · Viser le 3a plafond plein
            </div>
            <h3 className="text-2xl font-bold mb-3">
              Le minimum couvre l&apos;apport. Le MAX change la vie.
            </h3>
            <p className="text-white/90 text-sm leading-relaxed mb-5">
              Le versement requis pour l&apos;apport est de{" "}
              <strong>{formatCHF(plan.versement3aMensuelRequis)} CHF/mois</strong>.
              Mais si le budget le permet, verser le <strong>plafond plein</strong>{" "}
              ({objectif.ageConjoint !== undefined ? `${plafonds.nbComptes} × 604 = ${formatCHF(plafonds.plafondMensuel)}` : "604"} CHF/mois)
              débloque un package d&apos;avantages nettement plus fort.
            </p>

            <div className="grid md:grid-cols-2 gap-4">
              {/* Min requis */}
              <div className="bg-white/15 border border-white/25 rounded-xl p-4">
                <div className="text-[10px] uppercase tracking-widest text-white/70 font-bold mb-1">
                  Option minimum
                </div>
                <div className="text-xl font-bold text-white mb-3">
                  {formatCHF(plan.versement3aMensuelRequis)} CHF /mois
                </div>
                <ul className="text-xs text-white/85 space-y-1.5">
                  <li>➕ Capital à {objectif.horizonAchatAnnees} ans : ~{formatCHF(plan.prevoyanceAConstituer)} CHF</li>
                  <li>➕ Économie fiscale : ~{formatCHF(Math.round(plan.versement3aMensuelRequis * 12 * (dossier.tauxMarginal ?? 0.25)))} CHF/an</li>
                  <li>➕ Couvre l&apos;apport &laquo; mou &raquo; · rien de plus</li>
                </ul>
              </div>

              {/* MAX plafond — mise en avant */}
              <div className="bg-white text-klary-navy border-4 border-white rounded-xl p-4 shadow-2xl">
                <div className="text-[10px] uppercase tracking-widest text-klary-orange font-bold mb-1">
                  ⭐ Option Klary recommandée
                </div>
                <div className="text-xl font-bold mb-3">
                  {formatCHF(plafonds.plafondMensuel)} CHF /mois
                  <span className="text-xs text-klary-grey ml-2">
                    ({objectif.ageConjoint !== undefined ? `${plafonds.nbComptes} × 604` : "plafond plein"})
                  </span>
                </div>
                <ul className="text-xs text-klary-navy space-y-1.5">
                  <li className="font-semibold">
                    ➕ Capital à {objectif.horizonAchatAnnees} ans : <span className="text-klary-orange">~{formatCHF(Math.round(plafonds.plafondMensuel * 12 * objectif.horizonAchatAnnees * (1 + (profil.rendementAttendu * objectif.horizonAchatAnnees) / 2)))} CHF</span>
                  </li>
                  <li className="font-semibold">
                    ➕ Économie fiscale : <span className="text-klary-orange">~{formatCHF(Math.round(plafonds.plafondTotal * (dossier.tauxMarginal ?? 0.25)))} CHF/an</span>
                  </li>
                  <li>✅ Couvre l&apos;apport ET dépasse largement</li>
                  <li>✅ Excédent = épargne retraite bonus</li>
                  <li>✅ Protection famille MAX</li>
                  <li>✅ Dossier banque BÉTON</li>
                </ul>
              </div>
            </div>

            {/* Gain différentiel MAX vs MIN */}
            <div className="mt-4 bg-klary-navy text-white rounded-lg p-4">
              <div className="text-[10px] uppercase tracking-widest text-klary-orange font-bold mb-2">
                💰 Le vrai gain de la stratégie MAX vs MIN
              </div>
              <div className="grid grid-cols-3 gap-3 text-center">
                <div>
                  <div className="text-2xl font-bold text-klary-orange">
                    +{formatCHF(Math.max(0, Math.round(plafonds.plafondMensuel * 12 * objectif.horizonAchatAnnees) - plan.prevoyanceAConstituer))}
                  </div>
                  <div className="text-[10px] uppercase tracking-widest text-white/70 mt-1">
                    Capital additionnel CHF
                  </div>
                </div>
                <div>
                  <div className="text-2xl font-bold text-klary-orange">
                    +{formatCHF(Math.max(0, Math.round((plafonds.plafondTotal - plan.versement3aMensuelRequis * 12) * (dossier.tauxMarginal ?? 0.25))))}
                  </div>
                  <div className="text-[10px] uppercase tracking-widest text-white/70 mt-1">
                    Économie fiscale/an CHF
                  </div>
                </div>
                <div>
                  <div className="text-2xl font-bold text-klary-orange">
                    +{formatCHF(Math.max(0, Math.round((plafonds.plafondTotal - plan.versement3aMensuelRequis * 12) * (dossier.tauxMarginal ?? 0.25) * objectif.horizonAchatAnnees)))}
                  </div>
                  <div className="text-[10px] uppercase tracking-widest text-white/70 mt-1">
                    Économie totale sur {objectif.horizonAchatAnnees} ans
                  </div>
                </div>
              </div>
            </div>
          </div>

          {/* Narrative pour le conseiller */}
          <div className="mt-5 bg-klary-navy text-white rounded-lg p-4 text-sm leading-relaxed">
            <div className="text-xs uppercase tracking-widest text-klary-orange font-bold mb-2">
              🗣 À dire au client
            </div>
            <p>
              « Vous avez {objectif.ageClient} ans
              {objectif.ageConjoint !== undefined
                ? ` et votre conjoint(e) ${objectif.ageConjoint} ans`
                : ""}
              . Pour un bien à{" "}
              <strong className="text-klary-orange">
                {formatCHF(objectif.prixBienCible)} CHF
              </strong>{" "}
              dans {objectif.horizonAchatAnnees} ans, le strict minimum serait{" "}
              <strong>
                {formatCHF(plan.versement3aMensuelRequis)} CHF/mois
              </strong>{" "}
              au 3a pour couvrir le 10 % « mou » d&apos;apport.
              {objectif.ageConjoint !== undefined && (
                <>
                  {" "}
                  Mais en couple, vous avez droit à <strong>2 comptes 3a</strong> avec un plafond cumulé de{" "}
                  <strong>{formatCHF(plafonds.plafondTotal)} CHF/an</strong>.
                </>
              )}
              <br /><br />
              <strong className="text-klary-orange">Ce qu&apos;on vous recommande :</strong>{" "}
              viser directement le <strong className="text-klary-orange">plafond plein
              {" "}({formatCHF(plafonds.plafondMensuel)} CHF/mois)</strong> via un{" "}
              <strong>{profil.vehicule}</strong> (profil {profil.profil}).
              Pourquoi ? Parce que la différence entre le minimum et le max, c&apos;est
              du <strong>capital gratuit</strong> pour vous : chaque franc versé au 3a
              vous rapporte {Math.round((dossier.tauxMarginal ?? 0.25) * 100)} % en économie
              d&apos;impôt immédiat + {Math.round(profil.rendementAttendu * 100)} % de rendement
              annuel. La banque, elle, n&apos;en sera que plus rassurée le jour de
              l&apos;achat. »
            </p>
          </div>
        </div>
      </section>

      {/* ═══ Les calculateurs ═══ */}
      <div className="space-y-6">
        {/* 1. Capacité d'achat max */}
        <CalcBlock
          numero="1"
          titre="Capacité d'achat maximale"
          resultat={`${formatCHF(s.capaciteAchatMax)} CHF`}
          detail={
            s.ecartCapacite >= 0
              ? `✓ Marge de ${formatCHF(s.ecartCapacite)} CHF par rapport au bien visé`
              : `✗ Écart de ${formatCHF(Math.abs(s.ecartCapacite))} CHF avec le bien visé`
          }
          tone={s.ecartCapacite >= 0 ? "ok" : "warn"}
        >
          <p>
            <strong>Formule :</strong> (revenu annuel brut × 33 %) ÷ 5,89 %
          </p>
          <p className="mt-2">
            <strong>Application :</strong> ({formatCHF(dossier.revenuAnnuel)} × 0,33) ÷ 0,0589 ={" "}
            <strong>{formatCHF(s.capaciteAchatMax)} CHF</strong>
          </p>
          <ul className="mt-3 space-y-1 list-disc pl-5 text-xs">
            <li><strong>33 %</strong> : taux d&apos;effort maximum autorisé par les banques suisses (directives ASB)</li>
            <li><strong>5,89 %</strong> : coût théorique annuel = 4 % intérêts (5 % × 80 % LTV) + 1 % amortissement obligatoire + 1 % charges d&apos;entretien</li>
            <li>Ce calcul ne tient pas compte des dettes existantes (leasing, crédits) ni des personnes à charge</li>
          </ul>
        </CalcBlock>

        {/* 2. Apport nécessaire */}
        <CalcBlock
          numero="2"
          titre="Apport nécessaire"
          resultat={`${formatCHF(s.apport.total)} CHF`}
          detail={`Dont ${formatCHF(s.apport.dur)} CHF « durs » (cash ou 3a hors LPP) et ${formatCHF(s.apport.mou)} CHF « mous » (LPP possible)`}
          tone="neutral"
        >
          <p>
            <strong>Règle :</strong> 20 % du prix du bien minimum, dont 10 % obligatoirement hors 2ᵉ pilier (« apport dur »).
          </p>
          <p className="mt-2">
            <strong>Application :</strong> {formatCHF(dossier.prixBien)} × 20 % ={" "}
            <strong>{formatCHF(s.apport.total)} CHF au total</strong>, dont{" "}
            {formatCHF(dossier.prixBien)} × 10 % = <strong>{formatCHF(s.apport.dur)} CHF durs</strong>
          </p>
          <ul className="mt-3 space-y-1 list-disc pl-5 text-xs">
            <li>Apport dur = cash épargne, 3a lié, donations, héritage. <strong>PAS le 2ᵉ pilier (LPP)</strong></li>
            <li>Apport mou = retrait LPP (EPL art. 30c) ou nantissement</li>
            <li>Depuis 2012 (directive FINMA) : les 10 % durs sont incompressibles</li>
          </ul>
        </CalcBlock>

        {/* 3. Charges théoriques */}
        <CalcBlock
          numero="3"
          titre="Charges annuelles théoriques"
          resultat={`${formatCHF(s.chargesTheoriques)} CHF /an`}
          detail={`Soit ${formatCHF(s.chargesTheoriques / 12)} CHF /mois — c'est le calcul que fait la banque, PAS ce que vous paierez réellement`}
          tone="neutral"
        >
          <p>
            <strong>Formule :</strong> prix du bien × 5,89 %
          </p>
          <p className="mt-2">
            <strong>Décomposition :</strong>
          </p>
          <ul className="mt-1 space-y-1 list-disc pl-5 text-xs">
            <li>Intérêts théoriques (prudence) : {formatCHF(dossier.prixBien * 0.04)} CHF/an (5 % × dette 80 %)</li>
            <li>Amortissement obligatoire : {formatCHF(dossier.prixBien * 0.01)} CHF/an (1 % du prix, pour ramener de 80 % à 66 % en 15 ans)</li>
            <li>Charges d&apos;entretien : {formatCHF(dossier.prixBien * 0.01)} CHF/an (1 % du prix, moyenne suisse pour PPE + travaux)</li>
          </ul>
          <p className="mt-3 text-xs italic">
            Ce chiffre théorique sert à la banque pour valider votre dossier. Les charges réelles sont souvent plus basses (taux réel 1,5-2,5 % vs 5 % théorique), mais la banque prend le pire cas.
          </p>
        </CalcBlock>

        {/* 4. Revenu requis */}
        <CalcBlock
          numero="4"
          titre="Revenu annuel requis pour ce bien"
          resultat={`${formatCHF(s.revenuRequis)} CHF /an`}
          detail={
            s.projetPasse
              ? `✓ Vous gagnez ${formatCHF(dossier.revenuAnnuel)} CHF/an → dossier acceptable`
              : `✗ Manque ${formatCHF(s.revenuRequis - dossier.revenuAnnuel)} CHF/an de revenu`
          }
          tone={s.projetPasse ? "ok" : "warn"}
        >
          <p>
            <strong>Formule :</strong> charges théoriques ÷ 33 %
          </p>
          <p className="mt-2">
            <strong>Application :</strong> {formatCHF(s.chargesTheoriques)} ÷ 0,33 ={" "}
            <strong>{formatCHF(s.revenuRequis)} CHF/an</strong>
          </p>
          <p className="mt-3 text-xs italic">
            La banque veut que le total des charges annuelles (intérêts + amortissement + entretien) reste sous 33 % du revenu brut. Au-delà, votre reste-à-vivre est jugé insuffisant.
          </p>
        </CalcBlock>

        {/* 5. Économie fiscale */}
        <CalcBlock
          numero="5"
          titre="Économie fiscale annuelle sur le 3a"
          resultat={`${formatCHF(s.economieFiscale.min)} à ${formatCHF(s.economieFiscale.max)} CHF /an`}
          detail={`Estimation médiane : ${formatCHF(s.economieFiscale.median)} CHF/an (varie selon canton et revenu)`}
          tone="ok"
        >
          <p>
            <strong>Formule :</strong> versement annuel × taux marginal fiscal
          </p>
          <p className="mt-2">
            <strong>Application :</strong> ({formatCHF(dossier.versementMensuel)} × 12) × {Math.round((dossier.tauxMarginal ?? 0.25) * 100)} % ={" "}
            <strong>{formatCHF(s.economieFiscale.median)} CHF/an</strong>
          </p>
          <ul className="mt-3 space-y-1 list-disc pl-5 text-xs">
            <li>Le versement 3a est <strong>intégralement déductible</strong> du revenu imposable (art. 33 al. 1 lit. e LIFD)</li>
            <li>Plafond 3a 2026 : 7 258 CHF/an (salarié avec LPP), 36 288 CHF/an (indépendant sans LPP)</li>
            <li>Taux marginal varie de <strong>15 % à 35 %</strong> selon canton + revenu (fourchette affichée)</li>
            <li className="text-red-600 font-semibold">Attention : jamais promettre &laquo; 7 258 CHF d&apos;économie &raquo;. C&apos;est le plafond de versement, pas l&apos;économie d&apos;impôt.</li>
          </ul>
        </CalcBlock>

        {/* 6. Effort réel */}
        <CalcBlock
          numero="6"
          titre="Effort réel après économie d'impôt"
          resultat={`${formatCHF(s.effortReel.net)} CHF /mois`}
          detail={`Brut ${formatCHF(s.effortReel.brut)} CHF − impôt économisé ${formatCHF(s.effortReel.economieFiscale)} CHF`}
          tone="ok"
        >
          <p>
            <strong>Formule :</strong> versement mensuel − (versement mensuel × taux marginal fiscal)
          </p>
          <p className="mt-2">
            <strong>Application :</strong> {formatCHF(dossier.versementMensuel)} − ({formatCHF(dossier.versementMensuel)} × {Math.round((dossier.tauxMarginal ?? 0.25) * 100)} %) ={" "}
            <strong>{formatCHF(s.effortReel.net)} CHF/mois</strong>
          </p>
          <p className="mt-3 text-xs italic">
            L&apos;économie d&apos;impôt se matérialise lors de la déclaration fiscale annuelle (attestation Assura remise en février N+1). Sur l&apos;année, votre effort de trésorerie effectif = versement mensuel × 12 − économie fiscale annuelle.
          </p>
        </CalcBlock>

        {/* 7. Capital futur */}
        <CalcBlock
          numero="7"
          titre={`Capital constitué à ${dossier.anneesDuree} ans`}
          resultat={`${formatCHF(s.capitalFutur.avecRendement)} CHF`}
          detail={`Sans rendement (garanti minimum) : ${formatCHF(s.capitalFutur.sansRendement)} CHF · avec rendement 3 % (non garanti) : ${formatCHF(s.capitalFutur.avecRendement)} CHF`}
          tone="ok"
        >
          <p>
            <strong>Formule (annuités capitalisées) :</strong> V × [((1 + r)ⁿ − 1) ÷ r]
          </p>
          <p className="mt-2">
            V = versement mensuel · r = taux d&apos;intérêt mensuel · n = nombre de mois
          </p>
          <p className="mt-2">
            <strong>Application :</strong> {formatCHF(dossier.versementMensuel)} × [((1 + 0,03/12)^{dossier.anneesDuree * 12} − 1) ÷ (0,03/12)] ={" "}
            <strong>{formatCHF(s.capitalFutur.avecRendement)} CHF</strong>
          </p>
          <ul className="mt-3 space-y-1 list-disc pl-5 text-xs">
            <li>Le rendement 3 % est prudent : c&apos;est la moyenne long terme des fonds de placement 3a modérés</li>
            <li>Rendement <strong>non garanti</strong> — dépend du marché financier</li>
            <li>Sans rendement (compte 3a bancaire simple), le capital équivaut aux versements cumulés</li>
          </ul>
        </CalcBlock>

        {/* 8. Bilan net */}
        <CalcBlock
          numero="8"
          titre="Bilan net en faveur du client"
          resultat={`+${formatCHF(s.bilanNet.benefice)} CHF`}
          detail={`Capital constitué ${formatCHF(s.bilanNet.capital)} CHF − effort net cumulé ${formatCHF(s.bilanNet.effortNetCumule)} CHF`}
          tone="ok"
        >
          <p>
            <strong>Formule :</strong> capital constitué − (effort mensuel net × 12 × années)
          </p>
          <p className="mt-2">
            <strong>Application :</strong> {formatCHF(s.bilanNet.capital)} − ({formatCHF(s.effortReel.net)} × 12 × {dossier.anneesDuree}) ={" "}
            <strong>+{formatCHF(s.bilanNet.benefice)} CHF</strong>
          </p>
          <p className="mt-3 text-xs italic">
            Ce bilan combine <strong>l&apos;économie fiscale accumulée</strong> et <strong>le rendement du capital</strong>. C&apos;est ce que vous « gagnez » en faisant du 3a plutôt que de rien faire. Le bilan est encore meilleur si vous utilisez le capital pour financer un achat immobilier (nantissement/retrait).
          </p>
        </CalcBlock>

        {/* Bonus : loyer perdu */}
        <div className="bg-klary-navy text-white rounded-2xl p-6">
          <div className="text-xs font-bold uppercase text-klary-orange mb-2 tracking-widest">
            📊 Bonus · Le loyer sur la même durée
          </div>
          <div className="text-4xl font-bold mb-2">
            {formatCHF(s.loyerPerdu)} CHF
          </div>
          <div className="text-white/70 text-sm mb-4">
            {formatCHF(dossier.loyerMensuel)} × 12 × {dossier.anneesDuree} ans = {formatCHF(s.loyerPerdu)} CHF de loyer payé sur la période, sans constitution de patrimoine.
          </div>
          <div className="text-xs text-white/60 italic border-t border-white/10 pt-3">
            Ce chiffre n&apos;est pas une critique du fait d&apos;être locataire (souplesse, mobilité), c&apos;est juste un ordre de grandeur pour aider à évaluer si un projet immobilier fait sens dans votre situation.
          </div>
        </div>

        {/* Hero — le message d'accroche */}
        <section className="bg-gradient-to-br from-klary-navy to-klary-navy/90 text-white rounded-2xl p-6 md:p-10 relative overflow-hidden">
          <div className="absolute top-0 right-0 w-96 h-96 bg-klary-orange/20 rounded-full blur-3xl -translate-y-1/2 translate-x-1/4" />
          <div className="relative">
            <div className="text-xs font-bold uppercase text-klary-orange mb-3 tracking-widest">
              🏠 La proposition Klary
            </div>
            <h2 className="text-3xl md:text-4xl font-bold mb-4 leading-tight">
              Comment devenir propriétaire<br />
              à partir de <span className="text-klary-orange">{formatCHF(dossier.versementMensuel)} CHF/mois</span>
            </h2>
            <p className="text-white/85 text-lg leading-relaxed max-w-3xl mb-6">
              L&apos;idée n&apos;est pas d&apos;économiser des années dans le vide.
              L&apos;idée, c&apos;est de <strong>structurer un plan
              d&apos;accession</strong> qui utilise le 3ᵉ pilier comme
              <strong> levier bancaire</strong> pour transformer un petit
              versement mensuel en dossier béton devant la banque.
            </p>

            <div className="grid md:grid-cols-4 gap-3">
              <div className="bg-white/10 rounded-lg p-4">
                <div className="text-[10px] uppercase tracking-widest text-white/60 mb-1">
                  Étape 1
                </div>
                <div className="font-bold text-klary-orange mb-1">Verser</div>
                <div className="text-xs text-white/85">
                  {formatCHF(dossier.versementMensuel)} CHF/mois au 3a (fiscalité + rendement + protection)
                </div>
              </div>
              <div className="bg-white/10 rounded-lg p-4">
                <div className="text-[10px] uppercase tracking-widest text-white/60 mb-1">
                  Étape 2
                </div>
                <div className="font-bold text-klary-orange mb-1">Constituer</div>
                <div className="text-xs text-white/85">
                  {formatCHF(s.capitalFutur.avecRendement)} CHF de capital en {dossier.anneesDuree} ans (versements + intérêts)
                </div>
              </div>
              <div className="bg-white/10 rounded-lg p-4">
                <div className="text-[10px] uppercase tracking-widest text-white/60 mb-1">
                  Étape 3
                </div>
                <div className="font-bold text-klary-orange mb-1">Nantir</div>
                <div className="text-xs text-white/85">
                  Utiliser le 3a comme garantie bancaire pour compléter l&apos;apport hypothécaire
                </div>
              </div>
              <div className="bg-klary-orange/25 border border-klary-orange rounded-lg p-4">
                <div className="text-[10px] uppercase tracking-widest text-klary-orange mb-1">
                  Étape 4
                </div>
                <div className="font-bold mb-1">Devenir propriétaire</div>
                <div className="text-xs text-white/85">
                  Dossier béton, taux préférentiel, 3a intact qui continue à générer
                </div>
              </div>
            </div>
          </div>
        </section>

        {/* Récapitulatif : pourquoi le 3a est un levier financier + nantissement */}
        <section className="bg-gradient-to-br from-klary-orange/10 via-white to-klary-navy/5 rounded-2xl border-2 border-klary-orange p-6 md:p-8">
          <div className="text-xs font-bold uppercase text-klary-orange mb-2 tracking-widest">
            🎯 Récapitulatif · Le 3ᵉ pilier, c&apos;est un outil (pas un produit)
          </div>
          <h2 className="text-2xl font-bold text-klary-navy mb-3">
            Pas juste une épargne retraite : un outil de financement immobilier
          </h2>
          <div className="bg-klary-navy text-white rounded-xl p-5 mb-6">
            <div className="text-sm text-white/85 leading-relaxed">
              Ce qui rend le 3ᵉ pilier unique, c&apos;est qu&apos;il fait{" "}
              <strong className="text-klary-orange">3 choses en même temps</strong>{" "}
              sur le même franc versé :
            </div>
            <div className="grid md:grid-cols-3 gap-3 mt-4">
              <div className="bg-white/10 rounded-lg p-3 text-sm">
                <div className="font-bold text-klary-orange mb-1">💰 + Économie d&apos;impôt</div>
                <div className="text-white/85 text-xs">Chaque franc versé est déduit du revenu imposable</div>
              </div>
              <div className="bg-white/10 rounded-lg p-3 text-sm">
                <div className="font-bold text-klary-orange mb-1">📈 + Intérêts / rendement</div>
                <div className="text-white/85 text-xs">Le capital travaille pendant qu&apos;il dort chez la banque</div>
              </div>
              <div className="bg-white/10 rounded-lg p-3 text-sm">
                <div className="font-bold text-klary-orange mb-1">🛡 + Protection famille</div>
                <div className="text-white/85 text-xs">Couverture décès + libération de prime en incapacité (version assurance)</div>
              </div>
            </div>
            <div className="mt-4 pt-4 border-t border-white/10 text-center">
              <div className="text-white/70 text-xs uppercase tracking-widest font-bold mb-1">
                Au final
              </div>
              <div className="text-2xl font-bold text-klary-orange">
                Tout bénéf pour le client 🎁
              </div>
              <div className="text-white/70 text-sm mt-1">
                Sans le 3a : tu payes tes impôts pleins pot ET ton argent dort sur un compte à 0 %. Avec le 3a : tu réduis tes impôts + ton capital grandit + ta famille est protégée.
              </div>
            </div>
          </div>

          {/* 3a vs 3b : les deux versions de l'outil */}
          <div className="mb-6">
            <div className="text-xs font-bold uppercase text-klary-orange mb-2 tracking-widest">
              🔧 Le 3ᵉ pilier existe en 2 versions
            </div>
            <div className="grid md:grid-cols-2 gap-4">
              <div className="bg-white rounded-xl p-5 border-2 border-klary-orange">
                <div className="text-xs uppercase tracking-widest text-klary-orange font-bold mb-2">
                  Pilier 3a · Lié
                </div>
                <div className="font-bold text-klary-navy mb-2">
                  L&apos;outil « performance fiscale »
                </div>
                <ul className="text-sm text-klary-grey space-y-1.5 list-disc pl-5">
                  <li><strong>Déductible fiscalement</strong> : plafond 7 258 CHF/an (salarié) ou 36 288 CHF/an (indépendant sans LPP)</li>
                  <li>Retrait bloqué jusqu&apos;à 60 ans SAUF motifs légaux (achat résidence principale, indépendance, départ CH...)</li>
                  <li>Ordre des bénéficiaires imposé (art. 2 OPP 3)</li>
                  <li><strong>Nantissable</strong> auprès de la banque pour un dossier hypothèque</li>
                </ul>
              </div>
              <div className="bg-white rounded-xl p-5 border-2 border-klary-navy">
                <div className="text-xs uppercase tracking-widest text-klary-navy font-bold mb-2">
                  Pilier 3b · Libre
                </div>
                <div className="font-bold text-klary-navy mb-2">
                  L&apos;outil « souplesse totale »
                </div>
                <ul className="text-sm text-klary-grey space-y-1.5 list-disc pl-5">
                  <li>Pas de plafond de versement, aucune restriction de retrait</li>
                  <li>Bénéficiaire librement désigné (utile pour concubin, ami, association...)</li>
                  <li>Fiscalité : primes non déductibles au fédéral (déduction partielle GE / VD selon canton)</li>
                  <li>Utilisé en <strong>complément</strong> du 3a une fois le plafond épuisé, ou pour concubins / retraits libres</li>
                </ul>
              </div>
            </div>
            <div className="text-xs text-klary-grey italic mt-3 text-center">
              Selon la situation du client, on peut combiner les deux : 3a plein pour le maximum fiscal + 3b pour le reste et la souplesse.
            </div>
          </div>

          {/* Les 2 stratégies 3a pour le nantissement */}
          <div className="mb-6 bg-white rounded-xl p-6 border-2 border-klary-navy">
            <div className="text-xs font-bold uppercase text-klary-navy tracking-widest mb-2">
              ⚠ Les 2 stratégies possibles pour votre 3a
            </div>
            <h3 className="text-xl font-bold text-klary-navy mb-1">
              Bancaire ou Assurance : quel véhicule choisir ?
            </h3>
            <p className="text-sm text-klary-grey mb-5">
              Le 3ᵉ pilier 3a peut être hébergé chez une banque ou souscrit
              via une police d&apos;assurance-vie. Les deux fonctionnent pour
              le nantissement, mais l&apos;équilibre entre <strong>flexibilité
              et sécurité</strong> est très différent.
            </p>

            <div className="grid md:grid-cols-2 gap-4">
              {/* Option 1 : 3a Bancaire */}
              <div className="rounded-xl border-2 border-emerald-500 overflow-hidden">
                <div className="bg-emerald-500 text-white p-3">
                  <div className="text-[10px] uppercase tracking-widest text-white/80 font-bold">
                    Option 1
                  </div>
                  <div className="text-lg font-bold">
                    Le 3a Bancaire (Épargne ou Fonds)
                  </div>
                </div>
                <div className="p-5">
                  <p className="text-sm text-klary-navy leading-relaxed mb-3">
                    Le client verse chaque année sur un <strong>compte
                    d&apos;épargne 3a</strong>. Pour booster la croissance du
                    capital nanti, il peut demander à la banque de placer cet
                    argent dans des <strong>fonds de placement 3a</strong>{" "}
                    (actions / obligations) et viser un meilleur rendement
                    long terme pour couvrir sa dette.
                  </p>
                  <div className="border-t border-klary-light-grey pt-3 mt-3">
                    <div className="text-xs font-bold text-emerald-700 mb-2">✓ Avantages</div>
                    <ul className="text-xs text-klary-grey space-y-1 list-disc pl-4">
                      <li>Très flexible (versements variables, arrêt possible)</li>
                      <li>Frais faibles (0,1 à 0,5 % en compte, 0,5-1,2 % en fonds)</li>
                      <li>Choix du profil de risque (prudent → dynamique)</li>
                      <li>Aucune assurance obligatoire</li>
                    </ul>
                    <div className="text-xs font-bold text-red-600 mt-3 mb-2">⚠ Limites</div>
                    <ul className="text-xs text-klary-grey space-y-1 list-disc pl-4">
                      <li>Aucune protection décès / incapacité intégrée</li>
                      <li>Rendement des fonds non garanti (marché financier)</li>
                    </ul>
                  </div>
                </div>
              </div>

              {/* Option 2 : 3a Assurance */}
              <div className="rounded-xl border-2 border-klary-orange overflow-hidden">
                <div className="bg-klary-orange text-white p-3">
                  <div className="text-[10px] uppercase tracking-widest text-white/80 font-bold">
                    Option 2
                  </div>
                  <div className="text-lg font-bold">
                    Le 3a Assurance
                  </div>
                </div>
                <div className="p-5">
                  <p className="text-sm text-klary-navy leading-relaxed mb-3">
                    La banque peut exiger ou proposer que le nantissement se
                    fasse via une <strong>police d&apos;assurance-vie 3a</strong>.
                    Cela combine l&apos;épargne obligatoire avec une{" "}
                    <strong>couverture décès + libération de prime en cas
                    d&apos;incapacité</strong>, ce qui sécurise à la fois la
                    banque et la famille du client.
                  </p>
                  <div className="border-t border-klary-light-grey pt-3 mt-3">
                    <div className="text-xs font-bold text-emerald-700 mb-2">✓ Avantages</div>
                    <ul className="text-xs text-klary-grey space-y-1 list-disc pl-4">
                      <li>Protection décès + incapacité incluse dès le 1ᵉʳ franc</li>
                      <li>Libération de prime si le client tombe malade / invalide</li>
                      <li>Capital garanti à l&apos;échéance (partie « rachat »)</li>
                      <li>La banque adore : couvre le risque de défaut</li>
                    </ul>
                    <div className="text-xs font-bold text-red-600 mt-3 mb-2">⚠ Limites</div>
                    <ul className="text-xs text-klary-grey space-y-1 list-disc pl-4">
                      <li>Moins flexible (arrêt / réduction = pénalités les 5 premières années)</li>
                      <li>Frais d&apos;acquisition élevés années 1-5</li>
                      <li>Rendement souvent inférieur au 3a bancaire long terme</li>
                    </ul>
                  </div>
                </div>
              </div>
            </div>

            <div className="mt-5 bg-klary-cream/60 border border-klary-orange/30 rounded-lg p-4 text-sm text-klary-navy leading-relaxed">
              <strong className="text-klary-orange">🎯 La recommandation Klary :</strong>{" "}
              tout dépend du <strong>profil du client</strong> et de
              l&apos;<strong>horizon du projet immobilier</strong>.
              <ul className="mt-2 space-y-1 list-disc pl-5 text-xs">
                <li><strong>Jeune, célibataire, sans famille à protéger, achat &gt; 10 ans</strong> → 3a bancaire fonds (rendement)</li>
                <li><strong>Famille, enfants, achat &lt; 5 ans, revenu unique</strong> → 3a assurance (protection décès critique)</li>
                <li><strong>Situation mixte</strong> → combiner un 3a bancaire (pour la performance) + un petit 3a assurance (pour la protection)</li>
              </ul>
            </div>
          </div>

          {/* Coût réel long terme : le versement apparent vs le coût net vrai */}
          <div className="mb-6 bg-white rounded-xl p-6 border-2 border-emerald-500">
            <div className="text-xs font-bold uppercase text-emerald-700 mb-2 tracking-widest">
              🧮 Le vrai coût sur {dossier.anneesDuree} ans
            </div>
            <h3 className="text-xl font-bold text-klary-navy mb-4">
              Il pense payer {formatCHF(dossier.versementMensuel)} CHF/mois. En vrai, c&apos;est beaucoup moins.
            </h3>

            <div className="space-y-3">
              {/* Versement apparent */}
              <div className="flex items-center justify-between p-3 rounded-lg bg-klary-cream/60">
                <div>
                  <div className="text-sm text-klary-grey">Ce qu&apos;il verse (apparent)</div>
                  <div className="text-xs text-klary-grey">
                    {formatCHF(dossier.versementMensuel)} × 12 × {dossier.anneesDuree} ans
                  </div>
                </div>
                <div className="text-xl font-bold text-klary-navy">
                  {formatCHF(dossier.versementMensuel * 12 * dossier.anneesDuree)} CHF
                </div>
              </div>

              {/* Économie fiscale cumulée */}
              <div className="flex items-center justify-between p-3 rounded-lg bg-emerald-50">
                <div>
                  <div className="text-sm text-emerald-800">− Économie d&apos;impôt cumulée</div>
                  <div className="text-xs text-emerald-700">
                    {formatCHF(s.economieFiscale.median)} CHF/an × {dossier.anneesDuree} ans
                  </div>
                </div>
                <div className="text-xl font-bold text-emerald-700">
                  − {formatCHF(s.economieFiscale.median * dossier.anneesDuree)} CHF
                </div>
              </div>

              {/* Rendement gagné */}
              <div className="flex items-center justify-between p-3 rounded-lg bg-emerald-50">
                <div>
                  <div className="text-sm text-emerald-800">− Intérêts/rendement gagnés</div>
                  <div className="text-xs text-emerald-700">
                    Sur le capital placé pendant {dossier.anneesDuree} ans à ~3 %
                  </div>
                </div>
                <div className="text-xl font-bold text-emerald-700">
                  − {formatCHF(s.capitalFutur.avecRendement - s.capitalFutur.sansRendement)} CHF
                </div>
              </div>

              {/* Coût net réel */}
              <div className="flex items-center justify-between p-4 rounded-lg bg-klary-navy text-white">
                <div>
                  <div className="text-xs uppercase tracking-widest text-klary-orange font-bold">
                    = Coût réel net sur {dossier.anneesDuree} ans
                  </div>
                  <div className="text-xs text-white/70 mt-1">
                    Soit environ {formatCHF(Math.max(0, (dossier.versementMensuel * 12 * dossier.anneesDuree - s.economieFiscale.median * dossier.anneesDuree - (s.capitalFutur.avecRendement - s.capitalFutur.sansRendement)) / (dossier.anneesDuree * 12)))} CHF/mois effectif
                  </div>
                </div>
                <div className="text-2xl font-bold text-klary-orange">
                  {formatCHF(Math.max(0, dossier.versementMensuel * 12 * dossier.anneesDuree - s.economieFiscale.median * dossier.anneesDuree - (s.capitalFutur.avecRendement - s.capitalFutur.sansRendement)))} CHF
                </div>
              </div>

              {/* Capital final récupérable */}
              <div className="flex items-center justify-between p-4 rounded-lg bg-emerald-600 text-white">
                <div>
                  <div className="text-xs uppercase tracking-widest text-white/80 font-bold">
                    Et il RÉCUPÈRE au bout de {dossier.anneesDuree} ans
                  </div>
                  <div className="text-xs text-white/80 mt-1">
                    Capital constitué disponible (retrait retraite, achat immo, indépendance)
                  </div>
                </div>
                <div className="text-2xl font-bold">
                  {formatCHF(s.capitalFutur.avecRendement)} CHF
                </div>
              </div>
            </div>

            <div className="mt-5 p-4 bg-klary-orange/10 rounded-lg border border-klary-orange/30 text-sm text-klary-navy leading-relaxed">
              <strong className="text-klary-orange">Comparaison brutale :</strong> sur {dossier.anneesDuree} ans, il « paye »{" "}
              <strong>{formatCHF(dossier.versementMensuel * 12 * dossier.anneesDuree)} CHF</strong>{" "}
              mais entre l&apos;économie fiscale et le rendement, il récupère un capital de{" "}
              <strong>{formatCHF(s.capitalFutur.avecRendement)} CHF</strong>. Le bilan net en sa faveur =
              <strong className="text-emerald-700"> +{formatCHF(s.bilanNet.benefice)} CHF</strong>.
              Le versement mensuel est un déplacement d&apos;argent d&apos;une poche à une autre poche, pas une dépense perdue.
            </div>
          </div>


          <div className="grid gap-4 md:grid-cols-2 mb-6">
            <div className="bg-white rounded-xl p-5 border border-klary-light-grey">
              <div className="text-klary-orange text-2xl mb-2">💰</div>
              <div className="font-bold text-klary-navy mb-1">1. Économie fiscale immédiate</div>
              <div className="text-sm text-klary-grey">
                Chaque franc versé au 3a est <strong>déductible du revenu imposable</strong>.
                Sur votre plan actuel : ~{formatCHF(s.economieFiscale.median)} CHF/an
                d&apos;impôt en moins, soit {formatCHF(s.economieFiscale.median * dossier.anneesDuree)} CHF sur {dossier.anneesDuree} ans.
              </div>
            </div>

            <div className="bg-white rounded-xl p-5 border border-klary-light-grey">
              <div className="text-klary-orange text-2xl mb-2">📈</div>
              <div className="font-bold text-klary-navy mb-1">2. Capital qui fructifie</div>
              <div className="text-sm text-klary-grey">
                Le 3a rapporte des intérêts (compte bancaire) ou du rendement
                (assurance-vie / fonds). À {dossier.anneesDuree} ans :{" "}
                <strong>{formatCHF(s.capitalFutur.avecRendement)} CHF</strong> constitués
                (dont {formatCHF(s.capitalFutur.avecRendement - s.capitalFutur.sansRendement)} CHF de rendement).
              </div>
            </div>

            <div className="bg-white rounded-xl p-5 border border-klary-light-grey">
              <div className="text-klary-orange text-2xl mb-2">🛡</div>
              <div className="font-bold text-klary-navy mb-1">3. Protection famille</div>
              <div className="text-sm text-klary-grey">
                En version <strong>police assurance-vie 3a</strong>, une couverture
                décès + libération de prime en cas d&apos;incapacité est incluse.
                Le capital est versé au bénéficiaire nominatif hors succession
                (art. 76-79 LCA).
              </div>
            </div>

            <div className="bg-white rounded-xl p-5 border border-klary-light-grey">
              <div className="text-klary-orange text-2xl mb-2">⚖</div>
              <div className="font-bold text-klary-navy mb-1">4. Transmission optimisée</div>
              <div className="text-sm text-klary-grey">
                Ordre de bénéficiaires imposé par l&apos;art. 2 OPP 3, mais
                l&apos;attribution est <strong>directe et rapide</strong> : le
                bénéficiaire touche le capital sans passer par la procédure
                successorale classique.
              </div>
            </div>
          </div>

          {/* Zoom nantissement */}
          <div className="bg-klary-navy text-white rounded-xl p-6">
            <div className="text-xs font-bold uppercase text-klary-orange mb-2 tracking-widest">
              🏦 Le point clé pour la banque · le nantissement
            </div>
            <h3 className="text-xl font-bold mb-3">
              Le 3ᵉ pilier est un « collatéral » de qualité que la banque accepte
            </h3>
            <p className="text-white/85 text-sm leading-relaxed mb-4">
              Quand tu prépares un dossier d&apos;hypothèque, la banque te
              demande <strong>20 % d&apos;apport</strong>. Le 3a peut servir de{" "}
              <strong>garantie mise en gage (nantissement)</strong> :
              tu ne retires PAS ton capital, tu le laisses fructifier, et la
              banque l&apos;accepte comme collatéral pour compléter ton apport.
            </p>

            <div className="grid md:grid-cols-3 gap-3 text-sm">
              <div className="bg-white/10 rounded-lg p-3">
                <div className="font-bold mb-1 text-klary-orange">Sans 3ᵉ pilier</div>
                <div className="text-white/80 text-xs">
                  Le client doit sortir 20 % cash de ses économies. Zéro épargne fructifiante, zéro déduction fiscale, dossier bancaire plus fragile.
                </div>
              </div>
              <div className="bg-emerald-500/20 border-2 border-emerald-400 rounded-lg p-3">
                <div className="font-bold mb-1 text-emerald-300">✓ Avec 3a nanti (best)</div>
                <div className="text-white/90 text-xs">
                  La banque prend le 3a en <strong>garantie</strong>, mais le client :
                  <ul className="mt-1 space-y-0.5 list-none">
                    <li>✓ <strong>Continue de verser</strong> ses 200/mois</li>
                    <li>✓ <strong>Garde 100 % des intérêts</strong></li>
                    <li>✓ <strong>Garde 100 % des économies d&apos;impôt</strong></li>
                    <li>✓ <strong>Garde la protection famille</strong></li>
                    <li>✓ Le capital continue à grandir</li>
                  </ul>
                </div>
              </div>
              <div className="bg-white/10 rounded-lg p-3">
                <div className="font-bold mb-1 text-klary-orange">Avec retrait EPL</div>
                <div className="text-white/80 text-xs">
                  Le client retire le capital (art. 30c LPP / art. 3 OPP 3), MAIS il paye l&apos;impôt de sortie (~5 %), perd le rendement futur ET la protection. Dernier recours seulement.
                </div>
              </div>
            </div>

            <div className="mt-5 bg-emerald-500/20 border-2 border-emerald-400 rounded-lg p-4">
              <div className="text-xs uppercase tracking-widest text-emerald-200 font-bold mb-2">
                💡 Le vrai deal du nantissement
              </div>
              <div className="text-sm text-white leading-relaxed">
                La banque met un <strong>gage sur le 3a</strong> (elle sécurise
                son prêt). Le client, lui, ne change RIEN à ses habitudes : il
                continue à verser ses {formatCHF(dossier.versementMensuel)} CHF/mois, son capital
                continue à fructifier chez l&apos;assureur/banque 3a, il continue à toucher
                l&apos;économie fiscale chaque année, et sa famille reste protégée en cas
                de coup dur.
                <br /><br />
                <strong className="text-emerald-200">Résultat : la banque a sa garantie, le client garde 100 % des bénéfices du 3a.</strong>{" "}
                C&apos;est le mécanisme le plus win-win qu&apos;on trouve dans le financement immobilier suisse.
              </div>
            </div>

            {/* Le point qui change tout : le 3a fait partie du montage hypothécaire */}
            <div className="mt-5 bg-white text-klary-navy rounded-lg p-5 border-l-4 border-klary-orange">
              <div className="text-xs uppercase tracking-widest text-klary-orange font-bold mb-2">
                🔀 Le changement de perspective qui fait la différence
              </div>
              <div className="text-lg font-bold mb-3">
                Avant : 2 flux financiers séparés. Après : 1 seul montage intégré.
              </div>

              <div className="grid md:grid-cols-2 gap-4">
                <div className="bg-red-50 border border-red-200 rounded-lg p-4">
                  <div className="text-xs uppercase tracking-widest text-red-700 font-bold mb-2">
                    ❌ Avant
                  </div>
                  <div className="text-sm text-klary-navy mb-2">
                    <strong>2 charges parallèles :</strong>
                  </div>
                  <ul className="text-sm text-klary-navy space-y-1 list-disc pl-5">
                    <li>Il paye son <strong>loyer</strong> ({formatCHF(dossier.loyerMensuel)} CHF/mois)</li>
                    <li>ET il essaye d&apos;épargner pour sa retraite <strong>en parallèle</strong> (rarement fait)</li>
                    <li>2 efforts déconnectés, rien n&apos;alimente son achat immobilier futur</li>
                  </ul>
                </div>
                <div className="bg-emerald-50 border-2 border-emerald-500 rounded-lg p-4">
                  <div className="text-xs uppercase tracking-widest text-emerald-700 font-bold mb-2">
                    ✅ Après structuration Klary
                  </div>
                  <div className="text-sm text-klary-navy mb-2">
                    <strong>1 seul montage globalisé :</strong>
                  </div>
                  <ul className="text-sm text-klary-navy space-y-1 list-disc pl-5">
                    <li>Il paye son <strong>hypothèque</strong> (souvent moins cher que le loyer)</li>
                    <li>Son <strong>3a nanti sert de collatéral</strong> auprès de la banque pour couvrir une partie des fonds propres exigés</li>
                    <li>Le 3a fait <strong>double emploi</strong> : garantie bancaire + épargne retraite + protection famille</li>
                    <li>Un seul effort mensuel structuré, tout est intégré dans le dossier bancaire</li>
                  </ul>
                </div>
              </div>

              <div className="mt-4 p-4 bg-klary-orange/10 border border-klary-orange/30 rounded-lg text-sm">
                <strong className="text-klary-orange">Le message clé :</strong> le client
                n&apos;épargne plus « en plus » de son hypothèque. Le 3a est <strong>intégré au montage</strong> :
                il couvre une partie de l&apos;apport (via nantissement), sert d&apos;amortissement indirect (2ᵉ rang),
                et continue à générer l&apos;économie fiscale + le rendement + la protection en même temps.
                <br /><br />
                <strong>Un seul effort → cinq bénéfices simultanés.</strong>
              </div>
            </div>

            <div className="mt-5 pt-4 border-t border-white/10">
              <div className="text-xs uppercase tracking-widest text-klary-orange font-bold mb-3">
                🎯 Ce que les banques adorent chez un client 3a
              </div>
              <div className="grid md:grid-cols-2 gap-3 mb-4">
                <div className="bg-emerald-500/15 border border-emerald-400/30 rounded-lg p-3">
                  <div className="font-bold text-emerald-200 text-sm mb-1">
                    ✓ Régularité mensuelle = signal fort
                  </div>
                  <div className="text-white/85 text-xs">
                    La banque voit une <strong>régularité financière mensuelle</strong> (200 CHF chaque mois pendant des années) = discipline d&apos;épargne prouvée = risque de défaut faible. C&apos;est le signal comportemental que la banque adore le plus.
                  </div>
                </div>
                <div className="bg-emerald-500/15 border border-emerald-400/30 rounded-lg p-3">
                  <div className="font-bold text-emerald-200 text-sm mb-1">
                    ✓ Taux hypothécaire préférentiel
                  </div>
                  <div className="text-white/85 text-xs">
                    Certaines banques (UBS, Raiffeisen, PostFinance) offrent <strong>-0,05 à -0,15 %</strong> sur le taux quand le 3a est chez eux. Sur 1 M CHF pendant 10 ans = 5-15 k CHF d&apos;économie d&apos;intérêts.
                  </div>
                </div>
                <div className="bg-emerald-500/15 border border-emerald-400/30 rounded-lg p-3">
                  <div className="font-bold text-emerald-200 text-sm mb-1">
                    ✓ LTV améliorée (loan-to-value)
                  </div>
                  <div className="text-white/85 text-xs">
                    Le 3a nanti compte dans les <strong>fonds propres</strong>. Un client avec 100 k de 3a peut viser un bien plus cher qu&apos;un client sans épargne équivalente.
                  </div>
                </div>
                <div className="bg-emerald-500/15 border border-emerald-400/30 rounded-lg p-3">
                  <div className="font-bold text-emerald-200 text-sm mb-1">
                    ✓ Dossier validé plus vite
                  </div>
                  <div className="text-white/85 text-xs">
                    Le comité crédit voit un client 3a comme <strong>« bien géré »</strong> : décision plus rapide, moins de justificatifs demandés, moins d&apos;aller-retour.
                  </div>
                </div>
                <div className="bg-emerald-500/15 border border-emerald-400/30 rounded-lg p-3">
                  <div className="font-bold text-emerald-200 text-sm mb-1">
                    ✓ Cross-selling banque
                  </div>
                  <div className="text-white/85 text-xs">
                    La banque adore garder le 3a chez elle pour cross-vendre carte, compte épargne, prévoyance 3b, hypothèque. Elle facilite donc l&apos;hypothèque pour <strong>capter le client</strong>.
                  </div>
                </div>
                <div className="bg-emerald-500/15 border border-emerald-400/30 rounded-lg p-3">
                  <div className="font-bold text-emerald-200 text-sm mb-1">
                    ✓ Amortissement 2ᵉ rang facilité
                  </div>
                  <div className="text-white/85 text-xs">
                    L&apos;amortissement obligatoire 15 ans (art. 30c LPP) peut être partiellement fait via versements 3a. La banque valorise ce mécanisme.
                  </div>
                </div>
              </div>

              <div className="bg-klary-orange/20 border border-klary-orange rounded-lg p-4 text-sm text-white leading-relaxed">
                <strong className="text-klary-orange">Résultat concret pour le client :</strong> avec {formatCHF(s.capitalFutur.avecRendement)} CHF de 3a nanti, il obtient :
                <ul className="mt-2 space-y-1 list-disc pl-5 text-white/90 text-xs">
                  <li>Un dossier <strong>accepté 3× plus facilement</strong> (source : études internes ASB 2024)</li>
                  <li>Un taux hypothécaire jusqu&apos;à <strong>0,15 point plus bas</strong></li>
                  <li>Une négociation où <strong>c&apos;est la banque qui te chasse</strong>, pas l&apos;inverse</li>
                </ul>
              </div>
            </div>

            <div className="mt-4 text-xs text-white/60 italic">
              💡 C&apos;est pour ça que le 3a est intéressant <strong>même si tu n&apos;achètes pas tout de suite</strong> : plus tu commences tôt, plus ton capital est important quand tu passes devant la banque, plus tu es en position de force.
            </div>
          </div>
        </section>

        {/* Prévoyance requise pour l'apport 10 % mou */}
        <section className="bg-white rounded-2xl border-2 border-klary-navy p-6 md:p-8">
          <div className="text-xs font-bold uppercase text-klary-navy tracking-widest mb-2">
            🎯 Combien de prévoyance il te faut pour cet apport
          </div>
          <h2 className="text-2xl font-bold text-klary-navy mb-4">
            Pour un bien à {formatCHF(dossier.prixBien)} CHF
          </h2>

          <div className="grid md:grid-cols-3 gap-3 mb-6">
            <div className="bg-klary-cream/40 rounded-xl p-5 text-center">
              <div className="text-xs uppercase tracking-widest text-klary-grey font-bold mb-1">
                Apport total (20 %)
              </div>
              <div className="text-2xl font-bold text-klary-navy">
                {formatCHF(dossier.prixBien * 0.2)}
              </div>
              <div className="text-xs text-klary-grey mt-1">CHF</div>
            </div>
            <div className="bg-red-50 border-2 border-red-300 rounded-xl p-5 text-center">
              <div className="text-xs uppercase tracking-widest text-red-700 font-bold mb-1">
                Apport « DUR » (10 %)
              </div>
              <div className="text-2xl font-bold text-red-700">
                {formatCHF(dossier.prixBien * 0.1)}
              </div>
              <div className="text-xs text-red-600 mt-1">
                Cash + 3a lié (hors LPP)
              </div>
            </div>
            <div className="bg-emerald-50 border-2 border-emerald-500 rounded-xl p-5 text-center">
              <div className="text-xs uppercase tracking-widest text-emerald-700 font-bold mb-1">
                Apport « MOU » (10 %)
              </div>
              <div className="text-2xl font-bold text-emerald-700">
                {formatCHF(dossier.prixBien * 0.1)}
              </div>
              <div className="text-xs text-emerald-600 mt-1">
                LPP + 3a nanti (prévoyance)
              </div>
            </div>
          </div>

          <div className="bg-klary-navy text-white rounded-xl p-5 mb-4">
            <div className="text-xs uppercase tracking-widest text-klary-orange font-bold mb-2">
              💡 La règle du montage
            </div>
            <p className="text-white/90 text-sm leading-relaxed">
              Sur les 20 % d&apos;apport exigés par la banque, <strong>la moitié
              (10 %) doit être « dure »</strong> : cash épargné ou 3a lié (car
              considéré comme hors 2ᵉ pilier). L&apos;autre moitié (10 %) peut
              être issue de la <strong>prévoyance mobilisable</strong> : LPP
              (retrait EPL art. 30c ou nantissement) et 3a nanti.
            </p>
            <p className="text-white/90 text-sm leading-relaxed mt-3">
              Autrement dit, pour un bien à {formatCHF(dossier.prixBien)} CHF,
              tu dois pouvoir mobiliser au minimum{" "}
              <strong className="text-klary-orange">
                {formatCHF(dossier.prixBien * 0.1)} CHF de prévoyance
              </strong>{" "}
              (LPP + 3a cumulés) pour couvrir le 10 % mou.
            </p>
          </div>

          <div className="text-xs font-bold uppercase text-klary-navy tracking-widest mb-3">
            📋 3 façons de constituer les {formatCHF(dossier.prixBien * 0.1)} CHF de prévoyance requise
          </div>
          <div className="grid md:grid-cols-3 gap-3">
            {prevoyanceRequisePourApport(dossier.prixBien).suggestions.map((sug, i) => (
              <div key={i} className="bg-klary-cream/40 rounded-xl p-4 border border-klary-light-grey">
                <div className="font-bold text-klary-navy mb-1">
                  Option {i + 1} · {sug.label}
                </div>
                <div className="text-2xl font-bold text-klary-orange mb-1">
                  {formatCHF(sug.montant)}
                </div>
                <div className="text-xs text-klary-grey">{sug.explication}</div>
              </div>
            ))}
          </div>
        </section>

        {/* Comment booster sa prévoyance */}
        <section className="bg-gradient-to-br from-klary-orange/5 to-white rounded-2xl border-2 border-klary-orange p-6 md:p-8">
          <div className="text-xs font-bold uppercase text-klary-orange tracking-widest mb-2">
            🚀 Comment accélérer la constitution
          </div>
          <h2 className="text-2xl font-bold text-klary-navy mb-4">
            Le client veut atteindre {formatCHF(dossier.prixBien * 0.1)} CHF plus vite ?
          </h2>

          {/* Calcul temps nécessaire selon versement */}
          <div className="bg-white rounded-xl p-5 border border-klary-light-grey mb-6">
            <div className="text-xs font-bold uppercase text-klary-navy tracking-widest mb-3">
              ⏱ Temps nécessaire pour atteindre les {formatCHF(dossier.prixBien * 0.1)} CHF
            </div>
            <div className="grid md:grid-cols-4 gap-3 text-center">
              {[200, 400, 604, 1000].map((v) => {
                const annees = anneesNecessairesPourCapital(
                  dossier.prixBien * 0.1,
                  v,
                  dossier.rendementAnnuel ?? 0.03
                );
                const isPlafond = v <= 604;
                return (
                  <div key={v} className={`rounded-lg p-4 ${isPlafond ? 'bg-emerald-50 border border-emerald-300' : 'bg-amber-50 border border-amber-300'}`}>
                    <div className="text-xs uppercase tracking-widest text-klary-grey font-bold mb-1">
                      {formatCHF(v)} /mois
                    </div>
                    <div className={`text-3xl font-bold ${isPlafond ? 'text-emerald-700' : 'text-amber-700'}`}>
                      {annees} ans
                    </div>
                    <div className="text-xs text-klary-grey mt-1">
                      {v <= 604 ? "3a bancaire OK" : "Dépasse plafond 3a annuel"}
                    </div>
                  </div>
                );
              })}
            </div>
            <div className="text-xs text-klary-grey italic mt-3">
              Rappel : plafond 3a mensuel équivalent = 604 CHF (7 258 CHF/an). Au-delà, cumuler avec 3b ou augmenter LPP.
            </div>
          </div>

          {/* 6 leviers pour booster la prévoyance */}
          <div className="text-xs font-bold uppercase text-klary-navy tracking-widest mb-3">
            💪 6 leviers pour accélérer la constitution
          </div>
          <div className="grid md:grid-cols-2 gap-3">
            <div className="bg-white rounded-xl p-4 border border-klary-light-grey">
              <div className="text-klary-orange font-bold text-lg mb-1">1. Verser le plafond 3a plein</div>
              <div className="text-sm text-klary-grey">
                Passer de 200 à <strong>604 CHF/mois</strong> (plafond salarié) = 3× plus vite. Économie fiscale × 3 aussi.
              </div>
            </div>
            <div className="bg-white rounded-xl p-4 border border-klary-light-grey">
              <div className="text-klary-orange font-bold text-lg mb-1">2. Rachat LPP</div>
              <div className="text-sm text-klary-grey">
                Combler les <strong>lacunes de LPP</strong> (art. 79b) : déductible fiscal total, capital immédiatement disponible pour nantissement.
              </div>
            </div>
            <div className="bg-white rounded-xl p-4 border border-klary-light-grey">
              <div className="text-klary-orange font-bold text-lg mb-1">3. Cumuler 3a + 3b</div>
              <div className="text-sm text-klary-grey">
                Une fois le plafond 3a atteint, verser le surplus sur un <strong>3b libre</strong> (pas de plafond, pas de blocage).
              </div>
            </div>
            <div className="bg-white rounded-xl p-4 border border-klary-light-grey">
              <div className="text-klary-orange font-bold text-lg mb-1">4. Prime unique 3a en fin d&apos;année</div>
              <div className="text-sm text-klary-grey">
                Verser le complément fin novembre pour <strong>saturer le plafond de l&apos;année fiscale</strong> (économie d&apos;impôt maximale).
              </div>
            </div>
            <div className="bg-white rounded-xl p-4 border border-klary-light-grey">
              <div className="text-klary-orange font-bold text-lg mb-1">5. Ouvrir 2ᵉ compte 3a (voire 3)</div>
              <div className="text-sm text-klary-grey">
                Multiplier les comptes 3a permet ensuite d&apos;<strong>échelonner les retraits</strong> à la retraite pour optimiser l&apos;impôt (barème progressif).
              </div>
            </div>
            <div className="bg-white rounded-xl p-4 border border-klary-light-grey">
              <div className="text-klary-orange font-bold text-lg mb-1">6. Passer à un 3a fonds de placement</div>
              <div className="text-sm text-klary-grey">
                Un 3a fonds actions génère <strong>3-5 % de rendement moyen long terme</strong> vs 0-1 % en 3a bancaire simple.
              </div>
            </div>
          </div>

          <div className="mt-5 bg-klary-navy text-white rounded-xl p-4 text-sm leading-relaxed">
            <strong className="text-klary-orange">Bonus stratégique :</strong> combiner
            plusieurs leviers (ex: 3a plafond + 3b + rachat LPP 5 000 CHF) permet
            de constituer le capital 10 % apport en <strong>3-5 ans</strong> au
            lieu de 15 ans à petit versement.
          </div>
        </section>

        {/* Bloc final : la question rhétorique */}
        <section className="bg-gradient-to-br from-klary-navy to-black text-white rounded-2xl p-6 md:p-10 relative overflow-hidden">
          <div className="absolute -top-20 -right-20 w-64 h-64 bg-klary-orange/30 rounded-full blur-3xl" />
          <div className="relative">
            <div className="text-xs font-bold uppercase text-klary-orange mb-3 tracking-widest">
              ❓ La seule question qui reste
            </div>
            <h2 className="text-3xl md:text-4xl font-bold mb-6 leading-tight">
              Objectivement, pourquoi refuser<br />
              de mettre en place un 3ᵉ pilier ?
            </h2>

            <div className="grid md:grid-cols-2 gap-6 mb-6">
              {/* Les 5 « non-raisons » qui ne tiennent pas */}
              <div className="bg-white/5 border border-white/10 rounded-xl p-5">
                <div className="text-xs uppercase tracking-widest text-red-300 font-bold mb-3">
                  ❌ Les « non-raisons »
                </div>
                <ul className="space-y-3 text-sm">
                  <li>
                    <div className="font-bold text-white">« C&apos;est cher »</div>
                    <div className="text-white/70 text-xs">Le coût net réel = {formatCHF(Math.max(0, dossier.versementMensuel - Math.round(dossier.versementMensuel * (dossier.tauxMarginal ?? 0.25))))} CHF/mois après économie d&apos;impôt. Un abo fitness coûte plus.</div>
                  </li>
                  <li>
                    <div className="font-bold text-white">« Je préfère garder l&apos;argent disponible »</div>
                    <div className="text-white/70 text-xs">Il l&apos;est déjà à la retraite, pour un achat immobilier, pour se mettre à son compte, ou en cas d&apos;invalidité (art. 3 OPP 3).</div>
                  </li>
                  <li>
                    <div className="font-bold text-white">« Je verrai plus tard »</div>
                    <div className="text-white/70 text-xs">Chaque année perdue = une année d&apos;économie d&apos;impôt en moins + rendement composé perdu.</div>
                  </li>
                  <li>
                    <div className="font-bold text-white">« Je n&apos;y comprends rien »</div>
                    <div className="text-white/70 text-xs">L&apos;outil est reconnu par l&apos;État, la déduction est garantie par la loi, il y a 14 jours pour tout annuler (art. 2a LCA).</div>
                  </li>
                  <li>
                    <div className="font-bold text-white">« C&apos;est de l&apos;arnaque »</div>
                    <div className="text-white/70 text-xs">L&apos;argent ne bouge PAS de sa poche. Il reste chez lui (compte bancaire ou police assurance). Une arnaque = argent qui disparaît.</div>
                  </li>
                </ul>
              </div>

              {/* Les vraies raisons de dire non */}
              <div className="bg-white/5 border border-white/10 rounded-xl p-5">
                <div className="text-xs uppercase tracking-widest text-emerald-300 font-bold mb-3">
                  ✓ Les vraies raisons (rares)
                </div>
                <ul className="space-y-3 text-sm">
                  <li>
                    <div className="font-bold text-white">Surendettement actif</div>
                    <div className="text-white/70 text-xs">Poursuites en cours, actes de défaut de biens → traiter la dette d&apos;abord.</div>
                  </li>
                  <li>
                    <div className="font-bold text-white">Revenu insuffisant</div>
                    <div className="text-white/70 text-xs">Si le budget n&apos;absorbe même pas 100 CHF/mois, il faut travailler le revenu avant.</div>
                  </li>
                  <li>
                    <div className="font-bold text-white">Santé fragile (version assurance)</div>
                    <div className="text-white/70 text-xs">Maladie grave récente = refus questionnaire santé. Alternative : 3a bancaire simple sans couverture.</div>
                  </li>
                  <li>
                    <div className="font-bold text-white">Départ définitif de Suisse imminent</div>
                    <div className="text-white/70 text-xs">Sortie possible mais impôt de retrait immédiat. À évaluer.</div>
                  </li>
                  <li>
                    <div className="font-bold text-white">Déjà au plafond 3a</div>
                    <div className="text-white/70 text-xs">7 258 CHF/an déjà versé ailleurs → basculer sur 3b libre pour le surplus.</div>
                  </li>
                </ul>
              </div>
            </div>

            <div className="bg-klary-orange/20 border-2 border-klary-orange rounded-xl p-5 text-sm leading-relaxed">
              <div className="text-lg font-bold text-klary-orange mb-2">
                💡 Le raisonnement à poser au client
              </div>
              <div className="text-white/95">
                « Vous préférez : (1) payer plus d&apos;impôts et laisser votre
                argent dormir à 0 %, ou (2) payer moins d&apos;impôts, avoir un
                capital qui grandit, une protection famille comprise, et un
                dossier bancaire renforcé pour votre projet immobilier ? »
                <br /><br />
                <strong className="text-klary-orange">La vraie question n&apos;est pas si le 3a vaut le coup. La vraie question, c&apos;est combien vous perdez chaque année où vous ne l&apos;avez pas.</strong>
              </div>
            </div>

            <div className="mt-4 text-xs text-white/60 italic text-center">
              Le rôle du conseiller Klary : présenter les chiffres, laisser le client conclure. Aucune pression, juste de la clarté.
            </div>
          </div>
        </section>
      </div>

      {/* Composant PDF (invisible sauf impression) */}
      <PlanClientPrint dossier={dossier} s={s} />
    </div>
  );
}

// ═════════════ Composants ═════════════

function CalcBlock({
  numero,
  titre,
  resultat,
  detail,
  tone,
  children,
}: {
  numero: string;
  titre: string;
  resultat: string;
  detail: string;
  tone: "ok" | "warn" | "neutral";
  children: React.ReactNode;
}) {
  const badge =
    tone === "ok" ? "bg-emerald-500" : tone === "warn" ? "bg-red-500" : "bg-klary-navy";
  const resultColor =
    tone === "ok" ? "text-emerald-700" : tone === "warn" ? "text-red-700" : "text-klary-navy";

  return (
    <section className="bg-white rounded-2xl border border-klary-light-grey overflow-hidden">
      <div className="p-6">
        <div className="flex items-start gap-4 mb-4">
          <span className={`shrink-0 w-9 h-9 rounded-full text-white flex items-center justify-center font-bold ${badge}`}>
            {numero}
          </span>
          <div className="flex-1 min-w-0">
            <h3 className="font-bold text-klary-navy text-lg">{titre}</h3>
            <div className={`text-3xl font-bold mt-1 ${resultColor}`}>{resultat}</div>
            <div className="text-sm text-klary-grey mt-1">{detail}</div>
          </div>
        </div>
      </div>
      <details className="border-t border-klary-light-grey group">
        <summary className="cursor-pointer p-4 bg-klary-cream/40 hover:bg-klary-cream/60 transition text-sm font-semibold text-klary-navy flex items-center justify-between list-none">
          <span>📖 Comment on calcule</span>
          <span className="text-klary-orange text-xs group-open:rotate-90 transition">▶</span>
        </summary>
        <div className="p-5 text-sm text-klary-navy space-y-1 bg-klary-cream/20">
          {children}
        </div>
      </details>
    </section>
  );
}

function TextInput({ label, value, onChange }: { label: string; value: string; onChange: (v: string) => void }) {
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

function NumberInputOrange({
  label,
  value,
  step = 1,
  min,
  max,
  suffix,
  onChange,
}: {
  label: string;
  value: number;
  step?: number;
  min?: number;
  max?: number;
  suffix?: string;
  onChange: (v: number) => void;
}) {
  return (
    <label className="block">
      <span className="text-[10px] font-bold uppercase text-white/85 tracking-widest mb-1.5 block">
        {label}
      </span>
      <div className="relative">
        <input
          type="number"
          value={value}
          step={step}
          min={min}
          max={max}
          onChange={(e) => onChange(Number(e.target.value))}
          className="w-full px-3 py-2 pr-14 bg-white/15 border border-white/25 rounded-lg text-white font-bold text-lg focus:outline-none focus:border-white focus:bg-white/20"
        />
        {suffix && (
          <span className="absolute right-3 top-1/2 -translate-y-1/2 text-xs text-white/70">
            {suffix}
          </span>
        )}
      </div>
    </label>
  );
}

function PlanCard({
  label,
  value,
  hint,
  tone,
}: {
  label: string;
  value: string;
  hint: string;
  tone: "orange" | "ok" | "warn" | "navy";
}) {
  const styles = {
    orange: "bg-klary-orange/10 border-klary-orange text-klary-navy",
    ok: "bg-emerald-50 border-emerald-500 text-emerald-900",
    warn: "bg-amber-50 border-amber-500 text-amber-900",
    navy: "bg-klary-cream/60 border-klary-navy text-klary-navy",
  }[tone];
  return (
    <div className={`rounded-xl border-2 p-4 ${styles}`}>
      <div className="text-[10px] uppercase tracking-widest font-bold opacity-80 mb-1">
        {label}
      </div>
      <div className="text-2xl font-bold">{value}</div>
      <div className="text-xs opacity-75 mt-1 leading-tight">{hint}</div>
    </div>
  );
}

function NumberInputDark({
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
      <span className="text-[10px] font-bold uppercase text-white/60 tracking-widest mb-1.5 block">
        {label}
      </span>
      <input
        type="number"
        value={value}
        step={step}
        min={min}
        max={max}
        onChange={(e) => onChange(Number(e.target.value))}
        className="w-full px-3 py-2 bg-white/10 border border-white/20 rounded-lg text-white font-bold text-lg focus:outline-none focus:border-klary-orange focus:bg-white/15"
      />
    </label>
  );
}
