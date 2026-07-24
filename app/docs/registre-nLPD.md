# Registre des traitements — nLPD

**Klary Sàrl** · en application de l'art. 12 nLPD (obligation de tenir un registre).

## Responsable du traitement

**Klary Sàrl**
Route de Lausanne 31 · 1052 Le Mont-sur-Lausanne
admin@klary.ch

Représentante légale : Anisa Sadiq, gérante.

## Sous-responsable interne

Sacha Bacconnier — responsable d'agence Vaud (accès admin RH).

## Traitements effectués

### Traitement 1 — Candidatures externes

| Élément | Valeur |
|---|---|
| **Finalité** | Traitement des candidatures pour recrutement d'agents Klary |
| **Base légale** | Consentement explicite du candidat (art. 6 nLPD) |
| **Personnes concernées** | Candidats externes ayant postulé via `app.klary.ch/postuler` |
| **Catégories de données** | Nom, prénom, email, téléphone, CV (PDF), lettre motivation |
| **Sous-traitants** | Supabase (hébergement EU-Central-1) · Resend (email transactionnel) |
| **Transferts hors CH/UE** | Aucun. Données stockées en Europe (Francfort). |
| **Durée de conservation** | 12 mois maximum à compter du dépôt · suppression automatique |
| **Droit d'accès** | Endpoint `/candidat/moi` avec vérification email |
| **Droit d'effacement** | Endpoint `/candidat/effacer` — traitement < 30 jours |
| **Mesures de sécurité** | Chiffrement au repos (AES-256) · signed URLs · RLS activé · audit trail |

### Traitement 2 — Formation et certification des agents

| Élément | Valeur |
|---|---|
| **Finalité** | Formation continue et certification interne des agents Klary |
| **Base légale** | Contrat de travail (art. 328a CO — obligation de formation) |
| **Personnes concernées** | Agents et managers salariés Klary Sàrl |
| **Catégories de données** | Nom, prénom, email @klary.ch, résultats évaluations, certifications |
| **Sous-traitants** | Supabase · Resend |
| **Transferts hors CH/UE** | Aucun |
| **Durée de conservation** | Durée du contrat + 10 ans (art. 962 CO — conservation registres) |
| **Droit d'accès** | Portail agent — accès à son historique complet |
| **Mesures de sécurité** | Auth magic link · RLS · audit trail |

### Traitement 3 — Anti-triche pendant les évaluations

| Élément | Valeur |
|---|---|
| **Finalité** | Prévention de la triche pendant les évaluations de certification |
| **Base légale** | Contrat de travail + consentement explicite avant chaque évaluation |
| **Personnes concernées** | Agents en cours d'évaluation |
| **Catégories de données** | Événements de perte de focus / changement d'onglet (métadonnées) |
| **Vidéo/webcam** | ❌ NON — pas d'enregistrement vidéo actuellement |
| **Durée de conservation** | 12 mois (audit de la certification) |
| **Mesures de sécurité** | Stockage limité aux métadonnées, pas de contenu visuel |

## Sécurité générale

- Chiffrement TLS 1.3 pour toutes les communications
- Chiffrement au repos AES-256 (Supabase Storage)
- Row-Level Security (RLS) activé sur toutes les tables sensibles
- Sauvegardes quotidiennes chiffrées (rétention 7 jours)
- Journal d'audit sur toutes les actions admin (`candidate_events`)
- Accès admin limité (Anisa + Sacha uniquement)
- Rotation des clés API tous les 6 mois

## Procédure en cas de fuite de données

1. Détection → notification immédiate au responsable (Anisa)
2. Évaluation de la gravité et du périmètre
3. Notification au **PFPDT** (Préposé fédéral à la protection des données) sous **72 heures** si risque élevé
4. Notification aux personnes concernées si risque élevé pour leurs droits et libertés
5. Documentation complète de l'incident dans un registre séparé

## Contact PFPDT

Préposé fédéral à la protection des données et à la transparence
Feldeggweg 1 · 3003 Berne
+41 58 462 43 95 · https://www.edoeb.admin.ch

## Contact interne pour questions nLPD

Anisa Sadiq — admin@klary.ch — sujet : `[nLPD]`

Délai de réponse maximum : 30 jours (art. 25 nLPD).
