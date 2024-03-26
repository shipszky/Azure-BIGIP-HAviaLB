data "azurerm_public_ip" "f52-public_ip" {
  name = var.public_ip_bigip2
  resource_group_name = var.resource_group_name
}

resource "azurerm_network_interface" "f52-mgmt_nic" {
  name                = "${var.prefix}-${var.hostname2}-mgmt-nic"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "${var.prefix}${var.hostname2}-ip-mgmt"
    subnet_id                     = data.azurerm_subnet.mgmt.id
    private_ip_address_allocation = "Static"
    private_ip_address            = var.mgmt_ip_bigip2
    public_ip_address_id          = data.azurerm_public_ip.f52-public_ip.id
  }
}

resource "azurerm_network_interface" "f52-nic_external1" {
  name                = "${var.prefix}-${var.hostname2}-external1-nic"
  location            = var.location
  resource_group_name = var.resource_group_name
  enable_accelerated_networking = true

  ip_configuration {
    name                          = "${var.prefix}-${var.hostname2}-external1-selfip"
    subnet_id                     = data.azurerm_subnet.external1.id
    private_ip_address_allocation = "Static"
    private_ip_address            = var.external1_ip_bigip2
  }
}

resource "azurerm_network_interface" "f52-nic_external2" {
  name                = "${var.prefix}-${var.hostname2}-external2-nic"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  enable_accelerated_networking = true

  ip_configuration {
    name                          = "${var.prefix}-${var.hostname2}-external2-selfip"
    subnet_id                     = data.azurerm_subnet.external2.id
    private_ip_address_allocation = "Static"
    private_ip_address            = var.external2_ip_bigip2
  }
}

resource "azurerm_network_interface" "f52-nic_internal1" {
  name                = "${var.prefix}-${var.hostname2}-internal1-nic"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  enable_accelerated_networking = true

  ip_configuration {
    name                          = "${var.prefix}-${var.hostname2}-internal1-selfip"
    subnet_id                     = data.azurerm_subnet.internal1.id
    private_ip_address_allocation = "Static"
    private_ip_address            = var.internal1_ip_bigip2
  }
}

resource "azurerm_network_interface" "f52-nic_internal2" {
  name                = "${var.prefix}-${var.hostname2}-internal2-nic"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  enable_accelerated_networking = true

  ip_configuration {
    name                          = "${var.prefix}-${var.hostname2}-internal2-selfip"
    subnet_id                     = data.azurerm_subnet.internal2.id
    private_ip_address_allocation = "Static"
    private_ip_address            = var.internal2_ip_bigip2
  }
}

resource "azurerm_network_interface_security_group_association" "f52-nic_sg_assoc_mgmt" {
  network_interface_id      = azurerm_network_interface.f52-mgmt_nic.id
  network_security_group_id = data.azurerm_network_security_group.mgmt.id
}

resource "azurerm_network_interface_security_group_association" "f52-nic_sg_assoc_internal1" {
  network_interface_id      = azurerm_network_interface.f52-nic_internal1.id
  network_security_group_id = data.azurerm_network_security_group.internal.id
}

resource "azurerm_network_interface_security_group_association" "f52-nic_sg_assoc_internal2" {
  network_interface_id      = azurerm_network_interface.f52-nic_internal2.id
  network_security_group_id = data.azurerm_network_security_group.internal.id
}

resource "azurerm_network_interface_security_group_association" "f52-nic_sg_assoc_external1" {
  network_interface_id      = azurerm_network_interface.f52-nic_external1.id
  network_security_group_id = data.azurerm_network_security_group.external.id
}

resource "azurerm_network_interface_security_group_association" "f52-nic_sg_assoc_external2" {
  network_interface_id      = azurerm_network_interface.f52-nic_external2.id
  network_security_group_id = data.azurerm_network_security_group.external.id
}

resource "azurerm_linux_virtual_machine" "f52-vm" {
  depends_on = [ azurerm_network_interface.f51-mgmt_nic, azurerm_network_interface.f51-nic_external1, azurerm_network_interface.f51-nic_external2, azurerm_network_interface.f51-nic_internal1, azurerm_network_interface.f51-nic_internal2, azurerm_network_interface.f52-mgmt_nic,azurerm_network_interface.f52-nic_external1, azurerm_network_interface.f52-nic_external2, azurerm_network_interface.f52-nic_internal1, azurerm_network_interface.f52-nic_internal2 ]
  name                  = "${var.prefix}-${var.hostname2}"
  resource_group_name   = data.azurerm_resource_group.rg.name
  location              = data.azurerm_resource_group.rg.location
  size                  = var.f5_instance_type
  admin_username        = var.f5_username
  disable_password_authentication = false
  admin_password = var.f5_password
  zone = var.availability_zone_f52
  custom_data = base64encode(templatefile("f5_onboard.tmpl",
    {
      INIT_URL                   = var.INIT_URL
      DO_URL                     = var.DO_URL
      AS3_URL                    = var.AS3_URL
      TS_URL                     = var.TS_URL,
      DO_VER                     = format("v%s", split("-", split("/", var.DO_URL)[length(split("/", var.DO_URL)) - 1])[3])
      AS3_VER                    = format("v%s", split("-", split("/", var.AS3_URL)[length(split("/", var.AS3_URL)) - 1])[2])
      TS_VER                     = format("v%s", split("-", split("/", var.TS_URL)[length(split("/", var.TS_URL)) - 1])[2])
      bigip_username             = var.f5_username
      ssh_keypair                = var.f5_ssh_publickey
      bigip_password             = var.f5_password
      self_ip_internal1 = var.internal1_ip_bigip2
      self_ip_internal2 = var.internal2_ip_bigip2
      self_ip_external1 = var.external1_ip_bigip2
      self_ip_external2 = var.external2_ip_bigip2
      host_name = var.hostname2
      ha_host1 = var.internal2_ip_bigip1
      ha_host2 = var.internal2_ip_bigip2
      default_gateway = var.default_gateway
  }))

#  admin_ssh_key {
#    username   = var.f5_username
#    public_key = file(var.f5_ssh_publickey)
#  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = var.image_publisher
    offer     = var.f5_product_name
    sku       = var.f5_image_name
    version   = var.bigip_version
  }

  plan {
    publisher = var.image_publisher
    product   = var.f5_product_name
    name      = var.f5_image_name
  }

  boot_diagnostics {
  }

  network_interface_ids = [
      azurerm_network_interface.f52-mgmt_nic.id,
      azurerm_network_interface.f52-nic_external1.id, 
      azurerm_network_interface.f52-nic_external2.id,
      azurerm_network_interface.f52-nic_internal1.id,
      azurerm_network_interface.f52-nic_internal2.id
  ]
}

resource "time_sleep" "f52-wait_bigip_ready" {
  depends_on      = [azurerm_linux_virtual_machine.f52-vm]
  create_duration = var.time_sleep
}