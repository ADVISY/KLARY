import { Mail, Check } from "lucide-react";
import { ScrollRevealText } from "../ScrollRevealText";
import { Reveal } from "../Reveal";
import { DevisForm } from "@/components/forms/DevisForm";

const reassurances = [
  "100% gratuit, sans engagement",
  "Analyse complète en 15 min",
  "Toutes compagnies suisses comparées",
  "Conseil neutre — aucune compagnie derrière nous",
];

export const FinalCtaSection = () => {
  return (
    <section
      id="contact"
      className="relative py-24 md:py-32 overflow-hidden"
      style={{
        background: `
          radial-gradient(900px 600px at 85% 0%, rgba(240, 101, 31, 0.10) 0%, transparent 60%),
          linear-gradient(180deg, #14123F 0%, #0D0B40 60%, #0A0830 100%)
        `,
      }}
    >
      <div className="mx-auto max-w-7xl px-5 lg:px-8 relative">
        <div className="grid lg:grid-cols-[1fr_1.1fr] gap-12 lg:gap-16 items-start">
          {/* Colonne gauche — message */}
          <Reveal className="text-white">
            <span className="kx-eyebrow mb-5" style={{ color: "hsl(var(--accent-soft))" }}>
              On commence quand ?
            </span>

            <ScrollRevealText
              as="h2"
              className="kx-display text-white text-[2rem] sm:text-[2.5rem] lg:text-[3rem] mb-5 leading-[1.05]"
              theme="light"
            >
              Découvrez{" "}
              <span
                style={{
                  background: "linear-gradient(120deg, hsl(19 90% 60%) 0%, hsl(28 95% 70%) 100%)",
                  WebkitBackgroundClip: "text",
                  backgroundClip: "text",
                  WebkitTextFillColor: "transparent",
                }}
              >
                combien vous économisez
              </span>{" "}
              en 15 minutes.
            </ScrollRevealText>

            <p className="text-lg text-white/70 mb-8 leading-relaxed max-w-lg">
              Un conseiller Klary analyse vos contrats actuels et vous renvoie un rapport clair sous
              72 heures. Aucune obligation.
            </p>

            <ul className="space-y-3 mb-8 max-w-md">
              {reassurances.map((r) => (
                <li key={r} className="flex items-center gap-3 text-[15px] text-white/85">
                  <span
                    className="w-5 h-5 rounded-full flex items-center justify-center shrink-0"
                    style={{ background: "rgba(255, 165, 90, 0.18)", color: "hsl(28 95% 70%)" }}
                  >
                    <Check className="w-3 h-3" strokeWidth={3} />
                  </span>
                  {r}
                </li>
              ))}
            </ul>

            <div className="pt-6 border-t border-white/10 flex flex-col gap-3">
              <p className="text-xs uppercase tracking-[0.16em] text-white/50 font-semibold">
                Préférez nous écrire ?
              </p>
              <a
                href="mailto:admin@klary.ch"
                className="inline-flex items-center gap-2 text-xl font-bold text-white hover:text-[hsl(var(--accent-soft))] transition-colors"
              >
                <Mail className="w-5 h-5" />
                admin@klary.ch
              </a>
              <p className="text-xs text-white/50">Réponse sous 24 h ouvrées</p>
            </div>
          </Reveal>

          {/* Colonne droite — formulaire */}
          <Reveal delay={150}>
            <DevisForm
              type="Analyse globale"
              title="Recevez votre analyse personnalisée"
              subtitle="On reprend tous vos contrats et vous montre ce que vous pouvez économiser. Sous 24h ouvrées."
            />
          </Reveal>
        </div>
      </div>
    </section>
  );
};
