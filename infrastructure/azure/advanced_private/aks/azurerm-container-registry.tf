resource "azurerm_container_registry" "acr" {
  name                     = "${local.prefix}acr${local.suffix}"
  resource_group_name      = data.terraform_remote_state.networking.outputs.resource_group.name
  location                 = data.terraform_remote_state.networking.outputs.resource_group.location
  sku                      = "Premium"
  admin_enabled            = false
  
  network_rule_set {
      default_action = "Deny"
      virtual_network {
          action = "Allow"
          subnet_id = data.terraform_remote_state.networking.outputs.acr_subnet_id
      }
  }
}

resource "azurerm_private_endpoint" "acr" {
  name                = "acr-endpoint"
  resource_group_name = data.terraform_remote_state.networking.outputs.resource_group.name
  location            = data.terraform_remote_state.networking.outputs.resource_group.location
  subnet_id           = data.terraform_remote_state.networking.outputs.acr_subnet_id

  private_dns_zone_group {
    name = "acr"
    private_dns_zone_ids = [data.terraform_remote_state.networking.outputs.dns_zone_id]
  }

  private_service_connection {
    name                           = "acr-privateserviceconnection"
    private_connection_resource_id = azurerm_container_registry.acr.id
    is_manual_connection           = false
    subresource_names              = ["registry"]
  }
}