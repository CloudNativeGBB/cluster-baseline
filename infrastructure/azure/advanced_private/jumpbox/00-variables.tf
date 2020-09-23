### RESOURCE PROVISIONING
variable "prefix" {
  default = ""
  type = string
}

variable "suffix" {
  default = ""
  type = string
}

variable "vm_sku"{
  type = string
  default = "Standard_D4_v3"
}

variable "ssh_key"{
  default = "~/.ssh/id_rsa.pub"
  description = "(Required) File path to an SSH Public Key."
  type = string
}

variable "username"{
  type = string
  default = "aksadmin"
}

variable "custom_data"{
  type = string
  default = ""
}