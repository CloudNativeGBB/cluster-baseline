variable prefix {
    type = string
    default = ""
}

variable suffix {
    type = string
    default = ""
}

variable resource_group {
}

variable vm_sku {
    type    = string
    default = "Standard_D4_v3"
}

variable subnet_id {
    type = string
}

variable ssh_key {
    type = string
}

variable username {
    type = string
    default = "jumpboxadmin"
}

variable custom_data {
    type = string
    default = ""
}