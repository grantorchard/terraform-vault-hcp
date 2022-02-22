resource "vault_mount" "db" {
  path = "rds_postgres"
  type = "database"
}