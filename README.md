# Klary — Monorepo

Repo unique contenant les 2 applications Klary Sàrl.

## 📁 Structure

```
klary-app/
├── site/          # Site marketing existant — klary.ch          [Vite + React + shadcn]
├── app/           # Plateforme interne     — app.klary.ch       [Next.js 14 + Supabase]
└── README.md
```

## 🌐 Déploiement

**Deux projets Vercel** liés au même repo GitHub `ADVISY/KLARY` :

| Projet Vercel | Root directory | Framework | Domaine |
|---|---|---|---|
| `klary-site` | `site/` | Vite | **klary.ch** |
| `klary-app` | `app/` | Next.js | **app.klary.ch** |

## 🗄️ Base Supabase

Les deux apps partagent la même Supabase :
- Project ID : `ezhgsurhnyszhjixybak`
- URL : `https://ezhgsurhnyszhjixybak.supabase.co`

Migrations SQL et Edge Functions dans `app/supabase/`.

## 🚀 Dev local

### Site marketing (klary.ch)
```bash
cd site
npm install
npm run dev            # → http://localhost:5173
```

### App interne (app.klary.ch)
```bash
cd app
npm install
npm run dev            # → http://localhost:3000
```

## 🔐 Règles

- Ne jamais commit de secrets (`.env*` gitignored)
- Ne jamais push sur `main` sans validation
- La base Supabase est partagée : attention aux migrations
