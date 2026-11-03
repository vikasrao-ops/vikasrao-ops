# Architecture Specification: AWS Secure Multi-AZ Infrastructure

## 1. Network Topology

The AWS Secure Infrastructure utilizes a 3-tier Multi-AZ Virtual Private Cloud (VPC) design across two Availability Zones, enforcing complete network isolation between the public edge, private applications, and sensitive database storage.

```mermaid
flowchart TD
    Internet((Public Internet)) <--> IGW["Internet Gateway"]

    subgraph AWS_Region ["AWS Region: us-east-1"]
        subgraph VPC ["VPC: 10.20.0.0/16"]
            
            subgraph PublicSubnets ["Public Subnets (Tier 1)"]
                PubAZ1["public-az1: 10.20.0.0/24<br/>• NAT Gateway<br/>• Bastion (SSM)"]
                PubAZ2["public-az2: 10.20.1.0/24<br/>• ALB Endpoint"]
            end

            subgraph PrivateSubnets ["Private App Subnets (Tier 2)"]
                PrivAZ1["private-az1: 10.20.10.0/24<br/>• App Workloads"]
                PrivAZ2["private-az2: 10.20.11.0/24<br/>• App Workloads"]
            end

            subgraph DBSubnets ["Isolated Database Subnets (Tier 3)"]
                DBAZ1["database-az1: 10.20.20.0/24<br/>• RDS PostgreSQL"]
                DBAZ2["database-az2: 10.20.21.0/24<br/>• RDS Standby"]
            end

            subgraph StorageSecurity ["Hardened Storage & Key Management"]
                KMS["AWS KMS CMK<br/>(Auto Key Rotation)"]
                S3["S3 Bucket (SSE-KMS)<br/>• Enforce TLS/HTTPS<br/>• Block Public Access<br/>• Object Versioning"]
            end
        end
    end

    IGW <--> PublicSubnets
    PublicSubnets -->|"Outbound Egress via NAT GW"| PrivateSubnets
    PrivateSubnets -->|"Port 5432 Inbound (SG Controlled)"| DBSubnets
    KMS --- S3
```

## 2. Security Boundaries & Zero-Trust Features

* **SSM Session Manager:** Eliminates public SSH port 22 access. Operators connect via IAM credentials through encrypted AWS Systems Manager tunnels.
* **Isolated Database Tier:** Database subnets have no route table association to Internet Gateways or NAT Gateways, preventing exfiltration or direct ingress.
* **IMDSv2 Enforcement:** EC2 metadata service requires session tokens (`http_tokens = "required"`), preventing SSRF credential theft.
* **Customer Managed KMS Encryption:** All data at rest in S3 and EBS is protected with rotating customer-managed KMS keys.

