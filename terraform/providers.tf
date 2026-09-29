terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }

    databricks = {
      source  = "databricks/databricks"
      version = "1.113.0"
    }
  }
}

provider "azurerm" {
  features {}
}

provider "databricks" {
  host                        = "https://${module.databricks_workspace.workspace_url}"
  azure_workspace_resource_id = module.databricks_workspace.resource_id

  azure_client_id     = var.azure_client_id
  azure_client_secret = var.azure_client_secret
  azure_tenant_id     = var.azure_tenant_id
}
