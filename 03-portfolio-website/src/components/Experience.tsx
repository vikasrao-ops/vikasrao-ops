import React from "react";

export default function Experience() {
  return (
    <section id="experience" className="py-20 border-b border-[#1E293B]">
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div className="max-w-3xl mb-12">
          <h2 className="text-xs font-mono font-bold uppercase tracking-wider text-[#38BDF8]">
            // Verified Technical Background
          </h2>
          <h3 className="mt-2 text-3xl font-extrabold text-[#F8FAFC]">
            Professional Experience &amp; Technical Positioning
          </h3>
          <p className="mt-3 text-base text-[#94A3B8]">
            Complete transparency between verified enterprise employment and independent hands-on cloud architecture projects.
          </p>
        </div>

        <div className="grid grid-cols-1 lg:grid-cols-3 gap-8">
          {/* Card 1: Enterprise Azure Professional Experience (Primary) */}
          <div className="lg:col-span-2 p-6 rounded-xl bg-[#111827] border border-[#38BDF8]/30 shadow-xl relative overflow-hidden">
            <div className="absolute top-0 left-0 h-1 w-full bg-gradient-to-r from-[#0284C7] to-[#38BDF8]" />
            <div className="flex flex-wrap items-center justify-between gap-2 mb-4">
              <div>
                <span className="px-2.5 py-0.5 rounded text-xs font-mono font-semibold bg-[#0284C7]/20 text-[#38BDF8] border border-[#0284C7]/40">
                  PRIMARY PROFESSIONAL EMPLOYMENT
                </span>
                <h4 className="mt-2 text-xl font-bold text-[#F8FAFC]">DevOps &amp; Azure Cloud Infrastructure Engineer</h4>
              </div>
              <span className="text-xs font-mono text-[#94A3B8]">2+ Years Professional Experience</span>
            </div>

            <ul className="space-y-3 text-sm text-[#94A3B8] mt-6">
              <li className="flex items-start gap-2.5">
                <span className="text-[#38BDF8] font-bold">▸</span>
                <span>
                  <strong className="text-[#F8FAFC]">Enterprise Landing Zone Architecture:</strong> Designed and deployed modular Terraform infrastructures on Microsoft Azure, enforcing Hub-and-Spoke network isolation and zero public ingress to workload databases.
                </span>
              </li>
              <li className="flex items-start gap-2.5">
                <span className="text-[#38BDF8] font-bold">▸</span>
                <span>
                  <strong className="text-[#F8FAFC]">Private Networking &amp; Security:</strong> Implemented Azure Private Endpoints, Network Security Groups (NSGs), User Defined Routes (UDRs), and centralized Log Analytics diagnostics.
                </span>
              </li>
              <li className="flex items-start gap-2.5">
                <span className="text-[#38BDF8] font-bold">▸</span>
                <span>
                  <strong className="text-[#F8FAFC]">CI/CD Pipeline Engineering:</strong> Built multi-stage Azure DevOps Pipelines and GitHub Actions workflows incorporating Checkov IaC security gates and approval barriers.
                </span>
              </li>
              <li className="flex items-start gap-2.5">
                <span className="text-[#38BDF8] font-bold">▸</span>
                <span>
                  <strong className="text-[#F8FAFC]">Governance &amp; RBAC:</strong> Configured Azure Policy initiatives (e.g. allowed regions, mandatory tags) and role-based access control following least-privilege principles.
                </span>
              </li>
            </ul>

            <div className="mt-6 pt-4 border-t border-[#1E293B] flex flex-wrap gap-2">
              <span className="px-2 py-1 rounded bg-[#0B1120] text-xs font-mono text-[#38BDF8]">Microsoft Azure</span>
              <span className="px-2 py-1 rounded bg-[#0B1120] text-xs font-mono text-[#38BDF8]">Terraform HCL</span>
              <span className="px-2 py-1 rounded bg-[#0B1120] text-xs font-mono text-[#38BDF8]">Azure DevOps</span>
              <span className="px-2 py-1 rounded bg-[#0B1120] text-xs font-mono text-[#38BDF8]">Azure Policy</span>
              <span className="px-2 py-1 rounded bg-[#0B1120] text-xs font-mono text-[#38BDF8]">Hub-and-Spoke</span>
            </div>
          </div>

          {/* Card 2: Hands-on AWS & GCP Independent Projects */}
          <div className="p-6 rounded-xl bg-[#111827] border border-[#1E293B] flex flex-col justify-between">
            <div>
              <span className="px-2.5 py-0.5 rounded text-xs font-mono font-semibold bg-[#F59E0B]/20 text-[#F59E0B] border border-[#F59E0B]/40">
                INDEPENDENT ARCHITECTURE PROJECTS
              </span>
              <h4 className="mt-2 text-lg font-bold text-[#F8FAFC]">AWS Architecture &amp; GCP Foundations</h4>

              <div className="mt-4 space-y-4 text-xs text-[#94A3B8]">
                <div className="p-3 rounded-lg bg-[#0B1120] border border-[#1E293B]">
                  <strong className="text-[#F59E0B] block font-mono mb-1">Amazon Web Services (Hands-on)</strong>
                  Architected Multi-AZ VPCs, keyless EC2 management with AWS Systems Manager (SSM), S3 bucket policies, and customer-managed KMS key rotation.
                </div>

                <div className="p-3 rounded-lg bg-[#0B1120] border border-[#1E293B]">
                  <strong className="text-[#38BDF8] block font-mono mb-1">Google Cloud Platform (Foundational POC)</strong>
                  Engineered Google Cloud Storage (GCS) uniform access baselines, IAM service account role bindings, and VPC peering concepts.
                </div>
              </div>
            </div>

            <div className="mt-6 pt-4 border-t border-[#1E293B] text-xs font-mono text-[#94A3B8]">
              Status: Verified Technical Implementations
            </div>
          </div>
        </div>
      </div>
    </section>
  );
}

