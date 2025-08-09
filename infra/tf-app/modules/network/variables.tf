variable "location" {
  type        = string
  description = "Azure location"
}


variable "network_rg_name" {
  description = "The name of the resource group for networking"
  type        = string
  default     = "cst8918-final-project-group-3"
}

variable "main_vnet_name" {
  description = "The name of the main virtual network"
  type        = string
  default     = "grp3-vnet"
}