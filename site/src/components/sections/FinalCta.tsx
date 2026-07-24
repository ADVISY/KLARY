import { ReactNode } from "react";

interface FinalCtaProps {
  title: string;
  subtitle?: string;
  cta: ReactNode;
}

export const FinalCta = ({ title, subtitle, cta }: FinalCtaProps) => {
  return (
    <section className="relative py-24 lg:py-32 overflow-hidden">
      <div aria-hidden className="pointer-events-none absolute inset-0">
        <div
          className="absolute left-1/2 top-1/2 -translate-x-1/2 -translate-y-1/2 w-[1100px] h-[700px] rounded-full"
          style={{
            background:
              "radial-gradient(closest-side, hsl(252 90% 62% / 0.35), hsl(220 100% 60% / 0.15) 50%, transparent 80%)",
            filter: "blur(120px)",
          }}
        />
      </div>

      <div className="container relative z-10 mx-auto px-4 lg:px-8">
        <div className="max-w-3xl mx-auto text-center premium-card p-10 md:p-14 lg:p-16">
          <h2 className="text-3xl md:text-4xl lg:text-5xl affirm-display mb-5">{title}</h2>
          {subtitle && (
            <p className="text-base md:text-lg text-muted-foreground font-light leading-relaxed mb-8 max-w-xl mx-auto">
              {subtitle}
            </p>
          )}
          <div className="flex flex-col sm:flex-row gap-3 items-center justify-center">{cta}</div>
        </div>
      </div>
    </section>
  );
};
