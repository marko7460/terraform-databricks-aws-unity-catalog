output "schema_id" {
  description = "The ID of the schema."
  value       = databricks_schema.this.id
}

output "schema" {
  description = "The schema"
  value       = databricks_schema.this
}