"use client";

import Link from "next/link";
import Image from "next/image";
import { usePathname } from "next/navigation";
import { cn } from "@/lib/utils";

type NavItem = {
  href: string;
  label: string;
  icon: React.ReactNode;
};

const NAV_ITEMS: NavItem[] = [
  {
    href: "/formation",
    label: "Formation",
    icon: (
      <svg
        className="w-5 h-5"
        fill="none"
        stroke="currentColor"
        strokeWidth={2}
        viewBox="0 0 24 24"
      >
        <path
          strokeLinecap="round"
          strokeLinejoin="round"
          d="M12 6.253v13m0-13C10.832 5.477 9.246 5 7.5 5S4.168 5.477 3 6.253v13C4.168 18.477 5.754 18 7.5 18s3.332.477 4.5 1.253m0-13C13.168 5.477 14.754 5 16.5 5c1.747 0 3.332.477 4.5 1.253v13C19.832 18.477 18.247 18 16.5 18c-1.746 0-3.332.477-4.5 1.253"
        />
      </svg>
    ),
  },
  {
    href: "/certifications",
    label: "Mes certifications",
    icon: (
      <svg
        className="w-5 h-5"
        fill="none"
        stroke="currentColor"
        strokeWidth={2}
        viewBox="0 0 24 24"
      >
        <path
          strokeLinecap="round"
          strokeLinejoin="round"
          d="M9 12l2 2 4-4M7.835 4.697a3.42 3.42 0 001.946-.806 3.42 3.42 0 014.438 0 3.42 3.42 0 001.946.806 3.42 3.42 0 013.138 3.138 3.42 3.42 0 00.806 1.946 3.42 3.42 0 010 4.438 3.42 3.42 0 00-.806 1.946 3.42 3.42 0 01-3.138 3.138 3.42 3.42 0 00-1.946.806 3.42 3.42 0 01-4.438 0 3.42 3.42 0 00-1.946-.806 3.42 3.42 0 01-3.138-3.138 3.42 3.42 0 00-.806-1.946 3.42 3.42 0 010-4.438 3.42 3.42 0 00.806-1.946 3.42 3.42 0 013.138-3.138z"
        />
      </svg>
    ),
  },
  {
    href: "/mon-profil",
    label: "Mon profil",
    icon: (
      <svg
        className="w-5 h-5"
        fill="none"
        stroke="currentColor"
        strokeWidth={2}
        viewBox="0 0 24 24"
      >
        <path
          strokeLinecap="round"
          strokeLinejoin="round"
          d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z"
        />
      </svg>
    ),
  },
];

const ADMIN_ITEMS: NavItem[] = [
  {
    href: "/admin/candidatures",
    label: "Candidatures",
    icon: (
      <svg
        className="w-5 h-5"
        fill="none"
        stroke="currentColor"
        strokeWidth={2}
        viewBox="0 0 24 24"
      >
        <path
          strokeLinecap="round"
          strokeLinejoin="round"
          d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"
        />
      </svg>
    ),
  },
  {
    href: "/admin/contacts",
    label: "Messages contact",
    icon: (
      <svg
        className="w-5 h-5"
        fill="none"
        stroke="currentColor"
        strokeWidth={2}
        viewBox="0 0 24 24"
      >
        <path
          strokeLinecap="round"
          strokeLinejoin="round"
          d="M8 12h.01M12 12h.01M16 12h.01M21 12c0 4.418-4.03 8-9 8a9.863 9.863 0 01-4.255-.949L3 20l1.395-3.72C3.512 15.042 3 13.574 3 12c0-4.418 4.03-8 9-8s9 3.582 9 8z"
        />
      </svg>
    ),
  },
  {
    href: "/admin/agents",
    label: "Agents",
    icon: (
      <svg
        className="w-5 h-5"
        fill="none"
        stroke="currentColor"
        strokeWidth={2}
        viewBox="0 0 24 24"
      >
        <path
          strokeLinecap="round"
          strokeLinejoin="round"
          d="M17 20h5v-2a3 3 0 00-5.356-1.857M17 20H7m10 0v-2c0-.656-.126-1.283-.356-1.857M7 20H2v-2a3 3 0 015.356-1.857M7 20v-2c0-.656.126-1.283.356-1.857m0 0a5.002 5.002 0 019.288 0M15 7a3 3 0 11-6 0 3 3 0 016 0zm6 3a2 2 0 11-4 0 2 2 0 014 0zM7 10a2 2 0 11-4 0 2 2 0 014 0z"
        />
      </svg>
    ),
  },
];

interface SidebarProps {
  userEmail: string;
  userName: string;
  role: string;
  profileCompleted: boolean;
}

export function Sidebar({
  userEmail,
  userName,
  role,
  profileCompleted,
}: SidebarProps) {
  const pathname = usePathname();
  const isAdmin = role === "admin" || role === "manager";
  const displayItems = [...NAV_ITEMS, ...(isAdmin ? ADMIN_ITEMS : [])];

  return (
    <aside className="w-64 bg-klary-navy text-white flex flex-col shrink-0 h-screen sticky top-0">
      {/* Logo header */}
      <div className="p-6 border-b border-white/10">
        <Link href="/formation" className="inline-block">
          <Image
            src="/klary-logo-white.png"
            alt="Klary"
            width={140}
            height={47}
            priority
            className="h-9 w-auto"
          />
        </Link>
        <div className="text-[10px] font-semibold tracking-widest uppercase text-white/50 mt-2">
          Plateforme interne
        </div>
      </div>

      {/* Warning profil incomplet */}
      {!profileCompleted && (
        <div className="p-4 bg-klary-orange/20 border-b border-klary-orange/40">
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

      {/* Nav items */}
      <nav className="flex-1 p-4 space-y-1">
        {displayItems.map((item) => {
          const active =
            pathname === item.href || pathname.startsWith(item.href + "/");
          return (
            <Link
              key={item.href}
              href={item.href}
              className={cn(
                "flex items-center gap-3 px-3 py-2.5 rounded-lg text-sm font-medium transition-colors",
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
      </nav>

      {/* Bottom user block */}
      <div className="p-4 border-t border-white/10">
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
            className="w-full text-left text-xs text-white/60 hover:text-white transition-colors py-1.5 flex items-center gap-2"
          >
            <svg
              className="w-4 h-4"
              fill="none"
              stroke="currentColor"
              strokeWidth={2}
              viewBox="0 0 24 24"
            >
              <path
                strokeLinecap="round"
                strokeLinejoin="round"
                d="M17 16l4-4m0 0l-4-4m4 4H7m6 4v1a3 3 0 01-3 3H6a3 3 0 01-3-3V7a3 3 0 013-3h4a3 3 0 013 3v1"
              />
            </svg>
            Se déconnecter
          </button>
        </form>
      </div>
    </aside>
  );
}
