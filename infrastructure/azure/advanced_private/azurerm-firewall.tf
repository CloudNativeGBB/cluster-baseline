resource azurerm_public_ip firewall {
  name                = "pip-fw-${local.suffix}"
  location            = azurerm_resource_group.aks.location
  resource_group_name = azurerm_resource_group.aks.name
  allocation_method   = "Static"
  sku                 = "Standard"
  domain_name_label   = "${local.prefix}-pip-${local.suffix}"
}

resource azurerm_firewall aks {
  name                = "afw-${local.suffix}"
  location            = azurerm_resource_group.aks.location
  resource_group_name = azurerm_resource_group.aks.name

  ip_configuration {
    name                 = "primary"
    subnet_id            = azurerm_subnet.firewall.id
    public_ip_address_id = azurerm_public_ip.firewall.id
  }
}