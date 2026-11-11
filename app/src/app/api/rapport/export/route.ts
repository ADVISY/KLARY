import { NextRequest, NextResponse } from "next/server";
import { createSupabaseServerClient } from "@/lib/supabase/server";
import {
  ALL_FIELDS,
  ROLE_LABELS,
  SALES_ROLES,
  conversionRate,
  highestRole,
  todayZurich,
} from "@/lib/reports/fields";

// Point-virgule et BOM : le fichier s'ouvre correctement dans Excel en français.
// Une cellule commençant par = + - @ serait exécutée comme une formule.
function cell(value: string | number | null | undefined): string {
  if (typeof value === "number") return String(value).replace(".", ",");
  let text = value ?? "";
  if (/^[=+\-@\t\r]/.test(text)) text = `'${text}`;
  return `"${text.replace(/"/g, '""')}"`;
}

/**
 * GET /api/rapport/export?date=AAAA-MM-JJ
 * Télécharge le rapport global d'une journée : le total, puis le détail par
 * personne et les rapports manquants. RLS limite le responsable à son équipe ;
 * la direction reçoit tout.
 */
export async function GET(request: NextRequest) {
  const supabase = createSupabaseServerClient();
  const {
    data: { user },
  } = await supabase.auth.getUser();
  if (!user) {
    return NextResponse.json({ error: "Non connecté." }, { status: 401 });
  }

  const { data: myRoles } = await supabase
    .from("user_roles")
    .select("role")
    .eq("user_id", user.id)
    .eq("active", true);
  const myRole = highestRole(myRoles);
  if (myRole !== "admin" && myRole !== "manager") {
    return NextResponse.json({ error: "Accès refusé." }, { status: 403 });
  }

  const param = request.nextUrl.searchParams.get("date") ?? "";
  const date = /^\d{4}-\d{2}-\d{2}$/.test(param) ? param : todayZurich();

  const { data: reports, error } = await supabase
    .from("daily_reports")
    .select("user_id, role, metrics, summary, problem, solution")
    .eq("report_date", date);
  if (error) {
    console.error("[rapport] export impossible", error);
    return NextResponse.json({ error: "Export impossible." }, { status: 500 });
  }

  const { data: people } = await supabase
    .from("user_roles")
    .select("user_id, role, active, first_name, last_name");
  const names = new Map(
    (people ?? []).map((p) => [
      p.user_id,
      [p.first_name, p.last_name].filter(Boolean).join(" ") || "Sans nom",
    ])
  );

  const rows = (reports ?? [])
    .map((r) => {
      const metrics = r.metrics as Record<string, number>;
      const rate = SALES_ROLES.includes(r.role) ? conversionRate(metrics) : null;
      return {
        name: names.get(r.user_id) ?? "Ancien collaborateur",
        line: [
          cell(names.get(r.user_id) ?? "Ancien collaborateur"),
          cell(ROLE_LABELS[r.role] ?? r.role),
          ...ALL_FIELDS.map((f) => cell(metrics[f.key])),
          cell(rate === null ? "" : `${rate} %`),
          cell(r.summary),
          cell(r.problem),
          cell(r.solution),
        ].join(";"),
      };
    })
    .sort((a, b) => a.name.localeCompare(b.name, "fr"))
    .map((r) => r.line);

  const allMetrics = (reports ?? []).map(
    (r) => r.metrics as Record<string, number>
  );
  const totals = ALL_FIELDS.map((f) => {
    const values = allMetrics
      .map((m) => m[f.key])
      .filter((v) => typeof v === "number");
    if (values.length === 0) return cell(null);
    const sum = values.reduce((a, b) => a + b, 0);
    // Une note se résume par sa moyenne, pas par sa somme
    return cell(f.decimal ? Math.round((sum / values.length) * 10) / 10 : sum);
  });
  const salesMetrics = (reports ?? [])
    .filter((r) => SALES_ROLES.includes(r.role))
    .map((r) => r.metrics as Record<string, number>);
  const totalHeld = salesMetrics.reduce(
    (a, m) => a + (m.appointments_held ?? 0),
    0
  );
  const totalContracts = salesMetrics.reduce((a, m) => a + (m.contracts ?? 0), 0);
  const totalLine = [
    cell("TOTAL"),
    cell(`${rows.length} rapport(s)`),
    ...totals,
    cell(
      totalHeld > 0 ? `${Math.round((totalContracts / totalHeld) * 100)} %` : ""
    ),
    cell(""),
    cell(""),
    cell(""),
  ].join(";");

  // Personnes actives sans rapport ce jour-là
  const reported = new Set((reports ?? []).map((r) => r.user_id));
  const activeRows = (people ?? []).filter((p) => p.active);
  const missing = Array.from(new Set(activeRows.map((p) => p.user_id)))
    .filter((id) => !reported.has(id))
    .filter((id) => {
      const role = highestRole(activeRows.filter((p) => p.user_id === id));
      return myRole === "admin" ? true : role === "agent" || role === "backoffice";
    })
    .map((id) => names.get(id) ?? "Sans nom")
    .sort((a, b) => a.localeCompare(b, "fr"));
  const missingLines = missing.map((name) =>
    [cell(name), cell("Pas de rapport")].join(";")
  );

  const header = [
    "Personne",
    "Poste",
    ...ALL_FIELDS.map((f) => f.label),
    "Transformation",
    "Journée",
    "Problème",
    "Solution",
  ]
    .map(cell)
    .join(";");

  return new NextResponse(
    `﻿${[header, totalLine, ...rows, ...missingLines].join("\r\n")}\r\n`,
    {
      headers: {
        "Content-Type": "text/csv; charset=utf-8",
        "Content-Disposition": `attachment; filename="rapport-global-klary-${date}.csv"`,
        "Cache-Control": "no-store",
      },
    }
  );
}
