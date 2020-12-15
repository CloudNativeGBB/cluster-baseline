### RESOURCE PROVISIONING
variable "prefix" {
  type = string
}

variable "suffix" {
  default = ""
  type = string
}

variable "resource_group" {  
}

variable "kubernetes_version" {
  default = null
  type = string
}

variable "private_cluster_enabled" {
  default = false
  type = bool
}

variable "subnet_id" {
  type = string
}

variable "network_plugin" {
  default = "azure"
  type = string
}

variable "network_policy" {
  default = "calico"
  type = string
}

variable "load_balancer_sku" {
  default = "standard"
  type = string
}

variable "service_cidr" {
  default = null
  type = string
}

variable "dns_service_ip" {
  default = null
  type = string
}

variable "docker_bridge_cidr" {
  default = null
  type = string
}

variable role_based_access_control {
  type = bool
  default = null
}

variable azure_active_directory {
  type = bool
  default = null
}

variable "nodepools" {
  type = map
  default = {}
}

variable "default_nodepool" {
  type = object({
    	name = string
      vm_size = string
      os_disk_size_gb = number
      os_disk_type = string
      max_pods = number
      node_count = number
      enable_auto_scaling = object({
        enabled = bool
        min_count = number
        max_count = number
      })
  })
  
  default = {
    name = "default"
    vm_size = "standard_d4s_v3"
    os_disk_size_gb = 30
    os_disk_type = "Managed"
    max_pods = 30
    node_count = 2
    enable_auto_scaling = {
      enabled = false
      min_count = 1
      max_count = 5
    }
  }
}