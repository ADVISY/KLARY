import { useState } from "react";
import { ArrowRight, Mail, Check, ChevronDown } from "lucide-react";
import { HeaderV2 } from "./HeaderV2";
import { FooterV2 } from "./FooterV2";
import { ScrollProgress } from "./ScrollProgress";
import { PageHeroV2 } from "./PageHeroV2";
import { PageSectionV2 } from "./PageSectionV2";
import { Reveal } from "./Reveal";
import { TiltCard } from "./TiltCard";
import { DevisForm } from "@/components/forms/DevisForm";
import { insurancePages } from "@/config/insurancePages";

interface ProductPageV2Props {
  pageKey: keyof typeof insurancePages;
}

export const ProductPageV2 = ({ pageKey }: ProductPageV2Props) => {
  const page = insurancePages[pageKey];
  const [openFaq, setOpenFaq] = useState<number | null>(0);

  const handleCta = (href: string) => {
    if (href.startsWith("#")) {
      document.querySelector(href)?.scrollIntoView({ behavior: "smooth" });
    } else if (href.startsWith("tel:") || href.startsWith("mailto:")) {
      window.location.href = href;
    }
  };

  return (
    <div className="min-h-screen bg-background text-foreground">
      <ScrollProgress />
      <HeaderV2 />

      <main>
        {/* ── HERO ── */}
        <PageHeroV2
          eyebrow={page.category}
          title={page.hero.title}
          titleAccent={page.hero.titleAccent}
          subtitle={page.hero.subtitle}
          image={page.hero.image}
          imageAlt={page.category}
          cta={
            <>
              <button onClick={() => handleCta("#contact")} className="kx-btn kx-btn-accent">
                Mon analyse gratuite en 15 min
                <ArrowRight className="w-4 h-4" />
              </button>
              <button onClick={() => handleCta("#comprendre")} className="kx-btn kx-btn-outline">
                Comprendre
              </button>
            </>
          }
        />

        {/* ── INTRO ── */}
        <PageSectionV2
          id="comprendre"
          eyebrow={page.intro.eyebrow}
          title={page.intro.title}
        >
          <div className="grid lg:grid-cols-[1.4fr_1fr] gap-10 lg:gap-16">
            <Reveal>
              <div className="space-y-5 text-lg leading-relaxed" style={{ color: "hsl(var(--foreground-soft))" }}>
                {page.intro.paragraphs.map((p, i) => (
                  <p key={i}>{p}</p>
                ))}
              </div>
            </Reveal>

            <Reveal delay={150}>
              <TiltCard className="kx-card !p-8" max={4}>
                <p className="kx-eyebrow mb-5">Points clés</p>
                <ul className="space-y-4">
                  {page.intro.keyPoints.map((kp, i) => {
                    const Icon = kp.icon;
                    return (
                      <li key={i} className="flex items-start gap-3">
                        <span
                          className="w-9 h-9 rounded-xl flex items-center justify-center shrink-0"
                          style={{ background: "hsl(var(--accent-light))", color: "hsl(var(--accent))" }}
                        >
                          <Icon className="w-4 h-4" />
                        </span>
                        <span className="text-[15px] leading-snug font-medium text-foreground">
                          {kp.label}
                        </span>
                      </li>
                    );
                  })}
                </ul>
              </TiltCard>
            </Reveal>
          </div>
        </PageSectionV2>

        {/* ── PROBLÉMATIQUES ── */}
        <PageSectionV2
          eyebrow="Vos enjeux"
          title={page.problematics.title}
          subtitle={page.problematics.subtitle}
        >
          <div className="grid sm:grid-cols-2 lg:grid-cols-3 gap-5 md:gap-6">
            {page.problematics.problems.map((p, i) => (
              <Reveal key={i} delay={i * 80}>
                <TiltCard className="kx-card block h-full" max={4}>
                  <p
                    className="text-2xl font-bold mb-3 tracking-tight"
                    style={{ color: "hsl(var(--accent))" }}
                  >
                    {String(i + 1).padStart(2, "0")}
                  </p>
                  <p className="text-base leading-relaxed text-foreground">{p}</p>
                </TiltCard>
              </Reveal>
            ))}
          </div>
        </PageSectionV2>

        {/* ── PROCESS ── */}
        <PageSectionV2
          eyebrow="Notre méthode"
          title={page.process.title}
          subtitle={page.process.subtitle}
        >
          <div className="grid md:grid-cols-2 lg:grid-cols-4 gap-5 md:gap-6">
            {page.process.steps.map((step, i) => (
              <Reveal key={i} delay={i * 100}>
                <TiltCard className="kx-card !p-7 block h-full" max={4}>
                  <p
                    className="text-[11px] uppercase tracking-[0.16em] font-semibold mb-5 tabular-nums"
                    style={{ color: "hsl(var(--accent))" }}
                  >
                    Étape {String(i + 1).padStart(2, "0")}
                  </p>
                  <p className="text-lg font-bold text-foreground mb-3 leading-snug tracking-tight">
                    {step.title}
                  </p>
                  <p className="text-sm leading-relaxed" style={{ color: "hsl(var(--muted-text))" }}>
                    {step.description}
                  </p>
                </TiltCard>
              </Reveal>
            ))}
          </div>
        </PageSectionV2>

        {/* ── BÉNÉFICES ── */}
        <PageSectionV2
          eyebrow="Vos avantages"
          title={page.benefits.title}
          subtitle={page.benefits.subtitle}
        >
          <div className="grid sm:grid-cols-2 lg:grid-cols-3 gap-5 md:gap-6">
            {page.benefits.items.map((b, i) => {
              const Icon = b.icon;
              return (
                <Reveal key={i} delay={i * 70}>
                  <TiltCard className="kx-card block h-full" max={4}>
                    <div
                      className="w-12 h-12 rounded-2xl flex items-center justify-center mb-5"
                      style={{ background: "hsl(var(--accent-light))", color: "hsl(var(--accent))" }}
                    >
                      <Icon className="w-6 h-6" />
                    </div>
                    <p className="text-xl font-bold text-foreground mb-3 tracking-tight">
                      {b.title}
                    </p>
                    <p className="text-sm leading-relaxed" style={{ color: "hsl(var(--muted-text))" }}>
                      {b.description}
                    </p>
                  </TiltCard>
                </Reveal>
              );
            })}
          </div>
        </PageSectionV2>

        {/* ── ARTICLES ── */}
        {page.articles && page.articles.length > 0 && (
          <PageSectionV2
            eyebrow="Pour aller plus loin"
            title="Comprendre, optimiser, décider."
            subtitle="Nos guides pour aller au fond du sujet, sans jargon."
          >
            <div className="grid md:grid-cols-2 lg:grid-cols-3 gap-5 md:gap-6">
              {page.articles.map((article, i) => (
                <Reveal key={i} delay={i * 80}>
                  <TiltCard className="kx-card block h-full" max={4}>
                    <p
                      className="text-[11px] uppercase tracking-[0.14em] font-bold mb-3"
                      style={{ color: "hsl(var(--accent))" }}
                    >
                      {article.category || "Guide"}
                    </p>
                    <p className="text-lg font-bold text-foreground mb-3 leading-snug tracking-tight">
                      {article.title}
                    </p>
                    <p className="text-sm leading-relaxed mb-5" style={{ color: "hsl(var(--muted-text))" }}>
                      {article.excerpt}
                    </p>
                    <span
                      className="inline-flex items-center gap-1.5 text-sm font-semibold"
                      style={{ color: "hsl(var(--accent))" }}
                    >
                      Lire le guide
                      <ArrowRight className="w-3.5 h-3.5" />
                    </span>
                  </TiltCard>
                </Reveal>
              ))}
            </div>
          </PageSectionV2>
        )}

        {/* ── FAQ ── */}
        <PageSectionV2
          eyebrow="Questions fréquentes"
          title="Tout ce que vous voulez savoir."
        >
          <div className="max-w-3xl mx-auto space-y-3">
            {page.faq.map((item, i) => {
              const isOpen = openFaq === i;
              return (
                <div
                  key={i}
                  className="rounded-2xl bg-background-pure border border-neutral-light overflow-hidden"
                >
                  <button
                    type="button"
                    onClick={() => setOpenFaq(isOpen ? null : i)}
                    className="w-full flex items-center justify-between gap-4 px-6 py-5 text-left"
                  >
                    <span className="text-base md:text-lg font-semibold text-foreground tracking-tight">
                      {item.question}
                    </span>
                    <ChevronDown
                      className={`w-5 h-5 shrink-0 transition-transform duration-300 ${
                        isOpen ? "rotate-180" : ""
                      }`}
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
                        {item.answer}
                      </p>
                    </div>
                  </div>
                </div>
              );
            })}
          </div>
        </PageSectionV2>

        {/* ── CTA FINAL avec FORMULAIRE ── */}
        <section
          id="contact"
          className="relative py-24 md:py-32 overflow-hidden"
          style={{
            background: `
              radial-gradient(800px 500px at 85% 0%, rgba(240, 101, 31, 0.08) 0%, transparent 60%),
              linear-gradient(180deg, #14123F 0%, #0D0B40 60%, #0A0830 100%)
            `,
          }}
        >
          <div className="mx-auto max-w-7xl px-5 lg:px-8 relative">
            <div className="grid lg:grid-cols-[1fr_1.1fr] gap-12 lg:gap-16 items-start">
              {/* Texte gauche */}
              <Reveal className="text-white">
                <span className="kx-eyebrow mb-5" style={{ color: "hsl(var(--accent-soft))" }}>
                  On commence quand ?
                </span>
                <h2 className="kx-display text-white text-[2rem] sm:text-[2.5rem] lg:text-[3rem] mb-5 leading-[1.05]">
                  {page.finalCta.title}
                </h2>
                <p className="text-lg text-white/70 mb-8 leading-relaxed max-w-lg">
                  {page.finalCta.subtitle}
                </p>

                <ul className="space-y-3 mb-8">
                  {[
                    "Réponse sous 24h ouvrées",
                    "Comparatif personnalisé gratuit",
                    "Aucune obligation, aucun engagement",
                  ].map((b) => (
                    <li key={b} className="flex items-center gap-3 text-[15px] text-white/85">
                      <span
                        className="w-5 h-5 rounded-full flex items-center justify-center shrink-0"
                        style={{ background: "rgba(255, 165, 90, 0.18)", color: "hsl(28 95% 70%)" }}
                      >
                        <Check className="w-3 h-3" strokeWidth={3} />
                      </span>
                      {b}
                    </li>
                  ))}
                </ul>

                <div className="pt-6 border-t border-white/10 flex flex-col gap-3">
                  <p className="text-xs uppercase tracking-[0.16em] text-white/50 font-semibold">
                    Préférez nous écrire ?
                  </p>
                  <a href="mailto:admin@klary.ch" className="inline-flex items-center gap-2 text-xl font-bold text-white hover:text-[hsl(var(--accent-soft))] transition-colors">
                    <Mail className="w-5 h-5" />
                    admin@klary.ch
                  </a>
                  <p className="text-xs text-white/50">Réponse sous 24 h ouvrées</p>
                </div>
              </Reveal>

              {/* Formulaire droite */}
              <Reveal delay={150}>
                <DevisForm
                  type={page.category}
                  title={`Recevez votre analyse ${page.category.toLowerCase()}`}
                  subtitle="Remplissez ces 5 champs, on revient vers vous sous 24h avec un comparatif personnalisé."
                />
              </Reveal>
            </div>
          </div>
        </section>
      </main>

      <FooterV2 />
    </div>
  );
};
