import { redirect } from "next/navigation";

// Redirect vers /formation par défaut à la connexion
export default function DashboardHome() {
  redirect("/formation");
}
