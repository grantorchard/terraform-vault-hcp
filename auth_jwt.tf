resource "vault_jwt_auth_backend" "this" {
  path = "gha"
	oidc_discovery_url = "https://token.actions.githubusercontent.com"
	bound_issuer       = "https://token.actions.githubusercontent.com"
}

resource "vault_jwt_auth_backend_role" "example" {
  backend         = vault_jwt_auth_backend.this.path
  role_name       = "gha-vault-jwt"
  token_policies  = [
		"default",
		"kv_read"
	]

  bound_audiences = ["sigstore"]
  bound_claims = {
    "repository" = "grantorchard/gha-vault-jwt"
  }
  user_claim      = "actor"
  role_type       = "jwt"
}