# external-storage
This module creates external storage for Data Catalog.

To use this module you have to define the following environment variables:
- `DATABRICKS_HOST`: Workspace URL.
- `DATABRICKS_CLIENT_ID`: The databricks client ID of the service principle. See [here](https://docs.databricks.com/en/dev-tools/authentication-oauth.html) for more information.
- `DATABRICKS_CLIENT_SECRET`: The databricks client ID secret of the service principle. See [here](https://docs.databricks.com/en/dev-tools/authentication-oauth.html) for more information.

## Providers

| Name | Version |
|------|---------|
| aws | n/a |
| databricks | n/a |
| null | n/a |
| time | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| aws\_account\_id | AWS account ID | `string` | n/a | yes |
| bucket | S3 bucket name | `string` | n/a | yes |
| create\_bucket | Wheather to create a new bucket or use an existing one | `bool` | `true` | no |
| databricks\_account\_id | Databricks account ID | `string` | n/a | yes |
| external\_creds\_grants | List of grants to create for the external location | <pre>list(object({<br>    principal  = string<br>    privileges = list(string)<br>  }))<br></pre> | `[]` | no |
| external\_location\_grants | List of grants to create for the external location | <pre>list(object({<br>    principal  = string<br>    privileges = list(string)<br>  }))<br></pre> | `[]` | no |
| force\_destroy | Destroy external location regardless of its dependents | `bool` | `false` | no |
| owner | Username/groupname/sp application\_id of the external location owner. | `string` | n/a | yes |
| prefix | S3 bucket prefix | `string` | `""` | no |
| read\_only | Indicates whether the external location is read-only. | `bool` | `false` | no |
| skip\_validation | Skip Validation | `bool` | `true` | no |
| tags | Tags to apply to all resources | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| bucket | The name of the bucket |