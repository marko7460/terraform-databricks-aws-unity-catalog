variable "name" {
  description = "Name of the metastore"
  type        = string
}

variable "metastore_id" {
  description = "Metastore ID"
  type        = string
}

variable "storage_root" {
  description = "Managed location of the catalog."
  type        = string
  default     = null
}

variable "provider_name" {
  description = "For Delta Sharing Catalogs: the name of the delta sharing provider. Change forces creation of a new resource."
  type        = string
  default     = null
}

variable "share_name" {
  description = "For Delta Sharing Catalogs: the name of the share under the share provider. Change forces creation of a new resource"
  type        = string
  default     = null
}

#variable "connection_name" {
#  description = "For Foreign Catalogs: the name of the connection to an external data source. Changes forces creation of a new resource."
#  type        = string
#  default     = null
#}

variable "owner" {
  description = "Username/groupname/sp application_id of the catalog owner."
  type        = string
  default     = null
}

variable "isolation_mode" {
  description = "Whether the catalog is accessible from all workspaces or a specific set of workspaces. Can be ISOLATED or OPEN. Setting the catalog to ISOLATED will automatically allow access from the current workspace."
  type        = string
  default     = "ISOLATED"
}

variable "properties" {
  description = "Extensible Catalog properties"
  type        = map(string)
  default     = {}
}

variable "options" {
  description = "For Foreign Catalogs: the name of the entity from an external data source that maps to a catalog. For example, the database name in a PostgreSQL server."
  type        = string
  default     = null
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