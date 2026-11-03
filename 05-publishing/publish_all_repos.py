#!/usr/bin/env python3
"""
Automated GitHub Multi-Repository Publisher
Author: Vikas Rao (vikasrao-ops)
Publishes all 7 Flagship projects, 12 POC labs, and the portfolio website to independent GitHub repositories under vikasrao-ops.
"""

import os
import sys
import json
import shutil
import tempfile
import subprocess
import urllib.request
import urllib.error

GITHUB_USER = "vikasrao-ops"
GITHUB_TOKEN = os.environ.get("GITHUB_PAT")

if not GITHUB_TOKEN:
    print("[ERROR] Environment variable GITHUB_PAT is required.")
    sys.exit(1)

HEADERS = {
    "Authorization": f"token {GITHUB_TOKEN}",
    "Accept": "application/vnd.github.v3+json",
    "User-Agent": GITHUB_USER
}

REPO_CATALOG = [
    # --------------------------------------------------------------------------
    # 7 Flagship Production Architectures
    # --------------------------------------------------------------------------
    {
        "name": "azure-enterprise-landing-zone",
        "description": "Production-grade Microsoft Azure Hub-and-Spoke Landing Zone with Terraform, Policy & Private Endpoints",
        "path": "01-flagship-projects/azure-enterprise-landing-zone",
        "topics": ["azure", "terraform", "landing-zone", "cloud-adoption-framework", "devops", "iac", "infrastructure-as-code"]
    },
    {
        "name": "aws-secure-infrastructure",
        "description": "Hardened AWS Multi-AZ VPC Infrastructure with Keyless SSM, KMS Encryption & S3 Security",
        "path": "01-flagship-projects/aws-secure-infrastructure",
        "topics": ["aws", "terraform", "vpc", "kms", "ssm", "devops", "security", "iac"]
    },
    {
        "name": "devsecops-platform",
        "description": "Shift-Left DevSecOps Security Pipeline with GitHub Actions, Gitleaks, Semgrep, Trivy & Syft SBOM",
        "path": "01-flagship-projects/devsecops-platform",
        "topics": ["devsecops", "github-actions", "security", "sast", "trivy", "gitleaks", "sbom", "docker"]
    },
    {
        "name": "kubernetes-platform",
        "description": "Cloud-Native Kubernetes Platform & Parameterized Helm 3 Chart with Ingress & HPA Autoscaling",
        "path": "01-flagship-projects/kubernetes-platform",
        "topics": ["kubernetes", "helm", "ingress", "hpa", "networkpolicy", "devops", "cloud-native"]
    },
    {
        "name": "multi-cloud-automation",
        "description": "Comparative Multi-Cloud Infrastructure Automation across Azure, AWS, and GCP with Terraform",
        "path": "01-flagship-projects/multi-cloud-automation",
        "topics": ["multi-cloud", "terraform", "azure", "aws", "gcp", "iac", "devops"]
    },
    {
        "name": "observability-platform",
        "description": "Enterprise Cloud Observability & Telemetry Stack with Prometheus, Grafana & Node Exporter",
        "path": "01-flagship-projects/observability-platform",
        "topics": ["observability", "prometheus", "grafana", "monitoring", "sre", "node-exporter", "devops"]
    },
    {
        "name": "finops-governance",
        "description": "Cloud Cost Optimization & Governance Scanner for Tagging Compliance and Idle Asset Remediation",
        "path": "01-flagship-projects/finops-governance",
        "topics": ["finops", "cloud-cost", "azure", "aws", "python", "governance", "cost-optimization"]
    },

    # --------------------------------------------------------------------------
    # 12 Technical Proof-of-Concept Laboratories
    # --------------------------------------------------------------------------
    {
        "name": "azure-terraform-poc",
        "description": "Azure Storage & Container Provisioning Proof-of-Concept in Terraform",
        "path": "02-poc-laboratory/azure-terraform-poc",
        "topics": ["azure", "terraform", "poc", "storage-account", "blob"]
    },
    {
        "name": "aws-terraform-poc",
        "description": "AWS S3 Remote State Backend & DynamoDB Concurrency Locking POC",
        "path": "02-poc-laboratory/aws-terraform-poc",
        "topics": ["aws", "terraform", "s3", "dynamodb", "remote-state"]
    },
    {
        "name": "gcp-foundation-poc",
        "description": "Google Cloud Storage Uniform Access & IAM Service Account Binding POC",
        "path": "02-poc-laboratory/gcp-foundation-poc",
        "topics": ["gcp", "terraform", "cloud-storage", "iam", "google-cloud"]
    },
    {
        "name": "terraform-modules",
        "description": "Reusable, Versioned Terraform Modules for Azure and AWS Cloud Networking",
        "path": "02-poc-laboratory/terraform-modules",
        "topics": ["terraform-modules", "azure", "aws", "vpc", "vnet", "iac"]
    },
    {
        "name": "azure-devops-pipeline",
        "description": "Multi-Stage Azure DevOps YAML Pipeline with Checkov IaC Scanning & Gated Approvals",
        "path": "02-poc-laboratory/azure-devops-pipeline",
        "topics": ["azure-devops", "yaml-pipelines", "checkov", "ci-cd", "devops"]
    },
    {
        "name": "github-actions-lab",
        "description": "Advanced GitHub Actions Patterns: Matrix Builds, Reusable Workflows, Composite Actions & OIDC",
        "path": "02-poc-laboratory/github-actions-lab",
        "topics": ["github-actions", "reusable-workflows", "composite-actions", "oidc", "ci-cd"]
    },
    {
        "name": "docker-lab",
        "description": "Container Hardening Laboratory: Multi-Stage Builds, Alpine vs Distroless & Non-Root Execution",
        "path": "02-poc-laboratory/docker-lab",
        "topics": ["docker", "distroless", "container-security", "alpine", "devops"]
    },
    {
        "name": "kubernetes-lab",
        "description": "Kubernetes Operational Primitives: Rolling Updates, ConfigMaps, Secrets & PodDisruptionBudgets",
        "path": "02-poc-laboratory/kubernetes-lab",
        "topics": ["kubernetes", "kubectl", "configmap", "pdb", "zero-downtime"]
    },
    {
        "name": "devsecops-security-lab",
        "description": "DevSecOps Security Toolchain: Pre-Commit Hooks, Custom Semgrep Rules & Gitleaks",
        "path": "02-poc-laboratory/devsecops-security-lab",
        "topics": ["devsecops", "semgrep", "gitleaks", "pre-commit", "security-tools"]
    },
    {
        "name": "ansible-lab",
        "description": "Automated Linux OS Hardening & Security Baselining with Idempotent Ansible Playbooks",
        "path": "02-poc-laboratory/ansible-lab",
        "topics": ["ansible", "linux-hardening", "ufw", "fail2ban", "devops"]
    },
    {
        "name": "prometheus-grafana-lab",
        "description": "Prometheus Custom Metric Emitter, PromQL Latency Quantiles & Alertmanager Routing Lab",
        "path": "02-poc-laboratory/prometheus-grafana-lab",
        "topics": ["prometheus", "alertmanager", "promql", "metrics", "telemetry"]
    },
    {
        "name": "cloud-finops-lab",
        "description": "Infracost Pull-Request Cloud Cost Estimation & Rightsizing Optimization Lab",
        "path": "02-poc-laboratory/cloud-finops-lab",
        "topics": ["finops", "infracost", "cloud-cost", "terraform", "cost-estimation"]
    },

    # --------------------------------------------------------------------------
    # Portfolio Website
    # --------------------------------------------------------------------------
    {
        "name": "portfolio-website",
        "description": "Interactive Modern Dark Engineering Portfolio Website for Vikas Rao (Next.js, TypeScript, Tailwind)",
        "path": "03-portfolio-website",
        "topics": ["portfolio", "nextjs", "typescript", "tailwindcss", "devops-portfolio"]
    }
]

import time

def make_github_request(url, method="GET", data=None):
    """Executes authenticated GitHub REST API calls with rate-limit retry."""
    encoded_data = json.dumps(data).encode("utf-8") if data else None
    
    for attempt in range(3):
        req = urllib.request.Request(url, data=encoded_data, headers=HEADERS, method=method)
        try:
            with urllib.request.urlopen(req) as response:
                if response.status in [200, 201]:
                    return json.loads(response.read().decode("utf-8"))
                return None
        except urllib.error.HTTPError as e:
            error_body = e.read().decode("utf-8")
            if e.code == 422 and "already exists" in error_body:
                return {"exists": True}
            elif e.code == 403 and "secondary rate limit" in error_body:
                print(f"    [Rate Limit] Exceeded secondary limit. Pausing 35 seconds before retry (attempt {attempt+1}/3)...")
                time.sleep(35)
                continue
            else:
                print(f"    [API Error] {e.code}: {error_body}")
                return None
    return None

def ensure_repository(repo):
    """Ensures repository exists and has correct metadata on GitHub."""
    repo_name = repo["name"]
    print(f"\n=======================================================")
    print(f" Checking / Provisioning Repository: {repo_name}")
    print(f"=======================================================")

    # 1. Check if repo exists
    url = f"https://api.github.com/repos/{GITHUB_USER}/{repo_name}"
    check_req = urllib.request.Request(url, headers=HEADERS, method="GET")
    exists = False
    try:
        with urllib.request.urlopen(check_req) as resp:
            if resp.status == 200:
                exists = True
                print(f"  [OK] Repository '{repo_name}' already exists on GitHub.")
    except urllib.error.HTTPError as e:
        if e.code == 404:
            exists = False

    # 2. Create if not exists
    if not exists:
        create_url = "https://api.github.com/user/repos"
        create_payload = {
            "name": repo_name,
            "description": repo["description"],
            "private": False,
            "has_issues": True,
            "has_projects": True,
            "has_wiki": False,
            "auto_init": False
        }
        res = make_github_request(create_url, method="POST", data=create_payload)
        if res:
            print(f"  [OK] Created new public repository: {repo_name}")
        else:
            print(f"  [FAIL] Failed to create repository: {repo_name}")
            return False

    # 3. Set topics
    time.sleep(3)
    topics_url = f"https://api.github.com/repos/{GITHUB_USER}/{repo_name}/topics"
    make_github_request(topics_url, method="PUT", data={"names": repo["topics"]})
    print(f"  [OK] Set repository topics: {', '.join(repo['topics'])}")
    time.sleep(4)
    return True

def push_project_code(repo, workspace_root):
    """Publishes project files to its standalone GitHub repository."""
    repo_name = repo["name"]
    src_path = os.path.join(workspace_root, repo["path"])

    if not os.path.exists(src_path):
        print(f"  [FAIL] Source path not found: {src_path}")
        return False

    # Create temporary isolated directory for clean git push
    temp_dir = tempfile.mkdtemp(prefix=f"git_push_{repo_name}_")
    try:
        # Copy project contents to temp directory (excluding node_modules or large build caches)
        def ignore_patterns(path, names):
            ignored = set()
            for n in names:
                if n in ["node_modules", ".next", "out", ".terraform", "__pycache__", ".git"]:
                    ignored.add(n)
            return ignored

        shutil.copytree(src_path, temp_dir, dirs_exist_ok=True, ignore=ignore_patterns)

        # Copy global LICENSE if not present in project
        proj_license = os.path.join(temp_dir, "LICENSE")
        if not os.path.exists(proj_license):
            shutil.copy(os.path.join(workspace_root, "LICENSE"), proj_license)

        # Initialize Git in temp directory
        remote_url = f"https://{GITHUB_TOKEN}@github.com/{GITHUB_USER}/{repo_name}.git"

        subprocess.run(["git", "init", "-b", "main"], cwd=temp_dir, check=True, capture_output=True)
        subprocess.run(["git", "config", "user.name", "Vikas Rao"], cwd=temp_dir, check=True, capture_output=True)
        subprocess.run(["git", "config", "user.email", "contact.vikasrao.ops@gmail.com"], cwd=temp_dir, check=True, capture_output=True)
        subprocess.run(["git", "remote", "add", "origin", remote_url], cwd=temp_dir, check=True, capture_output=True)

        subprocess.run(["git", "add", "."], cwd=temp_dir, check=True, capture_output=True)
        commit_res = subprocess.run(["git", "commit", "-m", f"feat: initial production-grade release of {repo_name}"], cwd=temp_dir, capture_output=True, text=True)
        
        # Push to main branch
        push_res = subprocess.run(["git", "push", "-u", "origin", "main", "--force"], cwd=temp_dir, capture_output=True, text=True)
        if push_res.returncode == 0:
            print(f"  [OK] Successfully pushed code to https://github.com/{GITHUB_USER}/{repo_name}")
            return True
        else:
            print(f"  [FAIL] Push failed for {repo_name}: {push_res.stderr}")
            return False

    finally:
        # Secure cleanup of temporary files
        shutil.rmtree(temp_dir, ignore_errors=True)

def main():
    workspace_root = os.path.abspath(os.path.join(os.path.dirname(__file__), ".."))
    print(f"Starting Multi-Repository GitHub Publication for {GITHUB_USER}")
    print(f"Workspace Root: {workspace_root}")

    success_count = 0
    total_count = len(REPO_CATALOG)

    for repo in REPO_CATALOG:
        ok = ensure_repository(repo)
        if ok:
            pushed = push_project_code(repo, workspace_root)
            if pushed:
                success_count += 1

    print("\n=======================================================")
    print(f" Publication Completed: {success_count}/{total_count} Repositories Published.")
    print("=======================================================")

if __name__ == "__main__":
    main()
