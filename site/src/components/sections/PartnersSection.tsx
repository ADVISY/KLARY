import liechtensteinLogo from "@/assets/partners/liechtenstein-life.webp";
import cssLogo from "@/assets/partners/css-logo.png";
import groupeMutuelLogo from "@/assets/partners/groupe-mutuel-logo.png";
import sanitasLogo from "@/assets/partners/sanitas-logo-transparent.png";
import paxLogo from "@/assets/partners/pax-logo-transparent.png";
import helsanaLogo from "@/assets/partners/helsana-logo.svg";

const partners = [
  { name: "Liechtenstein Life", logo: liechtensteinLogo, hasWhiteBg: false },
  { name: "CSS", logo: cssLogo, hasWhiteBg: false },
  { name: "Helsana", logo: helsanaLogo, hasWhiteBg: false },
  { name: "Groupe Mutuel", logo: groupeMutuelLogo, hasWhiteBg: false },
  { name: "Sanitas", logo: sanitasLogo, hasWhiteBg: true },
  { name: "Pax", logo: paxLogo, hasWhiteBg: true },
];

export const PartnersSection = () => {
  // Duplicate exactly twice for seamless -50% loop
  const loopList = [...partners, ...partners];

  return (
    <section className="relative py-16 overflow-hidden">
      <div className="container relative z-10 mx-auto px-4 lg:px-8">
        <div className="text-center mb-8">
          <h2 className="text-heading-1 md:text-display-sm affirm-display">
            Accès aux meilleures{" "}
            <span
              className="bg-clip-text text-transparent"
              style={{
                backgroundImage:
                  "linear-gradient(100deg, hsl(220 100% 70%) 0%, hsl(245 100% 75%) 35%, hsl(265 100% 75%) 65%, hsl(300 95% 72%) 100%)",
                WebkitBackgroundClip: "text",
              }}
            >
              compagnies
            </span>
          </h2>
        </div>

        <div className="relative overflow-hidden py-4 [mask-image:linear-gradient(to_right,transparent,black_8%,black_92%,transparent)]">
          <div className="flex w-max animate-marquee-left">
            {loopList.map((p, i) => (
              <div
                key={`${p.name}-${i}`}
                className="flex-[0_0_auto] w-52 h-28 mr-8 group pole-card !min-h-0 !rounded-2xl !p-[1.5px]"
              >
                <div aria-hidden className="pole-card-border !rounded-2xl" />
                <div className="pole-card-inner !rounded-[14px] !p-6 !shadow-none flex items-center justify-center">
                  <img
                    src={p.logo}
                    alt={p.name}
                    className={`max-h-12 max-w-full object-contain transition-all duration-500 brightness-0 invert opacity-60 group-hover:brightness-100 group-hover:invert-0 group-hover:opacity-100 group-hover:scale-110 ${p.hasWhiteBg ? "group-hover:mix-blend-screen" : ""}`}
                  />
                </div>
              </div>
            ))}
          </div>
        </div>

        <p className="text-center mt-10 text-body-sm text-muted-foreground font-light">
          Et plus de <span className="font-medium text-primary-light">50+ compagnies</span> d'assurance en Suisse
        </p>
      </div>
    </section>
  );
};
