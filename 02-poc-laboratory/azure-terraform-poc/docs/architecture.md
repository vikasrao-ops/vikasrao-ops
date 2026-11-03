# Architecture Specification: Azure Terraform POC

## Architectural Topology
Demonstrates atomic, idempotent provisioning of Microsoft Azure core storage primitives with versioning and private container isolation.

```mermaid
flowchart LR
    RG["Resource Group: rg-terraform-poc-poc"] --> Storage["Storage Account (TLS 1.2+ / LRS)"]
    Storage --> Container["Blob Container (Private / Versioned)"]
```

