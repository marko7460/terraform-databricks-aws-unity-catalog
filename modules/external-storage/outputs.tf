output "bucket" {
  description = "The name of the bucket"
  value       = var.create_bucket ? aws_s3_bucket.external[0].bucket : var.bucket
}