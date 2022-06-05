// Notes
# I make use of the Microsoft Graph service principal in the AzureAD auth method, which
# can be found in the auth_oidc.tf file. Same for the azurerm_subcription data source.

resource "azuread_application" "aad_secrets" {
	display_name = "Vault Secrets Engine"
	group_membership_claims = []
	api {}

	required_resource_access {
    resource_app_id = data.azuread_service_principal.this.application_id
    dynamic "resource_access" {
      for_each = toset(var.app_resource_permissions)
      content {
        type = "Role" # This is type "Application" in the Azure UI
				id   = data.azuread_service_principal.this.app_role_ids[resource_access.value]
      }
    }
		dynamic "resource_access" {
      for_each = toset(var.delegated_resource_permissions)
      content {
        type = "Scope" # This is type "Delegated" in the Azure UI
        id   = data.azuread_service_principal.this.oauth2_permission_scope_ids[resource_access.value]
      }
    }
  }
}

# This handles the admin consent for the application permissions
resource "azuread_app_role_assignment" "application" {
	for_each = toset(var.app_resource_permissions)
	app_role_id = data.azuread_service_principal.this.app_role_ids[each.value]
	principal_object_id = azuread_service_principal.aad_secrets.object_id
	resource_object_id = data.azuread_service_principal.this.object_id
}

# This handles the admin consent for the delegated user permissions
resource "azuread_service_principal_delegated_permission_grant" "aad_secrets" {
  service_principal_object_id          = azuread_service_principal.aad_secrets.object_id
  resource_service_principal_object_id = data.azuread_service_principal.this.object_id
  claim_values                         = var.delegated_resource_permissions
}

resource "azuread_service_principal" "aad_secrets" {
  application_id = azuread_application.aad_secrets.application_id
}

# Since the password expires, we put in a "keeper"
resource "time_rotating" "aad_secrets" {
  rotation_days = 90
}

# Update the password when a new time_rotating resource is created
resource "azuread_application_password" "aad_secrets" {
  application_object_id = azuread_application.aad_secrets.object_id
  rotate_when_changed = {
    rotation = time_rotating.aad_secrets.id
  }
}

# Assign the Owner role to the subscription
resource "azurerm_role_assignment" "aad_secrets" {
  scope              = data.azurerm_subscription.this.id
  role_definition_name = "Owner"
  principal_id       = azuread_service_principal.aad_secrets.id
}

resource "vault_azure_secret_backend" "azure" {
  use_microsoft_graph_api = true
  subscription_id         = data.azurerm_subscription.this.subscription_id
  tenant_id               = data.azurerm_subscription.this.tenant_id
  client_id               = azuread_application.aad_secrets.application_id
  client_secret           = azuread_application_password.aad_secrets.value
  environment             = "AzurePublicCloud"
}

resource "azurerm_resource_group" "this" {
	location = "australiaeast"
	name = "vault_stuff"
}

resource "vault_azure_secret_backend_role" "manage_groups" {
  backend                     = "azure"
  role                        = "manage_groups"
  ttl                         = 300
  max_ttl                     = 600

  azure_roles {
    role_name = "User Access Administrator"
    scope =  azurerm_resource_group.this.id
  }
}
