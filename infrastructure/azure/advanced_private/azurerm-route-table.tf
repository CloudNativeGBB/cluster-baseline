resource "azurerm_route_table" "aks" {
  name                          = "aksRouteTable"
  location                      = azurerm_resource_group.aks.location
  resource_group_name           = azurerm_resource_group.aks.name
  disable_bgp_route_propagation = false

  tags = {
    environment = local.environment
  }
}

resource "azurerm_route" "default" {
  name                = "defaultRoute"
  resource_group_name = azurerm_resource_group.aks.name
  route_table_name    = azurerm_route_table.aks.name
  address_prefix      = "0.0.0.0/0"
  next_hop_type       = "VirtualAppliance"
  next_hop_in_ip_address = azurerm_firewall.aks.ip_configuration[0].private_ip_address
}


resource "azurerm_subnet_route_table_association" "example" {
  subnet_id      = azurerm_subnet.aks.id
  route_table_id = azurerm_route_table.aks.id
}