import { Search, ClipboardCheck, Rocket } from "lucide-react";

const steps = [
  { number: "01", title: "Découverte", description: "Point sur votre situation, vos besoins et vos objectifs.", icon: Search },
  { number: "02", title: "Analyse & recommandations", description: "Comparaison des solutions avec avantages et inconvénients.", icon: ClipboardCheck },
  { number: "03", title: "Mise en place & suivi", description: "Accompagnement dans les démarches et ajustements.", icon: Rocket },
];

export const MethodSection = () => {
  return (
    <section id="methode" className="relative py-section lg:py-section-lg overflow-hidden">
      <div className="absolute top-1/3 right-[-5%] w-[600px] h-[400px] bg-primary/[0.05] rounded-full blur-[200px] pointer-events-none" />

      <div className="container relative z-10 mx-auto px-4 lg:px-8">
        <div className="text-center mb-20">
          <h2 className="text-display-sm md:text-display-md lg:text-display affirm-display">

            Comment ça se passe ?
          </h2>
        </div>

        <div className="grid md:grid-cols-3 gap-6 lg:gap-8 relative max-w-6xl mx-auto">
          <div className="hidden md:block absolute top-[80px] left-[10%] right-[10%] h-px bg-gradient-to-r from-primary/10 via-primary/30 to-primary/10" />

          {steps.map((step, i) => {
            const Icon = step.icon;
            return (
              <div key={i} className="relative animate-slide-up" style={{ animationDelay: `${i * 120}ms` }}>
                <div className="premium-card p-8 lg:p-10 relative">
                  <div className="absolute -top-4 left-8 w-10 h-10 rounded-full bg-primary text-primary-foreground flex items-center justify-center text-micro font-semibold">
                    {step.number}
                  </div>

                  <div className="w-12 h-12 rounded-2xl bg-primary/15 border border-primary/20 flex items-center justify-center mb-6 mt-3">
                    <Icon className="w-5 h-5 text-primary-light" strokeWidth={1.5} />
                  </div>
                  <h3 className="text-heading-4 text-foreground mb-3 font-medium">{step.title}</h3>
                  <p className="text-body-sm text-muted-foreground leading-relaxed font-light">{step.description}</p>
                </div>
              </div>
            );
          })}
        </div>
      </div>
    </section>
  );
};
