import React from "react";
import { SKILL_CATEGORIES } from "../data/portfolioData";

export default function Skills() {
  return (
    <section id="skills" className="py-20 border-b border-[#1E293B]">
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div className="max-w-3xl mb-12">
          <h2 className="text-xs font-mono font-bold uppercase tracking-wider text-[#38BDF8]">
            // Technology Ecosystem
          </h2>
          <h3 className="mt-2 text-3xl font-extrabold text-[#F8FAFC]">
            Core Skills &amp; Engineering Disciplines
          </h3>
          <p className="mt-2 text-sm text-[#94A3B8]">
            Honest proficiency ratings reflecting verified enterprise experience and hands-on laboratory implementations.
          </p>
        </div>

        <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
          {SKILL_CATEGORIES.map((cat) => (
            <div key={cat.name} className="p-6 rounded-xl bg-[#111827] border border-[#1E293B]">
              <h4 className="text-base font-bold text-[#F8FAFC] pb-3 border-b border-[#1E293B] flex items-center justify-between">
                <span>{cat.name}</span>
                <span className="text-xs font-mono text-[#38BDF8]">Proficiency</span>
              </h4>

              <div className="mt-4 space-y-4">
                {cat.skills.map((s) => (
                  <div key={s.name} className="p-3 rounded-lg bg-[#0B1120] border border-[#1E293B]">
                    <div className="flex items-center justify-between text-xs">
                      <strong className="text-[#F8FAFC] font-semibold">{s.name}</strong>
                      <span className="font-mono text-[#38BDF8] bg-[#38BDF8]/10 px-2 py-0.5 rounded border border-[#38BDF8]/20">
                        {s.level}
                      </span>
                    </div>
                    <p className="mt-1.5 text-xs text-[#94A3B8] font-mono">
                      {s.focus}
                    </p>
                  </div>
                ))}
              </div>
            </div>
          ))}
        </div>
      </div>
    </section>
  );
}

