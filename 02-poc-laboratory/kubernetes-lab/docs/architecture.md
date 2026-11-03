# Architecture Specification: Resilient Kubernetes Operations

## Architectural Primitives
Demonstrates high-availability deployment mechanics with zero-downtime rolling updates, external configuration injection, and Pod Disruption Budgets during node maintenance.

```mermaid
flowchart TD
    ConfigMap["ConfigMap: lab-app-config"] --> Deployment["Deployment: lab-resilient-app (3 Replicas)"]
    Secret["Secret: lab-app-secret"] --> Deployment
    PDB["PodDisruptionBudget (minAvailable: 2)"] -.->|"Guarantees Capacity during Node Drains"| Deployment
    Deployment --> Service["ClusterIP: lab-resilient-svc"]
```

