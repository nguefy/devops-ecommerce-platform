output "resource_group_name" {
  description = "Name of the Azure resource group."
  value       = azurerm_resource_group.main.name
}

output "resource_group_location" {
  description = "Azure region of the resource group."
  value       = azurerm_resource_group.main.location
}

output "aks_cluster_name" {
  description = "Name of the AKS cluster."
  value       = azurerm_kubernetes_cluster.main.name
}

output "aks_cluster_id" {
  description = "Resource ID of the AKS cluster."
  value       = azurerm_kubernetes_cluster.main.id
}

output "aks_oidc_issuer_url" {
  description = "OIDC issuer URL of the AKS cluster."
  value       = azurerm_kubernetes_cluster.main.oidc_issuer_url
}

output "aks_fqdn" {
  description = "Fully qualified domain name of the AKS cluster."
  value       = azurerm_kubernetes_cluster.main.fqdn
}

output "aks_kubelet_identity_object_id" {
  description = "Object ID of the AKS kubelet managed identity."
  value       = azurerm_kubernetes_cluster.main.kubelet_identity[0].object_id
}

output "vnet_name" {
  description = "Name of the Azure virtual network."
  value       = azurerm_virtual_network.main.name
}

output "aks_subnet_name" {
  description = "Name of the AKS subnet."
  value       = azurerm_subnet.aks.name
}

output "vnet_id" {
  description = "Resource ID of the Azure virtual network."
  value       = azurerm_virtual_network.main.id
}

output "aks_subnet_id" {
  description = "Resource ID of the AKS subnet."
  value       = azurerm_subnet.aks.id
}
