#!/usr/bin/env python3
"""
Publishes remaining 10 repositories (9 POCs + Portfolio Website)
Author: Vikas Rao (vikasrao-ops)
"""

import os
import sys
import json
import shutil
import tempfile
import subprocess
import urllib.request
import urllib.error
import time

GITHUB_USER = "vikasrao-ops"
GITHUB_TOKEN = os.environ.get("GITHUB_PAT")

if not GITHUB_TOKEN:
    print("[ERROR] Environment variable GITHUB_PAT is required.", flush=True)
    sys.exit(1)

HEADERS = {
    "Authorization": f"token {GITHUB_TOKEN}",
    "Accept": "application/vnd.github.v3+json",
    "User-Agent": GITHUB_USER
}

REMAINING_REPOS = [
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
    {
        "name": "portfolio-website",
        "description": "Interactive Modern Dark Engineering Portfolio Website for Vikas Rao (Next.js, TypeScript, Tailwind)",
        "path": "03-portfolio-website",
        "topics": ["portfolio", "nextjs", "typescript", "tailwindcss", "devops-portfolio"]
    }
]

def make_request(url, method="GET", data=None):
    encoded_data = json.dumps(data).encode("utf-8") if data else None
    for attempt in range(3):
        req = urllib.request.Request(url, data=encoded_data, headers=HEADERS, method=method)
        try:
            with urllib.request.urlopen(req) as resp:
                if resp.status in [200, 201]:
                    return json.loads(resp.read().decode("utf-8"))
                return None
        except urllib.error.HTTPError as e:
            body = e.read().decode("utf-8")
            if e.code == 422 and "already exists" in body:
                return {"exists": True}
            if e.code == 403 and "rate limit" in body:
                print(f"  [WAIT] Secondary rate limit hit. Sleeping 30s...", flush=True)
                time.sleep(30)
                continue
            if e.code == 404:
                return None
            print(f"  [ERROR] HTTP {e.code}: {body}", flush=True)
            return None
        except Exception as e:
            print(f"  [ERROR] {e}", flush=True)
            time.sleep(2)
    return None

def ensure_repo(repo):
    name = repo["name"]
    print(f"\nProcessing repository: {name}...", flush=True)
    url = f"https://api.github.com/repos/{GITHUB_USER}/{name}"
    check = make_request(url)
    if not check:
        print(f"  Creating repo: {name}...", flush=True)
        create_url = "https://api.github.com/user/repos"
        payload = {
            "name": name,
            "description": repo["description"],
            "private": False,
            "has_issues": True,
            "has_projects": True,
            "auto_init": False
        }
        res = make_request(create_url, method="POST", data=payload)
        if not res:
            print(f"  [FAIL] Could not create {name}", flush=True)
            return False
        print(f"  [OK] Created {name}", flush=True)
        time.sleep(2)
    else:
        print(f"  [OK] Repository {name} already exists", flush=True)

    # Set topics
    topics_url = f"https://api.github.com/repos/{GITHUB_USER}/{name}/topics"
    make_request(topics_url, method="PUT", data={"names": repo["topics"]})
    return True

def push_code(repo, workspace_root):
    name = repo["name"]
    src = os.path.join(workspace_root, repo["path"])
    if not os.path.exists(src):
        print(f"  [FAIL] Source not found: {src}", flush=True)
        return False

    temp_dir = tempfile.mkdtemp(prefix=f"git_push_{name}_")
    try:
        def ignore_filter(path, names):
            ignored = []
            for item in names:
                if item in ["node_modules", ".next", "out", ".terraform", "__pycache__", ".git", ".pytest_cache"]:
                    ignored.append(item)
                elif item.endswith((".tfstate", ".tfstate.backup", ".log")):
                    ignored.append(item)
            return set(ignored)

        for item in os.listdir(src):
            s = os.path.join(src, item)
            d = os.path.join(temp_dir, item)
            if os.path.isdir(s):
                shutil.copytree(s, d, ignore=ignore_filter)
            else:
                shutil.copy2(s, d)

        lic_dest = os.path.join(temp_dir, "LICENSE")
        if not os.path.exists(lic_dest):
            lic_src = os.path.join(workspace_root, "05-publishing", "templates", "LICENSE")
            if os.path.exists(lic_src):
                shutil.copy2(lic_src, lic_dest)

        remote_url = f"https://{GITHUB_TOKEN}@github.com/{GITHUB_USER}/{name}.git"

        cmds = [
            ["git", "init"],
            ["git", "config", "user.name", "Vikas Rao"],
            ["git", "config", "user.email", "vikasrao.cloud@gmail.com"],
            ["git", "add", "."],
            ["git", "commit", "-m", f"feat: initial production release of {name}"],
            ["git", "branch", "-M", "main"],
            ["git", "remote", "add", "origin", remote_url],
            ["git", "push", "-u", "origin", "main", "--force"]
        ]

        for cmd in cmds:
            p = subprocess.run(cmd, cwd=temp_dir, capture_output=True, text=True)
            if p.returncode != 0 and "push" in cmd:
                print(f"  [FAIL] git push error: {p.stderr.strip()}", flush=True)
                return False

        print(f"  [OK] Successfully pushed {name} to GitHub!", flush=True)
        return True
    finally:
        shutil.rmtree(temp_dir, ignore_errors=True)

def main():
    root = os.path.abspath(os.path.join(os.path.dirname(__file__), ".."))
    successes = []
    failures = []

    for repo in REMAINING_REPOS:
        if ensure_repo(repo):
            time.sleep(2)
            if push_code(repo, root):
                successes.append(repo["name"])
            else:
                failures.append(repo["name"])
        else:
            failures.append(repo["name"])
        time.sleep(3)

    print("\n" + "="*50, flush=True)
    print(f"PUBLISHING COMPLETE: {len(successes)} succeeded, {len(failures)} failed.", flush=True)
    for s in successes:
        print(f"  + https://github.com/{GITHUB_USER}/{s}", flush=True)
    for f in failures:
        print(f"  - FAILED: {f}", flush=True)
    print("="*50, flush=True)

if __name__ == "__main__":
    main()
