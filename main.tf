resource "azapi_resource" "resource_group" {
  type     = "Microsoft.Resources/resourceGroups@2024-07-01"
  body     = {}
  location = var.location
  name     = var.name
  tags     = var.tags
}

resource "azapi_resource" "resource_lock" {
  for_each = var.lock

  type = "Microsoft.Authorization/locks@2020-05-01"
  body = {
    properties = {
      level = each.value.level
      notes = each.value.notes
    }
  }

  name      = "lock-${each.value.level}"
  parent_id = azapi_resource.resource_group.id
}

resource "azapi_resource" "role_assignments" {
  for_each = var.role_assignments

  type = "Microsoft.Authorization/roleAssignments@2022-04-01"
  body = {
    properties = {
      principalId                        = each.value.principalId
      roleDefinitionId                   = local.role_definition_map[each.key]
      condition                          = each.value.condition
      conditionVersion                   = each.value.conditionVersion
      delegatedManagedIdentityResourceId = each.value.delegatedManagedIdentityResourceId
      description                        = each.value.description
      principalType                      = each.value.principalType
    }
  }

  # Azure requires that the “name” property is a valid GUID.
  # The UUID is used here to generate a unique and stable ID (GUID) for the role assignment. 
  name      = uuidv5("931E759C-F29C-42D6-AD89-9135E8A452BC", "${each.key}-${each.value.principalId}")
  parent_id = azapi_resource.resource_group.id
}
