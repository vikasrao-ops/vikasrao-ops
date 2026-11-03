# ADR 003: Multi-AZ 3-Tier Network Isolation and Keyless SSM Management

## Status
Accepted

## Context
Deploying infrastructure on AWS requires strict network segmentation between internet-facing edge routers, business logic applications, and persistent data tiers. Traditional architectures frequently leave SSH port 22 open to the internet with static key pairs, posing significant compromise risks.

## Decision
We implemented:
1. **Multi-AZ 3-Tier Topology:** Public, private application, and isolated database subnets distributed across 2 Availability Zones.
2. **Keyless Session Manager Access:** EC2 instances run with `AmazonSSMManagedInstanceCore` IAM roles, deprecating inbound port 22 security group rules.
3. **SSE-KMS Encryption by Default:** Customer-managed KMS keys enforce data-at-rest protection on S3 buckets and EBS root disks.

## Alternatives Considered
- **Direct SSH with Bastion:** Rejected due to key management overhead and port 22 vulnerability scanning by bots.
- **Single AZ Deployment:** Unsuitable for high availability; Multi-AZ ensures resiliency against data center zone failures.

## Consequences & Trade-offs
- **Positive:** No open management ports to the internet, compliance with CIS AWS Foundations benchmarks, complete audit trails via CloudWatch and AWS CloudTrail.
- **Trade-off:** Multi-AZ NAT Gateway traffic incurs minor data processing costs ($0.045/hour + $0.045/GB).
