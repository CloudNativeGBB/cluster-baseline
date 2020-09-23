resource "azurerm_network_interface" "jumpbox" {
  name                = "${local.hostname}-pip"
  location            = var.resource_group.location
  resource_group_name = var.resource_group.name

  ip_configuration {
    name                          = "primary"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.jumpbox.id
  }
}