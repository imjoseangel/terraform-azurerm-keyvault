terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.62.0"
    }
    random = {
      source = "hashicorp/random"
    }
  }
  required_version = ">= 0.15"
}

provider "azurerm" {
  features {}
}
