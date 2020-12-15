### RESOURCE PROVISIONING
variable "prefix" {
  default = ""
  type = string
}

variable "suffix" {
  default = ""
  type = string
}

variable "location" {
  type = string
}

variable "kubernetes_version" {
  default = null
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

variable "nodepools" {
  type = map
  default = null
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