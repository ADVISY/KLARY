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

      <p style="color:#6E6A8E; margin:16px 0 24px; font-size:13px; line-height:1.6;">
        L'entretien se tiendra en visio (Google Meet) — le lien de connexion vous sera envoyé après confirmation. Si aucun de ces créneaux ne vous convient, contactez-nous directement à <a href="mailto:rh@klary.ch" style="color:#F0651F;">rh@klary.ch</a>.
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
        <div style="font-size:11px; color:#6E6A8E; font-weight:600; text-transform:uppercase; letter-spacing:0.05em; margin-bottom:6px;">Date & heure</div>
        <div style="font-size:18px; color:#1A1660; font-weight:700;">${slotLabel}</div>
      </div>
      <p style="color:#1F1B4B; margin:0 0 16px; font-size:15px; line-height:1.6;">
        Vous recevrez le lien Google Meet 24h avant le rendez-vous à cette même adresse. Merci de tester votre caméra et micro en amont.
      </p>
      <p style="color:#1F1B4B; margin:0 0 16px; font-size:15px; line-height:1.6;">
        Si un empêchement survient, prévenez-nous dès que possible à <a href="mailto:rh@klary.ch" style="color:#F0651F;">rh@klary.ch</a>.
      </p>
      <p style="color:#6E6A8E; margin:24px 0 0; font-size:13px; line-height:1.6;">
        À très bientôt,<br>
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
      </table>
      <p style="color:#6E6A8E; font-size:13px; margin-top:20px;">
        Pensez à envoyer le lien Google Meet 24h avant.
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
  }: {
    firstName: string;
    positionApplied?: string;
    portalUrl: string;
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
