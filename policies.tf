resource "vault_policy" "certgen" {
  name   = "certgen"
  policy = file("./files/certgen.hcl")
}

resource "vault_policy" "admin" {
  name   = "admin"
  policy = file("./files/admin.hcl")
}

resource "vault_policy" "boundary" {
  name   = "boundary"
  policy = file("./files/boundary.hcl")
}

# resource vault_policy "nomad" {
#   name   = "nomad"
#   policy = file("./files/nomad.hcl")
# }

resource "vault_policy" "unifi" {
	name = "unifi"
	policy = file("./files/unifi.hcl")
}

resource "vault_policy" "boundary_setup" {
	name = "boundary_setup"
	policy = file("./files/boundary_setup.hcl")
}

resource "vault_policy" "boundary_credential_store" {
	name = "boundary_credential_store"
	policy = file("./files/boundary_credential_store.hcl")
}

resource "vault_policy" "create_child_token" {
	name = "create_child_token"
	policy = file("./files/create_child_token.hcl")
}

resource "vault_policy" "manage_self" {
	name = "manage_self"
	policy = file("./files/manage_self.hcl")
}

resource "vault_policy" "kv_read" {
	name = "kv_read"
	policy = file("./files/kv_read.hcl")
}