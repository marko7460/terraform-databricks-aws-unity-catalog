# Catalog
This module creates schema with grants.

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
| catalog\_name | Name of parent catalog. Change forces creation of a new resource. | `string` | n/a | yes |
| comment | Comment | `string` | `"This catalog is managed by terraform"` | no |
| force\_destroy | Delete catalog regardless of its contents | `bool` | `false` | no |
| grants | List of grants to create | <pre>list(object({<br>    principal  = string<br>    privileges = list(string)<br>  }))<br></pre> | `[]` | no |
| name | Name of Schema relative to parent catalog. Change forces creation of a new resource. | `string` | n/a | yes |
| owner | Username/groupname/sp application\_id of the catalog owner. | `string` | n/a | yes |
| properties | Extensible Catalog properties | `map(string)` | `{}` | no |
| storage\_root | Managed location of the catalog. | `string` | n/a | yes |

## Outputs

| Name       | Description |
|------------|-------------|
| schema     | The schema |
| schema\_id | The ID of the schema. |