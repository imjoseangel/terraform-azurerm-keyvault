# terraform-azurerm-keyvault

## Deploys a Azure Key Vault. Monitoring support can be added through Azure Log Analytics

[![Terraform](https://github.com/visma-raet/terraform-azurerm-keyvault/actions/workflows/terraform.yml/badge.svg)](https://github.com/visma-raet/terraform-azurerm-keyvault/actions/workflows/terraform.yml)

This Terraform module deploys a Key Vault on Azure

### NOTES

* Name Convention specified as `kv<string><randomstring>. <randomstring>` is calculated with `random_string` resource.

## Usage in Terraform 0.15

```terraform
data "azurerm_client_config" "current" {}

module "keyvault" {
  source = "https://github.com/visma-raet/terraform-azurerm-keyvault.git"

  name                  = var.tf_name
  resource_group_name   = var.terraform_rsg
  location              = var.location
  create_resource_group = true

  access_policies = [
    {
      object_id               = data.azurerm_client_config.current.object_id
      secret_permissions      = ["get", "list", "set", "delete", "purge", "restore"]
      storage_permissions     = []
      key_permissions         = []
      certificate_permissions = []
    }
  ]
}
```

## Authors

Originally created by [Visma-raet](http://github.com/visma-raet)

## License

[MIT](LICENSE)
