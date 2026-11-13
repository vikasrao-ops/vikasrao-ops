package azure.governance.regions

import future.keywords.in

allowed_regions := ["eastus", "eastus2", "centralus", "westeurope"]

deny[msg] {
    some resource in input.resource_changes
    resource.change.actions[_] in ["create", "update"]
    
    location := lower(resource.change.after.location)
    not location in allowed_regions
    
    msg := sprintf("Policy Violation: Resource '%v' is in unapproved region '%v'. Allowed regions: %v", [resource.address, location, allowed_regions])
}
