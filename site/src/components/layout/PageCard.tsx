import { ReactNode } from "react";
import { LucideIcon } from "lucide-react";
import { Link } from "react-router-dom";

interface PageCardProps {
  icon?: LucideIcon;
  title: ReactNode;
  description?: ReactNode;
  /** Liste à puces optionnelle (avec checks lavande) */
  items?: string[];
  /** Si fourni, la carte devient un lien */
  to?: string;
  /** CTA texte (affiché en bas avec flèche) */
  ctaLabel?: string;
  children?: ReactNode;
  className?: string;
}

/**
 * Carte unifiée style premium-card lavande — utilisée pour services, avantages,
 * prestations sur toutes les pages internes. Fond glass sombre, hover halo violet.
 */
export const PageCard = ({
  icon: Icon,
  title,
  description,
  items,
  to,
  ctaLabel,
  children,
  className = "",
}: PageCardProps) => {
  const content = (
    <>
      {Icon && (
        <div
          className="w-14 h-14 rounded-2xl flex items-center justify-center mb-5 flex-shrink-0"
          style={{
            background:
              "linear-gradient(135deg, hsl(252 83% 74% / 0.18), hsl(265 90% 65% / 0.10))",
            border: "1px solid hsl(252 83% 74% / 0.25)",
          }}
        >
          <Icon className="w-7 h-7 text-primary-light" />
        </div>
      )}
      <h3 className="text-xl md:text-2xl font-light text-foreground mb-3 tracking-tight">
        {title}
      </h3>
      {description && (
        <p className="text-sm md:text-base text-muted-foreground leading-relaxed font-light">
          {description}
        </p>
      )}
      {items && items.length > 0 && (
        <ul className="space-y-2.5 mt-4">
          {items.map((item, i) => (
            <li key={i} className="flex items-start gap-3 text-sm text-muted-foreground">
              <span
                className="mt-1.5 w-1.5 h-1.5 rounded-full flex-shrink-0"
                style={{ background: "hsl(252 83% 74%)" }}
              />
              <span>{item}</span>
            </li>
          ))}
        </ul>
      )}
      {children}
      {ctaLabel && (
        <span className="inline-flex items-center gap-2 text-primary-light font-medium mt-5 text-sm group-hover:gap-3 transition-all">
          {ctaLabel}
          <span>→</span>
        </span>
      )}
    </>
  );

  const baseClasses = `group premium-card p-7 md:p-8 flex flex-col h-full ${className}`;

  if (to) {
    return (
      <Link to={to} className={baseClasses}>
        {content}
      </Link>
    );
  }

  return <div className={baseClasses}>{content}</div>;
};
