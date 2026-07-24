import { useEffect, useState } from "react";
import cascoCar from "@/assets/optimized/casco-car.webp";
import menageProduct from "@/assets/optimized/menage-product.webp";
import santeProduct from "@/assets/optimized/sante-product.webp";
import lppProduct from "@/assets/optimized/lpp-product.webp";
import prevoyanceProduct from "@/assets/optimized/prevoyance-product.webp";
import { ScrambleText } from "@/components/ScrambleText";

type Slide = {
  badge: string;
  innerBadge: string;
  title: string;
  subtitle: string;
  currentLabel: string;
  currentValue: string;
  optimizedLabel: string;
  optimizedValue: string;
  image: string;
  imageAlt: string;
};

const slides: Slide[] = [
  {
    badge: "Casco complète",
    innerBadge: "Assurance voiture",
    title: "Franchise 1000.-",
    subtitle: " avec protection du bonus",
    currentLabel: "Prime actuelle",
    currentValue: "2200.- / année",
    optimizedLabel: "Prime optimisée",
    optimizedValue: "1780.- / année",
    image: cascoCar,
    imageAlt: "Voiture Casco",
  },
  {
    badge: "Assurance ménage",
    innerBadge: "RC + Inventaire",
    title: "Couverture 80000.-",
    subtitle: " inventaire & responsabilité",
    currentLabel: "Prime actuelle",
    currentValue: "420.- / année",
    optimizedLabel: "Prime optimisée",
    optimizedValue: "290.- / année",
    image: menageProduct,
    imageAlt: "Maison assurance ménage",
  },
  {
    badge: "Assurance maladie",
    innerBadge: "LAMal + Complémentaires",
    title: "Franchise 2500.-",
    subtitle: " modèle médecin de famille",
    currentLabel: "Prime actuelle",
    currentValue: "418.- / mois",
    optimizedLabel: "Prime optimisée",
    optimizedValue: "312.- / mois",
    image: santeProduct,
    imageAlt: "Assurance maladie",
  },
  {
    badge: "Libre passage LPP",
    innerBadge: "2e pilier",
    title: "Avoir total 147 580.-",
    subtitle: " consolidé sur un compte",
    currentLabel: "Avoir retrouvé",
    currentValue: "87 450.-",
    optimizedLabel: "Rendement",
    optimizedValue: "4,2 % / an",
    image: lppProduct,
    imageAlt: "Sac d'argent libre passage LPP",
  },
  {
    badge: "Prévoyance privée",
    innerBadge: "3e pilier 3a",
    title: "Montant 604.- / mois",
    subtitle: " versement déductible",
    currentLabel: "Impôt déductible",
    currentValue: "7 258.- / an",
    optimizedLabel: "Capital retraite",
    optimizedValue: "259 450.-",
    image: prevoyanceProduct,
    imageAlt: "Graphique de croissance prévoyance",
  },
];

export const HeroProductSlider = () => {
  // index can go from 0..slides.length (last value is a clone of slide 0)
  const [index, setIndex] = useState(0);
  const [enableTransition, setEnableTransition] = useState(true);

  useEffect(() => {
    const id = setInterval(() => {
      setEnableTransition(true);
      setIndex((i) => i + 1);
    }, 4500);
    return () => clearInterval(id);
  }, []);

  // When we reach the cloned slide at the end, snap silently back to 0
  useEffect(() => {
    if (index === slides.length) {
      const t = setTimeout(() => {
        setEnableTransition(false);
        setIndex(0);
      }, 700); // match transition duration
      return () => clearTimeout(t);
    }
    if (!enableTransition) {
      // re-enable transition on next frame after the silent snap
      const r = requestAnimationFrame(() => setEnableTransition(true));
      return () => cancelAnimationFrame(r);
    }
  }, [index, enableTransition]);

  const realIndex = index % slides.length;
  const slide = slides[realIndex];

  return (
    <>
      {/* Glass card — fixed container */}
      <div
        className="rounded-2xl backdrop-blur-xl border -mr-3 -ml-5"
        style={{
          background:
            "linear-gradient(160deg, hsl(250 80% 70% / 0.18), hsl(245 70% 50% / 0.10))",
          borderColor: "hsl(250 100% 85% / 0.25)",
          boxShadow:
            "0 20px 50px -10px hsl(250 90% 40% / 0.35), inset 0 1px 0 hsl(255 100% 95% / 0.12)",
          padding: "18px",
          paddingBottom: "28px",
        }}
      >
        {/* Badge pill — container fixed, text scrambles */}
        <div
          className="inline-flex items-center gap-1.5 rounded-full mb-4"
          style={{
            background: "hsl(250 100% 85% / 0.22)",
            border: "1px solid hsl(250 100% 85% / 0.35)",
            padding: "4px 10px",
          }}
        >
          <span
            className="w-[6px] h-[6px] rounded-full"
            style={{ background: "hsl(250 100% 80%)" }}
          />
          <ScrambleText
            text={slide.badge}
            className="text-[10px] md:text-[11px] font-semibold tracking-wide whitespace-nowrap"
            style={{ color: "hsl(250 100% 88%)" }}
          />
        </div>

        {/* Main line with bullet — container fixed, text scrambles */}
        <div className="flex items-start gap-2 mb-3">
          <div
            className="w-[13px] h-[13px] md:w-[15px] md:h-[15px] rounded-full mt-[2px] flex-shrink-0"
            style={{
              background: "hsl(250 100% 75%)",
              boxShadow: "0 0 14px hsl(250 100% 70% / 0.85)",
            }}
          />
          <p className="text-white text-[13px] md:text-[15px] leading-tight whitespace-nowrap overflow-hidden">
            <ScrambleText text={slide.title} className="font-bold" />
            <ScrambleText text={slide.subtitle} className="text-white/70 font-normal" />
          </p>
        </div>

        {/* Details rows — containers fixed, values scramble */}
        <div className="space-y-1.5 pl-[21px]">
          <div className="flex justify-between items-center gap-2 text-[11px] md:text-[12px] whitespace-nowrap">
            <span className="text-white/60 truncate">{slide.currentLabel}</span>
            <ScrambleText
              text={slide.currentValue}
              className="text-white/90 font-medium"
            />
          </div>
          <div className="flex justify-between items-center gap-2 text-[11px] md:text-[12px] whitespace-nowrap">
            <span className="text-white/60 truncate">{slide.optimizedLabel}</span>
            <ScrambleText
              text={slide.optimizedValue}
              className="font-semibold"
              style={{ color: "hsl(250 100% 85%)" }}
            />
          </div>
        </div>

        {/* Inner placeholder card with product image — fixed container */}
        <div
          className="mt-4 rounded-xl border w-full overflow-hidden flex flex-col"
          style={{
            background:
              "linear-gradient(160deg, hsl(250 80% 70% / 0.12), hsl(245 70% 50% / 0.06))",
            borderColor: "hsl(250 100% 85% / 0.18)",
            aspectRatio: "1 / 1.25",
            padding: "12px",
          }}
        >
          <div
            className="inline-flex items-center gap-1.5 rounded-full self-start"
            style={{
              background: "hsl(250 100% 85% / 0.22)",
              border: "1px solid hsl(250 100% 85% / 0.35)",
              padding: "4px 10px",
            }}
          >
            <span
              className="w-[6px] h-[6px] rounded-full"
              style={{ background: "hsl(250 100% 80%)" }}
            />
            <ScrambleText
              text={slide.innerBadge}
              className="text-[10px] md:text-[11px] font-semibold tracking-wide whitespace-nowrap"
              style={{ color: "hsl(250 100% 88%)" }}
            />
          </div>
          <div className="flex-1 relative overflow-hidden">
            <div
              className={`absolute inset-0 flex ${
                enableTransition ? "transition-transform duration-700 ease-out" : ""
              }`}
              style={{ transform: `translateX(-${index * 100}%)` }}
            >
              {[...slides, slides[0]].map((s, i) => (
                <div
                  key={i}
                  className="w-full h-full flex-shrink-0 flex items-center justify-center"
                >
                  <img
                    src={s.image}
                    alt={s.imageAlt}
                    className="w-[90%] h-auto max-h-full object-contain"
                  />
                </div>
              ))}
            </div>
          </div>
        </div>

        {/* Dots */}
        <div className="flex items-center justify-center gap-1.5 mt-4">
          {slides.map((_, i) => (
            <button
              key={i}
              onClick={() => {
                setEnableTransition(true);
                setIndex(i);
              }}
              aria-label={`Aller à la carte ${i + 1}`}
              className="transition-all duration-300 rounded-full"
              style={{
                width: i === realIndex ? "18px" : "6px",
                height: "6px",
                background:
                  i === realIndex ? "hsl(250 100% 85%)" : "hsl(250 100% 85% / 0.3)",
              }}
            />
          ))}
        </div>
      </div>
    </>
  );
};
