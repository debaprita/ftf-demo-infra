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

variable "sku_size" {
  type        = string
  description = "KeyVault SKU size"
}

variable "rg_name" {
  type        = string
  description = "KeyVault resource group name"
}
