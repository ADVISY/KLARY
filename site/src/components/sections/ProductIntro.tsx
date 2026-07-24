import { ReactNode } from "react";
import { LucideIcon } from "lucide-react";

interface KeyPoint {
  icon?: LucideIcon;
  label: string;
}

interface ProductIntroProps {
  eyebrow?: string;
  title: ReactNode;
  paragraphs: string[];
  keyPoints?: KeyPoint[];
}

/**
 * Section intro produit — 2 colonnes : texte explicatif + key points en cards.
 */
export const ProductIntro = ({ eyebrow, title, paragraphs, keyPoints }: ProductIntroProps) => {
  return (
    <section className="relative py-24 lg:py-32">
      <div className="container mx-auto px-4 lg:px-8">
        <div className="grid lg:grid-cols-2 gap-12 lg:gap-20 items-start max-w-6xl mx-auto">
          <div className="space-y-6">
            {eyebrow && <div className="section-badge">{eyebrow}</div>}
            <h2 className="text-3xl md:text-4xl lg:text-5xl affirm-display">{title}</h2>
            <div className="space-y-4">
              {paragraphs.map((p, i) => (
                <p key={i} className="text-base md:text-lg text-muted-foreground leading-relaxed font-light">
                  {p}
                </p>
              ))}
            </div>
          </div>

          {keyPoints && keyPoints.length > 0 && (
            <div className="grid sm:grid-cols-2 gap-4 lg:sticky lg:top-32">
              {keyPoints.map((k, i) => {
                const Icon = k.icon;
                return (
                  <div key={i} className="premium-card p-6 flex flex-col gap-3">
                    {Icon && (
                      <div
                        className="w-11 h-11 rounded-xl flex items-center justify-center"
                        style={{
                          background:
                            "linear-gradient(135deg, hsl(220 100% 70% / 0.18), hsl(252 90% 65% / 0.10))",
                          border: "1px solid hsl(220 100% 70% / 0.25)",
                        }}
                      >
                        <Icon className="w-5 h-5 text-primary-light" strokeWidth={1.5} />
                      </div>
                    )}
                    <p className="text-sm md:text-base text-foreground leading-relaxed font-light">
                      {k.label}
                    </p>
                  </div>
                );
              })}
            </div>
          )}
        </div>
      </div>
    </section>
  );
};
