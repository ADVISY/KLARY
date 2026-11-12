-- ═════════════════════════════════════════════════════════
-- Charge utile Zapier alignée sur les colonnes réelles des feuilles.
--
-- Deux corrections par rapport à la version précédente :
--
-- 1. On envoie des LIBELLÉS, plus des valeurs techniques. Le tunnel stocke
--    `groupe-mutuel`, `45-60`, `single`, `true` ; le conseiller qui ouvre la
--    feuille doit lire « Groupe Mutuel », « 45 000 à 60 000 CHF », « Seul(e) »,
--    « Oui ». Le formulaire joint désormais ces libellés sous `_labels`, et on
--    les préfère systématiquement, avec repli sur la valeur brute.
--
-- 2. Toutes les colonnes des deux feuilles ont leur clé, y compris celles qui
--    n'existaient pas : couverture accident, complémentaires, franchise du
--    tunnel subside, composition du foyer. Les colonnes que l'équipe remplit
--    après coup (Fiche PDF, Broker, RDV) partent vides plutôt qu'absentes,
--    pour que la ligne ait toujours la même forme.
--
-- Les deux feuilles ne nomment pas tout pareil (« Situation familiale » côté
-- santé, « Composition du foyer » côté subside) : on envoie les deux clés avec
-- la même valeur, chaque Zap prend celle qui lui parle.
-- ═════════════════════════════════════════════════════════

CREATE OR REPLACE FUNCTION public.notify_site_lead()
RETURNS TRIGGER
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public, net
AS $$
DECLARE
  hook_url TEXT;
  a        JSONB := COALESCE(NEW.answers, '{}'::jsonb);
  lbl      JSONB := COALESCE(NEW.answers->'_labels', '{}'::jsonb);
BEGIN
  SELECT value INTO hook_url
  FROM app_config
  WHERE key = 'zapier_site_leads_url_' || NEW.source;

  IF hook_url IS NULL OR hook_url = '' THEN
    SELECT value INTO hook_url FROM app_config WHERE key = 'zapier_site_leads_url';
  END IF;

  IF hook_url IS NULL OR hook_url = '' THEN
    RETURN NEW;
  END IF;

  PERFORM net.http_post(
    url     := hook_url,
    headers := '{"Content-Type": "application/json"}'::jsonb,
    body    := jsonb_build_object(
      -- Identification
      'lead_id',   NEW.id,
      'source',    NEW.source,
      'campagne',  NEW.campaign,
      'date',      to_char(NEW.created_at AT TIME ZONE 'Europe/Zurich', 'DD.MM.YYYY HH24:MI'),
      'page',      COALESCE(NEW.page_url, ''),

      -- Contact
      'prenom',    NEW.first_name,
      'nom',       NEW.last_name,
      'email',     NEW.email,
      'telephone', NEW.phone,

      -- Situation
      'canton',         COALESCE(NULLIF(lbl->>'canton', ''), NEW.canton, ''),
      'code_postal',    COALESCE(NEW.postal_code, ''),
      'date_naissance', COALESCE(to_char(NEW.birth_date, 'DD.MM.YYYY'), ''),

      'assurance_actuelle', COALESCE(NULLIF(lbl->>'hasCurrentInsurance', ''), a->>'hasCurrentInsurance', ''),
      'assureur_actuel',    COALESCE(NULLIF(lbl->>'currentInsurer', ''), a->>'currentInsurer', ''),

      -- Le même champ porte deux noms selon la feuille
      'situation_familiale', COALESCE(NULLIF(lbl->>'familySituation', ''), a->>'familySituation', ''),
      'composition_foyer',   COALESCE(NULLIF(lbl->>'familySituation', ''), a->>'familySituation', ''),

      -- Assurance maladie
      'modele_lamal',       COALESCE(NULLIF(lbl->>'lamalModel', ''), a->>'lamalModel', ''),
      'franchise',          COALESCE(NULLIF(lbl->>'franchise', ''), NULLIF(lbl->>'currentFranchise', ''), a->>'franchise', a->>'currentFranchise', ''),
      'franchise_actuelle', COALESCE(NULLIF(lbl->>'currentFranchise', ''), NULLIF(lbl->>'franchise', ''), a->>'currentFranchise', a->>'franchise', ''),
      'couverture_accident', COALESCE(NULLIF(lbl->>'accidentCoverage', ''), a->>'accidentCoverage', ''),

      -- Complémentaires : une colonne Oui/Non et une colonne détail
      'complementaires', CASE
        WHEN COALESCE(lbl->>'interestsCount', '0') = '0' THEN 'Non'
        ELSE 'Oui'
      END,
      'complementaire_options', COALESCE(NULLIF(lbl->>'interests', ''), ''),

      -- Subside
      'revenu_annuel',         COALESCE(NULLIF(lbl->>'incomeRange', ''), a->>'incomeRange', ''),
      'situation_particuliere', COALESCE(NULLIF(lbl->>'specialSituation', ''), a->>'specialSituation', ''),

      -- Suivi commercial
      'disponibilite', COALESCE(NULLIF(lbl->>'availability', ''), a->>'availability', ''),
      'statut_lie_accepte', CASE WHEN NEW.consent_tied THEN 'Oui' ELSE 'Non' END,

      -- Colonnes remplies par l'équipe, envoyées vides pour garder la forme
      'fiche_pdf', '',
      'broker',    '',
      'rdv',       '',

      -- Et l'intégralité, pour ne rien perdre
      'reponses_completes', a - '_labels'
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
  'Envoie chaque nouvelle demande au Zap de sa source, en libellés lisibles, avec une clé par colonne des feuilles santé et subside.';
