#!/usr/bin/env python3
import os
import shutil
import tempfile
import subprocess

GITHUB_USER = "vikasrao-ops"
GITHUB_TOKEN = os.environ.get("GITHUB_PAT")
REPO_NAME = "portfolio-website"

root = os.path.abspath(os.path.join(os.path.dirname(__file__), ".."))
src = os.path.join(root, "03-portfolio-website")
temp_dir = tempfile.mkdtemp(prefix="git_push_portfolio_")

try:
    print(f"Preparing {REPO_NAME} files (excluding node_modules, .next, out)...", flush=True)
    def ignore_filter(path, names):
        ignored = []
        for n in names:
            if n in ["node_modules", ".next", "out", ".git", ".turbo"]:
                ignored.append(n)
        return set(ignored)

    for item in os.listdir(src):
        if item in ["node_modules", ".next", "out", ".git", ".turbo"]:
            continue
        s = os.path.join(src, item)
        d = os.path.join(temp_dir, item)
        if os.path.isdir(s):
            shutil.copytree(s, d, ignore=ignore_filter)
        else:
            shutil.copy2(s, d)

    lic_dest = os.path.join(temp_dir, "LICENSE")
    if not os.path.exists(lic_dest):
        lic_src = os.path.join(root, "05-publishing", "templates", "LICENSE")
        if os.path.exists(lic_src):
            shutil.copy2(lic_src, lic_dest)

    remote_url = f"https://{GITHUB_TOKEN}@github.com/{GITHUB_USER}/{REPO_NAME}.git"

    cmds = [
        ["git", "init"],
        ["git", "config", "user.name", "Vikas Rao"],
        ["git", "config", "user.email", "vikasrao.cloud@gmail.com"],
        ["git", "add", "."],
        ["git", "commit", "-m", "feat: initial production release of portfolio-website"],
        ["git", "branch", "-M", "main"],
        ["git", "remote", "add", "origin", remote_url],
        ["git", "push", "-u", "origin", "main", "--force"]
    ]

    for cmd in cmds:
        p = subprocess.run(cmd, cwd=temp_dir, capture_output=True, text=True)
        if p.returncode != 0 and "push" in cmd:
            print(f"[FAIL] git push error: {p.stderr.strip()}", flush=True)
            exit(1)

    print(f"[SUCCESS] Successfully pushed {REPO_NAME} to GitHub!", flush=True)

finally:
    shutil.rmtree(temp_dir, ignore_errors=True)
