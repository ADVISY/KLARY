import { redirect, notFound } from "next/navigation";
import { createSupabaseServerClient } from "@/lib/supabase/server";
import { ConventionSortie } from "@/components/ConventionSortie";
import { PrintClientButton } from "../../../certifications/[certId]/apercu/PrintClientButton";

export const metadata = {
  title: "Convention de sortie — à imprimer",
  robots: "noindex, nofollow",
};

export const dynamic = "force-dynamic";

export default async function ConventionPage({
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
  if (role?.role !== "admin") redirect("/formation");

  const { data: offb } = await supabase
    .from("offboarding_processes")
    .select("*")
    .eq("id", params.id)
    .maybeSingle();
  if (!offb) notFound();

  const lastDay = offb.last_working_day
    ? new Date(offb.last_working_day).toLocaleDateString("fr-CH", {
        day: "numeric",
        month: "long",
        year: "numeric",
      })
    : "";

  return (
    <div className="min-h-screen bg-klary-navy/10 py-10 print:py-0 print:bg-white">
      <div className="max-w-3xl mx-auto mb-6 flex items-center justify-between px-4 print:hidden">
        <div className="text-sm text-klary-grey">
          Imprimer sur papier Klary tamponné, en <strong>2 exemplaires</strong>.
        </div>
        <div className="flex gap-2">
          <a
            href={`/admin/offboarding/${offb.id}`}
            className="px-4 py-2 bg-white border border-klary-light-grey rounded-lg text-sm font-semibold text-klary-navy hover:border-klary-navy"
          >
            Retour
          </a>
          <PrintClientButton />
        </div>
      </div>

      <ConventionSortie
        firstName={offb.first_name || ""}
        lastName={offb.last_name || ""}
        lastWorkingDay={lastDay}
        reason={offb.reason}
      />
    </div>
  );
}
