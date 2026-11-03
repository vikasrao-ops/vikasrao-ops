# Multi-Cloud Architectural Comparison Matrix

A technical comparative analysis across Microsoft Azure, Amazon Web Services (AWS), and Google Cloud Platform (GCP) derived from hands-on Terraform engineering.

---

## 1. Cloud Networking Primitive Comparison

| Dimension | Microsoft Azure (Primary 2+ Yrs) | Amazon Web Services (Hands-on) | Google Cloud Platform (Foundational POC) |
| :--- | :--- | :--- | :--- |
| **Virtual Network Unit** | Virtual Network (VNet) | Virtual Private Cloud (VPC) | Virtual Private Cloud (VPC) |
| **Network Scope** | Regional resource | Regional resource | **Global resource** (subnets are regional) |
| **Subnet Scope** | Single region / availability zone flexible | Strictly bound to a single Availability Zone | Regional |
| **Egress Filtering** | Azure Firewall / UDR default route | NAT Gateway in Public Subnet | Cloud NAT (software-defined, gatewayless) |
| **Private Service Access** | Azure Private Endpoint & Private Link | AWS VPC Endpoint (Interface & Gateway) | Private Service Connect / Google Access |
| **Traffic Inspection** | Network Security Groups (NSGs) & ASGs | Security Groups (stateful) & Network ACLs | VPC Firewall Rules (tag / SA based) |

---

## 2. Identity & Access Management (IAM) Comparison

| Dimension | Microsoft Azure | Amazon Web Services | Google Cloud Platform |
| :--- | :--- | :--- | :--- |
| **Identity Provider** | Microsoft Entra ID (Azure AD) | AWS IAM / Identity Center | Google Cloud Identity / Workspace |
| **Workload Identity** | Azure Managed Identity (System/User) | IAM Roles for EC2 / IRSA / OIDC | IAM Service Accounts with Keyless OIDC |
| **Policy Model** | Role Definitions + Scope Assignment | JSON Policy (Identity & Resource-based) | IAM Roles bound to Members at Scope |
| **Boundary Controls** | Azure Management Groups & Azure Policy | AWS Service Control Policies (SCPs) | GCP Organization Policies |
| **Permission Principle**| Explicit Allow; Least-Privilege Role | Default Deny; Explicit Allow | Default Deny; Explicit Allow |

---

## 3. Object Storage Hardening Comparison

| Dimension | Azure Blob Storage | AWS S3 | Google Cloud Storage (GCS) |
| :--- | :--- | :--- | :--- |
| **Account / Bucket Scope**| Storage Account (Global Namespace) | S3 Bucket (Global Namespace) | GCS Bucket (Global Namespace) |
| **Encryption at Rest** | Platform Key or Customer Key Vault | SSE-S3 or Customer KMS CMK | Google-managed or Cloud KMS |
| **Public Access Block** | `public_network_access_enabled = false`| Block Public Access (4 settings) | `uniform_bucket_level_access = true` |
| **In-Transit Protection** | `min_tls_version = "TLS1_2"` | Enforced via Bucket Policy Deny | Default TLS HTTPS across Google Edge |
| **Versioning & Lifecycle**| Blob versioning & Soft Delete | S3 Versioning & Lifecycle Rules | GCS Object Versioning & Lifecycle |

