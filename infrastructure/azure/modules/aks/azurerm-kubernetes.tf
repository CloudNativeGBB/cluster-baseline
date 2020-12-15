resource "azurerm_kubernetes_cluster" "aks" {
  name                = "${local.prefix}-aks-cluster-${local.suffix}"
  location            = var.resource_group.location
  resource_group_name = var.resource_group.name
  
  dns_prefix          = "${local.prefix}-aks-cluster-${local.suffix}"
  
  kubernetes_version  = var.kubernetes_version != "" ? var.kubernetes_version : null
  private_cluster_enabled = var.private_cluster_enabled

  default_node_pool {
    name                = var.default_nodepool.name
    vm_size             = var.default_nodepool.vm_size
    os_disk_size_gb     = var.default_nodepool.os_disk_size_gb
    os_disk_type        = var.default_nodepool.os_disk_type
    max_pods            = var.default_nodepool.max_pods    
    node_count          = var.default_nodepool.node_count
    
    enable_auto_scaling = var.default_nodepool.enable_auto_scaling.enabled != true ? null : true
    min_count           = var.default_nodepool.enable_auto_scaling.enabled != true ? null : var.default_nodepool.enable_auto_scaling.min_count
    max_count           = var.default_nodepool.enable_auto_scaling.enabled != true ? null : var.default_nodepool.enable_auto_scaling.max_count
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
  
  # role_based_access_control {
  #   enabled = var.role_based_access_control !="" ? true : null

  #   azure_active_directory {
  #     managed = var.azure_active_directory !="" ? true : null
  #   }    
  # }

}

resource "azurerm_kubernetes_cluster_node_pool" "primary" {
  for_each = var.nodepools
  
  kubernetes_cluster_id = azurerm_kubernetes_cluster.aks.id
  
  name                  = each.key
  mode                  = each.value.mode != "" ? each.value.mode : null
  vm_size               = each.value.np_sku_size
  os_disk_type          = each.value.os_disk_type
  os_disk_size_gb       = each.value.os_disk_size_gb
  node_count            = each.value.node_count
  enable_auto_scaling   = each.value.enable_auto_scaling.enabled != true ? null : true
  min_count             = each.value.enable_auto_scaling.enabled != true ? null : each.value.enable_auto_scaling.min_count
  max_count             = each.value.enable_auto_scaling.enabled != true ? null : each.value.enable_auto_scaling.max_count
  vnet_subnet_id        = var.subnet_id
  
  tags = {
    environment = local.environment
  }
}