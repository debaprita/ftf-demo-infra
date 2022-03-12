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

variable "az_env_lookup" {
  type        = map(string)
  description = "azure environment and region map"

  default = {
    eastus2_dev  = "de"
    eastus2_qa   = "qe"
    eastus2_perf = "fe"
    eastus2_prod = "pe"

  }
}

variable "location" {
  type        = string
  description = "Region to deploy service(s) into"
  default     = "eastus2"
}

variable "account_tier" {
  type        = string
  description = "Defines the Tier to use for this storage account. Valid options are Standard and Premium"
  default     = "Standard"
}

variable "account_kind" {
  type        = string
  description = "Defines the Kind of account. Valid options are Storage, StorageV2 and BlobStorage"
  default     = "StorageV2"
}

variable "account_replication_type" {
  type        = string
  description = "Defines the type of replication to use for this storage account. Valid options are LRS, GRS, RAGRS and ZRS"
  default     = "LRS"
}

variable "enable_https_traffic_only" {
  type        = string
  description = "Boolean flag which forces HTTPS if enabled"
  default     = "true"
}

variable "storage_container_name" {
  type        = string
  description = "Storage container name"
}
variable "allow_blob_public_access" {
  type        = string
  description = "Allow public access for blob storage."
  default     = "true"
}

variable "index" {
  type        = string
  description = "Unique index to add to the end of the resource group name"
}
