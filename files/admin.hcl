# Manage auth backends broadly across Vault
path "auth" {
  capabilities = ["list"]
}

path "auth/*" {
  capabilities = ["create", "read", "update", "delete", "list", "sudo"]
}

# List, create, update, and delete auth backends
path "sys/auth" {
  capabilities = ["list","read"]
}

path "sys/auth/*" {
  capabilities = ["create", "read", "update", "delete", "sudo"]
}

path "identity/*" {
  capabilities = [ "create", "read", "update", "delete", "list" ]
}

# List existing policies
path "sys/policies" {
  capabilities = ["list", "read"]
}

# Create and manage ACL policies broadly across Vault
path "sys/policies/*" {
  capabilities = ["create", "read", "update", "delete", "list", "sudo"]
}

# Manage and manage secret backends broadly across Vault.
path "sys/mounts/*" {
  capabilities = ["create", "read", "update", "delete", "list", "sudo"]
}

path "sys/mounts" {
  capabilities = ["read", "list"]
}

path "sys/replication" {
	capabilities = ["create", "read", "update", "delete", "list", "sudo"]
}

# Read health checks
path "sys/health" {
  capabilities = ["read", "sudo"]
}

# Manage transit engine
path "transit/*" {
	capabilities = ["read", "update"]
}

path "nomad_intermediate_ca" {
	capabilities = ["list"]
}

path "nomad_intermediate_ca/*" {
	capabilities = ["create", "read", "update", "delete", "list", "sudo"]
}

path "pki_root_ca/*" {
	capabilities = ["create", "read", "update", "delete", "list", "sudo"]
}

path "pki_root_ca" {
	capabilities = ["read","list"]
}

path "intermediate_ca/*" {
	capabilities = ["create", "read", "update", "delete", "list", "sudo"]
}

path "intermediate_ca" {
	capabilities = ["read","list"]
}

path "go_local/*" {
	capabilities = ["create", "read", "update", "delete", "list", "sudo"]
}

path "go_local" {
	capabilities = ["read","list"]
}

path "approle/*" {
	capabilities = ["create", "read", "update", "delete", "list", "sudo"]
}

path "approle" {
	capabilities = ["read","list"]
}

path "auth/token/create/nomad" {
  capabilities = ["update", "sudo"]
}

path "aws/*" {
	capabilities = ["create", "read", "update", "delete", "list", "sudo"]
}

path "rds_postgres/*" {
	capabilities = ["create", "read", "update", "delete", "list", "sudo"]
}

path "tfc/*" {
	capabilities = ["create", "read", "update", "delete", "list", "sudo"]
}

path "tfc" {
	capabilities = ["create", "read", "update", "delete", "list", "sudo"]
}

path "jwt/*" {
	capabilities = ["create", "read", "update", "delete", "list", "sudo"]
}

path "secrets*" {
	capabilities = ["create", "read", "update", "delete", "list", "sudo"]
}

path "consul*" {
	capabilities = ["create", "read", "update", "delete", "list", "sudo"]
}

path "ssh-github*" {
	capabilities = ["create", "read", "update", "delete", "list", "sudo"]
}

path "auth/aws/identity-accesslist/*" {
	capabilities = ["delete"]
}

path "pki_mesh_blue/roles/*" {
  capabilities = ["create", "read", "update", "delete", "list", "sudo"]
}

path "+/roles/+" {
  capabilities = ["create", "read", "update", "delete", "list", "sudo"]
}

path "+/intermediate/set-signed" {
	capabilities = ["create", "update", "delete", "sudo" ]
}

path "mesh_intermediate_ca/roles/*" {
	capabilities = ["create", "update", "delete", "read" ]
}

path "+/intermediate/generate/internal" {
	capabilities = ["create", "update"]
}

path "+/root/sign-intermediate" {
	capabilities = ["create"]
}

path "yellow/issue/yellow" {
	capabilities = ["read","update"]
}

path "totp*" {
	capabilities = ["create", "read", "update", "delete", "list", "sudo"]
}