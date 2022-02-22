# Generate/update a certificate for listeners
path "go_local/issue/unifi" {
  capabilities = ["update"]
}

path "auth/token/renew-self" {
  capabilities = ["update"]
}