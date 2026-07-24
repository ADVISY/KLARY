import {
  Accordion,
  AccordionContent,
  AccordionItem,
  AccordionTrigger,
} from "@/components/ui/accordion";

const faqs = [
  { question: "Vos conseils sont-ils vraiment indépendants ?", answer: "Oui. Notre rôle est de vous présenter des solutions adaptées à votre situation, en toute transparence, en expliquant les avantages et les limites de chaque option." },
  { question: "Combien coûtent vos services ?", answer: "Nous vous expliquons clairement notre rémunération avant toute collaboration. Pas de frais cachés, pas de surprise." },
  { question: "Travaillez-vous uniquement en Suisse romande ?", answer: "Nous sommes basés en Suisse romande, mais accompagnons aussi des clients dans d'autres régions en visio." },
  { question: "Est-ce que le premier entretien est payant ?", answer: "Le premier échange sert à comprendre votre situation et vos besoins. Nous expliquons ensuite la suite de l'accompagnement." },
  { question: "Avec quels types de profils travaillez-vous ?", answer: "Particuliers, familles, indépendants et petites entreprises." },
];

export const FAQSection = () => {
  return (
    <section id="faq" className="relative py-12 sm:py-16 lg:py-24 overflow-hidden">
      <div className="absolute top-1/4 left-1/2 -translate-x-1/2 w-[600px] h-[400px] bg-primary/[0.04] rounded-full blur-[200px] pointer-events-none" />

      <div className="container relative z-10 mx-auto px-4 lg:px-8">
        <div className="text-center mb-8 sm:mb-12">
          <h2 className="text-display-sm md:text-display-md lg:text-display affirm-display">
            Questions{" "}
            <span
              className="bg-clip-text text-transparent"
              style={{
                backgroundImage:
                  "linear-gradient(100deg, hsl(220 100% 70%) 0%, hsl(245 100% 75%) 35%, hsl(265 100% 75%) 65%, hsl(300 95% 72%) 100%)",
                WebkitBackgroundClip: "text",
              }}
            >
              fréquentes
            </span>
          </h2>
        </div>

        <div className="max-w-3xl mx-auto">
          <Accordion type="single" collapsible className="space-y-3 sm:space-y-4">
            {faqs.map((faq, i) => (
              <AccordionItem
                key={i}
                value={`item-${i}`}
                className="premium-card !rounded-2xl px-5 sm:px-7 border-white/[0.06] data-[state=open]:border-primary/25"
              >
                <AccordionTrigger className="text-left text-foreground font-medium hover:text-primary-light py-5 sm:py-6 text-body">
                  {faq.question}
                </AccordionTrigger>
                <AccordionContent className="text-muted-foreground leading-relaxed pb-5 sm:pb-6 text-body-sm font-light">
                  {faq.answer}
                </AccordionContent>
              </AccordionItem>
            ))}
          </Accordion>
        </div>
      </div>
    </section>
  );
};
