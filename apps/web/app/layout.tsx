import type { Metadata } from "next";
import "./globals.css";

export const metadata: Metadata = {
  title: "ZeroKnow Protocol",
  description: "Experimental privacy infrastructure for verifiable digital activity."
};

export default function RootLayout({ children }: { children: React.ReactNode }) {
  return (
    <html lang="en">
      <body>{children}</body>
    </html>
  );
}
