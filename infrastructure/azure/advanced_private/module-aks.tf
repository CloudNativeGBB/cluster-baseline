module "aks" {
    source = "../modules/aks"

    prefix = local.prefix
    suffix = local.suffix

    resource_group = {
        name     = azurerm_resource_group.aks.name
        location = azurerm_resource_group.aks.location
    }
    
    kubernetes_version = var.kubernetes_version
    private_cluster_enabled = true
    
    default_np_sku_size = var.default_np_sku_size
    default_np_count = var.default_np_count
    
    user_np_sku_size = var.user_np_sku_size
    user_np_count = var.user_np_count

    subnet_id       = azurerm_subnet.aks.id
    network_plugin = var.network_plugin
    network_policy = var.network_policy
    load_balancer_sku = var.load_balancer_sku
    service_cidr = var.service_cidr
    dns_service_ip = var.dns_service_ip
    docker_bridge_cidr = var.docker_bridge_cidr
}