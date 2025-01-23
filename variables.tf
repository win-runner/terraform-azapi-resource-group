variable "name" {
  type        = string
  description = "The name of the resource group."
  nullable    = false
}

variable "location" {
  type        = string
  description = "The location of the resource group."
  nullable    = false
}

variable "tags" {
  type        = map(string)
  default     = null
  description = "The tags attached to the resource group."
}

variable "role_assignments" {
  type = map(object({
    principalId                        = string
    principalType                      = string
    condition                          = optional(string)
    conditionVersion                   = optional(string)
    delegatedManagedIdentityResourceId = optional(string)
    description                        = optional(string)
  }))
  default     = {}
  description = <<EOT
A map of role assignments to create. The key is the name of the role assignment.
 - `principalId` - The ID of the Principal (User, Group or Service Principal) to assign the Role Definition to.
 - `principalType` - The type of the principal_id. Possible values are User, Group and ServicePrincipal.
 - `condition` - The condition that limits the resources that the role can be assigned to.
 - `conditionVersion` - The condition that limits the resources that the role can be assigned to.
 - `delegatedManagedIdentityResourceId` - The delegated Azure Resource Id which contains a Managed Identity.
 - `description` - The description for this Role Assignment.
EOT
  nullable    = false
}

variable "lock" {
  type = map(object({
    level = string
    notes = optional(string)
  }))
  default     = {}
  description = <<EOT
A map of locks to create. The key is the name of the lock.
 - `level` - Specifies the Level to be used for this Lock. Possible values are CanNotDelete and ReadOnly.
 - `notes` - Specifies some notes about the lock. Maximum of 512 characters.
EOT
  nullable    = false
}

variable "subscription_id" {
  type        = string
  description = "The subscription ID to query for role definitions."
}
