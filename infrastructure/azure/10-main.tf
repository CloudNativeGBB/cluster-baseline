terraform {
  required_version = "~> 0.12.29"
}

######################################################################### PROVIDERS
provider "azuread" {
  tenant_id = var.tenant_id
}

provider "azurerm" {
  subscription_id = var.subscription_id
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
    min_count           = 3
    max_count           = 10
    vm_size             = "Standard_DS1_v2"
    os_disk_size_gb     = 30
    type                = "VirtualMachineScaleSets"
    availability_zones  = [ "1", "2", "3"]
    enable_auto_scaling = true
    vnet_subnet_id      = var.vnet_subnet_id
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
