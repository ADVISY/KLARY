import { AfaRunner } from "@/components/afa/AfaRunner";

export const metadata = { title: "Quiz AFA" };

export default function QuizThemePage({
  params,
  searchParams,
}: {
  params: { theme: string };
  searchParams: { filiere?: string };
}) {
  const filiere = searchParams.filiere || "maladie_complementaire";
  const isPieges = params.theme === "pieges";

  return (
    <AfaRunner
      filiereKey={filiere}
      mode={isPieges ? "pieges" : "drill"}
      themeKey={isPieges ? undefined : params.theme}
      title={isPieges ? "Les pièges" : "Quiz thématique"}
      backHref={`/revision-afa?filiere=${filiere}`}
    />
  );
}
