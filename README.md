# Klary — App interne Formation & Certification

Application déployée sur **`app.klary.ch`** — module de formation et certification interne des agents Klary.

## 🎯 Périmètre exact

Cette app **complète** le site principal `klary.ch` (dossier `/website/` en Vite/React) déjà en production.

| App | URL | Rôle |
|---|---|---|
| **Site principal** (existant) | `klary.ch` | Marketing · formulaire contact · candidatures · CRM · IA chatbot |
| **App formation** (ce repo) | `app.klary.ch` | Évaluation & certification interne des agents Klary |

**Base Supabase dédiée** : `ezhgsurhnyszhjixybak` (projet dédié à cette app, distinct du site principal).

## 🏗️ Stack

- **Frontend** : Next.js 14 (App Router) + TypeScript + Tailwind CSS
- **Backend** : Supabase existant (project `ezhgsurhnyszhjixybak`)
- **Emails** : Edge Functions Supabase (Resend intégré via `send-crm-email` existant)
- **Hosting** : Vercel · custom domain `app.klary.ch`
- **PDF** : `@react-pdf/renderer` côté serveur pour les certificats

## 🗄️ Ajouts à la base Supabase existante

Une seule migration : `supabase/migrations/20260724120000_training_module.sql`

4 nouvelles tables (préfixées `training_*` pour ne pas polluer l'existant) :
- `training_modules` — 4 modules (maladie · lpp · prévoyance · hypothèque)
- `training_questions` — banque de questions par module
- `training_attempts` — tentatives d'évaluation par utilisateur
- `training_certifications` — attestations délivrées

**Ne duplique rien de l'existant** : utilise `auth.users` et `user_roles` déjà en place.

## 🚀 Application de la migration

```bash
# Installer Supabase CLI si besoin
brew install supabase/tap/supabase

# Se lier au projet existant
cd klary-app
supabase link --project-ref ezhgsurhnyszhjixybak

# Appliquer la migration
supabase db push
```

**Créer aussi le bucket Storage :**
Dashboard Supabase → Storage → New bucket → `training-certificates` → **PRIVATE**

## 📁 Structure prévue

```
klary-app/
├── src/
│   ├── app/
│   │   ├── (auth)/                # Login magic link
│   │   ├── formation/             # Sélection module + évaluation
│   │   ├── certifications/        # Historique certifs de l'agent
│   │   ├── admin/                 # Backoffice questions + résultats
│   │   └── api/
│   │       ├── training/          # Endpoints attempts / certifs
│   │       └── send-certificate/  # Envoi email + génération PDF
│   ├── components/
│   ├── lib/
│   │   ├── supabase/              # Clients (server + client)
│   │   └── training/              # Logique quiz + anti-triche + scoring
│   └── styles/
├── supabase/
│   └── migrations/
│       └── 20260724120000_training_module.sql
└── docs/
    ├── setup.md
    └── registre-nLPD.md
```

## 🔐 Sécurité

- Auth partagée avec le site principal (magic link Supabase)
- Row-Level Security activé sur toutes les tables `training_*`
- Agent voit uniquement ses propres tentatives et certifs
- Admins (via `user_roles`) voient tout
- Génération de la note **côté serveur** — la `correct` n'est jamais exposée côté client pendant le quiz
- Anti-triche : détection changement d'onglet · perte de focus · timeout

## 🚫 Règles

- Ne jamais push sur `main` sans validation d'Anisa
- Ne jamais commit de secrets (`.env*` gitignored)
- Ne jamais toucher aux tables du site principal (uniquement `training_*`)

## 📋 Ce qu'il te reste à faire

1. **Appliquer la migration** SQL sur ta Supabase existante (commande ci-dessus)
2. **Créer le bucket `training-certificates`** (privé) dans Storage
3. **Configurer `.env.local`** :
   - `NEXT_PUBLIC_SUPABASE_URL=https://ezhgsurhnyszhjixybak.supabase.co`
   - `NEXT_PUBLIC_SUPABASE_ANON_KEY=<anon key du projet>`
   - `SUPABASE_SERVICE_ROLE_KEY=<service_role secret>`
4. **Créer projet Vercel** lié à ce repo · ajouter les env vars · brancher `app.klary.ch`

Une fois ces 4 étapes faites, je peux coder l'app complète.
