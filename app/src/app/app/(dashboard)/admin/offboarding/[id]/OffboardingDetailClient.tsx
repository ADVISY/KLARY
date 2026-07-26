"use client";

import { useState, useRef } from "react";
import { useRouter } from "next/navigation";
import Link from "next/link";

type Offb = any;

const REASON_LABELS: Record<string, string> = {
  demission: "Démission",
  mutuel_accord: "Rupture d'un commun accord",
  rupture_essai: "Rupture période d'essai",
  fin_cdd: "Fin CDD",
  retraite: "Retraite",
  licenciement: "Licenciement (préavis normal)",
  faute_grave: "Licenciement pour faute grave",
  abandon_poste: "Abandon de poste",
};

const CHECKLIST_ITEMS = [
  {
    key: "access_revoked",
    label: "Accès techniques révoqués",
    hint: "Email Infomaniak, LYTA, Google, badges Regus, compagnies",
    responsible: "office@",
  },
  {
    key: "equipment_returned",
    label: "Matériel restitué",
    hint: "Ordinateur, badges, clés, téléphone pro, cartes de visite",
    responsible: "office@",
  },
  {
    key: "portfolio_transferred",
    label: "Portefeuille transféré",
    hint: "À quel agent (choisir ci-dessous)",
    responsible: "admin@",
    needsPortfolioTarget: true,
  },
  {
    key: "final_commissions_calculated",
    label: "Commissions finales calculées",
    hint: "Voir Annexe III — 20% ou 100% dans compte caution × 3 ans",
    responsible: "finance@",
    needsAmount: true,
  },
  {
    key: "work_certificate_issued",
    label: "Certificat de travail émis",
    hint: "Arbeitszeugnis qualifiant (art. 330a CO)",
    responsible: "Sacha / admin@",
  },
  {
    key: "attestation_ac_issued",
    label: "Attestation d'employeur pour l'AC émise",
    hint: "SECO — assurance chômage",
    responsible: "finance@",
  },
  {
    key: "salary_final_sent",
    label: "Décompte de salaire final + solde de tout compte envoyé",
    hint: "Dernier mois + vacances + 13e pro rata",
    responsible: "finance@",
  },
  {
    key: "lawid_sent",
    label: "Certificat de salaire annuel LAWID envoyé",
    hint: "Début année suivante (pour déclaration fiscale)",
    responsible: "finance@",
  },
  {
    key: "finma_registry_updated",
    label: "Registre intermédiaires FINMA mis à jour",
    hint: "Radiation notifiée à la FINMA (10 jours ouvrés max)",
    responsible: "admin@",
  },
] as const;

export function OffboardingDetailClient({
  offboarding,
  signedConventionUrl,
  transferableAgents,
}: {
  offboarding: Offb;
  signedConventionUrl: string | null;
  transferableAgents: {
    user_id: string;
    first_name: string;
    last_name: string;
    role: string;
  }[];
}) {
  const router = useRouter();
  const [uploading, setUploading] = useState(false);
  const [file, setFile] = useState<File | null>(null);
  const [drag, setDrag] = useState(false);
  const [uploadError, setUploadError] = useState<string | null>(null);
  const inputFileRef = useRef<HTMLInputElement>(null);

  const conventionSigned = !!offboarding.convention_signed_uploaded_at;
  const isSensitive = [
    "faute_grave",
    "abandon_poste",
    "licenciement",
  ].includes(offboarding.reason);

  const uploadSigned = async () => {
    if (!file) return;
    setUploading(true);
    setUploadError(null);
    const fd = new FormData();
    fd.set("file", file);
    try {
      const res = await fetch(
        `/api/admin/offboarding/${offboarding.id}/upload-signed`,
        { method: "POST", body: fd }
      );
      const data = await res.json();
      if (!res.ok) {
        setUploadError(data?.error || "Erreur upload");
        setUploading(false);
        return;
      }
      setFile(null);
      router.refresh();
    } catch {
      setUploadError("Erreur réseau");
    } finally {
      setUploading(false);
    }
  };

  const toggleChecklist = async (
    item: string,
    action: "check" | "uncheck",
    extras: any = {}
  ) => {
    const res = await fetch(
      `/api/admin/offboarding/${offboarding.id}/checklist`,
      {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ item, action, ...extras }),
      }
    );
    if (res.ok) router.refresh();
    else alert("Erreur");
  };

  const completedItems = CHECKLIST_ITEMS.filter(
    (i) => offboarding[`${i.key}_at`] != null
  ).length;

  return (
    <div className="max-w-5xl mx-auto p-6 md:p-10">
      <div className="mb-6">
        <Link
          href="/admin/offboarding"
          className="text-sm text-klary-grey hover:text-klary-orange"
        >
          ← Retour à la liste
        </Link>
      </div>

      {/* Header */}
      <div className="bg-white rounded-2xl border border-klary-light-grey p-8 mb-6">
        <div className="flex items-start justify-between gap-4 mb-4">
          <div>
            <div className="text-xs font-bold tracking-widest uppercase text-klary-orange mb-2">
              Dossier offboarding
            </div>
            <h1 className="text-3xl font-bold text-klary-navy">
              {offboarding.first_name} {offboarding.last_name}
            </h1>
            <div className="text-sm text-klary-grey mt-1">
              {offboarding.agent_email}
            </div>
          </div>
          {offboarding.completed_at && (
            <span className="px-3 py-1 rounded-full text-xs font-bold bg-green-100 text-green-800">
              ✓ Finalisé
            </span>
          )}
        </div>

        <div className="grid grid-cols-2 md:grid-cols-3 gap-3 text-sm mb-4">
          <div>
            <div className="text-[10px] uppercase tracking-widest text-klary-grey font-bold mb-1">
              Motif
            </div>
            <div className="font-semibold text-klary-navy">
              {REASON_LABELS[offboarding.reason] || offboarding.reason}
            </div>
          </div>
          <div>
            <div className="text-[10px] uppercase tracking-widest text-klary-grey font-bold mb-1">
              Dernier jour
            </div>
            <div className="font-semibold text-klary-navy">
              {offboarding.last_working_day
                ? new Date(offboarding.last_working_day).toLocaleDateString(
                    "fr-CH"
                  )
                : "—"}
            </div>
          </div>
          <div>
            <div className="text-[10px] uppercase tracking-widest text-klary-grey font-bold mb-1">
              Progression
            </div>
            <div className="font-semibold text-klary-navy">
              {completedItems} / {CHECKLIST_ITEMS.length} + convention
            </div>
          </div>
        </div>

        {offboarding.admin_notes && (
          <div className="mt-4 p-3 bg-klary-cream rounded-lg text-xs text-klary-ink whitespace-pre-wrap">
            <strong>Notes admin :</strong> {offboarding.admin_notes}
          </div>
        )}

        {isSensitive && (
          <div className="mt-4 p-3 bg-red-50 border-l-4 border-red-500 rounded text-sm text-red-900">
            🚨 <strong>Motif sensible</strong> — consulter le conseiller
            juridique avant toute action irréversible.
          </div>
        )}
      </div>

      {/* Convention de sortie */}
      <div className="bg-white rounded-2xl border border-klary-light-grey p-8 mb-6">
        <h2 className="font-bold text-klary-navy mb-4 flex items-center gap-2">
          📄 Convention de sortie
        </h2>

        <div className="mb-4 flex flex-wrap gap-3">
          <a
            href={`/admin/offboarding/${offboarding.id}/convention`}
            target="_blank"
            rel="noopener noreferrer"
            className="inline-flex items-center gap-2 px-4 py-2.5 bg-klary-navy text-white font-semibold rounded-lg hover:bg-klary-navy/90 text-sm"
          >
            📥 Télécharger la convention à imprimer
          </a>
          <div className="text-xs text-klary-grey max-w-md">
            Imprimer sur papier Klary tamponné, en <strong>2 exemplaires</strong>.
            Remise en main propre à l'agent ou par courrier recommandé A+.
            Ne PAS envoyer par email (risque de fuite).
          </div>
        </div>

        {conventionSigned ? (
          <div className="p-4 bg-green-50 border-2 border-green-300 rounded-xl">
            <div className="flex items-center gap-2 text-green-900 font-semibold mb-2">
              <span>✓</span>
              <span>
                Convention signée uploadée le{" "}
                {new Date(
                  offboarding.convention_signed_uploaded_at
                ).toLocaleString("fr-CH")}
              </span>
            </div>
            {signedConventionUrl && (
              <a
                href={signedConventionUrl}
                target="_blank"
                rel="noopener noreferrer"
                className="text-sm text-green-700 hover:underline"
              >
                Voir le document signé →
              </a>
            )}
          </div>
        ) : (
          <div className="p-4 bg-yellow-50 border-2 border-yellow-300 rounded-xl">
            <div className="text-yellow-900 font-semibold text-sm mb-3">
              ⏳ En attente du scan signé par l'agent
            </div>
            {file ? (
              <div className="p-3 bg-white rounded-lg flex items-center gap-3 mb-3">
                <div className="text-2xl">📎</div>
                <div className="flex-1 min-w-0 text-sm">
                  <div className="font-semibold text-klary-navy truncate">
                    {file.name}
                  </div>
                  <div className="text-xs text-klary-grey">
                    {(file.size / 1024 / 1024).toFixed(1)} Mo
                  </div>
                </div>
                <button
                  onClick={() => setFile(null)}
                  className="text-xs text-red-600 hover:underline"
                >
                  Retirer
                </button>
              </div>
            ) : (
              <div
                onDragOver={(e) => {
                  e.preventDefault();
                  setDrag(true);
                }}
                onDragLeave={() => setDrag(false)}
                onDrop={(e) => {
                  e.preventDefault();
                  setDrag(false);
                  const f = e.dataTransfer.files?.[0];
                  if (f) setFile(f);
                }}
                onClick={() => inputFileRef.current?.click()}
                className={`cursor-pointer p-6 border-2 border-dashed rounded-xl text-center transition ${
                  drag
                    ? "border-klary-orange bg-klary-orange/10"
                    : "border-yellow-400 hover:border-klary-orange"
                }`}
              >
                <div className="text-2xl mb-1">📤</div>
                <div className="text-sm font-semibold text-klary-navy">
                  Glisser ici le scan signé (PDF ou JPG)
                </div>
                <div className="text-xs text-klary-grey mt-1">
                  ou cliquer pour parcourir · max 10 Mo
                </div>
              </div>
            )}
            <input
              ref={inputFileRef}
              type="file"
              accept=".pdf,.jpg,.jpeg,.png"
              onChange={(e) => setFile(e.target.files?.[0] || null)}
              className="hidden"
            />
            {uploadError && (
              <div className="mt-2 p-2 bg-red-50 border-l-4 border-red-400 text-xs text-red-800">
                {uploadError}
              </div>
            )}
            {file && (
              <button
                onClick={uploadSigned}
                disabled={uploading}
                className="mt-3 w-full py-2.5 bg-klary-orange text-white font-semibold rounded-lg hover:bg-klary-orange/90 disabled:opacity-50 text-sm"
              >
                {uploading
                  ? "Envoi…"
                  : "Confirmer l'upload — déclencher email finance"}
              </button>
            )}
          </div>
        )}
      </div>

      {/* Checklist */}
      <div className="bg-white rounded-2xl border border-klary-light-grey p-8">
        <h2 className="font-bold text-klary-navy mb-4 flex items-center gap-2">
          ✅ Checklist des étapes ({completedItems}/{CHECKLIST_ITEMS.length})
        </h2>

        <div className="space-y-3">
          {CHECKLIST_ITEMS.map((item) => {
            const done = offboarding[`${item.key}_at`] != null;
            const doneDate = offboarding[`${item.key}_at`];
            const notes = offboarding[`${item.key}_notes`];

            return (
              <div
                key={item.key}
                className={`p-4 rounded-xl border-2 transition ${
                  done
                    ? "border-green-200 bg-green-50/40"
                    : "border-klary-light-grey bg-white"
                }`}
              >
                <div className="flex items-start gap-3">
                  <button
                    onClick={() =>
                      toggleChecklist(item.key, done ? "uncheck" : "check")
                    }
                    className={`mt-0.5 w-6 h-6 rounded-md border-2 flex items-center justify-center shrink-0 transition ${
                      done
                        ? "bg-green-600 border-green-600 text-white"
                        : "border-klary-light-grey hover:border-klary-orange"
                    }`}
                  >
                    {done && "✓"}
                  </button>
                  <div className="flex-1">
                    <div className="flex items-start justify-between gap-3">
                      <div>
                        <div
                          className={`font-semibold text-sm ${
                            done ? "text-green-900" : "text-klary-navy"
                          }`}
                        >
                          {item.label}
                        </div>
                        <div className="text-xs text-klary-grey mt-0.5">
                          {item.hint}
                        </div>
                      </div>
                      <span className="text-[10px] text-klary-grey shrink-0 mt-0.5">
                        {item.responsible}
                      </span>
                    </div>

                    {done && (
                      <div className="mt-2 text-xs text-green-700">
                        Fait le{" "}
                        {new Date(doneDate).toLocaleString("fr-CH", {
                          day: "2-digit",
                          month: "2-digit",
                          year: "2-digit",
                          hour: "2-digit",
                          minute: "2-digit",
                        })}
                        {item.key === "final_commissions_calculated" &&
                          offboarding.final_commissions_amount != null && (
                            <>
                              {" · "}
                              <strong>
                                CHF {offboarding.final_commissions_amount}
                              </strong>
                            </>
                          )}
                      </div>
                    )}
                    {notes && (
                      <div className="mt-2 p-2 bg-klary-cream rounded text-xs text-klary-ink whitespace-pre-wrap">
                        {notes}
                      </div>
                    )}
                    {item.key === "portfolio_transferred" && done && (
                      <div className="mt-1 text-xs text-klary-grey">
                        Portefeuille repris par :{" "}
                        {(() => {
                          const target = transferableAgents.find(
                            (a) => a.user_id === offboarding.portfolio_transferred_to
                          );
                          return target
                            ? `${target.first_name} ${target.last_name} (${target.role})`
                            : "—";
                        })()}
                      </div>
                    )}
                  </div>
                </div>
              </div>
            );
          })}
        </div>

        {offboarding.completed_at && (
          <div className="mt-6 p-4 bg-green-100 border-2 border-green-300 rounded-xl text-center">
            <div className="text-2xl mb-1">🎉</div>
            <div className="font-bold text-green-900">
              Offboarding finalisé
            </div>
            <div className="text-xs text-green-700 mt-1">
              Le {new Date(offboarding.completed_at).toLocaleString("fr-CH")}
            </div>
          </div>
        )}
      </div>
    </div>
  );
}
