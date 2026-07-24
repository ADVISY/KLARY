import { CheckCircle, Users, Lightbulb, BarChart3, MapPin, Award } from "lucide-react";

const advantages = [
  { icon: Users, title: "Conseil indépendant", description: "Aucun lien exclusif avec une compagnie." },
  { icon: CheckCircle, title: "Accompagnement complet", description: "De l'analyse à la mise en place." },
  { icon: Lightbulb, title: "Pédagogie avant tout", description: "Nous expliquons, vous décidez." },
  { icon: BarChart3, title: "Optimisation sur mesure", description: "Comparaison personnalisée." },
  { icon: MapPin, title: "Présence nationale", description: "Conseillers en Suisse romande." },
];

export const WhyKlarySection = () => {
  return (
    <section id="pourquoi-klary" className="relative py-section lg:py-section-lg overflow-hidden">
      <div className="absolute top-1/3 right-0 w-[600px] h-[500px] bg-primary/[0.05] rounded-full blur-[220px] pointer-events-none" />

      <div className="container relative z-10 mx-auto px-4 lg:px-8">
        <div className="text-center mb-20 max-w-3xl mx-auto">
          <div className="section-badge mb-8">
            <Award className="w-3.5 h-3.5" />
            Nos avantages
          </div>
          <h2 className="text-display-sm md:text-display-md lg:text-display affirm-display">

            Pourquoi choisir Klary ?
          </h2>
        </div>

        <div className="grid md:grid-cols-2 lg:grid-cols-5 gap-5 max-w-7xl mx-auto">
          {advantages.map((a, i) => {
            const Icon = a.icon;
            return (
              <div
                key={i}
                className="premium-card group text-center p-8 animate-slide-up"
                style={{ animationDelay: `${i * 80}ms` }}
              >
                <div className="mx-auto w-14 h-14 rounded-2xl bg-primary/15 border border-primary/20 flex items-center justify-center mb-5 group-hover:bg-primary/20 transition-all duration-500">
                  <Icon className="w-6 h-6 text-primary-light" strokeWidth={1.5} />
                </div>
                <h3 className="text-body font-medium text-foreground mb-2">
                  {a.title}
                </h3>
                <p className="text-body-sm text-muted-foreground leading-relaxed font-light">{a.description}</p>
              </div>
            );
          })}
        </div>
      </div>
    </section>
  );
};
