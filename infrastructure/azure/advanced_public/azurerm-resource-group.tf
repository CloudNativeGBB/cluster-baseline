resource "azurerm_resource_group" "aks" {
  name     = "${local.prefix}-rg-${local.suffix}"
  location = local.location
}