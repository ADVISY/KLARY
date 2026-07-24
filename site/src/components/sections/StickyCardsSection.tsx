import { useEffect, useRef, useState } from "react";
import {
  AlertTriangle,
  Users,
  Lightbulb,
  TrendingUp,
  Shield,
  Home,
  HeartPulse,
  Wallet,
  Bell,
  CheckCircle2,
  Building2,
  Hammer,
  Coins,
  ArrowUpRight,
  Star,
  ChevronLeft,
  ChevronRight,
} from "lucide-react";
import bgPrevoyance from "@/assets/cards/bg-prevoyance.jpg";
import bgHypotheque from "@/assets/cards/bg-hypotheque.jpg";
import bgMaladie from "@/assets/cards/bg-maladie.jpg";
import bgLpp from "@/assets/cards/bg-lpp.jpg";

const bgByKind: Record<string, string> = {
  prevoyance: bgPrevoyance,
  hypotheque: bgHypotheque,
  maladie: bgMaladie,
  lpp: bgLpp,
};

// ---------- Types ----------
type CardData = {
  icon: typeof Shield;
  badge: string;
  title: string;
  hero: { prefix?: string; value: number; suffix?: string; format?: "int" | "decimal" | "thousands"; label: string };
  blocks: { probleme: string; situation: string; solution: string; resultat: string };
  visualKind: "prevoyance" | "hypotheque" | "maladie" | "lpp";
};

const cards: CardData[] = [
  {
    icon: Shield,
    badge: "Prévoyance privée",
    title: "Protéger sa famille, préparer sa retraite",
    hero: { value: 350, suffix: " CHF", label: "/ mois en 3a — déductible des impôts" },
    blocks: {
      probleme: "Perte de revenu en cas de décès d'un parent.",
      situation: "Couple, 2 enfants, 130'000 CHF / an, aucune stratégie.",
      solution: "Solution 3a à 350 CHF/mois, protection + retraite.",
      resultat: "Famille protégée, capital long terme, fiscalité optimisée.",
    },
    visualKind: "prevoyance",
  },
  {
    icon: Home,
    badge: "Hypothèque",
    title: "Structurer un financement durable",
    hero: { prefix: "−", value: 18, suffix: "%", label: "charge mensuelle réduite" },
    blocks: {
      probleme: "Financement mal structuré, mensualités trop lourdes.",
      situation: "Couple, projet d'achat en Suisse, budget serré.",
      solution: "Comparaison, structuration, montage optimisé.",
      resultat: "Mensualité cohérente, projet durable et maîtrisé.",
    },
    visualKind: "hypotheque",
  },
  {
    icon: HeartPulse,
    badge: "Assurance maladie",
    title: "Réduire les primes, garder la couverture",
    hero: { value: 3840, suffix: " CHF", format: "thousands", label: "économisés sur l'année" },
    blocks: {
      probleme: "Primes trop élevées, couvertures inadaptées.",
      situation: "Famille de 4, plus de 1'200 CHF/mois de primes.",
      solution: "Analyse, comparaison modèles, franchises, complémentaires.",
      resultat: "Charge réduite, couvertures cohérentes, milliers économisés.",
    },
    visualKind: "maladie",
  },
  {
    icon: Wallet,
    badge: "Libre passage LPP",
    title: "Retrouver et regrouper les avoirs",
    hero: { value: 85000, suffix: " CHF", format: "thousands", label: "d'avoirs LPP retrouvés" },
    blocks: {
      probleme: "Avoirs LPP dispersés après plusieurs employeurs.",
      situation: "Cliente, 7+ employeurs en 25 ans, fonds éparpillés.",
      solution: "Recherche, récupération, regroupement, meilleur taux.",
      resultat: "Avoirs centralisés, conditions optimisées, +3,2 % cette année.",
    },
    visualKind: "lpp",
  },
];

const blockMeta = [
  { key: "probleme", label: "Problème", icon: AlertTriangle, tone: "text-rose-300", bg: "bg-rose-500/5", ring: "ring-rose-500/15" },
  { key: "situation", label: "Situation", icon: Users, tone: "text-sky-300", bg: "bg-sky-500/5", ring: "ring-sky-500/15" },
  { key: "solution", label: "Solution", icon: Lightbulb, tone: "text-amber-300", bg: "bg-amber-500/5", ring: "ring-amber-500/15" },
  { key: "resultat", label: "Résultat", icon: TrendingUp, tone: "text-emerald-300", bg: "bg-emerald-500/5", ring: "ring-emerald-500/15" },
] as const;

const clamp = (v: number, min: number, max: number) => Math.min(Math.max(v, min), max);

// ---------- Count-up hook (rejoue à chaque ré-activation) ----------
const useCountUp = (target: number, active: boolean, duration = 1400) => {
  const [val, setVal] = useState(0);
  useEffect(() => {
    if (!active) {
      setVal(0);
      return;
    }
    const start = performance.now();
    let raf = 0;
    const tick = (now: number) => {
      const t = clamp((now - start) / duration, 0, 1);
      const eased = 1 - Math.pow(1 - t, 3);
      setVal(target * eased);
      if (t < 1) raf = requestAnimationFrame(tick);
    };
    raf = requestAnimationFrame(tick);
    return () => cancelAnimationFrame(raf);
  }, [active, target, duration]);
  return val;
};

const formatNumber = (n: number, format?: "int" | "decimal" | "thousands") => {
  if (format === "decimal") return n.toFixed(1).replace(".", ",");
  if (format === "thousands") return Math.round(n).toLocaleString("fr-CH").replace(/,/g, "'");
  return Math.round(n).toString();
};

// ---------- Visuals ----------

// PRÉVOYANCE — notifications "impôts déduits" + logos compagnies défilants
const PrevoyanceVisual = ({ reveal }: { reveal: number }) => {
  const taxAmount = useCountUp(840, reveal > 0.3);
  const capital3a = useCountUp(168000, reveal > 0.35);
  const companies = ["Helvetia", "Swiss Life", "AXA", "Zurich", "Generali", "Vaudoise", "Allianz", "Bâloise"];
  return (
    <div className="space-y-3">
      {/* Notif impôts */}
      <div
        className="flex items-center gap-3 rounded-xl bg-emerald-500/10 ring-1 ring-emerald-500/25 p-3.5"
        style={{
          opacity: clamp(reveal * 1.3 - 0.1, 0, 1),
          transform: `translateY(${(1 - clamp(reveal * 1.3 - 0.1, 0, 1)) * 8}px)`,
          transition: "opacity 600ms, transform 600ms",
        }}
      >
        <div className="flex h-10 w-10 items-center justify-center rounded-lg bg-emerald-500/20">
          <CheckCircle2 className="h-5 w-5 text-emerald-300" />
        </div>
        <div className="flex-1 min-w-0">
          <div className="text-sm text-muted-foreground">Impôts — déduction 3a</div>
          <div className="text-base font-semibold text-emerald-300 tabular-nums">−{formatNumber(taxAmount, "thousands")} CHF / an</div>
        </div>
        <Bell className="h-4 w-4 text-emerald-300/60" />
      </div>

      {/* Graphique capital 3a qui grandit */}
      <div
        className="rounded-xl bg-white/[0.03] ring-1 ring-white/[0.06] p-4"
        style={{
          opacity: clamp(reveal * 1.3 - 0.2, 0, 1),
          transform: `translateY(${(1 - clamp(reveal * 1.3 - 0.2, 0, 1)) * 8}px)`,
          transition: "opacity 600ms, transform 600ms",
        }}
      >
        <div className="flex items-center justify-between mb-2">
          <span className="text-sm text-muted-foreground">Capital 3a estimé</span>
          <span className="text-base font-semibold text-foreground/95 tabular-nums">
            {formatNumber(capital3a, "thousands")} CHF
          </span>
        </div>
        {(() => {
          const w = 280, h = 70;
          const pts = [8, 18, 32, 50, 70, 95, 125, 168];
          const max = Math.max(...pts);
          const stepX = w / (pts.length - 1);
          const visible = Math.max(1, Math.ceil(reveal * pts.length));
          const coords = pts.slice(0, visible).map((p, i) => `${i * stepX},${h - (p / max) * (h - 6)}`);
          const lastIdx = Math.min(visible - 1, pts.length - 1);
          const [lx, ly] = coords[lastIdx].split(",").map(Number);
          return (
            <svg viewBox={`0 0 ${w} ${h + 14}`} className="w-full">
              <defs>
                <linearGradient id="grad-3a" x1="0" y1="0" x2="0" y2="1">
                  <stop offset="0%" stopColor="hsl(150 80% 60%)" stopOpacity="0.45" />
                  <stop offset="100%" stopColor="hsl(150 80% 60%)" stopOpacity="0" />
                </linearGradient>
              </defs>
              <polyline points={`0,${h} ${coords.join(" ")} ${lx},${h}`} fill="url(#grad-3a)" stroke="none" />
              <polyline points={coords.join(" ")} fill="none" stroke="hsl(150 80% 65%)" strokeWidth="2.5" strokeLinecap="round" strokeLinejoin="round" />
              <circle cx={lx} cy={ly} r="4" fill="hsl(150 80% 70%)" />
            </svg>
          );
        })()}
        <div className="flex justify-between text-[11px] text-muted-foreground mt-1">
          <span>30 ans</span>
          <span>Retraite</span>
        </div>
      </div>

      {/* Logos défilants */}
      <div className="relative overflow-hidden rounded-lg bg-white/[0.02] ring-1 ring-white/[0.05] py-2.5">
        <div className="flex gap-6 animate-[scroll-x_22s_linear_infinite] whitespace-nowrap">
          {[...companies, ...companies].map((c, i) => (
            <span key={i} className="text-sm text-muted-foreground/80 font-medium tracking-wide">
              {c}
            </span>
          ))}
        </div>
      </div>
    </div>
  );
};

// HYPOTHÈQUE — maison qui se construit étage par étage
const HypothequeVisual = ({ reveal }: { reveal: number }) => {
  const monthly = useCountUp(2620, reveal > 0.3);
  // Construction en 4 phases selon reveal
  const phase = (i: number) => clamp(reveal * 1.5 - i * 0.18, 0, 1);
  return (
    <div className="space-y-3">
      <div className="relative h-24 rounded-xl bg-gradient-to-b from-sky-500/5 to-emerald-500/5 ring-1 ring-white/[0.05] overflow-hidden">
        <svg viewBox="0 0 200 90" className="h-full w-full">
          {/* Sol */}
          <line x1="10" y1="78" x2="190" y2="78" stroke="hsl(var(--muted) / 0.3)" strokeWidth="1" />
          {/* Fondation */}
          <rect x="55" y="70" width="90" height="8" rx="1" fill="hsl(245 40% 45%)" opacity={phase(0)} style={{ transition: "opacity 500ms" }} />
          {/* Murs */}
          <rect x="60" y="40" width="80" height="30" fill="hsl(245 60% 55%)" opacity={phase(1)} style={{ transition: "opacity 500ms" }} />
          {/* Toit */}
          <polygon points="55,40 100,15 145,40" fill="hsl(265 70% 60%)" opacity={phase(2)} style={{ transition: "opacity 500ms" }} />
          {/* Fenêtres + porte */}
          <g opacity={phase(3)} style={{ transition: "opacity 500ms" }}>
            <rect x="70" y="48" width="14" height="14" fill="hsl(50 90% 70%)" />
            <rect x="116" y="48" width="14" height="14" fill="hsl(50 90% 70%)" />
            <rect x="93" y="55" width="14" height="15" fill="hsl(20 60% 35%)" />
          </g>
          {/* Marteau qui flotte */}
          <g
            opacity={reveal > 0.2 ? 0.8 : 0}
            style={{
              transition: "opacity 600ms",
              transform: `translate(${150 + Math.sin(reveal * Math.PI * 2) * 4}px, ${20 - Math.cos(reveal * Math.PI * 2) * 3}px)`,
            }}
          >
            <circle r="8" fill="hsl(var(--primary) / 0.2)" />
          </g>
        </svg>
        <Hammer className="absolute top-2 right-2 h-4 w-4 text-primary/60 animate-pulse" />
      </div>

      <div
        className="flex items-center gap-3 rounded-xl bg-emerald-500/10 ring-1 ring-emerald-500/25 p-3"
        style={{
          opacity: clamp(reveal * 1.3 - 0.3, 0, 1),
          transform: `translateY(${(1 - clamp(reveal * 1.3 - 0.3, 0, 1)) * 8}px)`,
          transition: "opacity 600ms, transform 600ms",
        }}
      >
        <div className="flex h-9 w-9 items-center justify-center rounded-lg bg-emerald-500/20">
          <Building2 className="h-4 w-4 text-emerald-300" />
        </div>
        <div className="flex-1 min-w-0">
          <div className="text-xs text-muted-foreground">Mensualité optimisée</div>
          <div className="text-sm text-foreground/90 tabular-nums">{formatNumber(monthly, "thousands")} CHF / mois</div>
        </div>
        <span className="text-xs text-emerald-300 tabular-nums">−18%</span>
      </div>
    </div>
  );
};

// MALADIE — notifications de remboursements
const MaladieVisual = ({ reveal }: { reveal: number }) => {
  const total = useCountUp(3840, reveal > 0.3);
  const notifs = [
    { label: "Remboursement consultation", value: "180 CHF", delay: 0.0 },
    { label: "Remboursement dentaire", value: "420 CHF", delay: 0.18 },
    { label: "Prime mensuelle réduite", value: "−96 CHF", delay: 0.36 },
  ];
  return (
    <div className="space-y-2.5">
      {notifs.map((n, i) => {
        const r = clamp(reveal * 1.5 - n.delay, 0, 1);
        return (
          <div
            key={i}
            className="flex items-center gap-3 rounded-xl bg-white/[0.03] ring-1 ring-white/[0.06] p-2.5"
            style={{
              opacity: r,
              transform: `translateX(${(1 - r) * 16}px)`,
              transition: "opacity 600ms, transform 600ms",
            }}
          >
            <div className="flex h-8 w-8 items-center justify-center rounded-lg bg-emerald-500/15">
              <CheckCircle2 className="h-4 w-4 text-emerald-300" />
            </div>
            <div className="flex-1 min-w-0">
              <div className="text-[11px] text-muted-foreground">{n.label}</div>
            </div>
            <span className="text-xs text-emerald-300 tabular-nums">{n.value}</span>
          </div>
        );
      })}
      <div
        className="flex items-center justify-between rounded-xl bg-emerald-500/10 ring-1 ring-emerald-500/25 px-3 py-2.5 mt-2"
        style={{
          opacity: clamp(reveal * 1.4 - 0.55, 0, 1),
          transform: `translateY(${(1 - clamp(reveal * 1.4 - 0.55, 0, 1)) * 8}px)`,
          transition: "opacity 600ms, transform 600ms",
        }}
      >
        <span className="text-xs text-muted-foreground">Économies cumulées</span>
        <span className="text-sm text-emerald-300 tabular-nums">{formatNumber(total, "thousands")} CHF</span>
      </div>
    </div>
  );
};

// LPP — montant retrouvé + croissance progressive
const LppVisual = ({ reveal }: { reveal: number }) => {
  const found = useCountUp(85000, reveal > 0.2);
  const growth = useCountUp(3.2, reveal > 0.4);
  const future = useCountUp(99500, reveal > 0.5);

  // Courbe de croissance avoirs
  const years = [85, 87.7, 90.5, 93.4, 96.4, 99.5];
  return (
    <div className="space-y-3">
      <div
        className="flex items-center gap-3 rounded-xl bg-primary/10 ring-1 ring-primary/25 p-3.5"
        style={{
          opacity: clamp(reveal * 1.3 - 0.05, 0, 1),
          transform: `translateY(${(1 - clamp(reveal * 1.3 - 0.05, 0, 1)) * 8}px)`,
          transition: "opacity 600ms, transform 600ms",
        }}
      >
        <div className="flex h-10 w-10 items-center justify-center rounded-lg bg-primary/20">
          <Coins className="h-5 w-5 text-primary" />
        </div>
        <div className="flex-1 min-w-0">
          <div className="text-sm text-muted-foreground">Avoirs LPP retrouvés</div>
          <div className="text-base font-semibold text-foreground/95 tabular-nums">{formatNumber(found, "thousands")} CHF</div>
        </div>
        <Bell className="h-4 w-4 text-primary/60" />
      </div>

      <div
        className="flex items-center gap-3 rounded-xl bg-emerald-500/10 ring-1 ring-emerald-500/25 p-3.5"
        style={{
          opacity: clamp(reveal * 1.3 - 0.2, 0, 1),
          transform: `translateY(${(1 - clamp(reveal * 1.3 - 0.2, 0, 1)) * 8}px)`,
          transition: "opacity 600ms, transform 600ms",
        }}
      >
        <div className="flex h-10 w-10 items-center justify-center rounded-lg bg-emerald-500/20">
          <ArrowUpRight className="h-5 w-5 text-emerald-300" />
        </div>
        <div className="flex-1 min-w-0">
          <div className="text-sm text-muted-foreground">Performance cette année</div>
          <div className="text-base font-semibold text-emerald-300 tabular-nums">+{growth.toFixed(1).replace(".", ",")} %</div>
        </div>
      </div>

      {/* Courbe progressive — avoirs sur 5 ans */}
      <div
        className="rounded-xl bg-white/[0.03] ring-1 ring-white/[0.06] p-4"
        style={{
          opacity: clamp(reveal * 1.3 - 0.3, 0, 1),
          transform: `translateY(${(1 - clamp(reveal * 1.3 - 0.3, 0, 1)) * 8}px)`,
          transition: "opacity 600ms, transform 600ms",
        }}
      >
        <div className="flex items-center justify-between mb-2">
          <span className="text-sm text-muted-foreground">Avoirs projetés</span>
          <span className="text-base font-semibold text-emerald-300 tabular-nums">{formatNumber(future, "thousands")} CHF</span>
        </div>
        {(() => {
          const w = 280, h = 80;
          const max = Math.max(...years);
          const min = Math.min(...years) * 0.94;
          const stepX = w / (years.length - 1);
          const visible = Math.max(1, Math.ceil(reveal * years.length));
          const coords = years.slice(0, visible).map((p, i) => `${i * stepX},${h - ((p - min) / (max - min)) * (h - 6)}`);
          const lastIdx = Math.min(visible - 1, years.length - 1);
          const [lx, ly] = coords[lastIdx].split(",").map(Number);
          return (
            <svg viewBox={`0 0 ${w} ${h + 14}`} className="w-full">
              <defs>
                <linearGradient id="grad-lpp" x1="0" y1="0" x2="0" y2="1">
                  <stop offset="0%" stopColor="hsl(245 100% 70%)" stopOpacity="0.5" />
                  <stop offset="100%" stopColor="hsl(245 100% 70%)" stopOpacity="0" />
                </linearGradient>
              </defs>
              <polyline points={`0,${h} ${coords.join(" ")} ${lx},${h}`} fill="url(#grad-lpp)" stroke="none" />
              <polyline points={coords.join(" ")} fill="none" stroke="hsl(265 100% 78%)" strokeWidth="2.5" strokeLinecap="round" strokeLinejoin="round" />
              <circle cx={lx} cy={ly} r="4" fill="hsl(300 95% 75%)" />
            </svg>
          );
        })()}
        <div className="flex justify-between text-[11px] text-muted-foreground mt-1">
          <span>2025</span>
          <span>+5 ans</span>
        </div>
      </div>
    </div>
  );
};

const VisualForCard = ({ kind, reveal }: { kind: CardData["visualKind"]; reveal: number }) => {
  switch (kind) {
    case "prevoyance": return <PrevoyanceVisual reveal={reveal} />;
    case "hypotheque": return <HypothequeVisual reveal={reveal} />;
    case "maladie": return <MaladieVisual reveal={reveal} />;
    case "lpp": return <LppVisual reveal={reveal} />;
  }
};

// ---------- Hero number with count-up ----------
const HeroNumber = ({ card, active }: { card: CardData; active: boolean }) => {
  const val = useCountUp(card.hero.value, active);
  return (
    <span className="tabular-nums">
      {card.hero.prefix}
      {formatNumber(val, card.hero.format)}
      {card.hero.suffix}
    </span>
  );
};

// ---------- Main ----------
export const StickyCardsSection = () => {
  const scrollerRef = useRef<HTMLDivElement>(null);
  const [activeIdx, setActiveIdx] = useState(0);

  const scrollToIdx = (idx: number) => {
    const el = scrollerRef.current;
    if (!el) return;
    const clamped = clamp(idx, 0, cards.length - 1);
    const child = el.children[clamped] as HTMLElement | undefined;
    if (child) {
      el.scrollTo({ left: child.offsetLeft - el.offsetLeft, behavior: "smooth" });
    }
  };

  useEffect(() => {
    const el = scrollerRef.current;
    if (!el) return;
    const onScroll = () => {
      const children = Array.from(el.children) as HTMLElement[];
      const center = el.scrollLeft + el.clientWidth / 2;
      let nearest = 0;
      let best = Infinity;
      children.forEach((c, i) => {
        const cCenter = c.offsetLeft + c.clientWidth / 2 - el.offsetLeft;
        const d = Math.abs(cCenter - center);
        if (d < best) {
          best = d;
          nearest = i;
        }
      });
      setActiveIdx(nearest);
    };
    el.addEventListener("scroll", onScroll, { passive: true });
    return () => el.removeEventListener("scroll", onScroll);
  }, []);

  const renderCard = (card: CardData, idx: number) => {
    const Icon = card.icon;
    return (
      <article
        key={card.title}
        className="pole-card group !min-h-0 snap-center shrink-0 w-[88vw] sm:w-[80vw] md:w-[70vw] lg:w-[60vw] max-w-3xl"
      >
        <div aria-hidden className="pole-card-border" />
        <div className="pole-card-inner relative overflow-hidden">
          <div
            aria-hidden
            className="pointer-events-none absolute inset-0 bg-cover bg-center opacity-[0.07]"
            style={{
              backgroundImage: `url(${bgByKind[card.visualKind]})`,
              maskImage: "radial-gradient(ellipse at center, black 20%, transparent 75%)",
              WebkitMaskImage: "radial-gradient(ellipse at center, black 20%, transparent 75%)",
            }}
          />
          <div className="relative grid gap-6 p-5 md:p-8">
            <div className="flex flex-col gap-5 min-w-0">
              <div className="space-y-3">
                <div className="flex items-center gap-3">
                  <div className="flex h-11 w-11 items-center justify-center rounded-xl bg-primary/15 text-primary ring-1 ring-primary/20">
                    <Icon className="h-5 w-5" />
                  </div>
                  <div className="section-badge">{card.badge}</div>
                </div>
                <div className="flex items-center gap-3 text-xs">
                  <div className="flex items-center gap-1.5">
                    <div className="flex">
                      {[0, 1, 2, 3, 4].map((i) => (
                        <Star key={i} className="h-3.5 w-3.5 fill-yellow-400 text-yellow-400" />
                      ))}
                    </div>
                    <span className="text-foreground/90 font-medium tabular-nums">4,8/5</span>
                  </div>
                  <span className="h-3 w-px bg-white/10" />
                  <span className="text-muted-foreground tabular-nums">+2'500 clients</span>
                </div>
              </div>
              <div>
                <div
                  className="affirm-display text-4xl leading-none bg-clip-text text-transparent sm:text-5xl md:text-6xl"
                  style={{
                    backgroundImage:
                      "linear-gradient(120deg, hsl(220 100% 78%) 0%, hsl(265 100% 78%) 55%, hsl(300 95% 75%) 100%)",
                    WebkitBackgroundClip: "text",
                  }}
                >
                  <HeroNumber card={card} active={activeIdx === idx} />
                </div>
                <div className="mt-2 text-sm text-muted-foreground">{card.hero.label}</div>
                <h3 className="mt-3 text-xl md:text-2xl leading-tight text-foreground/95 affirm-display">
                  {card.title}
                </h3>
              </div>
              <VisualForCard kind={card.visualKind} reveal={activeIdx === idx ? 1 : 0} />
            </div>
            <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
              {blockMeta.map((meta) => {
                const BlockIcon = meta.icon;
                return (
                  <div
                    key={meta.key}
                    className={`relative rounded-xl border border-white/[0.06] ${meta.bg} p-4 ring-1 ${meta.ring}`}
                  >
                    <div className="mb-2 flex items-center gap-2">
                      <BlockIcon className={`h-4 w-4 ${meta.tone}`} />
                      <span className="text-xs uppercase tracking-[0.16em] text-muted-foreground font-semibold">
                        {meta.label}
                      </span>
                    </div>
                    <p className="text-[15px] leading-relaxed text-foreground/90 font-light">
                      {card.blocks[meta.key]}
                    </p>
                  </div>
                );
              })}
            </div>
          </div>
        </div>
      </article>
    );
  };

  return (
    <section className="relative py-8" aria-label="Cas clients">
      <div className="relative">
        {/* Scroller horizontal avec snap */}
        <div
          ref={scrollerRef}
          className="flex gap-6 overflow-x-auto snap-x snap-mandatory scroll-smooth px-[6vw] pb-6 [scrollbar-width:none] [&::-webkit-scrollbar]:hidden"
        >
          {cards.map((card, idx) => renderCard(card, idx))}
        </div>

        {/* Boutons de navigation */}
        <button
          type="button"
          onClick={() => scrollToIdx(activeIdx - 1)}
          disabled={activeIdx === 0}
          aria-label="Cas précédent"
          className="hidden md:flex absolute left-4 top-1/2 -translate-y-1/2 h-12 w-12 items-center justify-center rounded-full bg-white/10 backdrop-blur-md ring-1 ring-white/15 text-foreground hover:bg-white/15 transition disabled:opacity-30 disabled:cursor-not-allowed z-10"
        >
          <ChevronLeft className="h-5 w-5" />
        </button>
        <button
          type="button"
          onClick={() => scrollToIdx(activeIdx + 1)}
          disabled={activeIdx === cards.length - 1}
          aria-label="Cas suivant"
          className="hidden md:flex absolute right-4 top-1/2 -translate-y-1/2 h-12 w-12 items-center justify-center rounded-full bg-white/10 backdrop-blur-md ring-1 ring-white/15 text-foreground hover:bg-white/15 transition disabled:opacity-30 disabled:cursor-not-allowed z-10"
        >
          <ChevronRight className="h-5 w-5" />
        </button>

        {/* Indicateurs (dots) */}
        <div className="mt-4 flex justify-center gap-2">
          {cards.map((_, i) => (
            <button
              key={i}
              type="button"
              onClick={() => scrollToIdx(i)}
              aria-label={`Aller au cas ${i + 1}`}
              className={`h-1.5 rounded-full transition-all ${
                i === activeIdx ? "w-8 bg-primary" : "w-2 bg-white/20 hover:bg-white/30"
              }`}
            />
          ))}
        </div>
      </div>
    </section>
  );
};
