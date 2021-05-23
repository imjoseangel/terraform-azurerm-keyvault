# terraform-azurerm-keyvault

## Deploys an Azure Key Vault

This Terraform module deploys a Key Vault on Azure

### NOTES

* Pending

## Usage in Terraform 0.15

```terraform
data "azurerm_client_config" "current" {}

module "keyvault" {
  source = "git@ssh.dev.azure.com:v3/raet/IT%20Operations/terraform-azurerm-keyvault"

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
