resource "vault_mount" "github" {
    type = "ssh"
		path = "ssh-github"
}

resource "vault_ssh_secret_backend_ca" "github" {
    backend = vault_mount.github.path
		generate_signing_key = true
}

resource "vault_ssh_secret_backend_role" "github" {
	backend = vault_mount.github.path
	name = "short_ttl"
	allow_user_certificates = true
  allowed_users = "grantorchard"
  allowed_extensions = "login@github.com"
  key_type = "ca"
  ttl = "300"
  max_ttl = "300"
}

# resource "vault_policy" "ssh_github" {
# 	name = "ssh_github"
# 	policy =<<EOH
# path "/sign/${vault_ssh_secret_backend_role.github.}" {
# 	capabilities = ["read"]
# }
# EOH

# }
# }