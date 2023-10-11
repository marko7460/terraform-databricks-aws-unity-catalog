variable "metastore_id" {
  description = "Metastore ID"
  type        = string
}

variable "grants" {
  description = "List of grants to create"
  type = list(object({
    principal  = string
    privileges = list(string)
  }))
  default = []
}