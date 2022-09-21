variable "name" {
  description = "The name of the Managed Kubernetes Cluster to create"
  type        = string
}

variable "location" {
  description = "The location where the Managed Kubernetes Cluster should be created"
  type        = string
}

variable "resource_group_name" {
  description = "Specifies the Resource Group where the Managed Kubernetes Cluster should exist"
  type        = string
}

variable "kubernetes_version" {
  description = "Version of Kubernetes specified when creating the AKS managed cluster"
  type        = string
  default     = "1.24.3"
}

variable "default_node_pool_vnet_subnet_id" {
  description = "The ID of a Subnet where the Kubernetes Node Pool should exist"
  type        = string
}

variable "default_node_pool_min_count" {
  description = "The minimum number of nodes which should exist in this Node Pool"
  type        = number
  default     = 3
}

variable "default_node_pool_max_count" {
  description = "The maximum number of nodes which should exist in this Node Pool"
  type        = number
  default     = 10
}

variable "default_node_pool_os_disk_size_gb" {
  description = "The size of the OS Disk which should be used for each agent in the Node Pool"
  type        = number
  default     = 256
}

variable "default_node_pool_vm_size" {
  description = "The SKU of the Virtual Machine"
  type        = string
  default     = "Standard_B2s"
}

variable "auto_scaler_profile_scale_down_utilization_threshold" {
  description = "Node utilization level, defined as sum of requested resources divided by capacity, below which a node can be considered for scale down"
  type        = number
  default     = 0.5
}

variable "aad_rbac_admin_group_object_ids" {
  description = "A list of Object IDs of Azure Active Directory Groups which should have Admin Role on the Cluster"
  type        = list(string)
  default     = []
}

variable "api_server_authorized_ip_ranges" {
  description = "The IP ranges to allow for incoming traffic to the kube-apiserver"
  type        = list(string)
  default     = []
}

variable "log_analytics_workspace_id" {
  description = "The ID of the Log Analytics Workspace which the OMS Agent should send data to"
  type        = string
}

variable "tags" {
  description = "A mapping of tags to assign to the resource"
  type        = map(string)
  default     = {}
}