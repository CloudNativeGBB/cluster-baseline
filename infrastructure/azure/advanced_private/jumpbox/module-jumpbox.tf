module "jumpbox" {
    source = "../../modules/jumpbox"
    prefix = local.prefix
    suffix = local.suffix
    vm_sku = var.vm_sku
    resource_group = data.terraform_remote_state.networking.outputs.resource_group
    subnet_id = data.terraform_remote_state.networking.outputs.jumpbox_subnet_id
    ssh_key = local.ssh_key
    username = var.username
    custom_data = var.custom_data
}