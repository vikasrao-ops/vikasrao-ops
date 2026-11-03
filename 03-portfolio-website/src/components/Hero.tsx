import React from "react";
import { CANDIDATE_PROFILE } from "../data/portfolioData";

export default function Hero() {
  return (
    <section id="hero" className="pt-28 pb-16 md:pt-36 md:pb-24 border-b border-[#1E293B] relative overflow-hidden">
      {/* Background Radial Glow */}
      <div className="absolute top-1/4 left-1/2 -translate-x-1/2 w-[600px] h-[300px] bg-[#38BDF8]/5 blur-[120px] rounded-full pointer-events-none" />

      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 relative z-10">
        <div className="max-w-3xl">
          {/* Eyebrow Pill */}
          <div className="inline-flex items-center space-x-2 px-3 py-1 rounded-full bg-[#111827] border border-[#1E293B] text-xs font-mono text-[#38BDF8] mb-6">
            <span className="h-2 w-2 rounded-full bg-[#22D3EE] animate-pulse" />
            <span>2+ YEARS CLOUD DEVOPS EXPERIENCE</span>
          </div>

          <h1 className="text-4xl sm:text-5xl lg:text-6xl font-extrabold text-[#F8FAFC] tracking-tight leading-tight">
            Hi, I'm <span className="text-transparent bg-clip-text bg-gradient-to-r from-[#38BDF8] to-[#22D3EE]">{CANDIDATE_PROFILE.name}</span>
          </h1>

          <p className="mt-3 text-xl sm:text-2xl font-semibold text-[#38BDF8]">
            Multi-Cloud DevOps &amp; DevSecOps Engineer
          </p>

          <p className="mt-4 text-base sm:text-lg text-[#94A3B8] leading-relaxed">
            {CANDIDATE_PROFILE.tagline} Specializing in production-grade Microsoft Azure enterprise infrastructure, shift-left DevSecOps security automation, and multi-cloud Terraform orchestration.
          </p>

          {/* Quick Pillar Cards */}
          <div className="mt-8 grid grid-cols-1 sm:grid-cols-3 gap-3">
            <div className="p-3.5 rounded-lg bg-[#111827] border border-[#1E293B]">
              <span className="text-xs font-mono text-[#38BDF8] block font-semibold">PRIMARY PLATFORM</span>
              <span className="text-sm font-bold text-[#F8FAFC]">Microsoft Azure</span>
              <p className="text-xs text-[#94A3B8] mt-0.5">2+ Years Enterprise Employment</p>
            </div>
            <div className="p-3.5 rounded-lg bg-[#111827] border border-[#1E293B]">
              <span className="text-xs font-mono text-[#22D3EE] block font-semibold">HANDS-ON PROJECTS</span>
              <span className="text-sm font-bold text-[#F8FAFC]">Amazon Web Services</span>
              <p className="text-xs text-[#94A3B8] mt-0.5">Multi-AZ VPC, KMS, IAM Least-Privilege</p>
            </div>
            <div className="p-3.5 rounded-lg bg-[#111827] border border-[#1E293B]">
              <span className="text-xs font-mono text-[#94A3B8] block font-semibold">DISCIPLINES</span>
              <span className="text-sm font-bold text-[#F8FAFC]">IaC &amp; DevSecOps</span>
              <p className="text-xs text-[#94A3B8] mt-0.5">Terraform • K8s • Trivy • Checkov</p>
            </div>
          </div>

          {/* Call to Actions */}
          <div className="mt-8 flex flex-wrap gap-4">
            <a
              href="#flagship"
              className="px-6 py-3 rounded-lg bg-[#38BDF8] text-[#0B1120] font-bold text-sm hover:bg-[#22D3EE] transition-all shadow-lg shadow-[#38BDF8]/10"
            >
              Explore Flagship Architectures
            </a>
            <a
              href="#pocs"
              className="px-6 py-3 rounded-lg bg-[#111827] text-[#F8FAFC] border border-[#1E293B] font-semibold text-sm hover:border-[#38BDF8]/40 transition-colors"
            >
              View 12 POC Labs
            </a>
            <a
              href={CANDIDATE_PROFILE.github}
              target="_blank"
              rel="noopener noreferrer"
              className="px-6 py-3 rounded-lg bg-transparent text-[#94A3B8] border border-transparent font-medium text-sm hover:text-[#F8FAFC] flex items-center gap-1.5"
            >
              GitHub @vikasrao-ops ↗
            </a>
          </div>
        </div>
      </div>
    </section>
  );
}

