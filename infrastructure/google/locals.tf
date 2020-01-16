locals {
  project_id      = var.PROJECT_ID
  name            = var.CLUSTER_NAME
  region          = var.REGION
  network         = var.VPC_NAME
  subnetwork      = var.SUBNET_NAME
  ip_range_pods   = var.POD_SUBNET_NAME
  ip_range_services = var.SERVICE_SUBNET_NAME

  kubernetes_version = var.KUBERNETES_VERSION
}