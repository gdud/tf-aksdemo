variable "environment" {
  description = "The name of the environment uses as a prefix for all resources"
  type        = string
  default     = "recruitment"
}

variable "location" {
  description = "The location where the Managed Kubernetes Cluster should be created"
  type        = string
  default     = "West Europe"
}

variable "vnet_address_space" {
  description = "The address space that is used the virtual network"
  type        = list(string)
  default     = ["10.0.10.0/23"]
}

variable "aks_subnet_address_prefixes" {
  description = "The address prefixes to use for the AKS subnet"
  type        = list(string)
  default     = ["10.0.10.0/24"]
}

variable "kubernetes_version" {
  description = "Version of Kubernetes specified when creating the AKS managed cluster"
  type        = string
  default     = "1.24.3"
}

variable "tags" {
  description = "A mapping of tags to assign to the resource"
  type        = map(string)
  default = {
    name = "Grzegorz Dudek"
  }
}

variable "api_server_authorized_ip_ranges" {
  description = "The IP ranges to allow for incoming traffic to the kube-apiserver"
  type        = list(string)
  default = [
    "0.0.0.0/32"
  ]
}

variable "aad_rbac_admin_group_object_ids" {
  description = "A list of Object IDs of Azure Active Directory Groups which should have Admin Role on the Cluster"
  type        = list(string)
  default     = []
}