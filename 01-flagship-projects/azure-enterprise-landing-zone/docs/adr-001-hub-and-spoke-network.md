# ADR 001: Selection of Hub-and-Spoke Network Architecture with Private Endpoints

## Status
Accepted

## Context
Enterprise cloud environments require isolated network segments for production workloads while maintaining central egress filtering, auditing, on-premises connectivity, and DNS resolution. Direct internet-exposed PaaS services (e.g., Azure Blob Storage, Azure SQL) present security risks and violate zero-trust compliance frameworks (CIS Azure Foundations).

## Decision
We implemented a **Hub-and-Spoke VNet Topology** leveraging Azure Virtual Network Peering and Azure Private Endpoints:
1. **Hub VNet (`10.100.0.0/16`)**: Dedicated to shared services (VPN Gateway, Azure Firewall, Azure Bastion, and jumpbox management).
2. **Spoke VNet (`10.101.0.0/16`)**: Houses application workloads and database tiers with no public IPs.
3. **Private Endpoints**: All PaaS resources (Storage accounts) bind to private IP addresses within `snet-spoke-pe` and map to private DNS zones.

## Alternatives Considered
- **Mesh Topology (Peer all VNets to each other):** Rejected due to quadratic complexity ($O(N^2)$ peering connections) and inability to enforce centralized inspection.
- **Single Flat VNet:** Rejected due to lack of blast radius containment between management infrastructure and tenant workloads.
- **Azure Virtual WAN (vWAN):** Suitable for large multi-region topologies (>50 branches); rejected for initial landing zone scope due to cost overhead ($1.20/hr base fee per vWAN hub).

## Consequences & Trade-offs
- **Positive:** Centralized egress filtering, zero public IP footprint on workload databases, complete audit logging in Log Analytics.
- **Trade-off:** Requires peering routing configuration and cross-VNet DNS zone link management.

