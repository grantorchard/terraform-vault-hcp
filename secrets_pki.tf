# PKI Engine to be used for Cert Auth.

# Enable the pki secret engine
resource "vault_mount" "pki_root_ca" {
	type = "pki"
	path = "pki_root_ca"
}

# Create a root CA for the secret engine

resource "vault_pki_secret_backend_root_cert" "this" {
  backend = vault_mount.pki_root_ca.path

  type = "exported"
  common_name = "fcto.internal"
  ttl = 315360000
  key_type = "rsa"
  key_bits = 4096
  exclude_cn_from_sans = true
  ou = "FCTO"
  organization = "HashiCorp"
}


resource "vault_mount" "mesh_intermediate_ca" {
	type = "pki"
	path = "mesh_intermediate_ca"
}

resource "vault_pki_secret_backend_intermediate_cert_request" "this" {
  backend = vault_mount.mesh_intermediate_ca.path
	type = "internal"
  common_name = "mesh.fcto.internal"
}

resource "vault_pki_secret_backend_root_sign_intermediate" "this" {
	backend = vault_mount.pki_root_ca.path

  csr = vault_pki_secret_backend_intermediate_cert_request.this.csr
  common_name = "mesh.fcto.internal"
  exclude_cn_from_sans = true
  ou = "FCTO"
  organization = "HashiCorp"
	ttl = 525600
}

resource "vault_pki_secret_backend_intermediate_set_signed" "this" {
	backend = vault_mount.mesh_intermediate_ca.path
	certificate = vault_pki_secret_backend_root_sign_intermediate.this.certificate
}

resource "vault_pki_secret_backend_role" "this" {
  backend          = vault_mount.mesh_intermediate_ca.path
  name             = "mesh"
  ttl              = 3600
  allow_ip_sans    = true
  key_type         = "rsa"
  key_bits         = 4096
  #allowed_domains  = ["clustera.mesh.fcto.internal"]
  #allow_subdomains = true
}

module "yellow" {
  source = "github.com/grantorchard/terraform-vault-pki-intca"

  mesh_name          = "yellow"
  root_ca_mount_path = vault_mount.pki_root_ca.path
}

/*




resource "vault_mount" "this" {
	type = "pki"
	path = "this"
}

resource "vault_pki_secret_backend_config_ca" "this" {
  backend = vault_mount.this.path
  pem_bundle = "${vault_pki_secret_backend_intermediate_cert_request.this.private_key}\n${vault_pki_secret_backend_root_sign_intermediate.this.certificate}\n${vault_pki_secret_backend_root_sign_intermediate.this.issuing_ca}"
}

resource "vault_auth_backend" "cert_nomad" {
	type = "cert"
	path = "cert"
}

*/



# Intermediate CA for use with Consul Connect

# resource "vault_mount" "intermediate_ca" {
# 	type = "pki"
# 	path = "intermediate_ca"
# }

# resource "vault_pki_secret_backend_intermediate_cert_request" "intermediate_ca" {
#   backend = vault_mount.pki_root_ca.path

#   type = "exported"
#   common_name = "humblelab.com"
# }


# resource "vault_pki_secret_backend_root_sign_intermediate" "intermediate_ca" {
# 	depends_on = [vault_pki_secret_backend_root_cert.this]
# 	backend = vault_mount.pki_root_ca.path

#   csr = vault_pki_secret_backend_intermediate_cert_request.intermediate_ca.csr
#   common_name = "humblelab.com"
#   exclude_cn_from_sans = true
#   ou = "FCTO"
#   organization = "HashiCorp"
# 	ttl = 315360000
# }

# resource "vault_pki_secret_backend_config_ca" "intermediate_ca" {
#   backend = vault_mount.intermediate_ca.path
#   pem_bundle = "${vault_pki_secret_backend_intermediate_cert_request.intermediate_ca.private_key}\n${vault_pki_secret_backend_root_sign_intermediate.intermediate_ca.certificate}\n${vault_pki_secret_backend_root_sign_intermediate.intermediate_ca.issuing_ca}"
# }

# resource "vault_pki_secret_backend_role" "boundary" {
#   backend         = vault_mount.intermediate_ca.path
#   name            = "boundary"
# 	ttl             = 86400
# 	allowed_domains = ["humblelab.com","service.consul"]
# 	allow_ip_sans   = true
# 	allow_any_name  = true
# 	enforce_hostnames = false
# 	key_usage = [
#     "DigitalSignature",
#     "KeyAgreement",
#     "KeyEncipherment"
# 	]
# 	ext_key_usage = [
# 		"ClientAuth"
# 	]
# }




# resource "vault_pki_secret_backend_root_sign_intermediate" "go_local" {
# 	depends_on = [vault_pki_secret_backend_root_cert.this]
# 	backend = vault_mount.pki_root_ca.path

#   csr = vault_pki_secret_backend_intermediate_cert_request.go_local.csr
#   common_name = "go.local"
#   exclude_cn_from_sans = true
#   ou = "FCTO"
#   organization = "HashiCorp"
# 	ttl = 315360000
# }

# resource "vault_pki_secret_backend_config_ca" "go_local" {
#   backend = vault_mount.go_local.path
#   pem_bundle = "${vault_pki_secret_backend_intermediate_cert_request.go_local.private_key}\n${vault_pki_secret_backend_root_sign_intermediate.go_local.certificate}\n${vault_pki_secret_backend_root_sign_intermediate.go_local.issuing_ca}"
# }
