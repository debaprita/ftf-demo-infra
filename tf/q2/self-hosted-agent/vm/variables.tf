## variables

variable "app_code" {
  type        = string
  description = "Application code"
}

variable "app_name" {
  type        = string
  description = "Application name"
}

variable "environment" {
  type        = string
  description = "Application environment"
}

variable "cost_center_number" {
  type        = string
  description = "Cost Center number for chargeback"
}

variable "location" {
  type        = string
  description = "Region to deploy service(s) into"
  default     = "eastus2"
}
variable "rg_name" {
  type        = string
  description = "KeyVault resource group name"
}
variable "keyvault_name" {
  type        = string
  description = "KeyVault name from which secrets are to be queried"
}
variable "disk_size_gb" {
  type        = string
  description = "OS disk size"
}
variable "index" {
  type        = string
  description = "Unique index to add to the end of the resource group name"
}
variable "sku_size" {
  type        = string
  description = "Virtual machine size"
}
variable "subnet_name" {
  type        = string
  description = "Subnet name to which this virtual machine needs to be placed"
}
variable "subnet_vnet_name" {
  type        = string
  description = "Vnet name to which the subnet belongs"
}
