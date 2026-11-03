# Architecture Specification: Multi-Cloud Infrastructure Automation

## 1. Multi-Cloud Control Plane

This architecture establishes a provider-independent orchestration framework utilizing HashiCorp Terraform modules to manage resources across Microsoft Azure, AWS, and GCP foundational storage from a single automation repository.

```mermaid
flowchart TD
    subgraph Orchestration ["Multi-Cloud Terraform Orchestration"]
        RootPlan["Unified Root Plan & CI Pipeline"]
    end

    subgraph AzureEnv ["Microsoft Azure (Primary Focus)"]
        AzRG["Resource Group: rg-multicloud-prod"]
        AzStorage["Azure Storage Account<br/>(TLS 1.2+ / LRS)"]
        AzRG --- AzStorage
    end

    subgraph AWSEnv ["Amazon Web Services (Hands-on Focus)"]
        S3Bucket["AWS S3 Bucket<br/>(Block Public Access / Versioned)"]
    end

    subgraph GCPEnv ["Google Cloud Platform (Foundational POC)"]
        GCS["Google Cloud Storage (GCS)<br/>(Uniform Bucket-Level Access)"]
        GCP_SA["GCP Service Account<br/>(roles/storage.objectViewer)"]
        GCS --- GCP_SA
    end

    RootPlan --> AzureEnv
    RootPlan --> AWSEnv
    RootPlan --> GCPEnv
```

## 2. Abstraction Design Guidelines

1. **Decoupled State:** Each cloud provider maintains an isolated remote backend state file to eliminate cross-cloud blast radius.
2. **Normalized Tagging:** Standardized tags (`Platform`, `Environment`, `ManagedBy`) ensure consistent FinOps auditing across all three cloud providers.
3. **Provider-Native Security:** Avoids generic lowest-common-denominator abstractions; applies provider-native zero-trust security controls for each cloud.

