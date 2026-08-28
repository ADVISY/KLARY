"use client";

import Link from "next/link";
import { usePathname } from "next/navigation";
import { useEffect, useState } from "react";
import { cn } from "@/lib/utils";

type NavItem = {
  href: string;
  label: string;
  icon: React.ReactNode;
  /** Chemins additionnels pour lesquels cet item est actif (onglets siblings) */
  activePaths?: string[];
};

// ─── Icônes ───
const iconBook = (
  <svg className="w-5 h-5" fill="none" stroke="currentColor" strokeWidth={2} viewBox="0 0 24 24">
    <path strokeLinecap="round" strokeLinejoin="round" d="M12 6.253v13m0-13C10.832 5.477 9.246 5 7.5 5S4.168 5.477 3 6.253v13C4.168 18.477 5.754 18 7.5 18s3.332.477 4.5 1.253m0-13C13.168 5.477 14.754 5 16.5 5c1.747 0 3.332.477 4.5 1.253v13C19.832 18.477 18.247 18 16.5 18c-1.746 0-3.332.477-4.5 1.253" />
  </svg>
);
const iconFolder = (
  <svg className="w-5 h-5" fill="none" stroke="currentColor" strokeWidth={2} viewBox="0 0 24 24">
    <path strokeLinecap="round" strokeLinejoin="round" d="M3 7v10a2 2 0 002 2h14a2 2 0 002-2V9a2 2 0 00-2-2h-6l-2-2H5a2 2 0 00-2 2z" />
  </svg>
);
const iconUser = (
  <svg className="w-5 h-5" fill="none" stroke="currentColor" strokeWidth={2} viewBox="0 0 24 24">
    <path strokeLinecap="round" strokeLinejoin="round" d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z" />
  </svg>
);
const iconClipboardCheck = (
  <svg className="w-5 h-5" fill="none" stroke="currentColor" strokeWidth={2} viewBox="0 0 24 24">
    <path strokeLinecap="round" strokeLinejoin="round" d="M9 5H7a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2V7a2 2 0 00-2-2h-2M9 5a2 2 0 002 2h2a2 2 0 002-2M9 5a2 2 0 012-2h2a2 2 0 012 2m-6 9l2 2 4-4" />
  </svg>
);
const iconRepeat = (
  <svg className="w-5 h-5" fill="none" stroke="currentColor" strokeWidth={2} viewBox="0 0 24 24">
    <path strokeLinecap="round" strokeLinejoin="round" d="M4 4v5h5M20 20v-5h-5M4 9a9 9 0 0114.5-3.5M20 15a9 9 0 01-14.5 3.5" />
  </svg>
);
const iconInbox = (
  <svg className="w-5 h-5" fill="none" stroke="currentColor" strokeWidth={2} viewBox="0 0 24 24">
    <path strokeLinecap="round" strokeLinejoin="round" d="M20 13V6a2 2 0 00-2-2H6a2 2 0 00-2 2v7m16 0v5a2 2 0 01-2 2H6a2 2 0 01-2-2v-5m16 0h-3.5l-2 3h-5l-2-3H4" />
  </svg>
);
const iconChat = (
  <svg className="w-5 h-5" fill="none" stroke="currentColor" strokeWidth={2} viewBox="0 0 24 24">
    <path strokeLinecap="round" strokeLinejoin="round" d="M8 12h.01M12 12h.01M16 12h.01M21 12c0 4.418-4.03 8-9 8a9.863 9.863 0 01-4.255-.949L3 20l1.395-3.72C3.512 15.042 3 13.574 3 12c0-4.418 4.03-8 9-8s9 3.582 9 8z" />
  </svg>
);
const iconPlus = (
  <svg className="w-5 h-5" fill="none" stroke="currentColor" strokeWidth={2} viewBox="0 0 24 24">
    <path strokeLinecap="round" strokeLinejoin="round" d="M12 6v6m0 0v6m0-6h6m-6 0H6" />
  </svg>
);
const iconLogout = (
  <svg className="w-5 h-5" fill="none" stroke="currentColor" strokeWidth={2} viewBox="0 0 24 24">
    <path strokeLinecap="round" strokeLinejoin="round" d="M17 16l4-4m0 0l-4-4m4 4H7m6 4v1a3 3 0 01-3 3H6a3 3 0 01-3-3V7a3 3 0 013-3h4a3 3 0 013 3v1" />
  </svg>
);
const iconUsers = (
  <svg className="w-5 h-5" fill="none" stroke="currentColor" strokeWidth={2} viewBox="0 0 24 24">
    <path strokeLinecap="round" strokeLinejoin="round" d="M17 20h5v-2a3 3 0 00-5.356-1.857M17 20H7m10 0v-2c0-.656-.126-1.283-.356-1.857M7 20H2v-2a3 3 0 015.356-1.857M7 20v-2c0-.656.126-1.283.356-1.857m0 0a5.002 5.002 0 019.288 0M15 7a3 3 0 11-6 0 3 3 0 016 0zm6 3a2 2 0 11-4 0 2 2 0 014 0zM7 10a2 2 0 11-4 0 2 2 0 014 0z" />
  </svg>
);
const iconPlug = (
  <svg className="w-5 h-5" fill="none" stroke="currentColor" strokeWidth={2} viewBox="0 0 24 24">
    <path strokeLinecap="round" strokeLinejoin="round" d="M13 10V3L4 14h7v7l9-11h-7z" />
  </svg>
);
const iconPulse = (
  <svg className="w-5 h-5" fill="none" stroke="currentColor" strokeWidth={2} viewBox="0 0 24 24">
    <path strokeLinecap="round" strokeLinejoin="round" d="M3 12h4l3-9 4 18 3-9h4" />
  </svg>
);
const iconMenu = (
  <svg className="w-6 h-6" fill="none" stroke="currentColor" strokeWidth={2} viewBox="0 0 24 24">
    <path strokeLinecap="round" strokeLinejoin="round" d="M4 6h16M4 12h16M4 18h16" />
  </svg>
);
const iconClose = (
  <svg className="w-6 h-6" fill="none" stroke="currentColor" strokeWidth={2} viewBox="0 0 24 24">
    <path strokeLinecap="round" strokeLinejoin="round" d="M6 18L18 6M6 6l12 12" />
  </svg>
);

// ─── Navigation flat : 1 item par groupe (les sous-pages sont accessibles via onglets) ───
const AGENT_ITEMS: NavItem[] = [
  {
    href: "/formation",
    label: "Formation",
    icon: iconBook,
    activePaths: ["/certifications"], // /certifications aussi allume "Formation"
  },
  {
    href: "/library",
    label: "Documents",
    icon: iconFolder,
    activePaths: ["/mes-documents"], // /mes-documents allume aussi "Documents"
  },
  {
    href: "/mon-profil",
    label: "Mon profil",
    icon: iconUser,
  },
];

const ADMIN_ITEMS: NavItem[] = [
  {
    href: "/admin/evaluations",
    label: "Évaluations",
    icon: iconClipboardCheck,
  },
  {
    href: "/admin/onboarding",
    label: "Onboarding / Offboarding",
    icon: iconRepeat,
    activePaths: ["/admin/offboarding"],
  },
  {
    href: "/admin/candidatures",
    label: "Candidatures",
    icon: iconInbox,
  },
  {
    href: "/admin/contacts",
    label: "Messages contact",
    icon: iconChat,
  },
  {
    href: "/admin/library",
    label: "Bibliothèque (admin)",
    icon: iconPlus,
  },
  {
    href: "/admin/agents",
    label: "Agents",
    icon: iconUsers,
  },
  {
    href: "/admin/barometre",
    label: "Baromètre équipe",
    icon: iconPulse,
  },
  {
    href: "/admin/integrations",
    label: "Intégrations",
    icon: iconPlug,
  },
];

interface SidebarProps {
  userEmail: string;
  userName: string;
  role: string;
  profileCompleted: boolean;
}

function isActive(pathname: string, item: NavItem): boolean {
  const paths = [item.href, ...(item.activePaths || [])];
  return paths.some((p) => pathname === p || pathname.startsWith(p + "/"));
}

export function Sidebar({
  userEmail,
  userName,
  role,
  profileCompleted,
}: SidebarProps) {
  const pathname = usePathname();
  const isAdmin = role === "admin" || role === "manager";
  const [mobileOpen, setMobileOpen] = useState(false);

  // Fermer le drawer mobile après navigation
  useEffect(() => {
    setMobileOpen(false);
  }, [pathname]);

  // Empêcher le scroll du body quand drawer ouvert
  useEffect(() => {
    if (mobileOpen) {
      document.body.style.overflow = "hidden";
    } else {
      document.body.style.overflow = "";
    }
    return () => {
      document.body.style.overflow = "";
    };
  }, [mobileOpen]);

  const sidebarContent = (
    <>
      {/* Logo header — FIXÉ */}
      <div className="px-6 pt-7 pb-5 border-b border-white/10 shrink-0 flex items-center justify-between">
        <Link href="/formation" className="inline-block">
          {/* eslint-disable-next-line @next/next/no-img-element */}
          <img
            src="/klary-logo.png"
            alt="Klary"
            style={{
              height: "44px",
              width: "auto",
              display: "block",
              filter: "brightness(0) invert(1)",
            }}
          />
        </Link>
        {/* Bouton fermer (mobile uniquement) */}
        <button
          onClick={() => setMobileOpen(false)}
          className="md:hidden text-white/70 hover:text-white p-2 -mr-2"
          aria-label="Fermer le menu"
        >
          {iconClose}
        </button>
      </div>

      <div className="px-6 py-2 shrink-0">
        <div className="text-[10px] font-semibold tracking-widest uppercase text-white/50">
          Plateforme interne
        </div>
      </div>

      {/* Warning profil incomplet — FIXÉ */}
      {!profileCompleted && (
        <div className="p-4 bg-klary-orange/20 border-b border-klary-orange/40 shrink-0">
          <Link
            href="/mon-profil"
            className="block text-xs text-orange-100 hover:text-white transition-colors"
          >
            <div className="flex items-center gap-2 font-semibold mb-1">
              <span>⚠</span> Profil incomplet
            </div>
            <div className="text-[11px] text-orange-100/80 leading-snug">
              Complétez votre profil pour recevoir vos attestations.
            </div>
          </Link>
        </div>
      )}

      {/* Nav — SCROLLABLE si beaucoup d'items */}
      <nav className="flex-1 min-h-0 overflow-y-auto p-3 space-y-1 sidebar-scroll">
        {AGENT_ITEMS.map((item) => {
          const active = isActive(pathname, item);
          return (
            <Link
              key={item.href}
              href={item.href}
              className={cn(
                "flex items-center gap-3 px-3 py-3 rounded-lg text-sm font-medium transition-colors min-h-[44px]",
                active
                  ? "bg-klary-orange text-white"
                  : "text-white/70 hover:text-white hover:bg-white/5"
              )}
            >
              {item.icon}
              <span>{item.label}</span>
            </Link>
          );
        })}

        {isAdmin && (
          <>
            <div className="mt-4 mb-2 px-3 text-[10px] uppercase tracking-widest text-white/40 font-bold">
              Administration
            </div>
            {ADMIN_ITEMS.map((item) => {
              const active = isActive(pathname, item);
              return (
                <Link
                  key={item.href}
                  href={item.href}
                  className={cn(
                    "flex items-center gap-3 px-3 py-3 rounded-lg text-sm font-medium transition-colors min-h-[44px]",
                    active
                      ? "bg-klary-orange text-white"
                      : "text-white/70 hover:text-white hover:bg-white/5"
                  )}
                >
                  {item.icon}
                  <span>{item.label}</span>
                </Link>
              );
            })}
          </>
        )}
      </nav>

      {/* Bloc utilisateur — FIXÉ */}
      <div className="p-4 border-t border-white/10 shrink-0">
        <div className="text-xs text-white/50 uppercase tracking-wider mb-2 font-semibold">
          Connecté
        </div>
        <div className="text-sm font-medium truncate text-white">
          {userName}
        </div>
        <div className="text-[11px] text-white/60 truncate mt-0.5">
          {userEmail}
        </div>
        <div className="text-[10px] text-klary-orange uppercase tracking-widest mt-0.5 font-semibold">
          {role}
        </div>

        <form action="/api/auth/logout" method="POST" className="mt-3">
          <button
            type="submit"
            className="w-full text-left text-xs text-white/60 hover:text-white transition-colors py-2 flex items-center gap-2 min-h-[44px]"
          >
            {iconLogout}
            Se déconnecter
          </button>
        </form>
      </div>

      <style jsx>{`
        .sidebar-scroll::-webkit-scrollbar {
          width: 6px;
        }
        .sidebar-scroll::-webkit-scrollbar-track {
          background: transparent;
        }
        .sidebar-scroll::-webkit-scrollbar-thumb {
          background: rgba(255, 255, 255, 0.15);
          border-radius: 3px;
        }
        .sidebar-scroll::-webkit-scrollbar-thumb:hover {
          background: rgba(255, 255, 255, 0.3);
        }
        .sidebar-scroll {
          scrollbar-width: thin;
          scrollbar-color: rgba(255, 255, 255, 0.15) transparent;
        }
      `}</style>
    </>
  );

  return (
    <>
      {/* ── HEADER MOBILE : burger + logo ── */}
      <div className="md:hidden fixed top-0 left-0 right-0 z-40 bg-klary-navy border-b border-white/10 flex items-center justify-between px-4 h-14">
        <button
          onClick={() => setMobileOpen(true)}
          className="text-white p-2 -ml-2 hover:bg-white/5 rounded-lg min-w-[44px] min-h-[44px] flex items-center justify-center"
          aria-label="Ouvrir le menu"
        >
          {iconMenu}
        </button>
        <Link href="/formation">
          {/* eslint-disable-next-line @next/next/no-img-element */}
          <img
            src="/klary-logo.png"
            alt="Klary"
            style={{
              height: "28px",
              width: "auto",
              filter: "brightness(0) invert(1)",
            }}
          />
        </Link>
        <div className="w-11" /> {/* Placeholder pour équilibrer le burger */}
      </div>

      {/* ── OVERLAY MOBILE (backdrop) ── */}
      {mobileOpen && (
        <div
          className="md:hidden fixed inset-0 bg-black/50 z-40 backdrop-blur-sm"
          onClick={() => setMobileOpen(false)}
          aria-hidden="true"
        />
      )}

      {/* ── SIDEBAR : desktop sticky, mobile drawer ── */}
      <aside
        className={cn(
          "bg-klary-navy text-white flex flex-col shrink-0 overflow-hidden",
          // Desktop : sticky visible
          "md:w-64 md:h-screen md:sticky md:top-0 md:flex",
          // Mobile : drawer coulissant depuis la gauche
          "fixed top-0 left-0 h-full w-72 max-w-[85vw] z-50",
          "transition-transform duration-300 ease-in-out",
          mobileOpen
            ? "translate-x-0"
            : "-translate-x-full md:translate-x-0"
        )}
      >
        {sidebarContent}
      </aside>
    </>
  );
}
