resource "databricks_catalog" "this" {
  metastore_id   = var.metastore_id
  name           = var.name
  comment        = var.comment
  properties     = var.properties
  isolation_mode = var.isolation_mode
  force_destroy  = var.force_destroy
  provider_name  = var.provider_name
  owner          = var.owner
  share_name     = var.share_name
  storage_root   = var.storage_root
}

resource "databricks_grants" "metastore" {
  count   = length(var.grants) > 0 ? 1 : 0
  catalog = databricks_catalog.this.id
  dynamic "grant" {
    for_each = { for g in var.grants : g.principal => g }
    content {
      principal  = grant.value.principal
      privileges = grant.value.privileges
    }
  }
}

resource "databricks_catalog_workspace_binding" "this" {
  for_each     = toset(var.attach_workspace_ids)
  catalog_name = databricks_catalog.this.id
  workspace_id = each.value
}
