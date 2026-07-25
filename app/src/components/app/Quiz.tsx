"use client";

import { useState, useEffect, useRef } from "react";
import { useRouter } from "next/navigation";
import { cn } from "@/lib/utils";
import { CameraConsent } from "./CameraConsent";

type Question = {
  id: string;
  external_id: string;
  category: string;
  question_type: string;
  question: string;
  options: string[];
};

type Module = {
  key: string;
  title: string;
  duration_min: number;
  passing_score: number;
};

interface QuizProps {
  attemptId: string;
  module: Module;
  questions: Question[];
}

export function Quiz({ attemptId, module, questions }: QuizProps) {
  const router = useRouter();

  // Étapes : caméra → quiz
  const [cameraStream, setCameraStream] = useState<MediaStream | null>(null);
  const [started, setStarted] = useState(false);

  const [currentIdx, setCurrentIdx] = useState(0);
  const [answers, setAnswers] = useState<Record<string, number>>({});
  const [selectedOption, setSelectedOption] = useState<number | null>(null);
  const [secondsLeft, setSecondsLeft] = useState(module.duration_min * 60);
  const [cheatCount, setCheatCount] = useState(0);
  const [cheatWarning, setCheatWarning] = useState<string | null>(null);
  const [submitting, setSubmitting] = useState(false);

  const startedAt = useRef<number>(Date.now());
  // Type explicit HTMLVideoElement | null → MutableRefObject (writable current)
  // — nécessaire pour l'affectation dans le callback ref inline
  const videoRef = useRef<HTMLVideoElement | null>(null);

  const currentQuestion = questions[currentIdx];
  const isLast = currentIdx === questions.length - 1;
  const progressPct = ((currentIdx + 1) / questions.length) * 100;

  // Attacher le stream au <video> PIP + retry robuste.
  // Certains navigateurs (Chrome/Safari) ratent l'attachement si le
  // srcObject est assigné trop tôt ou si play() est bloqué.
  useEffect(() => {
    if (!started || !cameraStream) return;

    const tryAttach = (attempt = 0) => {
      const video = videoRef.current;
      if (!video) {
        if (attempt < 5) setTimeout(() => tryAttach(attempt + 1), 100);
        return;
      }

      // Log diagnostic — visible dans DevTools Console
      const tracks = cameraStream.getVideoTracks();
      console.log("[Quiz] Attach stream PIP", {
        attempt,
        videoEl: !!video,
        streamActive: cameraStream.active,
        tracks: tracks.length,
        trackState: tracks[0]?.readyState,
        trackEnabled: tracks[0]?.enabled,
      });

      if (!cameraStream.active || tracks[0]?.readyState !== "live") {
        console.error("[Quiz] Stream inactif — la caméra a été coupée avant l'attachement.");
        return;
      }

      video.srcObject = cameraStream;
      video.muted = true;
      video.playsInline = true;

      video
        .play()
        .then(() => console.log("[Quiz] video.play() OK"))
        .catch((err) => {
          console.warn("[Quiz] video.play() bloqué:", err?.name, err?.message);
          // Retry après un délai — Safari peut demander un 2ᵉ tour
          if (attempt < 3) {
            setTimeout(() => tryAttach(attempt + 1), 300);
          }
        });
    };

    tryAttach();
  }, [started, cameraStream]);

  // Cleanup : couper le stream si on quitte
  useEffect(() => {
    return () => {
      cameraStream?.getTracks().forEach((t) => t.stop());
    };
  }, [cameraStream]);

  // Détection perte du stream vidéo (caméra débranchée / coupée)
  useEffect(() => {
    if (!started || !cameraStream || submitting) return;
    const tracks = cameraStream.getVideoTracks();
    const track = tracks[0];
    if (!track) return;

    const handleEnded = () => {
      triggerCheat("camera_stopped");
    };
    track.addEventListener("ended", handleEnded);
    return () => track.removeEventListener("ended", handleEnded);
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [started, cameraStream, submitting]);

  // Timer
  useEffect(() => {
    if (!started || submitting) return;
    const interval = setInterval(() => {
      setSecondsLeft((s) => {
        if (s <= 1) {
          clearInterval(interval);
          handleSubmit(true, "timeout");
          return 0;
        }
        return s - 1;
      });
    }, 1000);
    return () => clearInterval(interval);
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [started, submitting]);

  // Anti-triche : visibilité + focus
  // Délai d'init 1.5s : au tout début du quiz le focus n'est pas encore
  // stable (rendu React, préparation caméra…), ce qui déclenche des faux
  // positifs. On attend que la page soit vraiment posée avant d'écouter.
  useEffect(() => {
    if (!started || submitting) return;
    let armed = false;
    const armTimeout = setTimeout(() => {
      armed = true;
    }, 1500);

    const handleVisibility = () => {
      if (!armed) return;
      if (document.hidden) triggerCheat("tab_switch");
    };

    // Blur seul est peu fiable (mobile rotation, DevTools, notification
    // OS…). On ne déclenche l'échec QUE si vraiment le tab reste caché
    // plus de 2 secondes. Ça filtre 95 % des faux positifs.
    let blurTimeout: ReturnType<typeof setTimeout> | null = null;
    const handleBlur = () => {
      if (!armed) return;
      if (blurTimeout) clearTimeout(blurTimeout);
      blurTimeout = setTimeout(() => {
        if (!document.hasFocus() && document.hidden) {
          triggerCheat("focus_lost");
        }
      }, 2000);
    };
    const handleFocus = () => {
      if (blurTimeout) {
        clearTimeout(blurTimeout);
        blurTimeout = null;
      }
    };

    document.addEventListener("visibilitychange", handleVisibility);
    window.addEventListener("blur", handleBlur);
    window.addEventListener("focus", handleFocus);
    return () => {
      clearTimeout(armTimeout);
      if (blurTimeout) clearTimeout(blurTimeout);
      document.removeEventListener("visibilitychange", handleVisibility);
      window.removeEventListener("blur", handleBlur);
      window.removeEventListener("focus", handleFocus);
    };
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [started, cheatCount, submitting]);

  const triggerCheat = (reason: string) => {
    if (submitting || !started) return;
    setCheatCount((c) => {
      const newCount = c + 1;
      if (newCount === 1) {
        setCheatWarning(
          reason === "camera_stopped"
            ? "⚠ Votre caméra a été désactivée. Le prochain écart entraînera l'échec automatique."
            : "⚠ Vous avez quitté la page. Un nouvel écart entraînera l'échec automatique."
        );
        setTimeout(() => setCheatWarning(null), 10000);
      } else if (newCount >= 2) {
        handleSubmit(true, "cheat");
      }
      return newCount;
    });
  };

  const handleCameraGranted = (stream: MediaStream) => {
    setCameraStream(stream);
    setStarted(true);
    startedAt.current = Date.now();
  };

  const handleCancelCamera = () => {
    router.push(`/formation/${module.key}`);
  };

  const handleNext = () => {
    if (selectedOption === null) return;
    const newAnswers = { ...answers, [currentQuestion.id]: selectedOption };
    setAnswers(newAnswers);
    setSelectedOption(null);

    if (isLast) {
      handleSubmit(false, null, newAnswers);
    } else {
      setCurrentIdx(currentIdx + 1);
    }
  };

  const handleSubmit = async (
    aborted: boolean,
    reason: string | null,
    finalAnswers?: Record<string, number>
  ) => {
    if (submitting) return;
    setSubmitting(true);

    // Couper la caméra immédiatement
    cameraStream?.getTracks().forEach((t) => t.stop());

    const timeUsedSec = Math.round((Date.now() - startedAt.current) / 1000);

    try {
      const res = await fetch("/api/training/submit", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
          attemptId,
          answers: finalAnswers || answers,
          cheat_count: cheatCount,
          time_used_sec: timeUsedSec,
          aborted,
          abort_reason: reason,
        }),
      });
      if (!res.ok) throw new Error("Échec de l'envoi");
      router.push(`/formation/${module.key}/resultat/${attemptId}`);
    } catch (err) {
      alert(
        "Erreur lors de la soumission — vérifiez votre connexion. Contactez admin@klary.ch"
      );
      setSubmitting(false);
    }
  };

  // Écran consentement caméra (avant démarrage du quiz)
  if (!started) {
    return (
      <CameraConsent
        onGranted={handleCameraGranted}
        onCancel={handleCancelCamera}
      />
    );
  }

  const mm = Math.floor(secondsLeft / 60);
  const ss = secondsLeft % 60;

  return (
    <div className="min-h-screen bg-klary-cream">
      {/* Barre du haut : progress + timer */}
      <div className="sticky top-0 z-20 bg-white border-b border-klary-light-grey shadow-sm">
        <div className="max-w-3xl mx-auto px-6 py-4 flex items-center gap-6">
          <div className="flex-1">
            <div className="text-xs font-semibold uppercase tracking-wider text-klary-grey mb-1.5">
              Question {currentIdx + 1} / {questions.length}
            </div>
            <div className="h-2 bg-klary-light-grey rounded-full overflow-hidden">
              <div
                className="h-full bg-klary-orange transition-all duration-500"
                style={{ width: `${progressPct}%` }}
              />
            </div>
          </div>
          <div
            className={cn(
              "px-3 py-2 rounded-lg font-bold font-mono text-white",
              secondsLeft <= 60 ? "bg-red-600 animate-pulse" : "bg-klary-navy"
            )}
          >
            ⏱ {String(mm).padStart(2, "0")}:{String(ss).padStart(2, "0")}
          </div>
        </div>
      </div>

      {/* Zone question */}
      <div className="max-w-3xl mx-auto px-6 py-10">
        <div className="bg-white rounded-2xl shadow-sm border border-klary-light-grey p-6 md:p-10">
          <div className="text-xs font-bold uppercase tracking-widest text-klary-orange mb-3">
            {currentQuestion.category}
          </div>
          <h2 className="text-xl md:text-2xl font-bold text-klary-navy leading-tight mb-8">
            {currentQuestion.question}
          </h2>

          <div className="space-y-3">
            {currentQuestion.options.map((opt, idx) => (
              <label
                key={idx}
                className={cn(
                  "flex gap-3 items-start p-4 rounded-xl border-2 cursor-pointer transition-all",
                  selectedOption === idx
                    ? "border-klary-orange bg-klary-orange/5"
                    : "border-klary-light-grey bg-white hover:border-klary-navy"
                )}
              >
                <input
                  type="radio"
                  name="answer"
                  value={idx}
                  checked={selectedOption === idx}
                  onChange={() => setSelectedOption(idx)}
                  className="mt-1 accent-klary-orange w-4 h-4"
                />
                <span className="text-klary-ink leading-relaxed">{opt}</span>
              </label>
            ))}
          </div>

          <div className="mt-8 flex justify-end">
            <button
              onClick={handleNext}
              disabled={selectedOption === null || submitting}
              className="px-6 py-3 bg-klary-orange text-white font-semibold rounded-lg hover:bg-klary-orange/90 transition disabled:opacity-40 disabled:cursor-not-allowed"
            >
              {submitting
                ? "Envoi…"
                : isLast
                ? "Terminer l'évaluation →"
                : "Question suivante →"}
            </button>
          </div>
        </div>

        {/* Avertissement anti-triche */}
        {cheatWarning && (
          <div className="mt-4 p-4 bg-red-50 border-2 border-red-300 rounded-xl text-red-800 font-semibold">
            {cheatWarning}
          </div>
        )}

        {/* Indicateur cheat count discret */}
        {cheatCount > 0 && (
          <div className="mt-3 text-xs text-red-600 text-center">
            Avertissements : {cheatCount} / 2
          </div>
        )}
      </div>

      {/* Caméra en Picture-in-Picture (bas droite) */}
      <div className="fixed bottom-4 right-4 z-30 shadow-xl">
        <div className="relative bg-black rounded-xl overflow-hidden border-2 border-klary-navy w-40 md:w-48 aspect-video">
          <video
            ref={(el) => {
              // Callback ref : attache le stream DÈS que l'élément monte,
              // sans dépendre du timing du useEffect
              videoRef.current = el;
              if (el && cameraStream && el.srcObject !== cameraStream) {
                el.srcObject = cameraStream;
                el.muted = true;
                el.playsInline = true;
                el.play().catch(() => {});
              }
            }}
            autoPlay
            playsInline
            muted
            className="w-full h-full object-cover"
          />
          <div className="absolute top-1 right-1 flex items-center gap-1 px-1.5 py-0.5 rounded bg-red-600 text-white text-[10px] font-bold">
            <span className="w-1.5 h-1.5 rounded-full bg-white animate-pulse" />
            LIVE
          </div>
        </div>
      </div>
    </div>
  );
}
