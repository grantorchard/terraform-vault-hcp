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
	verbose_oidc_logging = true
	#bound_subject = "repo:grantorchard/gha-vault-jwt"
  bound_audiences = ["sigstore"]
  bound_claims = {
    "repository" = "grantorchard/gha-vault-jwt"
		"ref"        = "refs/heads/main"
  }
  user_claim      = "actor"
  role_type       = "jwt"
}