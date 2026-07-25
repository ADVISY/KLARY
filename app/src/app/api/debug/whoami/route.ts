import { NextResponse } from "next/server";
import { createSupabaseServerClient } from "@/lib/supabase/server";

/**
 * Debug endpoint temporaire — retourne l'état exact que voit le layout
 * côté serveur : user auth, user_roles, modules, erreurs RLS.
 * À supprimer une fois le bug sidebar résolu.
 */

export async function GET() {
  try {
    const supabase = createSupabaseServerClient();

    const {
      data: { user },
      error: authError,
    } = await supabase.auth.getUser();

    if (!user) {
      return NextResponse.json({
        step: "auth.getUser",
        user: null,
        authError: authError?.message ?? null,
      });
    }

    // Query user_roles — même sélecteur que le layout
    const { data: profileRows, error: profileError } = await supabase
      .from("user_roles")
      .select(
        "id, role, active, first_name, last_name, profile_completed, user_id"
      )
      .eq("user_id", user.id)
      .eq("active", true);

    // Aussi lister TOUTES les lignes du user (peu importe active) pour diag
    const { data: allRoles } = await supabase
      .from("user_roles")
      .select("id, role, active, first_name, last_name, profile_completed")
      .eq("user_id", user.id);

    // Modules
    const { data: modules, error: modulesError } = await supabase
      .from("training_modules")
      .select("key, title, active")
      .eq("active", true)
      .order("key");

    return NextResponse.json({
      auth: {
        userId: user.id,
        email: user.email,
        createdAt: user.created_at,
      },
      userRoles_activeOnly: {
        rows: profileRows,
        error: profileError?.message ?? null,
      },
      userRoles_allForUser: allRoles,
      trainingModules: {
        rows: modules,
        error: modulesError?.message ?? null,
      },
    });
  } catch (e: any) {
    return NextResponse.json(
      { fatal: e?.message ?? String(e) },
      { status: 500 }
    );
  }
}
