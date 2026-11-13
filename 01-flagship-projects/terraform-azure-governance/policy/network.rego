package azure.governance.network

import future.keywords.in

# Prohibit public inbound 0.0.0.0/0 on SSH (22) and RDP (3389)
deny[msg] {
    some resource in input.resource_changes
    resource.type == "azurerm_network_security_rule"
    resource.change.actions[_] in ["create", "update"]
    
    rule := resource.change.after
    rule.direction == "Inbound"
    rule.access == "Allow"
    rule.source_address_prefix in ["*", "0.0.0.0/0", "Internet"]
    rule.destination_port_range in ["22", "3389", "*"]
    
    msg := sprintf("Security Violation: Inbound rule '%v' permits unrestricted public ingress on administrative port '%v'.", [resource.address, rule.destination_port_range])
}
