terraform {
  backend "azurerm" {
    resource_group_name  = "storage-we-ent-01"
    storage_account_name = "tfstateu9yle"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
}

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.76.0"
    }
  }
}

provider "azurerm" {
  features {}
}
