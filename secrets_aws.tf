resource "vault_aws_secret_backend_role" "account_management" {
  backend = "aws"
	name = "account_management"
	credential_type = "assumed_role"
	role_arns = ["arn:aws:iam::495078824317:role/account_management"]
	default_sts_ttl = "1800"
}

# resource "vault_aws_secret_backend" "name" {
	
# }