import { LucideIcon } from "lucide-react";

interface Benefit {
  icon: LucideIcon;
  title: string;
  description: string;
}

interface BenefitsGridProps {
  eyebrow?: string;
  title: string;
  subtitle?: string;
  benefits: Benefit[];
}

export const BenefitsGrid = ({ eyebrow, title, subtitle, benefits }: BenefitsGridProps) => {
  return (
    <section className="relative py-24 lg:py-32">
      <div className="container mx-auto px-4 lg:px-8">
        <div className="max-w-3xl mx-auto text-center mb-14 space-y-5">
          {eyebrow && <div className="section-badge mx-auto">{eyebrow}</div>}
          <h2 className="text-3xl md:text-4xl lg:text-5xl affirm-display">{title}</h2>
          {subtitle && (
            <p className="text-base md:text-lg text-muted-foreground font-light leading-relaxed">
              {subtitle}
            </p>
          )}
        </div>

        <div className="grid sm:grid-cols-2 lg:grid-cols-3 gap-5 md:gap-6 max-w-6xl mx-auto">
          {benefits.map((b, i) => {
            const Icon = b.icon;
            return (
              <div key={i} className="premium-card p-7 md:p-8">
                <div
                  className="w-12 h-12 rounded-2xl flex items-center justify-center mb-5"
                  style={{
                    background:
                      "linear-gradient(135deg, hsl(220 100% 70% / 0.18), hsl(252 90% 65% / 0.10))",
                    border: "1px solid hsl(220 100% 70% / 0.25)",
                  }}
                >
                  <Icon className="w-6 h-6 text-primary-light" strokeWidth={1.5} />
                </div>
                <h3 className="text-lg md:text-xl font-light text-foreground mb-2 tracking-tight">
                  {b.title}
                </h3>
                <p className="text-sm text-muted-foreground leading-relaxed font-light">
                  {b.description}
                </p>
              </div>
            );
          })}
        </div>
      </div>
    </section>
  );
};
