
resource "azurerm_public_ip" "jumpbox" {
  name                = "${local.hostname}-pip"
  resource_group_name = var.resource_group.name
  location            = var.resource_group.location
  allocation_method   = "Static"
  domain_name_label = local.hostname

  tags = {
    environment = local.environment
  }
}