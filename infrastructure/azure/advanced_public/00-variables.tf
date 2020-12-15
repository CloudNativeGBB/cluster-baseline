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
}