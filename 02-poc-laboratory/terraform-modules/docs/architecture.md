# Architecture Specification: Reusable Enterprise Terraform Modules

## Architectural Topology
Demonstrates modular Infrastructure as Code engineering. Separates core infrastructure building blocks into independently testable, version-controlled modules.

```mermaid
flowchart TD
    App["Consumer Root Module"] --> ModAz["module: azure-vnet (VNet + Subnets)"]
    App --> ModAws["module: aws-vpc (VPC + IGW + Subnets)"]
```

