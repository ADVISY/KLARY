import { ReactNode } from "react";
import { LucideIcon } from "lucide-react";

interface SimulateurShellProps {
  icon: LucideIcon;
  eyebrow: string;
  title: string;
  subtitle: string;
  inputs: ReactNode;
  result: ReactNode;
  id?: string;
}

/**
 * Premium Finary-style simulator shell.
 * Left: inputs panel. Right: result + chart panel.
 */
export const SimulateurShell = ({
  icon: Icon,
  eyebrow,
  title,
  subtitle,
  inputs,
  result,
  id,
}: SimulateurShellProps) => {
  return (
    <section id={id} className="relative">
      {/* Header */}
      <div className="text-center mb-10 max-w-3xl mx-auto">
        <div className="inline-flex items-center gap-2 px-4 py-1.5 rounded-full bg-primary/10 border border-primary/20 mb-4">
          <Icon className="w-4 h-4 text-primary" />
          <span className="text-xs font-semibold text-primary uppercase tracking-wider">
            {eyebrow}
          </span>
        </div>
        <h2 className="text-3xl md:text-5xl font-bold tracking-tight mb-3 bg-gradient-to-r from-foreground via-foreground to-primary bg-clip-text text-transparent">
          {title}
        </h2>
        <p className="text-base md:text-lg text-muted-foreground">{subtitle}</p>
      </div>

      {/* Card grid */}
      <div className="relative grid lg:grid-cols-2 gap-6 rounded-[28px] border border-border/60 bg-card/40 backdrop-blur-xl p-2 shadow-[0_20px_60px_-20px_hsl(var(--primary)/0.3)]">
        {/* Decorative glow */}
        <div className="pointer-events-none absolute -top-20 -right-20 w-80 h-80 rounded-full bg-primary/15 blur-[120px]" />
        <div className="pointer-events-none absolute -bottom-20 -left-20 w-80 h-80 rounded-full bg-accent/10 blur-[120px]" />

        {/* Inputs */}
        <div className="relative rounded-3xl bg-background/60 border border-border/40 p-6 md:p-8">
          {inputs}
        </div>

        {/* Result */}
        <div className="relative rounded-3xl bg-gradient-to-br from-primary/5 via-background/60 to-background/60 border border-primary/20 p-6 md:p-8 flex flex-col">
          {result}
        </div>
      </div>
    </section>
  );
};

interface FieldProps {
  label: string;
  unit?: string;
  children: ReactNode;
  hint?: string;
}

export const SimField = ({ label, unit, children, hint }: FieldProps) => (
  <div className="group border-b border-border/40 last:border-0 py-4 first:pt-0">
    <div className="flex items-center justify-between mb-2">
      <label className="text-sm text-muted-foreground font-medium">{label}</label>
      {unit && (
        <span className="text-[10px] uppercase tracking-widest text-muted-foreground/60 font-semibold">
          {unit}
        </span>
      )}
    </div>
    {children}
    {hint && <p className="text-xs text-muted-foreground/70 mt-2">{hint}</p>}
  </div>
);
