-- ═════════════════════════════════════════════════════════
-- Un webhook Zapier PAR SOURCE.
--
-- Les demandes de subside et les demandes d'assurance ne vont pas dans la
-- même feuille et ne se traitent pas pareil : chacune a donc son Zap.
-- La fonction cherche d'abord la clé de sa source, puis retombe sur une clé
-- générique si elle existe, et ne fait rien si aucune n'est configurée.
--
--   zapier_site_leads_url_subside   demandes de subside
--   zapier_site_leads_url_maladie   demandes d'assurance maladie
--   zapier_site_leads_url           repli commun, facultatif
-- ═════════════════════════════════════════════════════════

CREATE OR REPLACE FUNCTION public.notify_site_lead()
RETURNS TRIGGER
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public, net
AS $$
DECLARE
  hook_url TEXT;
  answers  JSONB := COALESCE(NEW.answers, '{}'::jsonb);
BEGIN
  -- La clé de la source d'abord, le repli commun ensuite.
  SELECT value INTO hook_url
  FROM app_config
  WHERE key = 'zapier_site_leads_url_' || NEW.source;

  IF hook_url IS NULL OR hook_url = '' THEN
    SELECT value INTO hook_url FROM app_config WHERE key = 'zapier_site_leads_url';
  END IF;

  -- Aucune URL : on ne fait rien, et surtout on ne casse pas l'enregistrement.
  IF hook_url IS NULL OR hook_url = '' THEN
    RETURN NEW;
  END IF;

  PERFORM net.http_post(
    url     := hook_url,
    headers := '{"Content-Type": "application/json"}'::jsonb,
    body    := jsonb_build_object(
      'id',            NEW.id,
      'recu_le',       to_char(NEW.created_at AT TIME ZONE 'Europe/Zurich', 'DD.MM.YYYY HH24:MI'),
      'source',        NEW.source,
      'campagne',      NEW.campaign,
      'prenom',        NEW.first_name,
      'nom',           NEW.last_name,
      'email',         NEW.email,
      'telephone',     NEW.phone,
      'canton',        COALESCE(NEW.canton, ''),
      'code_postal',   COALESCE(NEW.postal_code, ''),
      'date_naissance', COALESCE(to_char(NEW.birth_date, 'DD.MM.YYYY'), ''),
      'statut_lie_accepte', NEW.consent_tied,
      'page',          COALESCE(NEW.page_url, ''),
      'assureur_actuel',    COALESCE(answers->>'currentInsurer', ''),
      'situation_familiale', COALESCE(answers->>'familySituation', ''),
      'modele_lamal',       COALESCE(answers->>'lamalModel', ''),
      'franchise',          COALESCE(answers->>'franchise', ''),
      'taille_menage',      COALESCE(answers->>'householdSize', ''),
      'tranche_revenu',     COALESCE(answers->>'incomeRange', ''),
      'situation_particuliere', COALESCE(answers->>'specialSituation', ''),
      'disponibilite',      COALESCE(answers->>'availability', ''),
      'reponses_completes', answers
    )
  );

  RETURN NEW;
EXCEPTION
  WHEN OTHERS THEN
    RAISE WARNING 'notify_site_lead: envoi Zapier impossible (%)', SQLERRM;
    RETURN NEW;
END;
$$;

COMMENT ON FUNCTION public.notify_site_lead() IS
  'Envoie chaque nouvelle demande au Zap de sa source (clé zapier_site_leads_url_<source> dans app_config), avec repli sur zapier_site_leads_url. Sans URL configurée, ne fait rien.';
