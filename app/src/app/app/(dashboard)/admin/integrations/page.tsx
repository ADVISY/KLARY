import { redirect } from "next/navigation";
import { createSupabaseServerClient } from "@/lib/supabase/server";
import { getStoredGoogleTokens } from "@/lib/google/calendar";
import { GoogleCalendarCard } from "./GoogleCalendarCard";

export const metadata = {
  title: "Intégrations — Admin",
};

export const dynamic = "force-dynamic";

export default async function AdminIntegrationsPage({
  searchParams,
}: {
  searchParams: { google_connected?: string; google_error?: string };
}) {
  const supabase = createSupabaseServerClient();
  const {
    data: { user },
  } = await supabase.auth.getUser();
  if (!user) redirect("/login");

  const { data: role } = await supabase
    .from("user_roles")
    .select("role")
    .eq("user_id", user.id)
    .eq("active", true)
    .maybeSingle();
  if (role?.role !== "admin" && role?.role !== "manager")
    redirect("/formation");

  const googleTokens = await getStoredGoogleTokens();

  return (
    <div className="max-w-4xl mx-auto p-6 md:p-10">
      <header className="mb-6">
        <div className="text-xs font-bold tracking-widest uppercase text-klary-orange mb-2">
          Backoffice · Intégrations
        </div>
        <h1 className="text-3xl md:text-4xl font-bold text-klary-navy mb-3">
          Intégrations tierces
        </h1>
        <p className="text-klary-grey">
          Connectez Klary aux services externes (Google Calendar, futures
          intégrations…) pour automatiser les tâches répétitives.
        </p>
      </header>

      {/* Bannière feedback callback */}
      {searchParams.google_connected === "1" && (
        <div className="mb-6 p-4 rounded-xl bg-green-50 border border-green-300 text-sm text-green-900">
          ✅ Google Calendar connecté avec succès. Les prochains entretiens
          confirmés seront ajoutés automatiquement à ton agenda.
        </div>
      )}
      {searchParams.google_error && (
        <div className="mb-6 p-4 rounded-xl bg-red-50 border border-red-300 text-sm text-red-900">
          ❌ Erreur connexion Google : <code>{searchParams.google_error}</code>
        </div>
      )}

      <GoogleCalendarCard
        connected={!!googleTokens}
        authorizedEmail={googleTokens?.authorized_email || null}
        connectedAt={googleTokens?.connected_at || null}
      />

      {/* Setup guide */}
      <details className="mt-8 rounded-xl border border-klary-light-grey bg-klary-cream/40 p-5">
        <summary className="cursor-pointer font-semibold text-klary-navy text-sm">
          🛠 Setup initial Google Cloud (à faire 1 seule fois)
        </summary>
        <div className="mt-4 text-sm text-klary-grey space-y-3 leading-relaxed">
          <p>
            <strong>1. Créer un projet Google Cloud</strong> — va sur{" "}
            <a
              className="text-klary-orange underline"
              href="https://console.cloud.google.com/projectcreate"
              target="_blank"
              rel="noopener noreferrer"
            >
              console.cloud.google.com
            </a>{" "}
            → nomme-le "Klary Internal".
          </p>
          <p>
            <strong>2. Activer Google Calendar API</strong> — dans le projet, va
            dans <em>APIs & Services → Library</em>, cherche "Google Calendar
            API", clique <strong>Enable</strong>.
          </p>
          <p>
            <strong>3. Configurer l'écran de consentement</strong> — <em>APIs &
            Services → OAuth consent screen</em> → Internal (si Workspace) ou
            External → remplis App name = "Klary", support email = admin@klary.ch,
            developer email = admin@klary.ch. Scopes : <code>calendar.events</code>,
            <code>openid</code>, <code>email</code>.
          </p>
          <p>
            <strong>4. Créer l'OAuth Client ID</strong> — <em>APIs & Services →
            Credentials → Create Credentials → OAuth client ID</em> → Web
            application, nom "Klary Web". <strong>Authorized redirect URIs</strong> :
          </p>
          <pre className="bg-white p-3 rounded border border-klary-light-grey text-xs overflow-x-auto">
            {`http://localhost:3000/api/google/callback
https://app.klary.ch/api/google/callback`}
          </pre>
          <p>
            <strong>5. Copier Client ID + Client Secret</strong> et les ajouter
            dans les variables d'environnement (Vercel <em>+</em> .env.local) :
          </p>
          <pre className="bg-white p-3 rounded border border-klary-light-grey text-xs overflow-x-auto">
            {`GOOGLE_CLIENT_ID=xxxxx.apps.googleusercontent.com
GOOGLE_CLIENT_SECRET=GOCSPX-xxxxx
GOOGLE_REDIRECT_URI=https://app.klary.ch/api/google/callback`}
          </pre>
          <p>
            <strong>6.</strong> Une fois les variables déployées, reviens ici et
            clique <strong>Connecter Google Calendar</strong>. Connecte-toi avec
            <code> admin@klary.ch</code> pour que les events atterrissent dans son
            agenda.
          </p>
        </div>
      </details>
    </div>
  );
}
