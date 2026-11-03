# Architecture Specification: Multi-Stage Azure DevOps Pipeline

## Architectural Pipeline Topology
Demonstrates enterprise-grade multi-stage Azure DevOps YAML pipeline execution incorporating automated security scanning and gated production approvals.

```mermaid
flowchart LR
    Commit["Git Push (main/develop)"] --> Stage1["Stage 1: Build & Validate<br/>• Python Unit Tests<br/>• Checkov IaC Security"]
    Stage1 --> Stage2["Stage 2: Deploy Staging<br/>(Automated Staging Rollout)"]
    Stage2 --> Gate{"Manual Approval Gate<br/>(Production Environment)"}
    Gate -->|"Approved by Lead"| Stage3["Stage 3: Deploy Production<br/>(Branch == main)"]
```

