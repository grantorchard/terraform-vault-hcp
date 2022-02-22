resource "vault_token_auth_backend_role" "nomad" {
  role_name              = "nomad"
  allowed_policies       = ["boundary"]
  disallowed_policies    = ["default"]
  orphan                 = true
  token_period           = "2592000"
  renewable              = true
  path_suffix            = "nomad"
}

resource "vault_token_auth_backend_role" "certgen" {
  role_name              = "certgen"
  allowed_policies       = [
		"certgen",
		#"manage_self"
	]
  disallowed_policies    = ["default"]
  orphan                 = true
  token_period           = "2592000"
  renewable              = true
  path_suffix            = "certgen"
}
