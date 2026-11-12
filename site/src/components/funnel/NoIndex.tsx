import { useEffect } from "react";

/**
 * Force `noindex, nofollow` sur la page courante, et remet la valeur précédente
 * en quittant.
 *
 * Aujourd'hui le site entier est déjà en noindex, par le `<meta>` de
 * index.html et par l'en-tête X-Robots-Tag de vercel.json. Ce composant sert
 * au jour d'après : quand le site public rouvrira, ces pages de campagne
 * payante devront rester hors de Google, sans quoi Google indexerait des
 * atterrissages publicitaires à la place des pages de fond.
 */
const NoIndex = () => {
  useEffect(() => {
    const tag = document.querySelector<HTMLMetaElement>('meta[name="robots"]');
    const previous = tag?.getAttribute("content") ?? null;

    if (tag) {
      tag.setAttribute("content", "noindex, nofollow");
    } else {
      const created = document.createElement("meta");
      created.name = "robots";
      created.content = "noindex, nofollow";
      created.dataset.funnelNoindex = "true";
      document.head.appendChild(created);
    }

    return () => {
      if (tag) {
        if (previous === null) tag.removeAttribute("content");
        else tag.setAttribute("content", previous);
      } else {
        document.querySelector('meta[data-funnel-noindex="true"]')?.remove();
      }
    };
  }, []);

  return null;
};

export default NoIndex;
