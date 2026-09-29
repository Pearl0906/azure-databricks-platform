variable "resource_group_name" {
  description = "Name of the Azure resource group"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "tags" {
  description = "Tags for Azure resources"
  type        = map(string)
  default     = {}
}

variable "storage_account_name" {
  description = "Name of the Azure Storage Account"
  type        = string
}

variable "storage_filesystem_name" {
  description = "Name of the ADLS Gen2 filesystem"
  type        = string
}

variable "databricks_workspace_name" {
  description = "Name of the Azure Databricks workspace"
  type        = string
}

variable "databricks_managed_resource_group_name" {
  description = "Name of the Azure Databricks managed resource group"
  type        = string
}

variable "databricks_sku" {
  description = "Azure Databricks workspace SKU"
  type        = string
  default     = "standard"
}

variable "catalogue_name" {
  description = "Name of the Unity Catalog catalog"
  type        = string
}

variable "catalogue_comment" {
  description = "Description of the Unity Catalog catalog"
  type        = string
  default     = ""
}

variable "catalogue_force_destroy" {
  description = "Whether to delete all objects inside the catalog when destroying it"
  type        = bool
  default     = false
}

variable "access_connector_name" {
  description = "Name of the Databricks Access Connector"
  type        = string
}

variable "storage_credential_name" {
  description = "Name of the Unity Catalog storage credential"
  type        = string
}

variable "storage_credential_comment" {
  description = "Description of the Unity Catalog storage credential"
  type        = string
  default     = ""
}


variable "azure_client_secret" {
  description = "Azure service principal client secret"
  type        = string
  sensitive   = true
}

variable "azure_tenant_id" {
  description = "Azure tenant ID"
  type        = string
  sensitive   = true
}

variable "external_location_name" {
  description = "Name of the Unity Catalog external location"
  type        = string
}

variable "external_location_comment" {
  description = "Description of the Unity Catalog external location"
  type        = string
  default     = ""
}



