terraform {
  backend "azurerm" {
    resource_group_name   = "storage-we-ent-01"
    storage_account_name  = "tfstateu9yle"
<<<<<<< HEAD
    container_name        = "launchpad01"
=======
    container_name        = "tfstate"
>>>>>>> f501b9a (:()
    key                   = "terraform.tfstate"
  }
}

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
<<<<<<< HEAD
      version = "=2.48.0"
=======
      version = "=2.76.0"
>>>>>>> f501b9a (:()
    }
  }
}

<<<<<<< HEAD
# Configure the Microsoft Azure Provider
=======
>>>>>>> f501b9a (:()
provider "azurerm" {
  features {}
}
