variable vault_url {
  type    = string
}

variable "tfc_org_token" {
	type = string
}

variable "tfc_teams" {
	type = list(string)
}

variable "consul_prefixes" {
	type = list(string)
}