output "resource_group" {
    value = {
        name = azurerm_resource_group.aks.name
        location = azurerm_resource_group.aks.location
    }
}

output "dns_zone_id" {
  value = azurerm_private_dns_zone.acr.id
}

output "aks_subnet_id" {
  value = azurerm_subnet.aks.id
}

output "acr_subnet_id" {
  value = azurerm_subnet.acr.id
}