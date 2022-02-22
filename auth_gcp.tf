# resource "google_project_iam_custom_role" "this" {
#   role_id     = "nomadTagRead"
#   title       = "Nomad Compute Tag Read"
#   permissions = [
# 		"compute.instances.get",
# 		"compute.instanceGroups.list"
# 	]
# }

# resource "google_service_account" "vault" {
#   account_id   = random_string.vault.result
#   display_name = "vault"
# }

# resource "random_string" "vault" {
#   upper   = false
#   special = false
#   number  = false
#   length  = 16
# }

# resource "vault_auth_backend" "gcp" {
#     path = "gcp"
#     type = "gcp"
# }

# resource "vault_gcp_auth_backend" "gcp" {
#     credentials  = file("~/go-gcp-demos-548678faf176.json")
# 		path = "gcp"
# }

# resource "vault_gcp_auth_backend_role" "gcp" {
#     backend                = vault_gcp_auth_backend.gcp.path
# 		role   								 = "nomad-server"
# 		type 									 = "gce"
#     bound_projects         = ["go-gcp-demos"]
# 		#bound_regions          = ["australia-southeast1"]
# 		#bound_instance_groups   = ["nomad-server-mgari82p"]
#     #bound_service_accounts = ["qylxjskthnkvpkmy@go-gcp-demos.iam.gserviceaccount.com"]
#     token_policies         = [ vault_policy.nomad.name ]
# }