# AKS Microservices CI/CD Pipeline

[![Kubernetes](https://img.shields.io/badge/Kubernetes-1.28%2B-326CE5?logo=kubernetes&logoColor=white)](https://kubernetes.io/)
[![Terraform](https://img.shields.io/badge/Terraform-1.5%2B-623CE4?logo=terraform&logoColor=white)](https://www.terraform.io/)
[![Helm 3](https://img.shields.io/badge/Helm-v3-0F1689?logo=helm&logoColor=white)](https://helm.sh/)
[![Azure DevOps](https://img.shields.io/badge/Azure_DevOps-Pipelines-0078D7?logo=azure-devops&logoColor=white)](https://azure.microsoft.com/services/devops/)
[![Trivy](https://img.shields.io/badge/Aqua_Trivy-Container_Scan-1B74E4?logo=aqua&logoColor=white)](https://trivy.dev/)

A production-grade cloud-native microservices platform running on Microsoft Azure Kubernetes Service (AKS). Provisions a secure AKS cluster and Azure Container Registry (ACR) using Terraform, packages services using Helm 3 charts (with HPA, NetworkPolicy, and Ingress), and automates zero-downtime rolling releases via Azure DevOps multi-stage pipelines with Aqua Trivy vulnerability gates.

---

## Architecture Overview

```mermaid
flowchart TD
    subgraph CI_CD ["Automated CI/CD Pipeline (Azure DevOps)"]
        GitCommit([Git Push to Main]) --> Stage1[Unit Tests & Node Lint]
        Stage1 --> Stage2[Docker OCI Build]
        Stage2 --> Stage3[Aqua Trivy CVE Audit<br/>Fail on Critical/High]
        Stage3 --> Stage4[Push Image to ACR]
        Stage4 --> Stage5[Helm Upgrade --install<br/>Rolling Zero Downtime]
    end

    subgraph Azure_Platform ["Microsoft Azure Infrastructure (Terraform)"]
        ACR[(Azure Container Registry)]
        
        subgraph AKS_Cluster ["Azure Kubernetes Service (AKS)"]
            IngressController[Ingress-NGINX Controller]
            
            subgraph Microservice_Pods ["Workload Namespace"]
                HPA[Horizontal Pod Autoscaler<br/>CPU: 70% | Memory: 80%]
                Pod1[Pod Instance 1]
                Pod2[Pod Instance 2]
                Pod3[Pod Instance 3]
            end

            NetPol{NetworkPolicy<br/>Default Ingress Deny}
        end
    end

    Stage4 -.->|Push OCI| ACR
    Stage5 -.->|Deploy Helm| AKS_Cluster
    ACR -.->|Managed Identity AcrPull| AKS_Cluster
    IngressController --> NetPol --> Microservice_Pods
    HPA -.->|Scale| Microservice_Pods
```

---

## Core Platform Capabilities

- **Automated Infrastructure:** Declarative provisioning of Azure Kubernetes Service (system and user nodepools) and Azure Container Registry via modular Terraform.
- **Role-Based Container Pulls:** Secure passwordless integration using Azure Managed Identity (`AcrPull` role assignment).
- **Hardened Kubernetes Runtime:** Non-root execution (`runAsNonRoot: true`, `runAsUser: 1000`), dropped Linux capabilities, and zero-trust ingress `NetworkPolicy`.
- **Dynamic Autoscaling & Resilience:** Horizontal Pod Autoscaler (HPA) auto-scaling replicas between 3 and 10 based on CPU/memory pressure.
- **Container Vulnerability Gate:** Aqua Trivy scans every image in CI/CD, halting deployment if CVEs exceed policy thresholds.

---

## Code Highlights

### 1. Terraform AKS Cluster & ACR Integration
```hcl
# Managed Azure Kubernetes Service Cluster with Azure CNI
resource "azurerm_kubernetes_cluster" "aks" {
  name                = "aks-${var.project_name}-${var.environment}"
  location            = azurerm_resource_group.aks_rg.location
  resource_group_name = azurerm_resource_group.aks_rg.name
  dns_prefix          = "aks-${var.project_name}-${var.environment}"
  kubernetes_version  = "1.28.3"

  default_node_pool {
    name                = "systempool"
    node_count          = 2
    vm_size             = "Standard_D2s_v5"
    enable_auto_scaling = true
    min_count           = 2
    max_count           = 4
    vnet_subnet_id      = azurerm_subnet.aks_subnet.id
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    network_plugin = "azure"
    network_policy = "azure"
  }
}

# Passwordless AcrPull Role Assignment
resource "azurerm_role_assignment" "aks_acr_pull" {
  principal_id         = azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id
  role_definition_name = "AcrPull"
  scope                = azurerm_container_registry.acr.id
}
```

### 2. Helm 3 Deployment & Security Context (`charts/microservice/`)
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: orders-microservice
spec:
  replicas: 3
  selector:
    matchLabels:
      app: orders-microservice
  template:
    metadata:
      labels:
        app: orders-microservice
    spec:
      containers:
        - name: orders-microservice
          image: "craksprod.azurecr.io/orders-service:1.0.0"
          ports:
            - containerPort: 8080
          securityContext:
            runAsNonRoot: true
            runAsUser: 1000
            allowPrivilegeEscalation: false
            capabilities:
              drop: ["ALL"]
          livenessProbe:
            httpGet:
              path: /health
              port: 8080
            initialDelaySeconds: 15
```

### 3. Azure DevOps CI/CD Multi-Stage Pipeline (`azure-pipelines/azure-pipelines.yml`)
```yaml
stages:
  - stage: BuildAndScan
    jobs:
      - job: ContainerBuild
        steps:
          - script: docker build -t $(acrName)/$(imageName):$(imageTag) src/orders-service
          - script: |
              trivy image --severity HIGH,CRITICAL --exit-code 1 $(acrName)/$(imageName):$(imageTag)
            displayName: 'Trivy CVE Security Audit'

  - stage: DeployToAKS
    dependsOn: PublishArtifacts
    jobs:
      - deployment: HelmDeploy
        environment: 'aks-production-cluster'
        strategy:
          runOnce:
            deploy:
              steps:
                - task: AzureCLI@2
                  inputs:
                    inlineScript: |
                      az aks get-credentials --resource-group $(aksResourceGroup) --name $(aksClusterName)
                      helm upgrade --install orders-service charts/microservice \
                        --namespace production --set image.tag=$(imageTag) --wait
```

---

## Directory Layout

```
.
├── azure-pipelines/
│   └── azure-pipelines.yml         # Multi-stage CI/CD pipeline
├── charts/
│   └── microservice/               # Production Helm 3 chart
│       ├── Chart.yaml              # Chart metadata
│       ├── values.yaml             # Configurable parameters
│       └── templates/              # Deployment, Service, Ingress, HPA, NetPol
├── infrastructure/
│   ├── main.tf                     # AKS & ACR infrastructure
│   ├── variables.tf                # Cluster parameters
│   ├── outputs.tf                  # Cluster credentials & endpoints
│   └── versions.tf                 # Terraform provider constraints
├── src/
│   └── orders-service/             # Node.js containerized microservice
│       ├── Dockerfile              # Hardened Alpine multi-stage build
│       ├── server.js               # Microservice with probes & routes
│       └── package.json            # Node runtime dependencies
└── examples/
    └── terraform.tfvars.example    # Variable defaults
```

---

## Deployment Walkthrough

```bash
# 1. Provision AKS & ACR Infrastructure
cd infrastructure
terraform init
terraform plan -var-file="../examples/terraform.tfvars.example" -out=tfplan
terraform apply tfplan

# 2. Deploy Microservice via Helm
az aks get-credentials --resource-group rg-aksmicro-prod --name aks-aksmicro-prod
helm upgrade --install orders-service ../charts/microservice --namespace production --create-namespace
```
