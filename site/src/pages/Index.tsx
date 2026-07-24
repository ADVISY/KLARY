import { useEffect, useLayoutEffect, useState } from "react";
import { LogoIntro } from "@/components/v2/LogoIntro";
import { HeaderV2 } from "@/components/v2/HeaderV2";
import { ScrollProgress } from "@/components/v2/ScrollProgress";
import { HeroV2 } from "@/components/v2/HeroV2";
import { StatsBar } from "@/components/v2/sections/StatsBar";
import { LiveSavingsCounter } from "@/components/v2/sections/LiveSavingsCounter";
import { ProblemSection } from "@/components/v2/sections/ProblemSection";
import { BeforeAfterSection } from "@/components/v2/sections/BeforeAfterSection";
import { SolutionSection } from "@/components/v2/sections/SolutionSection";
import { CoveragesSection } from "@/components/v2/sections/CoveragesSection";
import { ProcessSection } from "@/components/v2/sections/ProcessSection";
import { TestimonialsSection } from "@/components/v2/sections/TestimonialsSection";
import { PartnersSection } from "@/components/v2/sections/PartnersSection";
import { FAQSection } from "@/components/v2/sections/FAQSection";
import { FinalCtaSection } from "@/components/v2/sections/FinalCtaSection";
import { FooterV2 } from "@/components/v2/FooterV2";

const Index = () => {
  const [introDone, setIntroDone] = useState(false);

  useEffect(() => {
    if ("scrollRestoration" in window.history) {
      window.history.scrollRestoration = "manual";
    }
  }, []);

  useLayoutEffect(() => {
    document.body.style.overflow = introDone ? "" : "hidden";
    if (!introDone) {
      window.scrollTo({ top: 0, left: 0, behavior: "auto" });
    }
    return () => { document.body.style.overflow = ""; };
  }, [introDone]);

  return (
    <div className="min-h-screen bg-background text-foreground">
      {!introDone && <LogoIntro onComplete={() => setIntroDone(true)} />}
      <div className={introDone ? "kx-fade-in" : "opacity-0"}>
        <ScrollProgress />
        <HeaderV2 />
        <main>
          <HeroV2 />
          <StatsBar />
          <ProblemSection />
          <BeforeAfterSection />
          <SolutionSection />
          <CoveragesSection />
          <ProcessSection />
          <LiveSavingsCounter />
          <TestimonialsSection />
          <PartnersSection />
          <FAQSection />
          <FinalCtaSection />
        </main>
        <FooterV2 />
      </div>
    </div>
  );
};

export default Index;
