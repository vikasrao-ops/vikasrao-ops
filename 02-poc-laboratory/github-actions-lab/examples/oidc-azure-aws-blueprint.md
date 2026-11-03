# OIDC Federated Authentication Blueprint: Azure & AWS

## 1. Concept: Keyless Authentication
Hardcoding long-lived cloud credentials (`AWS_SECRET_ACCESS_KEY` or `AZURE_CLIENT_SECRET`) in GitHub repository secrets exposes organizations to token theft. Using OpenID Connect (OIDC), GitHub Actions requests a short-lived JSON Web Token (JWT) from GitHub's OIDC provider and exchanges it directly with cloud STS (Security Token Service) endpoints.

---

## 2. GitHub Actions Workflow Configuration
```yaml
permissions:
  id-token: write  # Mandatory for requesting the OIDC JWT
  contents: read

steps:
  # Azure Keyless Authentication via OIDC
  - name: 'Azure Login via OIDC'
    uses: azure/login@v2
    with:
      client-id: ${{ secrets.AZURE_CLIENT_ID }}
      tenant-id: ${{ secrets.AZURE_TENANT_ID }}
      subscription-id: ${{ secrets.AZURE_SUBSCRIPTION_ID }}

  # AWS Keyless Authentication via OIDC
  - name: 'Configure AWS Credentials via OIDC'
    uses: aws-actions/configure-aws-credentials@v4
    with:
      role-to-assume: arn:aws:iam::123456789012:role/GitHubActionsOIDCRole
      aws-region: us-east-1
```

