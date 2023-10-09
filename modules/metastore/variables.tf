variable "databricks_account_id" {
  description = "The Databricks account ID"
  type        = string
}

variable "aws_account_id" {
  description = "The AWS account ID"
  type        = string
}

variable "region" {
  description = "The AWS region"
  type        = string
}

variable "metastore_name" {
  description = "The name of the metastore"
  type        = string
}

variable "bucket" {
  description = "Name of the S3 bucket to store the metastore data"
  type        = string
}

variable "create_bucket" {
  description = "Whether to create the S3 bucket to store the metastore data. Set this to false if you have already created the bucket."
  type        = bool
  default     = true
}

variable "prefix" {
  description = "Prefix for the S3 bucket to store the metastore data"
  type        = string
  default     = "metastore"
}

variable "tags" {
  description = "Tags to apply to the resources created"
  type        = map(string)
  default     = {}
}