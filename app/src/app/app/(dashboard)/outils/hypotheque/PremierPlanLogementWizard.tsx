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

const DEFAULT_DOSSIER: DossierClient = {
  prixBien: 600000,
  revenuAnnuel: 90000,
  loyerMensuel: 1800,
  versementMensuel: 200,
  anneesDuree: 15,
  tauxMarginal: 0.25,
  rendementAnnuel: 0.03,
};

export function PremierPlanLogementWizard() {
  const [dossier, setDossier] = useState<DossierClient>(DEFAULT_DOSSIER);
  const [simId, setSimId] = useState<string | null>(null);
  const [saving, setSaving] = useState(false);
  const [saved, setSaved] = useState(false);
  const s = useMemo(() => synthese(dossier), [dossier]);
  const params = useSearchParams();
  const router = useRouter();

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

        {/* Récapitulatif : pourquoi le 3a est un levier financier + nantissement */}
        <section className="bg-gradient-to-br from-klary-orange/10 via-white to-klary-navy/5 rounded-2xl border-2 border-klary-orange p-6 md:p-8">
          <div className="text-xs font-bold uppercase text-klary-orange mb-2 tracking-widest">
            🎯 Récapitulatif · Pourquoi le 3ᵉ pilier est un levier
          </div>
          <h2 className="text-2xl font-bold text-klary-navy mb-4">
            Pas juste une épargne retraite : un outil de financement immobilier
          </h2>

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
                <div className="font-bold mb-1 text-klary-orange">Sans nantissement</div>
                <div className="text-white/80 text-xs">
                  Tu dois sortir 20 % cash de tes économies. Ton 3a reste
                  inactif dans le dossier bancaire.
                </div>
              </div>
              <div className="bg-white/10 rounded-lg p-3">
                <div className="font-bold mb-1 text-klary-orange">Avec nantissement</div>
                <div className="text-white/80 text-xs">
                  Ton 3a garantit une partie de l&apos;apport. Tu gardes ton
                  capital, il continue à fructifier, tu ne payes pas
                  d&apos;impôt de retrait anticipé.
                </div>
              </div>
              <div className="bg-white/10 rounded-lg p-3">
                <div className="font-bold mb-1 text-klary-orange">Avec retrait EPL</div>
                <div className="text-white/80 text-xs">
                  Tu retires le capital (art. 30c LPP / art. 3 OPP 3), mais tu
                  payes l&apos;impôt de sortie (~5 %) et tu perds le rendement
                  futur + la protection.
                </div>
              </div>
            </div>

            <div className="mt-5 pt-4 border-t border-white/10 text-sm text-white/85 leading-relaxed">
              <strong className="text-klary-orange">
                Résultat pour la banque :
              </strong>{" "}
              un client qui présente un 3a de {formatCHF(s.capitalFutur.avecRendement)} CHF
              nanti est <strong>beaucoup plus solide</strong> qu&apos;un client
              sans épargne. Ça débloque des taux plus avantageux, une meilleure
              LTV (loan-to-value) et parfois même la validation d&apos;un
              dossier qui aurait été refusé sans.
            </div>

            <div className="mt-4 text-xs text-white/60 italic">
              💡 C&apos;est aussi pour ça qu&apos;on te dit que le 3a est
              intéressant même si tu n&apos;achètes pas tout de suite :
              plus tu commences tôt, plus ton capital est important quand
              tu passes devant la banque.
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
