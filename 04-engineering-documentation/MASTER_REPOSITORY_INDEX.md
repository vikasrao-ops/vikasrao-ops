# Master Repository Index — Vikas Rao Engineering Portfolio

This index catalogues all flagship projects, proof-of-concept laboratories, and supporting documentation within the `vikasrao-ops` multi-cloud engineering portfolio.

---

## Flagship Production Architectures (`01-flagship-projects`)

| Project Repository | Domain | Tech Stack | Production Highlights |
| :--- | :--- | :--- | :--- |
| **`azure-enterprise-landing-zone`** | Cloud Platform (Primary) | Azure, Terraform, Azure Policy | Hub-and-Spoke VNet peering, Azure Firewall, Log Analytics workspace, Private Endpoints, RBAC, Policy compliance |
| **`aws-secure-infrastructure`** | Cloud Platform (Hands-on) | AWS, Terraform, KMS | Multi-AZ VPC (public/private/db), EC2 Bastion host, S3 SSE-KMS, IAM boundary policies, CloudWatch |
| **`devsecops-platform`** | Security Automation | GitHub Actions, Trivy, Checkov | Shift-Left pipeline with Gitleaks secret scan, SAST, Checkov IaC scanner, Syft SBOM generation, Trivy container audit |
| **`kubernetes-platform`** | Container Orchestration | Kubernetes, Helm, NGINX | Production Helm chart, Horizontal Pod Autoscaler (HPA), Ingress TLS termination, NetworkPolicies, Health probes |
| **`multi-cloud-automation`** | Cross-Cloud IaC | Azure, AWS, GCP, Terraform | Comparative multi-cloud topology, standardized naming conventions, unified CI pipeline, cross-cloud architecture matrix |
| **`observability-platform`** | Telemetry & SRE | Prometheus, Grafana, Exporters | Metric scraping, Alertmanager rules, Node Exporter, SLI/SLO dashboards, incident runbooks |
| **`finops-governance`** | Cost & Cloud Economics | Python, Azure/AWS APIs | Cloud cost waste identification, tagging compliance auditor, unattached disk detection, rightsizing recommendations |

---

## Technical Proof-of-Concept Laboratories (`02-poc-laboratory`)

| Lab Repository | Core Technical Focus |
| :--- | :--- |
| **`azure-terraform-poc`** | Modular Azure resource group, storage account, and compute provisioning with HCL validation. |
| **`aws-terraform-poc`** | AWS S3 state backend with DynamoDB state locking and parameterized security groups. |
| **`gcp-foundation-poc`** | Google Cloud Platform storage bucket, IAM service account roles, and basic VPC setup. |
| **`terraform-modules`** | Suite of reusable, versioned Terraform modules for enterprise VNet/VPC, VM, and Key Vault. |
| **`azure-devops-pipeline`** | Multi-stage Azure DevOps YAML pipeline featuring build verification, manual approvals, and deployment gates. |
| **`github-actions-lab`** | GitHub Actions workflows showcasing matrix builds, composite actions, and OIDC federated authentication. |
| **`docker-lab`** | Multi-stage Dockerfiles with unprivileged users, distroless runtimes, and vulnerability audits. |
| **`kubernetes-lab`** | Kubernetes core primitives: Pods, Deployments, Services, ConfigMaps, Secrets, and rolling updates. |
| **`devsecops-security-lab`** | Hands-on DevSecOps security toolchain integration: Semgrep, Gitleaks, Hadolint, and Trivy. |
| **`ansible-lab`** | Ansible playbooks for automated Linux OS configuration, user management, and security baselining. |
| **`prometheus-grafana-lab`** | Docker Compose observability stack with Prometheus, Grafana, and automated dashboard provisioning. |
| **`cloud-finops-lab`** | Infracost integration with GitHub Actions for automated pull-request cloud cost diff projections. |

---

## Repository Standards Checklist

All repositories in this portfolio adhere to the following standard structure:

```
<repository-name>/
├── .github/
│   └── workflows/          # Automated CI/CD, linting, or security scanning
├── docs/                   # Architectural diagrams, decision records, runbooks
├── examples/               # Example variable definitions, payloads, or configs
├── infrastructure/         # Terraform, Helm, Docker, or Kubernetes manifests
├── src/                    # Source code, automation scripts, or application files
├── .gitignore              # Clean ignore patterns preventing secret / state leaks
├── CHANGELOG.md            # Semantic version history
├── CONTRIBUTING.md         # Contribution and PR guidelines
├── LICENSE                 # Open-source MIT license
├── Makefile                # Local developer automation commands
└── README.md               # 12-section technical documentation standard
```
