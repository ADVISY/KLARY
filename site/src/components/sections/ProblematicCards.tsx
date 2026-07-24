interface ProblematicCardsProps {
  eyebrow?: string;
  title: string;
  subtitle?: string;
  problems: string[];
}

/**
 * "Vous reconnaissez-vous ?" — cards de problématiques clients fréquentes.
 * Look simple, ton humain, hover subtil.
 */
export const ProblematicCards = ({ eyebrow, title, subtitle, problems }: ProblematicCardsProps) => {
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

        <div className="grid sm:grid-cols-2 lg:grid-cols-3 gap-5 max-w-6xl mx-auto">
          {problems.map((p, i) => (
            <div
              key={i}
              className="premium-card p-6 md:p-7 flex items-start gap-4 transition-transform"
            >
              <div className="flex-shrink-0 w-7 h-7 rounded-full flex items-center justify-center mt-0.5"
                style={{
                  background: "hsl(220 100% 70% / 0.15)",
                  border: "1px solid hsl(220 100% 70% / 0.3)",
                }}>
                <span className="text-xs font-medium text-primary-light">?</span>
              </div>
              <p className="text-base text-foreground leading-relaxed font-light">"{p}"</p>
            </div>
          ))}
        </div>
      </div>
    </section>
  );
};
