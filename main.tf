terraform {
  required_version = ">= 1.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.0.0"
    }
  }
}

terraform {
  backend "azurerm" {
    # storage_account_name = "abcd1234"
    # container_name       = "tfstate"
    # key                  = "prod.terraform.tfstate"
    # use_azuread_auth     = true
    # subscription_id      = "00000000-0000-0000-0000-000000000000"
    # tenant_id            = "00000000-0000-0000-0000-000000000000"
  }
}

provider "azurerm" {
  features {
  }
}

locals {
  name_prefix = lower(var.environment)
  tags = merge(var.tags, {
    env = var.environment
  })
}

resource "azurerm_resource_group" "demo" {
  name     = "${local.name_prefix}-rg"
  location = var.location
  tags     = local.tags
}

resource "azurerm_virtual_network" "demo" {
  name                = "${local.name_prefix}-vnet"
  resource_group_name = azurerm_resource_group.demo.name
  location            = azurerm_resource_group.demo.location
  address_space       = var.vnet_address_space
  tags                = local.tags
}

resource "azurerm_subnet" "aks" {
  name                 = "${local.name_prefix}-subnet"
  resource_group_name  = azurerm_resource_group.demo.name
  address_prefixes     = var.aks_subnet_address_prefixes
  virtual_network_name = azurerm_virtual_network.demo.name
}

resource "azurerm_log_analytics_workspace" "demo" {
  name                = "${local.name_prefix}-log"
  location            = azurerm_resource_group.demo.location
  resource_group_name = azurerm_resource_group.demo.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}

module "aks" {
  source = "./modules/aks"

  name                = local.name_prefix
  location            = azurerm_resource_group.demo.location
  resource_group_name = azurerm_resource_group.demo.name

  kubernetes_version = var.kubernetes_version

  default_node_pool_vnet_subnet_id = azurerm_subnet.aks.id

  auto_scaler_profile_scale_down_utilization_threshold = 0.8

  log_analytics_workspace_id = azurerm_log_analytics_workspace.demo.id

  aad_rbac_admin_group_object_ids = var.aad_rbac_admin_group_object_ids
  api_server_authorized_ip_ranges = var.api_server_authorized_ip_ranges

  tags = local.tags
}


