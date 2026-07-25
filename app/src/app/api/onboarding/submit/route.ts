import { NextRequest, NextResponse } from "next/server";
import { createServerClient } from "@supabase/ssr";
import { cookies } from "next/headers";
import { z } from "zod";
import {
  sendEmail,
  COMPTABLE_EMAILS,
  ADMIN_EMAIL,
  OFFICE_EMAILS,
} from "@/lib/resend/client";
import { templates } from "@/lib/resend/templates";

/**
 * POST /api/onboarding/submit
 *
 * Public — protégé par token secret (form_token). Aucune auth requise.
 * Reçoit FormData avec :
 *   - token (UUID form_token)
 *   - champs personnels (identity, address, bank, tax, prevoyance, urgence)
 *   - fichiers uploadés (id_document, avs_card, rib, permis_sejour, lpp_exit)
 * Actions :
 *   1. Vérifie que le form n'a pas déjà été soumis
 *   2. Upload docs sur bucket onboarding-docs
 *   3. Sauvegarde form_data + uploaded_docs
 *   4. Envoie email récap au comptable + confirmation candidat
 */

const MAX_FILE_SIZE = 5 * 1024 * 1024; // 5 Mo
const ACCEPTED_TYPES = [
  "application/pdf",
  "image/jpeg",
  "image/jpg",
  "image/png",
  "application/msword",
  "application/vnd.openxmlformats-officedocument.wordprocessingml.document",
];

const DOC_KEYS = [
  { key: "id_document", label: "Carte d'identité / passeport" },
  { key: "avs_card", label: "Carte AVS" },
  { key: "rib", label: "RIB / relevé bancaire" },
  { key: "permis_sejour", label: "Permis de séjour" },
  { key: "lpp_exit", label: "Certificat de sortie LPP" },
] as const;

const schema = z.object({
  token: z.string().uuid(),
  // Identité
  date_of_birth: z.string().regex(/^\d{4}-\d{2}-\d{2}$/, "Date invalide"),
  nationality: z.string().min(1).max(100),
  marital_status: z.enum([
    "celibataire",
    "marie",
    "pacs",
    "divorce",
    "veuf",
  ]),
  avs_number: z.string().min(1).max(20),
  children_count: z.string().optional().or(z.literal("")),
  residence_permit: z.string().max(100).optional().or(z.literal("")),
  // Parents (optionnels — pour dossier RH complet)
  father_first_name: z.string().max(100).optional().or(z.literal("")),
  father_last_name: z.string().max(100).optional().or(z.literal("")),
  mother_first_name: z.string().max(100).optional().or(z.literal("")),
  mother_last_name: z.string().max(100).optional().or(z.literal("")),
  // Adresse actuelle en Suisse
  postal_street: z.string().min(1).max(200),
  postal_zip: z.string().min(4).max(10),
  postal_city: z.string().min(1).max(100),
  postal_canton: z.string().min(2).max(2),
  // Adresse à l'étranger (optionnelle — pour employés étrangers)
  foreign_street: z.string().max(200).optional().or(z.literal("")),
  foreign_city: z.string().max(150).optional().or(z.literal("")),
  foreign_country: z.string().max(100).optional().or(z.literal("")),
  // Banque
  bank_iban: z.string().min(15).max(40),
  bank_name: z.string().min(1).max(100),
  bank_holder: z.string().min(1).max(200),
  // Fiscalité
  religion: z.string().max(50).optional().or(z.literal("")),
  spouse_working: z.enum(["oui", "non", "sans_objet"]).optional(),
  spouse_income: z.string().max(50).optional().or(z.literal("")),
  // Prévoyance
  prev_lpp_fund: z.string().max(200).optional().or(z.literal("")),
  prev_lpp_id: z.string().max(100).optional().or(z.literal("")),
  libre_passage: z.string().max(200).optional().or(z.literal("")),
  // Contact urgence
  emergency_name: z.string().min(1).max(200),
  emergency_relation: z.string().min(1).max(100),
  emergency_phone: z.string().min(1).max(50),
  // Consentement
  consent: z.union([z.literal("on"), z.literal("true"), z.boolean()]),
});

export async function POST(request: NextRequest) {
  try {
    const formData = await request.formData();
    const parsed = schema.safeParse({
      token: formData.get("token"),
      date_of_birth: formData.get("date_of_birth"),
      nationality: formData.get("nationality"),
      marital_status: formData.get("marital_status"),
      avs_number: formData.get("avs_number"),
      children_count: formData.get("children_count") || "",
      residence_permit: formData.get("residence_permit") || "",
      father_first_name: formData.get("father_first_name") || "",
      father_last_name: formData.get("father_last_name") || "",
      mother_first_name: formData.get("mother_first_name") || "",
      mother_last_name: formData.get("mother_last_name") || "",
      postal_street: formData.get("postal_street"),
      postal_zip: formData.get("postal_zip"),
      postal_city: formData.get("postal_city"),
      postal_canton: formData.get("postal_canton"),
      foreign_street: formData.get("foreign_street") || "",
      foreign_city: formData.get("foreign_city") || "",
      foreign_country: formData.get("foreign_country") || "",
      bank_iban: formData.get("bank_iban"),
      bank_name: formData.get("bank_name"),
      bank_holder: formData.get("bank_holder"),
      religion: formData.get("religion") || "",
      spouse_working: formData.get("spouse_working") || undefined,
      spouse_income: formData.get("spouse_income") || "",
      prev_lpp_fund: formData.get("prev_lpp_fund") || "",
      prev_lpp_id: formData.get("prev_lpp_id") || "",
      libre_passage: formData.get("libre_passage") || "",
      emergency_name: formData.get("emergency_name"),
      emergency_relation: formData.get("emergency_relation"),
      emergency_phone: formData.get("emergency_phone"),
      consent: formData.get("consent"),
    });

    if (!parsed.success) {
      return NextResponse.json(
        { error: "Données invalides", details: parsed.error.flatten() },
        { status: 400 }
      );
    }

    // Client service_role (bypass RLS)
    const cookieStore = cookies();
    const supabase = createServerClient(
      process.env.NEXT_PUBLIC_SUPABASE_URL!,
      process.env.SUPABASE_SERVICE_ROLE_KEY!,
      {
        cookies: {
          getAll: () => cookieStore.getAll(),
          setAll: () => {},
        },
      }
    );

    // Charger le formulaire par token
    const { data: onbForm, error: fetchErr } = await supabase
      .from("onboarding_forms")
      .select("id, candidate_id, form_token, submitted_at")
      .eq("form_token", parsed.data.token)
      .maybeSingle();

    if (fetchErr || !onbForm) {
      return NextResponse.json(
        { error: "Lien invalide ou expiré." },
        { status: 404 }
      );
    }

    if (onbForm.submitted_at) {
      return NextResponse.json(
        {
          error: "Ce formulaire a déjà été soumis.",
          alreadySubmitted: true,
        },
        { status: 409 }
      );
    }

    // Charger le candidat pour son nom/email
    const { data: candidate } = await supabase
      .from("candidates")
      .select("first_name, last_name, email, position_applied")
      .eq("id", onbForm.candidate_id)
      .maybeSingle();

    if (!candidate) {
      return NextResponse.json(
        { error: "Candidature associée introuvable." },
        { status: 404 }
      );
    }

    // ─── Upload documents (tous optionnels sauf ID + RIB) ───
    const now = Date.now();
    const year = new Date().getFullYear();
    const safeSlug = `${candidate.last_name}_${candidate.first_name}_${now}`
      .replace(/[^a-zA-Z0-9._-]/g, "_")
      .toLowerCase();

    const uploadedDocs: any[] = [];
    const uploadedPaths: string[] = [];

    for (const { key } of DOC_KEYS) {
      const f = formData.get(`doc_${key}`) as File | null;
      if (!f || f.size === 0) continue;

      if (f.size > MAX_FILE_SIZE) {
        // Cleanup ce qu'on a déjà uploadé
        if (uploadedPaths.length > 0) {
          await supabase.storage.from("onboarding-docs").remove(uploadedPaths);
        }
        return NextResponse.json(
          { error: `Fichier '${key}' trop lourd (max 5 Mo)` },
          { status: 400 }
        );
      }
      if (!ACCEPTED_TYPES.includes(f.type)) {
        if (uploadedPaths.length > 0) {
          await supabase.storage.from("onboarding-docs").remove(uploadedPaths);
        }
        return NextResponse.json(
          { error: `Type de fichier '${key}' non accepté (PDF/DOC/JPG/PNG)` },
          { status: 400 }
        );
      }

      const ext = f.name.split(".").pop() || "pdf";
      const path = `${year}/${safeSlug}_${key}.${ext}`.toLowerCase();
      const buf = await f.arrayBuffer();

      const { error: upErr } = await supabase.storage
        .from("onboarding-docs")
        .upload(path, buf, { contentType: f.type, upsert: false });

      if (upErr) {
        console.error(`Upload ${key} error:`, upErr);
        if (uploadedPaths.length > 0) {
          await supabase.storage.from("onboarding-docs").remove(uploadedPaths);
        }
        return NextResponse.json(
          {
            error: `Erreur lors de l'upload du document '${key}'`,
            details: upErr.message,
          },
          { status: 500 }
        );
      }

      uploadedPaths.push(path);
      uploadedDocs.push({
        key,
        filename: f.name,
        storage_path: path,
        size_bytes: f.size,
      });
    }

    // ─── Sauvegarde du formulaire ───
    const { consent, token, ...formPayload } = parsed.data;
    const { error: updateErr } = await supabase
      .from("onboarding_forms")
      .update({
        submitted_at: new Date().toISOString(),
        form_data: formPayload,
        uploaded_docs: uploadedDocs,
      })
      .eq("id", onbForm.id);

    if (updateErr) {
      console.error("[onboarding/submit] update échec:", updateErr);
      // Cleanup docs si update DB échoue
      if (uploadedPaths.length > 0) {
        await supabase.storage.from("onboarding-docs").remove(uploadedPaths);
      }
      return NextResponse.json(
        { error: "Erreur d'enregistrement" },
        { status: 500 }
      );
    }

    // ─── Générer signed URLs pour l'email comptable ───
    const docsInfo: {
      key: string;
      label: string;
      url: string | null;
      filename?: string;
    }[] = [];
    for (const dk of DOC_KEYS) {
      const uploaded = uploadedDocs.find((d) => d.key === dk.key);
      if (uploaded) {
        const { data: sig } = await supabase.storage
          .from("onboarding-docs")
          .createSignedUrl(uploaded.storage_path, 3600);
        docsInfo.push({
          key: dk.key,
          label: dk.label,
          url: sig?.signedUrl || null,
          filename: uploaded.filename,
        });
      } else {
        docsInfo.push({
          key: dk.key,
          label: dk.label,
          url: null,
        });
      }
    }

    const appUrl =
      process.env.NEXT_PUBLIC_APP_URL || "https://app.klary.ch";
    const dashboardUrl = `${appUrl}/admin/candidatures/${onbForm.candidate_id}`;

    // ─── Email comptable (destinataire principal) + admin + office en CC ───
    // Admin + office reçoivent le récap complet AVEC les liens signés vers
    // les documents, dans le même message que le comptable — pas de mail
    // séparé, tout le monde a la même vision d'un coup.
    const ccList = [ADMIN_EMAIL, ...OFFICE_EMAILS].filter(
      (e) => !COMPTABLE_EMAILS.includes(e)
    );

    sendEmail({
      to: COMPTABLE_EMAILS,
      cc: ccList.length > 0 ? ccList : undefined,
      subject: `[Onboarding] Dossier reçu — ${candidate.first_name} ${candidate.last_name}`,
      html: templates.onboardingReceivedByComptable({
        firstName: candidate.first_name,
        lastName: candidate.last_name,
        email: candidate.email,
        positionApplied: candidate.position_applied || undefined,
        formData: formPayload,
        docsInfo,
        dashboardUrl,
      }),
    })
      .then(() => {
        // Marquer notifié
        supabase
          .from("onboarding_forms")
          .update({ comptable_notified_at: new Date().toISOString() })
          .eq("id", onbForm.id)
          .then(() => {});
      })
      .catch((err) =>
        console.error("[onboarding/submit] Failed comptable email:", err)
      );

    // ─── Confirmation candidat ───
    sendEmail({
      to: candidate.email,
      subject: "Votre dossier d'onboarding est bien reçu — Klary",
      html: templates.onboardingConfirmation({
        firstName: candidate.first_name,
      }),
    }).catch((err) =>
      console.error("Failed onboarding candidat confirm:", err)
    );

    return NextResponse.json({ success: true });
  } catch (error: any) {
    console.error("onboarding/submit POST:", error);
    return NextResponse.json(
      { error: "Erreur serveur", details: error?.message },
      { status: 500 }
    );
  }
}
