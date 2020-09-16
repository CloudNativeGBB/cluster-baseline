output "kube_config" {
  value = module.aks.kube_config_raw
}

output "cluster_name" {
  value = module.aks.name
}

output "cluster_resource_group_name" {
  value = module.aks.resource_group_name
}
