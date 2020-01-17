locals {
  project_id      = var.PROJECT_ID
  cluster_name    = var.CLUSTER_NAME
  region          = var.REGION
  network_name    = var.VPC_NAME

  cluster_subnetwork_name = var.SUBNETWORK_NAME
  cluster_subnetwork_cidr = var.SUBNETWORK_CIDR
  
  services_range_name = var.SERVICES_RANGE_NAME
  services_range_cidr = var.SERVICES_RANGE_CIDR

  pod_range_name  = var.POD_RANGE_NAME
  pod_range_cidr  = var.POD_RANGE_CIDR
  
  kubernetes_version = var.KUBERNETES_VERSION
}