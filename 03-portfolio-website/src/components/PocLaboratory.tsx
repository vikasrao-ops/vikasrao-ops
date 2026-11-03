import React from "react";
import { POC_LABS } from "../data/portfolioData";

export default function PocLaboratory() {
  return (
    <section id="pocs" className="py-20 border-b border-[#1E293B]">
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div className="max-w-3xl mb-10">
          <h2 className="text-xs font-mono font-bold uppercase tracking-wider text-[#38BDF8]">
            // Independent Technical Research
          </h2>
          <h3 className="mt-2 text-3xl font-extrabold text-[#F8FAFC]">
            12 Reproducible POC Laboratories
          </h3>
          <p className="mt-2 text-sm text-[#94A3B8]">
            Focused, atomic laboratories isolating specific infrastructure patterns, automation scripts, and tooling integrations.
          </p>
        </div>

        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
          {POC_LABS.map((lab) => (
            <div
              key={lab.id}
              className="p-5 rounded-lg bg-[#111827] border border-[#1E293B] hover:border-[#38BDF8]/40 transition-colors flex flex-col justify-between"
            >
              <div>
                <div className="flex items-center justify-between gap-2 mb-2">
                  <span className="text-[10px] font-mono px-2 py-0.5 rounded bg-[#0B1120] text-[#38BDF8] border border-[#1E293B]">
                    {lab.category}
                  </span>
                  <span className="text-[10px] font-mono text-[#64748B]">POC LAB</span>
                </div>
                <h4 className="font-mono text-sm font-bold text-[#F8FAFC]">
                  {lab.title}
                </h4>
                <p className="mt-2 text-xs text-[#94A3B8] leading-relaxed">
                  {lab.description}
                </p>
              </div>

              <div className="mt-4 pt-3 border-t border-[#1E293B]">
                <a
                  href={lab.githubUrl}
                  target="_blank"
                  rel="noopener noreferrer"
                  className="text-xs font-mono text-[#38BDF8] hover:underline flex items-center justify-between"
                >
                  <span>Inspect Code &amp; Manifests</span>
                  <span>↗</span>
                </a>
              </div>
            </div>
          ))}
        </div>
      </div>
    </section>
  );
}

