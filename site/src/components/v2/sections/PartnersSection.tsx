const partners = [
  { name: "Helvetia",            file: "helvetia.jpg" },
  { name: "Swiss Life",          file: "swiss-life.png" },
  { name: "AXA",                 file: "axa.png" },
  { name: "Zurich",              file: "zurich-assurances.jpg" },
  { name: "Generali",            file: "generali.jpg" },
  { name: "La Mobilière",        file: "la-mobiliere.jpg" },
  { name: "Bâloise",             file: "baloise.png" },
  { name: "CSS",                 file: "css-assurance.png" },
  { name: "Sanitas",             file: "sanitas.jpg" },
  { name: "Visana",              file: "visana.jpg" },
  { name: "Groupe Mutuel",       file: "groupe-mutuel.png" },
  { name: "Assura",              file: "assura.png" },
  { name: "Atupri",              file: "atupri.png" },
  { name: "Concordia",           file: "concordia.jpg" },
  { name: "Helsana",             file: "helsana.png" },
  { name: "KPT",                 file: "kpt-cpt.jpg" },
  { name: "Liechtenstein Life",  file: "liechtenstein-life.jpg" },
  { name: "ÖKK",                 file: "okk.webp" },
  { name: "Pax",                 file: "pax.png" },
  { name: "Swica",               file: "swica.png" },
  { name: "Sympany",             file: "sympany.png" },
];

export const PartnersSection = () => {
  // Double the array for seamless marquee loop
  const loop = [...partners, ...partners];

  return (
    <section id="partners" className="relative py-20 md:py-24 border-y border-neutral-light bg-background">
      <div className="mx-auto max-w-7xl px-5 lg:px-8">
        <div className="text-center mb-10 md:mb-14">
          <span className="kx-eyebrow mb-4">Toutes les compagnies suisses</span>
          <h2 className="text-xl md:text-2xl font-semibold text-foreground tracking-tight">
            On compare et négocie avec les <span className="font-bold tabular-nums">{partners.length}</span> acteurs du marché.
          </h2>
        </div>

        <div
          className="relative overflow-hidden"
          style={{
            maskImage: "linear-gradient(to right, transparent 0%, black 8%, black 92%, transparent 100%)",
            WebkitMaskImage: "linear-gradient(to right, transparent 0%, black 8%, black 92%, transparent 100%)",
          }}
        >
          <div className="flex gap-10 md:gap-14 kx-marquee w-max items-center">
            {loop.map((p, i) => (
              <div
                key={i}
                className="shrink-0 h-12 md:h-14 flex items-center justify-center"
                title={p.name}
              >
                <img
                  src={`/insurance-logos/${p.file}`}
                  alt={p.name}
                  loading="lazy"
                  className="h-full w-auto object-contain transition-all duration-300"
                  style={{
                    // multiply : sur fond crème, les pixels blancs des logos deviennent crème (donc invisibles),
                    // les couleurs des logos sont conservées et légèrement assourdies.
                    mixBlendMode: "multiply",
                    filter: "grayscale(80%) opacity(0.70) contrast(1.05)",
                  }}
                  onMouseEnter={(e) => {
                    (e.currentTarget as HTMLImageElement).style.filter = "grayscale(0%) opacity(1) contrast(1)";
                  }}
                  onMouseLeave={(e) => {
                    (e.currentTarget as HTMLImageElement).style.filter = "grayscale(80%) opacity(0.70) contrast(1.05)";
                  }}
                />
              </div>
            ))}
          </div>
        </div>
      </div>
    </section>
  );
};
