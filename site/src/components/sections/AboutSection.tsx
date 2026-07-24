import { Eye, Users, MapPin, Target } from "lucide-react";
import officeConsultation from "@/assets/office-consultation.jpg";

const values = [
  { title: "Transparence", description: "Des explications simples, des recommandations argumentées.", icon: Eye },
  { title: "Indépendance", description: "Vos intérêts au centre de chaque décision.", icon: Users },
  { title: "Proximité", description: "Disponible, réactif, et aligné sur la réalité suisse.", icon: MapPin },
];

export const AboutSection = () => {
  return (
    <section id="a-propos" className="relative py-section lg:py-section-lg overflow-hidden">
      <div className="absolute top-1/3 left-0 w-[500px] h-[500px] bg-primary/[0.05] rounded-full blur-[200px] pointer-events-none" />

      <div className="container relative z-10 mx-auto px-4 lg:px-8">
        <div className="text-center mb-20 max-w-4xl mx-auto">
          <div className="section-badge mb-8">
            <Target className="w-3.5 h-3.5" />
            Qui sommes-nous
          </div>
          <h2 className="text-display-sm md:text-display-md lg:text-display affirm-display mb-8">

            Klary en quelques mots
          </h2>
          <p className="text-body-lg text-muted-foreground max-w-2xl mx-auto font-light">
            Cabinet de conseil indépendant en Suisse romande. Notre mission : vous aider à prendre des décisions éclairées.
          </p>
        </div>

        <div className="grid lg:grid-cols-2 gap-12 lg:gap-16 items-center max-w-6xl mx-auto">
          <div className="relative">
            <div className="rounded-3xl overflow-hidden group border border-white/[0.06] shadow-strong">
              <img src={officeConsultation} alt="Consultation Klary" className="w-full h-[480px] object-cover group-hover:scale-[1.03] transition-transform duration-700" />
              <div className="absolute inset-0 bg-gradient-to-t from-background via-background/30 to-transparent" />
              <div className="absolute bottom-5 left-5 right-5 premium-card !rounded-2xl p-5">
                <p className="text-body font-medium text-foreground mb-1">Conseil personnalisé</p>
                <p className="text-body-sm text-muted-foreground font-light">Des experts à votre écoute pour des solutions sur mesure</p>
              </div>
            </div>
          </div>

          <div className="grid gap-5">
            {values.map((v, i) => {
              const Icon = v.icon;
              return (
                <div key={i} className="premium-card group p-7 animate-slide-up" style={{ animationDelay: `${i * 120}ms` }}>
                  <div className="flex items-start gap-5">
                    <div className="w-12 h-12 rounded-2xl bg-primary/15 border border-primary/20 flex items-center justify-center flex-shrink-0">
                      <Icon className="w-5 h-5 text-primary-light" strokeWidth={1.5} />
                    </div>
                    <div>
                      <h3 className="text-heading-4 text-foreground mb-1.5 font-medium">{v.title}</h3>
                      <p className="text-body-sm text-muted-foreground leading-relaxed font-light">{v.description}</p>
                    </div>
                  </div>
                </div>
              );
            })}
          </div>
        </div>
      </div>
    </section>
  );
};
