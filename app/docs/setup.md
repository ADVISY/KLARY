# Klary — Guide de setup complet

Marche à suivre pour lancer la plateforme `app.klary.ch` de zéro.

## 1. Créer les services externes

### 1.1 Supabase (base de données + auth)

1. Aller sur https://supabase.com/dashboard → **New Project**
2. Nom : `klary-app`
3. Region : **eu-central-1** (Francfort) — obligatoire pour conformité nLPD suisse
4. Password DB : générer un mot de passe fort et le stocker dans un gestionnaire (Bitwarden / 1Password)
5. Une fois le projet créé, aller dans **Settings → API** et noter :
   - `Project URL` → `NEXT_PUBLIC_SUPABASE_URL`
   - `anon public` → `NEXT_PUBLIC_SUPABASE_ANON_KEY`
   - `service_role secret` → `SUPABASE_SERVICE_ROLE_KEY` (⚠ secret, jamais côté client)

**Appliquer les migrations SQL :**

```bash
# Installer Supabase CLI (si pas déjà fait)
brew install supabase/tap/supabase

# Lier le projet local au projet Supabase
cd klary-app
supabase link --project-ref <votre-project-ref>

# Appliquer les migrations
supabase db push
```

**Créer les buckets Storage :**

Dashboard Supabase → **Storage** → **New bucket** :
- `cvs` → **Private** (accès via signed URLs uniquement)
- `certificates` → **Private** (idem)

### 1.2 Resend (envoi email)

1. Aller sur https://resend.com/signup
2. Vérifier le domaine `klary.ch` (ajouter DNS records SPF/DKIM/DMARC)
3. Créer une API key → `RESEND_API_KEY`
4. Configurer l'expéditeur `noreply@klary.ch` (ou `admin@klary.ch`)

### 1.3 Vercel (hosting)

1. Aller sur https://vercel.com → **New Project**
2. Importer le repo `ADVISY/KLARY`
3. Framework preset : **Next.js**
4. Env variables : copier depuis `.env.local` (sans les `NEXT_PUBLIC_` uniquement les côté serveur)
5. Deploy
6. Aller dans **Settings → Domains** → ajouter `app.klary.ch`
7. Configurer DNS chez ton registrar (Infomaniak / Hostinger / etc.) :
   - Type : `CNAME`
   - Nom : `app`
   - Valeur : `cname.vercel-dns.com`

## 2. Setup local

```bash
# Cloner
git clone https://github.com/ADVISY/KLARY.git klary-app
cd klary-app

# Installer les dépendances
npm install

# Variables d'environnement
cp .env.local.example .env.local
# → Éditer .env.local avec les vraies valeurs

# Démarrer en mode dev
npm run dev
```

Ouvrir http://localhost:3000

## 3. Premier utilisateur admin (Anisa)

Après création du compte via magic link :

```sql
-- Dans Supabase SQL Editor
INSERT INTO agents (auth_user_id, email, first_name, last_name, role, active)
SELECT id, email, 'Anisa', 'Sadiq', 'admin', TRUE
FROM auth.users
WHERE email = 'anisa@klary.ch';
```

## 4. Registre nLPD (obligatoire)

Voir `docs/registre-nLPD.md` pour la documentation des traitements de données personnelles conformément à la nLPD suisse.

## 5. Sécurité

- ⚠️ Ne jamais commit `.env.local` — vérifier avec `git status` avant tout push
- ⚠️ Ne jamais désactiver Row-Level Security (RLS) en production
- ⚠️ Rotation des clés Supabase tous les 6 mois minimum
- ⚠️ Audit trail : toutes les actions admin sur candidats sont loggées dans `candidate_events`

## 6. Déploiement production

Push sur `main` → Vercel déploie automatiquement en production.

**Règle** : `main` est protégée. Toute PR doit être approuvée par Anisa avant merge.
