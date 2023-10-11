output "catalog_id" {
  description = "The ID of the catalog."
  value       = databricks_catalog.this.id
}

output "catalog" {
  description = "The catalog"
  value       = databricks_catalog.this
}