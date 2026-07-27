/**
 * Templates HTML pour les emails Klary — charte navy + orange + cream.
 * Tous stateless, sans dépendance.
 *
 * Le logo est référencé en absolu vers /public — la plupart des clients
 * mail affichent les images externes après consentement utilisateur.
 * Le texte "KLARY" en fallback (alt) reste lisible si les images sont
 * bloquées.
 */

const APP_BASE_URL =
  process.env.NEXT_PUBLIC_APP_URL || "https://app.klary.ch";
const LOGO_URL = `${APP_BASE_URL}/klary-logo-color.png`;

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
            <td style="background:#ffffff; padding:28px 40px; border-bottom:1px solid #F0EBE4;">
              <img src="${LOGO_URL}" alt="Klary" width="140" height="47" style="display:block; height:38px; width:auto; border:0; outline:none; text-decoration:none;" />
              <div style="color:#6E6A8E; font-size:10px; font-weight:600; letter-spacing:0.25em; text-transform:uppercase; margin-top:8px;">Courtage en assurance · Suisse</div>
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
            <td style="background:#1A1660; padding:20px 40px;">
              <table role="presentation" width="100%" cellspacing="0" cellpadding="0">
                <tr>
                  <td style="vertical-align:middle;">
                    <div style="color:#ffffff; font-size:13px; font-weight:700; letter-spacing:-0.01em;">Klary Sàrl</div>
                    <div style="color:rgba(255,255,255,0.65); font-size:11px; margin-top:2px;">Route de Lausanne 31 · 1052 Le Mont-sur-Lausanne</div>
                  </td>
                  <td style="text-align:right; vertical-align:middle;">
                    <a href="https://klary.ch" style="color:#F0651F; text-decoration:none; font-size:12px; font-weight:600;">klary.ch →</a>
                  </td>
                </tr>
              </table>
            </td>
          </tr>
        </table>
        <div style="max-width:600px; font-size:10px; color:#A5A2C0; text-align:center; margin-top:16px; line-height:1.5;">
          Email transactionnel automatique. Ne pas répondre.<br>
          Pour toute question : <a href="mailto:contact@klary.ch" style="color:#A5A2C0; text-decoration:underline;">contact@klary.ch</a>
        </div>
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

  /**
   * Refus candidature — email poli et bienveillant
   */
  candidatureRejection({
    firstName,
    positionApplied,
  }: {
    firstName: string;
    positionApplied?: string;
  }) {
    return wrapEmail(
      "Votre candidature — Klary",
      `
      <h2 style="color:#1A1660; margin:0 0 12px; font-size:22px;">Bonjour ${firstName},</h2>
      <p style="color:#1F1B4B; margin:0 0 16px; font-size:15px; line-height:1.6;">
        Nous vous remercions sincèrement pour l'intérêt que vous portez à Klary et pour le temps que vous avez consacré à votre candidature${positionApplied ? ` au poste de <strong>${positionApplied}</strong>` : ""}.
      </p>
      <p style="color:#1F1B4B; margin:0 0 16px; font-size:15px; line-height:1.6;">
        Après étude attentive de votre profil, nous ne sommes malheureusement pas en mesure de donner une suite favorable à votre candidature pour ce poste.
      </p>
      <p style="color:#1F1B4B; margin:0 0 16px; font-size:15px; line-height:1.6;">
        Ce choix ne remet nullement en cause la qualité de votre parcours. Nous conservons votre candidature dans nos dossiers pendant 12 mois — si un poste correspondant à votre profil venait à s'ouvrir, nous reprendrons contact avec vous.
      </p>
      <p style="color:#1F1B4B; margin:0 0 16px; font-size:15px; line-height:1.6;">
        Nous vous souhaitons une pleine réussite dans vos démarches et votre carrière.
      </p>
      <p style="color:#6E6A8E; margin:24px 0 0; font-size:13px; line-height:1.6;">
        Cordialement,<br>
        <strong style="color:#1A1660;">L'équipe Klary</strong>
      </p>
      `
    );
  },

  /**
   * Invitation entretien avec proposition de 3 créneaux
   */
  interviewInvitation({
    firstName,
    positionApplied,
    slotLabels,
    selectionUrl,
  }: {
    firstName: string;
    positionApplied?: string;
    slotLabels: string[]; // 3 labels formatés
    selectionUrl: string;
  }) {
    const slotsHtml = slotLabels
      .map(
        (label, i) => `
      <tr>
        <td style="padding:12px 16px; border:1px solid #DDD9E8; border-radius:8px; background:#FAF5EF;">
          <div style="font-size:11px; color:#6E6A8E; font-weight:600; text-transform:uppercase; letter-spacing:0.05em; margin-bottom:4px;">Option ${i + 1}</div>
          <div style="font-size:15px; color:#1F1B4B; font-weight:600;">${label}</div>
        </td>
      </tr>
      <tr><td style="height:8px;"></td></tr>
    `
      )
      .join("");

    return wrapEmail(
      "Votre entretien chez Klary — choisissez votre créneau",
      `
      <h2 style="color:#1A1660; margin:0 0 12px; font-size:22px;">Bonjour ${firstName},</h2>
      <p style="color:#1F1B4B; margin:0 0 16px; font-size:15px; line-height:1.6;">
        Excellente nouvelle : votre candidature${positionApplied ? ` au poste de <strong>${positionApplied}</strong>` : ""} a retenu toute notre attention.
      </p>
      <p style="color:#1F1B4B; margin:0 0 20px; font-size:15px; line-height:1.6;">
        Nous souhaitons vous rencontrer pour un premier entretien de <strong>30 minutes</strong>. Voici trois créneaux disponibles ces prochains jours — merci de confirmer celui qui vous convient en cliquant sur le bouton ci-dessous.
      </p>

      <table role="presentation" width="100%" cellspacing="0" cellpadding="0" style="margin:24px 0;">
        ${slotsHtml}
      </table>

      <div style="padding:16px 20px; background:#FAF5EF; border-left:4px solid #1A1660; border-radius:8px; margin:20px 0;">
        <div style="font-size:11px; color:#6E6A8E; font-weight:600; text-transform:uppercase; letter-spacing:0.05em; margin-bottom:6px;">📍 Lieu du rendez-vous</div>
        <div style="font-size:14px; color:#1F1B4B; line-height:1.5;">
          <strong>Bureau Klary — Bâtiment Regus</strong><br>
          Route de Crassier 7<br>
          1262 Eysins<br>
          <span style="display:inline-block; margin-top:6px; padding:4px 8px; background:#fff; border:1px dashed #F0651F; border-radius:4px; font-size:12px; color:#1A1660;">
            ℹ Présentez-vous à l'accueil Regus et demandez <strong>Klary</strong>
          </span><br>
          <a href="https://maps.google.com/?q=Route+de+Crassier+7,+1262+Eysins" style="color:#F0651F; font-size:12px; margin-top:6px; display:inline-block;">Itinéraire Google Maps →</a>
        </div>
      </div>

      <p style="color:#6E6A8E; margin:16px 0 24px; font-size:13px; line-height:1.6;">
        L'entretien se tiendra en présentiel à notre bureau. Après confirmation de votre créneau, vous recevrez un email récapitulatif avec une invitation calendrier à importer directement dans votre agenda. Si aucun de ces créneaux ne vous convient, contactez-nous à <a href="mailto:rh@klary.ch" style="color:#F0651F;">rh@klary.ch</a>.
      </p>
      `,
      { label: "Choisir mon créneau", url: selectionUrl }
    );
  },

  /**
   * Confirmation candidat — créneau retenu
   */
  interviewConfirmation({
    firstName,
    slotLabel,
  }: {
    firstName: string;
    slotLabel: string;
  }) {
    return wrapEmail(
      "Votre entretien Klary est confirmé",
      `
      <h2 style="color:#1A1660; margin:0 0 12px; font-size:22px;">Parfait ${firstName},</h2>
      <p style="color:#1F1B4B; margin:0 0 16px; font-size:15px; line-height:1.6;">
        Votre entretien est confirmé au créneau suivant :
      </p>
      <div style="padding:20px; background:#FAF5EF; border-left:4px solid #F0651F; border-radius:8px; margin:20px 0;">
        <div style="font-size:11px; color:#6E6A8E; font-weight:600; text-transform:uppercase; letter-spacing:0.05em; margin-bottom:6px;">📅 Date & heure</div>
        <div style="font-size:18px; color:#1A1660; font-weight:700;">${slotLabel}</div>
      </div>

      <div style="padding:20px; background:#FAF5EF; border-left:4px solid #1A1660; border-radius:8px; margin:20px 0;">
        <div style="font-size:11px; color:#6E6A8E; font-weight:600; text-transform:uppercase; letter-spacing:0.05em; margin-bottom:6px;">📍 Lieu — rendez-vous en présentiel</div>
        <div style="font-size:15px; color:#1F1B4B; line-height:1.6;">
          <strong>Klary Sàrl — Bâtiment Regus</strong><br>
          Route de Crassier 7<br>
          1262 Eysins<br>
          <div style="margin-top:10px; padding:10px 12px; background:#fff; border:1px dashed #F0651F; border-radius:6px; font-size:13px; color:#1A1660;">
            ℹ <strong>À votre arrivée :</strong> présentez-vous à l'accueil Regus au rez-de-chaussée et demandez <strong>Klary</strong>. Sacha Bacconnier viendra vous accueillir.
          </div>
          <a href="https://maps.google.com/?q=Route+de+Crassier+7,+1262+Eysins" style="color:#F0651F; font-size:13px; margin-top:8px; display:inline-block;">Itinéraire Google Maps →</a>
        </div>
      </div>

      <div style="padding:14px 18px; background:#fff; border:1px dashed #F0651F; border-radius:8px; margin:20px 0;">
        <div style="font-size:13px; color:#1F1B4B; line-height:1.5;">
          <strong>📎 Invitation calendrier en pièce jointe</strong><br>
          <span style="color:#6E6A8E; font-size:12px;">
            Cliquez sur le fichier <code>entretien-klary.ics</code> pour l'ajouter automatiquement à votre agenda (Google, Outlook, Apple). L'événement inclut l'adresse cliquable et un rappel automatique 24h + 1h avant.
          </span>
        </div>
      </div>

      <p style="color:#1F1B4B; margin:16px 0; font-size:15px; line-height:1.6;">
        Merci de vous présenter <strong>5 minutes avant l'heure</strong> à l'accueil du bâtiment Regus.
      </p>
      <p style="color:#1F1B4B; margin:0 0 16px; font-size:15px; line-height:1.6;">
        Si un empêchement survient, prévenez-nous dès que possible à <a href="mailto:rh@klary.ch" style="color:#F0651F;">rh@klary.ch</a>.
      </p>
      <p style="color:#6E6A8E; margin:24px 0 0; font-size:13px; line-height:1.6;">
        À très bientôt au bureau,<br>
        <strong style="color:#1A1660;">L'équipe Klary</strong>
      </p>
      `
    );
  },

  /**
   * Notification admin — le candidat a choisi son créneau
   */
  interviewNotifAdmin({
    firstName,
    lastName,
    email,
    positionApplied,
    slotLabel,
    dashboardUrl,
  }: {
    firstName: string;
    lastName: string;
    email: string;
    positionApplied?: string;
    slotLabel: string;
    dashboardUrl: string;
  }) {
    return wrapEmail(
      "Créneau entretien confirmé par le candidat",
      `
      <h2 style="color:#1A1660; margin:0 0 8px; font-size:22px;">📅 Entretien confirmé</h2>
      <p style="color:#6E6A8E; margin:0 0 24px;">Le candidat a validé son créneau.</p>

      <table role="presentation" width="100%" cellspacing="0" cellpadding="0">
        <tr><td style="padding:8px 0; color:#6E6A8E; font-size:12px; font-weight:600; text-transform:uppercase; letter-spacing:0.05em;">Candidat</td></tr>
        <tr><td style="padding:0 0 12px; color:#1F1B4B; font-size:16px;"><strong>${firstName} ${lastName}</strong> — <a href="mailto:${email}" style="color:#F0651F;">${email}</a>${positionApplied ? `<br><span style="color:#6E6A8E; font-size:13px;">Poste : ${positionApplied}</span>` : ""}</td></tr>
        <tr><td style="padding:8px 0; color:#6E6A8E; font-size:12px; font-weight:600; text-transform:uppercase; letter-spacing:0.05em;">Créneau choisi</td></tr>
        <tr><td style="padding:0 0 12px; color:#1F1B4B; font-size:16px;"><strong>${slotLabel}</strong></td></tr>
        <tr><td style="padding:8px 0; color:#6E6A8E; font-size:12px; font-weight:600; text-transform:uppercase; letter-spacing:0.05em;">Lieu</td></tr>
        <tr><td style="padding:0 0 12px; color:#1F1B4B; font-size:14px;">Bâtiment Regus, Route de Crassier 7, 1262 Eysins</td></tr>
      </table>
      <p style="color:#6E6A8E; font-size:13px; margin-top:20px;">
        📎 Une invitation calendrier <code>.ics</code> est jointe — importez-la dans votre agenda. Le candidat a reçu la même invitation.
      </p>
      `,
      { label: "Voir la candidature", url: dashboardUrl }
    );
  },

  /**
   * Rappel J-1 candidat — envoyé automatiquement 24h avant l'entretien
   */
  interviewReminderCandidate({
    firstName,
    slotLabel,
  }: {
    firstName: string;
    slotLabel: string;
  }) {
    return wrapEmail(
      "Rappel : votre entretien Klary demain",
      `
      <h2 style="color:#1A1660; margin:0 0 12px; font-size:22px;">Bonjour ${firstName},</h2>
      <p style="color:#1F1B4B; margin:0 0 16px; font-size:15px; line-height:1.6;">
        Petit rappel — votre entretien avec Klary a lieu <strong>demain</strong> :
      </p>
      <div style="padding:20px; background:#FAF5EF; border-left:4px solid #F0651F; border-radius:8px; margin:20px 0;">
        <div style="font-size:11px; color:#6E6A8E; font-weight:600; text-transform:uppercase; letter-spacing:0.05em; margin-bottom:6px;">📅 Date & heure</div>
        <div style="font-size:18px; color:#1A1660; font-weight:700;">${slotLabel}</div>
      </div>

      <div style="padding:20px; background:#FAF5EF; border-left:4px solid #1A1660; border-radius:8px; margin:20px 0;">
        <div style="font-size:11px; color:#6E6A8E; font-weight:600; text-transform:uppercase; letter-spacing:0.05em; margin-bottom:6px;">📍 Lieu — rendez-vous en présentiel</div>
        <div style="font-size:15px; color:#1F1B4B; line-height:1.6;">
          <strong>Klary Sàrl — Bâtiment Regus</strong><br>
          Route de Crassier 7<br>
          1262 Eysins<br>
          <div style="margin-top:10px; padding:10px 12px; background:#fff; border:1px dashed #F0651F; border-radius:6px; font-size:13px; color:#1A1660;">
            ℹ <strong>À votre arrivée :</strong> présentez-vous à l'accueil Regus au rez-de-chaussée et demandez <strong>Klary</strong>. Sacha Bacconnier viendra vous accueillir.
          </div>
          <a href="https://maps.google.com/?q=Route+de+Crassier+7,+1262+Eysins" style="color:#F0651F; font-size:13px; margin-top:8px; display:inline-block;">Itinéraire Google Maps →</a>
        </div>
      </div>

      <p style="color:#1F1B4B; margin:16px 0; font-size:15px; line-height:1.6;">
        Merci de vous présenter <strong>5 minutes avant l'heure</strong> à l'accueil du bâtiment Regus.
      </p>
      <p style="color:#1F1B4B; margin:0 0 16px; font-size:15px; line-height:1.6;">
        En cas d'empêchement de dernière minute, prévenez-nous au plus vite à <a href="mailto:rh@klary.ch" style="color:#F0651F;">rh@klary.ch</a>.
      </p>
      <p style="color:#6E6A8E; margin:24px 0 0; font-size:13px; line-height:1.6;">
        À demain,<br>
        <strong style="color:#1A1660;">L'équipe Klary</strong>
      </p>
      `
    );
  },

  /**
   * Rappel J-1 admin — récap des entretiens du lendemain
   */
  interviewReminderAdmin({
    interviews,
  }: {
    interviews: Array<{
      firstName: string;
      lastName: string;
      email: string;
      slotLabel: string;
      dashboardUrl: string;
    }>;
  }) {
    const rows = interviews
      .map(
        (i) => `
      <tr style="border-bottom:1px solid #F0EBE4;">
        <td style="padding:14px 0; color:#1F1B4B; font-size:14px; vertical-align:top;">
          <strong>${i.firstName} ${i.lastName}</strong><br>
          <a href="mailto:${i.email}" style="color:#F0651F; font-size:12px;">${i.email}</a>
        </td>
        <td style="padding:14px 0; color:#1F1B4B; font-size:14px; vertical-align:top; text-align:right;">
          <strong style="color:#1A1660;">${i.slotLabel}</strong><br>
          <a href="${i.dashboardUrl}" style="color:#F0651F; font-size:12px;">Voir la fiche →</a>
        </td>
      </tr>`
      )
      .join("");

    const count = interviews.length;
    const plural = count > 1 ? "s" : "";

    return wrapEmail(
      `Rappel : ${count} entretien${plural} demain`,
      `
      <h2 style="color:#1A1660; margin:0 0 8px; font-size:22px;">📅 ${count} entretien${plural} prévu${plural} demain</h2>
      <p style="color:#6E6A8E; margin:0 0 24px;">Récapitulatif automatique envoyé chaque matin pour les entretiens des prochaines 24h.</p>

      <table role="presentation" width="100%" cellspacing="0" cellpadding="0" style="margin:20px 0;">
        <thead>
          <tr style="border-bottom:2px solid #1A1660;">
            <th style="padding:10px 0; text-align:left; color:#6E6A8E; font-size:11px; text-transform:uppercase; letter-spacing:0.05em;">Candidat</th>
            <th style="padding:10px 0; text-align:right; color:#6E6A8E; font-size:11px; text-transform:uppercase; letter-spacing:0.05em;">Créneau</th>
          </tr>
        </thead>
        <tbody>${rows}</tbody>
      </table>

      <p style="color:#6E6A8E; font-size:13px; margin-top:20px;">
        📌 Rappel : l'événement est déjà dans ton agenda Google. Ce mail est juste un push matinal pour préparer la journée.
      </p>
      `
    );
  },

  /**
   * Admission Klary — email bienvenue + processus complet
   */
  candidatureHired({
    firstName,
    positionApplied,
    portalUrl,
    onboardingUrl,
  }: {
    firstName: string;
    positionApplied?: string;
    portalUrl: string;
    onboardingUrl?: string;
  }) {
    return wrapEmail(
      "Bienvenue chez Klary — votre parcours démarre",
      `
      <h2 style="color:#1A1660; margin:0 0 12px; font-size:24px;">Bienvenue ${firstName} 🎉</h2>
      <p style="color:#1F1B4B; margin:0 0 20px; font-size:16px; line-height:1.6;">
        Nous sommes ravis de vous accueillir dans l'équipe Klary${positionApplied ? ` au poste de <strong>${positionApplied}</strong>` : ""}. Voici les étapes de votre parcours d'intégration.
      </p>

      <div style="margin:24px 0;">
        <div style="padding:16px; background:#FAF5EF; border-radius:10px; margin-bottom:12px; border-left:4px solid #F0651F;">
          <div style="font-size:11px; color:#F0651F; font-weight:700; text-transform:uppercase; letter-spacing:0.1em; margin-bottom:6px;">Étape 1</div>
          <div style="font-size:15px; color:#1A1660; font-weight:600; margin-bottom:4px;">Formation théorique interne</div>
          <div style="font-size:13px; color:#6E6A8E; line-height:1.5;">Modules produits (Maladie, LPP, Prévoyance, Hypothèque), règlementation FINMA, éthique et confidentialité.</div>
        </div>

        <div style="padding:16px; background:#FAF5EF; border-radius:10px; margin-bottom:12px; border-left:4px solid #F0651F;">
          <div style="font-size:11px; color:#F0651F; font-weight:700; text-transform:uppercase; letter-spacing:0.1em; margin-bottom:6px;">Étape 2</div>
          <div style="font-size:15px; color:#1A1660; font-weight:600; margin-bottom:4px;">Accompagnement terrain</div>
          <div style="font-size:13px; color:#6E6A8E; line-height:1.5;">Prospection, entretien conseil, argumentaire de vente, montage complet de dossier, saisie compagnie — encadré par votre responsable.</div>
        </div>

        <div style="padding:16px; background:#FAF5EF; border-radius:10px; margin-bottom:12px; border-left:4px solid #F0651F;">
          <div style="font-size:11px; color:#F0651F; font-weight:700; text-transform:uppercase; letter-spacing:0.1em; margin-bottom:6px;">Étape 3</div>
          <div style="font-size:15px; color:#1A1660; font-weight:600; margin-bottom:4px;">Évaluation Klary</div>
          <div style="font-size:13px; color:#6E6A8E; line-height:1.5;">Passage des certifications internes en ligne (80% minimum). Score par catégorie, prise de conscience des points à revoir.</div>
        </div>

        <div style="padding:16px; background:#FAF5EF; border-radius:10px; margin-bottom:12px; border-left:4px solid #F0651F;">
          <div style="font-size:11px; color:#F0651F; font-weight:700; text-transform:uppercase; letter-spacing:0.1em; margin-bottom:6px;">Étape 4 (en parallèle)</div>
          <div style="font-size:15px; color:#1A1660; font-weight:600; margin-bottom:4px;">Ouverture accès FINMA + compagnies</div>
          <div style="font-size:13px; color:#6E6A8E; line-height:1.5;">Enregistrement FINMA au registre des intermédiaires + ouverture progressive des accès Groupe Mutuel, Helsana, Swica, CSS, Assura, Zurich…</div>
        </div>
      </div>

      ${onboardingUrl ? `
      <div style="padding:20px 24px; background:#F0651F; border-radius:12px; margin:24px 0; color:#fff;">
        <div style="font-size:11px; color:rgba(255,255,255,0.85); font-weight:700; text-transform:uppercase; letter-spacing:0.15em; margin-bottom:6px;">📝 Action requise sous 48h</div>
        <div style="font-size:17px; font-weight:700; margin-bottom:6px;">Compléter votre dossier d'onboarding</div>
        <div style="font-size:13px; line-height:1.5; color:rgba(255,255,255,0.9); margin-bottom:14px;">
          Pour préparer votre contrat de travail et votre premier salaire, nous avons besoin de quelques informations administratives (identité, adresse, banque, N° AVS, prévoyance passée) et de 4-5 documents à téléverser.
        </div>
        <a href="${onboardingUrl}" style="display:inline-block; padding:12px 22px; background:#fff; color:#F0651F; text-decoration:none; font-weight:700; border-radius:8px; font-size:14px;">
          Ouvrir mon dossier d'onboarding →
        </a>
      </div>` : ""}

      <p style="color:#1F1B4B; margin:24px 0 12px; font-size:15px; line-height:1.6;">
        Dès que ces 4 étapes seront validées, vous recevrez un second email d'activation avec vos accès complets (portefeuille leads, agenda CRM, email <strong>@klary.ch</strong>).
      </p>
      <p style="color:#6E6A8E; margin:16px 0 0; font-size:13px; line-height:1.6;">
        Toute question, écrivez-nous à <a href="mailto:rh@klary.ch" style="color:#F0651F;">rh@klary.ch</a>.<br><br>
        Bienvenue chez Klary,<br>
        <strong style="color:#1A1660;">Sacha Bacconnier</strong><br>
        <span style="color:#6E6A8E;">Responsable d'agence</span>
      </p>
      `,
      { label: "Accéder à mon espace formation", url: portalUrl }
    );
  },

  /**
   * Récap dossier onboarding reçu — destinataire : comptable.
   * Contient toutes les infos remplies par le candidat + liens signés
   * vers les documents uploadés (valables 1h à la génération).
   */
  onboardingReceivedByComptable({
    firstName,
    lastName,
    email,
    positionApplied,
    formData,
    docsInfo,
    dashboardUrl,
  }: {
    firstName: string;
    lastName: string;
    email: string;
    positionApplied?: string;
    formData: Record<string, any>;
    docsInfo: { key: string; label: string; url: string | null; filename?: string }[];
    dashboardUrl: string;
  }) {
    const row = (label: string, value?: string | null) =>
      value
        ? `<tr><td style="padding:6px 0; color:#6E6A8E; font-size:12px; width:180px;">${label}</td><td style="padding:6px 0; color:#1F1B4B; font-size:14px; font-weight:600;">${value}</td></tr>`
        : "";

    const docLine = (d: { label: string; url: string | null; filename?: string }) =>
      d.url
        ? `<li style="margin:6px 0;"><a href="${d.url}" style="color:#F0651F; font-weight:600;">${d.label}</a>${d.filename ? ` <span style="color:#6E6A8E; font-size:12px;">— ${d.filename}</span>` : ""}</li>`
        : `<li style="margin:6px 0; color:#A5A2C0;">${d.label} — <em>non transmis</em></li>`;

    return wrapEmail(
      "Dossier d'onboarding reçu — à traiter",
      `
      <h2 style="color:#1A1660; margin:0 0 8px; font-size:22px;">📁 Nouveau dossier d'onboarding</h2>
      <p style="color:#6E6A8E; margin:0 0 24px; font-size:14px;">
        <strong>${firstName} ${lastName}</strong>${positionApplied ? ` (${positionApplied})` : ""} vient de compléter son dossier d'onboarding. Merci de préparer contrat + paie.
      </p>

      <div style="padding:16px 20px; background:#FAF5EF; border-radius:10px; margin-bottom:20px;">
        <div style="font-size:11px; color:#F0651F; font-weight:700; text-transform:uppercase; letter-spacing:0.1em; margin-bottom:10px;">Identité</div>
        <table role="presentation" width="100%" cellspacing="0" cellpadding="0">
          ${row("Nom complet", `${firstName} ${lastName}`)}
          ${row("Email personnel", email)}
          ${row("Date de naissance", formData.date_of_birth)}
          ${row("Genre", formData.gender === "M" ? "Masculin" : formData.gender === "F" ? "Féminin" : formData.gender)}
          ${row("Nationalité", formData.nationality)}
          ${row("Lieu de naissance", [formData.birth_city, formData.birth_country].filter(Boolean).join(", "))}
          ${row("État civil", formData.marital_status)}
          ${row("N° AVS", formData.avs_number)}
          ${row("Enfants à charge", formData.children_count ? String(formData.children_count) : "—")}
          ${row("Permis de séjour", formData.residence_permit)}
          ${row("Carte identité — valable jusqu'au", formData.id_valid_until)}
          ${row("Passeport — valable jusqu'au", formData.passport_valid_until)}
          ${row("Permis de séjour — valable jusqu'au", formData.permis_valid_until)}
        </table>
      </div>

      <div style="padding:16px 20px; background:#FAF5EF; border-radius:10px; margin-bottom:20px;">
        <div style="font-size:11px; color:#F0651F; font-weight:700; text-transform:uppercase; letter-spacing:0.1em; margin-bottom:10px;">Filiation</div>
        <table role="presentation" width="100%" cellspacing="0" cellpadding="0">
          ${row("Père", [formData.father_first_name, formData.father_last_name].filter(Boolean).join(" "))}
          ${row("Mère (nom de jeune fille)", [formData.mother_first_name, formData.mother_last_name].filter(Boolean).join(" "))}
        </table>
      </div>

      <div style="padding:16px 20px; background:#FAF5EF; border-radius:10px; margin-bottom:20px;">
        <div style="font-size:11px; color:#F0651F; font-weight:700; text-transform:uppercase; letter-spacing:0.1em; margin-bottom:10px;">Adresse actuelle en Suisse</div>
        <table role="presentation" width="100%" cellspacing="0" cellpadding="0">
          ${row("Rue + numéro", formData.postal_street)}
          ${row("NPA + ville", [formData.postal_zip, formData.postal_city].filter(Boolean).join(" "))}
          ${row("Canton", formData.postal_canton)}
        </table>
      </div>

      ${
        formData.foreign_street || formData.foreign_city || formData.foreign_country
          ? `
      <div style="padding:16px 20px; background:#FAF5EF; border-radius:10px; margin-bottom:20px;">
        <div style="font-size:11px; color:#F0651F; font-weight:700; text-transform:uppercase; letter-spacing:0.1em; margin-bottom:10px;">Adresse à l'étranger</div>
        <table role="presentation" width="100%" cellspacing="0" cellpadding="0">
          ${row("Rue + numéro", formData.foreign_street)}
          ${row("Ville / région", formData.foreign_city)}
          ${row("Pays", formData.foreign_country)}
        </table>
      </div>
      `
          : ""
      }

      <div style="padding:16px 20px; background:#FAF5EF; border-radius:10px; margin-bottom:20px;">
        <div style="font-size:11px; color:#F0651F; font-weight:700; text-transform:uppercase; letter-spacing:0.1em; margin-bottom:10px;">Contact</div>
        <table role="presentation" width="100%" cellspacing="0" cellpadding="0">
          ${row("Téléphone mobile", formData.phone_mobile)}
          ${row("Téléphone fixe", formData.phone_landline)}
          ${row("Email personnel", formData.personal_email)}
          ${row("Lieu d'origine (Suisse)", formData.place_of_origin)}
        </table>
      </div>

      <div style="padding:16px 20px; background:#FAF5EF; border-radius:10px; margin-bottom:20px;">
        <div style="font-size:11px; color:#F0651F; font-weight:700; text-transform:uppercase; letter-spacing:0.1em; margin-bottom:10px;">Permis de conduire</div>
        <table role="presentation" width="100%" cellspacing="0" cellpadding="0">
          ${row("Possède le permis", formData.driving_license)}
          ${row("Types", formData.driving_license_types)}
        </table>
      </div>

      ${
        formData.unemployment_status === "oui"
          ? `
      <div style="padding:16px 20px; background:#fff7ed; border:1px solid #fed7aa; border-radius:10px; margin-bottom:20px;">
        <div style="font-size:11px; color:#F0651F; font-weight:700; text-transform:uppercase; letter-spacing:0.1em; margin-bottom:10px;">⚠ Chômage</div>
        <table role="presentation" width="100%" cellspacing="0" cellpadding="0">
          ${row("Actuellement au chômage", "Oui")}
          ${row("Caisse de chômage", formData.unemployment_fund_name)}
          ${row("Adresse caisse", formData.unemployment_fund_address)}
        </table>
      </div>`
          : ""
      }

      ${
        formData.spouse_first_name || formData.spouse_last_name
          ? `
      <div style="padding:16px 20px; background:#FAF5EF; border-radius:10px; margin-bottom:20px;">
        <div style="font-size:11px; color:#F0651F; font-weight:700; text-transform:uppercase; letter-spacing:0.1em; margin-bottom:10px;">Conjoint / partenaire</div>
        <table role="presentation" width="100%" cellspacing="0" cellpadding="0">
          ${row("Date de mariage/PACS", formData.marriage_date)}
          ${row("Nom complet", [formData.spouse_first_name, formData.spouse_last_name].filter(Boolean).join(" "))}
          ${row("Date de naissance", formData.spouse_dob)}
          ${row("Nationalité", formData.spouse_nationality)}
          ${row("Permis", formData.spouse_permit)}
          ${row("Situation professionnelle", formData.spouse_situation)}
          ${row("Depuis", formData.spouse_situation_since)}
          ${row("Taux d'activité", formData.spouse_activity_rate)}
          ${row("Lieu / pays d'activité", formData.spouse_activity_location)}
          ${row("Alloc familiales CH", formData.spouse_alloc_ch)}
          ${row("Alloc familiales étranger", formData.spouse_alloc_foreign)}
        </table>
      </div>`
          : ""
      }

      ${(() => {
        let children: any[] = [];
        try {
          children = JSON.parse(formData.children_json || "[]");
        } catch {
          children = [];
        }
        if (!children.length) return "";
        return `
      <div style="padding:16px 20px; background:#FAF5EF; border-radius:10px; margin-bottom:20px;">
        <div style="font-size:11px; color:#F0651F; font-weight:700; text-transform:uppercase; letter-spacing:0.1em; margin-bottom:10px;">Enfants à charge (${children.length})</div>
        <table role="presentation" width="100%" cellspacing="0" cellpadding="0" style="border-collapse:collapse;">
          <thead>
            <tr style="border-bottom:1px solid #DDD9E8;">
              <th style="text-align:left; padding:6px 4px; font-size:11px; color:#6E6A8E;">Nom</th>
              <th style="text-align:left; padding:6px 4px; font-size:11px; color:#6E6A8E;">Prénom</th>
              <th style="text-align:left; padding:6px 4px; font-size:11px; color:#6E6A8E;">Date naissance</th>
              <th style="text-align:left; padding:6px 4px; font-size:11px; color:#6E6A8E;">Parenté</th>
              <th style="text-align:left; padding:6px 4px; font-size:11px; color:#6E6A8E;">Domicile</th>
            </tr>
          </thead>
          <tbody>
            ${children
              .map(
                (c: any) => `
              <tr style="border-bottom:1px solid #F0EBE4;">
                <td style="padding:6px 4px; font-size:13px; color:#1F1B4B;">${c.last_name || "—"}</td>
                <td style="padding:6px 4px; font-size:13px; color:#1F1B4B;">${c.first_name || "—"}</td>
                <td style="padding:6px 4px; font-size:13px; color:#1F1B4B;">${c.dob || "—"}</td>
                <td style="padding:6px 4px; font-size:13px; color:#1F1B4B;">${c.relation || "—"}</td>
                <td style="padding:6px 4px; font-size:12px; color:#6E6A8E;">${c.address || "—"}</td>
              </tr>`
              )
              .join("")}
          </tbody>
        </table>
        <div style="margin-top:10px; font-size:12px; color:#6E6A8E;">
          Demande alloc familiales : <strong>${formData.requests_family_allowances || "—"}</strong>
          &nbsp;·&nbsp; 2ᵉ activité lucrative : <strong>${formData.secondary_activity || "—"}</strong>
          ${formData.secondary_activity_rate ? ` (${formData.secondary_activity_rate}%)` : ""}
        </div>
      </div>`;
      })()}

      <div style="padding:16px 20px; background:#FAF5EF; border-radius:10px; margin-bottom:20px;">
        <div style="font-size:11px; color:#F0651F; font-weight:700; text-transform:uppercase; letter-spacing:0.1em; margin-bottom:10px;">Banque (virement salaire)</div>
        <table role="presentation" width="100%" cellspacing="0" cellpadding="0">
          ${row("IBAN", formData.bank_iban)}
          ${row("Nom banque", formData.bank_name)}
          ${row("Titulaire compte", formData.bank_holder)}
          ${row("Localité banque", formData.bank_locality)}
          ${row("Bulletins salaire par email", formData.authorize_email_payslip === "on" ? "Autorisé" : "Refusé")}
        </table>
      </div>

      <div style="padding:16px 20px; background:#FAF5EF; border-radius:10px; margin-bottom:20px;">
        <div style="font-size:11px; color:#F0651F; font-weight:700; text-transform:uppercase; letter-spacing:0.1em; margin-bottom:10px;">Fiscalité</div>
        <table role="presentation" width="100%" cellspacing="0" cellpadding="0">
          ${row("Confession", formData.religion)}
          ${row("Conjoint travaille ?", formData.spouse_working)}
          ${row("Salaire brut annuel conjoint", formData.spouse_income)}
        </table>
      </div>

      <div style="padding:16px 20px; background:#FAF5EF; border-radius:10px; margin-bottom:20px;">
        <div style="font-size:11px; color:#F0651F; font-weight:700; text-transform:uppercase; letter-spacing:0.1em; margin-bottom:10px;">Prévoyance (2e pilier)</div>
        <table role="presentation" width="100%" cellspacing="0" cellpadding="0">
          ${row("Caisse LPP précédente", formData.prev_lpp_fund)}
          ${row("N° affiliation sortie", formData.prev_lpp_id)}
          ${row("Compte de libre passage", formData.libre_passage)}
        </table>
      </div>

      <div style="padding:16px 20px; background:#FAF5EF; border-radius:10px; margin-bottom:20px;">
        <div style="font-size:11px; color:#F0651F; font-weight:700; text-transform:uppercase; letter-spacing:0.1em; margin-bottom:10px;">Contact d'urgence</div>
        <table role="presentation" width="100%" cellspacing="0" cellpadding="0">
          ${row("Nom", formData.emergency_name)}
          ${row("Lien", formData.emergency_relation)}
          ${row("Téléphone", formData.emergency_phone)}
        </table>
      </div>

      <div style="padding:16px 20px; background:#FAF5EF; border-radius:10px; margin-bottom:20px;">
        <div style="font-size:11px; color:#F0651F; font-weight:700; text-transform:uppercase; letter-spacing:0.1em; margin-bottom:10px;">📎 Documents transmis (liens 1h)</div>
        <ul style="margin:0; padding-left:20px; font-size:13px; color:#1F1B4B;">
          ${docsInfo.map(docLine).join("\n")}
        </ul>
      </div>
      `,
      { label: "Voir la fiche candidature complète", url: dashboardUrl }
    );
  },

  /**
   * Offboarding — Notification agent partant (SANS pièce jointe)
   * L'agent est informé du départ et des conséquences.
   * La convention lui sera remise en main propre / courrier, PAS en email.
   */
  offboardingAgentNotice({
    firstName,
    lastName,
    reason,
    lastWorkingDay,
  }: {
    firstName: string;
    lastName: string;
    reason: string;
    lastWorkingDay: string;
  }) {
    const REASON_LABELS: Record<string, string> = {
      demission: "démission",
      mutuel_accord: "rupture d'un commun accord",
      rupture_essai: "rupture de la période d'essai",
      fin_cdd: "fin de contrat à durée déterminée",
      retraite: "départ à la retraite",
      licenciement: "licenciement",
      faute_grave: "licenciement pour faute grave",
      abandon_poste: "abandon de poste",
    };
    const reasonLabel = REASON_LABELS[reason] || reason;

    return wrapEmail(
      "Fin de collaboration Klary — procédure de sortie",
      `
      <h2 style="color:#1A1660; margin:0 0 12px; font-size:22px;">
        ${firstName} ${lastName},
      </h2>
      <p style="color:#1F1B4B; margin:0 0 16px; font-size:15px; line-height:1.6;">
        Nous vous notifions la fin de votre collaboration avec Klary Sàrl pour motif de <strong>${reasonLabel}</strong>, avec effet au <strong>${lastWorkingDay}</strong>.
      </p>

      <div style="padding:16px 20px; background:#fff5f5; border-left:4px solid #dc2626; border-radius:8px; margin:20px 0;">
        <div style="font-size:11px; color:#dc2626; font-weight:700; text-transform:uppercase; letter-spacing:0.1em; margin-bottom:8px;">🔒 Accès techniques révoqués</div>
        <div style="font-size:14px; color:#1F1B4B; line-height:1.5;">
          Avec effet immédiat, les accès suivants sont désactivés :
          <ul style="margin:8px 0 0; padding-left:20px;">
            <li>Email professionnel @klary.ch (Infomaniak)</li>
            <li>Plateforme Klary (app.klary.ch)</li>
            <li>CRM LYTA</li>
            <li>Google Workspace (Agenda, Sheet, Drive)</li>
            <li>Badges d'accès bâtiment Regus (Eysins)</li>
            <li>Accès individuels compagnies partenaires</li>
          </ul>
        </div>
      </div>

      <div style="padding:16px 20px; background:#FAF5EF; border-left:4px solid #F0651F; border-radius:8px; margin:20px 0;">
        <div style="font-size:11px; color:#F0651F; font-weight:700; text-transform:uppercase; letter-spacing:0.1em; margin-bottom:8px;">📄 Convention de sortie à signer</div>
        <div style="font-size:14px; color:#1F1B4B; line-height:1.5;">
          Une <strong>convention de sortie</strong> vous sera remise par Sacha Bacconnier <strong>en main propre</strong> lors de votre dernier jour, ou envoyée <strong>par courrier recommandé</strong> à l'adresse figurant dans votre dossier.
          <br><br>
          Elle formalise les obligations post-emploi (interdiction de débauchage art. 14, interdiction de concurrence art. 15, compte de caution 3 ans, confidentialité permanente art. 13) déjà prévues à votre contrat de travail.
        </div>
      </div>

      <div style="padding:16px 20px; background:#fef3c7; border:2px solid #f59e0b; border-radius:8px; margin:20px 0;">
        <div style="font-size:13px; color:#78350f; font-weight:700; margin-bottom:8px;">
          ⚠ IMPORTANT — Sans signature de la convention, aucun document de sortie ne sera émis
        </div>
        <div style="font-size:13px; color:#78350f; line-height:1.6;">
          La signature de la convention <strong>débloque uniquement</strong> l'émission des documents administratifs suivants :
          <ul style="margin:8px 0 0; padding-left:20px;">
            <li><strong>Certificat de travail</strong> qualifiant (art. 330a CO)</li>
            <li><strong>Attestation d'employeur pour l'assurance chômage</strong> (indispensable pour votre inscription à la caisse chômage)</li>
            <li>Décompte de salaire final + solde de tout compte</li>
            <li>Certificat de salaire annuel LAWID (début année suivante)</li>
            <li>Attestation de sortie LPP (via votre caisse LPP)</li>
          </ul>
          <br>
          <strong>Sans convention signée</strong> :
          <ul style="margin:8px 0 0; padding-left:20px;">
            <li>Aucune attestation ne sera transmise à la caisse chômage</li>
            <li>La procédure de sortie reste bloquée indéfiniment</li>
            <li>Vous serez privé·e de vos droits au chômage pendant plusieurs mois</li>
          </ul>
        </div>
      </div>

      <p style="color:#1F1B4B; margin:16px 0; font-size:14px; line-height:1.6;">
        <strong>Restitution matériel</strong> : d'ici votre dernier jour, merci de restituer ordinateur, badges, clés, téléphone pro et tout matériel Klary. Effacez également toute donnée client détenue en local.
      </p>

      <p style="color:#6E6A8E; margin:24px 0 0; font-size:13px; line-height:1.6;">
        Pour toute question, contactez la direction : <a href="mailto:admin@klary.ch" style="color:#F0651F;">admin@klary.ch</a>.<br><br>
        <strong style="color:#1A1660;">Sacha Bacconnier</strong><br>
        Responsable d'agence — Klary Sàrl
      </p>
      `
    );
  },

  /**
   * Offboarding — email URGENT à office@ pour révoquer les accès
   * Envoyé À L'INSTANT de l'initiation (avant même signature convention)
   */
  offboardingOfficeUrgent({
    firstName,
    lastName,
    reason,
    lastWorkingDay,
    dashboardUrl,
  }: {
    firstName: string;
    lastName: string;
    reason: string;
    lastWorkingDay: string;
    dashboardUrl: string;
  }) {
    return wrapEmail(
      "⚠ Offboarding urgent — révocation d'accès",
      `
      <div style="padding:14px 18px; background:#dc2626; color:#fff; border-radius:10px; margin-bottom:20px; text-align:center;">
        <div style="font-size:11px; font-weight:700; text-transform:uppercase; letter-spacing:0.2em; margin-bottom:6px;">🚨 ACTION URGENTE — DANS L'HEURE</div>
        <div style="font-size:16px; font-weight:700;">Révoquer les accès de ${firstName} ${lastName}</div>
      </div>

      <p style="color:#1F1B4B; margin:0 0 16px; font-size:14px; line-height:1.6;">
        <strong>${firstName} ${lastName}</strong> quitte Klary pour motif de <em>${reason}</em>, dernier jour effectif : <strong>${lastWorkingDay}</strong>.
      </p>
      <p style="color:#1F1B4B; margin:0 0 16px; font-size:14px; line-height:1.6;">
        Merci de procéder <strong>immédiatement</strong> à la révocation des accès et à la récupération du matériel.
      </p>

      <div style="padding:16px 20px; background:#FAF5EF; border-radius:10px; margin-bottom:20px;">
        <div style="font-size:11px; color:#F0651F; font-weight:700; text-transform:uppercase; letter-spacing:0.1em; margin-bottom:10px;">Accès à révoquer</div>
        <table role="presentation" width="100%" cellspacing="0" cellpadding="0" style="font-size:14px; color:#1F1B4B;">
          <tr><td style="padding:6px 0; vertical-align:top; width:24px;">☐</td><td style="padding:6px 0;">Email professionnel Infomaniak <strong>prenom.nom@klary.ch</strong></td></tr>
          <tr><td style="padding:6px 0; vertical-align:top;">☐</td><td style="padding:6px 0;">Compte plateforme <strong>app.klary.ch</strong> (désactivation user_roles déjà faite auto)</td></tr>
          <tr><td style="padding:6px 0; vertical-align:top;">☐</td><td style="padding:6px 0;">CRM <strong>LYTA</strong> (désactivation compte + retrait portefeuille)</td></tr>
          <tr><td style="padding:6px 0; vertical-align:top;">☐</td><td style="padding:6px 0;">Google Workspace (Agenda partagés, Sheet, Drive)</td></tr>
          <tr><td style="padding:6px 0; vertical-align:top;">☐</td><td style="padding:6px 0;">Badges bâtiment <strong>Regus (Route de Crassier 7, Eysins)</strong> — désactiver</td></tr>
          <tr><td style="padding:6px 0; vertical-align:top;">☐</td><td style="padding:6px 0;">Accès compagnies individuels : GM, Helsana, Swica, Assura, CSS, Sympany, Sanitas, Visana, autres</td></tr>
          <tr><td style="padding:6px 0; vertical-align:top;">☐</td><td style="padding:6px 0;">Notifier FINMA (radiation registre intermédiaires — 10 jours ouvrés max)</td></tr>
        </table>
      </div>

      <div style="padding:16px 20px; background:#FAF5EF; border-radius:10px; margin-bottom:20px;">
        <div style="font-size:11px; color:#F0651F; font-weight:700; text-transform:uppercase; letter-spacing:0.1em; margin-bottom:10px;">Matériel à récupérer</div>
        <table role="presentation" width="100%" cellspacing="0" cellpadding="0" style="font-size:14px; color:#1F1B4B;">
          <tr><td style="padding:6px 0; vertical-align:top; width:24px;">☐</td><td style="padding:6px 0;">Ordinateur portable + chargeur + accessoires</td></tr>
          <tr><td style="padding:6px 0; vertical-align:top;">☐</td><td style="padding:6px 0;">Badge d'accès Regus</td></tr>
          <tr><td style="padding:6px 0; vertical-align:top;">☐</td><td style="padding:6px 0;">Clés éventuelles</td></tr>
          <tr><td style="padding:6px 0; vertical-align:top;">☐</td><td style="padding:6px 0;">Téléphone pro (si fourni)</td></tr>
          <tr><td style="padding:6px 0; vertical-align:top;">☐</td><td style="padding:6px 0;">Cartes de visite non distribuées</td></tr>
        </table>
      </div>

      <p style="color:#6E6A8E; font-size:13px; margin-top:20px;">
        Une fois terminé, cochez les items correspondants dans le dossier admin.
      </p>
      `,
      { label: "Ouvrir le dossier offboarding", url: dashboardUrl }
    );
  },

  /**
   * Offboarding — checklist finance (envoyé APRÈS upload convention signée)
   */
  offboardingFinanceChecklist({
    firstName,
    lastName,
    reason,
    lastWorkingDay,
    dashboardUrl,
  }: {
    firstName: string;
    lastName: string;
    reason: string;
    lastWorkingDay: string;
    dashboardUrl: string;
  }) {
    const isAggravated = reason === "faute_grave" || reason === "abandon_poste";

    return wrapEmail(
      "Offboarding — préparation documents financiers",
      `
      <h2 style="color:#1A1660; margin:0 0 8px; font-size:22px;">💰 Offboarding ${firstName} ${lastName}</h2>
      <p style="color:#6E6A8E; margin:0 0 20px; font-size:14px;">
        La convention de sortie a été signée. La procédure de sortie financière peut démarrer.
      </p>

      <table role="presentation" width="100%" cellspacing="0" cellpadding="0" style="margin-bottom:20px;">
        <tr><td style="padding:6px 0; color:#6E6A8E; font-size:12px; font-weight:600; text-transform:uppercase;">Agent</td></tr>
        <tr><td style="padding:0 0 8px; color:#1F1B4B; font-size:15px;"><strong>${firstName} ${lastName}</strong></td></tr>
        <tr><td style="padding:6px 0; color:#6E6A8E; font-size:12px; font-weight:600; text-transform:uppercase;">Motif</td></tr>
        <tr><td style="padding:0 0 8px; color:#1F1B4B; font-size:15px;">${reason}</td></tr>
        <tr><td style="padding:6px 0; color:#6E6A8E; font-size:12px; font-weight:600; text-transform:uppercase;">Dernier jour</td></tr>
        <tr><td style="padding:0 0 8px; color:#1F1B4B; font-size:15px;"><strong>${lastWorkingDay}</strong></td></tr>
      </table>

      <div style="padding:16px 20px; background:#FAF5EF; border-radius:10px; margin-bottom:20px;">
        <div style="font-size:11px; color:#F0651F; font-weight:700; text-transform:uppercase; letter-spacing:0.1em; margin-bottom:10px;">📄 Documents à préparer et transmettre à l'agent</div>
        <table role="presentation" width="100%" cellspacing="0" cellpadding="0" style="font-size:14px; color:#1F1B4B;">
          <tr><td style="padding:6px 0; vertical-align:top; width:24px;">☐</td><td style="padding:6px 0;"><strong>Décompte de salaire final</strong> + solde de tout compte (art. 323b CO). Inclure : dernier mois, vacances non prises, 13e mois pro rata</td></tr>
          <tr><td style="padding:6px 0; vertical-align:top;">☐</td><td style="padding:6px 0;"><strong>Attestation d'employeur pour l'AC</strong> (SECO — assurance chômage). Salaire moyen 6 derniers mois + motif exact</td></tr>
          <tr><td style="padding:6px 0; vertical-align:top;">☐</td><td style="padding:6px 0;"><strong>Certificat de salaire annuel LAWID</strong> (à envoyer début année suivante — pour déclaration fiscale de l'agent)</td></tr>
          <tr><td style="padding:6px 0; vertical-align:top;">☐</td><td style="padding:6px 0;">Confirmer que la <strong>caisse LPP</strong> a bien été notifiée de la sortie (elle enverra l'attestation de libre passage à l'agent)</td></tr>
        </table>
      </div>

      <div style="padding:16px 20px; background:${isAggravated ? '#fff5f5' : '#f0f9ff'}; border-left:4px solid ${isAggravated ? '#dc2626' : '#0284c7'}; border-radius:8px; margin-bottom:20px;">
        <div style="font-size:11px; color:${isAggravated ? '#dc2626' : '#0284c7'}; font-weight:700; text-transform:uppercase; letter-spacing:0.1em; margin-bottom:8px;">Compte de caution (Annexe III du contrat)</div>
        <div style="font-size:14px; color:#1F1B4B; line-height:1.6;">
          ${isAggravated
            ? `<strong>Motif aggravé (faute grave / abandon)</strong> : Klary conserve <strong>l'intégralité</strong> des commissions dues dans le compte de caution pendant <strong>3 ans</strong> à compter de la fin du contrat. Ne PAS reverser les commissions récurrentes en attente.`
            : `<strong>Motif standard</strong> : retenue de <strong>20% de l'indemnité annuelle nette</strong> dans le compte de caution pendant <strong>3 ans</strong> à compter de la fin du contrat. Le solde éventuel sera reversé à l'agent à l'issue de cette période, déduction faite des annulations.`}
        </div>
      </div>

      <p style="color:#6E6A8E; font-size:13px; margin-top:20px;">
        Cochez les items correspondants dans le dossier admin au fur et à mesure.
      </p>
      `,
      { label: "Ouvrir le dossier offboarding", url: dashboardUrl }
    );
  },

  /**
   * Offboarding — supervision admin + alerte avocat si motif sensible
   */
  offboardingAdminSupervision({
    firstName,
    lastName,
    reason,
    lastWorkingDay,
    initiatedByName,
    adminNotes,
    dashboardUrl,
  }: {
    firstName: string;
    lastName: string;
    reason: string;
    lastWorkingDay: string;
    initiatedByName?: string;
    adminNotes?: string;
    dashboardUrl: string;
  }) {
    const isSensitive =
      reason === "faute_grave" ||
      reason === "abandon_poste" ||
      reason === "licenciement";

    return wrapEmail(
      "Supervision offboarding — action requise",
      `
      <h2 style="color:#1A1660; margin:0 0 8px; font-size:22px;">
        📋 Nouveau processus d'offboarding initié
      </h2>
      <p style="color:#6E6A8E; margin:0 0 20px; font-size:14px;">
        ${initiatedByName ? `Initié par : <strong>${initiatedByName}</strong>` : ""}
      </p>

      ${isSensitive ? `
      <div style="padding:16px 20px; background:#dc2626; color:#fff; border-radius:10px; margin-bottom:20px;">
        <div style="font-size:12px; font-weight:700; text-transform:uppercase; letter-spacing:0.15em; margin-bottom:8px;">🚨 CONSULTATION AVOCAT RECOMMANDÉE</div>
        <div style="font-size:14px; line-height:1.5;">
          Motif sensible détecté (<strong>${reason}</strong>). Consulter le conseiller juridique <strong>avant toute action irréversible</strong> :
          <ul style="margin:8px 0 0; padding-left:20px;">
            ${reason === 'faute_grave' ? '<li>Vérifier délai de réaction (art. 337 CO — sans délai)</li><li>Documenter les motifs justes objectifs et sérieux</li>' : ''}
            ${reason === 'abandon_poste' ? '<li>Mise en demeure préalable écrite obligatoire</li><li>Attendre délai raisonnable avant résiliation</li>' : ''}
            ${reason === 'licenciement' ? '<li>Vérifier respect du préavis contractuel</li><li>Motiver par écrit à la demande de l\'agent (art. 335 al. 2 CO)</li>' : ''}
            <li>Risque de recours prud'homal — préparer preuve documentaire</li>
          </ul>
        </div>
      </div>` : ""}

      <table role="presentation" width="100%" cellspacing="0" cellpadding="0" style="margin-bottom:20px;">
        <tr><td style="padding:6px 0; color:#6E6A8E; font-size:12px; font-weight:600; text-transform:uppercase;">Agent</td></tr>
        <tr><td style="padding:0 0 8px; color:#1F1B4B; font-size:15px;"><strong>${firstName} ${lastName}</strong></td></tr>
        <tr><td style="padding:6px 0; color:#6E6A8E; font-size:12px; font-weight:600; text-transform:uppercase;">Motif</td></tr>
        <tr><td style="padding:0 0 8px; color:#1F1B4B; font-size:15px;"><strong>${reason}</strong></td></tr>
        <tr><td style="padding:6px 0; color:#6E6A8E; font-size:12px; font-weight:600; text-transform:uppercase;">Dernier jour effectif</td></tr>
        <tr><td style="padding:0 0 8px; color:#1F1B4B; font-size:15px;"><strong>${lastWorkingDay}</strong></td></tr>
        ${adminNotes ? `
        <tr><td style="padding:6px 0; color:#6E6A8E; font-size:12px; font-weight:600; text-transform:uppercase;">Notes admin</td></tr>
        <tr><td style="padding:0 0 8px; color:#1F1B4B; font-size:14px; white-space:pre-wrap;">${adminNotes}</td></tr>
        ` : ""}
      </table>

      <div style="padding:14px 18px; background:#f0f9ff; border:1px dashed #0284c7; border-radius:6px; font-size:13px; color:#0c4a6e; margin-bottom:16px;">
        ℹ <strong>Étapes suivantes automatiques :</strong><br>
        • Accès techniques révoqués (email URGENT envoyé à office@)<br>
        • Convention de sortie à télécharger + imprimer sur papier Klary<br>
        • Remise en main propre ou courrier recommandé à l'agent<br>
        • Upload de la convention signée déclenchera l'envoi à finance@
      </div>
      `,
      { label: "Voir le dossier offboarding complet", url: dashboardUrl }
    );
  },

  /**
   * Confirmation candidat — dossier onboarding bien reçu
   */
  onboardingConfirmation({ firstName }: { firstName: string }) {
    return wrapEmail(
      "Votre dossier d'onboarding est bien reçu — Klary",
      `
      <h2 style="color:#1A1660; margin:0 0 12px; font-size:22px;">Merci ${firstName},</h2>
      <p style="color:#1F1B4B; margin:0 0 16px; font-size:15px; line-height:1.6;">
        Votre dossier d'onboarding a bien été reçu. Notre comptable prépare votre contrat de travail et vos accès administratifs.
      </p>
      <p style="color:#1F1B4B; margin:0 0 16px; font-size:15px; line-height:1.6;">
        Vous recevrez sous <strong>48 à 72 heures ouvrées</strong> votre contrat pour signature électronique. En parallèle, votre parcours de formation démarre — connectez-vous à <a href="https://app.klary.ch" style="color:#F0651F;">app.klary.ch</a> pour accéder aux modules.
      </p>
      <p style="color:#6E6A8E; margin:24px 0 0; font-size:13px; line-height:1.6;">
        À très vite,<br>
        <strong style="color:#1A1660;">L'équipe Klary</strong>
      </p>
      `
    );
  },

  /**
   * Onboarding technique — assistant(e)s notifié(e)s quand un agent
   * vient de réussir sa 1ère certification Klary.
   * Objectif : agent opérationnel dans la journée.
   */
  agentCertifiedSetupTasks({
    firstName,
    lastName,
    userLoginEmail,
    proposedKlaryEmail,
    moduleTitle,
    certNumber,
    dashboardUrl,
  }: {
    firstName: string;
    lastName: string;
    userLoginEmail: string;
    proposedKlaryEmail: string;
    moduleTitle: string;
    certNumber: string;
    dashboardUrl: string;
  }) {
    return wrapEmail(
      "Nouvel agent certifié — onboarding technique",
      `
      <h2 style="color:#1A1660; margin:0 0 12px; font-size:22px;">🎓 Nouvel agent certifié Klary</h2>
      <p style="color:#6E6A8E; margin:0 0 24px; font-size:14px;">
        L'agent ci-dessous vient de valider sa <strong>première certification</strong>. Merci de créer ses accès techniques dans la journée pour qu'il soit opérationnel.
      </p>

      <table role="presentation" width="100%" cellspacing="0" cellpadding="0" style="margin-bottom:24px;">
        <tr><td style="padding:8px 0; color:#6E6A8E; font-size:12px; font-weight:600; text-transform:uppercase; letter-spacing:0.05em;">Agent</td></tr>
        <tr><td style="padding:0 0 12px; color:#1F1B4B; font-size:16px;"><strong>${firstName} ${lastName}</strong><br><span style="color:#6E6A8E; font-size:13px;">Login app.klary.ch : ${userLoginEmail}</span></td></tr>
        <tr><td style="padding:8px 0; color:#6E6A8E; font-size:12px; font-weight:600; text-transform:uppercase; letter-spacing:0.05em;">Module validé</td></tr>
        <tr><td style="padding:0 0 12px; color:#1F1B4B; font-size:15px;"><strong>${moduleTitle}</strong> — certificat n° <code style="color:#F0651F;">${certNumber}</code></td></tr>
        <tr><td style="padding:8px 0; color:#6E6A8E; font-size:12px; font-weight:600; text-transform:uppercase; letter-spacing:0.05em;">Email pro Klary proposé</td></tr>
        <tr><td style="padding:0 0 12px; color:#F0651F; font-size:16px;"><strong>${proposedKlaryEmail}</strong></td></tr>
      </table>

      <div style="padding:16px 20px; background:#FAF5EF; border-left:4px solid #F0651F; border-radius:8px; margin:20px 0;">
        <div style="font-size:11px; color:#F0651F; font-weight:700; text-transform:uppercase; letter-spacing:0.1em; margin-bottom:10px;">✅ Checklist à effectuer aujourd'hui</div>
        <table role="presentation" width="100%" cellspacing="0" cellpadding="0" style="font-size:14px; color:#1F1B4B;">
          <tr>
            <td style="padding:8px 0; vertical-align:top; width:24px;">☐</td>
            <td style="padding:8px 0;"><strong>Créer l'adresse email pro sur Infomaniak</strong> : <code style="color:#F0651F;">${proposedKlaryEmail}</code><br><span style="color:#6E6A8E; font-size:12px;">Panneau Infomaniak → mail.infomaniak.com → nouvel utilisateur klary.ch. Pas de compte Gmail.</span></td>
          </tr>
          <tr>
            <td style="padding:8px 0; vertical-align:top;">☐</td>
            <td style="padding:8px 0;"><strong>Créer Google Agenda avec l'email Klary</strong><br><span style="color:#6E6A8E; font-size:12px;">Compte Google connecté avec <code>${proposedKlaryEmail}</code> (sans activer Gmail). Partager l'agenda à Sacha + assistantes.</span></td>
          </tr>
          <tr>
            <td style="padding:8px 0; vertical-align:top;">☐</td>
            <td style="padding:8px 0;"><strong>Créer Google Sheet de suivi avec l'email Klary</strong><br><span style="color:#6E6A8E; font-size:12px;">Sheet de suivi individuel copié depuis le template Klary. Partagé à Sacha + assistantes.</span></td>
          </tr>
          <tr>
            <td style="padding:8px 0; vertical-align:top;">☐</td>
            <td style="padding:8px 0;"><strong>Créer l'accès LYTA (CRM)</strong><br><span style="color:#6E6A8E; font-size:12px;">Compte LYTA avec l'email Klary. Rôle : agent. Portefeuille de leads à attribuer par le responsable.</span></td>
          </tr>
          <tr>
            <td style="padding:8px 0; vertical-align:top;">☐</td>
            <td style="padding:8px 0;"><strong>Transmettre les identifiants à l'agent</strong><br><span style="color:#6E6A8E; font-size:12px;">Email de bienvenue avec les logins créés — de préférence en présence de l'agent pour la 1re connexion.</span></td>
          </tr>
        </table>
      </div>

      <div style="padding:12px 16px; background:#fff; border:1px dashed #1A1660; border-radius:6px; margin:16px 0; font-size:13px; color:#1A1660;">
        ℹ <strong>Rappels importants :</strong><br>
        • Toutes les connexions (Google Agenda, Google Sheet, LYTA) se font avec <strong>l'email pro Klary</strong>, pas avec un email perso.<br>
        • <strong>Aucune boîte Gmail activée</strong> — l'email pro est uniquement sur Infomaniak. Google Workspace de l'agent = identité + Agenda + Sheet uniquement.<br>
        • Une fois la checklist terminée, marquez la candidature en statut <strong>« Actif »</strong> dans le backoffice pour déclencher l'email d'activation à l'agent.
      </div>

      <p style="color:#6E6A8E; margin:24px 0 0; font-size:13px; line-height:1.6;">
        Un souci technique ? <a href="mailto:it@klary.ch" style="color:#F0651F;">it@klary.ch</a>
      </p>
      `,
      { label: "Voir la fiche agent dans le backoffice", url: dashboardUrl }
    );
  },

  /**
   * Activation complète — accès portefeuille + CRM + email Klary
   */
  candidatureActivated({
    firstName,
    portalUrl,
    managerName,
    klaryEmail,
  }: {
    firstName: string;
    portalUrl: string;
    managerName?: string;
    klaryEmail?: string;
  }) {
    return wrapEmail(
      "Vous êtes activé·e — bienvenue en production",
      `
      <h2 style="color:#1A1660; margin:0 0 12px; font-size:24px;">Félicitations ${firstName} 🚀</h2>
      <p style="color:#1F1B4B; margin:0 0 20px; font-size:16px; line-height:1.6;">
        Votre certification FINMA + vos accès compagnies + vos certifications Klary sont validés. Vous êtes maintenant <strong>activé·e en production</strong>.
      </p>

      <div style="padding:20px; background:#FAF5EF; border-radius:12px; margin:24px 0; border:2px solid #F0651F;">
        <div style="font-size:12px; color:#F0651F; font-weight:700; text-transform:uppercase; letter-spacing:0.1em; margin-bottom:12px;">Vos accès sont maintenant actifs</div>
        <div style="font-size:14px; color:#1F1B4B; line-height:1.8;">
          ✔ <strong>Portefeuille de leads</strong> attribué et alimenté quotidiennement<br>
          ✔ <strong>Agenda CRM</strong> synchronisé avec vos RDV<br>
          ✔ <strong>Email professionnel</strong>${klaryEmail ? ` : <strong>${klaryEmail}</strong>` : " @klary.ch actif"}<br>
          ✔ <strong>Outils compagnies</strong> — saisie de dossiers directe<br>
          ✔ <strong>Accompagnement responsable</strong>${managerName ? ` par ${managerName}` : ""} sur vos premières semaines
        </div>
      </div>

      <p style="color:#1F1B4B; margin:0 0 16px; font-size:15px; line-height:1.6;">
        Vous êtes prêt·e à <strong>appeler, conseiller, signer</strong>. Votre responsable vous accompagnera sur vos premiers dossiers pour transformer votre formation en résultats.
      </p>
      <p style="color:#1F1B4B; margin:0 0 16px; font-size:15px; line-height:1.6;">
        La production, c'est maintenant. Bonne chance.
      </p>
      <p style="color:#6E6A8E; margin:24px 0 0; font-size:13px; line-height:1.6;">
        <strong style="color:#1A1660;">L'équipe Klary</strong>
      </p>
      `,
      { label: "Accéder à mon espace Klary", url: portalUrl }
    );
  },
};
