"use client";

import React, { useState } from "react";
import { CANDIDATE_PROFILE } from "../data/portfolioData";

export default function Navbar() {
  const [isOpen, setIsOpen] = useState(false);

  return (
    <nav className="fixed top-0 left-0 right-0 z-50 bg-[#0B1120]/80 backdrop-blur-md border-b border-[#1E293B]">
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 h-16 flex items-center justify-between">
        <a href="#hero" className="flex items-center space-x-3">
          <div className="h-8 w-8 rounded-lg bg-gradient-to-tr from-[#38BDF8] to-[#22D3EE] flex items-center justify-center font-mono font-bold text-[#0B1120] text-sm">
            VR
          </div>
          <span className="font-bold text-[#F8FAFC] tracking-tight">
            {CANDIDATE_PROFILE.name} <span className="text-[#38BDF8] font-mono font-normal text-xs ml-1">/ devops</span>
          </span>
        </a>

        {/* Desktop Navigation */}
        <div className="hidden md:flex items-center space-x-6 text-sm font-medium text-[#94A3B8]">
          <a href="#experience" className="hover:text-[#38BDF8] transition-colors">Experience</a>
          <a href="#flagship" className="hover:text-[#38BDF8] transition-colors">Flagship Projects</a>
          <a href="#pocs" className="hover:text-[#38BDF8] transition-colors">POC Lab</a>
          <a href="#architecture" className="hover:text-[#38BDF8] transition-colors">Architecture</a>
          <a href="#skills" className="hover:text-[#38BDF8] transition-colors">Skills</a>
          <a href="#contact" className="hover:text-[#38BDF8] transition-colors">Contact</a>
          <a
            href={CANDIDATE_PROFILE.github}
            target="_blank"
            rel="noopener noreferrer"
            className="px-3 py-1.5 rounded-md border border-[#38BDF8]/40 text-[#38BDF8] hover:bg-[#38BDF8]/10 transition-colors text-xs font-mono"
          >
            GitHub Profile ↗
          </a>
        </div>

        {/* Mobile Hamburger Button */}
        <div className="md:hidden">
          <button
            onClick={() => setIsOpen(!isOpen)}
            className="p-2 rounded-md text-[#94A3B8] hover:text-[#F8FAFC] focus:outline-none"
            aria-label="Toggle navigation"
          >
            <svg className="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
              {isOpen ? (
                <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M6 18L18 6M6 6l12 12" />
              ) : (
                <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M4 6h16M4 12h16M4 18h16" />
              )}
            </svg>
          </button>
        </div>
      </div>

      {/* Mobile Menu Dropdown */}
      {isOpen && (
        <div className="md:hidden bg-[#111827] border-b border-[#1E293B] px-4 pt-2 pb-4 space-y-2 text-sm font-medium text-[#94A3B8]">
          <a href="#experience" onClick={() => setIsOpen(false)} className="block py-1 hover:text-[#38BDF8]">Experience</a>
          <a href="#flagship" onClick={() => setIsOpen(false)} className="block py-1 hover:text-[#38BDF8]">Flagship Projects</a>
          <a href="#pocs" onClick={() => setIsOpen(false)} className="block py-1 hover:text-[#38BDF8]">POC Lab</a>
          <a href="#architecture" onClick={() => setIsOpen(false)} className="block py-1 hover:text-[#38BDF8]">Architecture</a>
          <a href="#skills" onClick={() => setIsOpen(false)} className="block py-1 hover:text-[#38BDF8]">Skills</a>
          <a href="#contact" onClick={() => setIsOpen(false)} className="block py-1 hover:text-[#38BDF8]">Contact</a>
        </div>
      )}
    </nav>
  );
}

