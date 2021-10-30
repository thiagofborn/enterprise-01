terraform {
  backend "azurerm" {
    resource_group_name   = "storage-we-ent-01"
    storage_account_name  = "tfstateu9yle"
    container_name        = "launchpad01"
    key                   = "terraform.tfstate"
  }
}

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.48.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}
