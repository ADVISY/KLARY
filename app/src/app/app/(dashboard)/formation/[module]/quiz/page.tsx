import { redirect } from "next/navigation";
import { headers } from "next/headers";
import { Quiz } from "@/components/app/Quiz";

export const metadata = {
  title: "Évaluation en cours",
  robots: "noindex, nofollow",
};

// Force le rendering dynamique (session, cookies)
export const dynamic = "force-dynamic";

export default async function QuizPage({
  params,
}: {
  params: { module: string };
}) {
  const headersList = headers();
  const host = headersList.get("host") || "";
  const proto = headersList.get("x-forwarded-proto") || "https";
  const cookie = headersList.get("cookie") || "";

  // Appel serveur-à-serveur pour démarrer l'attempt
  const res = await fetch(`${proto}://${host}/api/training/start`, {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
      cookie,
    },
    body: JSON.stringify({ module_key: params.module }),
    cache: "no-store",
  });

  if (!res.ok) {
    redirect(`/formation/${params.module}?error=start_failed`);
  }

  const data = await res.json();

  return (
    <Quiz
      attemptId={data.attemptId}
      module={data.module}
      questions={data.questions}
    />
  );
}
