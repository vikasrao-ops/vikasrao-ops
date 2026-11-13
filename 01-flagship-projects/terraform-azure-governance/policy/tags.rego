package azure.governance.tags

import future.keywords.in

required_tags := ["Environment", "Owner", "Project", "CostCenter", "ManagedBy"]

# Reject any resource missing required tags
deny[msg] {
    some resource in input.resource_changes
    resource.change.actions[_] in ["create", "update"]
    
    not resource.change.after.tags
    msg := sprintf("Policy Violation: Resource '%v' of type '%v' has no tags defined.", [resource.address, resource.type])
}

deny[msg] {
    some resource in input.resource_changes
    resource.change.actions[_] in ["create", "update"]
    resource.change.after.tags
    
    some tag in required_tags
    not resource.change.after.tags[tag]
    msg := sprintf("Policy Violation: Resource '%v' is missing mandatory tag '%v'. Required tags: %v", [resource.address, tag, required_tags])
}
