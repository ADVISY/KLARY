-- ═════════════════════════════════════════════════════════
-- Klary — RLS du module révision AFA
-- Même modèle que training_* : l'utilisateur ne voit que ses
-- propres sessions/réponses ; admin et manager voient tout.
-- ═════════════════════════════════════════════════════════

ALTER TABLE afa_filieres         ENABLE ROW LEVEL SECURITY;
ALTER TABLE afa_themes           ENABLE ROW LEVEL SECURITY;
ALTER TABLE afa_notions          ENABLE ROW LEVEL SECURITY;
ALTER TABLE afa_questions        ENABLE ROW LEVEL SECURITY;
ALTER TABLE afa_question_notions ENABLE ROW LEVEL SECURITY;
ALTER TABLE afa_sessions         ENABLE ROW LEVEL SECURITY;
ALTER TABLE afa_answers          ENABLE ROW LEVEL SECURITY;
ALTER TABLE afa_fiches           ENABLE ROW LEVEL SECURITY;

-- ───────── Contenu pédagogique : lecture pour tout authentifié ─────────
CREATE POLICY afa_read_filieres ON afa_filieres
  FOR SELECT USING (auth.role() = 'authenticated' AND active);
CREATE POLICY afa_read_themes ON afa_themes
  FOR SELECT USING (auth.role() = 'authenticated' AND active);
CREATE POLICY afa_read_notions ON afa_notions
  FOR SELECT USING (auth.role() = 'authenticated');
CREATE POLICY afa_read_question_notions ON afa_question_notions
  FOR SELECT USING (auth.role() = 'authenticated');
CREATE POLICY afa_read_fiches ON afa_fiches
  FOR SELECT USING (auth.role() = 'authenticated' AND active);

-- Les questions sont lisibles, mais l'API ne renvoie jamais `options`
-- brut pendant une session en cours (le corrigé y figure) : le filtrage
-- des bonnes réponses se fait côté route serveur, pas ici.
CREATE POLICY afa_read_questions ON afa_questions
  FOR SELECT USING (auth.role() = 'authenticated' AND active);

-- ───────── Données personnelles : chacun les siennes ─────────
CREATE POLICY afa_own_sessions_select ON afa_sessions
  FOR SELECT USING (auth.uid() = user_id);
CREATE POLICY afa_own_sessions_insert ON afa_sessions
  FOR INSERT WITH CHECK (auth.uid() = user_id);
CREATE POLICY afa_own_sessions_update ON afa_sessions
  FOR UPDATE USING (auth.uid() = user_id);

CREATE POLICY afa_own_answers_select ON afa_answers
  FOR SELECT USING (
    EXISTS (SELECT 1 FROM afa_sessions s WHERE s.id = session_id AND s.user_id = auth.uid())
  );
CREATE POLICY afa_own_answers_insert ON afa_answers
  FOR INSERT WITH CHECK (
    EXISTS (SELECT 1 FROM afa_sessions s WHERE s.id = session_id AND s.user_id = auth.uid())
  );
CREATE POLICY afa_own_answers_update ON afa_answers
  FOR UPDATE USING (
    EXISTS (SELECT 1 FROM afa_sessions s WHERE s.id = session_id AND s.user_id = auth.uid())
  );

-- ───────── Admin / manager : accès complet ─────────
CREATE POLICY afa_admin_filieres ON afa_filieres FOR ALL USING (
  EXISTS (SELECT 1 FROM user_roles r WHERE r.user_id = auth.uid() AND r.role IN ('admin','manager') AND r.active));
CREATE POLICY afa_admin_themes ON afa_themes FOR ALL USING (
  EXISTS (SELECT 1 FROM user_roles r WHERE r.user_id = auth.uid() AND r.role IN ('admin','manager') AND r.active));
CREATE POLICY afa_admin_notions ON afa_notions FOR ALL USING (
  EXISTS (SELECT 1 FROM user_roles r WHERE r.user_id = auth.uid() AND r.role IN ('admin','manager') AND r.active));
CREATE POLICY afa_admin_questions ON afa_questions FOR ALL USING (
  EXISTS (SELECT 1 FROM user_roles r WHERE r.user_id = auth.uid() AND r.role IN ('admin','manager') AND r.active));
CREATE POLICY afa_admin_question_notions ON afa_question_notions FOR ALL USING (
  EXISTS (SELECT 1 FROM user_roles r WHERE r.user_id = auth.uid() AND r.role IN ('admin','manager') AND r.active));
CREATE POLICY afa_admin_fiches ON afa_fiches FOR ALL USING (
  EXISTS (SELECT 1 FROM user_roles r WHERE r.user_id = auth.uid() AND r.role IN ('admin','manager') AND r.active));
CREATE POLICY afa_admin_sessions ON afa_sessions FOR SELECT USING (
  EXISTS (SELECT 1 FROM user_roles r WHERE r.user_id = auth.uid() AND r.role IN ('admin','manager') AND r.active));
CREATE POLICY afa_admin_answers ON afa_answers FOR SELECT USING (
  EXISTS (SELECT 1 FROM user_roles r WHERE r.user_id = auth.uid() AND r.role IN ('admin','manager') AND r.active));
