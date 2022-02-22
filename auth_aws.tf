

provider "aws" {
  # default_tags { # adjust your required tags as necessary
  #   tags = {
  #     delete-after = "2021-10-01"
  #     owner = "go@hashicorp.com"
  #   }
  # }
}

locals {
  name     = "vault-demo-hcp-go"
  my_email = "go@hashicorp.com"  # this _must_ match the doormat identity
	vpc_id = data.terraform_remote_state.this.outputs.vpc_id
}

data "aws_iam_policy" "permissions_boundary" {
  name = "VaultDemoPermissionsBoundary"
}

resource "aws_iam_user" "user" {
  name = local.name
  tags = { vault-demo : local.my_email }  # this is required

  permissions_boundary = data.aws_iam_policy.permissions_boundary.arn
}
resource "aws_iam_user_policy" "user" {
  name   = "AWSEC2VaultAuth"
  user   = aws_iam_user.user.name
  policy = data.aws_iam_policy_document.user.json
}
data "aws_iam_policy_document" "user" {
  statement {
    actions   = ["ec2:DescribeInstances", "iam:GetInstanceProfile"]
    resources = ["*"]
  }
}

resource "aws_iam_access_key" "this" {
  user    = aws_iam_user.user.name
}

resource "vault_auth_backend" "aws" {
	type = "aws"
	path = "aws"
}

resource "vault_aws_auth_backend_client" "this" {
	backend = vault_auth_backend.aws.path
	access_key = aws_iam_access_key.this.id
	secret_key = aws_iam_access_key.this.secret
}

resource "vault_aws_auth_backend_role" "this" {
	role = "boundary"
	auth_type = "ec2"
	bound_vpc_ids = [
		local.vpc_id
	]
	token_policies = [
		"boundary"
	]
}