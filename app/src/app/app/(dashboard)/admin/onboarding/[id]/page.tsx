import { redirect, notFound } from "next/navigation";
import Link from "next/link";
import { createServerClient } from "@supabase/ssr";
import { cookies } from "next/headers";
import { createSupabaseServerClient } from "@/lib/supabase/server";

export const metadata = {
  title: "Dossier d'onboarding — Admin",
};

const DOC_LABELS: Record<string, string> = {
  id_document: "Carte d'identité",
  passport: "Passeport",
  avs_card: "Carte AVS",
  rib: "RIB / relevé bancaire",
  permis_sejour: "Permis de séjour",
  permis_conduire: "Permis de conduire",
  photo_badge: "Photo identité (badge)",
  casier_judiciaire: "Extrait de casier judiciaire",
  poursuites: "Extrait de l'office des poursuites",
  acte_mariage: "Acte de mariage",
  jugement_divorce: "Jugement de divorce",
  lpp_exit: "Certificat de sortie LPP",
};

const SITUATION_LABELS: Record<string, string> = {
  salarie: "Salarié·e",
  indemnites: "Perçoit indemnités d'assurance",
  independant: "Indépendant·e",
  sans_activite: "Sans activité lucrative",
  sans_objet: "Sans objet",
};

const MARITAL_LABELS: Record<string, string> = {
  celibataire: "Célibataire",
  marie: "Marié·e",
  pacs: "Partenariat enregistré / Concubinage",
  divorce: "Divorcé·e",
  veuf: "Veuf·ve",
};

const GENDER_LABELS: Record<string, string> = {
  M: "Masculin",
  F: "Féminin",
  autre: "Autre / non précisé",
};

function formatFileSize(bytes: number): string {
  if (bytes < 1024) return `${bytes} o`;
  if (bytes < 1024 * 1024) return `${(bytes / 1024).toFixed(0)} Ko`;
  return `${(bytes / (1024 * 1024)).toFixed(1)} Mo`;
}

export default async function AdminOnboardingDetail({
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
  if (role?.role !== "admin" && role?.role !== "manager")
    redirect("/formation");

  // Le paramètre [id] peut être soit l'UUID de l'onboarding_form,
  // soit le candidate_id — on tente les 2.
  let { data: onboarding } = await supabase
    .from("onboarding_forms")
    .select("*")
    .eq("id", params.id)
    .maybeSingle();
  if (!onboarding) {
    ({ data: onboarding } = await supabase
      .from("onboarding_forms")
      .select("*")
      .eq("candidate_id", params.id)
      .order("created_at", { ascending: false })
      .limit(1)
      .maybeSingle());
  }

  if (!onboarding) notFound();

  const { data: candidate } = await supabase
    .from("candidates")
    .select("*")
    .eq("id", onboarding.candidate_id)
    .maybeSingle();
  if (!candidate) notFound();

  // Signed URLs pour les documents (service_role)
  const cookieStore = cookies();
  const serviceClient = createServerClient(
    process.env.NEXT_PUBLIC_SUPABASE_URL!,
    process.env.SUPABASE_SERVICE_ROLE_KEY!,
    {
      cookies: {
        getAll: () => cookieStore.getAll(),
        setAll: () => {},
      },
    }
  );

  type Doc = {
    key: string;
    filename: string;
    storage_path: string;
    size_bytes: number;
    signedUrl?: string | null;
  };
  const docs: Doc[] = Array.isArray(onboarding.uploaded_docs)
    ? onboarding.uploaded_docs
    : [];
  for (const d of docs) {
    const { data: sig } = await serviceClient.storage
      .from("onboarding-docs")
      .createSignedUrl(d.storage_path, 3600);
    d.signedUrl = sig?.signedUrl || null;
  }

  const fd: any = onboarding.form_data || {};
  let children: any[] = [];
  try {
    children = JSON.parse(fd.children_json || "[]");
  } catch {}

  const submitted = !!onboarding.submitted_at;

  return (
    <div className="max-w-5xl mx-auto p-6 md:p-10">
      <div className="mb-6">
        <Link
          href={`/admin/candidatures/${onboarding.candidate_id}`}
          className="text-sm text-klary-grey hover:text-klary-orange transition"
        >
          ← Retour à la candidature
        </Link>
      </div>

      {/* Header */}
      <div className="bg-white rounded-2xl border border-klary-light-grey p-8 mb-6">
        <div className="text-xs font-bold tracking-widest uppercase text-klary-orange mb-2">
          Dossier d'onboarding
        </div>
        <h1 className="text-3xl font-bold text-klary-navy mb-2">
          {candidate.first_name} {candidate.last_name}
        </h1>
        <div className="text-sm text-klary-grey mb-4">
          {candidate.email}
          {candidate.position_applied && ` · ${candidate.position_applied}`}
        </div>

        <div className="grid grid-cols-2 md:grid-cols-4 gap-3 text-sm">
          <Kpi
            label="Statut"
            value={submitted ? "Soumis" : "En attente"}
            color={submitted ? "green" : "yellow"}
          />
          <Kpi
            label="Créé le"
            value={new Date(onboarding.created_at).toLocaleDateString("fr-CH")}
          />
          <Kpi
            label="Soumis le"
            value={
              onboarding.submitted_at
                ? new Date(onboarding.submitted_at).toLocaleDateString("fr-CH")
                : "—"
            }
            color={submitted ? "green" : undefined}
          />
          <Kpi
            label="Comptable notifié"
            value={
              onboarding.comptable_notified_at
                ? new Date(
                    onboarding.comptable_notified_at
                  ).toLocaleDateString("fr-CH")
                : submitted
                ? "En cours"
                : "—"
            }
            color={onboarding.comptable_notified_at ? "green" : undefined}
          />
        </div>

        {!submitted && (
          <div className="mt-6 p-4 bg-yellow-50 border-l-4 border-yellow-400 rounded">
            <div className="text-sm text-yellow-900">
              ⏳ Le candidat n'a pas encore soumis son dossier. Lien privé
              envoyé par email :
            </div>
            <div className="mt-2 text-xs font-mono text-klary-orange break-all">
              {process.env.NEXT_PUBLIC_APP_URL ||
                "https://app.klary.ch"}
              /onboarding/{onboarding.form_token}
            </div>
          </div>
        )}
      </div>

      {submitted && (
        <>
          {/* Identité */}
          <Card title="Identité" icon="👤">
            <Row label="Date de naissance" value={fd.date_of_birth} />
            <Row
              label="Genre"
              value={GENDER_LABELS[fd.gender] || fd.gender}
            />
            <Row label="Nationalité" value={fd.nationality} />
            <Row
              label="Lieu de naissance"
              value={[fd.birth_city, fd.birth_country]
                .filter(Boolean)
                .join(", ")}
            />
            <Row label="Lieu d'origine (Suisse)" value={fd.place_of_origin} />
            <Row
              label="État civil"
              value={MARITAL_LABELS[fd.marital_status] || fd.marital_status}
            />
            <Row label="N° AVS" value={fd.avs_number} mono />
            <Row label="Permis de séjour" value={fd.residence_permit} />
            <Row
              label="Nombre d'enfants à charge"
              value={fd.children_count || "0"}
            />
          </Card>

          {/* Filiation */}
          <Card title="Filiation" icon="🌳">
            <Row
              label="Père"
              value={[fd.father_first_name, fd.father_last_name]
                .filter(Boolean)
                .join(" ")}
            />
            <Row
              label="Mère (nom de jeune fille)"
              value={[fd.mother_first_name, fd.mother_last_name]
                .filter(Boolean)
                .join(" ")}
            />
          </Card>

          {/* Contact */}
          <Card title="Contact" icon="📞">
            <Row label="Mobile" value={fd.phone_mobile} mono />
            <Row label="Fixe" value={fd.phone_landline} mono />
            <Row label="Email personnel" value={fd.personal_email} />
          </Card>

          {/* Adresse Suisse */}
          <Card title="Adresse actuelle en Suisse" icon="🏠">
            <Row label="Rue" value={fd.postal_street} />
            <Row
              label="NPA + ville"
              value={[fd.postal_zip, fd.postal_city].filter(Boolean).join(" ")}
            />
            <Row label="Canton" value={fd.postal_canton} />
          </Card>

          {/* Adresse étranger — si renseignée */}
          {(fd.foreign_street || fd.foreign_city || fd.foreign_country) && (
            <Card title="Adresse à l'étranger" icon="🌍">
              <Row label="Rue" value={fd.foreign_street} />
              <Row label="Ville / région" value={fd.foreign_city} />
              <Row label="Pays" value={fd.foreign_country} />
            </Card>
          )}

          {/* Permis conduire */}
          <Card title="Permis de conduire" icon="🚗">
            <Row
              label="Possède le permis"
              value={fd.driving_license === "oui" ? "Oui" : "Non"}
            />
            <Row label="Types" value={fd.driving_license_types} />
          </Card>

          {/* Chômage — si oui */}
          {fd.unemployment_status === "oui" && (
            <Card title="Chômage" icon="⚠" highlight="orange">
              <Row label="Actuellement au chômage" value="Oui" />
              <Row
                label="Caisse de chômage"
                value={fd.unemployment_fund_name}
              />
              <Row label="Adresse caisse" value={fd.unemployment_fund_address} />
            </Card>
          )}

          {/* Conjoint — si renseigné */}
          {(fd.spouse_first_name || fd.spouse_last_name) && (
            <Card title="Conjoint / partenaire" icon="💍">
              <Row label="Date de mariage / PACS" value={fd.marriage_date} />
              <Row
                label="Nom complet"
                value={[fd.spouse_first_name, fd.spouse_last_name]
                  .filter(Boolean)
                  .join(" ")}
              />
              <Row label="Date de naissance" value={fd.spouse_dob} />
              <Row label="Nationalité" value={fd.spouse_nationality} />
              <Row label="Permis" value={fd.spouse_permit} />
              <Row
                label="Situation"
                value={
                  SITUATION_LABELS[fd.spouse_situation] || fd.spouse_situation
                }
              />
              <Row label="Depuis" value={fd.spouse_situation_since} />
              <Row label="Taux d'activité" value={fd.spouse_activity_rate} />
              <Row label="Lieu d'activité" value={fd.spouse_activity_location} />
              <Row label="Alloc familiales CH" value={fd.spouse_alloc_ch} />
              <Row
                label="Alloc familiales étranger"
                value={fd.spouse_alloc_foreign}
              />
            </Card>
          )}

          {/* Enfants */}
          {children.length > 0 && (
            <Card title={`Enfants à charge (${children.length})`} icon="👶">
              <div className="col-span-full overflow-x-auto">
                <table className="w-full text-sm">
                  <thead className="border-b border-klary-light-grey">
                    <tr>
                      <th className="text-left py-2 px-2 text-xs uppercase text-klary-grey font-bold">Nom</th>
                      <th className="text-left py-2 px-2 text-xs uppercase text-klary-grey font-bold">Prénom</th>
                      <th className="text-left py-2 px-2 text-xs uppercase text-klary-grey font-bold">DOB</th>
                      <th className="text-left py-2 px-2 text-xs uppercase text-klary-grey font-bold">Parenté</th>
                      <th className="text-left py-2 px-2 text-xs uppercase text-klary-grey font-bold">Domicile</th>
                    </tr>
                  </thead>
                  <tbody>
                    {children.map((c: any, i: number) => (
                      <tr
                        key={i}
                        className="border-b border-klary-light-grey/50 last:border-0"
                      >
                        <td className="py-2 px-2 text-klary-navy">{c.last_name || "—"}</td>
                        <td className="py-2 px-2 text-klary-navy">{c.first_name || "—"}</td>
                        <td className="py-2 px-2 text-klary-grey">{c.dob || "—"}</td>
                        <td className="py-2 px-2 text-klary-grey">{c.relation || "—"}</td>
                        <td className="py-2 px-2 text-klary-grey text-xs">{c.address || "—"}</td>
                      </tr>
                    ))}
                  </tbody>
                </table>
                <div className="mt-3 text-xs text-klary-grey">
                  Demande alloc familiales : <strong>{fd.requests_family_allowances || "—"}</strong>
                  {" · "}
                  2ᵉ activité lucrative : <strong>{fd.secondary_activity || "—"}</strong>
                  {fd.secondary_activity_rate && ` (${fd.secondary_activity_rate}%)`}
                </div>
              </div>
            </Card>
          )}

          {/* Banque */}
          <Card title="Banque (virement salaire)" icon="🏦">
            <Row label="IBAN" value={fd.bank_iban} mono />
            <Row label="Nom banque" value={fd.bank_name} />
            <Row label="Titulaire compte" value={fd.bank_holder} />
            <Row label="Localité banque" value={fd.bank_locality} />
            <Row
              label="Bulletins salaire par email"
              value={fd.authorize_email_payslip === "on" ? "Autorisé" : "Refusé"}
            />
          </Card>

          {/* Fiscalité */}
          <Card title="Fiscalité" icon="📋">
            <Row label="Confession" value={fd.religion} />
            <Row label="Conjoint travaille" value={fd.spouse_working} />
            <Row
              label="Salaire brut annuel conjoint"
              value={fd.spouse_income}
            />
          </Card>

          {/* Prévoyance */}
          <Card title="Prévoyance (2ᵉ pilier)" icon="🏦">
            <Row label="Caisse LPP précédente" value={fd.prev_lpp_fund} />
            <Row label="N° affiliation sortie" value={fd.prev_lpp_id} />
            <Row label="Compte de libre passage" value={fd.libre_passage} />
          </Card>

          {/* Contact urgence */}
          <Card title="Contact d'urgence" icon="🚨">
            <Row label="Nom" value={fd.emergency_name} />
            <Row label="Lien" value={fd.emergency_relation} />
            <Row label="Téléphone" value={fd.emergency_phone} mono />
          </Card>

          {/* Documents */}
          <Card title={`Documents transmis (${docs.length})`} icon="📎">
            <div className="col-span-full space-y-2">
              {docs.length === 0 && (
                <p className="text-sm text-klary-grey italic">
                  Aucun document transmis.
                </p>
              )}
              {docs.map((d) => (
                <div
                  key={d.storage_path}
                  className="flex items-center justify-between gap-4 p-3 border border-klary-light-grey rounded-xl bg-white"
                >
                  <div className="min-w-0 flex-1">
                    <div className="font-semibold text-klary-navy text-sm">
                      {DOC_LABELS[d.key] || d.key}
                    </div>
                    <div className="text-xs text-klary-grey mt-0.5 truncate">
                      {d.filename} · {formatFileSize(d.size_bytes)}
                    </div>
                  </div>
                  {d.signedUrl && (
                    <div className="flex items-center gap-2 shrink-0">
                      <a
                        href={d.signedUrl}
                        target="_blank"
                        rel="noopener noreferrer"
                        className="px-3 py-1.5 text-xs font-semibold text-klary-navy border border-klary-navy/20 rounded-lg hover:bg-klary-navy/5"
                      >
                        Voir
                      </a>
                      <a
                        href={d.signedUrl}
                        download={d.filename}
                        className="px-3 py-1.5 text-xs font-semibold text-white bg-klary-navy rounded-lg hover:bg-klary-navy/90"
                      >
                        Télécharger
                      </a>
                    </div>
                  )}
                </div>
              ))}
              <p className="text-xs text-klary-grey italic mt-2">
                Liens de téléchargement valables 1 heure. Rechargez la page
                pour régénérer.
              </p>
            </div>
          </Card>

          {/* Dates de validité récap */}
          {(fd.id_valid_until ||
            fd.passport_valid_until ||
            fd.permis_valid_until) && (
            <Card title="Dates de validité (documents)" icon="📅">
              <Row label="Carte d'identité" value={fd.id_valid_until} />
              <Row label="Passeport" value={fd.passport_valid_until} />
              <Row label="Permis de séjour" value={fd.permis_valid_until} />
            </Card>
          )}
        </>
      )}
    </div>
  );
}

function Kpi({
  label,
  value,
  color,
}: {
  label: string;
  value: string;
  color?: "green" | "yellow";
}) {
  const c =
    color === "green"
      ? "text-green-700"
      : color === "yellow"
      ? "text-yellow-700"
      : "text-klary-navy";
  return (
    <div className="p-3 border border-klary-light-grey rounded-lg bg-white">
      <div className="text-[10px] uppercase tracking-widest text-klary-grey font-bold mb-1">
        {label}
      </div>
      <div className={`text-sm font-bold ${c}`}>{value}</div>
    </div>
  );
}

function Card({
  title,
  icon,
  highlight,
  children,
}: {
  title: string;
  icon?: string;
  highlight?: "orange";
  children: React.ReactNode;
}) {
  const border =
    highlight === "orange"
      ? "border-orange-300"
      : "border-klary-light-grey";
  const bg = highlight === "orange" ? "bg-orange-50/30" : "bg-white";
  return (
    <div
      className={`rounded-2xl border ${border} ${bg} p-6 mb-4`}
    >
      <h2 className="font-bold text-klary-navy mb-4 flex items-center gap-2">
        {icon && <span className="text-xl">{icon}</span>}
        {title}
      </h2>
      <div className="grid grid-cols-1 md:grid-cols-2 gap-x-6 gap-y-3">
        {children}
      </div>
    </div>
  );
}

function Row({
  label,
  value,
  mono = false,
}: {
  label: string;
  value?: string | null;
  mono?: boolean;
}) {
  const display = value && String(value).trim() ? String(value) : "—";
  const isEmpty = display === "—";
  return (
    <div>
      <div className="text-[10px] uppercase tracking-widest text-klary-grey font-bold mb-0.5">
        {label}
      </div>
      <div
        className={`text-sm ${
          isEmpty
            ? "text-klary-grey/50 italic"
            : mono
            ? "font-mono text-klary-navy font-semibold"
            : "text-klary-navy font-semibold"
        }`}
      >
        {display}
      </div>
    </div>
  );
}
