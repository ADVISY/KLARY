import { Quote, Star } from "lucide-react";
import advisorWoman from "@/assets/advisor-woman.jpg";
import clientHappy from "@/assets/client-happy.jpg";
import businessman from "@/assets/businessman.jpg";

const testimonials = [
  { text: "Grâce à Klary, j'ai enfin compris comment optimiser mes assurances sans payer plus que nécessaire. Un service professionnel et personnalisé.", name: "Sophie Martinez", subtitle: "Indépendante, Genève", image: advisorWoman, rating: 5 },
  { text: "Un accompagnement clair, réactif et centré sur mes besoins. J'ai économisé plus de 2 000 CHF par an !", name: "Hugo Laurent", subtitle: "Employé, Lausanne", image: clientHappy, rating: 5 },
  { text: "J'ai pu mettre en place une stratégie de prévoyance cohérente pour ma famille et mon activité.", name: "Karim Amrani", subtitle: "Entrepreneur, Valais", image: businessman, rating: 5 },
];

export const TestimonialsSection = () => {
  return (
    <section id="temoignages" className="relative py-20 lg:py-24 overflow-hidden">
      <div className="absolute top-0 right-[-5%] w-[600px] h-[500px] bg-primary/[0.05] rounded-full blur-[220px] pointer-events-none" />

      <div className="container relative z-10 mx-auto px-4 lg:px-8">
        <div className="text-center mb-12 max-w-3xl mx-auto">
          <h2 className="text-display-sm md:text-display-md lg:text-display affirm-display">
            Ils nous ont fait{" "}
            <span
              className="bg-clip-text text-transparent"
              style={{
                backgroundImage:
                  "linear-gradient(100deg, hsl(220 100% 70%) 0%, hsl(245 100% 75%) 35%, hsl(265 100% 75%) 65%, hsl(300 95% 72%) 100%)",
                WebkitBackgroundClip: "text",
              }}
            >
              confiance
            </span>
          </h2>
        </div>

        <div className="grid md:grid-cols-3 gap-6 max-w-6xl mx-auto">
          {testimonials.map((t, i) => (
            <div
              key={i}
              className="pole-card group !min-h-0 animate-slide-up transition-transform duration-500 hover:-translate-y-1"
              style={{ animationDelay: `${i * 100}ms` }}
            >
              <div aria-hidden className="pole-card-border" />
              <div className="pole-card-inner h-full">
                <div className="flex h-full flex-col p-8">
                  <div className="w-10 h-10 rounded-xl bg-primary/15 border border-primary/20 flex items-center justify-center mb-5 transition-transform duration-500 group-hover:scale-110 group-hover:rotate-3">
                    <Quote className="w-4 h-4 text-primary-light" />
                  </div>
                  <div className="flex gap-1 mb-4">
                    {[...Array(t.rating)].map((_, j) => (
                      <Star key={j} className="w-4 h-4 fill-yellow-400 text-yellow-400" />
                    ))}
                  </div>
                  <p className="text-body-sm text-foreground/90 leading-relaxed mb-6 font-light flex-1">
                    "{t.text}"
                  </p>
                  <div className="flex items-center gap-3 border-t border-white/[0.06] pt-5">
                    <div className="w-11 h-11 rounded-full overflow-hidden ring-2 ring-primary/20 group-hover:ring-primary/40 transition-all">
                      <img src={t.image} alt={t.name} className="w-full h-full object-cover" />
                    </div>
                    <div>
                      <p className="text-body-sm font-medium text-foreground">{t.name}</p>
                      <p className="text-micro text-muted-foreground">{t.subtitle}</p>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          ))}
        </div>
      </div>
    </section>
  );
};
