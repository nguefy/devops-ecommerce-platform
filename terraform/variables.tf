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

variable "vnet_address_space" {
  description = "Address space of the Azure virtual network."
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

variable "aks_subnet_address_prefixes" {
  description = "Address prefixes for the AKS subnet."
  type        = list(string)
  default     = ["10.0.1.0/24"]
}

variable "aks_cluster_name" {
  description = "Name of the Azure Kubernetes Service cluster."
  type        = string
  default     = "devops-ecommerce-aks"
}

variable "aks_node_vm_size" {
  description = "VM size for the AKS default node pool."
  type        = string
  default     = "Standard_B2s"
}

variable "aks_node_count" {
  description = "Initial number of nodes in the AKS default node pool."
  type        = number
  default     = 2
}
