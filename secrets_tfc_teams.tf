resource "vault_terraform_cloud_secret_backend" "this" {
	backend = "tfc"
	token   = var.tfc_org_token
}

data "tfe_team" "this" {
	for_each     = toset(var.tfc_teams)
	name         = each.value
	organization = "grantorchard"
}

resource "vault_terraform_cloud_secret_role" "this" {
	for_each = { for v in data.tfe_team.this: v.name => v }
	backend  = vault_terraform_cloud_secret_backend.this.backend
	name     = each.value.name
	team_id  = each.value.id
	ttl      = 300
	max_ttl  = 900
}

resource "vault_policy" "tfc" {
	for_each = { for v in vault_terraform_cloud_secret_role.this: v.name => v }
	name = each.value.name
	policy =<<EOH
path "${each.value.id}" {
	capabilities = ["read"]
}
EOH

}