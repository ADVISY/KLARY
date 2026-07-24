import { corsHeaders } from "https://esm.sh/@supabase/supabase-js@2.95.0/cors";

interface DocItem {
  type: string;
  name: string;
  path: string;
  size: number;
}

interface Payload {
  applicationId: string;
  data: Record<string, any>;
  documents: DocItem[];
}

const HR_EMAIL = "info@klary.ch";
const FROM = "Klary Recrutement <onboarding@resend.dev>";

Deno.serve(async (req) => {
  if (req.method === "OPTIONS") return new Response("ok", { headers: corsHeaders });

  try {
    const RESEND_API_KEY = Deno.env.get("RESEND_API_KEY");
    const LOVABLE_API_KEY = Deno.env.get("LOVABLE_API_KEY");
    if (!RESEND_API_KEY || !LOVABLE_API_KEY) {
      throw new Error("Missing API keys");
    }

    const { applicationId, data, documents } = (await req.json()) as Payload;
    if (!applicationId || !data?.email) {
      return new Response(JSON.stringify({ error: "Invalid payload" }), {
        status: 400,
        headers: { ...corsHeaders, "Content-Type": "application/json" },
      });
    }

    const row = (label: string, val: any) =>
      val === null || val === undefined || val === "" || val === false
        ? ""
        : `<tr><td style="padding:6px 12px;color:#666;font-size:13px;">${label}</td><td style="padding:6px 12px;font-size:13px;"><strong>${
            val === true ? "✅ Oui" : String(val)
          }</strong></td></tr>`;

    // Download every document from storage and convert to base64 attachments
    const SUPABASE_URL = Deno.env.get("SUPABASE_URL")!;
    const SERVICE_KEY = Deno.env.get("SUPABASE_SERVICE_ROLE_KEY")!;

    const attachments: { filename: string; content: string }[] = [];
    const failedDocs: string[] = [];

    for (const d of documents) {
      try {
        const r = await fetch(
          `${SUPABASE_URL}/storage/v1/object/${d.path.startsWith("recruitment-docs/") ? d.path : `recruitment-docs/${d.path}`}`,
          { headers: { Authorization: `Bearer ${SERVICE_KEY}`, apikey: SERVICE_KEY } },
        );
        if (!r.ok) {
          console.error(`Failed to fetch ${d.path}: ${r.status}`);
          failedDocs.push(d.name);
          continue;
        }
        const buf = new Uint8Array(await r.arrayBuffer());
        // Base64 encode in chunks to avoid stack overflow
        let binary = "";
        const chunk = 0x8000;
        for (let i = 0; i < buf.length; i += chunk) {
          binary += String.fromCharCode(...buf.subarray(i, i + chunk));
        }
        const b64 = btoa(binary);
        const safeType = d.type.replace(/[^a-zA-Z0-9_-]/g, "_");
        attachments.push({ filename: `${safeType}_${d.name}`, content: b64 });
      } catch (err) {
        console.error(`Attachment error for ${d.path}:`, err);
        failedDocs.push(d.name);
      }
    }

    const docsHtml = documents.length
      ? `<h3 style="margin-top:24px;color:#2457FF;">📎 Documents joints (${attachments.length}/${documents.length})</h3>
         <ul style="font-size:13px;line-height:1.8;">${documents
           .map((d) => `<li><strong>${d.type}</strong> — ${d.name} (${(d.size / 1024).toFixed(0)} Ko)</li>`)
           .join("")}</ul>
         ${failedDocs.length ? `<p style="font-size:12px;color:#c00;">⚠️ Échec pièces jointes : ${failedDocs.join(", ")}</p>` : ""}`
      : "";

    const html = `
      <div style="font-family:Inter,Arial,sans-serif;max-width:680px;margin:0 auto;padding:24px;background:#f7f7f9;">
        <div style="background:linear-gradient(135deg,#2457FF,#6B5BFF);color:#fff;padding:24px;border-radius:12px 12px 0 0;">
          <h1 style="margin:0;font-size:22px;">🚀 Nouvelle candidature Klary</h1>
          <p style="margin:8px 0 0;opacity:.9;">${data.first_name} ${data.last_name} — ${data.position_sought || "Poste non précisé"}</p>
        </div>
        <div style="background:#fff;padding:24px;border-radius:0 0 12px 12px;">
          <h3 style="color:#2457FF;margin-top:0;">👤 Identité</h3>
          <table style="width:100%;border-collapse:collapse;">
            ${row("Nom", `${data.last_name} ${data.first_name}`)}
            ${row("Date de naissance", data.birth_date)}
            ${row("Nationalité", data.nationality)}
            ${row("Permis de séjour", data.permit_type)}
            ${row("État civil", data.civil_status)}
            ${row("Adresse", `${data.address || ""}, ${data.postal_code || ""} ${data.city || ""} (${data.canton || "?"})`)}
          </table>

          <h3 style="color:#2457FF;">📞 Contact</h3>
          <table style="width:100%;border-collapse:collapse;">
            ${row("Email", data.email)}
            ${row("Téléphone", data.phone)}
            ${row("Mobile", data.mobile)}
          </table>

          <h3 style="color:#2457FF;">💼 Profil professionnel</h3>
          <table style="width:100%;border-collapse:collapse;">
            ${row("Poste visé", data.position_sought)}
            ${row("Statut FINMA", data.finma_status)}
            ${row("N° FINMA", data.finma_number)}
            ${row("Années d'expérience", data.years_experience)}
            ${row("Employeur actuel", data.current_employer)}
            ${row("Disponibilité", data.availability)}
            ${row("Prétentions salariales", data.salary_expectation)}
          </table>

          <h3 style="color:#2457FF;">🎓 Formation & langues</h3>
          <table style="width:100%;border-collapse:collapse;">
            ${row("Diplôme le plus élevé", data.highest_diploma)}
            ${row("Langues", Array.isArray(data.languages) ? data.languages.map((l: any) => `${l.language} (${l.level})`).join(", ") : "")}
          </table>

          <h3 style="color:#2457FF;">🚗 Mobilité</h3>
          <table style="width:100%;border-collapse:collapse;">
            ${row("Permis de conduire", data.driving_license)}
            ${row("Véhicule personnel", data.has_vehicle)}
            ${row("Cantons couverts", Array.isArray(data.cantons_covered) ? data.cantons_covered.join(", ") : "")}
          </table>

          <h3 style="color:#2457FF;">📋 Déclarations sur l'honneur</h3>
          <table style="width:100%;border-collapse:collapse;">
            ${row("Casier judiciaire à jour", data.criminal_record_clean)}
            ${row("Extrait poursuites à jour", data.debt_record_clean)}
            ${row("AFA à jour", data.afa_up_to_date)}
          </table>

          <h3 style="color:#2457FF;">💬 Motivation</h3>
          <p style="font-size:13px;background:#f4f6ff;padding:12px;border-radius:8px;"><strong>Pourquoi Klary :</strong><br>${(data.why_advisy || "—").replace(/\n/g, "<br>")}</p>
          <p style="font-size:13px;background:#f4f6ff;padding:12px;border-radius:8px;"><strong>Message :</strong><br>${(data.message || "—").replace(/\n/g, "<br>")}</p>

          ${docsHtml}

          <p style="margin-top:24px;font-size:11px;color:#aaa;border-top:1px solid #eee;padding-top:12px;">
            ID candidature : ${applicationId}<br>
            Reçue le ${new Date().toLocaleString("fr-CH")}
          </p>
        </div>
      </div>
    `;

    const res = await fetch("https://connector-gateway.lovable.dev/resend/emails", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        Authorization: `Bearer ${LOVABLE_API_KEY}`,
        "X-Connection-Api-Key": RESEND_API_KEY,
      },
      body: JSON.stringify({
        from: FROM,
        to: [HR_EMAIL],
        reply_to: data.email,
        subject: `🚀 Candidature — ${data.first_name} ${data.last_name} (${data.position_sought || "Spontanée"})`,
        html,
        attachments,
      }),
    });

    const result = await res.json();
    if (!res.ok) {
      console.error("Resend error:", result);
      return new Response(JSON.stringify({ error: result }), {
        status: 502,
        headers: { ...corsHeaders, "Content-Type": "application/json" },
      });
    }

    return new Response(JSON.stringify({ success: true }), {
      headers: { ...corsHeaders, "Content-Type": "application/json" },
    });
  } catch (e: any) {
    console.error(e);
    return new Response(JSON.stringify({ error: e.message }), {
      status: 500,
      headers: { ...corsHeaders, "Content-Type": "application/json" },
    });
  }
});
