interface KlaryAppHeaderProps {
  eyebrow?: string;
  title: string;
  /** Optionnel : node à droite (avatar, badge, etc.) */
  trailing?: React.ReactNode;
}

/**
 * Header app branded Klary à utiliser en haut de chaque screen du mockup.
 * - Logo K (carré) + wordmark "Klary"
 * - Eyebrow + titre de l'écran à droite
 * - Optionnellement un trailing element (avatar, notif)
 */
export const KlaryAppHeader = ({ eyebrow, title, trailing }: KlaryAppHeaderProps) => {
  return (
    <div className="flex items-center gap-2.5 mb-3.5">
      {/* Logo K */}
      <div
        className="shrink-0 w-9 h-9 rounded-[10px] flex items-center justify-center"
        style={{
          background: "linear-gradient(135deg, #1A1660 0%, #0D0B40 100%)",
          boxShadow: "0 4px 12px -4px rgba(26, 22, 96, 0.40)",
        }}
      >
        {/* Mini logo K stylé */}
        <svg width="18" height="18" viewBox="0 0 200 200" fill="none" aria-hidden>
          <g stroke="#FAF7EE" strokeWidth="22" strokeLinecap="round">
            <path d="M 78 26 L 38 138 Q 36 152 43 165" fill="none" />
            <path d="M 118 26 L 78 138 Q 76 152 83 165" fill="none" />
            <path d="M 158 26 L 118 138 Q 116 152 123 165" fill="none" />
          </g>
          <g fill="#F0651F">
            <ellipse cx="170" cy="62" rx="11" ry="7" transform="rotate(-32 170 62)" />
            <ellipse cx="178" cy="110" rx="12" ry="7" transform="rotate(-8 178 110)" />
          </g>
        </svg>
      </div>

      {/* Texte */}
      <div className="flex-1 min-w-0">
        {eyebrow && (
          <p
            className="text-[8.5px] uppercase tracking-[0.16em] font-bold leading-none mb-0.5"
            style={{ color: "hsl(var(--accent))" }}
          >
            {eyebrow}
          </p>
        )}
        <p className="text-[15px] font-bold text-foreground leading-tight tracking-tight truncate">
          {title}
        </p>
      </div>

      {trailing && <div className="shrink-0">{trailing}</div>}
    </div>
  );
};
