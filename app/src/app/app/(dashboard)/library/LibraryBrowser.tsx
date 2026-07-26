"use client";

import { useState, useMemo } from "react";
import Link from "next/link";

type Doc = {
  id: string;
  title: string;
  description: string | null;
  category: string;
  tags: string[] | null;
  filename: string;
  size_bytes: number | null;
  content_type: string | null;
  download_count: number | null;
  created_at: string;
};

type Category = {
  key: string;
  label: string;
  icon: string;
  color: string;
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
  if (type.includes("sheet") || type.includes("excel")) return "📊";
  if (type.includes("presentation")) return "📽";
  return "📎";
}

export function LibraryBrowser({
  docs,
  categories,
}: {
  docs: Doc[];
  categories: Category[];
}) {
  const [selectedCat, setSelectedCat] = useState<string>("all");
  const [search, setSearch] = useState("");
  const [downloading, setDownloading] = useState<string | null>(null);

  const filtered = useMemo(() => {
    const q = search.toLowerCase().trim();
    return docs.filter((d) => {
      if (selectedCat !== "all" && d.category !== selectedCat) return false;
      if (!q) return true;
      return (
        d.title.toLowerCase().includes(q) ||
        (d.description || "").toLowerCase().includes(q) ||
        (d.tags || []).some((t) => t.toLowerCase().includes(q)) ||
        d.filename.toLowerCase().includes(q)
      );
    });
  }, [docs, selectedCat, search]);

  const catCount = useMemo(() => {
    const m: Record<string, number> = {};
    for (const d of docs) m[d.category] = (m[d.category] || 0) + 1;
    return m;
  }, [docs]);

  const catByKey = useMemo(() => {
    const m: Record<string, Category> = {};
    for (const c of categories) m[c.key] = c;
    return m;
  }, [categories]);

  const download = async (docId: string) => {
    setDownloading(docId);
    try {
      const res = await fetch(`/api/library/${docId}/download`);
      const data = await res.json();
      if (data?.url) {
        window.location.href = data.url;
      } else {
        alert("Impossible de télécharger ce document.");
      }
    } catch {
      alert("Erreur réseau.");
    } finally {
      setDownloading(null);
    }
  };

  return (
    <>
      {/* Search + Filter bar */}
      <div className="mb-6 space-y-4">
        <input
          type="text"
          value={search}
          onChange={(e) => setSearch(e.target.value)}
          placeholder="🔍 Rechercher un document (titre, description, tag, fichier…)"
          className="w-full px-4 py-3 border border-klary-light-grey rounded-xl bg-white text-sm focus:outline-none focus:border-klary-orange"
        />

        <div className="flex flex-wrap gap-2">
          <button
            onClick={() => setSelectedCat("all")}
            className={`px-3 py-1.5 rounded-full text-xs font-semibold transition ${
              selectedCat === "all"
                ? "bg-klary-navy text-white"
                : "bg-white border border-klary-light-grey text-klary-navy hover:border-klary-navy"
            }`}
          >
            Toutes ({docs.length})
          </button>
          {categories.map((c) => (
            <button
              key={c.key}
              onClick={() => setSelectedCat(c.key)}
              className={`px-3 py-1.5 rounded-full text-xs font-semibold transition flex items-center gap-1.5 ${
                selectedCat === c.key
                  ? "bg-klary-orange text-white"
                  : "bg-white border border-klary-light-grey text-klary-navy hover:border-klary-orange"
              }`}
            >
              <span>{c.icon}</span>
              {c.label} ({catCount[c.key] || 0})
            </button>
          ))}
        </div>
      </div>

      {/* Results */}
      {filtered.length === 0 ? (
        <div className="bg-white rounded-2xl border border-klary-light-grey p-10 text-center">
          <div className="text-3xl mb-3">📚</div>
          <h2 className="text-lg font-bold text-klary-navy mb-2">
            Aucun document
          </h2>
          <p className="text-sm text-klary-grey">
            {search
              ? "Aucun résultat pour votre recherche. Essayez d'autres mots-clés."
              : "La bibliothèque est vide pour cette catégorie. Les documents ajoutés par la direction apparaîtront ici."}
          </p>
        </div>
      ) : (
        <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
          {filtered.map((d) => {
            const cat = catByKey[d.category] || {
              icon: "📎",
              label: d.category,
              color: "bg-gray-100 text-gray-700",
              key: d.category,
            };
            return (
              <div
                key={d.id}
                className="bg-white rounded-2xl border border-klary-light-grey p-5 hover:shadow-md hover:border-klary-orange/50 transition"
              >
                <div className="flex items-start gap-3 mb-3">
                  <div className="text-3xl shrink-0">
                    {iconForType(d.content_type)}
                  </div>
                  <div className="min-w-0 flex-1">
                    <div
                      className={`inline-block text-[10px] uppercase tracking-widest font-bold px-2 py-0.5 rounded ${cat.color} mb-1`}
                    >
                      {cat.icon} {cat.label}
                    </div>
                    <h3 className="font-bold text-klary-navy text-sm leading-tight">
                      {d.title}
                    </h3>
                    {d.description && (
                      <p className="text-xs text-klary-grey mt-1 line-clamp-2">
                        {d.description}
                      </p>
                    )}
                  </div>
                </div>

                {d.tags && d.tags.length > 0 && (
                  <div className="flex flex-wrap gap-1 mb-3">
                    {d.tags.map((t) => (
                      <span
                        key={t}
                        className="text-[10px] px-2 py-0.5 rounded bg-klary-cream text-klary-grey"
                      >
                        {t}
                      </span>
                    ))}
                  </div>
                )}

                <div className="flex items-center justify-between pt-3 border-t border-klary-light-grey">
                  <div className="text-xs text-klary-grey truncate flex-1 min-w-0">
                    {d.filename}
                    {d.size_bytes ? ` · ${formatSize(d.size_bytes)}` : ""}
                  </div>
                  <button
                    onClick={() => download(d.id)}
                    disabled={downloading === d.id}
                    className="ml-3 px-3 py-1.5 bg-klary-orange text-white text-xs font-semibold rounded-lg hover:bg-klary-orange/90 disabled:opacity-50 disabled:cursor-not-allowed shrink-0"
                  >
                    {downloading === d.id ? "…" : "Télécharger"}
                  </button>
                </div>
              </div>
            );
          })}
        </div>
      )}
    </>
  );
}
