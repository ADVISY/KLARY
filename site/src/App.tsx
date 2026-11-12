import { Component, ErrorInfo, lazy, ReactNode, Suspense } from "react";
import { Toaster } from "@/components/ui/toaster";
import { Toaster as Sonner } from "@/components/ui/sonner";
import { TooltipProvider } from "@/components/ui/tooltip";
import { QueryClient, QueryClientProvider } from "@tanstack/react-query";
import { BrowserRouter, Routes, Route } from "react-router-dom";
import { ScrollToTop } from "./components/ScrollToTop";
import { AuthProvider } from "./hooks/useAuth";
import Index from "./pages/Index";
import NotFound from "./pages/NotFound";
import Maintenance from "./pages/Maintenance";
import { CookieBanner } from "./components/v2/CookieBanner";
// WhatsAppButton désactivé tant que le numéro de téléphone officiel Klary n'est pas attribué.
// import { WhatsAppButton } from "./components/WhatsAppButton";

/**
 * MAINTENANCE_MODE
 * ────────────────
 * true  → site ENTIÈREMENT fermé. Aucune page n'est servie, quelle que soit
 *         l'URL : tout retombe sur « Bientôt disponible ». Ni /preview,
 *         ni la candidature, ni les pages légales.
 * false → site complet public (état normal).
 *
 * Fermeture totale le 11.11.2026. Motif : le statut d'intermédiaire lié, et la
 * déclaration d'exclusivité signée avec le Groupe Mutuel, interdisent de
 * laisser accessibles les mentions d'indépendance du site.
 * Ne repasser à false qu'après correction de ces mentions.
 *
 * EXCEPTION : les pages d'offre de /offre/* restent ouvertes même en
 * maintenance. Elles ont été écrites après la fermeture, elles ne revendiquent
 * aucune indépendance et affichent le statut d'intermédiaire lié au Groupe
 * Mutuel sur chaque écran. Elles sont donc conformes, là où le reste du site
 * ne l'est pas encore. Ce sont des atterrissages de campagne payante, en
 * noindex, sans aucun lien vers les pages fermées.
 */
const MAINTENANCE_MODE = true;

const OffreMaladie = lazy(() => import("./pages/offres/OffreMaladie"));
const OffreSubside = lazy(() => import("./pages/offres/OffreSubside"));

const AssuranceSante = lazy(() => import("./pages/assurances/AssuranceSante"));
const Assurance3ePilier = lazy(() => import("./pages/assurances/Assurance3ePilier"));
const AssuranceRCMenage = lazy(() => import("./pages/assurances/AssuranceRCMenage"));
const AssuranceAuto = lazy(() => import("./pages/assurances/AssuranceAuto"));
const ProtectionJuridique = lazy(() => import("./pages/assurances/ProtectionJuridique"));
const Hypotheque = lazy(() => import("./pages/assurances/Hypotheque"));
const AvoirsLPP = lazy(() => import("./pages/assurances/AvoirsLPP"));
const Guides = lazy(() => import("./pages/Guides"));
const GuideArticle = lazy(() => import("./pages/GuideArticle"));
const AssurancePersonnel = lazy(() => import("./pages/entreprises/AssurancePersonnel"));
const PrevoyanceLPP = lazy(() => import("./pages/entreprises/PrevoyanceLPP"));
const APropos = lazy(() => import("./pages/APropos"));
const Carriere = lazy(() => import("./pages/Carriere"));
const Recrutement = lazy(() => import("./pages/Recrutement"));
const RecrutementPostes = lazy(() => import("./pages/RecrutementPostes"));
const Simulateurs = lazy(() => import("./pages/Simulateurs"));
const Assurances = lazy(() => import("./pages/Assurances"));
const MentionsLegales = lazy(() => import("./pages/MentionsLegales"));
const PolitiqueConfidentialite = lazy(() => import("./pages/PolitiqueConfidentialite"));

class ErrorBoundary extends Component<{ children: ReactNode }, { error: Error | null }> {
  state: { error: Error | null } = { error: null };
  static getDerivedStateFromError(error: Error) { return { error }; }
  componentDidCatch(error: Error, info: ErrorInfo) {
    console.error("KLARY ERROR BOUNDARY:", error.message, error.stack, info.componentStack);
  }
  render() {
    if (this.state.error) {
      return (
        <div style={{ padding: "40px", fontFamily: "monospace", whiteSpace: "pre-wrap" }}>
          <h1 style={{ color: "red" }}>Erreur de rendu</h1>
          <p><strong>{this.state.error.message}</strong></p>
          <pre style={{ background: "#fee", padding: "12px", overflow: "auto", fontSize: "12px" }}>{this.state.error.stack}</pre>
          <button onClick={() => this.setState({ error: null })}>Réessayer</button>
        </div>
      );
    }
    return this.props.children;
  }
}

const queryClient = new QueryClient();

const RouteFallback = () => (
  <div className="min-h-screen flex items-center justify-center bg-background">
    <div
      className="w-10 h-10 rounded-full border-2 border-transparent animate-spin"
      style={{
        borderTopColor: "hsl(var(--accent))",
        borderRightColor: "hsl(var(--accent))",
      }}
      aria-label="Chargement en cours"
    />
  </div>
);

const App = () => (
  <QueryClientProvider client={queryClient}>
    <TooltipProvider>
      <Toaster />
      <Sonner />
      <BrowserRouter>
        <AuthProvider>
          <ScrollToTop />
          <ErrorBoundary>
          <Suspense fallback={<RouteFallback />}>
            {MAINTENANCE_MODE ? (
              <Routes>
                {/* Pages d'offre : conformes au statut lié, donc ouvertes. */}
                <Route path="/offre/assurance-maladie" element={<OffreMaladie />} />
                <Route path="/offre/subside" element={<OffreSubside />} />

                {/* Tout le reste du site demeure fermé, sans exception. */}
                <Route path="*" element={<Maintenance />} />
              </Routes>
            ) : (
              <Routes>
                <Route path="/" element={<Index />} />

                {/* Offres (campagnes payantes, noindex) */}
                <Route path="/offre/assurance-maladie" element={<OffreMaladie />} />
                <Route path="/offre/subside" element={<OffreSubside />} />

                {/* Assurances Hub */}
                <Route path="/assurances" element={<Assurances />} />

                {/* Assurances Particuliers */}
                <Route path="/assurances/sante" element={<AssuranceSante />} />
                <Route path="/assurances/3e-pilier" element={<Assurance3ePilier />} />
                <Route path="/assurances/rc-menage" element={<AssuranceRCMenage />} />
                <Route path="/assurances/auto" element={<AssuranceAuto />} />
                <Route path="/assurances/protection-juridique" element={<ProtectionJuridique />} />
                <Route path="/assurances/hypotheque" element={<Hypotheque />} />
                <Route path="/assurances/lpp" element={<AvoirsLPP />} />

                {/* Guides */}
                <Route path="/guides" element={<Guides />} />
                <Route path="/guides/:slug" element={<GuideArticle />} />

                {/* Entreprises */}
                <Route path="/entreprises/personnel" element={<AssurancePersonnel />} />
                <Route path="/entreprises/lpp" element={<PrevoyanceLPP />} />

                {/* Other Pages */}
                <Route path="/a-propos" element={<APropos />} />
                <Route path="/carriere" element={<Carriere />} />
                <Route path="/simulateurs" element={<Simulateurs />} />
                <Route path="/recrutement" element={<RecrutementPostes />} />
                <Route path="/recrutement/postuler" element={<Recrutement />} />

                {/* Legal Pages */}
                <Route path="/mentions-legales" element={<MentionsLegales />} />
                <Route path="/politique-confidentialite" element={<PolitiqueConfidentialite />} />

                {/* ADD ALL CUSTOM ROUTES ABOVE THE CATCH-ALL "*" ROUTE */}
                <Route path="*" element={<NotFound />} />
              </Routes>
            )}
          </Suspense>
          </ErrorBoundary>
          {/* <WhatsAppButton /> */}
          <CookieBanner />
        </AuthProvider>
      </BrowserRouter>
    </TooltipProvider>
  </QueryClientProvider>
);

export default App;
