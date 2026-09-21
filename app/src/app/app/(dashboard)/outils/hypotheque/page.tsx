import { redirect } from "next/navigation";
import { createSupabaseServerClient } from "@/lib/supabase/server";
import { PremierPlanLogementWizard } from "./PremierPlanLogementWizard";

export const metadata = { title: "Premier Plan Logement — Outils Klary" };

export default async function OutilHypothequePage() {
  const supabase = createSupabaseServerClient();
  const {
    data: { user },
  } = await supabase.auth.getUser();
  if (!user) redirect("/login");

  return <PremierPlanLogementWizard />;
}
