import { useEffect, useState } from "react";
import { Link } from "react-router-dom";
import { Cookie, X } from "lucide-react";

const STORAGE_KEY = "klary-cookie-consent";

export const CookieBanner = () => {
  const [visible, setVisible] = useState(false);

  useEffect(() => {
    try {
      const stored = localStorage.getItem(STORAGE_KEY);
      if (!stored) {
        const t = setTimeout(() => setVisible(true), 800);
        return () => clearTimeout(t);
      }
    } catch {
      setVisible(true);
    }
  }, []);

  const accept = () => {
    try {
      localStorage.setItem(STORAGE_KEY, JSON.stringify({ accepted: true, ts: Date.now() }));
    } catch {}
    setVisible(false);
  };

  const refuse = () => {
    try {
      localStorage.setItem(STORAGE_KEY, JSON.stringify({ accepted: false, ts: Date.now() }));
    } catch {}
    setVisible(false);
  };

  if (!visible) return null;

  return (
    <div
      role="dialog"
      aria-live="polite"
      aria-label="Bandeau de consentement aux cookies"
      className="fixed bottom-4 left-4 right-4 md:left-6 md:right-auto md:max-w-md z-[100]"
      style={{ animation: "kx-fade-in-up 0.5s ease-out both" }}
    >
      <div
        className="rounded-2xl p-5 md:p-6 shadow-2xl border"
        style={{
          background: "rgba(255, 255, 255, 0.96)",
          backdropFilter: "blur(20px)",
          WebkitBackdropFilter: "blur(20px)",
          borderColor: "rgba(26, 22, 96, 0.10)",
        }}
      >
        <div className="flex items-start gap-3 mb-3">
          <div
            className="w-9 h-9 rounded-full flex items-center justify-center shrink-0"
            style={{ background: "hsl(var(--accent) / 0.12)" }}
          >
            <Cookie className="w-4 h-4" style={{ color: "hsl(var(--accent))" }} />
          </div>
          <div className="flex-1 min-w-0">
            <p className="text-sm font-bold text-foreground mb-1">Cookies & confidentialité</p>
            <p className="text-[13px] leading-relaxed" style={{ color: "hsl(244 25% 35%)" }}>
              Nous utilisons uniquement des cookies techniques nécessaires au fonctionnement du site.
              Aucun traceur publicitaire.{" "}
              <Link
                to="/politique-confidentialite"
                className="underline hover:no-underline font-medium"
                style={{ color: "hsl(var(--accent))" }}
              >
                En savoir plus
              </Link>
              .
            </p>
          </div>
          <button
            type="button"
            onClick={refuse}
            aria-label="Fermer le bandeau"
            className="shrink-0 p-1 rounded-md hover:bg-black/5 transition-colors"
          >
            <X className="w-4 h-4" style={{ color: "hsl(244 25% 35%)" }} />
          </button>
        </div>

        <div className="flex gap-2 mt-4">
          <button
            type="button"
            onClick={refuse}
            className="flex-1 px-4 py-2.5 rounded-lg text-sm font-semibold border transition-all hover:bg-black/[0.03]"
            style={{
              borderColor: "rgba(26, 22, 96, 0.15)",
              color: "hsl(244 40% 22%)",
            }}
          >
            Refuser
          </button>
          <button
            type="button"
            onClick={accept}
            className="flex-1 px-4 py-2.5 rounded-lg text-sm font-semibold text-white transition-all hover:opacity-90"
            style={{
              background: "hsl(var(--accent))",
              boxShadow: "0 6px 18px -6px hsl(var(--accent) / 0.55)",
            }}
          >
            Accepter
          </button>
        </div>
      </div>
    </div>
  );
};
