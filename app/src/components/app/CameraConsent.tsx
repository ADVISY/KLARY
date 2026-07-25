"use client";

import { useState, useRef, useEffect } from "react";

interface CameraConsentProps {
  onGranted: (stream: MediaStream) => void;
  onCancel: () => void;
}

export function CameraConsent({ onGranted, onCancel }: CameraConsentProps) {
  const [step, setStep] = useState<"info" | "requesting" | "granted" | "denied">(
    "info"
  );
  const [errorMsg, setErrorMsg] = useState<string | null>(null);
  const videoRef = useRef<HTMLVideoElement>(null);
  const streamRef = useRef<MediaStream | null>(null);

  const requestCamera = async () => {
    setStep("requesting");
    setErrorMsg(null);
    try {
      const stream = await navigator.mediaDevices.getUserMedia({
        video: { width: 640, height: 480 },
        audio: false,
      });
      streamRef.current = stream;
      if (videoRef.current) {
        videoRef.current.srcObject = stream;
      }
      setStep("granted");
    } catch (err) {
      setStep("denied");
      setErrorMsg(
        err instanceof Error
          ? err.message
          : "Impossible d'accéder à la caméra."
      );
    }
  };

  const handleContinue = () => {
    if (streamRef.current) onGranted(streamRef.current);
  };

  useEffect(() => {
    return () => {
      // Ne pas stopper le stream ici - il est passé au parent
    };
  }, []);

  return (
    <div className="min-h-screen flex items-center justify-center bg-klary-cream px-6 py-12">
      <div className="max-w-lg w-full">
        <div className="bg-white rounded-2xl border border-klary-light-grey shadow-sm p-8">
          <div className="text-xs font-bold uppercase tracking-widest text-klary-orange mb-3">
            Vérification d'identité
          </div>
          <h1 className="text-2xl font-bold text-klary-navy mb-4">
            Activation de votre caméra
          </h1>

          {step === "info" && (
            <>
              <p className="text-klary-grey leading-relaxed mb-5">
                Pour garantir l'intégrité de votre évaluation Klary, votre
                caméra doit être <strong>active pendant toute la durée du
                test</strong>.
              </p>

              <div className="bg-klary-orange/5 border-l-4 border-klary-orange rounded-r-xl p-4 mb-6">
                <ul className="space-y-2 text-sm text-klary-ink">
                  <li className="flex gap-2">
                    <span className="text-klary-orange font-bold">▸</span>
                    <span>
                      Vidéo affichée en bas à droite pendant l'évaluation
                    </span>
                  </li>
                  <li className="flex gap-2">
                    <span className="text-klary-orange font-bold">▸</span>
                    <span>
                      <strong>Aucun enregistrement</strong> — la vidéo n'est ni
                      stockée ni envoyée
                    </span>
                  </li>
                  <li className="flex gap-2">
                    <span className="text-klary-orange font-bold">▸</span>
                    <span>
                      Si vous coupez la caméra, l'évaluation sera automatiquement
                      interrompue
                    </span>
                  </li>
                  <li className="flex gap-2">
                    <span className="text-klary-orange font-bold">▸</span>
                    <span>
                      Interdiction absolue de changer de fenêtre (2 avertissements
                      = échec)
                    </span>
                  </li>
                </ul>
              </div>

              <div className="flex flex-col sm:flex-row gap-3">
                <button
                  onClick={onCancel}
                  className="flex-1 py-3 border border-klary-light-grey text-klary-navy font-semibold rounded-xl hover:border-klary-navy transition"
                >
                  Annuler
                </button>
                <button
                  onClick={requestCamera}
                  className="flex-1 py-3 bg-klary-orange text-white font-semibold rounded-xl hover:bg-klary-orange/90 transition"
                >
                  Autoriser la caméra →
                </button>
              </div>
            </>
          )}

          {step === "requesting" && (
            <div className="text-center py-8">
              <div className="animate-spin w-10 h-10 border-4 border-klary-orange border-t-transparent rounded-full mx-auto mb-4"></div>
              <p className="text-klary-grey">
                Cliquez sur <strong>Autoriser</strong> dans la popup du
                navigateur.
              </p>
            </div>
          )}

          {step === "granted" && (
            <>
              <div className="bg-black rounded-xl overflow-hidden aspect-video mb-5">
                <video
                  ref={videoRef}
                  autoPlay
                  playsInline
                  muted
                  className="w-full h-full object-cover"
                />
              </div>

              <div className="p-4 bg-green-50 border border-green-200 rounded-xl mb-6">
                <div className="flex items-center gap-2 text-green-800 font-semibold">
                  <span className="text-xl">✓</span>
                  <span>Caméra activée — vous êtes bien visible</span>
                </div>
              </div>

              <button
                onClick={handleContinue}
                className="w-full py-3.5 bg-klary-orange text-white font-semibold rounded-xl hover:bg-klary-orange/90 transition"
              >
                Démarrer l'évaluation →
              </button>
            </>
          )}

          {step === "denied" && (
            <>
              <div className="p-5 bg-red-50 border border-red-200 rounded-xl mb-5 text-red-800">
                <div className="font-bold mb-2 flex items-center gap-2">
                  <span className="text-xl">✕</span> Accès caméra refusé
                </div>
                <p className="text-sm">
                  {errorMsg ||
                    "Nous n'avons pas pu accéder à votre caméra. Vérifiez les autorisations de votre navigateur."}
                </p>
              </div>

              <div className="text-sm text-klary-grey mb-6">
                Pour activer la caméra :
                <ul className="mt-2 space-y-1 list-disc pl-5">
                  <li>Cliquez sur l'icône 🔒 dans la barre d'adresse</li>
                  <li>Autorisez la caméra pour ce site</li>
                  <li>Rafraîchissez la page</li>
                </ul>
              </div>

              <div className="flex flex-col sm:flex-row gap-3">
                <button
                  onClick={onCancel}
                  className="flex-1 py-3 border border-klary-light-grey text-klary-navy font-semibold rounded-xl hover:border-klary-navy transition"
                >
                  Annuler
                </button>
                <button
                  onClick={requestCamera}
                  className="flex-1 py-3 bg-klary-orange text-white font-semibold rounded-xl hover:bg-klary-orange/90 transition"
                >
                  Réessayer
                </button>
              </div>
            </>
          )}
        </div>
      </div>
    </div>
  );
}
