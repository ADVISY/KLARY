-- ═════════════════════════════════════════════════════════
-- Fix : autorise un utilisateur authentifié à créer sa propre
-- ligne user_roles + s'assurer que TOUS les user @klary.ch
-- existants ont bien une ligne
-- ═════════════════════════════════════════════════════════

-- Policy INSERT : un user authentifié peut insérer SA propre ligne (role forcé 'agent')
DROP POLICY IF EXISTS user_insert_own_role ON user_roles;
CREATE POLICY user_insert_own_role ON user_roles
  FOR INSERT WITH CHECK (
    auth.uid() = user_id
    AND role = 'agent'  -- On limite au role agent, admin/manager doivent être promus manuellement
  );

-- Correctif : créer les user_roles manquants pour tous les users @klary.ch déjà connectés
INSERT INTO user_roles (user_id, role, first_name, last_name, active)
SELECT
  u.id,
  'agent',
  COALESCE(NULLIF(split_part(split_part(u.email, '@', 1), '.', 1), ''), 'Prénom'),
  COALESCE(NULLIF(split_part(split_part(u.email, '@', 1), '.', 2), ''), 'Nom'),
  TRUE
FROM auth.users u
WHERE u.email LIKE '%@klary.ch'
  AND NOT EXISTS (
    SELECT 1 FROM user_roles r WHERE r.user_id = u.id
  );
