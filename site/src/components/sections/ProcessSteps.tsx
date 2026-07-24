interface Step {
  title: string;
  description: string;
}

interface ProcessStepsProps {
  eyebrow?: string;
  title: string;
  subtitle?: string;
  steps: Step[];
}

/**
 * "Comment Klary vous accompagne" — timeline numérotée premium.
 */
export const ProcessSteps = ({ eyebrow, title, subtitle, steps }: ProcessStepsProps) => {
  return (
    <section className="relative py-24 lg:py-32">
      <div className="container mx-auto px-4 lg:px-8">
        <div className="max-w-3xl mx-auto text-center mb-16 space-y-5">
          {eyebrow && <div className="section-badge mx-auto">{eyebrow}</div>}
          <h2 className="text-3xl md:text-4xl lg:text-5xl affirm-display">{title}</h2>
          {subtitle && (
            <p className="text-base md:text-lg text-muted-foreground font-light leading-relaxed">
              {subtitle}
            </p>
          )}
        </div>

        <div className="max-w-5xl mx-auto">
          <div className="grid md:grid-cols-2 lg:grid-cols-3 gap-5 md:gap-6">
            {steps.map((s, i) => (
              <div key={i} className="premium-card p-7 md:p-8 relative">
                <div
                  className="absolute -top-4 left-7 w-10 h-10 rounded-full flex items-center justify-center font-medium text-sm text-white"
                  style={{
                    background:
                      "linear-gradient(135deg, hsl(220 100% 65%), hsl(252 90% 65%))",
                    boxShadow: "0 4px 20px hsl(252 90% 50% / 0.4)",
                  }}
                >
                  {String(i + 1).padStart(2, "0")}
                </div>
                <h3 className="text-lg md:text-xl font-light text-foreground mb-2 mt-3 tracking-tight">
                  {s.title}
                </h3>
                <p className="text-sm text-muted-foreground leading-relaxed font-light">
                  {s.description}
                </p>
              </div>
            ))}
          </div>
        </div>
      </div>
    </section>
  );
};
