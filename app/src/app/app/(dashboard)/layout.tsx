import { redirect } from "next/navigation";
import { headers } from "next/headers";
import { createSupabaseServerClient } from "@/lib/supabase/server";
import { Sidebar } from "@/components/app/Sidebar";

export default async function DashboardLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  const supabase = createSupabaseServerClient();
  const {
    data: { user },
  } = await supabase.auth.getUser();

  if (!user) redirect("/login");

  // Récupérer profil + rôle — on prend TOUTES les lignes actives et on
  // sélectionne le rôle le plus élevé pour éviter le cas 2 lignes (admin+agent)
  // qui fait échouer silencieusement maybeSingle().
  const { data: profileRows } = await supabase
    .from("user_roles")
    .select("role, first_name, last_name, profile_completed")
    .eq("user_id", user.id)
    .eq("active", true);

  const ROLE_PRIORITY: Record<string, number> = {
    admin: 3,
    manager: 2,
    agent: 1,
  };
  const profile = (profileRows ?? []).sort(
    (a, b) => (ROLE_PRIORITY[b.role] ?? 0) - (ROLE_PRIORITY[a.role] ?? 0)
  )[0];

  const role = profile?.role || "agent";
  const displayName =
    [profile?.first_name, profile?.last_name].filter(Boolean).join(" ") ||
    user.email ||
    "";

  // Redirection profil obligatoire si profil incomplet (sauf sur /mon-profil ou /admin)
  const pathname = headers().get("x-current-path") || "";
  const isOnProfilePage = pathname.includes("/mon-profil");
  const isAdminRoute = pathname.startsWith("/admin");

  if (!profile?.profile_completed && !isOnProfilePage && !isAdminRoute) {
    // Ne pas rediriger si l'utilisateur est déjà sur mon-profil
    // (contourner en utilisant le referer côté client ou juste laisser voir un warning)
    // Cette redirection ne fonctionnera qu'avec un middleware — pour l'instant on met un warning dans la sidebar
  }

  return (
    <div className="flex min-h-screen bg-klary-cream">
      <Sidebar
        userEmail={user.email || ""}
        userName={displayName}
        role={role}
        profileCompleted={profile?.profile_completed ?? false}
      />
      {/* pt-14 sur mobile pour compenser le header burger fixed h-14 ; pt-0 sur desktop */}
      <main className="flex-1 min-w-0 pt-14 md:pt-0">{children}</main>
    </div>
  );
}
