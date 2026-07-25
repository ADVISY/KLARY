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
          ${row("Nationalité", formData.nationality)}
          ${row("État civil", formData.marital_status)}
          ${row("N° AVS", formData.avs_number)}
          ${row("Enfants à charge", formData.children_count ? String(formData.children_count) : "—")}
          ${row("Permis de séjour", formData.residence_permit)}
        </table>
      </div>

      <div style="padding:16px 20px; background:#FAF5EF; border-radius:10px; margin-bottom:20px;">
        <div style="font-size:11px; color:#F0651F; font-weight:700; text-transform:uppercase; letter-spacing:0.1em; margin-bottom:10px;">Adresse</div>
        <table role="presentation" width="100%" cellspacing="0" cellpadding="0">
          ${row("Rue + numéro", formData.postal_street)}
          ${row("NPA + ville", [formData.postal_zip, formData.postal_city].filter(Boolean).join(" "))}
          ${row("Canton", formData.postal_canton)}
        </table>
      </div>

      <div style="padding:16px 20px; background:#FAF5EF; border-radius:10px; margin-bottom:20px;">
        <div style="font-size:11px; color:#F0651F; font-weight:700; text-transform:uppercase; letter-spacing:0.1em; margin-bottom:10px;">Banque (virement salaire)</div>
        <table role="presentation" width="100%" cellspacing="0" cellpadding="0">
          ${row("IBAN", formData.bank_iban)}
          ${row("Nom banque", formData.bank_name)}
          ${row("Titulaire compte", formData.bank_holder)}
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
