resource "vault_mount" "transit" {
  path                      = "transit"
  type                      = "transit"
  description               = "Example description"
  default_lease_ttl_seconds = 3600
  max_lease_ttl_seconds     = 86400
}

resource "vault_transit_secret_backend_key" "boundary_root" {
  backend = vault_mount.transit.path
  name    = "boundary_root"
}

resource "vault_transit_secret_backend_key" "boundary_worker_auth" {
  backend = vault_mount.transit.path
  name    = "boundary_worker_auth"
}

resource "vault_transit_secret_backend_key" "boundary_recovery" {
  backend = vault_mount.transit.path
  name    = "boundary_recovery"
}