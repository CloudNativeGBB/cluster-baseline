resource "azurerm_kubernetes_cluster" "aks" {
  name                = "${var.prefix}-aks-cluster-${local.suffix}"
  location            = var.resource_group.location
  resource_group_name = var.resource_group.name
  
  dns_prefix          = "${var.prefix}-aks-cluster-${local.suffix}"
  
  kubernetes_version  = var.kubernetes_version
  private_cluster_enabled = var.private_cluster_enabled

  default_node_pool {
    name                = "default"
    enable_auto_scaling = true
    min_count           = var.default_np_count
    max_count           = 5
    vm_size             = var.default_np_sku_size
    os_disk_size_gb     = 30
    type                = "VirtualMachineScaleSets"
    vnet_subnet_id      = var.subnet_id
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
    outbound_type      = var.private_cluster_enabled == true ? "userDefinedRouting" : "loadBalancer"
  }

  addon_profile {
    oms_agent {
      enabled                    = true
      log_analytics_workspace_id = azurerm_log_analytics_workspace.aks.id
    }
    kube_dashboard {
      enabled = false
    }
  }
  
  role_based_access_control {
    enabled = true

    azure_active_directory {
      managed = true
    }    
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