import { Link } from "react-router-dom";
import { ArrowUpRight } from "lucide-react";

export interface ArticleCard {
  slug: string;
  category: string;
  title: string;
  excerpt: string;
}

interface ArticleCardsProps {
  eyebrow?: string;
  title: string;
  subtitle?: string;
  articles: ArticleCard[];
  basePath?: string;
}

export const ArticleCards = ({
  eyebrow,
  title,
  subtitle,
  articles,
  basePath = "/guides",
}: ArticleCardsProps) => {
  return (
    <section className="relative py-24 lg:py-32">
      <div className="container mx-auto px-4 lg:px-8">
        <div className="max-w-3xl mx-auto text-center mb-14 space-y-5">
          {eyebrow && <div className="section-badge mx-auto">{eyebrow}</div>}
          <h2 className="text-3xl md:text-4xl lg:text-5xl affirm-display">{title}</h2>
          {subtitle && (
            <p className="text-base md:text-lg text-muted-foreground font-light leading-relaxed">
              {subtitle}
            </p>
          )}
        </div>

        <div className="grid md:grid-cols-2 lg:grid-cols-3 gap-5 md:gap-6 max-w-6xl mx-auto">
          {articles.map((a) => (
            <Link
              to={`${basePath}/${a.slug}`}
              key={a.slug}
              className="group premium-card p-7 md:p-8 flex flex-col"
            >
              <div className="flex items-center justify-between mb-4">
                <span className="text-xs uppercase tracking-wider text-primary-light/80 font-medium">
                  {a.category}
                </span>
                <ArrowUpRight className="w-4 h-4 text-muted-foreground group-hover:text-primary-light transition-colors" />
              </div>
              <h3 className="text-lg md:text-xl font-light text-foreground mb-3 tracking-tight leading-snug">
                {a.title}
              </h3>
              <p className="text-sm text-muted-foreground leading-relaxed font-light flex-1">
                {a.excerpt}
              </p>
              <span className="inline-flex items-center gap-2 text-primary-light text-sm mt-5 group-hover:gap-3 transition-all">
                Lire l'article
                <span>→</span>
              </span>
            </Link>
          ))}
        </div>
      </div>
    </section>
  );
};
