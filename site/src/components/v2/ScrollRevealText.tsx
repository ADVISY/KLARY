import { ReactNode, isValidElement, useEffect, useRef } from "react";

/**
 * Texte qui se "remplit" mot par mot au scroll (style SBS Software).
 * Chaque mot commence en gris/transparent puis devient progressivement opaque
 * selon sa position relative dans la viewport.
 *
 * Supporte du JSX nested : les <span> gradient à l'intérieur sont préservés,
 * leurs caractères se révèlent en gardant leur style propre.
 *
 * Le scroll-progress est calculé via rAF + getBoundingClientRect (compatible Safari < 26).
 */

type Theme = "dark" | "light";

interface ScrollRevealTextProps {
  children: ReactNode;
  as?: keyof JSX.IntrinsicElements;
  className?: string;
  theme?: Theme;
  // Plage de progression (en pourcentage de viewport height)
  startAt?: number; // 0.90 par défaut : reveal commence quand le texte est à 90% du viewport
  endAt?: number;   // 0.45 par défaut : reveal fini quand le texte est à 45% du viewport
  // Chevauchement entre mots (plus haut = plus de "tail" de fadein)
  wordWindow?: number; // 0.20 par défaut
}

const DIM_OPACITY: Record<Theme, number> = {
  dark: 0.32,   // Fond clair : 32% opacity au départ (toujours lisible mais clairement "in progress")
  light: 0.38,  // Fond sombre : 38% opacity au départ
};

export const ScrollRevealText = ({
  children,
  as: Tag = "h2",
  className = "",
  theme = "dark",
  startAt = 0.90,
  endAt = 0.45,
  wordWindow = 0.20,
}: ScrollRevealTextProps) => {
  const rootRef = useRef<HTMLElement | null>(null);
  const wordRefs = useRef<HTMLSpanElement[]>([]);
  const dim = DIM_OPACITY[theme];

  useEffect(() => {
    const root = rootRef.current;
    if (!root) return;

    // Lire les mots actuellement rendus
    const allSpans = root.querySelectorAll<HTMLSpanElement>("[data-srt-word]");
    wordRefs.current = Array.from(allSpans);

    let raf = 0;
    const update = () => {
      raf = 0;
      const rect = root.getBoundingClientRect();
      const vh = window.innerHeight;
      const startY = vh * startAt;
      const endY = vh * endAt;
      const top = rect.top;
      let progress = (startY - top) / (startY - endY);
      progress = Math.max(0, Math.min(1, progress));

      const wordSpans = wordRefs.current;
      const total = wordSpans.length;
      if (total === 0) return;

      // Le dernier mot atteint t=1 quand progress=1 :
      // wordStart va de 0 à (1 - wordWindow), pas à 1.
      const startMax = Math.max(0.001, 1 - wordWindow);
      const range = 1 - dim;
      for (let i = 0; i < total; i++) {
        const wordStart = total > 1 ? (i / (total - 1)) * startMax : 0;
        const wordProgress = (progress - wordStart) / wordWindow;
        const t = Math.max(0, Math.min(1, wordProgress));
        const eased = 1 - Math.pow(1 - t, 3); // easeOutCubic
        const span = wordSpans[i];
        if (!span) continue;
        span.style.opacity = (dim + eased * range).toFixed(3);
      }
    };

    const onScroll = () => {
      if (raf) return;
      raf = requestAnimationFrame(update);
    };

    update();
    window.addEventListener("scroll", onScroll, { passive: true });
    window.addEventListener("resize", update, { passive: true });
    return () => {
      window.removeEventListener("scroll", onScroll);
      window.removeEventListener("resize", update);
      if (raf) cancelAnimationFrame(raf);
    };
  }, [startAt, endAt, wordWindow, children, dim]);

  // Style commun pour un mot révélable
  const wordStyle = {
    opacity: dim,
    transition: "opacity 0.06s linear",
    willChange: "opacity",
  } as const;

  // Walk recursive : transforme chaque string en suite de spans révélables.
  // Les ReactElement (ex: <span class="kx-display-gradient">) sont enveloppés
  // ENTIERS comme UN seul mot — sinon l'opacity sur les sous-spans casse le
  // background-clip:text du gradient parent.
  const renderNode = (node: ReactNode, keyPath: string): ReactNode => {
    if (node === null || node === undefined || node === false) return null;
    if (typeof node === "string" || typeof node === "number") {
      const text = String(node);
      const parts = text.split(/(\s+)/);
      return parts
        .filter((chunk) => chunk.length > 0)
        .map((chunk, i) => {
          if (/^\s+$/.test(chunk)) {
            return <span key={`${keyPath}-s${i}`}>{chunk}</span>;
          }
          return (
            <span key={`${keyPath}-w${i}`} data-srt-word style={wordStyle}>
              {chunk}
            </span>
          );
        });
    }
    if (Array.isArray(node)) {
      return node.map((child, i) => renderNode(child, `${keyPath}-${i}`));
    }
    if (isValidElement(node)) {
      // Encapsuler l'élément entier comme un seul mot révélable.
      // L'opacity s'applique uniformément, le gradient interne reste intact.
      return (
        <span key={keyPath} data-srt-word style={wordStyle}>
          {node}
        </span>
      );
    }
    return node;
  };

  return (
    <Tag ref={rootRef as any} className={className}>
      {renderNode(children, "n")}
    </Tag>
  );
};
