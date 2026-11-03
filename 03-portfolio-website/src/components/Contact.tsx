import React from "react";
import { CANDIDATE_PROFILE } from "../data/portfolioData";

export default function Contact() {
  return (
    <section id="contact" className="py-20 border-b border-[#1E293B]">
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div className="max-w-2xl mx-auto text-center">
          <h2 className="text-xs font-mono font-bold uppercase tracking-wider text-[#38BDF8]">
            // Connect &amp; Collaborate
          </h2>
          <h3 className="mt-2 text-3xl font-extrabold text-[#F8FAFC]">
            Get In Touch
          </h3>
          <p className="mt-3 text-sm text-[#94A3B8] leading-relaxed">
            Interested in multi-cloud infrastructure engineering, zero-trust cloud architectures, or DevSecOps pipeline automation? Let's connect.
          </p>

          <div className="mt-8 flex flex-col sm:flex-row items-center justify-center gap-4">
            <a
              href={`mailto:${CANDIDATE_PROFILE.email}`}
              className="w-full sm:w-auto px-6 py-3 rounded-lg bg-[#38BDF8] text-[#0B1120] font-bold text-sm hover:bg-[#22D3EE] transition-colors"
            >
              Email Vikas Rao
            </a>
            <a
              href={CANDIDATE_PROFILE.github}
              target="_blank"
              rel="noopener noreferrer"
              className="w-full sm:w-auto px-6 py-3 rounded-lg bg-[#111827] text-[#F8FAFC] border border-[#1E293B] font-semibold text-sm hover:border-[#38BDF8]/40 transition-colors"
            >
              GitHub @vikasrao-ops
            </a>
            <a
              href={CANDIDATE_PROFILE.linkedin}
              target="_blank"
              rel="noopener noreferrer"
              className="w-full sm:w-auto px-6 py-3 rounded-lg bg-[#111827] text-[#94A3B8] border border-[#1E293B] font-semibold text-sm hover:text-[#F8FAFC] transition-colors"
            >
              LinkedIn Profile
            </a>
          </div>
        </div>
      </div>
    </section>
  );
}

