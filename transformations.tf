locals {
  role_definition_map = {
    for role_name, role_definition in data.azapi_resource_list.role_definition : role_name => one(role_definition.output.values).id
  }
}
