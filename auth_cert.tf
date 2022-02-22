# resource "vault_auth_backend" "cert" {
#   type = "cert"
# 	path = "cert"

#   tune {
#     max_lease_ttl      = "90000s"
#   }
# }

# resource "vault_cert_auth_backend_role" "nomad" {
#     name           = "nomad"
#     certificate    = vault_pki_secret_backend_root_sign_intermediate.intermediate_ca.certificate
#     backend        = vault_auth_backend.cert.path
#     token_ttl      = 24
#     token_max_ttl  = 720
#     token_policies = ["nomad"]
# }