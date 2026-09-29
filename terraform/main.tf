module "resource_group" {
  source = "./modules/resource_group"

  name     = var.resource_group_name
  location = var.location
  tags     = var.tags
}

module "storage" {
  source = "./modules/storage"

  name                = var.storage_account_name
  resource_group_name = module.resource_group.name
  location            = module.resource_group.location
  filesystem_name     = var.storage_filesystem_name
  tags                = var.tags
}

module "databricks_workspace" {
  source = "./modules/databricks_workspace"

  name                        = var.databricks_workspace_name
  resource_group_name         = module.resource_group.name
  location                    = module.resource_group.location
  sku                         = var.databricks_sku
  managed_resource_group_name = var.databricks_managed_resource_group_name
  tags                        = var.tags
}

module "catalogue" {
  source = "./modules/catalogue"

  name          = var.catalogue_name
  comment       = var.catalogue_comment
  force_destroy = var.catalogue_force_destroy

  storage_root = module.external_location.url

  principal = "shungubepss@gmail.com"
}

module "access_connector" {
  source = "./modules/access_connector"

  name                = var.access_connector_name
  resource_group_name = module.resource_group.name
  location            = module.resource_group.location
  tags                = var.tags
}

module "storage_access" {
  source = "./modules/storage_access"

  storage_account_id = module.storage.storage_account_id
  principal_id       = module.access_connector.principal_id
}

module "storage_credential" {
  source = "./modules/storage_credential"

  name                = var.storage_credential_name
  access_connector_id = module.access_connector.id
  workspace_id        = module.databricks_workspace.databricks_workspace_id
  comment             = var.storage_credential_comment
}

module "external_location" {
  source = "./modules/external_location"

  name            = var.external_location_name
  url             = "abfss://${module.storage.filesystem_name}@${trimsuffix(replace(module.storage.primary_dfs_endpoint, "https://", ""), "/")}/catalog"
  credential_name = module.storage_credential.name
  comment         = var.external_location_comment
}

module "bronze_schema" {
  source = "./modules/schema"

  name          = "bronze"
  catalog_name  = module.catalogue.catalog_name
  comment       = "Bronze layer containing raw ingested data"
  force_destroy = false
  principal     = "shungubepss@gmail.com"
}

module "raw_volume" {
  source = "./modules/volume"

  name         = "raw"
  catalog_name = module.catalogue.catalog_name
  schema_name  = module.bronze_schema.name
  comment      = "Raw data volume for the Bronze layer"
  principal    = "shungubepss@gmail.com"
}

module "silver_schema" {
  source = "./modules/schema"

  name          = "silver"
  catalog_name  = module.catalogue.catalog_name
  comment       = "Silver layer containing cleaned and transformed data"
  force_destroy = false
  principal     = "shungubepss@gmail.com"
}

module "gold_schema" {
  source = "./modules/schema"

  name          = "gold"
  catalog_name  = module.catalogue.catalog_name
  comment       = "Gold layer containing business-ready data"
  force_destroy = false
  principal     = "shungubepss@gmail.com"
}

module "permissions" {
  source = "./modules/permissions"

  user_name = "shungubepss@gmail.com"
}



