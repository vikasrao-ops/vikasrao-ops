import React from "react";
import { CANDIDATE_PROFILE } from "../data/portfolioData";

export default function Footer() {
  return (
    <footer className="py-8 bg-[#0B1120] text-center text-xs text-[#64748B] font-mono">
      <div className="max-w-7xl mx-auto px-4">
        <p>
          © 2026 {CANDIDATE_PROFILE.name} • Multi-Cloud DevOps &amp; DevSecOps Engineering Portfolio
        </p>
        <p className="mt-1">
          Built with Next.js, TypeScript, &amp; Tailwind CSS • Local-First Architecture
        </p>
      </div>
    </footer>
  );
}

