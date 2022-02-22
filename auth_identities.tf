data "azuread_group" "vault_admins" {
	display_name = "vault_admins_go"
}


resource "vault_identity_group" "vault_admins" {
	name = "vault admins"
	type = "external"
	policies = [ "admin" ]
}

resource "vault_identity_group_alias" "vault_admins" {
  name           = data.azuread_group.vault_admins.id
  mount_accessor = module.oidc.mount_accessor
  canonical_id   = vault_identity_group.vault_admins.id
}