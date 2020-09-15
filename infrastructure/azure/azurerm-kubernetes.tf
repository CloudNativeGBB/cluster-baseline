resource "azurerm_kubernetes_cluster" "aks" {
  name                = "${var.prefix}-aks-cluster-${local.suffix}"
  location            = azurerm_resource_group.aks.location
  resource_group_name = azurerm_resource_group.aks.name
  dns_prefix          = "${var.prefix}-aks-cluster-${local.suffix}"
  kubernetes_version  = var.kubernetes_version

  default_node_pool {
    name                = "default"
    enable_auto_scaling = true
    min_count           = var.default_np_count
    max_count           = 5
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

resource "azurerm_kubernetes_cluster_node_pool" "primary" {
  name                  = "usernp1"
  kubernetes_cluster_id = azurerm_kubernetes_cluster.aks.id
  vm_size               = var.user_np_sku_size
  node_count            = var.user_np_count
  mode                  = "User"

  tags = {
    environment = local.environment
  }
}