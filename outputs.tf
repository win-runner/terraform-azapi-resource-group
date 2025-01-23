output "resource_group_name" {
  description = "The name of the resource group."
  value       = azapi_resource.resource_group.name
}

output "resource_group" {
  description = "This is the full output for the resource group."
  value       = azapi_resource.resource_group
}

output "resource_group_id" {
  description = "The ID of the resource group."
  value       = azapi_resource.resource_group.id
}

output "role_definitions" {
  description = "The role definitions for the resource group."
  value       = local.role_definition_map
}
