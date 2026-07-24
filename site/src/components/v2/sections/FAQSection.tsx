import { useState } from "react";
import { ChevronDown } from "lucide-react";
import { ScrollRevealText } from "../ScrollRevealText";

const faqs = [
  {
    q: "C'est vraiment gratuit ?",
    a: "Oui, à 100%. Klary est rémunéré par les compagnies d'assurance via une commission standardisée, identique chez tous les courtiers. Vous ne payez rien — ni à la souscription, ni en frais récurrents. Et comme la commission est la même partout, on n'a aucun intérêt à pousser un produit plutôt qu'un autre.",
  },
  {
    q: "Comment être sûr que vous êtes vraiment indépendants ?",
    a: "Nous ne sommes liés à aucune compagnie d'assurance. Aucune participation, aucun objectif commercial chez un partenaire. Notre seul indicateur, c'est votre satisfaction sur la durée — d'où une note moyenne de 4,8/5 et 2'500 clients fidèles.",
  },
  {
    q: "Quels types d'assurances vous gérez ?",
    a: "L'ensemble du marché suisse pour les particuliers et PME : maladie (LAMal + complémentaires), 3ᵉ pilier, RC ménage, automobile, protection juridique, hypothèque. Pour les entreprises : LPP, assurance personnel, indemnités journalières, RC professionnelle.",
  },
  {
    q: "Combien de temps prend une analyse complète ?",
    a: "Première session : 15 à 30 minutes (en visio, par téléphone ou en physique). On vous renvoie le rapport sous 48-72h. Si vous décidez de changer un contrat, on s'occupe des résiliations et nouvelles souscriptions sous 7 jours.",
  },
  {
    q: "Je suis déjà bien couvert, ça vaut le coup ?",
    a: "Dans 8 cas sur 10, oui. Soit il y a des économies à faire (gain moyen 1'247 CHF/an), soit il y a des trous de couverture qu'on identifie. Et même si tout est parfait, vous repartez avec une analyse écrite — gratuite.",
  },
  {
    q: "Vous êtes basés où ?",
    a: "Bureaux à Lausanne et Genève, conseillers actifs sur toute la Suisse romande. Pour les analyses, on vient à vous, vous venez à nous, ou on fait tout en visio. À votre convenance.",
  },
];

export const FAQSection = () => {
  const [open, setOpen] = useState<number | null>(0);

  return (
    <section id="faq" className="relative py-24 md:py-32 bg-background">
      <div className="mx-auto max-w-4xl px-5 lg:px-8">
        <div className="text-center mb-14 md:mb-16">
          <span className="kx-eyebrow mb-5">Questions fréquentes</span>
          <ScrollRevealText as="h2" className="kx-display text-[2rem] sm:text-[2.5rem] lg:text-[3rem]" theme="dark">
            Tout est <span className="kx-display-gradient">clair.</span>
          </ScrollRevealText>
        </div>

        <div className="space-y-3">
          {faqs.map((f, i) => {
            const isOpen = open === i;
            return (
              <div
                key={i}
                className="rounded-2xl bg-background-pure border border-neutral-light overflow-hidden transition-all"
              >
                <button
                  type="button"
                  onClick={() => setOpen(isOpen ? null : i)}
                  className="w-full flex items-center justify-between gap-4 px-6 py-5 text-left"
                >
                  <span className="text-base md:text-lg font-semibold text-foreground tracking-tight">
                    {f.q}
                  </span>
                  <ChevronDown
                    className={`w-5 h-5 shrink-0 transition-transform duration-300 ${isOpen ? "rotate-180" : ""}`}
                    style={{ color: "hsl(var(--accent))" }}
                  />
                </button>
                <div
                  className="grid transition-all duration-300 ease-out"
                  style={{ gridTemplateRows: isOpen ? "1fr" : "0fr" }}
                >
                  <div className="overflow-hidden">
                    <p
                      className="px-6 pb-5 text-[15px] leading-relaxed"
                      style={{ color: "hsl(var(--foreground-soft))" }}
                    >
                      {f.a}
                    </p>
                  </div>
                </div>
              </div>
            );
          })}
        </div>
      </div>
    </section>
  );
};
