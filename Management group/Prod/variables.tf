variable "resource_group_name" {}
variable "location" {}
variable "virtual_network_name" {}
variable "vnet_address_space" {}

variable "frontend_subnet_name" {}
variable "frontend_subnet_prefix" {}

variable "backend_subnet_name" {}
variable "backend_subnet_prefix" {}

variable "frontend_pip_name" {}
variable "backend_pip_name" {}

variable "frontend_nic_name" {}
variable "backend_nic_name" {}

variable "frontend_ip_name" {}
variable "backend_ip_name" {}

variable "frontend_vm_name" {}
variable "backend_vm_name" {}

variable "secret_username_name" {}
variable "secret_password_name" {}
variable "secret_username_value" {}
variable "secret_password_value" {}

variable "key_vault_name" {}

variable "frontend_image_publisher" {}
variable "frontend_image_offer" {}
variable "frontend_image_sku" {}
variable "frontend_image_version" {}

variable "backend_image_publisher" {}
variable "backend_image_offer" {}
variable "backend_image_sku" {}
variable "backend_image_version" {}
