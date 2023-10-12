variable "databricks_account_id" {
  description = "Databricks account ID"
  type        = string
}

variable "aws_account_id" {
  description = "AWS account ID"
  type        = string
}

variable "bucket" {
  description = "S3 bucket name"
  type        = string
}

variable "prefix" {
  description = "S3 bucket prefix"
  type        = string
  default     = ""
}

variable "owner" {
  description = "Username/groupname/sp application_id of the external location owner."
  type        = string
  default     = null
}

variable "skip_validation" {
  description = "Skip Validation"
  type        = bool
  default     = true
}

variable "read_only" {
  description = "Indicates whether the external location is read-only."
  type        = bool
  default     = false
}

variable "force_destroy" {
  description = "Destroy external location regardless of its dependents"
  type        = bool
  default     = false
}

variable "create_bucket" {
  description = "Wheather to create a new bucket or use an existing one"
  type        = bool
  default     = true
}

variable "external_location_grants" {
  description = "List of grants to create for the external location"
  type = list(object({
    principal  = string
    privileges = list(string)
  }))
  default = []
}

variable "external_creds_grants" {
  description = "List of grants to create for the external location"
  type = list(object({
    principal  = string
    privileges = list(string)
  }))
  default = []
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default     = {}
}