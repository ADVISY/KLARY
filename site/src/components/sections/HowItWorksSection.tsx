import { Search, GitCompare, HeartHandshake, Sparkles } from "lucide-react";
import teamMeeting from "@/assets/team-meeting.jpg";

const steps = [
  { icon: Search, number: "1", title: "Analyse gratuite", description: "Nous analysons vos besoins et votre situation sans engagement." },
  { icon: GitCompare, number: "2", title: "Comparaison personnalisée", description: "Les meilleures offres du marché adaptées à votre profil." },
  { icon: HeartHandshake, number: "3", title: "Accompagnement & suivi", description: "Mise en place et suivi continu à vos côtés." },
];

export const HowItWorksSection = () => {
  const scrollToContact = () => {
    const el = document.querySelector("#contact");
    if (el) el.scrollIntoView({ behavior: "smooth" });
  };

  return (
    <section className="relative py-section lg:py-section-lg overflow-hidden">
      <div className="absolute bottom-0 left-1/2 -translate-x-1/2 w-[700px] h-[500px] bg-primary/[0.06] rounded-full blur-[200px] pointer-events-none" />

      <div className="container relative z-10 mx-auto px-4 lg:px-8">
        <div className="text-center mb-20 max-w-3xl mx-auto">
          <div className="section-badge mb-8">
            <Sparkles className="w-3.5 h-3.5" />
            Notre processus
          </div>
          <h2 className="text-display-sm md:text-display-md lg:text-display affirm-display">

            Comment ça fonctionne ?
          </h2>
        </div>

        <div className="grid md:grid-cols-3 gap-8 max-w-5xl mx-auto mb-24">
          {steps.map((step, i) => {
            const Icon = step.icon;
            return (
              <div key={i} className="group relative text-center space-y-6 animate-slide-up" style={{ animationDelay: `${i * 120}ms` }}>
                {i < steps.length - 1 && (
                  <div className="hidden md:block absolute top-14 left-[60%] w-[80%] h-px bg-gradient-to-r from-primary/30 to-transparent" />
                )}
                <div className="relative inline-flex items-center justify-center">
                  <div className="w-[100px] h-[100px] rounded-full bg-primary/10 border border-primary/25 backdrop-blur-md flex items-center justify-center group-hover:bg-primary/15 group-hover:scale-105 transition-all duration-500">
                    <Icon className="w-12 h-12 text-primary-light" strokeWidth={1.5} />
                  </div>
                  <div className="absolute -bottom-2 -right-2 w-9 h-9 rounded-full bg-card border border-primary/30 text-primary-light flex items-center justify-center text-body-sm font-medium">
                    {step.number}
                  </div>
                </div>
                <h3 className="text-heading-3 text-foreground font-light">
                  {step.title}
                </h3>
                <p className="text-body-sm text-muted-foreground leading-relaxed font-light max-w-xs mx-auto">{step.description}</p>
              </div>
            );
          })}
        </div>

        {/* CTA */}
        <div className="max-w-5xl mx-auto premium-card overflow-hidden !p-0">
          <div className="grid lg:grid-cols-2 items-stretch">
            <div className="relative min-h-[280px] lg:min-h-[380px]">
              <img src={teamMeeting} alt="Équipe Klary" className="w-full h-full object-cover" />
              <div className="absolute inset-0 bg-gradient-to-r from-transparent to-card/90 hidden lg:block" />
              <div className="absolute inset-0 bg-gradient-to-t from-card/80 to-transparent lg:hidden" />
            </div>
            <div className="p-8 lg:p-12 flex flex-col justify-center space-y-6">
              <h3 className="text-heading-1 md:text-display-sm affirm-display">

                Prêt à optimiser vos assurances ?
              </h3>
              <p className="text-body-lg text-muted-foreground font-light">
                Bénéficiez d'une analyse gratuite et sans engagement de votre situation.
              </p>
              <button onClick={scrollToContact} className="btn-pill-white w-fit">
                Analyse gratuite
              </button>
            </div>
          </div>
        </div>
      </div>
    </section>
  );
};
