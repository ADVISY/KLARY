import type { Metadata } from "next";
import "./globals.css";

export const metadata: Metadata = {
  title: "Klary — Plateforme interne",
  description: "Formation et certification interne des agents Klary Sàrl.",
  robots: "noindex, nofollow",
};

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  return (
    <html lang="fr">
      <body>{children}</body>
    </html>
  );
}
