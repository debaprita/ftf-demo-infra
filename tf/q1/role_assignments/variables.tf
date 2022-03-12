## variables

variable "str_acc_name" {
  type        = string
  description = "Storage Account name to which access needs to be scoped"
}

variable "str_acc_rg_name" {
  type        = string
  description = "Resource group to which Storage Account belongs"
}

variable "ug_principal_name" {
  type        = string
  description = "User or Group principal name to which the writer access needs to be scoped"
}

variable "container_name" {
  type        = string
  description = "Container name in Storage Account to which access needs to be scoped"
}

