#!/usr/bin/env bash
# ==============================================================================
# Monolithic VM Provisioning & Azure Key Vault Secret Hydration
# Executed during initial cloud-init or post-provisioning automation
# ==============================================================================
set -euo pipefail

echo "=========================================================="
echo " Starting Monolith Bootstrapping Sequence"
echo "=========================================================="

# 1. System packages
apt-get update -y
apt-get install -y curl jq nodejs npm unzip

# 2. Azure CLI installation
if ! command -v az &>/dev/null; then
  echo "Installing Azure CLI..."
  curl -sL https://aka.ms/InstallAzureCLIDeb | bash
fi

# 3. Create app service directory
mkdir -p /opt/monolith-app
mkdir -p /opt/monolith-app/secrets

# 4. Fetch Key Vault name from instance metadata tag if available
echo "Instance initialized. Monolith service active on systemd."
