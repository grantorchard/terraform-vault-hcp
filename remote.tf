data "terraform_remote_state" "this" {
  backend = "remote"

  config = {
    organization = "grantorchard"
    workspaces = {
      name = "aws-core"
    }
  }
}
