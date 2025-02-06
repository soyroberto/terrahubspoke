output "resource_group_a_name" {
  description = "The name of the resource group A"
  value       = azurerm_resource_group.sub_a.name
}

output "resource_group_b_name" {
  description = "The name of the resource group B"
  value       = azurerm_resource_group.sub_b.name
}

output "vnet_subnets" {
  description = "value of the subnet"
  value       = azurerm_virtual_network.vnet_a.subnet
}

output "vnet_subnets_b" {
  description = "value of the subnet"
  value       = azurerm_virtual_network.vnet_b.subnet
}

output "vnet_b_id" {
  description = "The ID of the virtual network B"
  value       = azurerm_virtual_network.vnet_b.id
}

output "vnet_a_id" {
  description = "The ID of the virtual network A"
  value       = azurerm_virtual_network.vnet_a.id
}