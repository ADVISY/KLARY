import { Link } from "react-router-dom";
import { ArrowRight, ArrowUpRight, BookOpen } from "lucide-react";
import { HeaderV2 } from "@/components/v2/HeaderV2";
import { FooterV2 } from "@/components/v2/FooterV2";
import { ScrollProgress } from "@/components/v2/ScrollProgress";
import { PageHeroV2 } from "@/components/v2/PageHeroV2";
import { PageSectionV2 } from "@/components/v2/PageSectionV2";
import { Reveal } from "@/components/v2/Reveal";
import { TiltCard } from "@/components/v2/TiltCard";
import { allGuides } from "@/config/guides";
import { insurancePages } from "@/config/insurancePages";

const Guides = () => {
  // Regroupe les articles par catégorie de page
  const grouped = Object.entries(insurancePages).map(([key, page]) => ({
    key,
    category: page.category,
    articles: allGuides.filter((g) => g.pageKey === key),
  }));

  return (
    <div className="min-h-screen bg-background text-foreground">
      <ScrollProgress />
      <HeaderV2 />

      <main>
        <PageHeroV2
          eyebrow="Guides Klary"
          title="Comprendre, optimiser,"
          titleAccent="décider."
          subtitle="Nos analyses sans jargon pour faire les bons choix en assurance, prévoyance et hypothèque. Mis à jour régulièrement par nos conseillers."
          cta={
            <>
              <a href="#articles" className="kx-btn kx-btn-accent">
                Parcourir les guides
                <ArrowRight className="w-4 h-4" />
              </a>
              <a href="mailto:admin@klary.ch" className="kx-btn kx-btn-outline">
                Parler à un conseiller
              </a>
            </>
          }
        />

        <div id="articles">
          {grouped.map((group, gi) =>
            group.articles.length === 0 ? null : (
              <PageSectionV2
                key={group.key}
                eyebrow={group.category}
                title={`Guides ${group.category}`}
                subtitle={`${group.articles.length} article${group.articles.length > 1 ? "s" : ""} sur ${group.category.toLowerCase()}.`}
              >
                <div className="grid md:grid-cols-2 lg:grid-cols-3 gap-5 md:gap-6">
                  {group.articles.map((article, i) => (
                    <Reveal key={article.slug} delay={i * 80}>
                      <TiltCard className="kx-card block h-full" max={4}>
                        <Link to={`/guides/${article.slug}`} className="block">
                          <div className="flex items-start justify-between mb-5">
                            <span
                              className="w-11 h-11 rounded-xl flex items-center justify-center"
                              style={{ background: "hsl(var(--accent-light))", color: "hsl(var(--accent))" }}
                            >
                              <BookOpen className="w-5 h-5" />
                            </span>
                            <ArrowUpRight className="w-5 h-5" style={{ color: "hsl(var(--muted-text))" }} />
                          </div>
                          <p
                            className="text-[11px] uppercase tracking-[0.14em] font-bold mb-2"
                            style={{ color: "hsl(var(--accent))" }}
                          >
                            {article.category || group.category}
                          </p>
                          <p className="text-lg font-bold text-foreground mb-3 leading-tight tracking-tight">
                            {article.title}
                          </p>
                          <p className="text-sm leading-relaxed" style={{ color: "hsl(var(--muted-text))" }}>
                            {article.excerpt}
                          </p>
                        </Link>
                      </TiltCard>
                    </Reveal>
                  ))}
                </div>
              </PageSectionV2>
            )
          )}
        </div>

        <PageSectionV2
          variant="dark"
          title="Une question précise ?"
          subtitle="Plutôt que chercher dans nos guides, parlez directement à un conseiller. Réponse claire en 15 minutes."
        >
          <div className="flex flex-col sm:flex-row items-center justify-center gap-3 mt-2">
            <a href="mailto:admin@klary.ch" className="kx-btn kx-btn-accent text-base !py-4 !px-7">
              Écrire à un conseiller
              <ArrowRight className="w-4 h-4" />
            </a>
          </div>
        </PageSectionV2>
      </main>

      <FooterV2 />
    </div>
  );
};

export default Guides;
