resource "azurerm_resource_group" "aks" {
  name     = "${var.prefix}-rg-${local.suffix}"
  location = var.region
}