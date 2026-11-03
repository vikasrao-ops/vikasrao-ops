# Architecture Specification: Infracost Shift-Left Cloud Financial Engineering

## Architectural Workflow
Demonstrates automated pull-request cost estimation using Infracost to project monthly dollar impacts before merging Terraform changes.

```mermaid
flowchart LR
    Dev["Developer Pull Request"] --> Actions["GitHub Actions (.github/workflows/infracost.yml)"]
    Actions --> Infracost["Infracost CLI<br/>• Parse HCL Abstract Syntax Tree<br/>• Query Cloud Pricing API"]
    Infracost --> Diff["Compute Delta: -$1,214 / month (-95%)"]
    Diff --> PRComment["Automated PR Markdown Comment"]
```

