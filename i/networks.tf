#Network peering between VNets

# VNet Peering from VNet A to VNet B
resource "azurerm_virtual_network_peering" "vnet_peering_a_to_b" {
  provider                     = azurerm.sub_a
  name                         = "peer-a-to-b"
  resource_group_name          = azurerm_resource_group.sub_a.name
  virtual_network_name         = azurerm_virtual_network.vnet_a.name
  remote_virtual_network_id    = azurerm_virtual_network.vnet_b.id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
  allow_gateway_transit        = false
  use_remote_gateways          = false

}

# VNet Peering from VNet B to VNet A
resource "azurerm_virtual_network_peering" "vnet_peering_b_to_a" {
  provider                     = azurerm.sub_b
  name                         = "peer-b-to-a"
  resource_group_name          = azurerm_resource_group.sub_b.name
  virtual_network_name         = azurerm_virtual_network.vnet_b.name
  remote_virtual_network_id    = azurerm_virtual_network.vnet_a.id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
  allow_gateway_transit        = false
  use_remote_gateways          = false
}