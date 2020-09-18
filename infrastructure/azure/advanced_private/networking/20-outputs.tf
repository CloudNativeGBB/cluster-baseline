output "aks_subnet_id" {
  value = azurerm_subnet.aks.id
}

output "resource_group" {
    value = {
        name = azurerm_resource_group.aks.name
        location = azurerm_resource_group.aks.location
    }
}