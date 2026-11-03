import React from "react";

export default function ArchitectureShowcase() {
  const adrs = [
    { id: "ADR-001", title: "Hub-and-Spoke Topology with Private Endpoints", status: "Accepted", target: "Azure Enterprise" },
    { id: "ADR-002", title: "Shift-Left Security Toolchain & Distroless Hardening", status: "Accepted", target: "DevSecOps Platform" },
    { id: "ADR-003", title: "Multi-AZ 3-Tier Network Isolation with Keyless SSM", status: "Accepted", target: "AWS Infrastructure" },
    { id: "ADR-004", title: "Standardized Helm Packaging and Kubernetes HPA", status: "Accepted", target: "Kubernetes Platform" },
    { id: "ADR-005", title: "Decoupled Multi-Cloud State vs Unified State", status: "Accepted", target: "Cross-Cloud IaC" },
    { id: "ADR-006", title: "Prometheus & Grafana for Telemetry vs SaaS", status: "Accepted", target: "Observability Platform" },
    { id: "ADR-007", title: "Automated CLI Cost Scanners vs Third-Party SaaS", status: "Accepted", target: "FinOps Governance" },
  ];

  return (
    <section id="architecture" className="py-20 border-b border-[#1E293B]">
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div className="max-w-3xl mb-10">
          <h2 className="text-xs font-mono font-bold uppercase tracking-wider text-[#38BDF8]">
            // System Design &amp; Architectural Governance
          </h2>
          <h3 className="mt-2 text-3xl font-extrabold text-[#F8FAFC]">
            Architecture Topology &amp; Decision Records (ADRs)
          </h3>
          <p className="mt-2 text-sm text-[#94A3B8]">
            High-level platform topology and documented Architecture Decision Records evaluating trade-offs, security, and cost.
          </p>
        </div>

        {/* Interactive Architecture Diagram Card */}
        <div className="p-4 sm:p-6 rounded-xl bg-[#111827] border border-[#1E293B] shadow-2xl mb-12">
          <div className="flex items-center justify-between pb-4 mb-4 border-b border-[#1E293B]">
            <div className="flex items-center space-x-2">
              <span className="h-3 w-3 rounded-full bg-[#EF4444]" />
              <span className="h-3 w-3 rounded-full bg-[#F59E0B]" />
              <span className="h-3 w-3 rounded-full bg-[#10B981]" />
              <span className="text-xs font-mono text-[#94A3B8] ml-2">VIKAS RAO // ARCHITECTURAL TOPOLOGY</span>
            </div>
            <span className="text-[11px] font-mono text-[#38BDF8] bg-[#0B1120] px-2 py-0.5 rounded border border-[#1E293B]">
              Multi-Cloud Ecosystem
            </span>
          </div>

          <div className="w-full flex justify-center bg-[#0B1120] rounded-lg p-2 border border-[#1E293B] overflow-hidden">
            <img
              src="/assets/architecture-overview.svg"
              alt="Multi-Cloud Architecture Topology"
              className="w-full max-w-5xl h-auto rounded"
            />
          </div>
        </div>

        {/* ADR List */}
        <div>
          <h4 className="text-lg font-bold text-[#F8FAFC] mb-4 flex items-center gap-2">
            <span className="text-[#38BDF8] font-mono">▸</span>
            Architecture Decision Records (ADRs)
          </h4>
          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
            {adrs.map((adr) => (
              <div key={adr.id} className="p-4 rounded-lg bg-[#111827] border border-[#1E293B]">
                <div className="flex items-center justify-between text-xs font-mono mb-2">
                  <span className="text-[#38BDF8] font-bold">{adr.id}</span>
                  <span className="text-[#10B981] bg-[#059669]/10 px-2 py-0.5 rounded border border-[#059669]/20">
                    {adr.status}
                  </span>
                </div>
                <h5 className="text-sm font-semibold text-[#F8FAFC]">{adr.title}</h5>
                <span className="text-[11px] font-mono text-[#94A3B8] mt-2 block">{adr.target}</span>
              </div>
            ))}
          </div>
        </div>
      </div>
    </section>
  );
}

