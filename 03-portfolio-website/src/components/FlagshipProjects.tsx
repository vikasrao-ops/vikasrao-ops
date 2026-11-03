"use client";

import React, { useState } from "react";
import { FLAGSHIP_PROJECTS, Project } from "../data/portfolioData";

export default function FlagshipProjects() {
  const [filter, setFilter] = useState<string>("All");

  const categories = ["All", "Azure", "AWS", "DevSecOps", "Kubernetes", "Multi-Cloud", "Observability", "FinOps"];

  const filteredProjects =
    filter === "All"
      ? FLAGSHIP_PROJECTS
      : FLAGSHIP_PROJECTS.filter((p) => p.category === filter);

  return (
    <section id="flagship" className="py-20 border-b border-[#1E293B]">
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div className="flex flex-col md:flex-row md:items-end justify-between mb-10 gap-4">
          <div>
            <h2 className="text-xs font-mono font-bold uppercase tracking-wider text-[#38BDF8]">
              // Flagship Infrastructure Repositories
            </h2>
            <h3 className="mt-2 text-3xl font-extrabold text-[#F8FAFC]">
              7 Production-Grade Cloud Architectures
            </h3>
            <p className="mt-2 text-sm text-[#94A3B8]">
              Complete codebases with modular Terraform, automated CI workflows, ADRs, and verification steps.
            </p>
          </div>

          {/* Filter Pills */}
          <div className="flex flex-wrap gap-1.5">
            {categories.map((cat) => (
              <button
                key={cat}
                onClick={() => setFilter(cat)}
                className={`px-3 py-1.5 rounded-md text-xs font-mono transition-colors ${
                  filter === cat
                    ? "bg-[#38BDF8] text-[#0B1120] font-bold"
                    : "bg-[#111827] text-[#94A3B8] border border-[#1E293B] hover:text-[#F8FAFC]"
                }`}
              >
                {cat}
              </button>
            ))}
          </div>
        </div>

        {/* Project Cards Grid */}
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
          {filteredProjects.map((project: Project) => (
            <div
              key={project.id}
              className="p-6 rounded-xl bg-[#111827] border border-[#1E293B] hover:border-[#38BDF8]/50 transition-all flex flex-col justify-between group"
            >
              <div>
                {/* Header Badge */}
                <div className="flex items-center justify-between gap-2 mb-3">
                  <span className="text-[11px] font-mono px-2 py-0.5 rounded bg-[#0B1120] border border-[#1E293B] text-[#38BDF8]">
                    {project.badge}
                  </span>
                  <span className="text-[10px] font-mono text-[#059669] flex items-center gap-1">
                    <span className="h-1.5 w-1.5 rounded-full bg-[#10B981]" />
                    {project.status}
                  </span>
                </div>

                <h4 className="text-lg font-bold text-[#F8FAFC] group-hover:text-[#38BDF8] transition-colors">
                  {project.title}
                </h4>

                <p className="mt-2 text-xs text-[#94A3B8] leading-relaxed line-clamp-3">
                  {project.description}
                </p>

                {/* Key Highlights */}
                <div className="mt-4 pt-4 border-t border-[#1E293B]/60 space-y-2">
                  <span className="text-[11px] font-mono font-semibold text-[#F8FAFC] block">Key Highlights:</span>
                  <ul className="text-xs text-[#94A3B8] space-y-1">
                    {project.highlights.slice(0, 2).map((h, idx) => (
                      <li key={idx} className="flex items-start gap-1.5">
                        <span className="text-[#38BDF8]">▹</span>
                        <span className="line-clamp-2">{h}</span>
                      </li>
                    ))}
                  </ul>
                </div>
              </div>

              <div className="mt-6 pt-4 border-t border-[#1E293B]">
                {/* Tech Pills */}
                <div className="flex flex-wrap gap-1.5 mb-4">
                  {project.techStack.map((tech) => (
                    <span
                      key={tech}
                      className="px-2 py-0.5 rounded text-[10px] font-mono bg-[#0B1120] text-[#94A3B8] border border-[#1E293B]"
                    >
                      {tech}
                    </span>
                  ))}
                </div>

                {/* GitHub Link */}
                <a
                  href={project.githubUrl}
                  target="_blank"
                  rel="noopener noreferrer"
                  className="w-full inline-flex items-center justify-center gap-2 px-3 py-2 rounded-lg bg-[#0B1120] border border-[#1E293B] text-xs font-mono font-semibold text-[#F8FAFC] hover:border-[#38BDF8] hover:text-[#38BDF8] transition-colors"
                >
                  <span>View Repository</span>
                  <span>→</span>
                </a>
              </div>
            </div>
          ))}
        </div>
      </div>
    </section>
  );
}

