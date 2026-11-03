# Architecture Specification: GCP Foundation POC

## Architectural Topology
Demonstrates foundational Google Cloud Platform infrastructure incorporating Google Cloud Storage (GCS) uniform access policies and least-privilege IAM service account bindings.

```mermaid
flowchart LR
    SA["Service Account: sa-gcp-foundation-poc"] -->|"roles/storage.objectViewer"| GCS["GCS Bucket (Uniform Access / Versioned / 30-Day TTL)"]
```

