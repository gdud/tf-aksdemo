resource "azurerm_kubernetes_cluster" "demo" {
  name       = "${var.name}-aks"
  dns_prefix = "${var.name}-dns-prefix"

  location            = var.location
  resource_group_name = var.resource_group_name

  kubernetes_version = var.kubernetes_version

  default_node_pool {
    name = var.name

    vm_size         = var.default_node_pool_vm_size
    zones           = ["1", "2", "3"]
    os_disk_size_gb = var.default_node_pool_os_disk_size_gb

    enable_auto_scaling = true
    min_count           = var.default_node_pool_min_count
    max_count           = var.default_node_pool_max_count

    vnet_subnet_id = var.default_node_pool_vnet_subnet_id
  }

  identity {
    type = "SystemAssigned"
  }

  azure_active_directory_role_based_access_control {
    managed                = true
    azure_rbac_enabled     = true
    admin_group_object_ids = var.aad_rbac_admin_group_object_ids
  }

  local_account_disabled = true

  api_server_authorized_ip_ranges = var.api_server_authorized_ip_ranges

  network_profile {
    network_plugin     = "azure"
    dns_service_ip     = "10.254.0.10"
    docker_bridge_cidr = "172.17.0.1/16"
    service_cidr       = "10.254.0.0/16"
    network_policy     = "azure"
  }

  auto_scaler_profile {
    scale_down_utilization_threshold = var.auto_scaler_profile_scale_down_utilization_threshold
    skip_nodes_with_system_pods      = false
    skip_nodes_with_local_storage    = false
  }

  azure_policy_enabled = true

  oms_agent {
    log_analytics_workspace_id = var.log_analytics_workspace_id
  }

  tags = var.tags
}