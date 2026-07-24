import Link from "next/link";
import { Header } from "@/components/marketing/Header";
import { Footer } from "@/components/marketing/Footer";

const services = [
  {
    title: "Assurance maladie",
    desc: "LAMal + LCA. On compare les 5 principales compagnies et on trouve la couverture qui vous protège vraiment.",
    href: "/services",
  },
  {
    title: "Prévoyance",
    desc: "3e pilier, assurance-vie, optimisation fiscale. Un plan sur mesure pour vos projets.",
    href: "/services",
  },
  {
    title: "LPP libre passage",
    desc: "On retrouve et regroupe vos anciens fonds de 2e pilier — souvent oubliés, jamais négligeables.",
    href: "/services",
  },
  {
    title: "Hypothèque",
    desc: "Négociation multi-banques pour votre financement immobilier. Meilleur taux, meilleures conditions.",
    href: "/services",
  },
];

const values = [
  {
    title: "Neutralité",
    desc: "Aucune compagnie derrière nous. Notre conseil ne dépend pas de qui nous paie le plus.",
  },
  {
    title: "Transparence",
    desc: "Vous voyez les chiffres bruts, les écarts, les commissions. Pas de petits caractères.",
  },
  {
    title: "Économies réelles",
    desc: "Nos clients économisent en moyenne 1'200 CHF/an sans rogner sur les garanties.",
  },
];

export default function HomePage() {
  return (
    <>
      <Header />

      <main>
        {/* HERO */}
        <section className="max-w-6xl mx-auto px-6 pt-16 pb-24 md:pt-24 md:pb-32">
          <div className="max-w-3xl">
            <div className="inline-flex items-center gap-2 px-3 py-1 rounded-full bg-white/70 border border-klary-light-grey text-xs font-semibold tracking-wider uppercase text-klary-grey mb-6">
              <span className="w-2 h-2 rounded-full bg-klary-orange" />
              Courtage indépendant · Suisse
            </div>
            <h1 className="text-4xl md:text-6xl font-bold tracking-tight text-klary-navy leading-[1.05] mb-6">
              L'assurance,{" "}
              <span className="text-klary-orange">enfin claire.</span>
            </h1>
            <p className="text-lg md:text-xl text-klary-grey leading-relaxed max-w-2xl mb-10">
              On compare pour vous les 5 principales compagnies suisses. On
              négocie. On optimise. Vous économisez — souvent en améliorant
              même votre couverture.
            </p>
            <div className="flex flex-col sm:flex-row items-start sm:items-center gap-4">
              <Link
                href="/contact"
                className="inline-flex items-center gap-2 px-6 py-3.5 bg-klary-orange text-white text-base font-semibold rounded-xl hover:bg-klary-orange/90 transition-colors shadow-lg shadow-klary-orange/20"
              >
                Prendre contact
              </Link>
              <Link
                href="/services"
                className="inline-flex items-center gap-2 px-6 py-3.5 bg-white text-klary-navy text-base font-semibold rounded-xl border border-klary-light-grey hover:border-klary-navy transition-colors"
              >
                Découvrir nos services
              </Link>
            </div>
          </div>
        </section>

        {/* SERVICES */}
        <section className="bg-white border-y border-klary-light-grey/50">
          <div className="max-w-6xl mx-auto px-6 py-20">
            <div className="text-center mb-14">
              <div className="text-xs font-bold tracking-widest uppercase text-klary-orange mb-3">
                Nos spécialités
              </div>
              <h2 className="text-3xl md:text-4xl font-bold text-klary-navy tracking-tight mb-4">
                Quatre domaines, un seul interlocuteur.
              </h2>
              <p className="text-lg text-klary-grey max-w-2xl mx-auto">
                Klary vous accompagne sur l'ensemble de votre patrimoine
                assurance et prévoyance.
              </p>
            </div>

            <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
              {services.map((s) => (
                <Link
                  key={s.title}
                  href={s.href}
                  className="group p-6 rounded-2xl border border-klary-light-grey hover:border-klary-orange hover:shadow-lg transition-all bg-white"
                >
                  <div className="flex items-start justify-between mb-3">
                    <h3 className="text-xl font-semibold text-klary-navy group-hover:text-klary-orange transition-colors">
                      {s.title}
                    </h3>
                    <span className="text-klary-orange text-xl">→</span>
                  </div>
                  <p className="text-klary-grey leading-relaxed">{s.desc}</p>
                </Link>
              ))}
            </div>
          </div>
        </section>

        {/* VALEURS */}
        <section className="max-w-6xl mx-auto px-6 py-24">
          <div className="text-center mb-14">
            <div className="text-xs font-bold tracking-widest uppercase text-klary-orange mb-3">
              Pourquoi Klary ?
            </div>
            <h2 className="text-3xl md:text-4xl font-bold text-klary-navy tracking-tight">
              Trois exigences non négociables.
            </h2>
          </div>

          <div className="grid grid-cols-1 md:grid-cols-3 gap-8">
            {values.map((v, i) => (
              <div key={v.title} className="text-center">
                <div className="w-14 h-14 rounded-2xl bg-klary-orange/10 text-klary-orange flex items-center justify-center text-2xl font-bold mx-auto mb-4">
                  {i + 1}
                </div>
                <h3 className="text-xl font-semibold text-klary-navy mb-2">
                  {v.title}
                </h3>
                <p className="text-klary-grey leading-relaxed">{v.desc}</p>
              </div>
            ))}
          </div>
        </section>

        {/* CTA */}
        <section className="bg-klary-navy text-white">
          <div className="max-w-6xl mx-auto px-6 py-20 text-center">
            <h2 className="text-3xl md:text-4xl font-bold tracking-tight mb-4">
              Un premier échange, sans engagement.
            </h2>
            <p className="text-lg text-white/70 max-w-xl mx-auto mb-8">
              15 minutes pour comprendre votre situation et voir ensemble ce
              qu'on peut optimiser. Gratuit et sans engagement.
            </p>
            <Link
              href="/contact"
              className="inline-flex items-center gap-2 px-6 py-3.5 bg-klary-orange text-white text-base font-semibold rounded-xl hover:bg-klary-orange/90 transition-colors"
            >
              Nous contacter
            </Link>
          </div>
        </section>
      </main>

      <Footer />
    </>
  );
}
