variable "resource_group_name" {
  description = "Name of the Azure Resource Group"
  type        = string
  default     = "cst8918-final-backend-group3-rg"
}

variable "location" {
  description = "Azure region for resources"
  type        = string
  default     = "Canada Central"
}

variable "storage_account_name" {
  description = "Azure Storage Account name"
  type        = string
  default     = "group3backendstorage"
}

variable "container_name" {
  description = "Name of the storage container"
  type        = string
  default     = "tfstate"
}

variable "account_tier" {
  description = "Storage account performance tier"
  type        = string
  default     = "Standard"
}

variable "replication_type" {
  description = "Replication type for the storage account"
  type        = string
  default     = "LRS"
}

variable "min_tls_version" {
  description = "Minimum TLS version for the storage account"
  type        = string
  default     = "TLS1_2"
}
