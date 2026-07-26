"use client";

import { useState, useMemo } from "react";

const DOCUMENT_TYPE_LABELS: Record<string, string> = {
  contrat_travail: "Contrat de travail",
  avenant: "Avenant au contrat",
  convention_sortie: "Convention de sortie",
  certif_travail: "Certificat de travail",
  attestation_ac: "Attestation d'employeur pour l'AC",
  lawid: "Certificat de salaire annuel LAWID",
  decompte_salaire: "Décompte de salaire",
  recu_materiel: "Reçu de matériel",
  fiche_poste: "Fiche de poste signée",
  attestation_formation: "Attestation de formation",
  autre_rh: "Autre document RH",
};

const DOC_CATEGORIES = [
  { key: "all", label: "Tous", icon: "📁" },
  {
    key: "contrat",
    label: "Contrats",
    icon: "📝",
    types: ["contrat_travail", "avenant"],
  },
  {
    key: "attestations",
    label: "Attestations",
    icon: "📄",
    types: [
      "certif_travail",
      "attestation_ac",
      "lawid",
      "attestation_formation",
      "fiche_poste",
    ],
  },
  {
    key: "salaires",
    label: "Salaires",
    icon: "💰",
    types: ["decompte_salaire"],
  },
  {
    key: "sortie",
    label: "Sortie",
    icon: "🚪",
    types: ["convention_sortie"],
  },
  {
    key: "autre",
    label: "Autre",
    icon: "📎",
    types: ["recu_materiel", "autre_rh"],
  },
];

type Doc = {
  id: string;
  document_type: string;
  title: string;
  description: string | null;
  filename: string;
  size_bytes: number | null;
  content_type: string | null;
  signature_method: string | null;
  signed_at: string | null;
  created_at: string;
};

function formatSize(bytes: number | null): string {
  if (!bytes) return "";
  if (bytes < 1024 * 1024) return `${(bytes / 1024).toFixed(0)} Ko`;
  return `${(bytes / (1024 * 1024)).toFixed(1)} Mo`;
}

function iconForType(contentType: string | null): string {
  if (!contentType) return "📎";
  if (contentType === "application/pdf") return "📄";
  if (contentType.startsWith("image/")) return "🖼";
  if (contentType.includes("word") || contentType.includes("document"))
    return "📝";
  return "📎";
}

export function MyDocumentsList({ docs }: { docs: Doc[] }) {
  const [selectedCat, setSelectedCat] = useState<string>("all");
  const [downloading, setDownloading] = useState<string | null>(null);

  const filtered = useMemo(() => {
    if (selectedCat === "all") return docs;
    const cat = DOC_CATEGORIES.find((c) => c.key === selectedCat);
    if (!cat?.types) return docs;
    return docs.filter((d) => cat.types.includes(d.document_type));
  }, [docs, selectedCat]);

  const catCount = useMemo(() => {
    const m: Record<string, number> = { all: docs.length };
    for (const cat of DOC_CATEGORIES) {
      if (cat.types) {
        m[cat.key] = docs.filter((d) => cat.types.includes(d.document_type))
          .length;
      }
    }
    return m;
  }, [docs]);

  const download = async (docId: string) => {
    setDownloading(docId);
    try {
      const res = await fetch(`/api/mes-documents/${docId}/download`);
      const data = await res.json();
      if (data?.url) {
        window.location.href = data.url;
      } else {
        alert(data?.error || "Impossible de télécharger ce document.");
      }
    } catch {
      alert("Erreur réseau. Réessayez.");
    } finally {
      setDownloading(null);
    }
  };

  if (docs.length === 0) {
    return (
      <div className="bg-white rounded-2xl border border-klary-light-grey p-10 text-center">
        <div className="text-4xl mb-3">📂</div>
        <h2 className="text-xl font-bold text-klary-navy mb-2">
          Aucun document pour l'instant
        </h2>
        <p className="text-sm text-klary-grey max-w-md mx-auto">
          Les documents administratifs qui vous concernent (contrat de travail,
          attestations, décomptes de salaire, certificats de formation…)
          apparaîtront ici au fur et à mesure que Klary les ajoute à votre
          dossier.
        </p>
      </div>
    );
  }

  return (
    <>
      {/* Filtres catégories */}
      <div className="flex flex-wrap gap-2 mb-6">
        {DOC_CATEGORIES.map((cat) => {
          const count =
            cat.key === "all" ? docs.length : catCount[cat.key] || 0;
          if (cat.key !== "all" && count === 0) return null;
          return (
            <button
              key={cat.key}
              onClick={() => setSelectedCat(cat.key)}
              className={`px-3 py-1.5 rounded-full text-xs font-semibold transition flex items-center gap-1.5 ${
                selectedCat === cat.key
                  ? "bg-klary-orange text-white"
                  : "bg-white border border-klary-light-grey text-klary-navy hover:border-klary-orange"
              }`}
            >
              <span>{cat.icon}</span>
              {cat.label} ({count})
            </button>
          );
        })}
      </div>

      {/* Liste documents */}
      <div className="space-y-3">
        {filtered.map((d) => (
          <div
            key={d.id}
            className="bg-white rounded-2xl border border-klary-light-grey p-5 hover:shadow-sm hover:border-klary-orange/40 transition"
          >
            <div className="flex items-start justify-between gap-4">
              <div className="flex items-start gap-3 min-w-0 flex-1">
                <div className="text-3xl shrink-0">
                  {iconForType(d.content_type)}
                </div>
                <div className="min-w-0 flex-1">
                  <div className="flex flex-wrap items-center gap-2 mb-1">
                    <span className="text-[10px] uppercase tracking-widest font-bold px-2 py-0.5 rounded bg-klary-cream text-klary-grey">
                      {DOCUMENT_TYPE_LABELS[d.document_type] || d.document_type}
                    </span>
                    {d.signature_method === "unsigned" ? (
                      <span className="text-[10px] px-2 py-0.5 rounded bg-yellow-100 text-yellow-800 font-semibold">
                        Non signé
                      </span>
                    ) : (
                      <span className="text-[10px] px-2 py-0.5 rounded bg-green-100 text-green-800 font-semibold">
                        ✓ Signé
                      </span>
                    )}
                  </div>
                  <h3 className="font-bold text-klary-navy text-sm leading-tight">
                    {d.title}
                  </h3>
                  {d.description && (
                    <p className="text-xs text-klary-grey mt-1 leading-relaxed">
                      {d.description}
                    </p>
                  )}
                  <div className="text-[11px] text-klary-grey mt-2">
                    {d.filename}
                    {d.size_bytes ? ` · ${formatSize(d.size_bytes)}` : ""}
                    {" · Ajouté le "}
                    {new Date(d.created_at).toLocaleDateString("fr-CH")}
                  </div>
                </div>
              </div>

              <button
                onClick={() => download(d.id)}
                disabled={downloading === d.id}
                className="shrink-0 px-4 py-2 bg-klary-orange text-white text-sm font-semibold rounded-lg hover:bg-klary-orange/90 disabled:opacity-50 transition"
              >
                {downloading === d.id ? "…" : "Télécharger"}
              </button>
            </div>
          </div>
        ))}
      </div>

      <div className="mt-6 p-4 bg-klary-cream rounded-xl text-xs text-klary-grey text-center">
        💡 Ces documents sont votre <strong>copie personnelle</strong>. Les
        originaux signés restent archivés par Klary. En cas de besoin
        particulier (dossier bancaire, régie immobilière, administration),
        vous pouvez télécharger vos documents à tout moment.
      </div>
    </>
  );
}
