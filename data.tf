data "azapi_resource_list" "role_definition" {
  for_each = var.role_assignments

  type      = "Microsoft.Authorization/roleDefinitions@2022-05-01-preview"
  parent_id = "/subscriptions/${var.subscription_id}"
  query_parameters = {
    "$filter" = ["roleName eq '${each.key}'"]
  }
  response_export_values = {
    "values" = "value[].{id: id}"
  }
}
