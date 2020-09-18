resource azurerm_firewall_application_rule_collection "aks" {
  name                = "aksRequiredRules${local.suffix}"
  azure_firewall_name = azurerm_firewall.aks.name
  resource_group_name = azurerm_resource_group.aks.name
  priority            = 100
  action              = "Allow"

  rule {
    name = "updateInfraRules"

    source_addresses = concat([],azurerm_virtual_network.aks.address_space)

    target_fqdns = [
      "*.hcp.${azurerm_resource_group.aks.location}.azmk8s.io",
      "mcr.microsoft.com",
      "*.cdn.mcr.io",
      "*.data.mcr.microsoft.com",
      "management.azure.com",
      "login.microsoftonline.com",
      "packages.microsoft.com",
      "acs-mirror.azureedge.net"
    ]

    protocol {
      port = "443"
      type = "Https"
    }
  }
}

resource azurerm_firewall_application_rule_collection "azureMonitor" {
  name                = "azureMonitorRequiredRules${local.suffix}"
  azure_firewall_name = azurerm_firewall.aks.name
  resource_group_name = azurerm_resource_group.aks.name
  priority            = 110
  action              = "Allow"

  rule {
    name = "azureMonitorRules"

    source_addresses = concat([],azurerm_virtual_network.aks.address_space)

    target_fqdns = [
      "dc.services.visualstudio.com",
      "*.ods.opinsights.azure.com",
      "*.oms.opinsights.azure.com",
      "*.monitoring.azure.com"
    ]

    protocol {
      port = "443"
      type = "Https"
    }
  }
}

resource "azurerm_firewall_network_rule_collection" "ntp" {
  name                = "ntpRule${local.suffix}"
  azure_firewall_name = azurerm_firewall.aks.name
  resource_group_name = azurerm_resource_group.aks.name
  priority            = 200
  action              = "Allow"

  rule {
    name = "ubuntuNTP"

    source_addresses = azurerm_subnet.aks.address_prefixes

    destination_ports = [
      "123",
    ]

    destination_addresses = [
      "*"
    ]

    protocols = [
      "UDP",
    ]
  }
}

resource azurerm_firewall_application_rule_collection "updates" {
  name                = "ubuntuUpdateInfrastructure${local.suffix}"
  azure_firewall_name = azurerm_firewall.aks.name
  resource_group_name = azurerm_resource_group.aks.name
  priority            = 300
  action              = "Allow"

  rule {
    name = "updateInfraRules"

    source_addresses = concat([],azurerm_virtual_network.aks.address_space)

    target_fqdns = [
      "azure.archive.ubuntu.com",
      "security.ubuntu.com",
      "changelogs.ubuntu.com",
      "launchpad.net",
      "ppa.launchpad.net",
      "keyserver.ubuntu.com"
    ]

    protocol {
      port = "443"
      type = "Https"
    }

    protocol {
      port = "80"
      type = "Http"
    }
  }
}