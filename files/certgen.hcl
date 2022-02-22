path "auth/token/create" {
	capabilities = ["create", "update"]
}

path "sys/mounts" {
	capabilities = ["read"]
}

path "sys/mounts/pki_mesh_*" {
  capabilities = ["create", "read", "update", "delete", "list", "sudo"]
}


path "+/roles/+" {
  capabilities = ["create", "read", "update", "delete"]
}

path "+/intermediate/set-signed" {
	capabilities = ["create", "update", "delete", "sudo" ]
}

path "+/intermediate/generate/internal" {
	capabilities = ["create", "update"]
}

path "+/root/sign-intermediate" {
	capabilities = ["update"]
}

path "sys/policies/acl/issue_cert_*" {
  capabilities = ["create", "read", "update", "delete", "list", "sudo"]
}

path "auth/token/roles/issue_cert_*" {
	capabilities = ["create", "read", "update", "delete"]
}