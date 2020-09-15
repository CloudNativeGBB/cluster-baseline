resource "azurerm_resource_group" "aks" {
  name     = "${var.prefix}-rg"
  location = var.region
}