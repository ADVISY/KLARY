import Link from "next/link";
import { redirect } from "next/navigation";
import { createSupabaseServerClient } from "@/lib/supabase/server";

export const metadata = { title: "Outils conseiller — Klary" };

const OUTILS = [
  {
    href: "/outils/hypotheque",
    eyebrow: "Hypothèque · Prévoyance 3a",
    title: "Premier Plan Logement",
    desc: "Guide de RDV en 7 phases avec les 8 calculs à poser en direct devant le client. Mise en scène complète pour transformer l'envie d'accession en signature 3a.",
    tone: "orange",
    ready: true,
  },
  {
    href: "#",
    eyebrow: "À venir",
    title: "Analyse lacune prévoyance",
    desc: "Calcul lacune décès / invalidité / retraite avec cascade AVS + LPP + LAA + 3a. Recommandation produit avec chiffres personnalisés.",
    tone: "navy",
    ready: false,
  },
  {
    href: "#",
    eyebrow: "À venir",
    title: "Optimisation fiscale retraits",
    desc: "Simulateur étalement des retraits 3a sur 5 ans avec barèmes cantonaux 2026. Comparateur rente vs capital LPP.",
    tone: "navy",
    ready: false,
  },
];

export default async function OutilsPage() {
  const supabase = createSupabaseServerClient();
  const {
    data: { user },
  } = await supabase.auth.getUser();
  if (!user) redirect("/login");

  return (
    <div className="max-w-[1200px] mx-auto p-6 md:p-10">
      <header className="mb-8">
        <div className="text-xs font-bold tracking-widest uppercase text-klary-orange mb-2">
          Boîte à outils conseiller
        </div>
        <h1 className="text-3xl md:text-4xl font-bold text-klary-navy mb-3">
          Outils Klary
        </h1>
        <p className="text-klary-grey max-w-2xl">
          Calculateurs, guides de RDV et simulateurs à utiliser directement
          devant le client. Chiffres officiels 2026, garde-fous d&apos;honnêteté
          intégrés (contrat lié Assura).
        </p>
      </header>

      <div className="grid gap-4 md:grid-cols-2 lg:grid-cols-3">
        {OUTILS.map((o) => {
          const disabled = !o.ready;
          const Component: any = disabled ? "div" : Link;
          return (
            <Component
              key={o.title}
              href={o.href}
              className={`block rounded-2xl border p-6 transition ${
                disabled
                  ? "border-klary-light-grey bg-klary-cream/40 opacity-60 cursor-not-allowed"
                  : o.tone === "orange"
                  ? "border-klary-orange bg-klary-orange/5 hover:shadow-lg hover:border-klary-orange"
                  : "border-klary-light-grey bg-white hover:border-klary-navy"
              }`}
            >
              <div
                className={`text-xs font-bold uppercase tracking-widest mb-2 ${
                  disabled ? "text-klary-grey" : "text-klary-orange"
                }`}
              >
                {o.eyebrow}
              </div>
              <h2 className="text-xl font-bold text-klary-navy mb-2">{o.title}</h2>
              <p className="text-sm text-klary-grey leading-relaxed">{o.desc}</p>
              {o.ready ? (
                <div className="mt-4 text-sm font-semibold text-klary-orange">
                  Ouvrir →
                </div>
              ) : (
                <div className="mt-4 inline-block text-[10px] uppercase tracking-widest font-bold text-klary-grey bg-klary-cream rounded-full px-3 py-1">
                  Bientôt
                </div>
              )}
            </Component>
          );
        })}
      </div>
    </div>
  );
}
