import { insurancePages } from "./insurancePages";
import type { ArticleCard } from "@/components/sections/ArticleCards";

export interface GuideArticle extends ArticleCard {
  pageKey: string;
  pageCategory: string;
  pageSlug: string;
  /** Contenu éditorial long, en paragraphes Markdown-like simples (texte brut). */
  body: string[];
}

/**
 * Génère le corps d'un article à partir de l'extrait + titre.
 * Texte placeholder intelligent, premium, prêt à être remplacé par du contenu réel.
 */
const buildBody = (title: string, excerpt: string, category: string): string[] => [
  excerpt,
  `Dans ce guide, nous décryptons en profondeur le sujet "${title.toLowerCase()}" pour vous donner les clés de compréhension et d'action. Notre approche : démystifier la complexité, vous présenter les vrais arbitrages, et vous aider à prendre une décision éclairée — sans pression commerciale.`,
  `**Pourquoi ce sujet est important.** En Suisse, les questions liées à ${category.toLowerCase()} touchent directement votre budget, votre patrimoine et votre tranquillité d'esprit. Pourtant, peu de personnes prennent le temps d'analyser leur situation en détail. Résultat : des frais évitables, des protections inadaptées ou des opportunités manquées.`,
  `**Les principes à connaître.** Avant toute décision, il est essentiel de comprendre le cadre légal et contractuel qui s'applique. Chaque situation est unique : âge, canton, situation familiale, profession, projets de vie. Une recommandation pertinente part toujours d'une analyse personnalisée, jamais d'un produit standardisé.`,
  `**Les pièges fréquents.** Nous voyons régulièrement les mêmes erreurs : contrats jamais revus depuis l'origine, garanties redondantes, franchises mal calibrées, méconnaissance des options de retrait ou de modification. Chacune de ces erreurs peut coûter plusieurs centaines, voire plusieurs milliers de francs sur la durée.`,
  `**La méthode Klary.** Notre rôle est d'analyser, comparer et structurer — sans biais d'assureur. Nous travaillons avec un large panel de partenaires et notre rémunération ne dépend pas du produit choisi. L'objectif est simple : que vous compreniez exactement ce que vous payez et pourquoi, et que la solution retenue soit la meilleure pour votre profil.`,
  `**Ce que vous pouvez faire maintenant.** Faites un point sur votre situation actuelle. Rassemblez vos contrats ou documents existants. Notez les questions ou inquiétudes qui vous viennent à l'esprit. C'est le matériau parfait pour un premier échange avec un conseiller — gratuit et sans engagement chez Klary.`,
];

/** Index plat de tous les articles du site, indexé par slug. */
export const guidesIndex: Record<string, GuideArticle> = {};

Object.entries(insurancePages).forEach(([pageKey, page]) => {
  page.articles.forEach((article) => {
    guidesIndex[article.slug] = {
      ...article,
      pageKey,
      pageCategory: page.category,
      pageSlug: page.slug,
      body: buildBody(article.title, article.excerpt, page.category),
    };
  });
});

/** Liste de tous les articles, triés par catégorie de page. */
export const allGuides: GuideArticle[] = Object.values(guidesIndex);
