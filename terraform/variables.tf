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

  validation {
    condition     = can(regex("^[a-z0-9-]+$", var.aks_cluster_name))
    error_message = "AKS cluster name must contain only lowercase letters, numbers, and hyphens."
  }

  validation {
    condition     = length(var.aks_cluster_name) >= 3 && length(var.aks_cluster_name) <= 63
    error_message = "AKS cluster name must be between 3 and 63 characters long."
  }
}

variable "aks_node_vm_size" {
  description = "VM size for the AKS default node pool."
  type        = string
  default     = "Standard_B2s"

  validation {
    condition     = trimspace(var.aks_node_vm_size) != ""
    error_message = "AKS node VM size must not be empty."
  }
}

variable "aks_node_count" {
  description = "Initial number of nodes in the AKS default node pool."
  type        = number
  default     = 2

  validation {
    condition     = var.aks_node_count >= 1
    error_message = "AKS node count must be at least 1."
  }
}

variable "aks_pod_cidr" {
  description = "CIDR range used for AKS pods."
  type        = string
  default     = "10.244.0.0/16"
}

variable "aks_service_cidr" {
  description = "CIDR range used for Kubernetes services."
  type        = string
  default     = "10.0.2.0/24"
}

variable "aks_dns_service_ip" {
  description = "Kubernetes DNS service IP address."
  type        = string
  default     = "10.0.2.10"
}
