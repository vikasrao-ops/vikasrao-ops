# Architecture Specification: Azure Enterprise Landing Zone

## 1. Topological Overview

The Azure Enterprise Landing Zone implements the Microsoft Cloud Adoption Framework (CAF) Hub-and-Spoke topology. It establishes an enterprise foundation ensuring isolation, centralized traffic egress, centralized security auditing, and least-privilege boundary enforcement.

```mermaid
flowchart TD
    subgraph ManagementGroup ["Enterprise Management Group Hierarchy"]
        subgraph Sub_Connectivity ["Subscription: Connectivity (Hub)"]
            HubVNet["Hub VNet: 10.100.0.0/16"]
            subgraph HubSubnets ["Hub Subnets"]
                GatewaySubnet["GatewaySubnet: 10.100.0.0/24<br/>(VPN / ExpressRoute)"]
                FirewallSubnet["AzureFirewallSubnet: 10.100.1.0/24<br/>(Central Egress & Inspection)"]
                BastionSubnet["AzureBastionSubnet: 10.100.2.0/24<br/>(Secure Management)"]
                MgmtSubnet["snet-hub-management: 10.100.3.0/24<br/>(Jumpboxes & Utility)"]
            end
        end

        subgraph Sub_Operations ["Subscription: Operations & Telemetry"]
            LogAnalytics["Log Analytics Workspace<br/>(Retention: 30-730 Days)"]
        end

        subgraph Sub_Workload ["Subscription: Production Workload (Spoke)"]
            SpokeVNet["Spoke VNet: 10.101.0.0/16"]
            subgraph SpokeSubnets ["Spoke Subnets"]
                AppSubnet["snet-spoke-app: 10.101.1.0/24<br/>(Microservices / App Tier)"]
                DataSubnet["snet-spoke-data: 10.101.2.0/24<br/>(Database Tier - Default Deny)"]
                PESubnet["snet-spoke-pe: 10.101.3.0/24<br/>(Private Endpoints)"]
            end
            StoragePE["Private Endpoint:<br/>stcoreprod*.blob.core.windows.net"]
            PrivDNS["Private DNS Zone:<br/>privatelink.blob.core.windows.net"]
        end
    end

    HubVNet <-->|"VNet Peering (allow_forwarded_traffic)"| SpokeVNet
    AppSubnet -->|"Port 5432 Only (NSG Controlled)"| DataSubnet
    AppSubnet -->|"Private Link (TLS 1.2+)"| StoragePE
    StoragePE --- PrivDNS
    HubVNet -.->|"Diagnostic Logs"| LogAnalytics
    SpokeVNet -.->|"Diagnostic Logs"| LogAnalytics
```

## 2. Network Segmentation & Security Controls

- **Zero Direct Inbound Internet:** No public IP addresses are assigned to spoke workloads or database interfaces.
- **Micro-segmentation via NSGs:**
  - `nsg-hub-management`: Restricts port 22 access strictly to the Azure Bastion CIDR block.
  - `nsg-spoke-app`: Restricts inbound traffic strictly to verified Hub VNet prefixes on HTTPS 443.
  - `nsg-spoke-data`: Enforces database port access (e.g., PostgreSQL 5432) exclusively from `snet-spoke-app`.
- **Private DNS Link Integration:** Resolves Azure PaaS endpoints internally, avoiding internet-routed FQDN resolution.

