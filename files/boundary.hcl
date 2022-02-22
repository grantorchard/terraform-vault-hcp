path "transit/encrypt/boundary_root" {
  capabilities = ["update"]
}

path "transit/decrypt/boundary_root" {
  capabilities = ["update"]
}

path "transit/encrypt/boundary_worker_auth" {
  capabilities = ["update"]
}

path "transit/decrypt/boundary_worker_auth" {
  capabilities = ["update"]
}


path "transit/encrypt/boundary_recovery" {
  capabilities = ["update"]
}

path "transit/decrypt/boundary_recovery" {
  capabilities = ["update"]
}

# Allow our own token to be renewed.
path "auth/token/renew-self" {
  capabilities = ["update"]
}

# Generate/update a certificate for listeners
path "intermediate_ca/issue/boundary" {
  capabilities = ["update"]
}

path "yellow/issue/yellow" {
	capabilities = ["read","update"]
}