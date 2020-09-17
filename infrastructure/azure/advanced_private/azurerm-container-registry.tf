resource "azurerm_container_registry" "acr" {
  name                     = "${local.prefix}acr${local.suffix}"
  resource_group_name      = azurerm_resource_group.aks.name
  location                 = azurerm_resource_group.aks.location
  sku                      = "Premium"
  admin_enabled            = false
  
  network_rule_set {
      default_action = "Deny"
      virtual_network {
          action = "Allow"
          subnet_id = azurerm_subnet.acr.id
      }
  }
}