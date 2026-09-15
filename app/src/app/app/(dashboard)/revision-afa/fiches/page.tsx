import Link from "next/link";
import { createSupabaseServerClient } from "@/lib/supabase/server";

export const metadata = { title: "Fiches mémoire AFA" };

export default async function FichesPage({
  searchParams,
}: {
  searchParams: { filiere?: string };
}) {
  const supabase = createSupabaseServerClient();
  const filiereKey = searchParams.filiere || "maladie_complementaire";

  const { data: fiches } = await supabase
    .from("afa_fiches")
    .select("id, key, title, summary, content_md")
    .eq("filiere_key", filiereKey)
    .eq("active", true)
    .order("sort_order");

  return (
    <div className="max-w-3xl mx-auto p-6 md:p-10">
      <header className="mb-8">
        <Link
          href={`/revision-afa?filiere=${filiereKey}`}
          className="text-sm text-klary-grey hover:text-klary-navy"
        >
          ← Révision AFA
        </Link>
        <h1 className="text-3xl font-bold text-klary-navy mt-3">
          Fiches mémoire
        </h1>
        <p className="text-klary-grey mt-2">
          À relire juste avant l&apos;épreuve. Aucun matériel n&apos;est autorisé
          pendant l&apos;examen.
        </p>
      </header>

      {!fiches?.length && (
        <p className="text-klary-grey">Aucune fiche pour cette filière.</p>
      )}

      <div className="space-y-6">
        {(fiches ?? []).map((f) => (
          <article
            key={f.id}
            className="rounded-2xl border border-klary-light-grey bg-white p-6"
          >
            <h2 className="text-xl font-bold text-klary-navy mb-1">
              {f.title}
            </h2>
            {f.summary && (
              <p className="text-sm text-klary-grey mb-4">{f.summary}</p>
            )}
            <Markdown source={f.content_md} />
          </article>
        ))}
      </div>
    </div>
  );
}

/**
 * Rendu Markdown minimal — titres, listes, gras, tableaux simples.
 * Volontairement sans dépendance : le contenu des fiches est maîtrisé
 * en interne, il ne provient pas d'une saisie utilisateur libre.
 */
function Markdown({ source }: { source: string }) {
  const lines = source.split("\n");
  const blocks: React.ReactNode[] = [];
  let list: string[] = [];

  const flushList = (key: number) => {
    if (!list.length) return;
    blocks.push(
      <ul key={`ul-${key}`} className="list-disc pl-5 space-y-1 my-3">
        {list.map((li, i) => (
          <li key={i} className="text-sm text-klary-ink">
            {inline(li)}
          </li>
        ))}
      </ul>
    );
    list = [];
  };

  lines.forEach((raw, i) => {
    const line = raw.trimEnd();
    if (line.startsWith("- ")) {
      list.push(line.slice(2));
      return;
    }
    flushList(i);
    if (!line.trim()) return;
    if (line.startsWith("### ")) {
      blocks.push(
        <h3 key={i} className="font-bold text-klary-navy mt-5 mb-2">
          {inline(line.slice(4))}
        </h3>
      );
    } else if (line.startsWith("## ")) {
      blocks.push(
        <h2 key={i} className="text-lg font-bold text-klary-navy mt-6 mb-2">
          {inline(line.slice(3))}
        </h2>
      );
    } else {
      blocks.push(
        <p key={i} className="text-sm text-klary-ink my-2">
          {inline(line)}
        </p>
      );
    }
  });
  flushList(lines.length);

  return <div>{blocks}</div>;
}

/** Gras **texte** uniquement. */
function inline(text: string): React.ReactNode {
  const parts = text.split(/(\*\*[^*]+\*\*)/g);
  return parts.map((p, i) =>
    p.startsWith("**") && p.endsWith("**") ? (
      <strong key={i} className="font-semibold text-klary-navy">
        {p.slice(2, -2)}
      </strong>
    ) : (
      <span key={i}>{p}</span>
    )
  );
}
