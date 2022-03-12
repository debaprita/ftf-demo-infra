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

variable "subnet_ip_address_prefix" {
  type        = string
  description = "Vnet subnet prefix"
  default     = ["10.1.0.0/24"]
}

variable "vnet_ip_address_prefix" {
  type        = string
  description = "Vnet subnet prefix"
  default     = ["10.1.0.0/16"]
}

variable "index" {
  type        = string
  description = "Unique index to add to the end of the resource group name"
}
