/**
 * Templates HTML pour les emails Klary — charte navy + orange + cream.
 * Tous stateless, sans dépendance.
 */

const wrapEmail = (title: string, body: string, cta?: { label: string; url: string }) => `
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>${title}</title>
</head>
<body style="margin:0; padding:0; background:#FAF5EF; font-family:-apple-system,BlinkMacSystemFont,'Segoe UI',sans-serif; color:#1F1B4B;">
  <table role="presentation" width="100%" cellspacing="0" cellpadding="0" style="background:#FAF5EF; padding:40px 20px;">
    <tr>
      <td align="center">
        <table role="presentation" width="600" cellspacing="0" cellpadding="0" style="max-width:600px; background:#fff; border-radius:16px; overflow:hidden; box-shadow:0 4px 20px rgba(26,22,96,0.08);">
          <tr>
            <td style="background:#1A1660; padding:24px 40px;">
              <div style="color:#fff; font-size:22px; font-weight:700; letter-spacing:-0.02em;">KLARY</div>
              <div style="color:rgba(255,255,255,0.6); font-size:10px; font-weight:600; letter-spacing:0.2em; text-transform:uppercase; margin-top:2px;">Courtage en assurance</div>
            </td>
          </tr>
          <tr>
            <td style="background:#F0651F; height:4px;"></td>
          </tr>
          <tr>
            <td style="padding:40px;">
              ${body}
              ${cta ? `
              <div style="margin-top:32px; text-align:center;">
                <a href="${cta.url}" style="display:inline-block; padding:14px 28px; background:#F0651F; color:#fff; text-decoration:none; font-weight:600; border-radius:10px; font-size:14px;">${cta.label}</a>
              </div>` : ""}
            </td>
          </tr>
          <tr>
            <td style="background:#FAF5EF; padding:24px 40px; border-top:1px solid #DDD9E8; font-size:12px; color:#6E6A8E; text-align:center;">
              Klary Sàrl · Route de Lausanne 31 · 1052 Le Mont-sur-Lausanne<br>
              <a href="https://klary.ch" style="color:#F0651F; text-decoration:none;">klary.ch</a>
            </td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
</body>
</html>
`;

export const templates = {
  /**
   * Notification admin — nouveau message de contact reçu depuis le site
   */
  contactAdminNotif({
    firstName,
    lastName,
    email,
    phone,
    subject,
    message,
    dashboardUrl,
  }: {
    firstName: string;
    lastName: string;
    email: string;
    phone?: string;
    subject: string;
    message: string;
    dashboardUrl: string;
  }) {
    return wrapEmail(
      "Nouveau contact via klary.ch",
      `
      <h2 style="color:#1A1660; margin:0 0 8px; font-size:22px;">📩 Nouveau message de contact</h2>
      <p style="color:#6E6A8E; margin:0 0 24px;">Reçu via le formulaire de klary.ch</p>

      <table role="presentation" width="100%" cellspacing="0" cellpadding="0" style="border-collapse:collapse; margin-bottom:20px;">
        <tr><td style="padding:8px 0; color:#6E6A8E; font-size:12px; font-weight:600; text-transform:uppercase; letter-spacing:0.05em;">De</td></tr>
        <tr><td style="padding:0 0 12px; color:#1F1B4B; font-size:16px;"><strong>${firstName} ${lastName}</strong><br><a href="mailto:${email}" style="color:#F0651F;">${email}</a>${phone ? `<br>${phone}` : ""}</td></tr>
        <tr><td style="padding:8px 0; color:#6E6A8E; font-size:12px; font-weight:600; text-transform:uppercase; letter-spacing:0.05em;">Sujet</td></tr>
        <tr><td style="padding:0 0 12px; color:#1F1B4B; font-size:15px;"><strong>${subject}</strong></td></tr>
        <tr><td style="padding:8px 0; color:#6E6A8E; font-size:12px; font-weight:600; text-transform:uppercase; letter-spacing:0.05em;">Message</td></tr>
        <tr><td style="padding:0; color:#1F1B4B; font-size:14px; line-height:1.6; background:#FAF5EF; padding:16px; border-radius:8px; border-left:3px solid #F0651F;">${message.replace(/\n/g, "<br>")}</td></tr>
      </table>
      `,
      { label: "Répondre depuis le backoffice", url: dashboardUrl }
    );
  },

  /**
   * Notification admin — nouvelle candidature reçue
   */
  candidatureAdminNotif({
    firstName,
    lastName,
    email,
    phone,
    positionApplied,
    dashboardUrl,
  }: {
    firstName: string;
    lastName: string;
    email: string;
    phone?: string;
    positionApplied: string;
    dashboardUrl: string;
  }) {
    return wrapEmail(
      "Nouvelle candidature reçue",
      `
      <h2 style="color:#1A1660; margin:0 0 8px; font-size:22px;">📥 Nouvelle candidature</h2>
      <p style="color:#6E6A8E; margin:0 0 24px;">Reçue via klary.ch/postuler</p>

      <table role="presentation" width="100%" cellspacing="0" cellpadding="0">
        <tr><td style="padding:8px 0; color:#6E6A8E; font-size:12px; font-weight:600; text-transform:uppercase; letter-spacing:0.05em;">Candidat</td></tr>
        <tr><td style="padding:0 0 12px; color:#1F1B4B; font-size:16px;"><strong>${firstName} ${lastName}</strong><br><a href="mailto:${email}" style="color:#F0651F;">${email}</a>${phone ? `<br>${phone}` : ""}</td></tr>
        <tr><td style="padding:8px 0; color:#6E6A8E; font-size:12px; font-weight:600; text-transform:uppercase; letter-spacing:0.05em;">Poste visé</td></tr>
        <tr><td style="padding:0 0 12px; color:#1F1B4B; font-size:15px;"><strong>${positionApplied}</strong></td></tr>
      </table>
      <p style="color:#6E6A8E; font-size:13px; margin-top:20px;">Le CV est disponible dans le backoffice.</p>
      `,
      { label: "Voir la candidature", url: dashboardUrl }
    );
  },

  /**
   * Accusé de réception candidat
   */
  candidatureConfirmation({
    firstName,
    positionApplied,
  }: {
    firstName: string;
    positionApplied: string;
  }) {
    return wrapEmail(
      "Votre candidature a bien été reçue — Klary",
      `
      <h2 style="color:#1A1660; margin:0 0 12px; font-size:22px;">Merci ${firstName},</h2>
      <p style="color:#1F1B4B; margin:0 0 16px; font-size:15px; line-height:1.6;">
        Votre candidature pour le poste <strong>${positionApplied}</strong> a bien été reçue.
      </p>
      <p style="color:#1F1B4B; margin:0 0 16px; font-size:15px; line-height:1.6;">
        Notre équipe étudie votre profil et revient vers vous sous <strong>72 heures ouvrées</strong>.
        Si nous souhaitons avancer, Sacha Bacconnier (responsable d'agence) vous recontactera pour un premier échange.
      </p>
      <p style="color:#6E6A8E; margin:24px 0 0; font-size:13px; line-height:1.6;">
        À bientôt,<br>
        <strong style="color:#1A1660;">L'équipe Klary</strong>
      </p>
      `
    );
  },

  /**
   * Accusé de réception contact (auto-response)
   */
  contactConfirmation({ firstName }: { firstName: string }) {
    return wrapEmail(
      "Votre message a bien été reçu — Klary",
      `
      <h2 style="color:#1A1660; margin:0 0 12px; font-size:22px;">Bonjour ${firstName},</h2>
      <p style="color:#1F1B4B; margin:0 0 16px; font-size:15px; line-height:1.6;">
        Merci d'avoir pris contact avec Klary.
      </p>
      <p style="color:#1F1B4B; margin:0 0 16px; font-size:15px; line-height:1.6;">
        Nous avons bien reçu votre message et un de nos conseillers vous répondra sous <strong>24 heures ouvrées</strong>.
      </p>
      <p style="color:#6E6A8E; margin:24px 0 0; font-size:13px; line-height:1.6;">
        À très vite,<br>
        <strong style="color:#1A1660;">L'équipe Klary</strong>
      </p>
      `
    );
  },
};
