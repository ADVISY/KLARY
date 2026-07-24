import type { Metadata } from "next";
import "./globals.css";

export const metadata: Metadata = {
  metadataBase: new URL("https://klary.ch"),
  title: {
    default: "Klary — Courtage en assurance",
    template: "%s · Klary",
  },
  description:
    "Cabinet de courtage indépendant en Suisse. Assurance santé, prévoyance, LPP, hypothèque — comparaison neutre, économies réelles.",
  keywords: [
    "courtage assurance suisse",
    "assurance maladie",
    "3e pilier",
    "LAMal",
    "LCA",
    "hypothèque",
    "prévoyance",
    "Vaud",
    "Le Mont-sur-Lausanne",
  ],
  authors: [{ name: "Klary Sàrl" }],
};

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  return (
    <html lang="fr">
      <body className="antialiased">{children}</body>
    </html>
  );
}
