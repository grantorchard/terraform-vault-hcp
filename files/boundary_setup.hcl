# Create configuration for boundary connection
path "rds_postgres/config/boundary" {
  capabilities = ["create", "read", "update", "delete"]
}

# Create role for boundary
path "rds_postgres/roles/boundary" {
	capabilities = ["create", "read", "update", "delete"]
}

# Rotate the root password
path "rds_postgres/rotate-root/boundary" {
	capabilities = ["create"]
}

# Generate child token
path "auth/token/create" {
	capabilities = ["create", "update"]
}