export interface Project {
  id: string;
  title: string;
  category: "Azure" | "AWS" | "DevSecOps" | "Kubernetes" | "Multi-Cloud" | "Observability" | "FinOps";
  badge: string;
  description: string;
  highlights: string[];
  techStack: string[];
  githubUrl: string;
  status: "Production Architecture" | "Active Lab";
}

export interface PocLab {
  id: string;
  title: string;
  category: "Terraform" | "CI/CD" | "Containers" | "Kubernetes" | "Security" | "Observability" | "FinOps";
  description: string;
  githubUrl: string;
}

export const CANDIDATE_PROFILE = {
  name: "Vikas Rao",
  githubUsername: "vikasrao-ops",
  tagline: "Building Secure, Scalable and Automated Cloud Infrastructure.",
  targetPositioning: "Multi-Cloud DevOps Engineer | Azure | AWS | Terraform | Kubernetes | DevSecOps",
  summary:
    "DevOps and DevSecOps Engineer with 2+ years of professional engineering experience specializing in Microsoft Azure enterprise cloud infrastructure, Terraform IaC, and automated CI/CD release engineering. Backed by practical hands-on AWS architecture projects and foundational GCP exploration.",
  experienceYears: "2+ Years",
  email: "contact.vikasrao.ops@gmail.com",
  github: "https://github.com/vikasrao-ops",
  linkedin: "https://linkedin.com/in/",
};

export const SKILL_CATEGORIES = [
  {
    name: "Cloud Platforms",
    skills: [
      { name: "Microsoft Azure (Primary)", level: "Professional (2+ Yrs)", focus: "Landing Zones, Hub-Spoke, Policy, RBAC, Private Link" },
      { name: "Amazon Web Services", level: "Hands-on Projects", focus: "Multi-AZ VPC, EC2 SSM, KMS CMK, S3 Hardening" },
      { name: "Google Cloud Platform", level: "Foundational POC", focus: "Cloud Storage, Service Account IAM, VPC Peering" },
    ],
  },
  {
    name: "Infrastructure as Code & Orchestration",
    skills: [
      { name: "Terraform (HCL)", level: "Advanced", focus: "Modular Architecture, Remote State Locking, Checkov" },
      { name: "Kubernetes", level: "Proficient", focus: "Helm 3, Ingress-NGINX, HPA, NetworkPolicies, Probes" },
      { name: "Docker", level: "Advanced", focus: "Multi-stage builds, Distroless, Non-root, CVE reduction" },
    ],
  },
  {
    name: "CI/CD & DevSecOps",
    skills: [
      { name: "GitHub Actions", level: "Advanced", focus: "Matrix builds, Reusable workflows, Composite actions, OIDC" },
      { name: "Azure DevOps", level: "Professional", focus: "Multi-stage YAML pipelines, Environment approval gates" },
      { name: "Security Toolchain", level: "Proficient", focus: "Gitleaks, Semgrep SAST, Aqua Trivy, Syft SBOM" },
    ],
  },
  {
    name: "Observability & Cloud Governance",
    skills: [
      { name: "Prometheus & Grafana", level: "Proficient", focus: "Custom metrics, PromQL quantile alerts, Node Exporter" },
      { name: "FinOps & Cost Control", level: "Proficient", focus: "Tagging compliance, Orphaned disk detection, Infracost" },
    ],
  },
];

export const FLAGSHIP_PROJECTS: Project[] = [
  {
    id: "azure-enterprise-landing-zone",
    title: "Azure Enterprise Landing Zone (CAF)",
    category: "Azure",
    badge: "Primary Platform • 2+ Yrs Exp",
    description:
      "Production-grade, modular Terraform implementation of an enterprise Microsoft Azure landing zone following the Cloud Adoption Framework (CAF). Incorporates Hub-and-Spoke network isolation, Azure Private Endpoints, centralized Log Analytics, and Azure Policy compliance.",
    highlights: [
      "Hub-and-Spoke VNet peering with isolated app, data, and management subnets",
      "Private Endpoints for Azure Storage resolving via Private DNS Zones (Zero public IP ingress)",
      "Automated Azure Policy enforcing approved geographical deployment regions",
      "Log Analytics Workspace centralized operational diagnostic telemetry",
    ],
    techStack: ["Terraform", "Azure", "Azure Policy", "VNet Peering", "Private Link", "Checkov"],
    githubUrl: "https://github.com/vikasrao-ops/azure-enterprise-landing-zone",
    status: "Production Architecture",
  },
  {
    id: "aws-secure-infrastructure",
    title: "AWS Secure Multi-AZ Infrastructure",
    category: "AWS",
    badge: "Hands-on Architecture Project",
    description:
      "A modular, zero-trust Terraform implementation of a production-hardened AWS Multi-AZ Infrastructure. Demonstrates practical engineering expertise in 3-tier VPC network isolation, keyless AWS Systems Manager (SSM) management, and customer-managed KMS encryption.",
    highlights: [
      "3-Tier Multi-AZ VPC topology with public, private app, and isolated database subnets",
      "Keyless EC2 management via AWS Systems Manager (SSM) Session Manager (Port 22 eliminated)",
      "Hardened S3 bucket with customer-managed KMS key rotation and public access block",
      "CloudWatch Metric Alarms monitoring compute threshold metrics",
    ],
    techStack: ["Terraform", "AWS", "VPC", "KMS CMK", "SSM Session Manager", "S3", "CloudWatch"],
    githubUrl: "https://github.com/vikasrao-ops/aws-secure-infrastructure",
    status: "Production Architecture",
  },
  {
    id: "devsecops-platform",
    title: "DevSecOps Shift-Left Security Platform",
    category: "DevSecOps",
    badge: "Security Automation Pipeline",
    description:
      "An end-to-end, shift-left DevSecOps automation pipeline engineered using GitHub Actions, Gitleaks, Semgrep SAST, Aqua Trivy, and Anchore Syft. Features a security-hardened, multi-stage Python microservice with non-root security contexts.",
    highlights: [
      "Gitleaks pre-commit and pipeline verification blocking committed secrets",
      "Semgrep static application security testing scanning for OWASP vulnerabilities",
      "Aqua Trivy container image scanning with zero critical CVE gate",
      "Anchore Syft generating machine-readable SPDX Software Bill of Materials (SBOM)",
    ],
    techStack: ["GitHub Actions", "Docker", "Gitleaks", "Semgrep", "Trivy", "Syft SBOM", "Python"],
    githubUrl: "https://github.com/vikasrao-ops/devsecops-platform",
    status: "Production Architecture",
  },
  {
    id: "kubernetes-platform",
    title: "Cloud-Native Kubernetes Platform & Helm",
    category: "Kubernetes",
    badge: "Container Orchestration",
    description:
      "A production-grade Kubernetes platform architecture featuring parameterized Helm 3 charts, Ingress-NGINX routing, Horizontal Pod Autoscaling (HPA), zero-trust NetworkPolicies, and restricted Pod Security Standards.",
    highlights: [
      "Parameterized Helm 3 chart with multi-environment value overlays",
      "Horizontal Pod Autoscaling dynamically balancing pods based on CPU/Memory load",
      "Ingress-NGINX with TLS termination and zero-trust microservice routing",
      "Strict NetworkPolicy default-deny isolating cross-namespace traffic",
    ],
    techStack: ["Kubernetes", "Helm 3", "Ingress-NGINX", "HPA", "NetworkPolicy", "Docker"],
    githubUrl: "https://github.com/vikasrao-ops/kubernetes-platform",
    status: "Production Architecture",
  },
  {
    id: "multi-cloud-automation",
    title: "Multi-Cloud Infrastructure Automation",
    category: "Multi-Cloud",
    badge: "Cross-Cloud IaC Engineering",
    description:
      "A modular, cross-cloud automation framework demonstrating comparative infrastructure provisioning across Microsoft Azure (Primary), Amazon Web Services (Hands-on), and Google Cloud Platform (Foundational Storage & IAM POC).",
    highlights: [
      "Decoupled state architectures eliminating cross-cloud failure blast radiuses",
      "Unified tagging and FinOps accounting taxonomies across three cloud providers",
      "GitHub Actions matrix pipeline validating multi-provider HCL configurations",
      "Detailed architectural comparison matrix analyzing networking, IAM, and storage",
    ],
    techStack: ["Terraform", "Azure", "AWS", "Google Cloud", "GitHub Actions", "IaC"],
    githubUrl: "https://github.com/vikasrao-ops/multi-cloud-automation",
    status: "Production Architecture",
  },
  {
    id: "observability-platform",
    title: "Enterprise Cloud Observability Platform",
    category: "Observability",
    badge: "Telemetry & SRE",
    description:
      "A turnkey, production-grade telemetry and observability stack built on Prometheus, Grafana, and Node Exporter. Includes automated datasource/dashboard provisioning as code, SLI/SLO tracking, threshold alerting, and incident response runbooks.",
    highlights: [
      "Docker Compose multi-container stack with Prometheus, Grafana, and Node Exporter",
      "Automated Grafana dashboard and datasource provisioning as versioned code",
      "PromQL alert rules evaluating high CPU, low memory, and target downtime",
      "Comprehensive SRE runbooks detailing incident triage and SLI/SLO targets",
    ],
    techStack: ["Prometheus", "Grafana", "Node Exporter", "Docker Compose", "PromQL", "SRE"],
    githubUrl: "https://github.com/vikasrao-ops/observability-platform",
    status: "Production Architecture",
  },
  {
    id: "finops-governance",
    title: "FinOps Cloud Cost Governance Scanner",
    category: "FinOps",
    badge: "Cost Engineering & Automation",
    description:
      "An automated multi-cloud cost optimization and governance scanner built in Python. Audits resource inventories across Azure and AWS for tagging compliance, detects orphaned and idle cloud assets, and generates actionable dollar-savings recommendations.",
    highlights: [
      "Identifies unattached EBS and Azure Managed Disks generating wasted spend",
      "Detects unassociated idle Public IPs and underutilized compute instances",
      "Enforces mandatory tagging compliance (Environment, Owner, CostCenter)",
      "Outputs executive JSON and Markdown reports with projected annual dollar savings",
    ],
    techStack: ["Python 3", "FinOps", "Cloud APIs", "JSON Inventory", "Automation"],
    githubUrl: "https://github.com/vikasrao-ops/finops-governance",
    status: "Production Architecture",
  },
];

export const POC_LABS: PocLab[] = [
  { id: "azure-terraform-poc", title: "azure-terraform-poc", category: "Terraform", description: "Modular Azure Storage Account & private blob container with HCL validation.", githubUrl: "https://github.com/vikasrao-ops/azure-terraform-poc" },
  { id: "aws-terraform-poc", title: "aws-terraform-poc", category: "Terraform", description: "AWS S3 remote state backend with DynamoDB concurrency locking table.", githubUrl: "https://github.com/vikasrao-ops/aws-terraform-poc" },
  { id: "gcp-foundation-poc", title: "gcp-foundation-poc", category: "Terraform", description: "Google Cloud Storage with Uniform Access & least-privilege IAM service account.", githubUrl: "https://github.com/vikasrao-ops/gcp-foundation-poc" },
  { id: "terraform-modules", title: "terraform-modules", category: "Terraform", description: "Reusable, versioned Terraform modules for Azure VNet and AWS VPC networking.", githubUrl: "https://github.com/vikasrao-ops/terraform-modules" },
  { id: "azure-devops-pipeline", title: "azure-devops-pipeline", category: "CI/CD", description: "Multi-stage YAML pipeline with Checkov scan and gated production approval checks.", githubUrl: "https://github.com/vikasrao-ops/azure-devops-pipeline" },
  { id: "github-actions-lab", title: "github-actions-lab", category: "CI/CD", description: "Matrix builds, reusable workflows, composite actions, and keyless OIDC federation.", githubUrl: "https://github.com/vikasrao-ops/github-actions-lab" },
  { id: "docker-lab", title: "docker-lab", category: "Containers", description: "Multi-stage Docker builds comparing Debian, Alpine, and Distroless CVE footprints.", githubUrl: "https://github.com/vikasrao-ops/docker-lab" },
  { id: "kubernetes-lab", title: "kubernetes-lab", category: "Kubernetes", description: "Rolling updates, ConfigMap/Secret injection, and Pod Disruption Budgets (PDB).", githubUrl: "https://github.com/vikasrao-ops/kubernetes-lab" },
  { id: "devsecops-security-lab", title: "devsecops-security-lab", category: "Security", description: "Pre-commit hooks, custom Semgrep SAST rules, and Gitleaks secret scanning.", githubUrl: "https://github.com/vikasrao-ops/devsecops-security-lab" },
  { id: "ansible-lab", title: "ansible-lab", category: "Containers", description: "Idempotent Linux OS security baselining (SSH keys only, UFW default deny, fail2ban).", githubUrl: "https://github.com/vikasrao-ops/ansible-lab" },
  { id: "prometheus-grafana-lab", title: "prometheus-grafana-lab", category: "Observability", description: "Custom application metric instrumentation with P95/P99 latency quantiles.", githubUrl: "https://github.com/vikasrao-ops/prometheus-grafana-lab" },
  { id: "cloud-finops-lab", title: "cloud-finops-lab", category: "FinOps", description: "Infracost pull-request cost diff automation demonstrating 95% monthly savings.", githubUrl: "https://github.com/vikasrao-ops/cloud-finops-lab" },
];

