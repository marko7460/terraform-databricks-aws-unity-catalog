resource "databricks_grants" "metastore" {
  count     = length(var.grants) > 0 ? 1 : 0
  metastore = var.metastore_id
  dynamic "grant" {
    for_each = { for g in var.grants : g.principal => g }
    content {
      principal  = grant.value.principal
      privileges = grant.value.privileges
    }
  }
}