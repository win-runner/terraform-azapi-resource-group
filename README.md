<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.6 |
| <a name="requirement_azapi"></a> [azapi](#requirement\_azapi) | 2.2.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azapi"></a> [azapi](#provider\_azapi) | 2.2.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | The name of the resource group. | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | The location of the resource group. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | The tags attached to the resource group. | `map(string)` | `null` | no |
| <a name="input_role_assignments"></a> [role\_assignments](#input\_role\_assignments) | A map of role assignments to create. The key is the name of the role assignment.<br/> - `principalId` - The ID of the Principal (User, Group or Service Principal) to assign the Role Definition to.<br/> - `principalType` - The type of the principal\_id. Possible values are User, Group and ServicePrincipal.<br/> - `condition` - The condition that limits the resources that the role can be assigned to.<br/> - `conditionVersion` - The condition that limits the resources that the role can be assigned to.<br/> - `delegatedManagedIdentityResourceId` - The delegated Azure Resource Id which contains a Managed Identity.<br/> - `description` - The description for this Role Assignment. | <pre>map(object({<br/>    principalId                        = string<br/>    principalType                      = string<br/>    condition                          = optional(string)<br/>    conditionVersion                   = optional(string)<br/>    delegatedManagedIdentityResourceId = optional(string)<br/>    description                        = optional(string)<br/>  }))</pre> | `{}` | no |
| <a name="input_lock"></a> [lock](#input\_lock) | A map of locks to create. The key is the name of the lock.<br/> - `level` - Specifies the Level to be used for this Lock. Possible values are CanNotDelete and ReadOnly.<br/> - `notes` - Specifies some notes about the lock. Maximum of 512 characters. | <pre>map(object({<br/>    level = string<br/>    notes = optional(string)<br/>  }))</pre> | `{}` | no |
| <a name="input_subscription_id"></a> [subscription\_id](#input\_subscription\_id) | The subscription ID to query for role definitions. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_resource_group_name"></a> [resource\_group\_name](#output\_resource\_group\_name) | The name of the resource group. |
| <a name="output_resource_group"></a> [resource\_group](#output\_resource\_group) | This is the full output for the resource group. |
| <a name="output_resource_group_id"></a> [resource\_group\_id](#output\_resource\_group\_id) | The ID of the resource group. |
| <a name="output_role_definitions"></a> [role\_definitions](#output\_role\_definitions) | The role definitions for the resource group. |
<!-- END_TF_DOCS -->

## Examples

```go
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
```

## Using UUIDs for Role Assignments

Azure requires the name property of Role Assignments to be a valid GUID (Globally Unique Identifier).\
To meet this requirement and avoid conflicts with multiple role assignments, a UUID (v5) is generated dynamically.

### How is the UUID generated?

The UUID is generated using Terraform's [uuidv5() function](https://developer.hashicorp.com/terraform/language/functions/uuidv5). This function creates a deterministic UUID based on the following inputs:

1. **Namespace:** A static, predefined UUID (e.g., e3b0c442-98fc-1c14-9afc-c24b00b8d9a7) specific to this project.\
2. **Name:** A combination of the role name (key) and the Principal ID (principalId).

**Example:**

```go
uuidv5("e3b0c442-98fc-1c14-9afc-c24b00b8d9a7", "Reader-12345678-1234-1234-1234-123456789012")
```

### Why is a UUID used?

- **Uniqueness:** Each role assignment gets its own, distinct ID.
- **Determinism:** The same combination of namespace, role name, and principal ID will always produce the same UUID.
- **Compatibility:** Azure only accepts GUIDs as name values for Role Assignments.

### What is the UUID used for?

The generated UUID is used as the name value in Azure's Resource Manager (ARM) to uniquely identify the role assignment and avoid conflicts.

### Generate a UUID locally

You can also generate a UUID locally to use as a reference for the namespace or as an ID. Here are a few methods:

1. **Linux/macOS:** Use the following command in the terminal:

    ```bash
    uuidgen
    ```

2. **Windows:** Open PowerShell and run the following command:

    ```powershell
    [guid]::NewGuid()
    ```

3. **Online Tools:** Alternatively, you can generate UUIDs using websites such as\
[it-tools.tech](https://it-tools.tech/uuid-generator)
