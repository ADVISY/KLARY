import { redirect } from "next/navigation";
import { createSupabaseServerClient } from "@/lib/supabase/server";

/**
 * Racine de app.klary.ch — redirige vers /login ou /formation
 * selon l'état de la session utilisateur.
 */
export default async function AppRootPage() {
  const supabase = createSupabaseServerClient();
  const {
    data: { user },
  } = await supabase.auth.getUser();

  if (user) {
    redirect("/formation");
  } else {
    redirect("/login");
  }
}
