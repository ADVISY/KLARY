-- ═════════════════════════════════════════════════════════
-- Nouveau rôle : backoffice
--   • Accès limité : Bibliothèque + Candidatures + Messages contact
--   • Aucun accès aux autres modules admin
-- ═════════════════════════════════════════════════════════

-- 1. Contrainte CHECK : autoriser 'backoffice'
ALTER TABLE public.user_roles
  DROP CONSTRAINT IF EXISTS user_roles_role_check;

ALTER TABLE public.user_roles
  ADD CONSTRAINT user_roles_role_check
  CHECK (role IN ('admin', 'manager', 'agent', 'backoffice'));

-- 2. Fonction utilitaire : is_backoffice_or_above
--    (retourne true pour admin, manager, backoffice)
CREATE OR REPLACE FUNCTION public.is_backoffice_or_above()
RETURNS boolean
LANGUAGE sql
STABLE
SECURITY DEFINER
SET search_path = public
AS $$
  SELECT EXISTS (
    SELECT 1
    FROM public.user_roles
    WHERE user_id = auth.uid()
      AND role IN ('admin', 'manager', 'backoffice')
      AND active = true
  );
$$;

GRANT EXECUTE ON FUNCTION public.is_backoffice_or_above() TO authenticated;

-- 3. Élargir les RLS des 3 tables cibles
--    candidates
DROP POLICY IF EXISTS admin_all_candidates_v2 ON public.candidates;
CREATE POLICY admin_all_candidates_v2 ON public.candidates
  FOR ALL
  USING (public.is_backoffice_or_above())
  WITH CHECK (public.is_backoffice_or_above());

--    contact_messages
DROP POLICY IF EXISTS admin_all_contact_messages_v2 ON public.contact_messages;
CREATE POLICY admin_all_contact_messages_v2 ON public.contact_messages
  FOR ALL
  USING (public.is_backoffice_or_above())
  WITH CHECK (public.is_backoffice_or_above());

--    library_documents
DROP POLICY IF EXISTS admin_all_library_documents_v2 ON public.library_documents;
CREATE POLICY admin_all_library_documents_v2 ON public.library_documents
  FOR ALL
  USING (public.is_backoffice_or_above())
  WITH CHECK (public.is_backoffice_or_above());

-- 4. Aussi candidate_events (log lié aux candidatures)
DROP POLICY IF EXISTS admin_all_candidate_events_v2 ON public.candidate_events;
CREATE POLICY admin_all_candidate_events_v2 ON public.candidate_events
  FOR ALL
  USING (public.is_backoffice_or_above())
  WITH CHECK (public.is_backoffice_or_above());

-- 5. onboarding_forms (lié aux candidats hired)
DROP POLICY IF EXISTS admin_all_onboarding_forms_v2 ON public.onboarding_forms;
CREATE POLICY admin_all_onboarding_forms_v2 ON public.onboarding_forms
  FOR ALL
  USING (public.is_backoffice_or_above())
  WITH CHECK (public.is_backoffice_or_above());

-- 6. interview_slots (créneaux d'entretien)
DROP POLICY IF EXISTS admin_all_interview_slots_v2 ON public.interview_slots;
CREATE POLICY admin_all_interview_slots_v2 ON public.interview_slots
  FOR ALL
  USING (public.is_backoffice_or_above())
  WITH CHECK (public.is_backoffice_or_above());

COMMENT ON FUNCTION public.is_backoffice_or_above() IS
  'Retourne true si l''utilisateur est admin, manager ou backoffice. Utilisé pour élargir l''accès aux modules Candidatures + Contacts + Bibliothèque.';
