output "metastore_id" {
  description = "The ID of the metastore."
  value       = databricks_metastore.this.id
}

output "metastore_iam_role_arn" {
  description = "The ARN of the IAM role used to access the metastore."
  value       = databricks_metastore_data_access.this.aws_iam_role
}