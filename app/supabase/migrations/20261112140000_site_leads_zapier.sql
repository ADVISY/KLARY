-- ═════════════════════════════════════════════════════════
-- Envoi automatique des demandes du site vers Zapier.
--
-- Choix de conception : l'appel part de la BASE, pas du navigateur.
--   • l'URL du webhook ne se retrouve pas dans le bundle public, donc
--     personne ne peut arroser la feuille Google de fausses lignes ;
--   • tout ce qui est enregistré est envoyé, y compris si le visiteur
--     ferme son onglet dans la seconde qui suit ;
--   • l'envoi est asynchrone : il ne retarde ni ne fait échouer le
--     formulaire du prospect.
--
-- Même logique que chez Optimis, où l'URL du canal vit en base et jamais
-- dans le code client.
-- ═════════════════════════════════════════════════════════

-- pg_net installe ses fonctions dans le schema `net` (verifie sur le projet).
CREATE EXTENSION IF NOT EXISTS pg_net;

-- ── Réglages internes ───────────────────────────────────────────────────
-- Table de configuration, volontairement sans aucune policy : elle n'est
-- donc lisible ni par le public ni par un utilisateur connecté. Seul le
-- rôle de service y accède, ce qui est exactement ce qu'on veut pour une
-- URL secrète.
CREATE TABLE IF NOT EXISTS app_config (
  key   TEXT PRIMARY KEY,
  value TEXT NOT NULL,
  note  TEXT,
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

ALTER TABLE app_config ENABLE ROW LEVEL SECURITY;

COMMENT ON TABLE app_config IS
  'Réglages internes (URL de webhook, etc.). Aucune policy : inaccessible depuis le client, par conception.';

-- ── Déclencheur ─────────────────────────────────────────────────────────
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
  SELECT value INTO hook_url FROM app_config WHERE key = 'zapier_site_leads_url';

  -- Pas d'URL configurée : on ne fait rien, et surtout on ne casse pas
  -- l'enregistrement de la demande.
  IF hook_url IS NULL OR hook_url = '' THEN
    RETURN NEW;
  END IF;

  -- Charge utile à plat : une clé par colonne de feuille de calcul.
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
      -- Réponses les plus utiles, remontées à plat pour la feuille
      'assureur_actuel',    COALESCE(answers->>'currentInsurer', ''),
      'situation_familiale', COALESCE(answers->>'familySituation', ''),
      'modele_lamal',       COALESCE(answers->>'lamalModel', ''),
      'franchise',          COALESCE(answers->>'franchise', ''),
      'taille_menage',      COALESCE(answers->>'householdSize', ''),
      'tranche_revenu',     COALESCE(answers->>'incomeRange', ''),
      'situation_particuliere', COALESCE(answers->>'specialSituation', ''),
      'disponibilite',      COALESCE(answers->>'availability', ''),
      -- Et l'intégralité, pour ne rien perdre
      'reponses_completes', answers
    )
  );

  RETURN NEW;
EXCEPTION
  -- Un webhook en panne ne doit jamais faire perdre une demande :
  -- la ligne reste en base, seul l'envoi est manqué.
  WHEN OTHERS THEN
    RAISE WARNING 'notify_site_lead: envoi Zapier impossible (%)', SQLERRM;
    RETURN NEW;
END;
$$;

DROP TRIGGER IF EXISTS trg_site_leads_zapier ON site_leads;
CREATE TRIGGER trg_site_leads_zapier
  AFTER INSERT ON site_leads
  FOR EACH ROW EXECUTE FUNCTION public.notify_site_lead();

COMMENT ON FUNCTION public.notify_site_lead() IS
  'Envoie chaque nouvelle demande du site au webhook Zapier défini dans app_config (clé zapier_site_leads_url). Sans URL configurée, ne fait rien.';

-- ── Activation ──────────────────────────────────────────────────────────
-- Coller l'URL du Zap une seule fois, puis le flux démarre :
--
--   INSERT INTO app_config (key, value, note)
--   VALUES ('zapier_site_leads_url',
--           'https://hooks.zapier.com/hooks/catch/XXXXX/YYYYY/',
--           'Demandes des pages d''offre vers la feuille Google')
--   ON CONFLICT (key) DO UPDATE
--     SET value = EXCLUDED.value, updated_at = now();
