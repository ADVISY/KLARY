import type { Metadata } from "next";
import "./globals.css";

export const metadata: Metadata = {
  title: "Klary — Plateforme interne",
  description:
    "Espace de formation et de certification interne réservé aux agents Klary Sàrl.",
  robots: "noindex, nofollow",
  icons: {
    icon: "/favicon.ico",
  },
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
