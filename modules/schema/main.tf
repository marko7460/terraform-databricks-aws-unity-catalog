resource "databricks_schema" "this" {
  name          = var.name
  comment       = var.comment
  properties    = var.properties
  force_destroy = var.force_destroy
  owner         = var.owner
  storage_root  = var.storage_root
  catalog_name  = var.catalog_name
}

resource "databricks_grants" "schema" {
  count  = length(var.grants) > 0 ? 1 : 0
  schema = databricks_schema.this.id
  dynamic "grant" {
    for_each = { for g in var.grants : g.principal => g }
    content {
      principal  = grant.value.principal
      privileges = grant.value.privileges
    }
  }
}