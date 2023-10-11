variable "name" {
  description = "Name of Schema relative to parent catalog. Change forces creation of a new resource."
  type        = string
}

variable "catalog_name" {
  description = "Name of parent catalog. Change forces creation of a new resource."
  type        = string
}

variable "storage_root" {
  description = "Managed location of the catalog."
  type        = string
  default     = null
}

variable "owner" {
  description = "Username/groupname/sp application_id of the catalog owner."
  type        = string
  default     = null
}

variable "properties" {
  description = "Extensible Catalog properties"
  type        = map(string)
  default     = {}
}

variable "force_destroy" {
  description = "Delete catalog regardless of its contents"
  type        = bool
  default     = false
}

variable "comment" {
  description = "Comment"
  type        = string
  default     = "This catalog is managed by terraform"
}

variable "grants" {
  description = "List of grants to create"
  type = list(object({
    principal  = string
    privileges = list(string)
  }))
  default = []
}