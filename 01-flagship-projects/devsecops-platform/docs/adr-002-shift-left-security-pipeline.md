# ADR 002: Shift-Left Security Toolchain & Container Hardening Standard

## Status
Accepted

## Context
Deploying software without automated security checks introduces vulnerabilities (CVEs), hardcoded API credentials, and unverified third-party dependencies into production. Manual security audits create delivery bottlenecks and fail to capture rapid iterative changes.

## Decision
We established a strict **Shift-Left DevSecOps Pipeline** using GitHub Actions:
1. **Secret Scanning at Commit:** Gitleaks runs before any code is built to avoid credential proliferation.
2. **Multi-Stage Container Hardening:** Containers build on minimal Alpine bases, eliminate package managers in the runtime stage, and run under an unprivileged user (`UID 10001:10001`).
3. **Automated Vulnerability Gate:** Aqua Trivy scans container images for vulnerabilities before pushing.
4. **SBOM Generation:** Syft creates an SPDX-compliant Software Bill of Materials for software supply chain transparency (EO 14028 compliance).

## Alternatives Considered
- **Commercial Security Suites (Snyk / Prisma Cloud):** Powerful but require enterprise licensing; open-source toolchains (Gitleaks, Semgrep, Trivy, Syft) provide identical verification capabilities with complete pipeline portability.
- **Post-deployment Scanning Only:** Rejected because identifying CVEs in production increases MTTR and risk exposure.

## Consequences & Trade-offs
- **Positive:** Automated zero-trust quality gate, zero unpatched critical vulnerabilities reaching staging, rapid developer feedback loops.
- **Trade-off:** Adds ~90 seconds to pipeline execution time during image scanning and SBOM generation.

