terraform {
  required_version = "~> 0.12.29"
}

######################################################################### PROVIDERS
provider "azurerm" {
  version = "~> 2.25.0"
  features {}
}

######################################################################### RESOURCES
resource "azurerm_resource_group" "resource_group" {
  name     = "${var.prefix}-rg"
  location = var.region
}

resource "random_string" "random_string_log_analytics_workspace_name_suffix" {
  length = 4
  special = false
  upper = false
}

resource "azurerm_log_analytics_workspace" "log_analytics_workspace" {
  name                = "${var.prefix}-log-analytics-workspace-${random_string.random_string_log_analytics_workspace_name_suffix.result}"
  location            = var.region
  resource_group_name = azurerm_resource_group.resource_group.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}

resource "azurerm_kubernetes_cluster" "kubernetes_cluster" {
  name                = "${var.prefix}-aks-cluster"
  location            = var.region
  resource_group_name = azurerm_resource_group.resource_group.name
  dns_prefix          = "${var.prefix}-aks-cluster"
  kubernetes_version  = var.kubernetes_version

  default_node_pool {
    name                = "default"
    enable_auto_scaling = true
    min_count           = 2
    max_count           = 10
    vm_size             = var.default_np_sku_size
    os_disk_size_gb     = 30
    type                = "VirtualMachineScaleSets"
    vnet_subnet_id      = azurerm_subnet.aks.id
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    network_plugin     = var.network_plugin
    network_policy     = var.network_policy
    load_balancer_sku  = var.load_balancer_sku
    service_cidr       = var.service_cidr
    dns_service_ip     = var.dns_service_ip
    docker_bridge_cidr = var.docker_bridge_cidr
  }

  addon_profile {
    oms_agent {
      enabled                    = true
      log_analytics_workspace_id = azurerm_log_analytics_workspace.log_analytics_workspace.id
    }
    kube_dashboard {
      enabled = false
    }
  }
  
  role_based_access_control {
    enabled = true
  }

}
