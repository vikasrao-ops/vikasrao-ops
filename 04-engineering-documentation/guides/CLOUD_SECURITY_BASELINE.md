# Multi-Cloud Zero-Trust Security Baseline & Governance Standard

## 1. Network Security Standard
* **No Direct Internet Ingress to Data Stores:** All relational databases (PostgreSQL, MySQL), cache instances (Redis), and blob stores must reside in private/isolated subnets or have public access explicitly disabled (`public_network_access_enabled = false` / `BlockPublicAcls = true`).
* **Micro-Segmentation via NSGs & Security Groups:**
  * Inbound rules strictly restricted to authorized source CIDR blocks or dependent security groups.
  * Default deny-all inbound traffic rule enforced at highest priority / boundary.
* **Private Link & Private DNS:** Cloud PaaS services must resolve across private virtual networks via Private Endpoints.

---

## 2. Identity & Access Management (IAM) Standard
* **Zero Long-Lived API Keys:** Workload identities (GitHub Actions runners, Azure DevOps pipelines, EC2 instances, Kubernetes pods) must authenticate using OpenID Connect (OIDC) or Azure Managed Identities / AWS IAM Roles.
* **Role-Based Access Control (RBAC):** Deployments follow the principle of least privilege. Broad `Owner` or `AdministratorAccess` roles are forbidden.

---

## 3. Data Protection & Encryption Standard
* **Encryption at Rest:** All managed disks, S3 buckets, and blob containers must enforce AES-256 or Customer-Managed KMS Keys with automatic annual key rotation.
* **Encryption in Transit:** All endpoints enforce TLS 1.2 or higher (`min_tls_version = "TLS1_2"`). Plaintext HTTP requests are automatically rejected.

---

## 4. Shift-Left DevSecOps Standard
* **Commit-Stage Secret Detection:** Gitleaks runs in local pre-commit hooks and CI pipelines to prevent credential leakage.
* **Container Hardening:** Base container images run under unprivileged non-root UIDs, use read-only root filesystems, drop all Linux capabilities (`cap_drop: ALL`), and eliminate compilers from runtime stages.
