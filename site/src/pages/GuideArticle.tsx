import { useParams, Link, Navigate } from "react-router-dom";
import { ArrowLeft, ArrowRight, ArrowUpRight, BookOpen, Mail } from "lucide-react";
import { HeaderV2 } from "@/components/v2/HeaderV2";
import { FooterV2 } from "@/components/v2/FooterV2";
import { ScrollProgress } from "@/components/v2/ScrollProgress";
import { PageHeroV2 } from "@/components/v2/PageHeroV2";
import { PageSectionV2 } from "@/components/v2/PageSectionV2";
import { Reveal } from "@/components/v2/Reveal";
import { TiltCard } from "@/components/v2/TiltCard";
import { guidesIndex, allGuides } from "@/config/guides";

const renderParagraph = (text: string, i: number) => {
  // Support **gras** simple en début de paragraphe
  const match = text.match(/^\*\*(.+?)\*\*\s*(.*)$/s);
  if (match) {
    return (
      <p key={i} className="text-base md:text-lg leading-relaxed" style={{ color: "hsl(var(--foreground-soft))" }}>
        <strong className="font-bold text-foreground">{match[1]}</strong> {match[2]}
      </p>
    );
  }
  return (
    <p key={i} className="text-base md:text-lg leading-relaxed" style={{ color: "hsl(var(--foreground-soft))" }}>
      {text}
    </p>
  );
};

const GuideArticle = () => {
  const { slug } = useParams<{ slug: string }>();
  const article = slug ? guidesIndex[slug] : undefined;

  if (!article) {
    return <Navigate to="/guides" replace />;
  }

  // 3 articles connexes (autres articles de la même catégorie)
  const related = allGuides
    .filter((g) => g.pageKey === article.pageKey && g.slug !== article.slug)
    .slice(0, 3);

  return (
    <div className="min-h-screen bg-background text-foreground">
      <ScrollProgress />
      <HeaderV2 />

      <main>
        <PageHeroV2
          eyebrow={article.pageCategory}
          title={article.title}
          subtitle={article.excerpt}
          cta={
            <>
              <Link to="/guides" className="kx-btn kx-btn-outline">
                <ArrowLeft className="w-4 h-4" />
                Tous les guides
              </Link>
              <a href="mailto:admin@klary.ch" className="kx-btn kx-btn-accent">
                Parler à un conseiller
                <ArrowRight className="w-4 h-4" />
              </a>
            </>
          }
        />

        {/* Corps de l'article */}
        <PageSectionV2>
          <div className="max-w-3xl mx-auto">
            <Reveal>
              <div className="kx-card !p-8 md:!p-12 space-y-6">
                {article.body.map(renderParagraph)}
              </div>
            </Reveal>

            <Reveal delay={150}>
              <Link
                to={`/assurances/${article.pageSlug}`}
                className="kx-card group flex items-center justify-between gap-4 mt-8 hover:!border-[hsl(var(--accent))/0.3]"
              >
                <div>
                  <p
                    className="text-[11px] uppercase tracking-[0.14em] font-bold mb-1"
                    style={{ color: "hsl(var(--accent))" }}
                  >
                    Aller plus loin
                  </p>
                  <p className="text-lg font-bold text-foreground tracking-tight">
                    Tout savoir sur {article.pageCategory.toLowerCase()}
                  </p>
                </div>
                <ArrowUpRight
                  className="w-6 h-6 transition-transform group-hover:translate-x-0.5"
                  style={{ color: "hsl(var(--accent))" }}
                />
              </Link>
            </Reveal>
          </div>
        </PageSectionV2>

        {/* Articles connexes */}
        {related.length > 0 && (
          <PageSectionV2
            eyebrow="Pour aller plus loin"
            title="Articles connexes"
          >
            <div className="grid md:grid-cols-2 lg:grid-cols-3 gap-5 md:gap-6">
              {related.map((r, i) => (
                <Reveal key={r.slug} delay={i * 80}>
                  <TiltCard className="kx-card block h-full" max={4}>
                    <Link to={`/guides/${r.slug}`} className="block">
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
                        {r.category || article.pageCategory}
                      </p>
                      <p className="text-lg font-bold text-foreground mb-3 leading-tight tracking-tight">
                        {r.title}
                      </p>
                      <p className="text-sm leading-relaxed" style={{ color: "hsl(var(--muted-text))" }}>
                        {r.excerpt}
                      </p>
                    </Link>
                  </TiltCard>
                </Reveal>
              ))}
            </div>
          </PageSectionV2>
        )}

        <PageSectionV2 variant="dark" title="Cas réel à débloquer ?" subtitle="Un guide donne le cadre. Un conseiller donne la réponse pour VOTRE situation.">
          <div className="flex flex-col sm:flex-row items-center justify-center gap-3 mt-2">
            <a href="mailto:admin@klary.ch" className="kx-btn kx-btn-accent text-base !py-4 !px-7">
              Réserver mon analyse
              <ArrowRight className="w-4 h-4" />
            </a>
            <a
              href="mailto:admin@klary.ch"
              className="kx-btn !py-4 !px-7 bg-white/10 text-white border border-white/20 hover:bg-white/15 transition-colors"
            >
              <Mail className="w-4 h-4" />
              admin@klary.ch
            </a>
          </div>
        </PageSectionV2>
      </main>

      <FooterV2 />
    </div>
  );
};

export default GuideArticle;
