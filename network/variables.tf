variable "resource_group_name" {
    description = "The name of the resource group"
}

variable "location" {
    description = "The name of the location for the Azure resources"
    default = "westeurope"
}

variable "storage_account_name" {
    description = "The storage account name to keep the tfstate"  
}

variable "storage_account_container_name" {
    description = "The name of the container where the tfstate will be saved"
  
}

variable "postfix" {
    description = "Postfix value that depends on the subscription name"
}
variable "ikea2_op_to_ent" {
    description = "The Shared key from the VPN server on-premises data center. "
}
variable "gateway_address_op" {
    description = "The public IP from the on-premises data center"
}
variable "address_space_op" {
    description = "The address space from the on-premises"
}

variable "hub_address_space" {
    description = "Address space VNET-Hub"
}

variable "dns_servers" {
    description = "DNS servers addresses"
}

variable "address_prefixes_gw" {
    description = "Address prefix subnet gateway"
}

variable "address_prefixes_mgmt" {
    description = "Address prefix subnet gateway"
}

variable "address_prefixes_dmz" {
    description = "Address prefix subnet gateway"
}

variable "resource_tags" {
  description = "Tags to set for all resources"
  type        = map(string)
  default = {
    project     = "enterprise",
    environment = "dev"
    pipeline    = "GitHub Actions"
  }
}

