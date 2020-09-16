output "kube_config" {
  value = module.aks.kube_config
}

output "cluster_name" {
  value = module.aks.cluster_name
}

output "cluster_resource_group_name" {
  value = module.aks.cluster_resource_group_name
}
