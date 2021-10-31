locals {
  postfix            = var.postfix
  hub-location       = var.location
  hub-resource-group = var.resource_group_name
}

resource "azurerm_resource_group" "network-ent-we-01" {
  name     = local.hub-resource-group
  location = local.hub-location
}

resource "azurerm_virtual_network" "hub-vnet" {
  name                = "hub-${local.postfix}"
  location            = azurerm_resource_group.network-ent-we-01.location
  resource_group_name = azurerm_resource_group.network-ent-we-01.name
  address_space       = var.hub_address_space
  dns_servers         = var.dns_servers
  tags                = var.resource_tags
}

resource "azurerm_subnet" "hub-gateway-subnet" {
  name                 = "GatewaySubnet"
  resource_group_name  = azurerm_resource_group.network-ent-we-01.name
  virtual_network_name = azurerm_virtual_network.hub-vnet.name
  address_prefixes     = var.address_prefixes_gw
}

resource "azurerm_subnet" "hub-mgmt" {
  name                 = "subnet-mgmt-${local.postfix}"
  resource_group_name  = azurerm_resource_group.network-ent-we-01.name
  virtual_network_name = azurerm_virtual_network.hub-vnet.name
  address_prefixes     = var.address_prefixes_mgmt
}

resource "azurerm_subnet" "hub-dmz" {
  name                 = "subnet-dmz-${local.postfix}"
  resource_group_name  = azurerm_resource_group.network-ent-we-01.name
  virtual_network_name = azurerm_virtual_network.hub-vnet.name
  address_prefixes     = var.address_prefixes_dmz
}

resource "azurerm_public_ip" "vpngw-pip-ent-we-01" {
  name                = "vpngw-pip-ent-we-01"
  location            = azurerm_resource_group.network-ent-we-01.location
  resource_group_name = azurerm_resource_group.network-ent-we-01.name

  allocation_method = "Dynamic"
}

resource "azurerm_virtual_network_gateway" "hub-vnet-gateway" {
  name                = "vpngw-ent-we-01"
  location            = azurerm_resource_group.network-ent-we-01.location
  resource_group_name = azurerm_resource_group.network-ent-we-01.name

  type     = "Vpn"
  vpn_type = "RouteBased"

  active_active = false
  sku           = "Basic"

  ip_configuration {
    name                          = "vnetGatewayConfig"
    public_ip_address_id          = azurerm_public_ip.vpngw-pip-ent-we-01.id
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = azurerm_subnet.hub-gateway-subnet.id
  }

  depends_on = [azurerm_public_ip.vpngw-pip-ent-we-01]
}

resource "azurerm_local_network_gateway" "local-network-gateway-op" {
  name                = "lng-op-01"
  resource_group_name = azurerm_resource_group.network-ent-we-01.name
  location            = azurerm_resource_group.network-ent-we-01.location
  gateway_address     = var.gateway_address_op
  address_space       = var.address_space_op
}

resource "azurerm_virtual_network_gateway_connection" "azure_to_on-prem" {
  name                = "azure-ent_to_on-prem"
  location            = azurerm_resource_group.network-ent-we-01.location
  resource_group_name = azurerm_resource_group.network-ent-we-01.name

  type                            = "IPsec"
  virtual_network_gateway_id      = azurerm_virtual_network_gateway.hub-vnet-gateway.id
  local_network_gateway_id        = azurerm_local_network_gateway.local-network-gateway-op.id

  shared_key = var.ikea2_op_to_ent
}