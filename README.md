<!-- HERO SECTION: HIGH-CONTRAST DEEP NAVY ANIMATED HEADER -->
<div align="center">
  <img src="https://capsule-render.vercel.app/api?type=waving&color=0:0B192C,100:1E3E62&height=220&section=header&text=VIKAS%20RAO&fontSize=48&fontColor=ffffff&fontAlignY=36&desc=AZURE%20DEVOPS%20%7C%20DEVSECOPS%20%7C%20SRE%20%7C%20PLATFORM%20ENGINEER&descSize=15&descAlignY=58&descColor=00D8FF" width="100%" />

  <!-- Animated Typing Tagline: High-Contrast Royal Blue (Visible in both Light & Dark Mode) -->
  <a href="https://github.com/vikasrao-ops">
    <img src="https://readme-typing-svg.demolab.com?font=Fira+Code&weight=700&size=20&pause=1000&color=0969DA&center=true&vCenter=true&width=750&lines=Azure%20DevOps%20Engineer%20%7C%20CI%2FCD%20Pipelines;DevSecOps%20%7C%20SonarQube%2C%20Trivy%20%26%20Key%20Vault;Kubernetes%20%28AKS%29%20%26%20SRE%20Observability;Infrastructure%20as%20Code%20with%20Terraform;Immediate%20Joiner%20%280-15%20Days%29%20%7C%20Ex-Cognizant" alt="Typing Tagline" />
  </a>

  <br><br>

  <!-- Status & Quick Links Ribbon -->
  <p align="center">
    <a href="https://linkedin.com/in/vikasrao-connect"><img src="https://img.shields.io/badge/LinkedIn-0077B5?style=for-the-badge&logo=linkedin&logoColor=white" /></a>
    <a href="mailto:vikasrao.connect@gmail.com"><img src="https://img.shields.io/badge/Gmail-EA4335?style=for-the-badge&logo=gmail&logoColor=white" /></a>
    <img src="https://img.shields.io/badge/Experience-2%2B_Years_(Cognizant)-0089D6?style=for-the-badge&logo=microsoft-azure&logoColor=white" />
    <img src="https://img.shields.io/badge/Availability-Immediate_Joiner-00C853?style=for-the-badge&logo=clockify&logoColor=white" />
  </p>
</div>

---

### 👨‍💻 About Me

I am an **Azure DevOps, DevSecOps, SRE, and Platform Engineer** with **2+ years of enterprise experience at Cognizant** delivering cloud infrastructure, automated CI/CD pipelines, and IaC solutions across pharmaceutical and UK retail client environments. 

Through structured, hands-on engineering at **DevOps Insiders**, I have expanded my capabilities into modern **Kubernetes (AKS) orchestration**, **GitOps governance with Atlantis/OPA**, and **automated DevSecOps security scanning**.

- 🏢 **Previous Experience:** Programmer Analyst (Azure Cloud & DevOps) at **Cognizant** (12/2021 – 02/2024).
- 🎯 **Target Roles:** Azure DevOps Engineer | DevSecOps Engineer | Site Reliability Engineer (SRE) | Platform Engineer.
- ⚡ **Key Metrics:** Reduced environment spin-up times by **65%** with Terraform, maintained **99.9% system uptime**, cut MTTR by **35%**, and reduced container images by **45%**.
- 📍 **Status:** Based in India | Open to Relocate (Bangalore / Pan-India / Remote) | Available to join **Immediately (0–15 Days)**.

---

### 🧰 Technical Skills Matrix

<div align="center">

#### **Cloud Platforms & Containers**
<a href="https://skillicons.dev">
  <img src="https://skillicons.dev/icons?i=azure,linux,docker,kubernetes,nginx&theme=dark" />
</a>

<br>

#### **Infrastructure as Code & CI/CD Pipelines**
<a href="https://skillicons.dev">
  <img src="https://skillicons.dev/icons?i=terraform,githubactions,git,bash,powershell,python&theme=dark" />
</a>

<br>

#### **SRE Observability, Security & Developer Tools**
<a href="https://skillicons.dev">
  <img src="https://skillicons.dev/icons?i=prometheus,grafana,vscode,postman&theme=dark" />
</a>

<br>

*(Also Proficient In: `Azure DevOps YAML`, `SonarQube (SAST)`, `Trivy (Container Scan)`, `OWASP ZAP (DAST)`, `Azure Key Vault`, `Open Policy Agent (OPA)`, `Atlantis`, `Log Analytics (KQL)`, `Azure Monitor`)*

</div>

---

### 🏛️ Architecture & Pipeline Workflows

#### **1. Enterprise Azure Landing Zone & Network Isolation**
```mermaid
graph TD
    classDef hub fill:#0d1117,stroke:#00D8FF,stroke-width:2px,color:#fff;
    classDef spoke fill:#0d1117,stroke:#7B42BC,stroke-width:2px,color:#fff;

    Internet["🌐 Public Traffic"] --> AppGW["🛡️ Layer-7 Application Gateway (WAF)"]
    AppGW --> WebSubnet["💻 Web Tier Subnet (NSG Protected)"]
    
    subgraph AzureVNet ["Azure Virtual Network (VNet)"]
        WebSubnet --> ILB["⚙️ Internal Load Balancer"]
        ILB --> AppSubnet["⚙️ App Tier Subnet"]
        AppSubnet --> DBSubnet["🗄️ Private DB Subnet (No Public IP)"]
        AppSubnet -.->|Outbound Egress Only| NATGW["🚪 Azure NAT Gateway"]
    end

    class AppGW,ILB,NATGW hub;
    class WebSubnet,AppSubnet,DBSubnet spoke;
```

<br>

#### **2. Shift-Left DevSecOps Automated CI/CD Pipeline**
```mermaid
flowchart LR
    classDef step fill:#0d1117,stroke:#00D8FF,stroke-width:1.5px,color:#fff;
    classDef gate fill:#0d1117,stroke:#e5534b,stroke-width:2px,color:#fff;
    classDef pass fill:#0d1117,stroke:#2ea043,stroke-width:2px,color:#fff;

    Commit["Code Commit"] --> SAST["🔍 SonarQube (SAST)"]
    SAST --> Build["🐳 Docker Build"]
    Build --> Trivy["🛡️ Trivy (Image Scan)"]
    Trivy --> QualityGate{"🛑 Security Gate"}
    QualityGate -->|High/Crit CVEs| Fail["❌ Break Build"]
    QualityGate -->|Zero High CVEs| Deploy["☸️ Deploy to AKS"]
    Deploy --> Monitor["📊 Prometheus & Grafana"]

    class Commit,SAST,Build,Trivy,Deploy,Monitor step;
    class QualityGate,Fail gate;
    class Deploy pass;
```

---

### 📂 Production Repositories & Real Implementations

<table>
  <tr>
    <td width="50%" valign="top">
      <h3>🛡️ <a href="https://github.com/vikasrao-ops/azure-devsecops-landingzone">Azure DevSecOps Landing Zone</a></h3>
      <p><i>Terraform • Azure DevOps • SonarQube • Trivy • Key Vault</i></p>
      <ul>
        <li>Provisioned a secure 3-tier Azure landing zone with Layer-7 App Gateway, internal Load Balancers, and private subnets with NAT Gateway egress.</li>
        <li>Built automated YAML pipelines integrating SonarQube, Trivy, and OWASP ZAP with quality gates that reject high/critical findings.</li>
        <li>Eliminated 100% of hardcoded secrets using dynamic Azure Key Vault injection.</li>
      </ul>
      <p align="center">
        <a href="https://github.com/vikasrao-ops/azure-devsecops-landingzone">
          <img src="https://img.shields.io/badge/View_Repository-00D8FF?style=for-the-badge&logo=github&logoColor=black" />
        </a>
      </p>
    </td>
    <td width="50%" valign="top">
      <h3>⚙️ <a href="https://github.com/vikasrao-ops/terraform-azure-governance">Terraform GitOps Governance</a></h3>
      <p><i>Terraform • Atlantis • GitHub Actions • Open Policy Agent (OPA)</i></p>
      <ul>
        <li>Implemented GitOps-based pull-request plan/apply workflows powered by Atlantis and GitHub Actions.</li>
        <li>Enforced policy-as-code compliance checks prior to deployment using Open Policy Agent (OPA).</li>
        <li>Managed remote state with automated blob leasing and state-locking on Azure Blob Storage.</li>
      </ul>
      <p align="center">
        <a href="https://github.com/vikasrao-ops/terraform-azure-governance">
          <img src="https://img.shields.io/badge/View_Repository-7B42BC?style=for-the-badge&logo=github&logoColor=white" />
        </a>
      </p>
    </td>
  </tr>
  <tr>
    <td colspan="2" valign="top">
      <h3 align="center">☸️ <a href="https://github.com/vikasrao-ops/aks-microservices-pipeline">Kubernetes Microservices & SRE Observability</a></h3>
      <p align="center"><i>Docker • Azure Kubernetes Service (AKS) • Prometheus • Grafana</i></p>
      <p align="center">
        Engineered multi-stage Dockerfiles reducing production image sizes by <b>45%</b>. Deployed container workloads to <b>AKS</b> with ingress routing, Horizontal Pod Autoscaling (HPA), and real-time SRE golden signal monitoring dashboards in Prometheus and Grafana.
      </p>
      <p align="center">
        <a href="https://github.com/vikasrao-ops/aks-microservices-pipeline">
          <img src="https://img.shields.io/badge/View_Repository-00C853?style=for-the-badge&logo=github&logoColor=white" />
        </a>
      </p>
    </td>
  </tr>
</table>

---

### 📈 GitHub Streak & Engineering Activity

<div align="center">
  <!-- Live GitHub Streak Card (100% Reliable & Non-Rate-Limited) -->
  <img src="https://streak-stats.demolab.com?user=vikasrao-ops&theme=tokyonight&hide_border=false&border_color=0969DA&border_radius=10&background=0D1117&stroke=0969DA&ring=00D8FF&fire=00D8FF&currStreakNum=ffffff" width="60%" />

  <br><br>

  <!-- Key Metrics & Engineering Highlights -->
  <p align="center">
    <img src="https://img.shields.io/badge/Production_Projects-3_Completed-00D8FF?style=for-the-badge&logo=git&logoColor=white" />
    <img src="https://img.shields.io/badge/Enterprise_IaC-Modular_Terraform-7B42BC?style=for-the-badge&logo=terraform&logoColor=white" />
    <img src="https://img.shields.io/badge/Cluster_Orchestration-Kubernetes_(AKS)-326CE5?style=for-the-badge&logo=kubernetes&logoColor=white" />
    <img src="https://img.shields.io/badge/Pipeline_Security-Zero_High_CVEs-00C853?style=for-the-badge&logo=sonarqube&logoColor=white" />
  </p>
</div>

---

<!-- FOOTER SECTION -->
<div align="center">
  <br>
  <h3>📫 Let's Connect</h3>
  <p>Actively interviewing for <b>Azure DevOps Engineer</b>, <b>DevSecOps Engineer</b>, <b>SRE</b>, and <b>Platform Engineer</b> roles.</p>
  
  <a href="https://linkedin.com/in/vikasrao-connect">
    <img src="https://img.shields.io/badge/LinkedIn-Connect-0A66C2?style=for-the-badge&logo=linkedin&logoColor=white" />
  </a>
  <a href="mailto:vikasrao.connect@gmail.com">
    <img src="https://img.shields.io/badge/Email-Direct_Ping-EA4335?style=for-the-badge&logo=gmail&logoColor=white" />
  </a>

  <br><br>
  <img src="https://capsule-render.vercel.app/api?type=waving&color=0:1E3E62,100:0B192C&height=100&section=footer" width="100%" />
</div>
