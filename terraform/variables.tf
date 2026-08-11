variable "azure_location" {
  description = "Azure region where resources will be deployed."
  type        = string
  default     = "westeurope"
}

variable "resource_group_name" {
  description = "Name of the Azure resource group."
  type        = string
  default     = "devops-ecommerce-rg"
}
