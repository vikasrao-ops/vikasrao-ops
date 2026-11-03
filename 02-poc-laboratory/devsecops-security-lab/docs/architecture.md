# Architecture Specification: DevSecOps Security Toolchain

## Architectural Workflow
Demonstrates localized developer shift-left defenses. Prevents code with secrets or common misconfigurations from ever leaving the local developer terminal.

```mermaid
flowchart LR
    Dev["Developer Workstation"] --> Hook["Pre-Commit Hooks (.pre-commit-config.yaml)"]
    Hook --> Gitleaks["Gitleaks (.gitleaks.toml)"]
    Hook --> Semgrep["Semgrep (custom rules)"]
    Hook --> Trivy["Trivy (config & container scanner)"]
    Gitleaks -->|"Pass / Block"| GitTree["Git Index"]
    Semgrep -->|"Pass / Block"| GitTree
    Trivy -->|"Pass / Block"| GitTree
```

