import { ReactNode } from "react";
import { ShieldCheck } from "lucide-react";
import klaryLogo from "@/assets/klary-logo-horizontal.png";

/**
 * FunnelShell — coque « application » des pages d'offre Klary.
 *
 * Volontairement pauvre en sorties : pas de menu, pas de footer de site, aucun
 * lien vers les pages publiques (qui sont fermées). L'écran entier sert la
 * saisie, ce qui est ce qui convertit sur du trafic payant.
 *
 * `tiedPartner` affiche le statut d'intermédiaire lié en pied de page. Ce n'est
 * pas une décoration : Klary est lié au Groupe Mutuel avec exclusivité signée,
 * et la directive de vente impose de ne jamais paraître non lié. Le pied doit
 * donc rester visible sur TOUTES les étapes du tunnel.
 */

export interface TiedPartner {
  /** Phrase de statut, par exemple « Klary Sàrl, intermédiaire lié ». */
  label: string;
  partnerName: string;
  logoSrc: string;
}

interface FunnelShellProps {
  children: ReactNode;
  tiedPartner?: TiedPartner;
  /** Ligne de réassurance quand aucun partenaire n'est déclaré. */
  trustLine?: string;
}

const FunnelShell = ({ children, tiedPartner, trustLine }: FunnelShellProps) => (
  <div className="kx-bg-soft-anim relative flex h-[100dvh] flex-col overflow-hidden bg-background">
    {/* Barre d'application minimale : le logo n'est pas cliquable, le site est fermé */}
    <header className="z-40 w-full shrink-0 border-b border-border/70 bg-background-pure/70 backdrop-blur-md">
      <div className="mx-auto flex h-12 w-full max-w-6xl items-center justify-between px-4 md:h-14 md:px-6">
        <span className="flex items-center" aria-label="Klary">
          <img src={klaryLogo} alt="Klary" className="h-6 w-auto md:h-8" />
        </span>
        <span className="text-[11px] font-semibold uppercase tracking-[0.14em] text-muted-foreground md:text-xs">
          Demande en ligne
        </span>
      </div>
    </header>

    {/* Scène du tunnel : hauteur verrouillée, seules les questions défilent */}
    <main className="flex min-h-0 flex-1 flex-col">
      <div className="mx-auto flex min-h-0 w-full max-w-6xl flex-1 flex-col overflow-y-auto px-4 py-2 md:px-6 md:py-3">
        {children}
      </div>
    </main>

    <footer className="w-full shrink-0 px-4 py-2">
      {tiedPartner ? (
        <p className="mx-auto flex max-w-2xl flex-wrap items-center justify-center gap-x-2 gap-y-1 text-center text-[10px] font-medium text-muted-foreground md:text-[11px]">
          <span>{tiedPartner.label}</span>
          <img
            src={tiedPartner.logoSrc}
            alt={tiedPartner.partnerName}
            className="h-3.5 w-auto opacity-80"
          />
        </p>
      ) : (
        <p className="mx-auto flex max-w-xl items-center justify-center gap-1.5 text-[11px] font-medium text-muted-foreground md:text-xs">
          <ShieldCheck className="h-3.5 w-3.5 shrink-0" />
          {trustLine ?? "Confidentiel, gratuit et sans engagement"}
        </p>
      )}
    </footer>
  </div>
);

export default FunnelShell;
