# Enterprise Tagging Policy & FinOps Allocation Specification

## 1. Mandatory Tag Taxonomy

Every provisioned cloud resource across Azure, AWS, and GCP must adhere to the following tagging standard:

| Tag Key | Allowed Values / Format | Description | Required Scope |
| :--- | :--- | :--- | :--- |
| **`Environment`** | `dev`, `staging`, `prod`, `poc` | Target runtime tier | All resources |
| **`Owner`** | Valid team email or slug (e.g. `platform-engineering`) | Primary operational team | All resources |
| **`CostCenter`** | `CC-[DEPARTMENT]-[ID]` (e.g. `CC-INFRA-104`) | Financial accounting ledger | All resources |
| **`ManagedBy`** | `Terraform`, `Helm` | Automation orchestrator | All IaC resources |
| **`DataSensitivity`**| `Public`, `Internal`, `Confidential`, `Restricted`| Data security tier | Storage & Databases |

---

## 2. Waste Detection Algorithms

1. **Unattached Disks:**
   - AWS: EBS volumes in `available` state for $> 7$ days.
   - Azure: Managed Disks where `managedBy` attribute is null.
2. **Idle Public IP Addresses:**
   - Public IPs not mapped to a network interface or load balancer incur hourly idle reservation surcharges ($0.005/hour).
3. **Rightsizing Candidates:**
   - Compute VMs with average CPU utilization $< 5\%$ over a 14-day rolling window qualify for immediate 50% instance family reduction.

