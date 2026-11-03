import type { Metadata } from "next";
import "./globals.css";

export const metadata: Metadata = {
  title: "Vikas Rao — Multi-Cloud DevOps & DevSecOps Engineering Portfolio",
  description: "Portfolio of Vikas Rao (vikasrao-ops): 2+ Years Azure DevOps Experience, AWS Architecture, Terraform, Kubernetes, and Shift-Left DevSecOps.",
};

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  return (
    <html lang="en" className="scroll-smooth">
      <body className="bg-[#0B1120] text-[#F8FAFC] antialiased selection:bg-[#38BDF8] selection:text-[#0B1120]">
        {children}
      </body>
    </html>
  );
}

