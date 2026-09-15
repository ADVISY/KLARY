import { AfaRunner } from "@/components/afa/AfaRunner";

export const metadata = { title: "Simulation examen AFA" };

export default function SimulationPage({
  searchParams,
}: {
  searchParams: { filiere?: string };
}) {
  const filiere = searchParams.filiere || "maladie_complementaire";
  return (
    <AfaRunner
      filiereKey={filiere}
      mode="simulation"
      title="Simulation examen"
      backHref={`/revision-afa?filiere=${filiere}`}
    />
  );
}
