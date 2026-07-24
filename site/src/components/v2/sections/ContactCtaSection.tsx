import { Mail, Check } from "lucide-react";
import { Reveal } from "../Reveal";
import { ScrollRevealText } from "../ScrollRevealText";
import { DevisForm } from "@/components/forms/DevisForm";

interface ContactCtaSectionProps {
  eyebrow?: string;
  title: string;
  titleAccent?: string;
  subtitle: string;
  formType: string;
  formTitle?: string;
  formSubtitle?: string;
  reassurances?: string[];
  id?: string;
}

const DEFAULT_REASSURANCES = [
  "100% gratuit, sans engagement",
  "Comparatif détaillé sous 24h",
  "Toutes compagnies suisses",
  "Conseil neutre — aucune compagnie derrière nous",
];

/**
 * CTA réutilisable pour les pages internes : message gauche + formulaire droite.
 * Fond navy premium (cohérent avec FinalCtaSection home et ProductPageV2).
 */
export const ContactCtaSection = ({
  eyebrow = "On commence quand ?",
  title,
  titleAccent,
  subtitle,
  formType,
  formTitle,
  formSubtitle,
  reassurances = DEFAULT_REASSURANCES,
  id = "contact",
}: ContactCtaSectionProps) => {
  return (
    <section
      id={id}
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
              {eyebrow}
            </span>

            <ScrollRevealText
              as="h2"
              className="kx-display text-white text-[2rem] sm:text-[2.5rem] lg:text-[3rem] mb-5 leading-[1.05]"
              theme="light"
            >
              {title}
              {titleAccent && (
                <>
                  {" "}
                  <span
                    style={{
                      background:
                        "linear-gradient(120deg, hsl(19 90% 60%) 0%, hsl(28 95% 70%) 100%)",
                      WebkitBackgroundClip: "text",
                      backgroundClip: "text",
                      WebkitTextFillColor: "transparent",
                    }}
                  >
                    {titleAccent}
                  </span>
                </>
              )}
            </ScrollRevealText>

            <p className="text-lg text-white/70 mb-8 leading-relaxed max-w-lg">{subtitle}</p>

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
              type={formType}
              title={formTitle || `Recevez votre analyse personnalisée`}
              subtitle={formSubtitle || "Remplissez ces champs, on revient vers vous sous 24h ouvrées."}
            />
          </Reveal>
        </div>
      </div>
    </section>
  );
};
