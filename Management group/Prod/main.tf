module "azurerm_resource_group" {
  source                  = "../Modules/azurerm_resource_group"
  resource_group_name     = var.resource_group_name
  resource_group_location = var.location
}

module "azurerm_virtual_network" {
  depends_on           = [module.azurerm_resource_group]
  source               = "../Modules/azurerm_virtual_network"
  virtual_network_name = var.virtual_network_name
  address_space        = var.vnet_address_space
  location             = var.location
  resource_group_name  = var.resource_group_name
}

module "azurerm_subnet" {
  depends_on           = [module.azurerm_virtual_network]
  source               = "../Modules/azurerm_subnet"
  subnet_name          = var.frontend_subnet_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.virtual_network_name
  address_prefixes     = var.frontend_subnet_prefix
}


module "azurerm_public_ip" {
  depends_on          = [module.azurerm_virtual_network]
  source              = "../Modules/azurerm_public_ip"
  pip_name            = var.frontend_pip_name
  resource_group_name = var.resource_group_name
  location            = var.location
}


module "azurerm_virtual_machine" {
  depends_on             = [module.azurerm_frontend_subnet, module.frontend_public_ip, module.key_vault, module.vm_password_secret, module.vm_username_secret]
  source                 = "../Modules/azurerm_virtual_machine"
  network_interface_name = var.frontend_nic_name
  location               = var.location
  resource_group_name    = var.resource_group_name
  ip_name                = var.frontend_ip_name
  virtual_machine_name   = var.frontend_vm_name
  subnet_name            = var.frontend_subnet_name
  virtual_network_name   = var.virtual_network_name
  public_ip_name         = var.frontend_pip_name
  secret_username_name   = var.secret_username_name
  secret_password_name   = var.secret_password_name
  image_publisher        = var.frontend_image_publisher
  image_offer            = var.frontend_image_offer
  image_sku              = var.frontend_image_sku
  image_version          = var.frontend_image_version
  key_vault_name         = var.key_vault_name
}

module "backend_vm" {
  depends_on             = [module.azurerm_backend_subnet, module.backend_public_ip, module.key_vault, module.vm_password_secret, module.vm_username_secret]
  source                 = "../Modules/azurerm_virtual_machine"
  network_interface_name = var.backend_nic_name
  location               = var.location
  resource_group_name    = var.resource_group_name
  ip_name                = var.backend_ip_name
  virtual_machine_name   = var.backend_vm_name
  subnet_name            = var.backend_subnet_name
  virtual_network_name   = var.virtual_network_name
  public_ip_name         = var.backend_pip_name
  secret_username_name   = var.secret_username_name
  secret_password_name   = var.secret_password_name
  image_publisher        = var.backend_image_publisher
  image_offer            = var.backend_image_offer
  image_sku              = var.backend_image_sku
  image_version          = var.backend_image_version
  key_vault_name         = var.key_vault_name
}

module "key_vault" {
  depends_on          = [module.azurerm_resource_group]
  source              = "../Modules/azurerm_key_vault"
  key_vault_name      = var.key_vault_name
  location            = var.location
  resource_group_name = var.resource_group_name
}

module "vm_username_secret" {
  depends_on          = [module.key_vault]
  source              = "../Modules/azurerm_key_vault_secret"
  key_vault_name      = var.key_vault_name
  secret_name         = var.secret_username_name
  secret_value        = var.secret_username_value
  resource_group_name = var.resource_group_name
}

module "vm_password_secret" {
  depends_on          = [module.key_vault, module.vm_username_secret]
  source              = "../Modules/azurerm_key_vault_secret"
  key_vault_name      = var.key_vault_name
  secret_name         = var.secret_password_name
  secret_value        = var.secret_password_value
  resource_group_name = var.resource_group_name
}

