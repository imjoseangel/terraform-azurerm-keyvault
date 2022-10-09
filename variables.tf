variable "name" {
  description = "Name of key vault account."
  type        = string
}

variable "create_resource_group" {
  description = "Whether to create resource group and use it for all networking resources"
  type        = bool
  default     = false
}

variable "resource_group_name" {
  description = "A container that holds related resources for an Azure solution"
  type        = string
  default     = "rg-demo-westeurope-01"
}

variable "location" {
  description = "The location/region to keep all your network resources. To get the list of all locations with table format from azure cli, run 'az account list-locations -o table'"
  type        = string
  default     = "westeurope"
}

variable "skuname" {
  description = "The SKUs supported by Microsoft Key Vault. Valid options are premium, standard"
  type        = string
  default     = "standard"
}

variable "enabled_for_deployment" {
  description = "Boolean flag to specify whether Azure Virtual Machines are permitted to retrieve certificates stored as secrets from the key vault. Defaults to `false`."
  type        = bool
  default     = false
}

variable "enabled_for_disk_encryption" {
  description = "Boolean flag to specify whether Azure Disk Encryption is permitted to retrieve secrets from the vault and unwrap keys. Defaults to `false`."
  type        = bool
  default     = false
}

variable "enabled_for_template_deployment" {
  description = "Boolean flag to specify whether Azure Resource Manager is permitted to retrieve secrets from the key vault. Defaults to `false`."
  type        = bool
  default     = false
}

variable "soft_delete_retention_days" {
  description = "The number of days that items should be retained for once soft-deleted."
  type        = number
  default     = 7
}


variable "purge_protection_enabled" {
  description = "(Optional) Is Purge Protection enabled for this Key Vault?."
  type        = bool
  default     = false
}

variable "access_policies" {
  description = "Map of access policies for an object_id (user, service principal, security group) to backend."
  type = list(object({
    object_id               = string,
    certificate_permissions = list(string),
    key_permissions         = list(string),
    secret_permissions      = list(string),
    storage_permissions     = list(string),
  }))
  default = []
}

variable "network_acls" {
  description = "Network rules to apply to key vault."
  type = object({
    bypass                     = string,
    default_action             = string,
    ip_rules                   = list(string),
    virtual_network_subnet_ids = list(string),
  })
  default = null
}

variable "logging_enabled" {
  description = "Manages a Diagnostic Setting for the Key Vault"
  type        = bool
  default     = false
}

variable "log_analytics_workspace_name" {
  description = "(Optional) The name of the Analytics workspace"
  type        = string
  default     = null
}

variable "log_analytics_resource_group" {
  description = "The resource group of the Analytics workspace"
  type        = string
  default     = null
}

variable "tags" {
  description = "Tags to apply to all resources created."
  type        = map(string)
  default     = {}
}
