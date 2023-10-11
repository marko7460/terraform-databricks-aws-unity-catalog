# Metastore Grants
This module creates grants on metastore.

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
| grants | List of grants to create | <pre>list(object({<br>    principal  = string<br>    privileges = list(string)<br>  }))<br></pre> | `[]` | no |
| metastore\_id | Metastore ID | `string` | n/a | yes |

## Outputs

No output.