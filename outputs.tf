output "ms_graph_id" {
	value = data.azuread_service_principal.this.application_id
}

output "group_member_read_all" {
	value = [
		for app_role in data.azuread_service_principal.this.app_roles: app_role.id if app_role.value == "GroupMember.Read.All"
	]
}