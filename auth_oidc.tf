provider "azurerm" {
  features {}
}

data "azuread_service_principal" "this" {
  display_name = "Microsoft Graph"
}

data azurerm_subscription "this" {}

# resource random_password "this" {
#   length  = 32
#   special = false
# }

resource azuread_application_password "this" {
  application_object_id = azuread_application.this.id
  #value                 = random_password.this.result
  end_date              = timeadd(timestamp(), "8766h")
  lifecycle {
    ignore_changes = [end_date]
  }
}

module "oidc" {
  source = "github.com/grantorchard/terraform-vault-module-oidc"

  azure_tenant_id    = data.azurerm_subscription.this.tenant_id
  oidc_client_id     = azuread_application.this.application_id
  oidc_client_secret = azuread_application_password.this.value
  web_redirect_uris = [
    "http://localhost:8250/oidc/callback",
    "${var.vault_url}/ui/vault/auth/oidc/oidc/callback",
		"http://127.0.0.1:8200/ui/vault/auth/oidc/oidc/callback"
  ]
  default_role = "default"
  token_policies = [
    "admin"
  ]
}

resource azuread_application "this" {
  display_name = "vault-oidc"
	web {
		redirect_uris = [
			"http://localhost:8250/oidc/callback",
			"${var.vault_url}/ui/vault/auth/oidc/oidc/callback",
  	]
	}

	api {
		oauth2_permission_scope {
			admin_consent_description = "Allow the application to access vault-oidc on behalf of the signed-in user."
			admin_consent_display_name = "Access vault-oidc"
			id = "58a3993f-401e-4360-984c-fccd753a82ae"
			user_consent_description = "Allow the application to access vault-oidc on your behalf."
			user_consent_display_name = "Access vault-oidc"
			value = "user_impersonation"
		}
	}
  
  required_resource_access {
    # Add MS Graph Group.Read.All API permissions
    resource_app_id = "00000003-0000-0000-c000-000000000000"
    resource_access {
      id   = "5b567255-7703-4780-807c-7be8301ae99b"
      type = "Scope"
    }
  }

	group_membership_claims = [ "SecurityGroup" ]
  #available_to_other_tenants = false
  #oauth2_allow_implicit_flow = true
  #type                       = "webapp/api"
}


# resource "azuread_application_app_role" "foo_admin" {
#   application_object_id = azuread_application.this.id
#   allowed_member_types  = ["User"]
#   description           = "Gives admin access to Terraform foo workspace"
#   display_name          = "Foo Admin"
#   is_enabled            = true
#   value                 = "foo_admin"
# }

# data "azuread_application" "tfc_auth" {
# 	display_name = "GO Terraform Cloud"
# }

# resource "azuread_application_app_role" "foo-admin" {
#   application_object_id = data.azuread_application.tfc_auth.id
#   allowed_member_types  = ["User"]
#   description           = "Gives admin access to Terraform foo workspace"
#   display_name          = "Foo Admin"
#   is_enabled            = true
#   value                 = "foo_admin"
# }

# resource "azuread_application_app_role" "foo_read_only" {
#   application_object_id = data.azuread_application.tfc_auth.id
#   allowed_member_types  = ["User"]
#   description           = "Gives admin access to Terraform foo workspace"
#   display_name          = "Foo Read-Only"
#   is_enabled            = true
#   value                 = "foo_read_only"
# }

# resource tfe_team "this" {
#   for_each = var.permissions
#   name         = azuread_group.users[each.key].object_id
#   organization = var.tfe_org_name
# }

# resource tfe_team_access "foo_admin" {
#   team_id      = tfe_team.read_only.id
#   workspace_id = tfe_workspace.this.id
#   permissions {
#     runs = "read"
#     variables = "none"
#     state_versions = "read-outputs"
#     sentinel_mocks = "none"
#     workspace_locking = "false"
#   }
# }

# data "azuread_users" "foo_admin" {
#   mail_nicknames = ["grant@hashicorp.com", "cam@hashicorp.com"]
# }

# resource "azuread_group" "foo_admin" {
#   display_name = "foo_admin"
# 	members = data.azuread_users.foo_admin.object_ids
# }