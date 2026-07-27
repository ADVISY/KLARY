"use client";

import { useEffect } from "react";

/**
 * Modal plein écran pour prévisualiser un PDF (ou tout doc rendu par le navigateur)
 * via <iframe>. Fermeture par ✕, clic backdrop, ou touche Échap.
 *
 * Utilisation :
 *   const [open, setOpen] = useState(false);
 *   const [url, setUrl] = useState<string | null>(null);
 *   ...
 *   {open && url && (
 *     <PdfPreviewModal
 *       url={url}
 *       title="Fiche produit SWICA"
 *       filename="swica.pdf"
 *       onClose={() => setOpen(false)}
 *     />
 *   )}
 */
export function PdfPreviewModal({
  url,
  title,
  filename,
  onClose,
  downloadUrl,
}: {
  url: string;
  title?: string;
  filename?: string;
  onClose: () => void;
  /** URL alternative pour forcer le téléchargement (bouton "Télécharger" dans la modal) */
  downloadUrl?: string;
}) {
  // ESC pour fermer + verrouille scroll body
  useEffect(() => {
    const onKey = (e: KeyboardEvent) => {
      if (e.key === "Escape") onClose();
    };
    document.addEventListener("keydown", onKey);
    const prevOverflow = document.body.style.overflow;
    document.body.style.overflow = "hidden";
    return () => {
      document.removeEventListener("keydown", onKey);
      document.body.style.overflow = prevOverflow;
    };
  }, [onClose]);

  return (
    <div
      className="fixed inset-0 z-[100] bg-black/70 backdrop-blur-sm flex flex-col p-4 md:p-8"
      onClick={(e) => {
        // Clic sur le backdrop (pas la fenêtre) → ferme
        if (e.target === e.currentTarget) onClose();
      }}
      aria-modal="true"
      role="dialog"
      aria-label={title || "Aperçu document"}
    >
      {/* Barre du haut : titre + actions */}
      <div className="flex items-center gap-3 mb-3 shrink-0">
        <div className="flex-1 min-w-0 text-white">
          {title && (
            <div className="text-sm font-bold truncate">{title}</div>
          )}
          {filename && (
            <div className="text-xs text-white/60 truncate">{filename}</div>
          )}
        </div>

        {(downloadUrl || url) && (
          <a
            href={downloadUrl || `${url}${url.includes("?") ? "&" : "?"}download=${encodeURIComponent(filename || "document.pdf")}`}
            className="px-3 py-2 text-xs font-semibold bg-white/10 text-white rounded-lg hover:bg-white/20 transition flex items-center gap-1.5"
            title="Télécharger"
          >
            <svg
              className="w-4 h-4"
              fill="none"
              stroke="currentColor"
              strokeWidth={2}
              viewBox="0 0 24 24"
            >
              <path
                strokeLinecap="round"
                strokeLinejoin="round"
                d="M4 16v1a3 3 0 003 3h10a3 3 0 003-3v-1m-4-4l-4 4m0 0l-4-4m4 4V4"
              />
            </svg>
            Télécharger
          </a>
        )}

        <a
          href={url}
          target="_blank"
          rel="noopener noreferrer"
          className="px-3 py-2 text-xs font-semibold bg-white/10 text-white rounded-lg hover:bg-white/20 transition flex items-center gap-1.5"
          title="Ouvrir dans un nouvel onglet"
        >
          <svg
            className="w-4 h-4"
            fill="none"
            stroke="currentColor"
            strokeWidth={2}
            viewBox="0 0 24 24"
          >
            <path
              strokeLinecap="round"
              strokeLinejoin="round"
              d="M10 6H6a2 2 0 00-2 2v10a2 2 0 002 2h10a2 2 0 002-2v-4M14 4h6m0 0v6m0-6L10 14"
            />
          </svg>
          Nouvel onglet
        </a>

        <button
          type="button"
          onClick={onClose}
          className="px-3 py-2 text-xs font-semibold bg-white text-klary-navy rounded-lg hover:bg-white/90 transition flex items-center gap-1.5"
          aria-label="Fermer"
        >
          <svg
            className="w-4 h-4"
            fill="none"
            stroke="currentColor"
            strokeWidth={2}
            viewBox="0 0 24 24"
          >
            <path strokeLinecap="round" strokeLinejoin="round" d="M6 18L18 6M6 6l12 12" />
          </svg>
          Fermer
        </button>
      </div>

      {/* Iframe PDF — occupe tout l'espace restant */}
      <div className="flex-1 min-h-0 bg-white rounded-lg overflow-hidden shadow-2xl">
        <iframe
          src={url}
          title={title || "Aperçu PDF"}
          className="w-full h-full border-0"
        />
      </div>
    </div>
  );
}
