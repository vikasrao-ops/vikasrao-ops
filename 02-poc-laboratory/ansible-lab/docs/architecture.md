# Architecture Specification: Automated Linux OS Hardening

## Architectural Strategy
Demonstrates declarative, idempotent operating system configuration management. Establishes a zero-trust host baseline across fleet virtual machines.

```mermaid
flowchart TD
    Ansible["Ansible Controller (playbooks/hardening.yml)"] --> Inventory["Inventory (inventory.ini)"]
    Inventory --> Node1["web-node-01 (10.0.1.10)"]
    Inventory --> Node2["web-node-02 (10.0.1.11)"]
    Inventory --> Node3["db-node-01 (10.0.2.10)"]
    
    subgraph Baseline ["Security Role Tasks"]
        Task1["1. Install fail2ban & ufw"]
        Task2["2. Disable Root Login (sshd_config)"]
        Task3["3. Disable Password Auth (SSH Keys Only)"]
        Task4["4. Enforce UFW Inbound Default Deny"]
    end

    Node1 -.-> Baseline
    Node2 -.-> Baseline
    Node3 -.-> Baseline
```

