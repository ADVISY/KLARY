"use client";

export function PrintClientButton() {
  return (
    <button
      type="button"
      onClick={() => window.print()}
      className="px-4 py-2 bg-klary-orange text-white rounded-lg text-sm font-semibold hover:bg-klary-orange/90"
    >
      Imprimer / PDF
    </button>
  );
}
