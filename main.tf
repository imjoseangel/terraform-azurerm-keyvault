#-------------------------------
# Local Declarations
#-------------------------------
locals {
  resource_group_name = element(coalescelist(data.azurerm_resource_group.rgrp.*.name, azurerm_resource_group.rg.*.name, [""]), 0)
  location            = element(coalescelist(data.azurerm_resource_group.rgrp.*.location, azurerm_resource_group.rg.*.location, [""]), 0)
}

data "azurerm_client_config" "current" {}

#---------------------------------------------------------
# Resource Group Creation or selection - Default is "false"
#----------------------------------------------------------
data "azurerm_resource_group" "rgrp" {
  count = var.create_resource_group == false ? 1 : 0
  name  = var.resource_group_name
}

resource "azurerm_resource_group" "rg" {
  count    = var.create_resource_group ? 1 : 0
  name     = lower(var.resource_group_name)
  location = var.location
  tags     = merge({ "ResourceName" = format("%s", var.resource_group_name) }, var.tags, )
}


#---------------------------------------------------------
# Key-vault Creation or selection
#---------------------------------------------------------
resource "random_string" "unique" {
  length  = 10
  special = false
  upper   = false
}

resource "azurerm_key_vault" "main" {
  name                = format("kv%s%s", lower(replace(var.name, "/[[:^alnum:]]/", "")), random_string.unique.result)
  resource_group_name = local.resource_group_name
  location            = local.location
  tenant_id           = data.azurerm_client_config.current.tenant_id
  sku_name            = var.skuname

  enabled_for_deployment          = var.enabled_for_deployment
  enabled_for_disk_encryption     = var.enabled_for_disk_encryption
  enabled_for_template_deployment = var.enabled_for_template_deployment
  soft_delete_retention_days      = var.soft_delete_retention_days

  dynamic "network_acls" {
    for_each = var.network_acls != null ? [true] : []
    content {
      bypass                     = var.network_acls.bypass
      default_action             = var.network_acls.default_action
      ip_rules                   = var.network_acls.ip_rules
      virtual_network_subnet_ids = var.network_acls.virtual_network_subnet_ids
    }
  }

  tags = merge({ "ResourceName" = format("kv%s%s", lower(replace(var.name, "/[[:^alnum:]]/", "")), random_string.unique.result) }, var.tags, )
}

#---------------------------------------------------------
# Key-vault Access Policies
#---------------------------------------------------------

resource "azurerm_key_vault_access_policy" "main" {
  count        = length(var.access_policies)
  key_vault_id = azurerm_key_vault.main.id

  tenant_id = data.azurerm_client_config.current.tenant_id
  object_id = var.access_policies[count.index].object_id

  secret_permissions      = var.access_policies[count.index].secret_permissions
  key_permissions         = var.access_policies[count.index].key_permissions
  certificate_permissions = var.access_policies[count.index].certificate_permissions
  storage_permissions     = var.access_policies[count.index].storage_permissions
}
