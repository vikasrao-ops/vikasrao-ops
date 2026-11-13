#!/usr/bin/env python3
"""
Automated GitHub Publisher for Flagship Projects to vikasrao-ops
Projects:
1. azure-devsecops-landingzone
2. terraform-azure-governance
3. aks-microservices-pipeline
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

GITHUB_USER = os.environ.get("GITHUB_USER", "vikasrao-ops")
GITHUB_TOKEN = os.environ.get("GITHUB_PAT")

if not GITHUB_TOKEN:
    print("[ERROR] Environment variable GITHUB_PAT is required.")
    sys.exit(1)

HEADERS = {
    "Authorization": f"token {GITHUB_TOKEN}",
    "Accept": "application/vnd.github.v3+json",
    "User-Agent": GITHUB_USER
}

PROJECTS = [
    {
        "name": "azure-devsecops-landingzone",
        "title": "Azure DevSecOps Landing Zone",
        "description": "Production-ready Microsoft Azure Hub-and-Spoke Landing Zone with Modular Terraform & Azure DevOps DevSecOps Pipeline",
        "path": "01-flagship-projects/azure-devsecops-landingzone",
        "topics": [
            "azure", "terraform", "landing-zone", "devsecops",
            "azure-devops", "cloud-adoption-framework", "checkov", "security"
        ]
    },
    {
        "name": "terraform-azure-governance",
        "title": "Terraform Azure Governance & Policy-as-Code",
        "description": "Automated Azure Cloud Governance and Policy-as-Code with Terraform, Open Policy Agent (OPA/Rego) & GitHub Actions",
        "path": "01-flagship-projects/terraform-azure-governance",
        "topics": [
            "terraform", "azure", "governance", "opa",
            "rego", "conftest", "policy-as-code", "github-actions"
        ]
    },
    {
        "name": "aks-microservices-pipeline",
        "title": "AKS Microservices CI/CD Pipeline",
        "description": "Cloud-Native Microservices on Azure Kubernetes Service (AKS) with Terraform, Helm 3, and Azure DevOps CI/CD Pipeline",
        "path": "01-flagship-projects/aks-microservices-pipeline",
        "topics": [
            "kubernetes", "aks", "helm", "microservices",
            "azure-devops", "trivy", "ci-cd", "cloud-native"
        ]
    }
]

def make_request(url, method="GET", data=None):
    encoded_data = json.dumps(data).encode("utf-8") if data else None
    req = urllib.request.Request(url, data=encoded_data, headers=HEADERS, method=method)
    try:
        with urllib.request.urlopen(req) as resp:
            if resp.status in [200, 201, 204]:
                content = resp.read().decode("utf-8")
                return json.loads(content) if content else {}
    except urllib.error.HTTPError as e:
        if e.code == 404:
            return None
        body = e.read().decode("utf-8", errors="ignore")
        print(f"    [WARN] HTTP {e.code} for {method} {url}: {body}", flush=True)
        return None
    except Exception as e:
        print(f"    [WARN] Request failed: {e}", flush=True)
        return None

def ensure_repository(project):
    name = project["name"]
    print(f"\n--> Checking repository on GitHub: {GITHUB_USER}/{name}...", flush=True)
    check_url = f"https://api.github.com/repos/{GITHUB_USER}/{name}"
    existing = make_request(check_url, method="GET")

    if not existing:
        print(f"    Creating repository {name} under {GITHUB_USER}...", flush=True)
        create_payload = {
            "name": name,
            "description": project["description"],
            "private": False,
            "has_issues": True,
            "has_projects": True,
            "has_wiki": False,
            "auto_init": False
        }
        res = make_request("https://api.github.com/user/repos", method="POST", data=create_payload)
        if not res:
            print(f"    [FAIL] Could not create {name}", flush=True)
            return False
        print(f"    [OK] Successfully created {name}", flush=True)
        time.sleep(2)
    else:
        print(f"    [OK] Repository {name} exists.", flush=True)
        make_request(check_url, method="PATCH", data={"description": project["description"]})

    # Set repository topics
    topics_url = f"https://api.github.com/repos/{GITHUB_USER}/{name}/topics"
    make_request(topics_url, method="PUT", data={"names": project["topics"]})
    return True

def push_project(project, workspace_root):
    name = project["name"]
    src = os.path.join(workspace_root, project["path"])
    if not os.path.exists(src):
        print(f"    [FAIL] Source path does not exist: {src}", flush=True)
        return False

    temp_dir = tempfile.mkdtemp(prefix=f"git_push_{name}_")
    try:
        def ignore_filter(path, names):
            ignored = []
            for item in names:
                if item in [".git", "node_modules", ".terraform", "__pycache__"]:
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
            ["git", "config", "user.email", "contact.vikasrao.ops@gmail.com"],
            ["git", "add", "."],
            ["git", "commit", "-m", f"feat: initial production release of {project['title']}"],
            ["git", "branch", "-M", "main"],
            ["git", "remote", "add", "origin", remote_url],
            ["git", "push", "-u", "origin", "main", "--force"]
        ]

        print(f"    Committing and pushing to origin/main for {name}...", flush=True)
        for cmd in cmds:
            p = subprocess.run(cmd, cwd=temp_dir, capture_output=True, text=True)
            if p.returncode != 0 and "push" in cmd:
                print(f"    [FAIL] git push error: {p.stderr.strip()}", flush=True)
                return False

        print(f"    [SUCCESS] Pushed https://github.com/{GITHUB_USER}/{name}", flush=True)
        return True
    finally:
        shutil.rmtree(temp_dir, ignore_errors=True)

def main():
    root = os.path.abspath(os.path.join(os.path.dirname(__file__), ".."))
    print("=" * 65, flush=True)
    print(f" Publishing 3 Clean Flagships to GitHub Account: {GITHUB_USER}")
    print("=" * 65, flush=True)

    success_list = []
    failed_list = []

    for project in PROJECTS:
        if ensure_repository(project):
            time.sleep(1)
            if push_project(project, root):
                success_list.append(project)
            else:
                failed_list.append(project)
        else:
            failed_list.append(project)
        time.sleep(2)

    print("\n" + "=" * 65, flush=True)
    print(f"SUMMARY: {len(success_list)} succeeded, {len(failed_list)} failed.")
    for p in success_list:
        print(f" [OK] https://github.com/{GITHUB_USER}/{p['name']}")
    for p in failed_list:
        print(f" [FAILED] {p['name']}")
    print("=" * 65, flush=True)

if __name__ == "__main__":
    main()
