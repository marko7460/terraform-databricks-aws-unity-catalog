# Catalog
This module creates catalog with grants.

To use this module you have to define the following environment variables:
- `DATABRICKS_HOST`: Workspace URL.
- `DATABRICKS_CLIENT_ID`: The databricks client ID of the service principle. See [here](https://docs.databricks.com/en/dev-tools/authentication-oauth.html) for more information.
- `DATABRICKS_CLIENT_SECRET`: The databricks client ID secret of the service principle. See [here](https://docs.databricks.com/en/dev-tools/authentication-oauth.html) for more information.

## Providers

| Name | Version |
|------|---------|
| databricks | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| comment | Comment | `string` | `"This catalog is managed by terraform"` | no |
| force\_destroy | Delete catalog regardless of its contents | `bool` | `false` | no |
| grants | List of grants to create | <pre>list(object({<br>    principal  = string<br>    privileges = list(string)<br>  }))<br></pre> | `[]` | no |
| isolation\_mode | Whether the catalog is accessible from all workspaces or a specific set of workspaces. Can be ISOLATED or OPEN. Setting the catalog to ISOLATED will automatically allow access from the current workspace. | `string` | `"ISOLATED"` | no |
| metastore\_id | Metastore ID | `string` | n/a | yes |
| name | Name of the metastore | `string` | n/a | yes |
| options | For Foreign Catalogs: the name of the entity from an external data source that maps to a catalog. For example, the database name in a PostgreSQL server. | `string` | n/a | yes |
| owner | Username/groupname/sp application\_id of the catalog owner. | `string` | n/a | yes |
| properties | Extensible Catalog properties | `map(string)` | `{}` | no |
| provider\_name | For Delta Sharing Catalogs: the name of the delta sharing provider. Change forces creation of a new resource. | `string` | n/a | yes |
| share\_name | For Delta Sharing Catalogs: the name of the share under the share provider. Change forces creation of a new resource | `string` | n/a | yes |
| storage\_root | Managed location of the catalog. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| catalog | The catalog |
| catalog\_id | The ID of the catalog. |
