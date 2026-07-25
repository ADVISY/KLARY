-- ═════════════════════════════════════════════════════════
-- Klary — Extension profil agent + storage bucket CV
-- ═════════════════════════════════════════════════════════

-- ─── Extension user_roles : infos personnelles agent ───
ALTER TABLE user_roles
  ADD COLUMN IF NOT EXISTS date_of_birth DATE,
  ADD COLUMN IF NOT EXISTS phone TEXT,
  ADD COLUMN IF NOT EXISTS postal_street TEXT,
  ADD COLUMN IF NOT EXISTS postal_zip TEXT,
  ADD COLUMN IF NOT EXISTS postal_city TEXT,
  ADD COLUMN IF NOT EXISTS postal_country TEXT DEFAULT 'Suisse',
  ADD COLUMN IF NOT EXISTS profile_completed BOOLEAN DEFAULT FALSE;

-- Fonction pour marquer profile_completed = TRUE quand toutes les infos requises sont là
CREATE OR REPLACE FUNCTION check_profile_completion()
RETURNS TRIGGER AS $$
BEGIN
  IF NEW.first_name IS NOT NULL AND length(trim(NEW.first_name)) > 0
     AND NEW.last_name IS NOT NULL AND length(trim(NEW.last_name)) > 0
     AND NEW.date_of_birth IS NOT NULL
     AND NEW.postal_street IS NOT NULL AND length(trim(NEW.postal_street)) > 0
     AND NEW.postal_zip IS NOT NULL AND length(trim(NEW.postal_zip)) > 0
     AND NEW.postal_city IS NOT NULL AND length(trim(NEW.postal_city)) > 0
  THEN
    NEW.profile_completed := TRUE;
  ELSE
    NEW.profile_completed := FALSE;
  END IF;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trg_check_profile_completion ON user_roles;
CREATE TRIGGER trg_check_profile_completion
  BEFORE INSERT OR UPDATE ON user_roles
  FOR EACH ROW EXECUTE FUNCTION check_profile_completion();

-- Policy : agent peut mettre à jour son propre profil
DROP POLICY IF EXISTS user_update_own_profile ON user_roles;
CREATE POLICY user_update_own_profile ON user_roles
  FOR UPDATE USING (auth.uid() = user_id);

-- ─── Storage bucket CV : instructions ───
-- À créer manuellement dans Supabase Dashboard → Storage :
--   Nom du bucket : cvs
--   Public : NON (privé)
--   Signed URLs seulement
-- Puis policies à créer :
--   • INSERT public (formulaire postuler) — mais on le fait via service_role donc pas besoin de policy publique
--   • SELECT admin/manager uniquement
