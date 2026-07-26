import { NextRequest, NextResponse } from "next/server";
import { createServerClient } from "@supabase/ssr";
import { cookies } from "next/headers";
import { z } from "zod";
import { createSupabaseServerClient } from "@/lib/supabase/server";

const CHECKLIST_ITEMS = [
  "access_revoked",
  "equipment_returned",
  "portfolio_transferred",
  "final_commissions_calculated",
  "work_certificate_issued",
  "attestation_ac_issued",
  "salary_final_sent",
  "lawid_sent",
  "finma_registry_updated",
] as const;

const schema = z.object({
  item: z.enum(CHECKLIST_ITEMS),
  action: z.enum(["check", "uncheck"]),
  notes: z.string().max(1000).optional().or(z.literal("")),
  amount: z.number().optional(), // pour final_commissions_amount
  portfolio_transferred_to: z.string().uuid().optional(),
});

/**
 * POST /api/admin/offboarding/[id]/checklist
 * Toggle un item de la checklist admin. Admin/manager only.
 */
export async function POST(
  request: NextRequest,
  { params }: { params: { id: string } }
) {
  try {
    const supabase = createSupabaseServerClient();
    const {
      data: { user },
    } = await supabase.auth.getUser();
    if (!user) {
      return NextResponse.json({ error: "Non authentifié" }, { status: 401 });
    }

    const { data: role } = await supabase
      .from("user_roles")
      .select("role")
      .eq("user_id", user.id)
      .eq("active", true)
      .maybeSingle();
    if (role?.role !== "admin" && role?.role !== "manager") {
      return NextResponse.json({ error: "Accès refusé" }, { status: 403 });
    }

    const body = await request.json();
    const parsed = schema.safeParse(body);
    if (!parsed.success) {
      return NextResponse.json(
        { error: "Données invalides", details: parsed.error.flatten() },
        { status: 400 }
      );
    }

    const item = parsed.data.item;
    const dateField = `${item}_at`;
    const notesField = `${item}_notes`;

    const updateData: Record<string, any> = {};
    if (parsed.data.action === "check") {
      updateData[dateField] = new Date().toISOString();
      if (parsed.data.notes) updateData[notesField] = parsed.data.notes;
      if (item === "final_commissions_calculated" && parsed.data.amount != null) {
        updateData.final_commissions_amount = parsed.data.amount;
      }
      if (item === "portfolio_transferred" && parsed.data.portfolio_transferred_to) {
        updateData.portfolio_transferred_to = parsed.data.portfolio_transferred_to;
      }
    } else {
      updateData[dateField] = null;
      // On garde les notes / montant / to
    }

    const cookieStore = cookies();
    const service = createServerClient(
      process.env.NEXT_PUBLIC_SUPABASE_URL!,
      process.env.SUPABASE_SERVICE_ROLE_KEY!,
      {
        cookies: {
          getAll: () => cookieStore.getAll(),
          setAll: () => {},
        },
      }
    );

    const { error: updateErr } = await service
      .from("offboarding_processes")
      .update(updateData)
      .eq("id", params.id);

    if (updateErr) {
      console.error("[offboarding/checklist] update err:", updateErr);
      return NextResponse.json(
        { error: "Erreur DB", details: updateErr.message },
        { status: 500 }
      );
    }

    // Vérifier si tout est complété → marquer completed_at
    const { data: refreshed } = await service
      .from("offboarding_processes")
      .select("*")
      .eq("id", params.id)
      .maybeSingle();

    if (refreshed) {
      const allDone = CHECKLIST_ITEMS.every(
        (i) => refreshed[`${i}_at`] != null
      );
      const hasSignedConvention =
        refreshed.convention_signed_uploaded_at != null;

      if (allDone && hasSignedConvention && !refreshed.completed_at) {
        await service
          .from("offboarding_processes")
          .update({
            completed_at: new Date().toISOString(),
            completed_by: user.id,
          })
          .eq("id", params.id);
      } else if (!allDone && refreshed.completed_at) {
        // Uncheck après finalisation → repasser en cours
        await service
          .from("offboarding_processes")
          .update({ completed_at: null, completed_by: null })
          .eq("id", params.id);
      }
    }

    return NextResponse.json({ success: true });
  } catch (err: any) {
    console.error("[offboarding/checklist] fatal:", err);
    return NextResponse.json(
      { error: "Erreur serveur", details: err?.message },
      { status: 500 }
    );
  }
}
