output "kube_config" {
  value = azurerm_kubernetes_cluster.aks.kube_config_raw
}

output "cluster_name" {
  value = azurerm_kubernetes_cluster.aks.name
}

output "cluster_resource_group_name" {
  value = azurerm_kubernetes_cluster.aks.resource_group_name
}
