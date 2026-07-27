"use client";

import Link from "next/link";
import { usePathname } from "next/navigation";
import { cn } from "@/lib/utils";

type Tab = {
  href: string;
  label: string;
  icon?: React.ReactNode;
  badge?: string | number;
};

/**
 * Barre d'onglets partagée en haut d'une page groupée.
 * Active un tab si pathname === tab.href OU commence par (tab.href + "/").
 *
 * Utilisation :
 *   <PageTabs tabs={[
 *     { href: "/formation", label: "Modules" },
 *     { href: "/certifications", label: "Mes certifications" },
 *   ]} />
 */
export function PageTabs({ tabs }: { tabs: Tab[] }) {
  const pathname = usePathname();

  return (
    <div className="mb-6 border-b border-klary-light-grey">
      <nav className="flex gap-1 -mb-px overflow-x-auto">
        {tabs.map((tab) => {
          const active =
            pathname === tab.href || pathname.startsWith(tab.href + "/");
          return (
            <Link
              key={tab.href}
              href={tab.href}
              className={cn(
                "flex items-center gap-2 px-4 py-3 text-sm font-semibold border-b-2 transition-colors whitespace-nowrap",
                active
                  ? "border-klary-orange text-klary-navy"
                  : "border-transparent text-klary-grey hover:text-klary-navy hover:border-klary-light-grey"
              )}
            >
              {tab.icon}
              {tab.label}
              {tab.badge != null && (
                <span
                  className={cn(
                    "px-1.5 py-0.5 rounded-full text-[10px] font-bold",
                    active
                      ? "bg-klary-orange text-white"
                      : "bg-klary-cream text-klary-grey"
                  )}
                >
                  {tab.badge}
                </span>
              )}
            </Link>
          );
        })}
      </nav>
    </div>
  );
}
