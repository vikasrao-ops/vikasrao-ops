package azure.governance.tags_test

import future.keywords.in
import data.azure.governance.tags.deny

test_deny_unlabeled_resource {
    mock_input := {
        "resource_changes": [
            {
                "address": "azurerm_resource_group.rg",
                "type": "azurerm_resource_group",
                "change": {
                    "actions": ["create"],
                    "after": {}
                }
            }
        ]
    }
    count(deny) > 0 with input as mock_input
}

test_allow_compliant_resource {
    mock_input := {
        "resource_changes": [
            {
                "address": "azurerm_resource_group.rg",
                "type": "azurerm_resource_group",
                "change": {
                    "actions": ["create"],
                    "after": {
                        "tags": {
                            "Environment": "prod",
                            "Owner": "vikas.rao",
                            "Project": "azure-governance",
                            "CostCenter": "GOV-100",
                            "ManagedBy": "Terraform"
                        }
                    }
                }
            }
        ]
    }
    count(deny) == 0 with input as mock_input
}
