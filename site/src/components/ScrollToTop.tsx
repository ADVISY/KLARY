import { useEffect } from "react";
import { useLocation, useNavigationType } from "react-router-dom";

export const ScrollToTop = () => {
  const { pathname, hash, key } = useLocation();
  const navigationType = useNavigationType();

  // Disable browser scroll restoration once
  useEffect(() => {
    if ("scrollRestoration" in window.history) {
      window.history.scrollRestoration = "manual";
    }
  }, []);

  // Scroll to top on every route change (except when there's a hash anchor)
  useEffect(() => {
    if (hash) return;
    const scrollTop = () => window.scrollTo({ top: 0, left: 0, behavior: "instant" as ScrollBehavior });
    scrollTop();
    requestAnimationFrame(scrollTop);
    const t = setTimeout(scrollTop, 50);
    return () => clearTimeout(t);
  }, [pathname, hash, key, navigationType]);

  // Catch clicks on same-route links and re-clicks on the current link
  useEffect(() => {
    const handleClick = (e: MouseEvent) => {
      const target = (e.target as HTMLElement)?.closest("a");
      if (!target) return;
      const href = target.getAttribute("href");
      if (!href) return;
      // Internal links only, no hash anchors, no new tab
      if (
        href.startsWith("/") &&
        !href.startsWith("//") &&
        !href.includes("#") &&
        target.target !== "_blank" &&
        !e.metaKey &&
        !e.ctrlKey &&
        !e.shiftKey
      ) {
        requestAnimationFrame(() =>
          window.scrollTo({ top: 0, left: 0, behavior: "instant" as ScrollBehavior })
        );
      }
    };
    document.addEventListener("click", handleClick);
    return () => document.removeEventListener("click", handleClick);
  }, []);

  return null;
};
