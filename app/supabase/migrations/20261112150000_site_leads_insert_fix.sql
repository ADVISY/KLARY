-- ═════════════════════════════════════════════════════════
-- Correctif de la policy d'insertion publique de `site_leads`.
--
-- Le formulaire du site n'envoie pas la colonne `status` : elle doit prendre
-- sa valeur par défaut. Or la policy exigeait `status = 'nouveau'`, condition
-- qui n'est pas vraie pour une colonne absente de l'ordre INSERT. Résultat :
-- toute demande partie du site était refusée par RLS, avec un 401 et le
-- message « new row violates row-level security policy ».
--
-- On garde la protection voulue, à savoir qu'un visiteur ne peut pas se
-- déclarer « signé » ni s'attribuer un lead, mais on accepte l'absence de
-- valeur, qui veut dire « prends la valeur par défaut ».
-- ═════════════════════════════════════════════════════════

DROP POLICY IF EXISTS site_leads_insert_public ON site_leads;
CREATE POLICY site_leads_insert_public ON site_leads
  FOR INSERT TO anon, authenticated
  WITH CHECK (
    (status IS NULL OR status = 'nouveau')
    AND assigned_to IS NULL
    AND notes IS NULL
  );

COMMENT ON POLICY site_leads_insert_public ON site_leads IS
  'Dépôt public d''une demande. `status` peut être absent (valeur par défaut) mais jamais autre chose que nouveau ; ni assignation ni note depuis le site.';
