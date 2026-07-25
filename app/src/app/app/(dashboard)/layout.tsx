import { redirect } from "next/navigation";
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

  if (!user) {
    redirect("/login");
  }

  // Récupérer le rôle
  const { data: roleData } = await supabase
    .from("user_roles")
    .select("role")
    .eq("user_id", user.id)
    .eq("active", true)
    .maybeSingle();

  const role = roleData?.role || "agent";

  return (
    <div className="flex min-h-screen bg-klary-cream">
      <Sidebar userEmail={user.email || ""} role={role} />
      <main className="flex-1 min-w-0">{children}</main>
    </div>
  );
}
