# Data source to fetch built-in policy definition for Allowed Locations
data "azurerm_policy_definition" "allowed_locations" {
  display_name = "Allowed locations"
}

# Assign Allowed Locations Policy to Resource Group Scope
resource "azurerm_resource_group_policy_assignment" "allowed_locations" {
  name                 = "audit-allowed-locations"
  resource_group_id    = var.resource_group_id
  policy_definition_id = data.azurerm_policy_definition.allowed_locations.id
  display_name         = "Enforce Approved Azure Regions"
  description          = "Restricts resource deployments strictly to authorized enterprise regions."

  parameters = jsonencode({
    "listOfAllowedLocations" = {
      "value" = var.allowed_locations
    }
  })
}

