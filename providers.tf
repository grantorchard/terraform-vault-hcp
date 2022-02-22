terraform {
  required_providers {
    tfe = {
      source = "hashicorp/tfe"
      version = "0.26.1"
    }
		vault = {
      source = "hashicorp/vault"
      version = "2.24.1"
    }
  }
}