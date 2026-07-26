"use client";

import { useState, useRef } from "react";
import { useRouter } from "next/navigation";

type Doc = {
  id: string;
  title: string;
  description: string | null;
  category: string;
  tags: string[] | null;
  target_roles: string[] | null;
  filename: string;
  size_bytes: number | null;
  is_active: boolean;
  download_count: number | null;
  created_at: string;
};

const JOB_TITLE_LABELS: Record<string, string> = {
  conseiller: "Conseiller",
  telephoniste: "Téléphoniste",
};

type Category = { key: string; label: string };

function formatSize(bytes: number | null): string {
  if (!bytes) return "";
  if (bytes < 1024 * 1024) return `${(bytes / 1024).toFixed(0)} Ko`;
  return `${(bytes / (1024 * 1024)).toFixed(1)} Mo`;
}

export function AdminLibraryPanel({
  docs,
  categories,
}: {
  docs: Doc[];
  categories: Category[];
}) {
  const router = useRouter();
  const [uploading, setUploading] = useState(false);
  const [uploadError, setUploadError] = useState<string | null>(null);
  const [file, setFile] = useState<File | null>(null);
  const formRef = useRef<HTMLFormElement>(null);
  const inputFileRef = useRef<HTMLInputElement>(null);

  const [drag, setDrag] = useState(false);

  const onDrop = (e: React.DragEvent) => {
    e.preventDefault();
    setDrag(false);
    const f = e.dataTransfer.files?.[0];
    if (f) setFile(f);
  };

  const submitUpload = async (e: React.FormEvent<HTMLFormElement>) => {
    e.preventDefault();
    setUploadError(null);
    if (!file) {
      setUploadError("Sélectionnez un fichier");
      return;
    }
    setUploading(true);
    const fd = new FormData(e.currentTarget);
    fd.set("file", file);
    try {
      const res = await fetch("/api/library/upload", {
        method: "POST",
        body: fd,
      });
      const data = await res.json();
      if (!res.ok) {
        setUploadError(data?.error || "Erreur upload");
        setUploading(false);
        return;
      }
      // Reset + refresh
      formRef.current?.reset();
      setFile(null);
      router.refresh();
    } catch {
      setUploadError("Erreur réseau");
    } finally {
      setUploading(false);
    }
  };

  const deleteDoc = async (id: string) => {
    if (!confirm("Masquer ce document ? Il ne sera plus visible par les agents.")) return;
    const res = await fetch(`/api/library/${id}/delete`, { method: "POST" });
    if (res.ok) router.refresh();
    else alert("Erreur");
  };

  const categoryLabel = (key: string) =>
    categories.find((c) => c.key === key)?.label || key;

  return (
    <>
      {/* Upload zone */}
      <div className="bg-white rounded-2xl border border-klary-light-grey p-6 mb-8">
        <h2 className="font-bold text-klary-navy mb-4 text-lg">
          ➕ Ajouter un document
        </h2>
        <form ref={formRef} onSubmit={submitUpload} className="space-y-4">
          <div>
            <label className="block text-xs font-semibold text-klary-ink mb-1.5">
              Fichier <span className="text-klary-orange">*</span>
            </label>
            {file ? (
              <div className="p-4 bg-green-50 border-2 border-green-300 rounded-xl flex items-center gap-3">
                <div className="text-2xl">📎</div>
                <div className="flex-1 min-w-0">
                  <div className="font-semibold text-green-900 truncate text-sm">
                    {file.name}
                  </div>
                  <div className="text-xs text-green-700">
                    {formatSize(file.size)} · {file.type || "type inconnu"}
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
                onDrop={onDrop}
                onClick={() => inputFileRef.current?.click()}
                className={`cursor-pointer p-6 border-2 border-dashed rounded-xl text-center transition ${
                  drag
                    ? "border-klary-orange bg-klary-orange/10"
                    : "border-klary-light-grey hover:border-klary-orange"
                }`}
              >
                <div className="text-3xl mb-1">📤</div>
                <div className="text-sm font-semibold text-klary-navy">
                  Glissez un fichier ici
                </div>
                <div className="text-xs text-klary-grey">
                  ou cliquez pour parcourir · max 25 Mo
                </div>
              </div>
            )}
            <input
              ref={inputFileRef}
              type="file"
              onChange={(e) => setFile(e.target.files?.[0] || null)}
              className="hidden"
            />
          </div>

          <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
            <div>
              <label className="block text-xs font-semibold text-klary-ink mb-1.5">
                Titre <span className="text-klary-orange">*</span>
              </label>
              <input
                name="title"
                type="text"
                required
                placeholder="Ex: Fiche produit COMPLETA Helsana"
                className="input"
              />
            </div>
            <div>
              <label className="block text-xs font-semibold text-klary-ink mb-1.5">
                Catégorie <span className="text-klary-orange">*</span>
              </label>
              <select name="category" required className="input">
                <option value="">— Sélectionnez —</option>
                {categories.map((c) => (
                  <option key={c.key} value={c.key}>{c.label}</option>
                ))}
              </select>
            </div>
            <div className="md:col-span-2">
              <label className="block text-xs font-semibold text-klary-ink mb-1.5">
                Description
              </label>
              <textarea
                name="description"
                rows={2}
                placeholder="Résumé, à quoi ça sert, dans quelle situation l'utiliser…"
                className="input"
              />
            </div>
            <div className="md:col-span-2">
              <label className="block text-xs font-semibold text-klary-ink mb-1.5">
                Tags (séparés par des virgules)
              </label>
              <input
                name="tags"
                type="text"
                placeholder="helsana, ambulatoire, LCA, ..."
                className="input"
              />
            </div>

            <div className="md:col-span-2">
              <label className="block text-xs font-semibold text-klary-ink mb-1.5">
                Postes concernés
              </label>
              <div className="flex flex-wrap gap-3">
                <label className="flex items-center gap-2 px-3 py-2 border border-klary-light-grey rounded-lg cursor-pointer hover:border-klary-orange text-sm">
                  <input
                    type="checkbox"
                    name="target_roles"
                    value="conseiller"
                    className="accent-klary-orange"
                  />
                  Conseiller
                </label>
                <label className="flex items-center gap-2 px-3 py-2 border border-klary-light-grey rounded-lg cursor-pointer hover:border-klary-orange text-sm">
                  <input
                    type="checkbox"
                    name="target_roles"
                    value="telephoniste"
                    className="accent-klary-orange"
                  />
                  Téléphoniste
                </label>
              </div>
              <div className="text-[11px] text-klary-grey mt-1">
                Si aucun poste coché : document visible par TOUS les agents. Sinon : visible uniquement pour les postes cochés.
              </div>
            </div>
          </div>

          {uploadError && (
            <div className="p-3 bg-red-50 border-l-4 border-red-400 rounded text-sm text-red-800">
              {uploadError}
            </div>
          )}

          <button
            type="submit"
            disabled={uploading}
            className={`w-full py-3 rounded-xl font-bold text-white transition ${
              uploading
                ? "bg-klary-grey/40 cursor-not-allowed"
                : "bg-klary-orange hover:bg-klary-orange/90"
            }`}
          >
            {uploading ? "Envoi…" : "Ajouter à la bibliothèque"}
          </button>
        </form>
      </div>

      {/* Liste */}
      <div className="bg-white rounded-2xl border border-klary-light-grey overflow-hidden">
        <div className="px-6 py-4 border-b border-klary-light-grey flex items-center justify-between">
          <h2 className="font-bold text-klary-navy">
            Documents ({docs.length})
          </h2>
        </div>

        {docs.length === 0 ? (
          <div className="p-10 text-center text-sm text-klary-grey">
            Aucun document dans la bibliothèque pour l'instant.
          </div>
        ) : (
          <table className="w-full text-sm">
            <thead className="bg-klary-cream text-klary-ink">
              <tr>
                <th className="text-left px-5 py-3 font-semibold">Titre</th>
                <th className="text-left px-5 py-3 font-semibold">Catégorie</th>
                <th className="text-left px-5 py-3 font-semibold">Fichier</th>
                <th className="text-center px-5 py-3 font-semibold">Téléchargé</th>
                <th className="text-center px-5 py-3 font-semibold">Statut</th>
                <th className="text-right px-5 py-3 font-semibold">Actions</th>
              </tr>
            </thead>
            <tbody>
              {docs.map((d) => (
                <tr
                  key={d.id}
                  className="border-t border-klary-light-grey hover:bg-klary-cream/30"
                >
                  <td className="px-5 py-3">
                    <div className="font-semibold text-klary-navy">{d.title}</div>
                    {d.description && (
                      <div className="text-xs text-klary-grey mt-0.5 line-clamp-1">
                        {d.description}
                      </div>
                    )}
                    {d.tags && d.tags.length > 0 && (
                      <div className="flex gap-1 mt-1">
                        {d.tags.map((t) => (
                          <span
                            key={t}
                            className="text-[10px] px-1.5 py-0.5 rounded bg-klary-cream text-klary-grey"
                          >
                            {t}
                          </span>
                        ))}
                      </div>
                    )}
                    <div className="flex gap-1 mt-1">
                      {d.target_roles && d.target_roles.length > 0 ? (
                        d.target_roles.map((r) => (
                          <span
                            key={r}
                            className="text-[10px] px-1.5 py-0.5 rounded bg-klary-orange/10 text-klary-orange font-semibold"
                          >
                            👤 {JOB_TITLE_LABELS[r] || r}
                          </span>
                        ))
                      ) : (
                        <span className="text-[10px] px-1.5 py-0.5 rounded bg-blue-50 text-blue-700 font-semibold">
                          👥 Tous les postes
                        </span>
                      )}
                    </div>
                  </td>
                  <td className="px-5 py-3 text-klary-ink text-xs">
                    {categoryLabel(d.category)}
                  </td>
                  <td className="px-5 py-3 text-klary-grey text-xs">
                    {d.filename}
                    {d.size_bytes ? ` · ${formatSize(d.size_bytes)}` : ""}
                  </td>
                  <td className="px-5 py-3 text-center font-mono text-klary-navy">
                    {d.download_count || 0}
                  </td>
                  <td className="px-5 py-3 text-center">
                    {d.is_active ? (
                      <span className="px-2 py-0.5 rounded-full text-[10px] font-semibold bg-green-100 text-green-800">
                        Actif
                      </span>
                    ) : (
                      <span className="px-2 py-0.5 rounded-full text-[10px] font-semibold bg-gray-100 text-gray-600">
                        Masqué
                      </span>
                    )}
                  </td>
                  <td className="px-5 py-3 text-right">
                    {d.is_active && (
                      <button
                        onClick={() => deleteDoc(d.id)}
                        className="text-red-600 text-xs font-semibold hover:underline"
                      >
                        Masquer
                      </button>
                    )}
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        )}
      </div>

      <style jsx>{`
        .input {
          width: 100%;
          padding: 10px 14px;
          border: 1px solid #ddd9e8;
          border-radius: 8px;
          background: white;
          font-size: 14px;
          color: #1f1b4b;
        }
        .input:focus {
          outline: none;
          border-color: #f0651f;
        }
      `}</style>
    </>
  );
}
