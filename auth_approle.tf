resource "vault_auth_backend" "approle" {
  type = "approle"
}

resource "vault_approle_auth_backend_role" "this" {
  backend        = vault_auth_backend.approle.path
  role_name      = "boundary_setup"
  token_policies = ["boundary_setup"]
}