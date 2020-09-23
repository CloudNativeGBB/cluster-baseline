resource "azurerm_linux_virtual_machine" "jumpbox" {
  name                = local.hostname
  resource_group_name = var.resource_group.name
  location            = var.resource_group.location
  size                = var.vm_sku
  admin_username      = var.username
  
  network_interface_ids = [
    azurerm_network_interface.jumpbox.id,
  ]

  admin_ssh_key {
    username   = var.username
    public_key = var.ssh_key
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  tags = {
    "environment" = local.environment
  }
}