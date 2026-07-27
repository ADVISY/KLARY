"use client";

import { useState } from "react";
import { PdfPreviewModal } from "@/components/app/PdfPreviewModal";

/**
 * Ligne "document" (CV ou pièce annexe) avec :
 *   - bouton "Voir" → ouvre PdfPreviewModal (iframe inline)
 *   - bouton "Télécharger" → force download via Supabase &download=filename
 */
export function DocumentRow({
  label,
  description,
  filename,
  signedUrl,
  highlight = false,
}: {
  label: string;
  description: string;
  filename: string;
  signedUrl: string | null;
  highlight?: boolean;
}) {
  const [open, setOpen] = useState(false);

  const downloadUrl = signedUrl
    ? `${signedUrl}${signedUrl.includes("?") ? "&" : "?"}download=${encodeURIComponent(filename)}`
    : null;

  return (
    <>
      <div
        className={`flex items-center justify-between gap-4 p-4 rounded-xl border ${
          highlight
            ? "border-klary-orange/30 bg-klary-orange/5"
            : "border-klary-light-grey bg-white"
        }`}
      >
        <div className="min-w-0 flex-1">
          <div className="font-semibold text-klary-navy">{label}</div>
          <div className="text-xs text-klary-grey mt-0.5 truncate">
            {filename} · {description}
          </div>
        </div>
        {signedUrl ? (
          <div className="flex items-center gap-2 shrink-0">
            <button
              type="button"
              onClick={() => setOpen(true)}
              title="Prévisualiser dans une modal"
              className="px-3 py-2 text-xs font-semibold text-klary-navy border border-klary-navy/20 rounded-lg hover:bg-klary-navy/5 transition"
            >
              👁 Voir
            </button>
            <a
              href={downloadUrl!}
              title="Télécharger sur votre appareil"
              className={`px-3 py-2 text-xs font-semibold text-white rounded-lg transition ${
                highlight
                  ? "bg-klary-orange hover:bg-klary-orange/90"
                  : "bg-klary-navy hover:bg-klary-navy/90"
              }`}
            >
              ⬇ Télécharger
            </a>
          </div>
        ) : (
          <span className="text-xs text-red-600 shrink-0">
            Lien indisponible
          </span>
        )}
      </div>

      {open && signedUrl && (
        <PdfPreviewModal
          url={signedUrl}
          title={label}
          filename={filename}
          downloadUrl={downloadUrl!}
          onClose={() => setOpen(false)}
        />
      )}
    </>
  );
}
