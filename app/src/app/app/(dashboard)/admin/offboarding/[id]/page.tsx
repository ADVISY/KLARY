import { redirect, notFound } from "next/navigation";
import Link from "next/link";
import { createClient } from "@supabase/supabase-js";
import { createSupabaseServerClient } from "@/lib/supabase/server";
import { OffboardingDetailClient } from "./OffboardingDetailClient";

export const metadata = {
  title: "Détail offboarding — Admin",
};

export const dynamic = "force-dynamic";

export default async function AdminOffboardingDetail({
  params,
}: {
  params: { id: string };
}) {
  const supabase = createSupabaseServerClient();
  const {
    data: { user },
  } = await supabase.auth.getUser();
  if (!user) redirect("/login");

  const { data: role } = await supabase
    .from("user_roles")
    .select("role")
    .eq("user_id", user.id)
    .eq("active", true)
    .maybeSingle();
  if (role?.role !== "admin" && role?.role !== "manager")
    redirect("/formation");

  const { data: offb } = await supabase
    .from("offboarding_processes")
    .select("*")
    .eq("id", params.id)
    .maybeSingle();
  if (!offb) notFound();

  // Signed URL pour la convention signée si elle existe
  let signedConventionUrl: string | null = null;
  if (offb.convention_signed_storage_path) {
    const service = createClient(
      process.env.NEXT_PUBLIC_SUPABASE_URL!,
      process.env.SUPABASE_SERVICE_ROLE_KEY!,
      { auth: { persistSession: false, autoRefreshToken: false } }
    );
    const { data: sig } = await service.storage
      .from("offboarding-docs")
      .createSignedUrl(offb.convention_signed_storage_path, 3600);
    signedConventionUrl = sig?.signedUrl || null;
  }

  // Liste des managers/admins pour le "portefeuille transféré à"
  const { data: activeAgents } = await supabase
    .from("user_roles")
    .select("user_id, first_name, last_name, role")
    .eq("active", true)
    .in("role", ["agent", "manager", "admin"])
    .order("last_name", { ascending: true });

  return (
    <OffboardingDetailClient
      offboarding={offb}
      signedConventionUrl={signedConventionUrl}
      transferableAgents={(activeAgents || []).filter(
        (a: any) => a.user_id !== offb.user_id
      )}
    />
  );
}
