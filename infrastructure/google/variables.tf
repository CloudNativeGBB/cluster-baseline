variable "PROJECT_ID" {
  default = "azure-arc-demo"
}

variable "CLUSTER_NAME" {
  default = "azure-arc-demo-cluster"
}

variable "REGION" {
  default = "us-west1"
}

variable "VPC_NAME" {
  default = "gke-vpc"
}

variable "SUBNETWORK_NAME" {
  default = "cluster-subnet"
}

variable "SUBNETWORK_CIDR" {
  default = "10.0.0.0/16"
}

variable "SERVICES_RANGE_NAME" {
  default = "services-subnet"
}

variable "SERVICES_RANGE_CIDR" {
 default = "10.1.0.0/16" 
}

variable "POD_RANGE_NAME" {
  default = "pod-subnet"
}

variable "POD_RANGE_CIDR" {
  default = "10.2.0.0/16"
}

variable "KUBERNETES_VERSION" {
  default = "1.14.8"
}
