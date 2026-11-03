# Architecture Specification: Advanced GitHub Actions Patterns

## Architectural Pipeline Topology
Demonstrates enterprise CI/CD delivery patterns with reusable workflows, composite actions, matrix jobs, and keyless OIDC cloud federation.

```mermaid
flowchart TD
    Trigger["Push / Pull Request"] --> Matrix["Matrix Build Engine<br/>• ubuntu-latest x (Py3.11, Py3.12)<br/>• windows-latest x (Py3.11, Py3.12)"]
    Matrix --> Reusable["Reusable Workflow: .github/workflows/reusable-ci.yml"]
    Reusable --> Composite["Composite Action: .github/actions/setup-tools"]
    Composite --> CloudOIDC["Keyless Cloud OIDC Authentication (Zero Long-Lived Secrets)"]
```

