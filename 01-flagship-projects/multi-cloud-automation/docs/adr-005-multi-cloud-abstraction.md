# ADR 005: Decoupled Multi-Cloud State Architecture vs Single Unified State

## Status
Accepted

## Context
Deploying infrastructure across multiple cloud providers (Azure, AWS, GCP) within a single Terraform configuration can create tight coupling, where a failure or credential timeout in one cloud provider blocks operations in another.

## Decision
We implemented **Decoupled Provider Architectures**:
1. Infrastructure directories are partitioned by cloud: `infrastructure/azure/`, `infrastructure/aws/`, and `infrastructure/gcp/`.
2. Each cloud target maintains independent state files and separate CI verification jobs.
3. Common variable schemas and tagging taxonomy are maintained via documentation and root orchestration wrappers.

## Alternatives Considered
- **Single Monolithic Multi-Provider State File:** Rejected due to fragile blast radius and permission sprawl (a single deployment identity requires high privileges across Azure, AWS, and GCP simultaneously).

## Consequences & Trade-offs
- **Positive:** Failure in one cloud provider does not impact others; least-privilege deployment credentials; parallel execution.
- **Trade-off:** Requires individual execution commands for each cloud environment.

