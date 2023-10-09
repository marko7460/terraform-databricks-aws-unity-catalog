# Metastore
The metastore module creates databricks metastore for the workspace and unity catalog.

To use this module you have to define the following environment variables:
- `DATABRICKS_HOST`: The host of the databricks account. For example: `DATABRICKS_HOST=https://accounts.cloud.databricks.com`.
- `DATABRICKS_ACCOUNT_ID`: The databricks account ID.
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
| databricks\_account\_id | The Databricks account ID | `string` | n/a | yes |
| aws\_account\_id | The AWS account ID | `string` | n/a | yes |
| bucket | Name of the S3 bucket to store the metastore data | `string` | n/a | yes |
| create\_bucket | Whether to create the S3 bucket to store the metastore data. Set this to false if you have already created the bucket. | `bool` | `true` | no |
| metastore\_name | The name of the metastore | `string` | n/a | yes |
| prefix | Prefix for the S3 bucket to store the metastore data | `string` | `"metastore"` | no |
| region | The AWS region | `string` | n/a | yes |
| tags | Tags to apply to the resources created | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| metastore\_iam\_role\_arn | The ARN of the IAM role used to access the metastore. |
| metastore\_id | The ID of the metastore. |