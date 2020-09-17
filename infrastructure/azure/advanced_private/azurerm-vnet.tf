resource "azurerm_virtual_network" "aks" {
  name                = "AksDemoVnet${local.suffix}"
  location            = azurerm_resource_group.aks.location
  resource_group_name = azurerm_resource_group.aks.name
  address_space       = ["10.0.0.0/16"]

  tags = {
    environment = local.environment
  }
}

resource azurerm_subnet firewall {
  name                 = "AzureFirewallSubnet"
  resource_group_name  = azurerm_resource_group.aks.name
  virtual_network_name = azurerm_virtual_network.aks.name
  address_prefixes       = ["10.0.0.0/26"]
}

resource azurerm_subnet acr {
  name           = "ACRSubnet"
  resource_group_name  = azurerm_resource_group.aks.name
  virtual_network_name = azurerm_virtual_network.aks.name
  address_prefixes     = ["10.0.0.64/26"]
  enforce_private_link_endpoint_network_policies = true
  service_endpoints     = ["Microsoft.ContainerRegistry"]
}

resource azurerm_subnet aks {
  name           = "AKSSubnet"
  resource_group_name  = azurerm_resource_group.aks.name
  virtual_network_name = azurerm_virtual_network.aks.name
  address_prefixes     = ["10.0.16.0/22"]
  enforce_private_link_endpoint_network_policies = true
  service_endpoints     = ["Microsoft.ContainerRegistry"]
}