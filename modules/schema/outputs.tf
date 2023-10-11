output "catalog_id" {
  description = "The ID of the schema."
  value       = databricks_schema.this.id
}

output "catalog" {
  description = "The schema"
  value       = databricks_schema.this
}