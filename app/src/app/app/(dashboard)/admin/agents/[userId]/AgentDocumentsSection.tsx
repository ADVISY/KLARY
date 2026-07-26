"use client";

import { useState, useRef } from "react";
import { useRouter } from "next/navigation";

const DOCUMENT_TYPES = [
  { value: "contrat_travail", label: "Contrat de travail" },
  { value: "avenant", label: "Avenant au contrat" },
  { value: "convention_sortie", label: "Convention de sortie" },
  { value: "certif_travail", label: "Certificat de travail" },
  { value: "attestation_ac", label: "Attestation d'employeur pour l'AC" },
  { value: "lawid", label: "Certificat de salaire annuel LAWID" },
  { value: "decompte_salaire", label: "Décompte de salaire" },
  { value: "recu_materiel", label: "Reçu de matériel" },
  { value: "fiche_poste", label: "Fiche de poste signée" },
  { value: "attestation_formation", label: "Attestation de formation" },
  { value: "autre_rh", label: "Autre document RH" },
];

const DOCUMENT_TYPE_LABELS: Record<string, string> = Object.fromEntries(
  DOCUMENT_TYPES.map((t) => [t.value, t.label])
);

const SIGNATURE_METHODS = [
  { value: "manuscrite_scan", label: "Signature manuscrite (scan papier)" },
  { value: "unsigned", label: "Non signé (pour info)" },
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

function iconForType(type: string | null): string {
  if (!type) return "📎";
  if (type === "application/pdf") return "📄";
  if (type.startsWith("image/")) return "🖼";
  if (type.includes("word") || type.includes("document")) return "📝";
  return "📎";
}

export function AgentDocumentsSection({
  userId,
  docs,
  canDelete,
}: {
  userId: string;
  docs: Doc[];
  canDelete: boolean;
}) {
  const router = useRouter();
  const [file, setFile] = useState<File | null>(null);
  const [drag, setDrag] = useState(false);
  const [uploading, setUploading] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const [downloading, setDownloading] = useState<string | null>(null);
  const [showUpload, setShowUpload] = useState(false);
  const formRef = useRef<HTMLFormElement>(null);
  const inputFileRef = useRef<HTMLInputElement>(null);

  const submit = async (e: React.FormEvent<HTMLFormElement>) => {
    e.preventDefault();
    if (!file) {
      setError("Sélectionnez un fichier");
      return;
    }
    setUploading(true);
    setError(null);
    const fd = new FormData(e.currentTarget);
    fd.set("file", file);
    try {
      const res = await fetch(`/api/admin/agents/${userId}/documents`, {
        method: "POST",
        body: fd,
      });
      const data = await res.json();
      if (!res.ok) {
        setError(data?.error || "Erreur upload");
        setUploading(false);
        return;
      }
      formRef.current?.reset();
      setFile(null);
      setShowUpload(false);
      router.refresh();
    } catch {
      setError("Erreur réseau");
    } finally {
      setUploading(false);
    }
  };

  const download = async (docId: string) => {
    setDownloading(docId);
    try {
      const res = await fetch(
        `/api/admin/agents/${userId}/documents/${docId}/download`
      );
      const data = await res.json();
      if (data?.url) {
        window.location.href = data.url;
      } else {
        alert(data?.error || "Impossible de télécharger");
      }
    } catch {
      alert("Erreur réseau");
    } finally {
      setDownloading(null);
    }
  };

  const deleteDoc = async (docId: string) => {
    if (!confirm("Masquer ce document ? Il ne sera plus visible.")) return;
    const res = await fetch(
      `/api/admin/agents/${userId}/documents/${docId}/delete`,
      { method: "POST" }
    );
    if (res.ok) router.refresh();
    else alert("Erreur");
  };

  return (
    <div className="bg-white rounded-2xl border border-klary-light-grey p-6">
      <div className="flex items-center justify-between mb-4">
        <h2 className="font-bold text-klary-navy flex items-center gap-2">
          🗄 Documents internes ({docs.length})
        </h2>
        <button
          onClick={() => setShowUpload((v) => !v)}
          className={`text-xs font-semibold px-3 py-1.5 rounded-lg transition ${
            showUpload
              ? "bg-klary-light-grey text-klary-navy"
              : "bg-klary-orange text-white hover:bg-klary-orange/90"
          }`}
        >
          {showUpload ? "✕ Fermer" : "+ Ajouter un document"}
        </button>
      </div>

      {/* Formulaire upload */}
      {showUpload && (
        <form
          ref={formRef}
          onSubmit={submit}
          className="p-4 bg-klary-cream/60 rounded-xl mb-6 space-y-4"
        >
          <div>
            <label className="block text-xs font-semibold text-klary-ink mb-1.5">
              Fichier <span className="text-klary-orange">*</span>
            </label>
            {file ? (
              <div className="p-3 bg-white rounded-lg flex items-center gap-3">
                <div className="text-2xl">{iconForType(file.type)}</div>
                <div className="flex-1 min-w-0 text-sm">
                  <div className="font-semibold text-klary-navy truncate">
                    {file.name}
                  </div>
                  <div className="text-xs text-klary-grey">
                    {formatSize(file.size)}
                  </div>
                </div>
                <button
                  type="button"
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
                    : "border-klary-light-grey hover:border-klary-orange"
                }`}
              >
                <div className="text-2xl mb-1">📤</div>
                <div className="text-sm font-semibold text-klary-navy">
                  Glisser un fichier ici
                </div>
                <div className="text-xs text-klary-grey">
                  ou cliquer pour parcourir · PDF/JPG/PNG/DOC · max 25 Mo
                </div>
              </div>
            )}
            <input
              ref={inputFileRef}
              type="file"
              accept=".pdf,.jpg,.jpeg,.png,.doc,.docx"
              onChange={(e) => setFile(e.target.files?.[0] || null)}
              className="hidden"
            />
          </div>

          <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
            <div>
              <label className="block text-xs font-semibold text-klary-ink mb-1.5">
                Type de document <span className="text-klary-orange">*</span>
              </label>
              <select name="document_type" required className="input">
                <option value="">— Sélectionnez —</option>
                {DOCUMENT_TYPES.map((t) => (
                  <option key={t.value} value={t.value}>
                    {t.label}
                  </option>
                ))}
              </select>
            </div>
            <div>
              <label className="block text-xs font-semibold text-klary-ink mb-1.5">
                Statut signature
              </label>
              <select name="signature_method" className="input">
                {SIGNATURE_METHODS.map((s) => (
                  <option key={s.value} value={s.value}>
                    {s.label}
                  </option>
                ))}
              </select>
            </div>
          </div>

          <div>
            <label className="block text-xs font-semibold text-klary-ink mb-1.5">
              Titre <span className="text-klary-orange">*</span>
            </label>
            <input
              type="text"
              name="title"
              required
              placeholder="Ex: Contrat de travail signé — 15 mars 2024"
              className="input"
            />
          </div>

          <div>
            <label className="block text-xs font-semibold text-klary-ink mb-1.5">
              Description / notes
            </label>
            <textarea
              name="description"
              rows={2}
              placeholder="Contexte, remarques, référence contrat…"
              className="input"
            />
          </div>

          {error && (
            <div className="p-3 bg-red-50 border-l-4 border-red-400 rounded text-sm text-red-800">
              {error}
            </div>
          )}

          <button
            type="submit"
            disabled={uploading || !file}
            className={`w-full py-2.5 rounded-lg font-bold text-white text-sm transition ${
              uploading || !file
                ? "bg-klary-grey/40 cursor-not-allowed"
                : "bg-klary-orange hover:bg-klary-orange/90"
            }`}
          >
            {uploading ? "Envoi…" : "Ajouter au coffre-fort"}
          </button>
        </form>
      )}

      {/* Liste documents */}
      {docs.length === 0 ? (
        <div className="p-6 text-center text-sm text-klary-grey italic">
          Aucun document interne pour l'instant.
          <br />
          Cliquez sur "+ Ajouter un document" pour uploader le premier.
        </div>
      ) : (
        <div className="space-y-2">
          {docs.map((d) => (
            <div
              key={d.id}
              className="flex items-center justify-between gap-3 p-3 border border-klary-light-grey rounded-xl hover:border-klary-orange/50 bg-white"
            >
              <div className="min-w-0 flex-1 flex items-center gap-3">
                <div className="text-2xl shrink-0">
                  {iconForType(d.content_type)}
                </div>
                <div className="min-w-0 flex-1">
                  <div className="flex flex-wrap items-center gap-2 mb-0.5">
                    <span className="text-[10px] uppercase tracking-widest font-bold px-1.5 py-0.5 rounded bg-klary-cream text-klary-grey">
                      {DOCUMENT_TYPE_LABELS[d.document_type] || d.document_type}
                    </span>
                    {d.signature_method === "unsigned" ? (
                      <span className="text-[10px] px-1.5 py-0.5 rounded bg-yellow-100 text-yellow-800">
                        Non signé
                      </span>
                    ) : (
                      <span className="text-[10px] px-1.5 py-0.5 rounded bg-green-100 text-green-800">
                        ✓ Signé
                      </span>
                    )}
                  </div>
                  <div className="font-semibold text-klary-navy text-sm">
                    {d.title}
                  </div>
                  {d.description && (
                    <div className="text-xs text-klary-grey mt-0.5 line-clamp-1">
                      {d.description}
                    </div>
                  )}
                  <div className="text-[10px] text-klary-grey mt-0.5">
                    {d.filename} · {formatSize(d.size_bytes)} ·{" "}
                    {new Date(d.created_at).toLocaleDateString("fr-CH")}
                  </div>
                </div>
              </div>
              <div className="flex items-center gap-2 shrink-0">
                <button
                  onClick={() => download(d.id)}
                  disabled={downloading === d.id}
                  className="px-3 py-1.5 text-xs font-semibold text-white bg-klary-navy rounded-lg hover:bg-klary-navy/90 disabled:opacity-50"
                >
                  {downloading === d.id ? "…" : "Télécharger"}
                </button>
                {canDelete && (
                  <button
                    onClick={() => deleteDoc(d.id)}
                    className="px-2 py-1.5 text-xs text-red-600 hover:bg-red-50 rounded-lg"
                    title="Masquer"
                  >
                    ✕
                  </button>
                )}
              </div>
            </div>
          ))}
        </div>
      )}

      <style jsx>{`
        .input {
          width: 100%;
          padding: 9px 12px;
          border: 1px solid #ddd9e8;
          border-radius: 8px;
          background: white;
          font-size: 13px;
          color: #1f1b4b;
        }
        .input:focus {
          outline: none;
          border-color: #f0651f;
        }
      `}</style>
    </div>
  );
}
