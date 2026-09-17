-- ═════════════════════════════════════════════════════════
-- Klary — Cible interne AFA 80 %
--
-- Le seuil VBV officiel est 60 % (art. 3.73 / 8.11). Klary vise plus
-- haut en interne pour donner une marge de sécurité au candidat :
-- si le conseiller atteint 80 % sur la plateforme Klary, il a très
-- forte probabilité de passer les 60 % en épreuve réelle VBV.
--
-- On garde `passing_pct` = 60 (référence VBV) et on ajoute
-- `internal_target_pct` = 80 (cible affichée + statut « réussi »).
-- ═════════════════════════════════════════════════════════

ALTER TABLE afa_filieres
  ADD COLUMN IF NOT EXISTS internal_target_pct INT NOT NULL DEFAULT 80
    CHECK (internal_target_pct BETWEEN 0 AND 100);

COMMENT ON COLUMN afa_filieres.passing_pct IS
  'Seuil VBV officiel (60 %). Ne pas modifier.';
COMMENT ON COLUMN afa_filieres.internal_target_pct IS
  'Cible interne Klary (80 % par défaut). Sert de base au statut « réussi » côté plateforme et à l''affichage de progression.';

-- S'assurer que toutes les filières existantes ont bien 80 comme cible
-- interne (au cas où DEFAULT n'ait pas rétro-agi sur les lignes existantes)
UPDATE afa_filieres SET internal_target_pct = 80 WHERE internal_target_pct IS NULL OR internal_target_pct < 80;
