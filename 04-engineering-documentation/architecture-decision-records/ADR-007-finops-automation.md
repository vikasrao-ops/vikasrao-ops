# ADR 007: Automated CLI Cost Scanners vs Third-Party SaaS Platforms

## Status
Accepted

## Context
Cloud infrastructure costs grow uncontrollably without automated detection of idle volumes, unattached IPs, and untagged resources. Commercial FinOps platforms (e.g., CloudZero, Apptio Cloudability) charge steep percentages of total cloud spend (2-4%).

## Decision
We implemented a **Lightweight, Open-Source FinOps Scanner**:
1. Standalone Python CLI executable locally or scheduled within GitHub Actions / Azure Functions cron jobs.
2. Evaluates standard JSON cloud inventories for orphaned resources and tagging defects.
3. Produces actionable dollar-savings projections and structured remediation payloads.

## Alternatives Considered
- **Native Azure Cost Management / AWS Cost Explorer Only:** Useful for reporting, but lack custom heuristic detection for multi-cloud unattached storage consolidation and unified tagging enforcement.
- **Enterprise SaaS:** Prohibitive costs for early-stage or mid-sized engineering infrastructure portfolios.

## Consequences & Trade-offs
- **Positive:** Zero SaaS licensing overhead, customizable detection heuristics, complete pipeline automation.
- **Trade-off:** Requires inventory data ingestion or Cloud CLI permissions to read resource metadata.
