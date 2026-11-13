resource "azurerm_public_ip" "appgw" {
  name                = "pip-appgw-${var.project_name}-${var.environment}"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
  tags                = var.tags
}

resource "azurerm_web_application_firewall_policy" "waf" {
  name                = "wafpolicy-${var.project_name}-${var.environment}"
  resource_group_name = var.resource_group_name
  location            = var.location

  policy_settings {
    enabled                     = true
    mode                        = "Prevention"
    request_body_check          = true
    max_request_body_size_in_kb = 128
    file_upload_limit_in_mb     = 100
  }

  managed_rules {
    managed_rule_set {
      type    = "OWASP"
      version = "3.2"
    }
  }

  tags = var.tags
}

resource "azurerm_application_gateway" "appgw" {
  name                = "appgw-${var.project_name}-${var.environment}"
  resource_group_name = var.resource_group_name
  location            = var.location
  firewall_policy_id  = azurerm_web_application_firewall_policy.waf.id

  sku {
    name     = "WAF_v2"
    tier     = "WAF_v2"
    capacity = 2
  }

  gateway_ip_configuration {
    name      = "appgw-ip-config"
    subnet_id = var.appgw_subnet_id
  }

  frontend_port {
    name = "port-http"
    port = 80
  }

  frontend_ip_configuration {
    name                 = "frontend-ip"
    public_ip_address_id = azurerm_public_ip.appgw.id
  }

  backend_address_pool {
    name = "backend-pool-default"
  }

  backend_http_settings {
    name                  = "backend-http-settings"
    cookie_based_affinity = "Disabled"
    port                  = 8080
    protocol              = "Http"
    request_timeout       = 30
  }

  http_listener {
    name                           = "http-listener"
    frontend_ip_configuration_name = "frontend-ip"
    frontend_port_name             = "port-http"
    protocol                       = "Http"
  }

  request_routing_rule {
    name                       = "rule-http"
    rule_type                  = "Basic"
    http_listener_name         = "http-listener"
    backend_address_pool_name  = "backend-pool-default"
    backend_http_settings_name = "backend-http-settings"
    priority                   = 100
  }

  tags = var.tags
}
