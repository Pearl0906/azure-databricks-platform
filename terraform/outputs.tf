output "access_connector_id" {
  description = "Databricks Access Connector resource ID"
  value       = module.access_connector.id
}

output "access_connector_principal_id" {
  description = "Managed identity principal ID used by Unity Catalog"
  value       = module.access_connector.principal_id
}

