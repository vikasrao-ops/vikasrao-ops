# ADR 004: Standardizing Helm Packaging and Kubernetes HPA Autoscaling

## Status
Accepted

## Context
Deploying raw Kubernetes YAML manifests across multiple environments (dev, staging, prod) leads to duplicate configuration drift, hardcoded hostnames, and static replica allocations that fail under traffic spikes or cause resource over-provisioning during idle periods.

## Decision
We standardized on:
1. **Parameterized Helm 3 Charts:** All microservice primitives (Deployment, Service, Ingress, HPA, NetworkPolicy) are templatized with environment-specific values files.
2. **Horizontal Pod Autoscaling (v2):** Dynamically scales pod replicas (3 to 10) based on real-time CPU (75%) and Memory (80%) metric thresholds.
3. **Restricted Pod Security Standard:** Containers prohibit privilege escalation (`allowPrivilegeEscalation: false`) and execute under non-root UIDs.

## Alternatives Considered
- **Kustomize:** Good for overlays, but lacks semantic versioning, chart dependency packaging, and rollback capabilities offered natively by Helm.
- **Static Replica Count:** Rejected due to inability to handle unpredictable load spikes or minimize idle cloud compute waste.

## Consequences & Trade-offs
- **Positive:** Automated self-healing, zero-downtime rolling updates, elastic cost optimization, and unified chart management.
- **Trade-off:** Requires Kubernetes Metrics Server running in the cluster for HPA metric evaluation.

