-- ═════════════════════════════════════════════════════════
-- Fix : récursion infinie sur les policies user_roles
-- Cause : admin_all_user_roles fait un EXISTS sur user_roles
--        qui redéclenche la même policy → boucle infinie.
-- Fix   : encapsuler la vérification dans une fonction
--        SECURITY DEFINER qui bypass la RLS.
-- ═════════════════════════════════════════════════════════

-- 1. Fonction helper SECURITY DEFINER : bypass RLS pour lire user_roles
CREATE OR REPLACE FUNCTION public.is_admin_or_manager()
RETURNS BOOLEAN
LANGUAGE sql
STABLE
SECURITY DEFINER
SET search_path = public
AS $$
  SELECT EXISTS (
    SELECT 1 FROM public.user_roles
    WHERE user_id = auth.uid()
      AND role IN ('admin', 'manager')
      AND active = TRUE
  );
$$;

GRANT EXECUTE ON FUNCTION public.is_admin_or_manager() TO authenticated, anon, service_role;

-- 2. Recréer toutes les policies admin en utilisant la fonction
DROP POLICY IF EXISTS admin_all_user_roles ON user_roles;
CREATE POLICY admin_all_user_roles ON user_roles
  FOR ALL USING (public.is_admin_or_manager());

DROP POLICY IF EXISTS admin_all_contact ON contact_messages;
CREATE POLICY admin_all_contact ON contact_messages
  FOR ALL USING (public.is_admin_or_manager());

DROP POLICY IF EXISTS admin_all_candidates ON candidates;
CREATE POLICY admin_all_candidates ON candidates
  FOR ALL USING (public.is_admin_or_manager());

DROP POLICY IF EXISTS admin_all_modules ON training_modules;
CREATE POLICY admin_all_modules ON training_modules
  FOR ALL USING (public.is_admin_or_manager());

DROP POLICY IF EXISTS admin_all_questions ON training_questions;
CREATE POLICY admin_all_questions ON training_questions
  FOR ALL USING (public.is_admin_or_manager());

DROP POLICY IF EXISTS admin_all_attempts ON training_attempts;
CREATE POLICY admin_all_attempts ON training_attempts
  FOR SELECT USING (public.is_admin_or_manager());

DROP POLICY IF EXISTS admin_all_certifications ON training_certifications;
CREATE POLICY admin_all_certifications ON training_certifications
  FOR ALL USING (public.is_admin_or_manager());
