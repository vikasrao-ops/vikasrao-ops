# Infrastructure as Code (IaC) Terraform Engineering Standards

## 1. Directory & File Taxonomy
Every Terraform project within this workspace adheres to the standard file layout:
* `versions.tf`: Explicit `required_version` constraint (e.g. `>= 1.5.0`) and provider version locks.
* `variables.tf`: Explicit type declarations, descriptions, and custom `validation` blocks.
* `main.tf`: Core resource declarations and module invocations.
* `outputs.tf`: Meaningful resource attributes exposed for downstream consumption.
* `examples/terraform.tfvars.example`: Example variable definitions.

---

## 2. Formatting, Validation & Linting
* **Strict Formatting:** All `.tf` files must pass `terraform fmt -check -recursive`.
* **Schema Validation:** Configurations must pass `terraform validate` without deprecation warnings.
* **Security Scanning:** Codebases are scanned with Bridgecrew Checkov to enforce CIS Benchmark compliance.

---

## 3. Remote State & Locking
* **No State in Git:** State files (`*.tfstate`, `*.tfstate.backup`) are strictly ignored via root `.gitignore`.
* **Concurrency Locking:** State backends must employ distributed locking mechanisms (Azure Blob Lease or AWS DynamoDB `LockID`) to prevent race conditions during concurrent runs.

---

## 4. Secret Prevention Standard
* **No Hardcoded Tokens:** Under no circumstances should Azure client secrets, AWS secret keys, passwords, or personal access tokens (PAT) be committed to version control.

