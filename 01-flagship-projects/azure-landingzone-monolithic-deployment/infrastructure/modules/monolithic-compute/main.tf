resource "azurerm_network_interface" "vm_nic" {
  name                = "nic-${var.project_name}-app-${var.environment}"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.app_subnet_id
    private_ip_address_allocation = "Dynamic"
  }

  tags = var.tags
}

resource "tls_private_key" "vm_ssh" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Store VM SSH Private Key securely into Key Vault
resource "azurerm_key_vault_secret" "vm_ssh_private_key" {
  name         = "vm-ssh-private-key"
  value        = tls_private_key.vm_ssh.private_key_pem
  key_vault_id = var.key_vault_id
}

# Monolithic Linux Virtual Machine (Zero Public IP)
resource "azurerm_linux_virtual_machine" "monolith" {
  name                = "vm-${var.project_name}-app-${var.environment}"
  location            = var.location
  resource_group_name = var.resource_group_name
  size                = var.vm_size
  admin_username      = var.vm_admin_username

  network_interface_ids = [
    azurerm_network_interface.vm_nic.id
  ]

  admin_ssh_key {
    username   = var.vm_admin_username
    public_key = tls_private_key.vm_ssh.public_key_openssh
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
    disk_size_gb         = 64
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }

  identity {
    type = "SystemAssigned"
  }

  custom_data = base64encode(<<-EOF
    #!/bin/bash
    set -e
    apt-get update -y
    apt-get install -y curl jq nodejs npm unzip

    # Install Azure CLI for Managed Identity Key Vault access
    curl -sL https://aka.ms/InstallAzureCLIDeb | bash

    # Create app directory
    mkdir -p /opt/monolith-app
    cat <<'APP' > /opt/monolith-app/server.js
    const http = require('http');
    const port = 8080;

    const server = http.createServer((req, res) => {
      if (req.url === '/health') {
        res.writeHead(200, { 'Content-Type': 'application/json' });
        res.end(JSON.stringify({ status: 'UP', timestamp: new Date().toISOString() }));
      } else {
        res.writeHead(200, { 'Content-Type': 'application/json' });
        res.end(JSON.stringify({
          application: 'Monolithic Production Service',
          architecture: 'Azure Landing Zone Secure Monolith',
          environment: '${var.environment}',
          vault_connected: true
        }));
      }
    });

    server.listen(port, () => {
      console.log(`Monolithic App listening on port $${port}`);
    });
    APP

    # Create systemd service
    cat <<'SERVICE' > /etc/systemd/system/monolith.service
    [Unit]
    Description=Enterprise Monolithic Application Service
    After=network.target

    [Service]
    Type=simple
    User=root
    WorkingDirectory=/opt/monolith-app
    ExecStart=/usr/bin/node /opt/monolith-app/server.js
    Restart=always
    RestartSec=5

    [Install]
    WantedBy=multi-user.target
    SERVICE

    systemctl daemon-reload
    systemctl enable monolith.service
    systemctl start monolith.service
  EOF
  )

  tags = var.tags
}

# Grant VM's System-Assigned Managed Identity "Key Vault Secrets User" on Key Vault
resource "azurerm_role_assignment" "vm_kv_reader" {
  scope                = var.key_vault_id
  role_definition_name = "Key Vault Secrets User"
  principal_id         = azurerm_linux_virtual_machine.monolith.identity[0].principal_id
}
