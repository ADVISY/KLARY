-- ═════════════════════════════════════════════════════════
-- Attribuer le rôle 'backoffice' à Rinah (utilisateur existant)
--
-- Prérequis : Rinah s'est déjà connectée UNE fois (email @klary.ch),
--             donc son compte auth.users existe.
--
-- Comment lancer :
--   Dans Supabase Dashboard > SQL Editor, colle et exécute.
--   OU via CLI : supabase db execute --file create-rinah-backoffice.sql
-- ═════════════════════════════════════════════════════════

-- 1. Trouver l'ID de Rinah (à adapter avec son email exact)
DO $$
DECLARE
  rinah_id UUID;
BEGIN
  SELECT id INTO rinah_id
  FROM auth.users
  WHERE email = 'backoffice@klary.ch'  -- ⚠ à ajuster si autre email
  LIMIT 1;

  IF rinah_id IS NULL THEN
    RAISE NOTICE 'Aucun utilisateur trouvé avec email backoffice@klary.ch. Elle doit se connecter une fois d''abord.';
    RETURN;
  END IF;

  -- 2. Désactiver tout autre rôle actif éventuel
  UPDATE public.user_roles
  SET active = false, updated_at = NOW()
  WHERE user_id = rinah_id AND active = true;

  -- 3. Insérer le rôle backoffice
  INSERT INTO public.user_roles (
    user_id, role, first_name, last_name, profile_completed, active,
    created_at, updated_at
  )
  VALUES (
    rinah_id,
    'backoffice',
    'Rinah',
    NULL,
    true,
    true,
    NOW(),
    NOW()
  );

  RAISE NOTICE 'Rôle backoffice attribué à Rinah (%)', rinah_id;
END $$;
