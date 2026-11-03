# Architecture Specification: AWS Terraform Remote State POC

## Architectural Topology
Demonstrates best-practice AWS remote state infrastructure with S3 object versioning and DynamoDB concurrency locking (`LockID`).

```mermaid
flowchart TD
    Dev["Terraform Client"] -->|"State Locking (Acquire Lock)"| DynamoDB["DynamoDB Table: terraform-locks-poc"]
    Dev -->|"Encrypted State Write (AES256)"| S3["S3 Bucket: tfstate-backend-poc-* (Versioning Enabled)"]
```

