module "resource_group_storage" {
  source = "../"

  name            = "rg-azapi-storage"
  location        = "swedencentral"
  subscription_id = "00000000-0000-0000-0000-000000000000"

  role_assignments = {
    Contributor = {
      principalId   = "12345678-1234-1234-1234-123456789012"
      principalType = "User"
    }

    "Storage Blob Data Contributor" = {
      principalId   = "12345678-1234-1234-1234-123456789012"
      principalType = "User"
    }
  }
}
